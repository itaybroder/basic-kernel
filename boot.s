section .boot
[bits 16]

jmp short _start
nop



_start:
    xor ax, ax
    hlt

times 510-($-$$) 		db 0	; Pad memory so that the size of the bootloader will always be 510 (+2 signature bytes)
dw 0AA55h		; Boot sector signature - tell the CPU this is our bootloader
