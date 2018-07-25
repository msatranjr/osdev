disk_load:
    push dx

    mov ah, 0x02 ; BIOS read sector function
    mov al, dh ; Read DH sectors
    mov ch, 0x00 ; Select cylinder 0
    mov dh, 0x00 ; Select head 0
    mov cl, 0x02 ; Start reading from second sector (after boot sector, because sectors are 512 bytes)
    int 0x13 ; BIOS interrupt

    jc disk_error ; Jump if carry flag was set

    pop dx
    cmp dh, al ; Compare sectors actually read with the sectors expected to be read.
    jne disk_error ; If they aren't equal there's a disk read error.
    ret

disk_error:
    mov bx, disk_error_message
    call print_string
    jmp $

disk_error_message: db 'Disk read error!', 0