.global print        # Make this available to other modules
.global print_nl 	
.global disableCursor 
.global cls
.section .text
.code16

print:
    pusha

# keep this in mind:
# while (string[i] != 0) { print string[i]; i++ }

#the comparison for string end (null byte)
start:
    mov (%bx), %al # 'bx' is the base address for the string
    cmp $0, %al 
    je done

    # the part where we print with the BIOS help
    mov $0x0e, %ah
    int $0x10 # 'al' already contains the char

    # increment pointer and do next loop
    add $1, %bx
    jmp start

done:
    popa
    ret



print_nl:
    pusha
    
    mov $0x0e, %ah
    mov $0x0a, %al # newline char
    int $0x10
    mov $0x0d, %al # carriage return
    int $0x10
    
    popa
    ret

disableCursor:
	pusha
	mov $0x01, %ah
	mov $0x2000, %cx
	int $0x10
	ret

cls:
  pusha
  mov $0x00, %ah
  mov $0x03, %al  # text mode 80x25 16 colours
  int $0x10
  popa
  ret
