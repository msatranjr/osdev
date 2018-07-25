; Tell assembler where this program will be stored in memory so that global
; memory locations are properly offset
[org 0x7c00]

mov [boot_drive], dl ; BIOS sets dl to the boot drive, so we are storing this now.

mov bp, 0x8000 ; Set stack into a safe range
mov sp, bp

mov bx, 0x9000 ; Load 5 sectors to 0x0000:0x9000
mov dh, 5 ; from boot disk.
mov dl, [boot_drive]
call disk_load

mov dx, [0x9000] ; Print out first loaded word
call print_hex

mov dx, [0x9000 + 512]
call print_hex

jmp $

%include "print_string.asm"
%include "print_hex.asm"
%include "disk_load.asm"

boot_drive: db 0

; Master boot record stuff.
times 510-($-$$) db 0
dw 0xaa55

; We know that BIOS will load only the first 512 - byte sector from the disk ,
; so if we purposely add a few more sectors to our code by repeating some
; familiar numbers , we can prove to ourselfs that we actually loaded those
; additional two sectors from the disk we booted from.
times 256 dw 0xdada
times 256 dw 0xface