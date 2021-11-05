# tempos
A hobby 32 bit OS

## Features 
- Protected Mode
- Custom Bootloader
- VGA Graphics

## Usage 
clone the repository and run 
```bash
qemu-system-x86_64 -drive format=raw,file="kernel.bin",index=0,if=floppy, -m 128M
```
to boot into the OS.

## Screenshot

![image](https://user-images.githubusercontent.com/43182697/140538527-a9553d71-355a-454a-b3d8-290ea5c52f9e.png)
