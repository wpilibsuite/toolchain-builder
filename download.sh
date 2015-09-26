#!/bin/zsh
source versions.sh
THIS_DIR="$PWD"

if [[ `gcc -dumpmachine` == *apple* ]]
then
	echo "Aliasing ar and tar to use GNU variants gar and gtar..."
	alias ar=gar
	alias tar=gtar
fi

# clean up old files
rm -rf repack

wget -nc https://ftp.gnu.org/gnu/gcc/gcc-${V_GCC}/gcc-${V_GCC}.tar.bz2
wget -nc https://ftp.gnu.org/gnu/binutils/binutils-${V_BIN}.tar.bz2
wget -nc https://ftp.gnu.org/gnu/mpfr/mpfr-${V_MPFR}.tar.bz2
wget -nc https://ftp.gnu.org/gnu/mpc/mpc-${V_MPC}.tar.gz
wget -nc https://ftp.gnu.org/gnu/gmp/gmp-${V_GMP}.tar.bz2
wget -nc http://www.bastoul.net/cloog/pages/download/cloog-${V_CLOOG}.tar.gz
wget -nc http://isl.gforge.inria.fr/isl-${V_ISL}.tar.bz2
wget -nc https://ftp.gnu.org/gnu/gdb/gdb-${V_GDB}.tar.gz
wget -nc http://iweb.dl.sourceforge.net/project/expat/expat/${Vw_EXPAT}/expat-${Vw_EXPAT}.tar.gz
wget -nc http://download.ni.com/ni-linux-rt/feeds/2015/arm/ipk/cortexa9-vfpv3/libc6_${Va_LIBC}_cortexa9-vfpv3.ipk
wget -nc http://download.ni.com/ni-linux-rt/feeds/2015/arm/ipk/cortexa9-vfpv3/libc6-dev_${Va_LIBC}_cortexa9-vfpv3.ipk
wget -nc http://download.ni.com/ni-linux-rt/feeds/2015/arm/ipk/cortexa9-vfpv3/linux-libc-headers-dev_${Va_LINUX}_cortexa9-vfpv3.ipk
wget -nc http://download.ni.com/ni-linux-rt/feeds/2015/arm/ipk/cortexa9-vfpv3/libcidn1_${Va_LIBC}_cortexa9-vfpv3.ipk
wget -nc http://download.ni.com/ni-linux-rt/feeds/2015/arm/ipk/cortexa9-vfpv3/libc6-thread-db_${Va_LIBC}_cortexa9-vfpv3.ipk
wget -nc http://download.ni.com/ni-linux-rt/feeds/2015/arm/ipk/cortexa9-vfpv3/libc6-extra-nss_${Va_LIBC}_cortexa9-vfpv3.ipk

mkdir -p repack/{libc6,libc6-dev,linux-libc-headers-dev}/out
mv linux-libc-headers-dev_${Va_LINUX}_cortexa9-vfpv3.ipk repack/linux-libc-headers-dev/
mv libc6_${Va_LIBC}_cortexa9-vfpv3.ipk repack/libc6/
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
	tar cjf "${THIS_DIR}/linux-libc-dev-frc-armel-cross_${Va_LINUX}.orig.tar.bz2" * --owner=0 --group=0
popd
pushd repack/libc6/
	mkdir libc6-${Va_LIBC}
	mv out libc6-${Va_LIBC}/libc6
	mv ../libc6-dev/out libc6-${Va_LIBC}/libc6-dev
	tar cjf "${THIS_DIR}/libc6-frc-armel-cross_${Va_LIBC}.orig.tar.bz2" * --owner=0 --group=0
popd

# Make frcmake tarball
mkdir frcmake-${V_FRCMAKE}
pushd frcmake-${V_FRCMAKE} 
cp ../tools/frcmake frcmake
cp ../tools/frc-cmake-toolchain frc-cmake-toolchain
cp ../tools/toolchain.cmake toolchain.cmake
cp ../tools/frcmake-nix-makefile Makefile
popd
tar cjf frcmake-${V_FRCMAKE}.tar.bz2 frcmake-${V_FRCMAKE}


