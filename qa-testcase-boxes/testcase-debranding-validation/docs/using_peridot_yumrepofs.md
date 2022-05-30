# Using Peridot yumrepofs

Prior to release of Rocky Linux 9 packages built by Peridot are available in a flat repository using the `dnf` tool.

The `peridot_repo_query.sh` script can be used to query this repository for contents and to dowload packages for various testing activities.


## Basic Examples

### Single package query - rocky-release

```
[vagrant@localhost vagrant]$ ./scripts/peridot_repo_query.sh rocky-release
# dnf --forcearch=x86_64 --repofrompath=pdot-x86_64,https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64 --repo=pdot-x86_64 search '' rocky-release
Added pdot-x86_64 repo from https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64
Last metadata expiration check: 0:09:49 ago on Mon 30 May 2022 12:28:15 AM UTC.
============================= Name & Summary Matched: , rocky-release ==============================
rocky-release.noarch : Rocky Linux release files
# set +x
```

### Single package info query - rocky-release

```
[vagrant@localhost vagrant]$ DNF_COMMAND=info ./scripts/peridot_repo_query.sh rocky-release
# dnf --forcearch=x86_64 --repofrompath=pdot-x86_64,https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64 --repo=pdot-x86_64 info '' rocky-release
Added pdot-x86_64 repo from https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64
Last metadata expiration check: 0:11:14 ago on Mon 30 May 2022 12:28:15 AM UTC.

Installed Packages
Name         : rocky-release
Version      : 8.6
Release      : 3.el8
Architecture : noarch
Size         : 18 k
Source       : rocky-release-8.6-3.el8.src.rpm
Repository   : @System
From repo    : baseos
Summary      : Rocky Linux release files
URL          : https://rockylinux.org
License      : BSD-3-Clause
Description  : Rocky Linux release files.

Available Packages
Name         : rocky-release
Version      : 9.0
Release      : 1.17.el9
Architecture : noarch
Size         : 21 k
Source       : rocky-release-9.0-1.17.el9.src.rpm
Repository   : pdot-x86_64
Summary      : Rocky Linux release files
URL          : https://rockylinux.org
License      : BSD-3-Clause
Description  : Rocky Linux release files.

# set +x
```


### Single package download URL - rocky-release

```
[vagrant@localhost vagrant]$ DNF_COMMAND="download" DNF_COMMAND_ARGS="--urls" ./scripts/peridot_repo_query.sh rocky-release
# dnf --forcearch=x86_64 --repofrompath=pdot-x86_64,https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64 --repo=pdot-x86_64 download --urls rocky-release
Added pdot-x86_64 repo from https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64
Last metadata expiration check: 0:23:27 ago on Mon 30 May 2022 12:28:15 AM UTC.

https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64/Packages/d10ded29-9641-4d04-aca3-b4425ec77191/702d426d350d275d/rocky-release-9.0-1.17.el9.noarch.rpm
# set +x
```


## Advanced Examples

The `peridot_repo_query.sh` script is designed to satisfy very simple testing requirements such as checking Peridot for specific package, checking package version and downloading packages from Peridot yumrepofs. More complex dnf commands are possible but not likely using `peridot_repo_query.sh`. One feature of `peridot_repo_query.sh` is that it prints the command used to query the Peridot yumrepofs repository. That command can be manually modified for more advanced examples.

### Package dependency list - sos

```
[vagrant@localhost vagrant]$ dnf --forcearch=x86_64 --repofrompath=pdot-x86_64,https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64 --repo=pdot-x86_64 repoquery --deplist sos
Added pdot-x86_64 repo from https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64
Last metadata expiration check: 0:27:43 ago on Mon 30 May 2022 12:28:15 AM UTC.

package: sos-4.2-15.el9.noarch
  dependency: /usr/bin/python3
   provider: python3-3.9.10-2.el9.x86_64
  dependency: bzip2
   provider: bzip2-1.0.8-8.el9.x86_64
  dependency: libxml2-python3
   provider: python3-libxml2-2.9.13-1.el9.x86_64
  dependency: python(abi) = 3.9
   provider: python3-3.9.10-2.el9.x86_64
  dependency: tar
   provider: tar-2:1.34-3.el9.x86_64
  dependency: xz
   provider: xz-5.2.5-7.el9.x86_64
```
