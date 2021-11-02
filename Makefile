#
# Makefile for tempos
#

GCCPARAMS = -m32 -nostdlib -ffreestanding -std=c++11 -mno-red-zone -fno-exceptions -nostdlib -fno-rtti -Wall -Wextra -Werror
CC="/usr/local/i386elfgcc/i386-elf-11.2.0-Linux-x86_64/bin/i386-elf-gcc-11.2.0"

all: run
	@echo "Finished building kernel"

	#nasm "Bootloader/boot.asm" -f bin -o "WeeBins/boot.bin" -i Bootloader


kernel.bin : bin/kernel/kmain.o bin/drivers/vga.o bin/libs/string.o bin/bootloader/boot.o
	$(CC) bin/kernel/kmain.o bin/drivers/vga.o bin/libs/string.o bin/bootloader/boot.o -o kernel.bin $(GCCPARAMS) -T linker.ld
	# $(CC) kernel/kmain.cpp drivers/vga.cpp libs/string.cpp drivers/port_io.cpp bootloader/boot.o -o kernel.bin $(GCCPARAMS) -T linker.ld

bin/kernel/kmain.o : kernel/kmain.cpp
	$(CC) -c kernel/kmain.cpp -o bin/kernel/kmain.o $(GCCPARAMS)

bin/drivers/vga.o : drivers/vga.cpp
	$(CC) -c drivers/vga.cpp -o bin/drivers/vga.o $(GCCPARAMS)

bin/libs/string.o : libs/string.cpp
	$(CC) -c libs/string.cpp -o bin/libs/string.o $(GCCPARAMS)

bin/bootloader/boot.o : bootloader/boot.asm
	nasm -f elf32 bootloader/boot.asm -o bin/bootloader/boot.o

run : kernel.bin
	qemu-system-x86_64 -drive format=raw,file="kernel.bin",index=0,if=floppy, -m 128M
