.global print        # Make this available to other modules
.global print_nl 	 
.global cls
.section .text
.code16

print:
    pusha

# keep this in mind:
# while (string[i] != 0) { print string[i]; i++ }

# the comparison for string end (null byte)
.start:
mov $0x0e, %ah # tty mode
mov  'H', %al
int $0x10
mov 'e', %al

.done:
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

cls:
  pusha
  mov $0x00, %ah
  mov $0x03, %al  # text mode 80x25 16 colours
  int $0x10
  popa
  ret
