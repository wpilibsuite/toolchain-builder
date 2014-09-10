V_BINUTILS=2.24
V_GCC=4.9.1
V_SYSROOT=1.0
V_GDB=7.8

# Build target order:
# 1. linux-api-headers
# 2. binutils
# 3. gcc-stage1
# 4. eglibc-headers
# 5. gcc-stage2
# 6. eglibc
# 7. gcc
# 8. gdb

.PHONY: all
all:
	@echo "please specify which you want. binutils must be installed before gcc"

.PHONY: linux-api-headers
linux-api-headers:
	cd pkgbuilds/linux-api-headers && makepkg -s

.PHONY: binutils
binutils:
	cp ../binutils-${V_BINUTILS}.tar.bz2 pkgbuilds/linux-api-headers/
	cd pkgbuilds/binutils && makepkg -s

.PHONY: gcc-stage1
gcc-stage1:
	cp ../gcc-${V_GCC}.tar.bz2 pkgbuilds/gcc-stage1/
	cd pkgbuilds/gcc-stage1 && makepkg -s

.PHONY: eglibc-headers
eglibc-headers:
	cd pkgbuilds/eglibc-headers && makepkg -s

.PHONY: gcc-stage2
gcc-stage2:
	cp ../gcc-${V_GCC}.tar.bz2 pkgbuilds/gcc-stage2/
	cd pkgbuilds/gcc-stage2 && makepkg -s

.PHONY: eglibc
eglibc:
	cd pkgbuilds/eglibc && makepkg -s

.PHONY: gcc
gcc:
	cp ../gcc-${V_GCC}.tar.bz2 pkgbuilds/gcc/
	cd pkgbuilds/gcc && makepkg -s

.PHONY: gdb
gdb:
	cp ../gdb-${V_GDB}.tar.gz pkgbuilds/gdb/
	cd pkgbuilds/gdb && makepkg -s

.PHONY: clean
clean:
	cd pkgbuilds/linux-api-headers && rm -rf src/ pkg/ *.bz2 *.xz linux-stable-rt/
	cd pkgbuilds/binutils && rm -rf src/ pkg/ *.bz2 *.xz
	cd pkgbuilds/gcc-stage1 && rm -rf src/ pkg/ *.bz2 *.xz
	cd pkgbuilds/eglibc-headers && rm -rf src/ pkg/ *.bz2 *.xz
	cd pkgbuilds/gcc-stage2 && rm -rf src/ pkg/ *.bz2 *.xz
	cd pkgbuilds/eglibc && rm -rf src/ pkg/ *.bz2 *.xz
	cd pkgbuilds/gcc && rm -rf src/ pkg/ *.bz2 *.xz
	cd pkgbuilds/gdb && rm -rf src/ pkg/ *.gz *.xz

