;
; Prints a string
; Address is stored in bx.
;

print_string:
	pusha

	print_string_loop:
		mov ax, [bx]
		mov ah, 0x0e	 
		int 0x10

		add bx, 1
		cmp al, 0
		jne print_string_loop
	popa
	ret
