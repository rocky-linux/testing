# testcase-debrand-validation

This box will...

-   Validate package debranding as described in QA:Testcase Debranding Validation
-   Optionally use cached rpms, previously downloaded Rocky Linux ISOs or published Rocky Linux repositories for debranding analysis.
-   Produce output than can be parsed into summary reports

## Requirements

The machine used for testing must...

- have the following RPM packages installed (in EL8), `coreutils`, `curl`, `dnf`, `isomd5sum`, `jq`, `koji`, `python3`, `rpm`, `util-linux` and `yq`.
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
==> default: Setting the name of the VM: testcase-debranding-validation_default_1653577650369_30157
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
    default:
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default:
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
==> default: Mounting shared folders...
    default: /vagrant => /home/rocky/testing/qa-testcase-boxes/testcase-debranding-validation
==> default: Running provisioner: Start Timestamp (shell)...
    default: Running: script: Start Timestamp
    default: Starting QA:Testcase-Debranding on Thu May 26 15:07:49 UTC 2022
==> default: Running provisioner: Install requirements (shell)...

    ...<snip>...

==> default: Running provisioner: file...
    default: etc/koji.conf => /tmp/koji.conf
==> default: Running provisioner: Deploy koji.conf (shell)...
    default: Running: script: Deploy koji.conf
==> default: Running provisioner: Prepare testing directories (shell)...
    default: Running: script: Prepare testing directories
==> default: Running provisioner: Rocky 8.6  Debrand Validation (shell)...
    default: Running: script: Rocky 8.6  Debrand Validation
    default: mkdir: created directory '/home/rocky/testing/output/2022-05-26'
    default:
    default: ================================================================================
    default: Package Debrand Validation for x86_64 packages in Rocky-8.6-x86_64-dvd1.iso
    default:
    default: ================================================================================
    default: General Processing Parameters
    default:
    default:              type: dvd1
    default:           version: 8.6
    default:              arch: x86_64
    default:
    default: ================================================================================
    default: PackageKit
    default:
    default:
    default:        binary_pkg: PackageKit-1.1.12-6.el8.0.2.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:
    default: ================================================================================
    default: WALinuxAgent
    default:
    default:
    default:        binary_pkg: WALinuxAgent-2.3.0.2-2.el8.rocky.0.noarch.rpm
    default:
    default: SUCCESS: FileContents found pattern.
    default:

    ...<snip>...

    default: ================================================================================
    default: systemd
    default:
    default: WARN: dvd1 media does not contain SRPMs, use koji or cache
    default:
    default: ================================================================================
    default: thunderbird
    default:
    default:
    default:        binary_pkg: thunderbird-91.9.0-3.el8_5.x86_64.rpm
    default:
    default: SUCCESS: FileContents found pattern.
==> default: Running provisioner: End Timestamp (shell)...
    default: Running: script: End Timestamp
    default: Finished QA:Testcase-Debranding on Thu May 26 15:08:37 UTC 2022
```


```
[rocky@localhost ~]$ vagrant halt
==> default: Attempting graceful shutdown of VM...
```


## Examples

Vagrant and non-Vagrant examples of usage are show in the following locations in this repository...

- [Default Vagrant](examples/default_vagrant.md)
- [Standalone System](examples/standalone_system.md)
- [Standalone Koji](examples/standalone_koji.md)
- [Standalone Cache](examples/standalone_cache.md)
