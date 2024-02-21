#!/bin/bash

set -e
#Credit to Meghthedev for the initial script 

# init
repo init --depth 1 -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs

# Run inside foss.crave.io devspace
# Remove existing local_manifests
crave run --no-patch -- "rm -rf .repo/local_manifests && \

# re-sync repo
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags && \ 

# fetch dt commits
cd device/xiaomi/fog && \
git fetch && \
git pull --rebase && \
cd ../../.. && \

# fetch kernel commits
cd kernel/xiaomi/fog && \
git fetch && \
git pull --rebase && \
cd ../../.. && \

# Set up build environment
source build/envsetup.sh && \

# Lunch configuration
lunch lineage_fog-userdebug && \

# Build the ROM
mka bacon"

# Pull generated zip files
crave pull out/target/product/*/*.zip
