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

mkdir -p repack/{libc6,libc6-dev,linux-libc-headers-dev}/out
mv linux-libc-headers-dev_${Va_LINUX_ORIG}_cortexa9-vfpv3.ipk repack/linux-libc-headers-dev/
mv libc6_${Va_LIBC_ORIG}_cortexa9-vfpv3.ipk repack/libc6/
# the rest are in dev
mv *.ipk repack/libc6-dev/

for dir in libc6 libc6-dev linux-libc-headers-dev; do
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
# remove all empty dirs (semi-recursive)
rm -d repack/**/*(/^F)
#rm -d repack/**/*(/^F)
#rm -d repack/**/*(/^F)

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

# Make frcmake tarball
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
