#!/bin/bash
set -e

crave run --no-patch -- "rm -rf .repo/local_manifests && \

# remove my tree first so they can reclone
rm -rf device/xiaomi/fog && \

# clone local manifests
git clone https://github.com/alternoegraha/local_manifest.git .repo/local_manifests && \

# resync repo
repo sync -c -j20 --force-sync --no-clone-bundle --no-tags && \ 

# Set up build environment
source build/envsetup.sh && \

# Lunch configuration
breakfast fog userdebug && \

# Build the ROM
mka bacon"

# Pull generated zip files
crave pull out/target/product/fog/*.zip
