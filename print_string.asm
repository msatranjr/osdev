; routine to print a null-terminating string stored at the memory location specified in bx.
print_string:
    pusha
    ps_loop:
        mov ax, [bx]
        mov ah, 0x0e
        int 0x10

        add bx, 1
        cmp al, 0
        jne ps_loop
    popa
    ret