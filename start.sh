#!/bin/bash
set -e
# Run inside foss.crave.io devspace
crave run --no-patch -- "rm -rf .repo/local_manifests && \

# set timezone
export TZ='Asia/Jakarta' && \

# sync repo
/opt/crave/resync.sh && \

# sync tree
git clone -b fourteen-qpr2 https://github.com/alternoegraha/device_xiaomi_fog device/xiaomi/fog && \

# Set up
export BUILD_USERNAME=alternoegraha && \
export BUILD_HOSTNAME=nurture && \
source build/envsetup.sh && \

# Lunch configuration
lunch aosp_fog-ap1a-userdebug && \

# Build
mka bacon -j\$(nproc --all)"
