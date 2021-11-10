# Running OpenQA from Docker

This document provides a reference example showing how OpenQA can be set up to test Rocky Linux in a containerized environment.

## Docker setup:

Run these steps for systems using Fedora:
 
1. Install packages: perl-Digest-SHA git docker
1. Enable Docker service: `sudo systemctl enable --now docker`
1. (Optional) Allow Docker use without sudo: `sudo usermod -aG docker $USER`

## Podman setup:

Run these steps for RHEL-based systems, such as Rocky Linux:

1. Install packages: perl-Digest-SHA git podman-docker
1. Install dnsname Podman plugin:
       https://github.com/containers/dnsname/blob/main/README_PODMAN.md#build-and-install

## How to use

- Build and start OpenQA container images by running `start.sh`
- Stop OpenQA containers with `stop.sh`

## Notes

- OpenQA configuration is stored in the "data" folder
- Webapp data is stored in the "data-postgres" folder. Delete this folder if you want to start fresh
- Webserver connection is available at http://localhost:80 by default
- VNC connection is available on port 5991 by default

