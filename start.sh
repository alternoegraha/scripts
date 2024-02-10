#!/bin/bash

set -e
#Credit to Meghthedev for the initial script 

# init
repo init -u https://github.com/ArrowOS/android_manifest.git -b arrow-13.1

# Run inside foss.crave.io devspace
# Remove existing local_manifests
crave run --clean --no-patch -- "rm -rf * .repo && \

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
