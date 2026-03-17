#!/bin/bash
# Integration test runner for Chazos ISO

ISO_FILE=$(find out/ -maxdepth 1 -name "*.iso" -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" ")
if [ -z "$ISO_FILE" ]; then
    echo "Error: No ISO found in out/ directory."
    exit 1
fi

echo "Starting HTTP server for verification script..."
# Use Python's simple HTTP server in background
(
    cd tests || exit
    python3 -m http.server 8080
) &
HTTP_PID=$!

# Function to cleanup HTTP server
cleanup() {
    echo "Cleaning up..."
    kill $HTTP_PID 2>/dev/null
    rm -f serial-test.log
}
trap cleanup EXIT

echo "Launching $ISO_FILE in QEMU (headless mode)..."
# We need to pass the script parameter via kernel command line.
# For UEFI boot, it's often more complex to inject parameters via CLI.
# However, we can use the -append flag if we're not using UEFI (but we are).
# Let's try to pass it via -fw_cfg or similar if possible.

# Actually, the easiest way is to use QEMU's -kernel and -initrd flags 
# for testing if we just want to verify the system state.
# But since we want to test the full ISO boot, we'll try to use a serial console 
# and maybe just wait for the output in the log.

# Let's use a timeout for the test.
TIMEOUT=300 # 5 minutes

# Run QEMU with a serial port redirected to a file.
# We also use -display none to run headless in CI/automation.
qemu-system-x86_64 \
    -enable-kvm \
    -m 4096 \
    -smp 4 \
    -drive file="$ISO_FILE",media=cdrom,readonly=on \
    -display none \
    -vga virtio \
    -cpu host \
    -serial file:serial-test.log \
    -device virtio-net-pci,netdev=net0 \
    -netdev user,id=net0 \
    -drive if=pflash,format=raw,unit=0,file=/usr/share/edk2/x64/OVMF_CODE.4m.fd,read-only=on \
    -drive if=pflash,format=raw,unit=1,file=/usr/share/edk2/x64/OVMF_VARS.4m.fd,read-only=on &
QEMU_PID=$!

echo "Waiting for test results in serial-test.log (timeout ${TIMEOUT}s)..."
START_TIME=$(date +%s)
while true; do
    if grep -q "\[CHAZOS-TEST\] SUCCESS" serial-test.log 2>/dev/null; then
        echo "Integration test PASSED!"
        kill $QEMU_PID 2>/dev/null
        exit 0
    fi
    if grep -q "\[CHAZOS-TEST\] FAIL" serial-test.log 2>/dev/null; then
        echo "Integration test FAILED!"
        cat serial-test.log
        kill $QEMU_PID 2>/dev/null
        exit 1
    fi
    
    CURRENT_TIME=$(date +%s)
    if [ $((CURRENT_TIME - START_TIME)) -gt $TIMEOUT ]; then
        echo "Integration test TIMED OUT!"
        # Show last few lines of log
        tail -n 20 serial-test.log 2>/dev/null
        kill $QEMU_PID 2>/dev/null
        exit 1
    fi
    sleep 5
done
