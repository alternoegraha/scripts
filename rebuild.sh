#!/bin/bash

set -e
#Credit to Meghthedev for the initial script 

# init
repo init --depth 1 -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs

# Run inside foss.crave.io devspace
# Remove existing local_manifests
crave run --no-patch --projectID=72 -- "rm -rf device vendor kernel && \

# set timezone
export TZ='Asia/Jakarta' && \

# re-sync repo
repo sync -c -j\$(nproc --all) --force-sync --no-clone-bundle --no-tags && \ 

# sync tree
git clone -b lineage-21-gapps https://github.com/alternoegraha/device_xiaomi_fog device/xiaomi/fog && \

# Set up build environment
source build/envsetup.sh && \
export WITH_GMS=true && \

# Lunch configuration
lunch lineage_fog-ap1a-userdebug && \

# Build the ROM
mka bacon -j\$(nproc --all)"

# Pull generated zip files
crave pull out/target/product/*/*.zip --projectID=72
