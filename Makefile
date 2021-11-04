#
# Makefile for tempos
#

GCCPARAMS = -m32 -nostdlib -ffreestanding -std=c++11 -mno-red-zone -fno-exceptions -nostdlib -fno-rtti -Wall -Wextra -Werror
#GCCPARAMS = -m32 -nostdlib -ffreestanding -std=c++11 -mno-red-zone -fno-exceptions -nostdlib -fno-rtti
CC="/usr/local/i386elfgcc/i386-elf-11.2.0-Linux-x86_64/bin/i386-elf-gcc-11.2.0"

all: iso
	@echo "Finished building kernel"

kernel.bin : bin/kernel/kmain.o bin/drivers/vga.o bin/libs/string.o bin/bootloader/boot.o bin/cpu/idt.o
	$(CC) bin/kernel/kmain.o bin/drivers/vga.o bin/libs/string.o bin/bootloader/boot.o bin/cpu/idt.o -o kernel.bin $(GCCPARAMS) -T linker.ld

bin/kernel/kmain.o : kernel/kmain.cpp
	$(CC) -c kernel/kmain.cpp -o bin/kernel/kmain.o $(GCCPARAMS)

bin/drivers/vga.o : drivers/vga.cpp
	$(CC) -c drivers/vga.cpp -o bin/drivers/vga.o $(GCCPARAMS)

bin/libs/string.o : libs/string.cpp
	$(CC) -c libs/string.cpp -o bin/libs/string.o $(GCCPARAMS)

bin/bootloader/boot.o : bootloader/boot.asm
	i386-elf-as bootloader/boot.asm -o bin/bootloader/boot.o
	# nasm -f elf32 bootloader/boot.asm -o bin/bootloader/boot.o

bin/cpu/idt.o : cpu/idt.cpp
	$(CC) -c cpu/idt.cpp -o bin/cpu/idt.o $(GCCPARAMS)

iso : kernel.bin 
	rm iso/boot/kernel.bin
	cp kernel.bin iso/boot
	grub-mkrescue /usr/lib/grub/i386-pc -o tempos.iso iso/
	qemu-system-i386 -drive format=raw,file=tempos.iso
