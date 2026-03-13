#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="chazos"
iso_label="CHAZOS_LIVE"
iso_publisher="Chazos <https://github.com/cbailey/chazos>"
iso_application="Chazos Terminal-First Linux Distribution"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="chazos"
buildmodes=('iso')
bootmodes=('bios.syslinux'
           'uefi.systemd-boot')
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '3')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '3')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/passwd"]="0:0:644"
  ["/root/.zshrc"]="0:0:600"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.gnupg"]="0:0:700"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  ["/usr/local/bin/chazos-install"]="0:0:755"
  ["/usr/local/bin/chazos-welcome"]="0:0:755"
  ["/usr/local/bin/livecd-sound"]="0:0:755"
  ["/usr/local/bin/gui"]="0:0:755"
  ["/etc/profile.d/nvidia-wayland.sh"]="0:0:755"
)
