# Rocky Linux Testing Team Test Reports

## Requirements

The script included in this repository require the use of `xsos`.

```bash
xsos - https://github.com/ryran/xsos
```

*`xsos` is [discussed](https://access.redhat.com/discussions/469323) on an upstream vendor's website.*

## Installing `xsos`

Follow the guide...

```bash
curl -Lo ./xsos bit.ly/xsos-direct
chmod +x ./xsos
dnf install -y pciutils # Needed for lspci
```

## Using `xsos`

```bash
sudo ./xsos -x --bios --os --cpu --disks --ethtool --lspci --mem --mpath | \
    tee "${HOME}/$(sudo dmidecode -t 1 | awk '/UUID:/ {print $2}').xsos.out"
cat *.xsos.out
```

### Scrubbing Private Information

`xsos` will let you scrub information from the report which is probably a good idea. If you wish to scrub everything automatically before uploading using the following comand instead. This will generate a random UUID instead of using your system UUID.

```bash
sudo ./xsos -x --bios --os --cpu --disks --ethtool --lspci --mem --mpath --scrub | \
    tee "${HOME}/$(uuidgen).xsos.out"
cat *.xsos.out
```

The above will generate a unique identifier that is not tied to your system instead of using the one generate by the kernel for your machine. If you do this be sure to keep track yourself of which machine is which in your testing if you test multiple systems. To that end you may which to manually scrub / sanitize the output of `xsos`.

### Containers

See the [README.md](./container/README.md) in the containers sub-directory.

## Report Contents

The report generated will likely have more information than is needed but it isn't as much as generated by `dmidecode` + `lspci` and `sosreport` combined acting as a summarizing tool for all of those (if available).

Here is a sample...

```
DMIDECODE
  BIOS:
    Vend: innotek GmbH
    Vers: VirtualBox
    Date: 12/01/2006
    BIOS Rev:
    FW Rev:
  System:
    Mfr:  innotek GmbH
    Prod: VirtualBox
    Vers: 1.2
    Ser:  ⣿
    UUID: ⣿⣿⣿⣿⣿⣿⣿⣿-⣿⣿⣿⣿-⣿⣿⣿⣿-⣿⣿⣿⣿-⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
  CPU:
    0 of 0 CPU sockets populated, 0 cores/0 threads per CPU
    0 total cores, 0 total threads
    Mfr:
    Fam:
    Freq:
    Vers:
  Memory:
    Total: 0 MiB (0 GiB)
    DIMMs: 0 of 0 populated
    MaxCapacity: 0 MiB (0 GiB / 0.00 TiB)

OS
  Hostname: SCRUBBED
  Distro:   [redhat-release] Rocky Linux release 8.3
            [rocky-release] Rocky Linux release 8.3
            [os-release] Rocky Linux 8.3 8.3
  RHN:      (missing)
  RHSM:     (missing)
  YUM:      1 enabled plugins: debuginfo-install
  Runlevel: N 3  (default multi-user)
  SELinux:  enforcing  (default enforcing)
  Arch:     mach=x86_64  cpu=x86_64  platform=x86_64
  Kernel:
    Booted kernel:  4.18.0-240.22.1.el8.x86_64
    GRUB default:
    Build version:
      Linux version 4.18.0-240.22.1.el8.x86_64 (mockbuild@7dfc074d1e13452e94271ec95cb31ed9) (gcc version 8.3.1 20191121 (Red
      Hat 8.3.1-5) (GCC)) #1 SMP Mon Apr 12 04:29:16 UTC 2021
    Booted kernel cmdline:

    GRUB default kernel cmdline:

    Taint-check: 134217728  (see https://access.redhat.com/solutions/40594)
      27  BIT_BY_ZOMBIE: Kernel booted with OMGZOMBIES param
    - - - - - - - - - - - - - - - - - - -
  Sys time:  Thu May  6 21:00:44 PDT 2021
  Boot time: Wed May  5 23:23:07 PDT 2021  (epoch: 1620282187)
  Time Zone: America/Los_Angeles
  Uptime:    21:37,  1 user
  LoadAvg:   [2 CPU] 0.00 (0%), 0.00 (0%), 0.02 (1%)
  /proc/stat:
    procs_running: 1   procs_blocked: 0    processes [Since boot]: 97890
    cpu [Utilization since boot]:
      us 1%, ni 0%, sys 0%, idle 98%, iowait 0%, irq 0%, sftirq 0%, steal 0%

CPU
  2 logical processors (2 CPU cores)
  1 Intel Core i9-9900K CPU @ 3.60GHz (flags: aes,constant_tsc,ht,lm,nx,pae,rdrand)
  └─2 threads / 2 cores each

MEMORY
  Stats graphed as percent of MemTotal:
    MemUsed    ▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊.......  85.4%
    Buffers    ..................................................   0.0%
    Cached     ▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊▊...................  61.9%
    HugePages  ..................................................   0.0%
    Dirty      ..................................................   0.0%
  RAM:
    0.8 GiB total ram
    0.7 GiB (85%) used
    0.2 GiB (23%) used excluding Buffers/Cached
    0 GiB (0%) dirty
  HugePages:
    No ram pre-allocated to HugePages
  THP:
    4096 kB allocated to THP
  LowMem/Slab/PageTables/Shmem:
    0.11 GiB (13%) of total ram used for Slab
    0.01 GiB (1%) of total ram used for PageTables
    0 GiB (0%) of total ram used for Shmem
  Swap:
    0.1 GiB (8%) used of 0.8 GiB total

STORAGE
  Whole Disks from /proc/partitions:
    1 disks, totaling 8 GiB (0.01 TiB)
    - - - - - - - - - - - - - - - - - - - - -
    Disk 	Size in GiB
    ----	-----------
    sda 	8

  Disk layout from lsblk:
    NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
    sda           8:0    0    8G  0 disk
    ├─sda1        8:1    0    1G  0 part /boot
    └─sda2        8:2    0    7G  0 part
      ├─rl-root 253:0    0  6.2G  0 lvm  /
      └─rl-swap 253:1    0  820M  0 lvm  [SWAP]
    sr0          11:0    1 1024M  0 rom

  Filesystem usage from df:
    Filesystem          1K-blocks    Used Available Use% Mounted on
    /dev/mapper/rl-root   6486016 4401624   2084392  68% /
    /dev/sda1             1038336  197104    841232  19% /boot

ETHTOOL
  Interface Status:
    enp0s3  0000:00:03.0  link=up 1000Mb/s full (autoneg=Y)  rx ring 256/4096  drv e1000 v7.3.21-k8-NAPI / fw UNKNOWN
  Interface Errors:
    [None]
```

*NOTE: The above output if for a vm running in VirtualBox which explains why multipath and lspci outputs are not available.*

## Reporting

Find the proper location in the filesystem hierarchy being used to organize reports and add a directory to the tree. You may need to add your vendor and likely will need to add a directory for your model.

Please replace `space` characters in all vendor and model names with `underscore` characters as you will see in the samples already uploaded.

The final directory in the hierarchy should be unique. You can use the `UUID` of your system or you can generate your own `UUID` with `uuidgen`. Both methods are shown below.

## Hierarchy

The reports for different targets are stored in a filesystem hierarchy to allow reports for specific configuration be quickly found. The prefered format is Resource -> Vendor -> Model/Version -> Rocky major version -> UUID. This format allows for the easiest sorting and lookup of information, though sub-categories are allowed.

* Resource is one of four: cloud, container, hardware, hypervisor.
* Vendor is the primary company (eg: Supermicro, Naver cloud, etc.) For homebuilt systems, please use the motherboard vendor as the base, and the model and revision as the model.
* Model is the best description of the model. Some make this easy, others may need to specify model with the generation. (for container and hypervisor there might not be a model but instead a version, use the major/minor version which is feature stable)
* Rocky major version: rl8 or rl9
* If you are submitting multiple information files, please included them in a sub-folder that matches the systems UUID. If it is a single file, then no sub-directory is sufficent.
