#!/bin/sh

set -oeux pipefail


ARCH="$(rpm -E '%_arch')"
KERNEL="$(rpm -q "${KERNEL_NAME}" --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"
RELEASE="$(rpm -E '%fedora')"

COPR_RELEASE="${RELEASE}"

curl -LsSf -o /etc/yum.repos.d/_copr_asan-acer-modules.repo "https://copr.fedorainfracloud.org/coprs/asan/acer-modules/repo/fedora-${COPR_RELEASE}/asan-acer-modules-fedora-${COPR_RELEASE}.repo"

### BUILD acer-wmi-battery (succeed or fail-fast with debug output)
dnf install -y \
    akmod-acer-wmi-battery-*.fc${RELEASE}.${ARCH}
akmods --force --kernels "${KERNEL}" --kmod acer-wmi-battery
modinfo /usr/lib/modules/${KERNEL}/extra/acer-wmi-battery/acer-wmi-battery.ko.xz > /dev/null \
|| (find /var/cache/akmods/acer-wmi-battery/ -name \*.log -print -exec cat {} \; && exit 1)

rm -f /etc/yum.repos.d/_copr_asan-acer-modules.repo
