FROM fedora:34 as edk2_images

RUN dnf install -y edk2-aarch64

FROM openqa_worker

COPY --from=edk2_images /usr/share/edk2/aarch64/QEMU_EFI-pflash.raw /usr/share/edk2/aarch64/QEMU_EFI-pflash.raw
COPY --from=edk2_images /usr/share/edk2/aarch64/vars-template-pflash.raw /usr/share/edk2/aarch64/vars-template-pflash.raw

# Fix for leap:15.3
# - Installed qemu-hw-display-virtio-vga and qemu-hw-display-virtio-gpu to fix 'Virtio VGA not available'
# - Installed qemu-hw-display-virtio-gpu-pci to fix 'virtio-gpu-pci' is not a valid device model name
RUN zypper -n install qemu-hw-display-virtio-vga qemu-hw-display-virtio-gpu qemu-hw-display-virtio-gpu-pci  || true # Not needed or available for leap:15.2 or ealier

# Install packages needed to test os-autoinst-distri-rocky
RUN zypper -n install make cpanm perl-JSON
RUN cpanm install REST::Client
