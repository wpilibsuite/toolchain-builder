V_GCC=4.9.1
V_BIN=2.24
V_MPFR=3.1.2
V_MPC=1.0.2
V_GMP=6.0.0a
V_GMPf=6.0.0
V_CLOOG=0.18.1
V_ISL=0.12.2
V_GDB=7.8

wget -nc https://ftp.gnu.org/gnu/gcc/gcc-${V_GCC}/gcc-${V_GCC}.tar.bz2
wget -nc https://ftp.gnu.org/gnu/binutils/binutils-${V_BIN}.tar.bz2
wget -nc https://ftp.gnu.org/gnu/mpfr/mpfr-${V_MPFR}.tar.bz2
wget -nc https://ftp.gnu.org/gnu/mpc/mpc-${V_MPC}.tar.gz
wget -nc https://ftp.gnu.org/gnu/gmp/gmp-${V_GMP}.tar.bz2
wget -nc http://www.bastoul.net/cloog/pages/download/cloog-${V_CLOOG}.tar.gz
wget -nc http://isl.gforge.inria.fr/isl-${V_ISL}.tar.bz2
wget -nc https://ftp.gnu.org/gnu/gdb/gdb-${V_GDB}.tar.gz
echo "Cleaning up.."
