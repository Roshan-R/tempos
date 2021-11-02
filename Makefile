#
# Makefile for tempos
#

GCCPARAMS = -m32 -nostdlib -ffreestanding -std=c++11 -mno-red-zone -fno-exceptions -nostdlib -fno-rtti -Wall -Wextra -Werror

all: run
	@echo "Finished building kernel"

	#nasm "Bootloader/boot.asm" -f bin -o "WeeBins/boot.bin" -i Bootloader


kernel.bin : boot.o
	i386-elf-gcc-11.2.0 kernel/kmain.cpp drivers/vga.cpp drivers/port_io.cpp bootloader/boot.o -o kernel.bin $(GCCPARAMS) -T linker.ld

boot.o :
	nasm -f elf32 bootloader/boot.asm -o bootloader/boot.o

run : kernel.bin
	qemu-system-x86_64 -drive format=raw,file="kernel.bin",index=0,if=floppy, -m 128M
