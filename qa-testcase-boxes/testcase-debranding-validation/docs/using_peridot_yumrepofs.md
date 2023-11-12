# Using Peridot yumrepofs

Prior to release of Rocky Linux 9 packages built by Peridot are available in a flat repository using the `dnf` tool.

The `peridot_repo_query.sh` script can be used to query this repository for contents and to dowload packages for various testing activities.


## Basic Examples

### Single package query - rocky-release

```
[vagrant@localhost vagrant]$ ./scripts/peridot_repo_query.sh rocky-release
# dnf --forcearch=x86_64 --repofrompath=pdot-x86_64,https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64 --repo=pdot-x86_64 search rocky-release
Added pdot-x86_64 repo from https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64
Last metadata expiration check: 8:26:45 ago on Mon 30 May 2022 06:09:08 PM UTC.

============================================== Name Exactly Matched: rocky-release ==============================================
rocky-release.noarch : Rocky Linux release files
# set +x
```

### Single package info query - rocky-release

```
[vagrant@localhost vagrant]$ ./scripts/peridot_repo_query.sh -c info rocky-release
# dnf --forcearch=x86_64 --repofrompath=pdot-x86_64,https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64 --repo=pdot-x86_64 info rocky-release
Added pdot-x86_64 repo from https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64
Last metadata expiration check: 8:27:21 ago on Mon 30 May 2022 06:09:08 PM UTC.
Modular dependency problems:

 Problem 1: conflicting requests
  - nothing provides module(platform:el8) needed by module perl:5.26:8050020211109115414:b4937e53.x86_64
 Problem 2: conflicting requests
  - nothing provides module(platform:el8) needed by module perl-IO-Socket-SSL:2.066:8060020220513050719:bc93984d.x86_64
 Problem 3: conflicting requests
  - nothing provides module(platform:el8) needed by module perl-libwww-perl:6.34:8060020220513153220:9168a43d.x86_64
 Problem 4: conflicting requests
  - nothing provides module(platform:el8) needed by module python36:3.6:8050020211109130820:982725ab.x86_64
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


### Single package download - rocky-release

```
[vagrant@localhost vagrant]$ ./scripts/peridot_repo_query.sh -c download rocky-release
# dnf --forcearch=x86_64 --repofrompath=pdot-x86_64,https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64 --repo=pdot-x86_64 download rocky-release
Added pdot-x86_64 repo from https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/x86_64
Last metadata expiration check: 8:27:53 ago on Mon 30 May 2022 06:09:08 PM UTC.

rocky-release-9.0-1.17.el9.noarch.rpm                                                             17 kB/s |  21 kB     00:01
# set +x
```

### Single source package download - rocky-release

```
[vagrant@localhost vagrant]$ ./scripts/peridot_repo_query.sh -c download -s rocky-release
# dnf --repofrompath=pdot-x86_64,https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/src --repo=pdot-x86_64 download --source rocky-release
Added pdot-x86_64 repo from https://yumrepofs.build.resf.org/v1/projects/55b17281-bc54-4929-8aca-a8a11d628738/repo/all/src
Last metadata expiration check: 5:07:23 ago on Mon 30 May 2022 09:30:32 PM UTC.
rocky-release-9.0-1.17.el9.src.rpm                                                                44 kB/s |  33 kB     00:00
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
