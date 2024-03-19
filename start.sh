#!/bin/bash

set -e
#Credit to Meghthedev for the initial script 

# init
repo init --depth 1 -u https://github.com/DerpFest-AOSP/manifest.git -b 13

# Run inside foss.crave.io devspace
# Remove existing local_manifests
crave run --no-patch --projectID=64 -- "rm -rf .repo .repo/local_manifests prebuilts && \

# set timezone
export TZ='Asia/Jakarta' && \

# init EvoX
repo init --depth=1 -u https://github.com/Evolution-X/manifest -b udc && \

# sync repo
repo sync -c -j\$(nproc --all) --force-sync --prune --no-clone-bundle --no-tags && \ 

# sync tree
git clone -b evox-14 https://github.com/alternoegraha/device_xiaomi_fog device/xiaomi/fog && \

# Set up build environment
source build/envsetup.sh && \

# Lunch configuration
lunch evolution_fog-eng && \

# Build the ROM
m evolution -j\$(nproc --all)"

# Pull generated zip files
crave pull out/target/product/*/*.zip --projectID=64
