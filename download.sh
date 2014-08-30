V_GCC=4.9.1
V_BIN=2.24
V_MPFR=3.1.2
V_MPC=1.0.2
V_GMP=6.0.0a
V_GMPf=6.0.0
V_CLOOG=0.18.1
V_ISL=0.13
V_GDB=7.8

wget -nc https://ftp.gnu.org/gnu/gcc/gcc-${V_GCC}/gcc-${V_GCC}.tar.bz2
wget -nc https://ftp.gnu.org/gnu/binutils/binutils-${V_BIN}.tar.bz2
wget -nc https://ftp.gnu.org/gnu/mpfr/mpfr-${V_MPFR}.tar.bz2
wget -nc https://ftp.gnu.org/gnu/mpc/mpc-${V_MPC}.tar.gz
wget -nc https://ftp.gnu.org/gnu/gmp/gmp-${V_GMP}.tar.bz2
wget -nc http://www.bastoul.net/cloog/pages/download/cloog-${V_CLOOG}.tar.gz
wget -nc http://isl.gforge.inria.fr/isl-${V_ISL}.tar.bz2
wget -nc https://ftp.gnu.org/gnu/gdb/gdb-${V_GDB}.tar.gz
echo "Cleaning up..."
rm -rf gcc-${V_GCC} gdb-${V_GDB} binutils-${V_binutils} cloog-${V_CLOOG} isl-${V_ISL} mpfr-${V_MPFR} mpc-${V_MPC} gmp-${V_GMP}
echo "Extracting GCC..."
tar xf gcc-${V_GCC}.tar.bz2
echo "Extracting Binutils..."
tar xf binutils-${V_BIN}.tar.bz2
echo "Extracting MPFR..."
tar xf mpfr-${V_MPFR}.tar.bz2
echo "Extracting MPC..."
tar xf mpc-${V_MPC}.tar.gz
echo "Extracting GMP..."
tar xf gmp-${V_GMP}.tar.bz2
echo "Extracting CLOOG..."
tar xf cloog-${V_CLOOG}.tar.gz
echo "Extracting ISL..."
tar xf isl-${V_ISL}.tar.bz2
echo "Extracting GDB..."
tar xf gdb-${V_GDB}.tar.gz
echo "Done Extracting"
mv cloog-${V_CLOOG} gcc-${V_GCC}/cloog
mv isl-${V_ISL} gcc-${V_GCC}/isl
mv mpfr-${V_MPFR} gcc-${V_GCC}/mpfr
mv mpc-${V_MPC} gcc-${V_GCC}/mpc
mv gmp-${V_GMPf} gcc-${V_GCC}/gmp
