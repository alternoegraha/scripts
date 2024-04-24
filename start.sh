#!/bin/bash

set -e
#Credit to Meghthedev for the initial script 

# init
repo init --depth 1 -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs

# Run inside foss.crave.io devspace
# Remove existing local_manifests
crave run --no-patch --projectID=72 -- "rm -rf .repo .repo/local_manifests prebuilts && \

# set timezone
export TZ='Asia/Jakarta' && \

# init EvoX
repo init --depth=1 -u https://github.com/Evolution-XYZ/manifest -b udc && \

# sync repo
bash /opt/crave/resync.sh && \

# sync tree
git clone -b evox-yz https://github.com/alternoegraha/device_xiaomi_fog device/xiaomi/fog && \

# Set up build environment
source build/envsetup.sh && \

# Lunch configuration
lunch lineage_fog-userdebug && \

# Build the ROM
m evolution -j\$(nproc --all)"

# Pull generated zip files
crave pull out/target/product/*/*.zip --projectID=72
