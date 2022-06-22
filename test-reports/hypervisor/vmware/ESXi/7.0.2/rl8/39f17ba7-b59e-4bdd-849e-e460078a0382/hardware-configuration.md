# ESXi 7.0U2 (version 19)

## Tested configuration

### CPU

- Sockets: 1
- CPU hot plug: disabled
- Hardware virtualization: disabled
- I/O MMU: disabled

### Memory

- Memory hot plug: disabled

### Storage

- SCSI controller: VMware Paravirtual

### Networking

- Network adapter: VMXNET3 (drv vmxnet3)

### Boot options

- Firmware: BIOS
- Secure Boot: disabled

## Similar tested configurations

### Storage

- SCSI controller: LSI Logic SAS (adds Taint-check 27 BIT_BY_ZOMBIE)
- SCSI controller: LSI Logic Parallel (adds Taint-check 27 BIT_BY_ZOMBIE)
- NVMe controller (empty Whole Disks from /proc/partitions)
