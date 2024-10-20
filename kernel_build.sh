export TZ='Asia/Jakarta'
BUILDDATE=$(date +%Y%m%d)
BUILDTIME=$(date +%H%M%S)
KERNEL_DIR='kernel_device_name'
PIXELDRAIN_API_KEY=''

# KernelSU
KERNELSU=1

if [ $KERNELSU = 1 ]; then
  KERNEL_NAME='YourName-Kernel'
  KERNEL_BRANCH='kernelsu'
else
  KERNEL_NAME='YourName-Kernel'
  KERNEL_BRANCH='main'
fi

# cleanup before building
rm -rf AnyKernel3/Image.gz
rm -rf "$KERNEL_DIR"/out/

# set environment variable
export KBUILD_BUILD_USER=user
export KBUILD_BUILD_HOST=host
# PATH="/path/to/clang-llvm/bin:${PATH}"

# Install dependencies
sudo apt update && sudo apt install -y bc cpio nano bison ca-certificates curl flex gcc git libc6-dev libssl-dev openssl python-is-python3 ssh wget zip zstd sudo make clang gcc-arm-linux-gnueabi software-properties-common build-essential libarchive-tools gcc-aarch64-linux-gnu

# clone clang and gcc
# ===================
# AOSP clang
#wget https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/heads/android14-release/clang-r487747c.tar.gz -O "clang-r487747c.tar.gz"
#mkdir clang-llvm && tar -xf clang-r487747c.tar.gz -C clang-llvm && rm -rf clang-r487747c.tar.gz
# ===================
# WeebX Clang
#wget "$(curl -s https://raw.githubusercontent.com/XSans0/WeebX-Clang/main/main/link.txt)" -O "weebx-clang.tar.gz"
#mkdir clang-llvm && tar -xf weebx-clang.tar.gz -C clang-llvm && rm -rf weebx-clang.tar.gz

# Build
cd "$KERNEL_DIR"
# Branch checkout
git checkout "$KERNEL_BRANCH"
git pull --rebase
# Prepare
make -j$(nproc --all) O=out ARCH=arm64 CC=clang CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-gnu- vendor/fog-perf_defconfig
# Execute
make -j$(nproc --all) O=out ARCH=arm64 CC=clang CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-gnu-

# Package
cd ..
git clone --depth=1 https://github.com/alternoegraha/AnyKernel3-680 -b master AnyKernel3
cp -R "$KERNEL_DIR"/out/arch/arm64/boot/Image.gz AnyKernel3/Image.gz
# Zip it and upload to pixeldrain
cd AnyKernel3
zip -r9 "$KERNEL_NAME"-"$BUILDDATE"-"$BUILDTIME" . -x ".git*" -x "README.md" -x "*.zip"
# curl -T "$KERNEL_NAME"-"$BUILDDATE"-"$BUILDTIME".zip -u :"$PIXELDRAIN_API_KEY" https://pixeldrain.com/api/file/
# finish
cd ..
# rm -rf "$KERNEL_DIR"/out/
echo "Build finished"
