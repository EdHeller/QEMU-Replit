#install-pkg qemu
#install-pkg mtools
#install-pkg genisoimage

#mkdir floppy
#touch disk1.img
#dd if=/dev/zero of=./floppy/disk1.img count=1440 bs=1k 

#mdir -i ./floppy/disk1.img
#mcopy -i -D  ./boot.bin ./floppy/disk1.img

as --32 "./os/display.s" -o display.o
as --32 "./os/serial.s" -o serial.o
as --32 "./os/keyboard.s" -o keyboard.o
as --32 "./os/gdt.s" -o gdt.o
as --32 "./os/boot.s" -o boot.o
ld -melf_i386 --oformat=binary -T"./os/link.ld" -nostartfiles -nostdlib \
    serial.o keyboard.o display.o gdt.o boot.o -o boot.bin

#mcopy -i ./floppy/disk1.img ./boot.bin
#mdir -i /floppy/disk1.img

#fallocate -l 1474560 ./boot.bin
#genisoimage -v -J -r -V "MY_DISK_LABEL" -o ./disk/cd.iso boot.bin
cd ./boot

genisoimage -v -J -r -V "BOOTDISK" -input-charset utf8 -b boot.bin -boot-info-table -o bootcd.iso ./disk

#genisoimage -R -b ./disk/ \
#		 -no-emul-boot \
#		-boot-load-size 4 \
#                -A ./boot.bin \
#                -input-charset utf8 \
#                -quiet \
#                -boot-info-table \
#                -o os.iso \
#                disk


#mkisofs -o ./new.iso -b ./stage2_eltorito.iso -c boot/boot.catalog  -no-emul-boot -boot-load-size 4 \ -boot-info-table -J -R -V disks .

#use this for beeping and sound on an actual system running qemu (won't work in the repl.it container)
#-soundhw pcspk  
#qemu-system-x86_64 -drive format=raw,file=boot.bin
