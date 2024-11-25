#!/bin/bash
set -e

crave run --no-patch -- "rm -rf .repo .repo/local_manifests && \

# init LOS22
repo init --depth=1 -u https://github.com/LineageOS/android -b lineage-22.0 && \

# sync + fixup repo
bash /opt/crave/resync.sh && \

# clone device tree
git clone -b lineage-22 https://github.com/alternoegraha/device_xiaomi_fog device/xiaomi/fog && \
git clone -b lineage-21 https://github.com/alternoegraha/keys vendor/lineage-priv/keys && \

# Set up build environment
source build/envsetup.sh && \

# Lunch configuration
breakfast fog userdebug && \

# Build the ROM
mka bacon"

# Pull generated zip files
crave pull out/target/product/fog/*.zip
