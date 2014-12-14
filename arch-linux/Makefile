source versions.sh

# Build target order:
# 1. linux-api-headers
# 2. binutils
# 3. gcc-stage1
# 4. eglibc-headers
# 5. gcc-stage2
# 6. eglibc
# 7. gcc
# 8. gdb

TARGET=arm-frc-linux-gnueabi

.PHONY: all
all:
	@echo "please specify which you want. binutils must be installed before gcc"

.PHONY: linux-api-headers
linux-api-headers:
	cd pkgbuilds/${TARGET}-linux-api-headers && makepkg -si

.PHONY: binutils
binutils:
	cp ../binutils-${V_BINUTILS}.tar.bz2 pkgbuilds/${TARGET}-binutils/
	cd pkgbuilds/${TARGET}-binutils && makepkg -si

.PHONY: gcc-stage1
gcc-stage1:
	cp ../gcc-${V_GCC}.tar.bz2 pkgbuilds/${TARGET}-gcc-stage1/
	cd pkgbuilds/${TARGET}-gcc-stage1 && makepkg -si

.PHONY: eglibc-headers
eglibc-headers:
	cd pkgbuilds/${TARGET}-eglibc-headers && makepkg -si

.PHONY: gcc-stage2
gcc-stage2:
	cp ../gcc-${V_GCC}.tar.bz2 pkgbuilds/${TARGET}-gcc-stage2/
	cd pkgbuilds/${TARGET}-gcc-stage2 && makepkg -si

.PHONY: eglibc
eglibc:
	cd pkgbuilds/${TARGET}-eglibc && makepkg -si

.PHONY: gcc
gcc:
	cp ../gcc-${V_GCC}.tar.bz2 pkgbuilds/${TARGET}-gcc/
	cd pkgbuilds/${TARGET}-gcc && makepkg -si

.PHONY: gdb
gdb:
	cp ../gdb-${V_GDB}.tar.gz pkgbuilds/${TARGET}-gdb/
	cd pkgbuilds/${TARGET}-gdb && makepkg -si

.PHONY: clean
clean:
	cd pkgbuilds/${TARGET}-linux-api-headers && rm -rf src/ pkg/ *.bz2 *.xz linux-stable-rt/
	cd pkgbuilds/${TARGET}-binutils && rm -rf src/ pkg/ *.bz2 *.xz
	cd pkgbuilds/${TARGET}-gcc-stage1 && rm -rf src/ pkg/ *.bz2 *.xz
	cd pkgbuilds/${TARGET}-eglibc-headers && rm -rf src/ pkg/ *.bz2 *.xz
	cd pkgbuilds/${TARGET}-gcc-stage2 && rm -rf src/ pkg/ *.bz2 *.xz
	cd pkgbuilds/${TARGET}-eglibc && rm -rf src/ pkg/ *.bz2 *.xz
	cd pkgbuilds/${TARGET}-gcc && rm -rf src/ pkg/ *.bz2 *.xz
	cd pkgbuilds/${TARGET}-gdb && rm -rf src/ pkg/ *.gz *.xz

