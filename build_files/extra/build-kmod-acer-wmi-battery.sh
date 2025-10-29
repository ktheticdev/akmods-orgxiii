#!/bin/sh

set -oeux pipefail


ARCH="$(rpm -E '%_arch')"
KERNEL="$(rpm -q kernel-cachyos-lto --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"
RELEASE="$(rpm -E '%fedora')"

if [[ "${RELEASE}" -ge 42 ]]; then
    COPR_RELEASE="rawhide"
else
    COPR_RELEASE="${RELEASE}"
fi

curl -LsSf -o /etc/yum.repos.d/_copr_asan-acer-modules.repo "https://copr.fedorainfracloud.org/coprs/asan/acer-modules/repo/fedora-${COPR_RELEASE}/asan-acer-modules-fedora-${COPR_RELEASE}.repo"

### BUILD acer-wmi-battery (succeed or fail-fast with debug output)
dnf install -y \
    akmod-acer-wmi-battery-*.fc${COPR_RELEASE}.${ARCH}
env CC=clang HOSTCC=clang CXX=clang++ LD=ld.lld LLVM=1 LLVM_IAS=1 akmods --force --kernels "${KERNEL}" --kmod acer-wmi-battery
modinfo /usr/lib/modules/${KERNEL}/extra/acer-wmi-battery/acer-wmi-battery.ko.xz > /dev/null \
|| (find /var/cache/akmods/acer-wmi-battery/ -name \*.log -print -exec cat {} \; && exit 1)

rm -f /etc/yum.repos.d/_copr_asan-acer-modules.repo
