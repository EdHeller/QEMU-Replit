install-pkg qemu

as --32 "./os/display.s" -o display.o
as --32 "./os/gdt.s" -o gdt.o
as --32 "./os/boot.s" -o boot.o
ld -melf_i386 --oformat=binary -T"./os/link.ld" -nostartfiles -nostdlib \
    display.o gdt.o boot.o -o boot.bin

#use this for beeping and sound on an actual system running qemu (won't work in the repl.it container)
#-soundhw pcspk  
qemu-system-x86_64 -drive format=raw,file=boot.bin 
