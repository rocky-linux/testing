# rpminspect examination


## Resources:

*   rpminspect : <https://github.com/rpminspect/rpminspect>
*   rpminspect-data-fedora : <https://github.com/rpminspect/rpminspect-data-fedora>


## Installation:

The following packages were installed from EPEL with dependencies provided from EPEL, BaseOS, PowerTools and AppStream...

```
$ dnf -y install rpminspect rpminspect-data-generic rpminspect-data-fedora
```


## Customization:

I customized the default Fedora vendor data to produce a partially updated VENDOR file that would not trigger failures that would otherwise be expected. That file is included as `rocky.yaml`.

In addition, the Rocky Koji server addresses were added so direct pull/test of Koji builds / products was made possible. The values used are in the `rocky.yaml` file.

_NOTE: There is substantial room for more customization of this file._

The Fedora licenses file in `/usr/share/rpminspect/licenses/fedora.json` was duplicated as `/usr/share/rpminspect/licenses/rocky.json`. This file should be modified if necessary to include any additional/alternate licenses that can be expected in Rocky packages.


## Koji Single Package Check

Configuration of `rocky.yaml` with Rocky Linux Koji server address allowed direct testing capability of single packages without the need to build locally.

```
$ rpminspect -v -c /home/vagrant/rpminspect/rocky.yaml -E virus,javabytecode \
  --output=rocky-release-8.3-8.el8.txt rocky-release-8.3-8.el8
Downloading https://koji.rockylinux.org/kojifiles/packages/rocky-release/8.3/8.el8/noarch/rocky-gpg-keys-8.3-8.el8.noarch.rpm...
Downloading https://koji.rockylinux.org/kojifiles/packages/rocky-release/8.3/8.el8/noarch/rocky-repos-8.3-8.el8.noarch.rpm...
Downloading https://koji.rockylinux.org/kojifiles/packages/rocky-release/8.3/8.el8/noarch/rocky-release-8.3-8.el8.noarch.rpm...
Downloading https://koji.rockylinux.org/kojifiles/packages/rocky-release/8.3/8.el8/src/rocky-release-8.3-8.el8.src.rpm...
Running license inspection...        pass
Running emptyrpm inspection...       pass
Running metadata inspection...       pass
Running manpage inspection...        pass
Running xml inspection...            pass
Running elf inspection...            pass
Running desktop inspection...        pass
Running disttag inspection...        pass
Running specname inspection...       pass
Running modularity inspection...     pass
Running ownership inspection...      pass
Running shellsyntax inspection...    pass
Running annocheck inspection...      pass
Running permissions inspection...    pass
Running capabilities inspection...   pass
Running pathmigration inspection...  pass
Running lto inspection...            pass
Running symlinks inspection...       pass
Running files inspection...          pass
Running patches inspection...        pass
Running politics inspection...       pass
Running badfuncs inspection...       pass
Running runpath inspection...        pass
```

Full output is included in...

`./rocky-release-8.3-8.el8.txt`


## Koji Before / After Comparison

Configuration of `rocky.yaml` with Rocky Linux Koji server address allowed direct comparison of two versions of builds for a package resident in Koji. This type of test precludes

```
$ rpminspect -v -c /home/vagrant/rpminspect/rocky.yaml -E virus,javabytecode --output=rocky-release-8.3-7.el8.vs.rocky-release-8.3-7.el8.txt rocky-release-8.3-7.el8 rocky-release-8.3-8.el8
Downloading https://koji.rockylinux.org/kojifiles/packages/rocky-release/8.3/8.el8/noarch/rocky-gpg-keys-8.3-8.el8.noarch.rpm...
Downloading https://koji.rockylinux.org/kojifiles/packages/rocky-release/8.3/8.el8/noarch/rocky-repos-8.3-8.el8.noarch.rpm...
Downloading https://koji.rockylinux.org/kojifiles/packages/rocky-release/8.3/8.el8/noarch/rocky-release-8.3-8.el8.noarch.rpm...
Downloading https://koji.rockylinux.org/kojifiles/packages/rocky-release/8.3/8.el8/src/rocky-release-8.3-8.el8.src.rpm...
Downloading https://koji.rockylinux.org/kojifiles/packages/rocky-release/8.3/7.el8/noarch/rocky-gpg-keys-8.3-7.el8.noarch.rpm...
Downloading https://koji.rockylinux.org/kojifiles/packages/rocky-release/8.3/7.el8/noarch/rocky-repos-8.3-7.el8.noarch.rpm...
Downloading https://koji.rockylinux.org/kojifiles/packages/rocky-release/8.3/7.el8/noarch/rocky-release-8.3-7.el8.noarch.rpm...
Downloading https://koji.rockylinux.org/kojifiles/packages/rocky-release/8.3/7.el8/src/rocky-release-8.3-7.el8.src.rpm...
Running license inspection...        pass
Running emptyrpm inspection...       pass
Running lostpayload inspection...    pass
Running metadata inspection...       pass
Running manpage inspection...        pass
Running xml inspection...            pass
Running elf inspection...            pass
Running desktop inspection...        pass
Running disttag inspection...        pass
Running specname inspection...       pass
Running modularity inspection...     pass
Running changedfiles inspection...   FAIL
Running movedfiles inspection...     pass
Running removedfiles inspection...   pass
Running addedfiles inspection...     pass
Running upstream inspection...       FAIL
Running ownership inspection...      pass
Running shellsyntax inspection...    pass
Running annocheck inspection...      pass
Running dsodeps inspection...        pass
Running filesize inspection...       pass
Running permissions inspection...    pass
Running capabilities inspection...   pass
Running kmod inspection...           pass
Running arch inspection...           pass
Running subpackages inspection...    pass
Running changelog inspection...      pass
Running pathmigration inspection...  pass
Running lto inspection...            pass
Running symlinks inspection...       pass
Running files inspection...          pass
Running types inspection...          pass
Running abidiff inspection...        pass
Running kmidiff inspection...        pass
Running config inspection...         FAIL
Running doc inspection...            pass
Running patches inspection...        pass
Running politics inspection...       pass
Running badfuncs inspection...       pass
Running runpath inspection...        pass
```

Full output is included in...

`./rocky-release-8.3-7.el8.vs.rocky-release-8.3-7.el8.txt`


## Local Package Before / After Comparison

Greg suggested comparing packages from different Module Streams to check for ABI incompatibility and indeed this proved valuable as a mechanism to find an obvious ABI failure.

It proved faster as a proof of concept to use DNF to pull packages from different streams to the local system and compare them there. Not as easy as hitting Koji directly but I couldn't figure out where the packages would even be located in Rocky Linux Koji if they were there at all.

I arbitrarily selected packages from the container-tools stream for testing and didn't have to look long to find an  `abidiff` FAIL.


### Inspect container-tools modules

```
$ dnf module list container-tools
Last metadata expiration check: 1:26:07 ago on Fri 23 Apr 2021 04:46:02 AM UTC.
CentOS Linux 8 - AppStream
Name            Stream    Profiles Summary
container-tools rhel8 [d] common [ Most recent (rolling) versions of podman, buildah, skopeo, runc, conmon, runc, conmon
                          d]       , CRIU, Udica, etc as well as dependencies such as container-selinux built and tested
                                    together, and updated as frequently as every 12 weeks.
container-tools 1.0       common [ Stable versions of podman 1.0, buildah 1.5, skopeo 0.1, runc, conmon, CRIU, Udica, et
                          d]       c as well as dependencies such as container-selinux built and tested together, and su
                                   pported for 24 months.
container-tools 2.0       common [ Stable versions of podman 1.6, buildah 1.11, skopeo 0.1, runc, conmon, etc as well as
                          d]        dependencies such as container-selinux built and tested together, and supported as d
                                   ocumented on the Application Stream lifecycle page.

Hint: [d]efault, [e]nabled, [x]disabled, [i]nstalled
```


### Download runc package from each container-tools module stream

```
$ dnf download runc
$ sudo dnf module enable container-tools:1.0
$ dnf download runc
$ sudo dnf module reset container-tools
$ sudo dnf module enable container-tools:2.0
$ dnf download runc
$ sudo dnf module reset container-tools
```


```
$ ls *.rpm
runc-1.0.0-56.rc5.dev.git2abd837.module_el8.3.0+569+1bada2e4.x86_64.rpm
runc-1.0.0-64.rc10.module_el8.3.0+479+69e2ae26.x86_64.rpm
runc-1.0.0-70.rc92.module_el8.3.0+699+d61d9c41.x86_64.rpm
```


### Compare two packages looking explicitly for ABI differences

```
$ P1=runc-1.0.0-56.rc5.dev.git2abd837.module_el8.3.0+569+1bada2e4.x86_64.rpm; \
  P2=runc-1.0.0-64.rc10.module_el8.3.0+479+69e2ae26.x86_64.rpm; \
  rpminspect-fedora -T abidiff --verbose --format=text \
  --output=rpminspect-fedora.abidiff.verbose.${P1}.vs.${P2}.txt ${P1} ${P2}
Running abidiff inspection...        FAIL
```

Full output is in...

`rpminspect-fedora.abidiff.verbose.runc-1.0.0-56.rc5.dev.git2abd837.module_el8.3.0+569+1bada2e4.x86_64.rpm.vs.runc-1.0.0-64.rc10.module_el8.3.0+479+69e2ae26.x86_64.rpm.txt`
