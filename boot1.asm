; Boot 1

bits 16 ; 16 bit real mode
org 0x7c00 ; Need to be aligned here

start:
	cli ; Disable interrupts
	hlt ; Halt system

times 510-($-$$) db 0 ; Pad the sector so that it's 512 bytes (510 but still)
dw 0xaa55 ; The boot signature.