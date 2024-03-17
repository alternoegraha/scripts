#!/bin/bash

set -e
#Credit to Meghthedev for the initial script 

# init
repo init --depth 1 -u https://github.com/ArrowOS/android_manifest.git -b arrow-13.1

# Run inside foss.crave.io devspace
# Remove existing local_manifests
crave run --no-patch --projectID=73 -- "rm -rf device vendor kernel && \

# set timezone
export TZ='Asia/Jakarta' && \

# sync repo
repo sync -c -j\$(nproc --all) --force-sync --no-clone-bundle --no-tags && \ 

# sync tree
git clone -b pixel-14 https://github.com/alternoegraha/device_xiaomi_fog device/xiaomi/fog && \

# Set up build environment
source build/envsetup.sh && \

# Lunch configuration
lunch aosp_fog-userdebug && \

# Build the ROM
m bacon -j\$(nproc --all)"

# Pull generated zip files
crave pull out/target/product/*/*.zip --projectID=73
