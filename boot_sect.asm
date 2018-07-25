; Tell assembler where this program will be stored in memory so that global
; memory locations are properly offset
[org 0x7c00]

mov bp, 0x9000
mov sp, bp

mov bx, message_real_mode
call print_string
call switch_to_pm

jmp $

%include "print_string.asm"
%include "gdt.asm"
%include "print_string_pm.asm"
%include "switch_to_pm.asm"

[bits 32]

begin_pm:

	mov ebx, message_prot_mode
	call print_string_pm

	jmp $

message_real_mode:
db 'Started in 16-bit Real Mode', 0

message_prot_mode:
db 'Successfully landed in 32-bit Protected Mode', 0

; Master boot record stuff.
times 510-($-$$) db 0
dw 0xaa55
