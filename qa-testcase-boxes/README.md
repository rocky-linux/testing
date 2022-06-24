# Vagrant Boxes for Rocky Linux QA Testing

This repository holds Vagrant box definitions for various partially automated QA testing sequences.

The Vagrant boxes will perform one sample analysis when they are instantiated. They can be reprovisioned with various other options to run other analyses, details are provided as examples within each box directory. Additionally, the script run the Vagrant boxes can be uses standalone in a system with similar specification and requirements without the need for Vagrant.

## testcase-mediacheck

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


## testcase-debranding-validation

This box will...

-   Validate package debranding as described in QA:Testcase Debranding Validation
-   Optionally use cached rpms, previously downloaded Rocky Linux ISOs or published Rocky Linux repositories for debranding analysis.
-   Produce output than can be parsed into summary reports
