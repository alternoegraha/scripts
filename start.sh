#!/bin/bash

set -e
#Credit to Meghthedev for the initial script 

# init
repo init --depth 1 -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs

# Run inside foss.crave.io devspace
# Remove existing local_manifests
crave run --clean --no-patch --projectID=72 -- "rm -rf .repo .repo/local_manifests android art bionic bootable build cts dalvik developers development device external frameworks hardware kernel libcore libnativehelper lineage-sdk packages pdk platform platform_testing prebuilts sdk system test toolchain tools vendor && \

# set timezone
export TZ='Asia/Jakarta' && \

# init EvoX
repo init --depth=1 -u https://github.com/Evolution-X/manifest -b udc && \

# sync repo
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags && \ 

# sync tree
git clone -b evox-14 https://github.com/alternoegraha/device_xiaomi_fog device/xiaomi/fog && \

# Set up build environment
source build/envsetup.sh && \

# Lunch configuration
lunch evolution_fog-userdebug && \

# Build the ROM
m evolution"

# Pull generated zip files
crave pull out/target/product/*/*.zip --projectID=72
