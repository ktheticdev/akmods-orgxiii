#!/bin/sh

set -oeux pipefail


ARCH="$(rpm -E '%_arch')"
KERNEL="$(rpm -q kernel-cachyos-lto --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"
RELEASE="$(rpm -E '%fedora')"

COPR_RELEASE="${RELEASE}"

curl -LsSf -o /etc/yum.repos.d/_copr_rok-cdemu.repo "https://copr.fedorainfracloud.org/coprs/rok/cdemu/repo/fedora-${COPR_RELEASE}/rok-cdemu-fedora-${COPR_RELEASE}.repo"

### BUILD vhba (succeed or fail-fast with debug output)
dnf install -y \
    akmod-vhba-*.fc${RELEASE}.${ARCH}
env CC=clang HOSTCC=clang CXX=clang++ LD=ld.lld LLVM=1 LLVM_IAS=1 akmods --force --kernels "${KERNEL}" --kmod vhba
modinfo /usr/lib/modules/${KERNEL}/extra/vhba/vhba.ko.xz > /dev/null \
|| (find /var/cache/akmods/vhba/ -name \*.log -print -exec cat {} \; && exit 1)

rm -f /etc/yum.repos.d/_copr_rok-cdemu.repo
