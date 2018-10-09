#!/bin/zsh
source versions.sh

THIS_DIR="$PWD"

# clean up old files
rm -rf repack

if [[ `gcc -dumpmachine` == *apple* ]]
then
	echo "Aliasing ar and tar to use GNU variants gar and gtar..."
	alias ar=gar
	alias tar=gtar
fi

mkdir -p repack/{libc6,libc6-dev,linux-libc-headers-dev,libgcc1,libgcc-dev,libstdc\+\+6,libstdc\+\+6-dev}/out
mv linux-libc-headers-dev_${Va_LINUX}_cortexa9-vfpv3.ipk repack/linux-libc-headers-dev/
mv libc6_${Va_LIBC}_cortexa9-vfpv3.ipk repack/libc6/
mv libgcc1_${Va_LIBGCC}_cortexa9-vfpv3.ipk repack/libgcc1/
mv \
    libgcc-s-dbg_${Va_LIBGCC}_cortexa9-vfpv3.ipk \
    libgcc-s-dev_${Va_LIBGCC}_cortexa9-vfpv3.ipk \
    repack/libgcc-dev/
mv \
    libstdc++6_${Va_LIBSTDCPP}_cortexa9-vfpv3.ipk \
    libatomic1_${Va_LIBSTDCPP}_cortexa9-vfpv3.ipk \
    libgomp1_${Va_LIBSTDCPP}_cortexa9-vfpv3.ipk \
    libitm1_${Va_LIBSTDCPP}_cortexa9-vfpv3.ipk \
    libssp0_${Va_LIBSTDCPP}_cortexa9-vfpv3.ipk \
    repack/libstdc++6/
mv \
    libstdc++-dev_${Va_LIBSTDCPP}_cortexa9-vfpv3.ipk \
    libatomic-dev_${Va_LIBSTDCPP}_cortexa9-vfpv3.ipk \
    libgomp-dev_${Va_LIBSTDCPP}_cortexa9-vfpv3.ipk \
    libitm-dev_${Va_LIBSTDCPP}_cortexa9-vfpv3.ipk \
    libssp-dev_${Va_LIBSTDCPP}_cortexa9-vfpv3.ipk \
    gcc-runtime-dbg_${Va_LIBSTDCPP}_cortexa9-vfpv3.ipk \
    repack/libstdc++6-dev/
# the rest are in libc6-dev
mv *.ipk repack/libc6-dev/

for dir in libc6 libc6-dev linux-libc-headers-dev libgcc1 libgcc-dev libstdc\+\+6 libstdc\+\+6-dev; do
	pushd repack/$dir
		for file in *.ipk; do
			ar x $file
			
			# don't need these
			rm control.tar.gz debian-binary
			pushd out
				tar xf ../data.tar.gz
			popd
			# clean up
			rm data.tar.gz
			mv $file "$THIS_DIR/"
		done
	popd
done

# ick... these are everywhere. remove them
find repack \( -name .install -o -name ..install.cmd \) -delete
# we don't need arm binaries...
rm repack/libc6/out/sbin/ldconfig
rm repack/libc6/out/etc/ld.so.conf
rm -rf repack/libc6-dev/out/sbin
rm -rf repack/libc6-dev/out/usr/bin
rm -rf repack/libc6-dev/out/usr/sbin
rm -rf repack/libc6-dev/out/usr/libexec
# remove all empty dirs (semi-recursive)
rm -d repack/**/*(/^F)
#rm -d repack/**/*(/^F)
#rm -d repack/**/*(/^F)
# move the arm-nilrt libs to arm-frcYEAR
mv repack/libgcc-dev/out/usr/lib/arm-nilrt-linux-gnueabi repack/libgcc-dev/out/usr/lib/arm-frc${V_YEAR}-linux-gnueabi
# copy the arm-nilrt headers to arm-frcYEAR
# (we copy instead of move so gdb can find the originals)
cp -Rp repack/libc6-dev/out/usr/lib/gcc/arm-nilrt-linux-gnueabi repack/libc6-dev/out/usr/lib/gcc/arm-frc${V_YEAR}-linux-gnueabi
cp -Rp repack/libstdc++6-dev/out/usr/include/c++/6.3.0/arm-nilrt-linux-gnueabi repack/libstdc++6-dev/out/usr/include/c++/6.3.0/arm-frc${V_YEAR}-linux-gnueabi

pushd repack/linux-libc-headers-dev/
	mv out linux-libc-${Va_LINUX}
	tar cjf "${THIS_DIR}/linux-libc-dev-frc${V_YEAR}-armel-cross_${Va_LINUX}.orig.tar.bz2" * --owner=0 --group=0
popd
pushd repack/libc6/
	mkdir libc6-${Va_LIBC}
	mv out libc6-${Va_LIBC}/libc6
	mv ../libc6-dev/out libc6-${Va_LIBC}/libc6-dev
	tar cjf "${THIS_DIR}/libc6-frc${V_YEAR}-armel-cross_${Va_LIBC}.orig.tar.bz2" * --owner=0 --group=0
popd
pushd repack/libgcc1/
	mkdir libgcc1-${Va_LIBGCC}
	mv out libgcc1-${Va_LIBGCC}/libgcc1
	mv ../libgcc-dev/out libgcc1-${Va_LIBGCC}/libgcc-dev
	tar cjf "${THIS_DIR}/libgcc1-frc${V_YEAR}-armel-cross_${Va_LIBGCC}.orig.tar.bz2" * --owner=0 --group=0
popd
pushd repack/libstdc++6/
	mkdir libstdc++6-${Va_LIBSTDCPP}
	mv out libstdc++6-${Va_LIBSTDCPP}/libstdc++6
	mv ../libstdc++6-dev/out libstdc++6-${Va_LIBSTDCPP}/libstdc++6-dev
	tar cjf "${THIS_DIR}/libstdc++6-frc${V_YEAR}-armel-cross_${Va_LIBSTDCPP}.orig.tar.bz2" * --owner=0 --group=0
popd

# Make frcmake tarball
rm -rf frcmake${V_YEAR}-${V_FRCMAKE}
mkdir frcmake${V_YEAR}-${V_FRCMAKE}
pushd frcmake${V_YEAR}-${V_FRCMAKE} 
sed -e "s/frc/frc${V_YEAR}/g" ../tools/frcmake > frcmake${V_YEAR}
chmod a+x frcmake${V_YEAR}
sed -e "s/frc/frc${V_YEAR}/g" ../tools/frc-cmake-toolchain > frc${V_YEAR}-cmake-toolchain
chmod a+x frc${V_YEAR}-cmake-toolchain
sed -e "s/frc/frc${V_YEAR}/g" ../tools/toolchain.cmake > toolchain.cmake
sed -e "s/frc/frc${V_YEAR}/g" -e "s/frc2019make/frcmake2019/g" ../tools/frcmake-nix-makefile > Makefile
popd
tar cjf frcmake${V_YEAR}-${V_FRCMAKE}.tar.bz2 frcmake${V_YEAR}-${V_FRCMAKE}
