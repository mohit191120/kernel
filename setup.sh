#!/bin/bash
cd ~
git clone https://github.com/TheSanty/kernel_xiaomi_msm8953.git
git clone https://github.com/arter97/arm64-gcc.git -b master --depth=3 gcc
git clone https://github.com/arter97/arm32-gcc.git -b master --depth=3 gcc32
cd gcc
git checkout cd9eb72bace3b4d682d5251a9eb4829bdd0ec2ca
cd ../gcc32
git checkout b788b457799d68553f51a00a5dd4a1d0ea6b0558
cd ..
cd kernel_xiaomi_msm8953/
make -j$(nproc) O=out ARCH=arm64 sakura_defconfig	    
make -j$(nproc) ARCH=arm64 O=out \
	CROSS_COMPILE=$HOME/gcc/bin/aarch64-elf- \
	CROSS_COMPILE_ARM32=$HOME/gcc32/bin/arm-eabi-
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
make -j$(nproc) O=out ARCH=arm64 daisy_defconfig	    
make -j$(nproc) ARCH=arm64 O=out \
	CROSS_COMPILE=$HOME/gcc/bin/aarch64-elf- \
	CROSS_COMPILE_ARM32=$HOME/gcc32/bin/arm-eabi-
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
		    
