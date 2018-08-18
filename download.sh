#!/bin/zsh
source versions.sh

wget -nc \
    https://ftp.gnu.org/gnu/gcc/gcc-${V_GCC}/gcc-${V_GCC}.tar.xz \
    https://ftp.gnu.org/gnu/binutils/binutils-${V_BIN}.tar.bz2 \
    https://ftp.gnu.org/gnu/mpfr/mpfr-${V_MPFR}.tar.bz2 \
    https://ftp.gnu.org/gnu/mpc/mpc-${V_MPC}.tar.gz \
    https://ftp.gnu.org/gnu/gmp/gmp-${V_GMP}.tar.bz2 \
    http://www.bastoul.net/cloog/pages/download/cloog-${V_CLOOG}.tar.gz \
    http://isl.gforge.inria.fr/isl-${V_ISL}.tar.bz2 \
    https://ftp.gnu.org/gnu/gdb/gdb-${V_GDB}.tar.gz \
    https://sourceforge.net/projects/expat/files/expat/${Vw_EXPAT}/expat-${Vw_EXPAT}.tar.gz \
    http://download.ni.com/ni-linux-rt/feeds/2017/arm/ipk/cortexa9-vfpv3/libc6_${Va_LIBC}_cortexa9-vfpv3.ipk \
    http://download.ni.com/ni-linux-rt/feeds/2017/arm/ipk/cortexa9-vfpv3/libc6-dev_${Va_LIBC}_cortexa9-vfpv3.ipk \
    http://download.ni.com/ni-linux-rt/feeds/2017/arm/ipk/cortexa9-vfpv3/linux-libc-headers-dev_${Va_LINUX}_cortexa9-vfpv3.ipk \
    http://download.ni.com/ni-linux-rt/feeds/2017/arm/ipk/cortexa9-vfpv3/libcidn1_${Va_LIBC}_cortexa9-vfpv3.ipk \
    http://download.ni.com/ni-linux-rt/feeds/2017/arm/ipk/cortexa9-vfpv3/libc6-thread-db_${Va_LIBC}_cortexa9-vfpv3.ipk \
    http://download.ni.com/ni-linux-rt/feeds/2017/arm/ipk/cortexa9-vfpv3/libc6-extra-nss_${Va_LIBC}_cortexa9-vfpv3.ipk
