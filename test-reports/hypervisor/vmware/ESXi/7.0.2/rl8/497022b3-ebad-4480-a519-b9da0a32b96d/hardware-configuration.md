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

- Firmware: EFI
- Secure Boot: disabled

## Similar tested configurations

### CPU

- Sockets: 2
- Sockets: 4
- CPU hot plug: enabled
- I/O MMU: enabled

### Memory

- Memory hot plug: enabled

### Storage

- SCSI controller: LSI Logic SAS (adds Taint-check 27 BIT_BY_ZOMBIE)
- SCSI controller: LSI Logic Parallel (adds Taint-check 27 BIT_BY_ZOMBIE)
- SATA controller
- NVMe controller (empty Whole Disks from /proc/partitions)

### Networking

- Network adapter: E1000e (drv e1000e)
- Network adapter: PVRDMA (drv vmxnet3)
