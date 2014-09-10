#!/bin/zsh

V_GCC=4.9.1
V_BIN=2.24
V_MPFR=3.1.2
V_MPC=1.0.2
V_GMP=6.0.0a
V_GMPf=6.0.0
V_CLOOG=0.18.1
V_ISL=0.12.2
V_GDB=7.8
Va_LIBC=2.17-r4
Va_LINUX=3.8-r0
THIS_DIR="$PWD"

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
wget -nc http://download.ni.com/ni-linux-rt/feeds/2014/arm/armv7a-vfp-neon/libc6_${Va_LIBC}_armv7a-vfp-neon.ipk
wget -nc http://download.ni.com/ni-linux-rt/feeds/2014/arm/armv7a-vfp-neon/libc6-dev_${Va_LIBC}_armv7a-vfp-neon.ipk
wget -nc http://download.ni.com/ni-linux-rt/feeds/2014/arm/armv7a-vfp-neon/linux-libc-headers-dev_${Va_LINUX}_armv7a-vfp-neon.ipk
wget -nc http://download.ni.com/ni-linux-rt/feeds/2014/arm/armv7a-vfp-neon/libcidn1_${Va_LIBC}_armv7a-vfp-neon.ipk
wget -nc http://download.ni.com/ni-linux-rt/feeds/2014/arm/armv7a-vfp-neon/libthread-db1_${Va_LIBC}_armv7a-vfp-neon.ipk
wget -nc http://download.ni.com/ni-linux-rt/feeds/2014/arm/armv7a-vfp-neon/eglibc-extra-nss_${Va_LIBC}_armv7a-vfp-neon.ipk

mkdir -p repack/{libc6,libc6-dev,linux-libc-headers-dev}/out
mv linux-libc-headers-dev_${Va_LINUX}_armv7a-vfp-neon.ipk repack/linux-libc-headers-dev/
mv libc6_${Va_LIBC}_armv7a-vfp-neon.ipk repack/libc6/
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

# we don't need arm binaries...
rm repack/libc6/out/usr/lib/eglibc/pt_chown
rm repack/libc6/out/sbin/ldconfig
rm repack/libc6/out/etc/ld.so.conf

for dir in libc6 libc6-dev linux-libc-headers-dev; do
	pushd repack/$dir/out
	tar cjf ../${dir}_${Va_LIBC}.orig.tar.bz2 . --owner=0 --group=0
	mv ../${dir}_${Va_LIBC}.orig.tar.bz2 "$THIS_DIR/"
	popd
done

mv linux-libc-headers-dev_${Va_LIBC}.orig.tar.bz2 linux-libc-dev-frc-armel-cross_${Va_LINUX}.orig.tar.bz2
mv libc6_${Va_LIBC}.orig.tar.bz2 libc6-frc-armel-cross_${Va_LIBC}.orig.tar.bz2
mv libc6-dev_${Va_LIBC}.orig.tar.bz2 libc6-dev-frc-armel-cross_${Va_LIBC}.orig.tar.bz2


# --owner=0 --group=0
