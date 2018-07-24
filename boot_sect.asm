;
; A simple boot sector program that prints Hello.
;

;
;

[org 0x7c00]

mov dx, 0xabcd
call print_hex

jmp $

%include "print_hex.asm"
%include "print_string.asm"

Message:
	db 'Hello, world!', 0
;
; The master boot record must be 512 bytes, so we need
; to pad the rest of the file with 0 so that the binary
; is exactly 512 bytes.

times 510-($-$$) db 0

;
; Magic number that must be at the end of the binary
; for the BIOS to recognize this as a bootable image.
;
dw 0xaa55
