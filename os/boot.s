# Section .text.bootentry is always placed before all other code and data
# in the linker script. If using multiple object files only specify
# one .text.bootentry as that will be the code that will start executing
# at 0x7c00

.section .text.bootentry
.code16
.global _start
_start:
    # Initialize the segments especially DS and set the stack to grow down from
    # start of bootloader at _start. SS:SP=0x0000:0x7c00
    xor %ax, %ax
    mov %ax, %ds
    mov %ax, %ss
    mov $_start, %sp
    cld                   # Set direction flag forward for string instructions
    call cls


    #mov  $boot_msg, %bx
    call print
    

    call installGDT

    cli				# clear interrupts
    mov	%cr0, %eax		# set bit 0 in cr0--enter pmode
    or	%eax, 1
    mov	%eax, %cr0
    jmp	Pmode #far jump to pmode
    # Infinite loop to end bootloader

.endloop:
    hlt #halt if we fail to jump.
    jmp .endloop

.section .rodata
boot_msg: .asciz "Hello"
console_rdy: .asciz "Ready!"

.section .text.pmode
.code32

  Pmode: 
  
  mov		0x10, %ax		# set data segments to data selector (0x10)
	xor %ax, %ax
  mov %ax, %ds
  mov %ax, %ss
	mov	0x90000, %esp		# stack begins from 90000h

.endloop32:
    cli
    hlt
    jmp .endloop32
