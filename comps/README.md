# RHEL vs Rocky repository comps.xml comparison

Reference:

- https://fedoraproject.org/wiki/How_to_use_and_edit_comps.xml_for_package_groups

## Download the fedora comps-cleanup.xsl

Found here... https://pagure.io/fedora-comps/blob/main/f/comps-cleanup.xsl


## Use xsltproc to cleanup the comps.xml from the reposync'd repositories

### BaseOS

```
➜  repos find . -name "*comps*.xml" | grep 8.4 | grep -Ei "baseos"
./rocky/8.4/baseos/repodata/5eedac6f334681aa51e154d77025db287c33ce1491b14368be9b477ff8208152-comps-BaseOS.x86_64.xml
./rhel/8.4/baseos/repodata/856cf20340533fc495b131d1b0a792b5c500dcce8ebd806ea87127b67cd282a1-comps.xml

➜  repos xsltproc -novalid -o rocky-8-baseos-comps.xml comps-cleanup.xsl \
    $(pwd)/./rocky/8.4/baseos/repodata/5eedac6f334681aa51e154d77025db287c33ce1491b14368be9b477ff8208152-comps-BaseOS.x86_64.xml

➜  repos xsltproc -novalid -o rhel-8-baseos-comps.xml comps-cleanup.xsl \
    $(pwd)/./rhel/8.4/baseos/repodata/856cf20340533fc495b131d1b0a792b5c500dcce8ebd806ea87127b67cd282a1-comps.xml
```

### AppStream

```
➜  repos find . -name "*comps*.xml" | grep 8.4 | grep -i app
./rocky/8.4/appstream/repodata/18e57fa69a4daadd345ab03e41c0347ce77405b128d02d086aa958f4b805d732-comps-AppStream.x86_64.xml
./rhel/8.4/appstream/repodata/cac7589fc374245267f367d9102f0c7233507dd84770d5f04f7e563c0f55d59b-comps.xml

➜  repos xsltproc -novalid -o rocky-8-appstream-comps.xml comps-cleanup.xsl \
    $(pwd)/./rocky/8.4/appstream/repodata/18e57fa69a4daadd345ab03e41c0347ce77405b128d02d086aa958f4b805d732-comps-AppStream.x86_64.xml
☹☹☹ Empty group  (conflicts-appstream)!

➜  repos xsltproc -novalid -o rhel-8-appstream-comps.xml comps-cleanup.xsl \
    $(pwd)/./rhel/8.4/appstream/repodata/cac7589fc374245267f367d9102f0c7233507dd84770d5f04f7e563c0f55d59b-comps.xml
☹☹☹ Empty group  (conflicts-appstream)!
```

### CodeReady / PowerTools

```
➜  repos find . -name "*comps*.xml" | grep 8.4 | grep -Ei "code|power"
./rocky/8.4/powertools/repodata/ca0be1262c3719850ebd15806a1d8c869ee82de1e7cb83f4f42e2dae967dcf3c-comps-PowerTools.x86_64.xml
./rhel/8.4/codeready/repodata/165f57a866dd8808ec2166ec629342802033187c22fbc9010869b1752cb3fb37-comps.xml

➜  repos xsltproc -novalid -o rhel-8-codeready-comps.xml comps-cleanup.xsl \
    $(pwd)/./rhel/8.4/codeready/repodata/165f57a866dd8808ec2166ec629342802033187c22fbc9010869b1752cb3fb37-comps.xml

➜  repos xsltproc -novalid -o rocky-8-powertools-comps.xml comps-cleanup.xsl \
    $(pwd)/./rocky/8.4/powertools/repodata/ca0be1262c3719850ebd15806a1d8c869ee82de1e7cb83f4f42e2dae967dcf3c-comps-PowerTools.x86_64.xml
```


### Resilient Storage

```
➜  repos find . -name "*comps*.xml" | grep 8.4 | grep -Ei "res"
./rocky/8.4/resilient-storage/repodata/d153da28376d04e0bd0bf658dfbc8bba4dbee9682343e75e3cac06bfaa5dd241-comps-ResilientStorage.x86_64.xml
./rhel/8.4/resilientstorage/repodata/6c841e9926e57e0fe71a09c8dab88c65dc7167fe006d68322c0c3797a30c7b41-comps.xml

➜  repos xsltproc -novalid -o rocky-8-resilient-storage-comps.xml comps-cleanup.xsl \
    $(pwd)/./rocky/8.4/resilient-storage/repodata/d153da28376d04e0bd0bf658dfbc8bba4dbee9682343e75e3cac06bfaa5dd241-comps-ResilientStorage.x86_64.xml

➜  repos xsltproc -novalid -o rhel-8-resilient-storage-comps.xml comps-cleanup.xsl \
    $(pwd)/./rhel/8.4/resilientstorage/repodata/6c841e9926e57e0fe71a09c8dab88c65dc7167fe006d68322c0c3797a30c7b41-comps.xml

```

### High Availability

```
➜  repos find . -name "*comps*.xml" | grep 8.4 | grep -Ei "ha|high"
./rocky/8.4/ha/repodata/076cd4a3817a824e4f542b0d8e4df7d4f9110e579bf82674ab9f992bf4b40b54-comps-HighAvailability.x86_64.xml
./rhel/8.4/highavailability/repodata/2b4ec451e7adb968ea936d2cb0ff6c2f9949d80547acbb60354ce9a505b2e85f-comps.xml

➜  repos xsltproc -novalid -o rocky-8-ha-comps.xml comps-cleanup.xsl \
    $(pwd)/./rocky/8.4/ha/repodata/076cd4a3817a824e4f542b0d8e4df7d4f9110e579bf82674ab9f992bf4b40b54-comps-HighAvailability.x86_64.xml

➜  repos xsltproc -novalid -o rhel-8-highavailability-comps.xml comps-cleanup.xsl \
    $(pwd)/./rhel/8.4/highavailability/repodata/2b4ec451e7adb968ea936d2cb0ff6c2f9949d80547acbb60354ce9a505b2e85f-comps.xml
```



## Diff the cleaned comps.xml files


### BaseOS

```
➜  repos diff -w \
    <(grep -Ev "<default>|display_order|uservisible|xml:lang" rhel-8-baseos-comps.xml) \
    <(grep -Ev "<default>|display_order|uservisible|xml:lang" rocky-8-baseos-comps.xml)
94c94
<     <description>The standard installation of Red Hat Enterprise Linux.</description>
---
>     <description>The standard installation of Rocky Linux.</description>
108a109
>       <packagereq type="mandatory">kpatch-dnf</packagereq>
117,118c118,119
<       <packagereq type="mandatory">redhat-release</packagereq>
<       <packagereq type="mandatory">redhat-release-eula</packagereq>
---
>       <packagereq type="mandatory">rocky-release</packagereq>
>       <packagereq type="mandatory">rocky-release-eula</packagereq>
132d132
<       <packagereq type="default">dnf-plugin-subscription-manager</packagereq>
146a147
>       <packagereq type="default">nvme-cli</packagereq>
148d148
<       <packagereq type="default">rng-tools</packagereq>
154,155d153
<       <packagereq type="default">subscription-manager-cockpit</packagereq>
<       <packagereq type="default">subscription-manager-plugin-container</packagereq>
173a172
>       <packagereq type="optional">vdo-support</packagereq>
213a213
>       <packagereq type="mandatory">NetworkManager</packagereq>
220d219
<       <packagereq type="mandatory">rng-tools</packagereq>
228d226
<       <packagereq type="mandatory">subscription-manager</packagereq>
247,248d244
<       <packagereq type="default">iwl3945-firmware</packagereq>
<       <packagereq type="default">iwl4965-firmware</packagereq>
261d256
<       <packagereq type="default">NetworkManager</packagereq>
286a282
>       <packagereq type="default">elfutils-libelf-devel</packagereq>
361a358
>       <packagereq type="default">alsa-sof-firmware</packagereq>
370,371d366
<       <packagereq type="default">iwl3945-firmware</packagereq>
<       <packagereq type="default">iwl4965-firmware</packagereq>
436a432
>       <packagereq type="optional">numatop</packagereq>
535c531
<     <description>Recommended development headers and libraries for developing applications to run on Red Hat Enterprise Linux.</description>
---
>     <description>Recommended development headers and libraries for developing applications to run on Rocky Linux.</description>
564c560
<     <description>Remote management interface for Red Hat Enterprise Linux.</description>
---
>     <description>Remote management interface for Rocky Linux.</description>
598,599c594,595
<       <packagereq type="mandatory">redhat-release</packagereq>
<       <packagereq type="mandatory">redhat-release-eula</packagereq>
---
>       <packagereq type="mandatory">rocky-release</packagereq>
>       <packagereq type="mandatory">rocky-release-eula</packagereq>
630c626
<     <description>The standard installation of Red Hat Enterprise Linux.</description>
---
>     <description>The standard installation of Rocky Linux.</description>
644a641
>       <packagereq type="mandatory">kpatch-dnf</packagereq>
653,654c650,651
<       <packagereq type="mandatory">redhat-release</packagereq>
<       <packagereq type="mandatory">redhat-release-eula</packagereq>
---
>       <packagereq type="mandatory">rocky-release</packagereq>
>       <packagereq type="mandatory">rocky-release-eula</packagereq>
668d664
<       <packagereq type="default">dnf-plugin-subscription-manager</packagereq>
682a679
>       <packagereq type="default">nvme-cli</packagereq>
684d680
<       <packagereq type="default">rng-tools</packagereq>
690,691d685
<       <packagereq type="default">subscription-manager-cockpit</packagereq>
<       <packagereq type="default">subscription-manager-plugin-container</packagereq>
709a704
>       <packagereq type="optional">vdo-support</packagereq>
778,780c773,774
<       <packagereq type="mandatory">redhat-release</packagereq>
<       <packagereq type="mandatory">redhat-release-eula</packagereq>
<       <packagereq type="mandatory">rng-tools</packagereq>
---
>       <packagereq type="mandatory">rocky-release</packagereq>
>       <packagereq type="mandatory">rocky-release-eula</packagereq>
810,825c804,819
<       <groupid default="true">debugging</groupid>
<       <groupid default="true">dns-server</groupid>
<       <groupid default="true">file-server</groupid>
<       <groupid default="true">ftp-server</groupid>
<       <groupid default="true">gnome-desktop</groupid>
<       <groupid default="true">guest-agents</groupid>
<       <groupid default="true">hardware-monitoring</groupid>
<       <groupid default="true">infiniband</groupid>
<       <groupid default="true">mail-server</groupid>
<       <groupid default="true">network-file-system-client</groupid>
<       <groupid default="true">network-server</groupid>
<       <groupid default="true">performance</groupid>
<       <groupid default="true">remote-system-management</groupid>
<       <groupid default="true">smb-server</groupid>
<       <groupid default="true">virtualization-hypervisor</groupid>
<       <groupid default="true">web-server</groupid>
---
>       <groupid>debugging</groupid>
>       <groupid>dns-server</groupid>
>       <groupid>file-server</groupid>
>       <groupid>ftp-server</groupid>
>       <groupid>gnome-desktop</groupid>
>       <groupid>guest-agents</groupid>
>       <groupid>hardware-monitoring</groupid>
>       <groupid>infiniband</groupid>
>       <groupid>mail-server</groupid>
>       <groupid>network-file-system-client</groupid>
>       <groupid>network-server</groupid>
>       <groupid>performance</groupid>
>       <groupid>remote-system-management</groupid>
>       <groupid>smb-server</groupid>
>       <groupid>virtualization-hypervisor</groupid>
>       <groupid>web-server</groupid>
836,837c830,831
<       <groupid default="true">guest-agents</groupid>
<       <groupid default="true">standard</groupid>
---
>       <groupid>guest-agents</groupid>
>       <groupid>standard</groupid>
843c837
<     <description>Basic building block for a custom RHEL system.</description>
---
>     <description>Basic building block for a custom Rocky system.</description>
848,849c842,843
<       <groupid default="true">guest-agents</groupid>
<       <groupid default="true">standard</groupid>
---
>       <groupid>guest-agents</groupid>
>       <groupid>standard</groupid>
```


### AppStream

```
➜  repos diff -w \
    <(grep -Ev "<default>|display_order|uservisible|xml:lang" rhel-8-appstream-comps.xml) \
    <(grep -Ev "<default>|display_order|uservisible|xml:lang" rocky-8-appstream-comps.xml)
100c100
<     <description>The standard installation of Red Hat Enterprise Linux.</description>
---
>     <description>The standard installation of Rocky Linux.</description>
110d109
<       <packagereq type="default">rhc</packagereq>
165d163
<       <packagereq type="default">rhc</packagereq>
673c671
<     <description>Java support for the Red Hat Enterprise Linux Server and Desktop Platforms.</description>
---
>     <description>Java support for the Rocky Linux Server and Desktop Platforms.</description>
944c942
<     <description>Recommended development headers and libraries for developing applications to run on Red Hat Enterprise Linux.</description>
---
>     <description>Recommended development headers and libraries for developing applications to run on Rocky Linux.</description>
1071c1069
<     <description>Remote management interface for Red Hat Enterprise Linux.</description>
---
>     <description>Remote management interface for Rocky Linux.</description>
1140c1138
<     <description>The standard installation of Red Hat Enterprise Linux.</description>
---
>     <description>The standard installation of Rocky Linux.</description>
1150d1147
<       <packagereq type="default">rhc</packagereq>
```


### CodeReady vs PowerTools

```
➜  repos diff \
    <(grep -Ev "display_order|uservisible|xml:lang" rhel-8-codeready-comps.xml) \
    <(grep -Ev "display_order|uservisible|xml:lang" rocky-8-powertools-comps.xml)
5c5,7
<     <id>codeready-builder</id>
---
>     <id>rocky-powertools</id>
>     <name>Rocky PowerTools</name>
>     <description>Rocky Devel PowerTools packages.</description>
7,8d8
<     <name>CodeReady Builder</name>
<     <description>Red Hat CodeReady Linux Builder packages.</description>
9a10
>       <packagereq type="default">accel-config-devel</packagereq>
27a29
>       <packagereq type="default">autogen-libopts-devel</packagereq>
33a36,38
>       <packagereq type="default">avahi-glib-devel</packagereq>
>       <packagereq type="default">avahi-gobject-devel</packagereq>
>       <packagereq type="default">avahi-ui-devel</packagereq>
35a41
>       <packagereq type="default">bcc-devel</packagereq>
102,104d107
<       <packagereq type="default">djvulibre</packagereq>
<       <packagereq type="default">djvulibre-devel</packagereq>
<       <packagereq type="default">djvulibre-libs</packagereq>
115a119
>       <packagereq type="default">dwarves</packagereq>
129a134
>       <packagereq type="default">evince-devel</packagereq>
176d180
<       <packagereq type="default">ghostscript-x11</packagereq>
220a225
>       <packagereq type="default">graphviz-python3</packagereq>
245a251
>       <packagereq type="default">http-parser-devel</packagereq>
249a256,257
>       <packagereq type="default">ibus-table-devel</packagereq>
>       <packagereq type="default">ibus-table-tests</packagereq>
253,255c261
<       <packagereq type="default">infiniband-diags-compat</packagereq>
<       <packagereq type="default">infiniband-diags-devel</packagereq>
<       <packagereq type="default">infiniband-diags-devel-static</packagereq>
---
>       <packagereq type="default">intel-cmt-cat-devel</packagereq>
258a265
>       <packagereq type="default">iscsi-initiator-utils-devel</packagereq>
270d276
<       <packagereq type="default">json-c-devel</packagereq>
302a309
>       <packagereq type="default">libbabeltrace-devel</packagereq>
303a311,321
>       <packagereq type="default">libblockdev-crypto-devel</packagereq>
>       <packagereq type="default">libblockdev-devel</packagereq>
>       <packagereq type="default">libblockdev-fs-devel</packagereq>
>       <packagereq type="default">libblockdev-loop-devel</packagereq>
>       <packagereq type="default">libblockdev-lvm-devel</packagereq>
>       <packagereq type="default">libblockdev-mdraid-devel</packagereq>
>       <packagereq type="default">libblockdev-part-devel</packagereq>
>       <packagereq type="default">libblockdev-swap-devel</packagereq>
>       <packagereq type="default">libblockdev-vdo-devel</packagereq>
>       <packagereq type="default">libbpf-devel</packagereq>
>       <packagereq type="default">libbpf-static</packagereq>
304a323
>       <packagereq type="default">libbytesize-devel</packagereq>
321a341
>       <packagereq type="default">libdazzle-devel</packagereq>
335a356
>       <packagereq type="default">libecpg-devel</packagereq>
339a361
>       <packagereq type="default">libepubgen-devel</packagereq>
396a419
>       <packagereq type="default">libnftnl-devel</packagereq>
420a444
>       <packagereq type="default">libpsl-devel</packagereq>
446a471
>       <packagereq type="default">libsemanage-devel</packagereq>
452a478
>       <packagereq type="default">libsmi-devel</packagereq>
458a485
>       <packagereq type="default">libstoragemgmt-devel</packagereq>
463a491
>       <packagereq type="default">libudisks2-devel</packagereq>
466a495
>       <packagereq type="default">liburing-devel</packagereq>
469a499
>       <packagereq type="default">libuv-devel</packagereq>
499a530
>       <packagereq type="default">libXvMC-devel</packagereq>
726a758
>       <packagereq type="default">pcre2-tools</packagereq>
784d815
<       <packagereq type="default">perl-IO-String</packagereq>
878a910
>       <packagereq type="default">pmix-devel</packagereq>
888,889d919
<       <packagereq type="default">protobuf-c-compiler</packagereq>
<       <packagereq type="default">protobuf-c-devel</packagereq>
891a922
>       <packagereq type="default">protobuf-lite-devel</packagereq>
897a929,930
>       <packagereq type="default">py3c-devel</packagereq>
>       <packagereq type="default">py3c-doc</packagereq>
905d937
<       <packagereq type="default">python3-cheetah</packagereq>
934a967
>       <packagereq type="default">qatlib-devel</packagereq>
935a969
>       <packagereq type="default">qgpgme-devel</packagereq>
943a978
>       <packagereq type="default">quota-devel</packagereq>
961a997
>       <packagereq type="default">samba-devel</packagereq>
1002d1037
<       <packagereq type="default">tokyocabinet-doc</packagereq>
1006a1042
>       <packagereq type="default">tracker-devel</packagereq>
1009a1046
>       <packagereq type="default">twolame-devel</packagereq>
1026a1064
>       <packagereq type="default">woff2-devel</packagereq>
1058a1097
>       <packagereq type="default">xorg-x11-server-source</packagereq>
1065d1103
<       <packagereq type="default">yaml-cpp-devel</packagereq>
```

### Resilient Storage

```
➜  repos diff -w <(grep -Ev "<default>|display_order|uservisible|xml:lang" rhel-8-resilient-storage-comps.xml) <(grep -Ev "<default>|display_order|uservisible|xml:lang" rocky-8-resilient-storage-comps.xml)
```

Hard to believe there are NO differences. Recheck without filtering...

```
➜  repos diff -w rhel-8-resilient-storage-comps.xml rocky-8-resilient-storage-comps.xml
6,8d5
<     <default>true</default>
<     <uservisible>false</uservisible>
<     <display_order>1024</display_order>
49c46
<     <description xml:lang="ja">高可用性サービスや共有ストレージのインフラストラクチャー</description>
---
>     <description xml:lang="ja">高可用性サービスや共有ストレージのインフラストラクチャー。</description>
51c48
<     <description xml:lang="ko">고가용성 서비스 또는/그리고 공유 저장소를 위한 인프라스트럭쳐</description>
---
>     <description xml:lang="ko">고가용성 서비스 또는/그리고 공유 저장소를 위한 인프라스트럭쳐.</description>
66a64,65
>     <default>true</default>
>     <uservisible>false</uservisible>
103,105d101
<     <default>true</default>
<     <uservisible>false</uservisible>
<     <display_order>1024</display_order>
127a124,125
>     <default>true</default>
>     <uservisible>false</uservisible>
134,136d131
<     <default>true</default>
<     <uservisible>false</uservisible>
<     <display_order>1024</display_order>
191a187,188
>     <default>true</default>
>     <uservisible>false</uservisible>
```


### High Availability

```
➜  repos diff -w <(grep -Ev "<default>|display_order|uservisible|xml:lang" rhel-8-highavailability-comps.xml) <(grep -Ev "<default>|display_order|uservisible|xml:lang" rocky-8-ha-comps.xml)
```

Hard to believe there are NO differences. Recheck without filtering...

```
➜  repos diff rhel-8-highavailability-comps.xml rocky-8-ha-comps.xml
6,8d5
<     <default>true</default>
<     <uservisible>false</uservisible>
<     <display_order>1024</display_order>
49c46
<     <description xml:lang="ja">高可用性サービスや共有ストレージのインフラストラクチャー</description>
---
>     <description xml:lang="ja">高可用性サービスや共有ストレージのインフラストラクチャー。</description>
51c48
<     <description xml:lang="ko">고가용성 서비스 또는/그리고 공유 저장소를 위한 인프라스트럭쳐</description>
---
>     <description xml:lang="ko">고가용성 서비스 또는/그리고 공유 저장소를 위한 인프라스트럭쳐.</description>
66a64,65
>     <default>true</default>
>     <uservisible>false</uservisible>
103,105d101
<     <default>true</default>
<     <uservisible>false</uservisible>
<     <display_order>1024</display_order>
127a124,125
>     <default>true</default>
>     <uservisible>false</uservisible>
```
