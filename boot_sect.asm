[org 0x7c00]

mov bx, message
call print_string

mov bx, message2
call print_string

mov dx, 0xa2b3
call print_hex

mov dx, 0x1234
call print_hex

jmp $

%include "print_string.asm"
%include "print_hex.asm"

message:
db 'Hello, world!', 0xa, 0


message2:
db 'Hello, world!2222', 0xa, 0

; Master boot record stuff.
times 510-($-$$) db 0
dw 0xaa55