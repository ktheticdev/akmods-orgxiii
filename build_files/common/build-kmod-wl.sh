#!/bin/sh

set -oeux pipefail


ARCH="$(rpm -E '%_arch')"
KERNEL="$(rpm -q kernel-cachyos-lto --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"
RELEASE="$(rpm -E '%fedora')"


### BUILD wl (succeed or fail-fast with debug output)
dnf install -y \
    akmod-wl-*.fc${RELEASE}.${ARCH}
env CC=clang HOSTCC=clang CXX=clang++ LD=ld.lld LLVM=1 LLVM_IAS=1 CFLAGS="-Wno-error=date-time" akmods --force --kernels "${KERNEL}" --kmod wl
modinfo /usr/lib/modules/${KERNEL}/extra/wl/wl.ko.xz > /dev/null \
|| (find /var/cache/akmods/wl/ -name \*.log -print -exec cat {} \; && exit 1)
