.global installGDT
.section .text
.code16


#*******************************************
# InstallGDT()
#	- Install our GDT
#*******************************************

installGDT:

	cli                  # clear interrupts
	pusha                # save registers
	lgdt 	(toc)        # load GDT into GDTR
	sti	                 # enable interrupts
	popa                 # restore registers
	ret	                 # All done!

#*******************************************
# Global Descriptor Table (GDT)
#*******************************************

gdt_data: 
	.long 0                # null descriptor
	.long 0 

gdtcode:	           # code descriptor
	.word 0xFFFF          # limit low
	.word 0               # base low
	.byte 0               # base middle
	.byte 0b10011010       # access
	.byte 0b11001111       # granularity
	.byte 0               # base high

gdtdata:	           # data descriptor
	.word 0xFFFF          # limit low (Same as code)10:56 AM 7/8/2007
	.word 0               # base low
	.byte 0               # base middle
	.byte 0b10010010       # access
	.byte 0b11001111       # granularity
	.byte 0               # base high
	
end_of_gdt:
toc: 
	.word end_of_gdt - gdtdata - 1 	# limit (Size of GDT)
	.long gdtdata 			# base of GDT

# give the descriptor offsets names

.set NULL_DESC, 0
.set CODE_DESC, 0x8
.set DATA_DESC, 0x10
