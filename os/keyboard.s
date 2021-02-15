.global waitForKey
.section .text
.code16

waitForKey:
	mov $0x00, %ah
	int $0x16
	ret
