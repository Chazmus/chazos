#!/bin/bash
export PATH="$(pwd)/bin:$PATH"
ISO_FILE=$(ls -t out/*.iso 2>/dev/null | head -n 1)
if [ -z "$ISO_FILE" ]; then
    echo "Error: No ISO found in out/ directory."
    exit 1
fi
echo "Launching $ISO_FILE in QEMU (logs to serial-boot.log)..."
# Use direct QEMU call for better control over memory and keyboard grabbing
# -display gtk,grab-on-hover=on is helpful for Sway/Wayland testing
# -m 4G is usually minimum for building yay packages in RAM
qemu-system-x86_64 \
    -enable-kvm \
    -m ${QEMU_RAM:-4096} \
    -smp 4 \
    -drive file="$ISO_FILE",media=cdrom,readonly=on \
    -display gtk,grab-on-hover=on \
    -vga virtio \
    -cpu host \
    -serial stdio \
    -device virtio-net-pci,netdev=net0 \
    -netdev user,id=net0,hostfwd=tcp::60022-:22 \
    -drive if=pflash,format=raw,unit=0,file=/usr/share/edk2/x64/OVMF_CODE.4m.fd,read-only=on \
    -drive if=pflash,format=raw,unit=1,file=/usr/share/edk2/x64/OVMF_VARS.4m.fd,read-only=on
