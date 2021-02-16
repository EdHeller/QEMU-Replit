install-pkg qemu
#install-pkg mtools
install-pkg genisoimage

as --32 "./os/display.s" -o display.o
as --32 "./os/serial.s" -o serial.o
as --32 "./os/keyboard.s" -o keyboard.o
as --32 "./os/gdt.s" -o gdt.o
as --32 "./os/boot.s" -o boot.o
ld -melf_i386 --oformat=binary -T"./os/link.ld" -nostartfiles -nostdlib \
    serial.o keyboard.o display.o gdt.o boot.o -o "boot/boot.bin"


#fallocate -l 1474560 ./boot.bin


genisoimage -v -J -r -V "BOOTDISK" -input-charset utf8 -no-emul-boot -boot-load-size 4 -b stage2_eltorito -o ./cd.iso ./boot

#use this for beeping and sound on an actual system running qemu (won't work in the repl.it container)
#-soundhw pcspk  
#qemu-system-x86_64 -drive format=raw,file=boot.bin
