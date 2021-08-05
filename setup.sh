#!/bin/bash
cd ~
git clone https://github.com/TheSanty/kernel_xiaomi_msm8953.git
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9
mkdir clang
cd clang 
wget https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/tags/android-11.0.0_r40/clang-r383902b1.tar.gz
tar xvf clang-r383902b1.tar.gz
cd ..
cd kernel_xiaomi_msm8953/
export ARCH=arm64 && export SUBARCH=arm64
make O=out ARCH=arm64 sakura_defconfig
PATH="$HOME/clang/bin:$HOME/aarch64-linux-android-4.9/bin:$HOME/arm-linux-androideabi-4.9/bin:${PATH}" \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android- \
                      CROSS_COMPILE_ARM32=arm-linux-androideabi-
cd ../
git clone https://github.com/TheSanty/AnyKernel3.git
cp $(pwd)/kernel_xiaomi_msm8953/out/arch/arm64/boot/Image.gz-dtb $(pwd)/AnyKernel3
mkdir releases
cd AnyKernel3
zip -r9 Rename-Sakura-V4.zip *
cd ../
mv $(pwd)/AnyKernel3/Rename-Sakura-V4.zip $(pwd)/releases
curl -F chat_id="-1001377058531" \
		 -F caption="$(sha1sum $(pwd)/releases/Rename-Sakura-V4.zip | awk '{ print $1 }')" \
                 -F document=@"$(pwd)/releases/Rename-Sakura-V4.zip" \
                  https://api.telegram.org/bot1834871407:AAGO4do-QGZxF46ibzPshG_pec5SniEk3T4/sendDocument
rm -rf kernel_xiaomi_msm8953
rm -rf AnyKernel3
git clone https://github.com/TheSanty/kernel_xiaomi_msm8953.git
cd kernel_xiaomi_msm8953/
export ARCH=arm64 && export SUBARCH=arm64
make O=out ARCH=arm64 daisy_defconfig
PATH="$HOME/clang/bin:$HOME/aarch64-linux-android-4.9/bin:$HOME/arm-linux-androideabi-4.9/bin:${PATH}" \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android- \
                      CROSS_COMPILE_ARM32=arm-linux-androideabi-
cd ../
git clone https://github.com/TheSanty/AnyKernel3.git
cp $(pwd)/kernel_xiaomi_msm8953/out/arch/arm64/boot/Image.gz-dtb $(pwd)/AnyKernel3
cd AnyKernel3
zip -r9 Rename-Daisy-V4.zip *
cd ../
mv $(pwd)/AnyKernel3/Rename-Daisy-V4.zip $(pwd)/releases
curl -F chat_id="-1001377058531" \
		 -F caption="$(sha1sum $(pwd)/releases/Rename-Daisy-V4.zip | awk '{ print $1 }')" \
                 -F document=@"$(pwd)/releases/Rename-Daisy-V4.zip" \
                  https://api.telegram.org/bot1834871407:AAGO4do-QGZxF46ibzPshG_pec5SniEk3T4/sendDocument
		    
