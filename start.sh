#!/bin/bash

set -e
#Credit to Meghthedev for the initial script 

# init
repo init --depth 1 -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs

# Run inside foss.crave.io devspace
# Remove existing local_manifests
crave run --no-patch --projectID=72 -- "rm -rf .repo .repo/local_manifests android art bionic bootable build cts dalvik developers development device external frameworks hardware kernel libcore libnativehelper lineage-sdk packages pdk platform platform_testing prebuilts sdk system test toolchain tools vendor && \

# set timezone
export TZ='Asia/Jakarta' && \

# init PixelOS
repo init --depth=1 -u https://github.com/PixelOS-AOSP/manifest.git -b fourteen --git-lfs && \

# sync repo
repo sync -c -j\$(nproc --all) --force-sync --no-clone-bundle --no-tags --prune && \ 

# sync tree
git clone -b fourteen-qpr2 https://github.com/alternoegraha/device_xiaomi_fog device/xiaomi/fog && \

# Set up build environment
source build/envsetup.sh && \

# Lunch configuration
lunch aosp_fog-ap1a-userdebug && \

# Build the ROM
mka bacon -j\$(nproc --all)"

# Pull generated zip files
crave pull out/target/product/*/*.zip --projectID=72
