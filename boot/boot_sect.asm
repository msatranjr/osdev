; Tell assembler where this program will be stored in memory so that global
; memory locations are properly offset
[org 0x7c00]
kernel_offset equ 0x1000

mov [boot_drive], dl

mov bp, 0x9000
mov sp, bp

mov bx, message_real_mode
call print_string
call load_kernel
call switch_to_pm

jmp $

%include "boot/print_string.asm"
%include "boot/disk_load.asm"
%include "boot/gdt.asm"
%include "boot/print_string_pm.asm"
%include "boot/switch_to_pm.asm"

[bits 16]

load_kernel:
mov bx, message_load_kernel
call print_string
mov bx, kernel_offset
mov dh, 15
mov dl, [boot_drive]
call disk_load
ret

[bits 32]

begin_pm:

	mov ebx, message_prot_mode
	call print_string_pm

    call kernel_offset

	jmp $

boot_drive:
db 0

message_real_mode:
db 'Started in 16-bit Real Mode', 0

message_prot_mode:
db 'Successfully landed in 32-bit Protected Mode', 0

message_load_kernel:
db 'Loading kernel into memory.', 0

; Master boot record stuff.
times 510-($-$$) db 0
dw 0xaa55
