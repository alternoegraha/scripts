#!/bin/bash

set -e
#Credit to Meghthedev for the initial script 

# init
repo init --depth 1 -u https://github.com/DerpFest-AOSP/manifest.git -b 13

# Run inside foss.crave.io devspace
# Remove existing local_manifests
crave run --no-patch --projectID=72 -- "rm -rf .repo .repo/local_manifests android art bionic bootable build cts dalvik developers development device external frameworks hardware kernel libcore libnativehelper lineage-sdk packages pdk platform platform_testing prebuilts sdk system test toolchain tools vendor && \

# set timezone
export TZ='Asia/Jakarta' && \

# init EvoX
repo init --depth=1 -u https://github.com/DerpFest-AOSP/manifest.git -b 14 && \

# sync repo
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags && \ 

# sync tree
git clone -b derpfest-14 https://github.com/alternoegraha/device_xiaomi_fog device/xiaomi/fog && \

# Set up build environment
source build/envsetup.sh && \

# Lunch configuration
lunch derp_fog-userdebug && \

# Build the ROM
m derp"

# Pull generated zip files
crave pull out/target/product/*/*.zip --projectID=72
