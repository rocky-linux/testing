# testcase-mediacheck

This box will...

-   Download Rocky Linux ISOs, CHECKSUM files and official GPG Public Key
-   Verify all ISO checksums
-   Verify internal ISO md5 checksums
-   Where applicable (minimal and dvd1 ISO)...
  -   Mount ISOs locally as loopback filesystems to /media
  -   Run `dnf repoclosure` on the included repositories
  -   Analyze packages in included repositories for conflicts
  -   Unmount ISOs from /media
- Generate output logs


## Requirements

The machine used for testing must...

- have the following RPM packages installed (in EL8), `coreutils`, `curl`, `dnf`, `isomd5sum`, `python3`, `rpm` and `util-linux`
- have available disk space in the test directory to hold the ISO(s) to be tested.
- have a connection to the Internet and/or access to pre-downloaded ISOs


## Quick Start

The basic Vagrant sequence is simply (redacted content)...

```
[rocky@localhost ~]$ vagrant status
Current machine states:

default                   not created (virtualbox)

The environment has not yet been created. Run `vagrant up` to
create the environment. If a machine is not created, only the
default provider will be shown. So if a provider is not listed,
then the machine is not created for that environment.
```

```
[rocky@localhost ~]$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'rockylinux/8'...
==> default: Matching MAC address for NAT networking...
==> default: Setting the name of the VM: testcase-mediacheck_default_1653246056648_618
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...

...

==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
==> default: Mounting shared folders...
    default: /vagrant => /home/rocky/testing/qa-testcase-boxes/testcase-mediacheck

==> default: Running provisioner: Start Timestamp (shell)...
    default: Running: script: Start Timestamp
    default: Starting QA:Testcase-Mediacheck on Sun May 22 19:01:16 UTC 2022
==> default: Running provisioner: Install requirements (shell)...
    default: Running: script: Install requirements

...

==> default: Running provisioner: Rocky 8.6 x86_64 boot ISO (shell)...
    default: Running: script: Rocky 8.6 x86_64 boot ISO
default: mkdir: created directory '/home/rocky/testing/output/2022-05-22'
default:
default: ================================================================================
default: Derived URLs...
default:
default: iso_url:              http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-boot.iso
default: iso_checksum_url:     http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM
default: iso_checksum_sig_url: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM.sig
default: iso_key_url:          https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-rockyofficial
default:

...

==> default: Running provisioner: Rocky 8.6 x86_64 minimal ISO (shell)...
default: Running: script: Rocky 8.6 x86_64 minimal ISO
default:
default: ================================================================================
default: Derived URLs...
default:
default: iso_url:              http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-minimal.iso
default: iso_checksum_url:     http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM
default: iso_checksum_sig_url: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM.sig
default: iso_key_url:          https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-rockyofficial
default:

...

==> default: Running provisioner: Rocky 8.6 x86_64 dvd1 ISO (shell)...
default: Running: script: Rocky 8.6 x86_64 dvd1 ISO
default:
default: ================================================================================
default: Derived URLs...
default:
default: iso_url:              http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.6-x86_64-dvd1.iso
default: iso_checksum_url:     http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM
default: iso_checksum_sig_url: http://dl.rockylinux.org/pub/rocky/8/isos/x86_64/CHECKSUM.sig
default: iso_key_url:          https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-rockyofficial
default:

...

default:
==> default: Running provisioner: End Timestamp (shell)...
default: Running: script: End Timestamp
default: Finished QA:Testcase-Mediacheck on Sun May 22 19:39:40 UTC 2022
```

**_NOTE: From this summary you can download testing without box clone, start and requirements install is ~40 mins._**


```
[rocky@localhost ~]$ vagrant halt
==> default: Attempting graceful shutdown of VM...
```


## Examples

Vagrant and non-Vagrant examples of usage are show in the following locations in this repository...

- [Default Vagrant](examples/default_vagrant.md)
- [Alternate Arch Vagrant](examples/alternate_arch_vagrant.md)
- [Standalone System](examples/standalone_system.md)
- [Standalone ISOs from Rocky Linux Vault](examples/standalone_vault.md)
