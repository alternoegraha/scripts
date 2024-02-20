#!/bin/bash

set -e
#Credit to Meghthedev for the initial script 

# init
repo init --depth 1 -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs

# Run inside foss.crave.io devspace
# Remove existing local_manifests
crave run --projectID=72 --clean --no-patch -- "rm -rf .repo .repo/local_manifests android art bionic bootable build cts dalvik developers development device external frameworks hardware kernel libcore libnativehelper lineage-sdk packages pdk platform platform_testing prebuilts sdk system test toolchain tools vendor && \

# init PixelOS
repo init --depth=1 -u https://github.com/PixelOS-AOSP/manifest.git -b fourteen --git-lfs && \

# sync repo
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags && \ 

# sync tree
git clone -b fourteen-oss https://github.com/alternoegraha/device_xiaomi_fog device/xiaomi/fog && \

# clone hardware/xiaomi
git clone https://github.com/PixelOS-AOSP/hardware_xiaomi hardware/xiaomi && \

# Set up build environment
source build/envsetup.sh && \

# Lunch configuration
lunch aosp_fog-userdebug && \

# Build the ROM
mka bacon"

# Pull generated zip files
crave pull out/target/product/*/*.zip
