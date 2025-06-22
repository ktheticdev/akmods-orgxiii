# ublue-os akmods

[![akmods lite 42](https://github.com/JoViatrix/akmods-lite/actions/workflows/build-42.yml/badge.svg)](https://github.com/JoViatrix/akmods-lite/actions/workflows/build-42.yml)

OCI images providing a set of cached kernel RPMs and extra kernel modules to Universal Blue images. Used for better hardware support and consistent build process.

## How it's organized

The [`akmods` image](https://github.com/orgs/ublue-os/packages/container/package/akmods) is built and published daily. However, there's not a single image but several, given various kernels we now support.

The akmods packages are divided up for building in a few different "groups":

- `common` - any kmod installed by default in Bluefin/Aurora (or were originally in main images pre-Fedora 39)
- `extra` - any kmods used by Bazzite but not Bluefine/Aurora
- `nvidia` - only the nvidia proprietary kmod and addons
- `nvidia-open` - only the nvidia-open kmod and addons
- `zfs` - only the zfs kmod and utilities built for select kernels

Each of these images contains a cached copy of the respective kernel RPMs compatible with the respective kmods for the image.

Builds also run for different kernels:

- `bazzite` - Bazzite [builds a kernel with gaming specific patches](https://github.com/bazzite-org/kernel-bazzite) for the current release of Fedora
- `ublue 41` - Fedora 41 kernel builds:
  - `main` - current default kernel version
  - `coreos-stable` - current Fedora CoreOS stable kernel version
  - `coreos-testing` - current Fedora CoreOS testing kernel version
- `ublue 42` - Fedora 42 kernel builds:
  - `main` - current default kernel version
  - `coreos-stable` - current Fedora CoreOS stable kernel version
  - `coreos-testing` - current Fedora CoreOS testing kernel version

This table shows what groups build for which kernel and Fedora release:

| Build | Kernel | akmods group |
|-------|--------|--------------|
| bazzite | bazzite | common |
| bazzite | bazzite | extra |
| bazzite | bazzite | nvidia |
| bazzite | bazzite | nvidia-open |
| 41 | main | common |
| 41 | main | nvidia |
| 41 | main | nvidia-open |
| 41 | coreos-stable | common |
| 41 | coreos-stable | nvidia |
| 41 | coreos-stable | nvidia-open |
| 41 | coreos-stable | zfs |
| 42 | main | common |
| 42 | main | nvidia |
| 42 | main | nvidia-open |
| 42 | coreos-stable | common |
| 42 | coreos-stable | nvidia |
| 42 | coreos-stable | nvidia-open |
| 42 | coreos-stable | zfs |

## Features

### Overview

The `common` images contain related kmod packages, plus:

- `ublue-os-akmods-addons` - installs extra repos and our kmods signing key; install and import to allow SecureBoot systems to use these kmods
- `ublue-os-ucore-addons` - a slightly lighter `ublue-os-akmods-addons` for CoreOS/uCore systems

The `nvidia` and `nvidia-open` images contains

- `ublue-os-nvidia-addons` - installs extra repos enabling our nvidia support
  - [nvidia container selinux policy](https://github.com/NVIDIA/dgx-selinux/tree/master/src/nvidia-container-selinux) - uses RHEL9 policy as the closest match
  - [nvidia-container-tookkit repo](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installing-with-yum-or-dnf) - version 1.14 (and newer) provide CDI for podman use of nvidia gpus
- `ublue-os-ucore-nvidia` - a slightly lighter `ublue-os-nvidia-addons` for CoreOS/uCore systems

### Kmod Packages

| Package | Stream | Description | Source |
|---------|--------|-------------|--------|
| [ayaneo-platform](https://github.com/ShadowBlip/ayaneo-platform) | extra | Linux drivers for AYANEO x86 handhelds | [![badge](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/ayaneo-platform-kmod/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/ayaneo-platform-kmod) |
| [ayn-platform](https://github.com/ShadowBlip/ayn-platform) | extra | Linux drivers for AYN x86 handhelds | [![badge](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/ayn-platform-kmod/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/ayn-platform-kmod) |
| [bmi260](https://github.com/hhd-dev/bmi260) | extra | kernel module driver for the Bosch BMI260 IMU | [![badge](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/bmi260-kmod/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/bmi260-kmod) |
| [evdi](www.displaylink.com) | extra | kernel module required for use of displaylink | [negativo17 - fedora-multimedia](https://negativo17.org/) |
| [facetimehd](https://github.com/patjak/facetimehd/) | extra | kernel module Linux driver for the FacetimeHD (Broadcom 1570) PCIe webcam | [![badge](https://copr.fedorainfracloud.org/coprs/mulderje/facetimehd-kmod/package/facetimehd-kmod/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/mulderje/facetimehd-kmod/package/facetimehd-kmod) |
| [framework-laptop](https://github.com/DHowett/framework-laptop-kmod) | common | A kernel module that exposes the Framework Laptop (13, 16)'s battery charge limit and LEDs to userspace | [![badge](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/framework-laptop-kmod/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/framework-laptop-kmod) |
| [gcadapter_oc](https://github.com/hannesmann/gcadapter-oc-kmod) | extra | kernel module for overclocking the Nintendo Wii U/Mayflash GameCube adapter | [![badge](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/gcadapter_oc-kmod/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/gcadapter_oc-kmod) |
| [kvmfr](https://github.com/gnif/looking-glass) | common | KVM framebuffer relay kernel module for use with Looking Glass | [![badge](https://copr.fedorainfracloud.org/coprs/hikariknight/looking-glass-kvmfr/package/kvmfr-kmod/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/hikariknight/looking-glass-kvmfr/package/kvmfr-kmod) |
| [nct6687d](https://github.com/Fred78290/nct6687d) | extra | Linux kernel module for Nuvoton NCT6687-R found on AMD B550 chipset motherboards | [![badge](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/nct6687d-kmod/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/nct6687d-kmod) |
| [nvidia](https://negativo17.org/nvidia-driver/) | nvidia | nvidia GPU drivers | [negativo17 - fedora-nvidia](https://negativo17.org/) |
| [openrazer](https://openrazer.github.io/) | common | kernel module adding additional features to Razer hardware | [![badge](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/openrazer-kmod/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/openrazer-kmod) |
| [rtl8814au](https://github.com/morrownr/8814au) | extra | Realtek RTL8814AU Driver | [![badge](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/rtl8814au-kmod/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/rtl8814au-kmod) |
| [rtl88xxau](https://github.com/aircrack-ng/rtl8812au) | extra | Realtek RTL8812AU/21AU and RTL8814AU driver | [![badge](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/rtl88xxau-kmod/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/rtl88xxau-kmod) |
| [ryzen-smu](https://gitlab.com/leogx9r/ryzen_smu) | extra | A Linux kernel driver that exposes access to the SMU (System Management Unit) for certain AMD Ryzen Processors | [![badge](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/ryzen-smu-kmod/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/ryzen-smu-kmod) |
| [system76](https://github.com/pop-os/system76-dkms) | extra | A Linux kernel driver for System76 laptops | [![badge](https://copr.fedorainfracloud.org/coprs/ssweeny/system76-hwe/package/system76-driver-kmod/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ssweeny/system76-hwe/package/system76-driver-kmod/) |
| [system76-io](https://github.com/pop-os/system76-io-dkms) | extra | A Linux kernel driver for the System76 Io board, which is used in System76's Thelio desktop line | [![badge](https://copr.fedorainfracloud.org/coprs/ssweeny/system76-hwe/package/system76-io-akmod/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ssweeny/system76-hwe/package/system76-io-akmod/) |
| [v4l2loopback](https://github.com/umlaeute/v4l2loopback) | common | allows creating "virtual video devices" | [RPMFusion - free](https://rpmfusion.org/) |
| [wl](https://github.com/rpmfusion/broadcom-wl/) | common | support for some legacy broadcom wifi devices | [RPMFusion - nonfree](https://rpmfusion.org/) |
| [xpadneo](https://github.com/atar-axis/xpadneo) | common | xbox one controller bluetooth driver | [negativo17 - fedora-multimedia](https://negativo17.org/) |
| [xone](https://github.com/BoukeHaarsma23/xonedo/) | common | xbox one controller USB wired/RF driver modified to work along-side xpad | [![badge](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/xone-kmod/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/xone-kmod) |
| [zenergy](https://github.com/BoukeHaarsma23/zenergy) | extra | Based on AMD_ENERGY driver, but with some jiffies added so non-root users can read it safely | [![badge](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/zenergy-kmod/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/package/zenergy-kmod) |
| [zfs](https://github.com/openzfs/zfs) | zfs | OpenZFS advanced file system and volume manager (From Ucore, CoreOS Only) |

## Usage

To install one of these kmods, you'll need to install any of their specific dependencies (checkout the `build-prep.sh` and the specific `build-FOO.sh` script for details), and ensure you are on a compatible kernel.

Using common images as an example, add something like this to your Containerfile, replacing `TAG` with the appropriate tag for the image:

    COPY --from=ghcr.io/ublue-os/akmods:TAG / /tmp/akmods-common
    RUN find /tmp/akmods-common
    ## optionally install remove old and install new kernel
    # dnf -y remove --no-autoremove kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra
    ## install ublue support package and desired kmod(s)
    RUN dnf install /tmp/rpms/ublue-os/ublue-os-akmods*.rpm
    RUN dnf install /tmp/rpms/kmods/kmod-v4l2loopback*.rpm

For NVIDIA images, add something like this to your Containerfile, replacing `TAG` with the appropriate tag for the image:

    COPY --from=ghcr.io/ublue-os/akmods-nvidia:TAG / /tmp/akmods-nvidia
    RUN find /tmp/akmods-nvidia
    ## optionally install remove old and install new kernel
    # dnf -y remove --no-autoremove kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra
    ## install ublue support package and desired kmod(s)
    RUN rpm-ostree install /tmp/rpms/ublue-os/ublue-os-nvidia*.rpm
    RUN rpm-ostree install /tmp/rpms/kmods/kmod-nvidia*.rpm

These examples show:

1. copying all the rpms from the respective akmods images
2. installing the respective ublue specific RPM
3. installing a kmods RPM.

