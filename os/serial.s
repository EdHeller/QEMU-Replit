.global initSerial
.global testSerial
.section .text
.code16

initSerial:
	mov $0x00, %dl
	mov $0x00, %ah
	mov $0b11111111, %al #7 bit word length / 1 stop bit / even parity / 
	int $0x14
	ret
	
testSerial:
	mov $0x01, %ah
	mov $'A', %al
	int $0x14
	ret
