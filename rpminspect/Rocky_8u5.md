# Testing/QA Team Package Inspection and Comparison for Rocky 8.5

## Overview

As part of the Testing / QA process when validating a new release for promotion
from Release Candidate (RC) to General Availability (GA) the Testing team will
compare the Release Engineering build products with those available from the
upstream release where applicable in an attempt to identify any issues with the
Rocky build which result in the production of packages that are not bug-for-bug
reproductions of the packages imported from upstream.


## Scope

Packages that are unique to Rocky are not compared to upstream as they are,
well, unique. The same can be said for packages that are unique in upstream. No
effort is made with this workflow to identify missing packages from Rocky
that exist in upstream. We have other tools for that.


## Requirements

- Rocky Linux 8.5 installed in system under test (SUT)
- The following packages and their dependencies are required:
    - `rpminspect`
    - `rpminspect-data-rocky`
    - `jsondiff`
    - `jq`
- A local clone of the upstream repositories to be compared


## Conventions

The following terms are used throughout the workflow and deserve definition:

- `{src}` - The source distribution
- `{tgt}` - The target distribution
- `{releasever}` - The version number stored as `*TBD*` in `/etc/os-release` on
`${src}` system.
-


## Layout

Portions of this workflow depend on a specific layout of code and content in
order to function without modification. That layout is depicted below...



The data directories can be local to the system or provided in some other
mechanism such as an NFS our bind mount. If not located at the default location
then the workflow may need to be modified to accomodate their use.


## Workflow

The basic workflow sequence is...

-   (re) Create source and target local repository clones for Rocky and RHEL
-   Run rpminspect against ALL packages in source and target repository clones
-   Parse the rpminspect output to identify tests as pass and fail
-   Summarize the parsed rpminspect output
-   Compare

## sync repositories locally

```
[vagrant@rocky8u5 data]$ ./repo_sync.sh
75 files removed
Syncing Rocky Linux Repos... appstream baseos devel extras ha powertools resilient-storage plus nfv rt
```

## (re)run rpminspect_wrapper.sh

*NOTE: If you want/need to replace previous reports/analysis be sure to clean out JSON reports.*

### Optional clean out previous reports...

```
[vagrant@rocky8u5 data]$ find rpminspect/rocky/8.5 -name "*.json" | wc -l
10259

[vagrant@rocky8u5 data]$ find rpminspect/rocky/8.5 -name "*.json" -print0 | xargs -0 /bin/rm

[vagrant@rocky8u5 data]$ find rpminspect/rocky/8.5 -name "*.json" | wc -l
0
```

```
[vagrant@rocky8u5 data]$ time ./rpminspect_wrapper.sh 2>&1 | tee rpminspect_wrapper.log
Rocky Linux appstream repo has...
	  2941 x86_64 packages -
		389-ds-base-1.4.3.23-10.module+el8.5.0+700+370e33d5.x86_64 fail
		389-ds-base-legacy-tools-1.4.3.23-10.module+el8.5.0+700+370e33d5.x86_64 fail
...
		resource-agents-4.1.1-98.el8.x86_64 fail
	     4 i686 packages
		libnozzle1-1.18-1.el8.i686 fail
	    26 noarch packages
		python3-azure-sdk skipped

real	95m56.557s
user	57m49.724s
sys	26m55.865s
```

If you don't update any packages in the locally sync'd repos the inspection will skip analysis for any packages that have output JSON files. So, updates to the local repository clone can be reprocessed with minimal time required.

For example...

```
[vagrant@rocky8u5 data]$ time ./rpminspect_wrapper.sh
Rocky Linux appstream repo has...
	  2941 x86_64 packages
	   983 i686 packages
	  2240 noarch packages
		subscription-manager-migration-data-2.0.51-1.noarch fail
Rocky Linux baseos repo has...
	  1110 x86_64 packages
	   403 i686 packages
	   230 noarch packages
		rocky-obsolete-packages-8-4.noarch fail
Rocky Linux extras repo has...
	     1 x86_64 packages
	    36 noarch packages
Rocky Linux ha repo has...
	    31 x86_64 packages
	     4 i686 packages
	    26 noarch packages
		python3-azure-sdk skipped
Rocky Linux powertools repo has...
	   759 x86_64 packages
	   625 i686 packages
	   811 noarch packages
Rocky Linux resilient-storage repo has...
	    33 x86_64 packages
	     4 i686 packages
	    26 noarch packages
		python3-azure-sdk skipped

real	4m25.786s
user	1m30.924s
sys	1m12.632s
```

## parse_rpminspect step

```
[vagrant@rocky8u5 data]$ ./parse_rpminspect.sh
    1973 /home/vagrant/data/rpminspect/rocky/8.5/rocky_fail
  172923 /home/vagrant/data/rpminspect/rocky/8.5/rocky_pass
  174896 total
```

## summarize rpminspect step

```
[vagrant@rocky8u5 data]$ ./summary_rpminspect.sh

=====
 Summary of all tests for rocky version 8.5...

  172923 /home/vagrant/data/rpminspect/rocky/8.5/rocky_pass
    1973 /home/vagrant/data/rpminspect/rocky/8.5/rocky_fail
  174896 total

=====
 Summary of failing tests...

-----
appstream had 1088 failing tests with the following breakdown...
	366 annocheck
	232 badfuncs
	184 javabytecode
	146 runpath
	63 emptyrpm
	39 xml
	16 shellsyntax
	10 pathmigration
	8 ownership
	7 capabilities
	7 lto
	4 permissions
	3 elf
	2 manpage
	1 symlinks

-----
powertools had 501 failing tests with the following breakdown...
	298 javabytecode
	77 annocheck
	48 runpath
	30 xml
	28 badfuncs
	7 shellsyntax
	6 pathmigration
	4 emptyrpm
	1 elf
	1 lto
	1 permissions

-----
baseos had 355 failing tests with the following breakdown...
	137 badfuncs
	70 annocheck
	60 runpath
	46 pathmigration
	12 elf
	8 emptyrpm
	6 ownership
	5 capabilities
	5 xml
	2 javabytecode
	2 shellsyntax
	1 permissions
	1 symlinks

-----
ha had 13 failing tests with the following breakdown...
	4 badfuncs
	4 emptyrpm
	2 annocheck
	2 xml
	1 shellsyntax

-----
resilient-storage had 13 failing tests with the following breakdown...
	4 badfuncs
	4 emptyrpm
	2 annocheck
	2 xml
	1 shellsyntax

-----
plus had 3 failing tests with the following breakdown...
	2 badfuncs
	1 annocheck

=====
 Summary of passing tests...

-----
appstream had 103683 passing tests with the following breakdown...
	6163 modularity
	6163 politics
	6162 symlinks
	6161 manpage
	6160 elf
	6159 permissions
	6156 capabilities
	6156 lto
	6155 ownership
	6153 pathmigration
	6147 shellsyntax
	6124 xml
	6100 emptyrpm
	6017 runpath
	5979 javabytecode
	5931 badfuncs
	5797 annocheck

-----
powertools had 36814 passing tests with the following breakdown...
	2195 capabilities
	2195 manpage
	2195 modularity
	2195 ownership
	2195 politics
	2195 symlinks
	2194 elf
	2194 lto
	2194 permissions
	2191 emptyrpm
	2189 pathmigration
	2188 shellsyntax
	2167 badfuncs
	2165 xml
	2147 runpath
	2118 annocheck
	1897 javabytecode

-----
baseos had 29259 passing tests with the following breakdown...
	1742 lto
	1742 manpage
	1742 modularity
	1742 politics
	1741 permissions
	1741 symlinks
	1740 javabytecode
	1740 shellsyntax
	1737 capabilities
	1737 xml
	1736 ownership
	1734 emptyrpm
	1730 elf
	1696 pathmigration
	1682 runpath
	1672 annocheck
	1605 badfuncs

-----
resilient-storage had 1041 passing tests with the following breakdown...
	62 capabilities
	62 elf
	62 javabytecode
	62 lto
	62 manpage
	62 modularity
	62 ownership
	62 pathmigration
	62 permissions
	62 politics
	62 runpath
	62 symlinks
	61 shellsyntax
	60 annocheck
	60 xml
	58 badfuncs
	58 emptyrpm

-----
ha had 1007 passing tests with the following breakdown...
	60 capabilities
	60 elf
	60 javabytecode
	60 lto
	60 manpage
	60 modularity
	60 ownership
	60 pathmigration
	60 permissions
	60 politics
	60 runpath
	60 symlinks
	59 shellsyntax
	58 annocheck
	58 xml
	56 badfuncs
	56 emptyrpm

-----
extras had 629 passing tests with the following breakdown...
	37 annocheck
	37 badfuncs
	37 capabilities
	37 elf
	37 emptyrpm
	37 javabytecode
	37 lto
	37 manpage
	37 modularity
	37 ownership
	37 pathmigration
	37 permissions
	37 politics
	37 runpath
	37 shellsyntax
	37 symlinks
	37 xml

-----
nfv had 459 passing tests with the following breakdown...
	27 annocheck
	27 badfuncs
	27 capabilities
	27 elf
	27 emptyrpm
	27 javabytecode
	27 lto
	27 manpage
	27 modularity
	27 ownership
	27 pathmigration
	27 permissions
	27 politics
	27 runpath
	27 shellsyntax
	27 symlinks
	27 xml

-----
plus had 31 passing tests with the following breakdown...
	2 capabilities
	2 elf
	2 emptyrpm
	2 javabytecode
	2 lto
	2 manpage
	2 modularity
	2 ownership
	2 pathmigration
	2 permissions
	2 politics
	2 runpath
	2 shellsyntax
	2 symlinks
	2 xml
	1 annocheck
```


## compare_rpminspect step

```
[vagrant@rocky8u5 data]$ time ./compare_rpminspect.sh fail 2>"compare_rpminspect.fail.$(date -Isec).err" | tee "compare_rpminspect.fail.$(date -Isec).out"
=====
./compare_rpminspect.sh started at Wed Nov 17 08:14:02 UTC 2021 for FAILURES
=====
rocky/8.5/appstream/389-ds-base-1.4.3.23-10.module+el8.5.0+700+370e33d5.x86_64.rpm annocheck FAILURES_MATCH rhel/8.5/appstream/389-ds-base-1.4.3.23-10.module+el8.5.0+12398+47000435.x86_64.rpm
rocky/8.5/appstream/389-ds-base-1.4.3.23-10.module+el8.5.0+700+370e33d5.x86_64.rpm runpath FAILURES_MATCH rhel/8.5/appstream/389-ds-base-1.4.3.23-10.module+el8.5.0+12398+47000435.x86_64.rpm
rocky/8.5/appstream/389-ds-base-legacy-tools-1.4.3.23-10.module+el8.5.0+700+370e33d5.x86_64.rpm runpath FAILURES_MATCH rhel/8.5/appstream/389-ds-base-legacy-tools-1.4.3.23-10.module+el8.5.0+12398+47000435.x86_64.rpm

...

rocky/8.5/rt/kernel-rt-debug-devel-4.18.0-348.rt7.130.el8.0.2.x86_64.rpm NO_TARGET_PACKAGE_IN rhel/8.5/rt
rocky/8.5/rt/kernel-rt-devel-4.18.0-348.rt7.130.el8.0.2.x86_64.rpm NO_TARGET_PACKAGE_IN rhel/8.5/rt
rocky/8.5/rt/stress-ng-0.12.06-2.el8.x86_64.rpm NO_TARGET_PACKAGE_IN rhel/8.5/rt
=====
./compare_rpminspect.sh ended at Wed Nov 17 09:11:32 UTC 2021 for FAILURES
=====
real	57m30.305s
user	42m10.831s
sys	8m26.707s
```

Optionally, you can repeat the analysis for rpminspect tests deemed to have passed as well.

*NOTE: This will take a lot longer to complete.*

```
[vagrant@rocky8u5 data]$ time ./compare_rpminspect.sh pass 2>"compare_rpminspect.pass.$(date -Isec).err" | tee "compare_rpminspect.pass.$(date -Isec).out"
=====
./compare_rpminspect.sh started at Wed Nov 17 16:10:28 UTC 2021 for PASSES
=====
rocky/8.5/appstream/389-ds-base-1.4.3.23-10.module+el8.5.0+700+370e33d5.x86_64.rpm emptyrpm PASSES_MATCH rhel/8.5/appstream/389-ds-base-1.4.3.23-10.module+el8.5.0+12398+47000435.x86_64.rpm
rocky/8.5/appstream/389-ds-base-1.4.3.23-10.module+el8.5.0+700+370e33d5.x86_64.rpm manpage PASSES_MATCH rhel/8.5/appstream/389-ds-base-1.4.3.23-10.module+el8.5.0+12398+47000435.x86_64.rpm
rocky/8.5/appstream/389-ds-base-1.4.3.23-10.module+el8.5.0+700+370e33d5.x86_64.rpm xml PASSES_MATCH rhel/8.5/appstream/389-ds-base-1.4.3.23-10.module+el8.5.0+12398+47000435.x86_64.rpm
...

rocky/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm emptyrpm PASSES_MATCH rhel/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm
rocky/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm manpage PASSES_MATCH rhel/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm
rocky/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm xml PASSES_MATCH rhel/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm
rocky/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm elf PASSES_MATCH rhel/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm
rocky/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm modularity PASSES_MATCH rhel/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm
rocky/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm javabytecode PASSES_MATCH rhel/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm
rocky/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm ownership PASSES_MATCH rhel/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm
rocky/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm shellsyntax PASSES_MATCH rhel/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm
rocky/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm annocheck PASSES_MATCH rhel/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm
rocky/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm permissions PASSES_MATCH rhel/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm
rocky/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm capabilities PASSES_MATCH rhel/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm
rocky/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm pathmigration PASSES_MATCH rhel/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm
rocky/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm lto PASSES_MATCH rhel/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm
rocky/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm symlinks PASSES_MATCH rhel/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm
rocky/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm politics PASSES_MATCH rhel/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm
rocky/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm badfuncs PASSES_MATCH rhel/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm
rocky/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm runpath PASSES_MATCH rhel/8.5/appstream/abrt-2.10.9-21.el8.x86_64.rpm

...

rocky/8.5/rt/kernel-rt-modules-extra-4.18.0-348.rt7.130.el8.0.2.x86_64.rpm NO_TARGET_PACKAGE_IN rhel/8.5/rt
rocky/8.5/rt/rteval-3.2-2.el8.noarch.rpm NO_TARGET_PACKAGE_IN rhel/8.5/rt
rocky/8.5/rt/rteval-loads-1.4-13.el8.x86_64.rpm NO_TARGET_PACKAGE_IN rhel/8.5/rt

real	611m31.049s  <--- you do NOT want to do this often. Maybe only repeat on/if there are PASSES_DIFF found.
user	101m13.507s
sys	88m19.529s
```
*NOTE: As can be seen for abrt above, there are 17 PASSES_MATCH entries for each 100% successful comparison of non-modular packages.*

*NOTE: Modular packages may have failure due only to package version being listed in the message for a test.*

Sample PASSES_DIFFERENT examination

```
[vagrant@rocky8u5 data]$ diff /home/vagrant/data/rpminspect/rocky/8.5/powertools/xorg-x11-drv-wacom-devel-0.38.0-1.el8.x86_64.rpminspect.out /home/vagrant/data/rpminspect/rhel/8.5/codeready/xorg-x11-drv-wacom-devel-0.38.0-1.el8.x86_64.rpminspect.out
9c9
< Running annocheck inspection...      pass
---
> Running annocheck inspection...      FAIL
```




```
[vagrant@rocky8u5 data]$ jsondiff <(jq -r --sort-keys '.["annocheck"]' /home/vagrant/data/rpminspect/rocky/8.5/powertools/xorg-x11-drv-wacom-devel-0.38.0-1.el8.x86_64.json) <(jq -r --sort-keys '.["annocheck"]' /home/vagrant/data/rpminspect/rhel/8.5/codeready/xorg-x11-drv-wacom-devel-0.38.0-1.el8.x86_64.json) -i 2 -s symmetric
{
  "0": {
    "details": [
      "annocheck: Version 9.65.\nHardened: /usr/bin/isdv4-serial-debugger: PASS: pie test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: cf-protection test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: property-note test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: writeable-got test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: dynamic-segment test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: bind-now test \nHardened: /usr/bin/isdv4-serial-debugger: info: set binary producer to Gas version 2.\nHardened: /usr/bin/isdv4-serial-debugger: info: notes produced by assembler plugin version 1\nHardened: /usr/bin/isdv4-serial-debugger: info: set binary producer to GCC version 9.\nHardened: /usr/bin/isdv4-serial-debugger: info: notes produced by gcc plugin version 9.23\nHardened: /usr/bin/isdv4-serial-debugger: PASS: stack-prot test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: pic test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: fortify test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: glibcxx-assertions test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: optimization test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: warnings test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: stack-clash test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: entry test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: gnu-stack test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: gnu-relro test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: notes test because no gaps found \nHardened: /usr/bin/isdv4-serial-debugger: skip: branch-protection test because not an AArch64 binary \nHardened: /usr/bin/isdv4-serial-debugger: skip: dynamic-tags test because AArch64 specific \nHardened: /usr/bin/isdv4-serial-debugger: skip: go-revision test because no GO compiled code found \nHardened: /usr/bin/isdv4-serial-debugger: PASS: lto test \nHardened: /usr/bin/isdv4-serial-debugger: skip: only-go test because no GO compiled code found \nHardened: /usr/bin/isdv4-serial-debugger: PASS: run-path test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: rwx-seg test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: short-enum test \nHardened: /usr/bin/isdv4-serial-debugger: skip: stack-realign test because not an x86 executable \nHardened: /usr/bin/isdv4-serial-debugger: PASS: textrel test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: threads test ",
      "annocheck: Version 9.72.\nHardened: /usr/bin/isdv4-serial-debugger: PASS: pie test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: cf-protection test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: property-note test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: writeable-got test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: dynamic-segment test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: bind-now test \nHardened: Internal Failure: /usr/bin/isdv4-serial-debugger: Unrecognised annobin note type 0.\nHardened: /usr/bin/isdv4-serial-debugger: PASS: entry test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: gnu-stack test because stack segment exists with the correct permissions \nHardened: /usr/bin/isdv4-serial-debugger: PASS: gnu-relro test \nHardened: /usr/bin/isdv4-serial-debugger: Not checking for gaps (binary created by a tool without an annobin plugin).\nHardened: /usr/bin/isdv4-serial-debugger: PASS: notes test \nHardened: /usr/bin/isdv4-serial-debugger: skip: branch-protection test because not an AArch64 binary \nHardened: /usr/bin/isdv4-serial-debugger: skip: dynamic-tags test because AArch64 specific \nHardened: /usr/bin/isdv4-serial-debugger: MAYB: test: fortify because no valid notes found regarding this test \nHardened: /usr/bin/isdv4-serial-debugger: MAYB: test: glibcxx-assertions because no valid notes found regarding this test \nHardened: /usr/bin/isdv4-serial-debugger: skip: go-revision test because no GO compiled code found \nHardened: /usr/bin/isdv4-serial-debugger: PASS: lto test \nHardened: /usr/bin/isdv4-serial-debugger: skip: only-go test because no GO compiled code found \nHardened: /usr/bin/isdv4-serial-debugger: skip: optimization test because not compiled code \nHardened: /usr/bin/isdv4-serial-debugger: skip: pic test because not compiled code \nHardened: /usr/bin/isdv4-serial-debugger: PASS: production test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: run-path test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: rwx-seg test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: short-enum test \nHardened: /usr/bin/isdv4-serial-debugger: MAYB: test: stack-clash because no notes found regarding this test \nHardened: /usr/bin/isdv4-serial-debugger: skip: stack-prot test because not compiled code \nHardened: /usr/bin/isdv4-serial-debugger: skip: stack-realign test because not an x86 executable \nHardened: /usr/bin/isdv4-serial-debugger: PASS: textrel test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: threads test \nHardened: /usr/bin/isdv4-serial-debugger: PASS: unicode test \nHardened: /usr/bin/isdv4-serial-debugger: skip: warnings test because compiling in LTO mode hides preprocessor and warning options "
    ],
    "message": [
      "annocheck 'hardened' test passes for /usr/bin/isdv4-serial-debugger on x86_64",
      "annocheck 'hardened' test fails for /usr/bin/isdv4-serial-debugger on x86_64"
    ],
    "result": [
      "INFO",
      "VERIFY"
    ]
  },
  "$delete": [
    [
      1,
      {
        "result": "OK",
        "waiver authorization": "Not Waivable"
      }
    ]
  ]
}
```

Summary of DIFF for PASSES...

```
[vagrant@rocky8u5 data]$ grep DIFF compare_rpminspect.pass.2021-11-17T16:10:28+00:00.out | wc -l
204

[vagrant@rocky8u5 data]$ grep DIFF compare_rpminspect.pass.2021-11-17T16:10:28+00:00.out | grep annocheck | wc -l
203

[vagrant@rocky8u5 data]$ grep DIFF compare_rpminspect.pass.2021-11-17T16:10:28+00:00.out | grep -v annocheck
rocky/8.5/appstream/python36-devel-3.6.8-38.module+el8.5.0+671+195e4563.x86_64.rpm symlinks PASSES_DIFFERENT rhel/8.5/appstream/python36-devel-3.6.8-38.module+el8.5.0+12207+5c5719bc.x86_64.rpm

```

This is actually a problem with rhel...

```
[vagrant@rocky8u5 data]$ jsondiff <(jq -r --sort-keys '.["symlinks"]' /home/vagrant/data/rpminspect/rocky/8.5/appstream/python36-devel-3.6.8-38.module+el8.5.0+671+195e4563.x86_64.json) <(jq -r --sort-keys '.["symlinks"]' /home/vagrant/data/rpminspect/rhel/8.5/appstream/python36-devel-3.6.8-38.module+el8.5.0+12207+5c5719bc.x86_64.json) | jq '.'
{
  "$insert": [
    [
      0,
      {
        "message": "symbolic link /usr/bin/python3.6-config is a dangling symbolic link in python36-devel on x86_64",
        "remedy": "Make sure symlinks point to a valid destination in one of the subpackages of the build; dangling symlinks are not allowed.  If you are comparing builds and have a non-symlink turn in to a symlink, ensure this is deliberate.  NOTE:  You cannot turn a directory in to a symlink due to RPM limitations.",
        "result": "INFO",
        "waiver authorization": "Not Waivable"
      }
    ]
  ]
}
```

```
[vagrant@rocky8u5 data]$ diff <(jq -r --sort-keys '.["symlinks"]' /home/vagrant/data/rpminspect/rocky/8.5/appstream/python36-devel-3.6.8-38.module+el8.5.0+671+195e4563.x86_64.json) <(jq -r --sort-keys '.["symlinks"]' /home/vagrant/data/rpminspect/rhel/8.5/appstream/python36-devel-3.6.8-38.module+el8.5.0+12207+5c5719bc.x86_64.json)
2a3,8
>     "message": "symbolic link /usr/bin/python3.6-config is a dangling symbolic link in python36-devel on x86_64",
>     "remedy": "Make sure symlinks point to a valid destination in one of the subpackages of the build; dangling symlinks are not allowed.  If you are comparing builds and have a non-symlink turn in to a symlink, ensure this is deliberate.  NOTE:  You cannot turn a directory in to a symlink due to RPM limitations.",
>     "result": "INFO",
>     "waiver authorization": "Not Waivable"
>   },
>   {
```

##

Principle is to compare failed test in rocky and rhel to see if they fail for the same reason...

### example baseos tar package has a badfuncs failure

```
[vagrant@rocky8u5 data]$ grep -i fail rpminspect/rocky/8.5/rocky_fail | grep baseos | grep "baseos tar"
baseos tar-1.30-5.el8.x86_64.rpm badfuncs FAIL

[vagrant@rocky8u5 data]$ grep -i fail rpminspect/rhel/8.5/rhel_fail | grep baseos | grep "baseos tar"
baseos tar-1.30-5.el8.x86_64.rpm badfuncs FAIL
```

### extract the badfuncs results

```
[vagrant@rocky8u5 data]$ jq --sort-keys ."badfuncs" rpminspect/rocky/8.5/baseos/tar-1.30-5.el8.x86_64.json
[
  {
    "details": "Forbidden function symbols found:\n\tgethostbyname\n",
    "message": "/usr/bin/tar may use forbidden functions on x86_64",
    "remedy": "Forbidden symbols were found in an ELF file in the package.  The configuration settings for rpminspect indicate the named symbols are forbidden in packages.  If this is deliberate, you may want to disable the badfuncs inspection.  If it is not deliberate, check the man pages for the named symbols to see what API functions have replaced the forbidden symbols.  Usually a function is marked as deprecated but still provided in order to allow for backwards compatibility.  Whenever possible the deprecated functions should not be used.",
    "result": "VERIFY",
    "waiver authorization": "Anyone"
  }
]
```

```
[vagrant@rocky8u5 data]$ jq --sort-keys ."badfuncs" rpminspect/rhel/8.5/baseos/tar-1.30-5.el8.x86_64.json
[
  {
    "details": "Forbidden function symbols found:\n\tgethostbyname\n",
    "message": "/usr/bin/tar may use forbidden functions on x86_64",
    "remedy": "Forbidden symbols were found in an ELF file in the package.  The configuration settings for rpminspect indicate the named symbols are forbidden in packages.  If this is deliberate, you may want to disable the badfuncs inspection.  If it is not deliberate, check the man pages for the named symbols to see what API functions have replaced the forbidden symbols.  Usually a function is marked as deprecated but still provided in order to allow for backwards compatibility.  Whenever possible the deprecated functions should not be used.",
    "result": "VERIFY",
    "waiver authorization": "Anyone"
  }
]
```

### diff the extract badfuncs results

```
[vagrant@rocky8u5 data]$ diff -s <(jq --sort-keys ."badfuncs" rpminspect/rocky/8.5/baseos/tar-1.30-5.el8.x86_64.json) <(jq --sort-keys ."badfuncs" rpminspect/rhel/8.5/baseos/tar-1.30-5.el8.x86_64.json)
Files /dev/fd/63 and /dev/fd/62 are identical
```

If the badfuncs failure in rocky matches that in rhel the we are "bug-for-bug compatible".
