; subroutine to store a single hex digit stored in ax into memory location bx+si
store_nibble:
pusha

; mask all digits except the one we want to store.
and ax, 0x000F

; compare the digit to 10
cmp ax, 10
jl pn_lessthanten 

; if it's greater than 10, we need to subtract 10 and add the ASCII 'a' character
; to convert to a-z character.
add ax, -10
add ax, 0x61
jmp pn_endif

; if it's less than 10, we need to add the ASCII '0' character to convert to 
; 0-9 character.
pn_lessthanten:
add ax, 0x30
    
pn_endif:
; store the result into bx+si
mov [bx+si], al
popa
ret

; subroutine to print hex value stored in dx
print_hex:
pusha

; print the first hex digit
mov bx, hex_out
mov si, 5
mov ax, dx
call store_nibble

; print the second hex digit
mov ax, dx
shr ax, 4
add si, -1
call store_nibble

; print the third hex digit
mov ax, dx
shr ax, 8
add si, -1
call store_nibble

; print the fourth hex digit
mov ax, dx
shr ax, 12
add si, -1
call store_nibble

; print the string representation 
call print_string
popa
ret

; memory location of where string representation lives.
hex_out:
db '0x0000', 0