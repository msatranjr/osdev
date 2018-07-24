;
; Prints hexadecimal
;

; Nibble must be in al register
print_nibble:
	; Push all registers onto the stack as part of subroutine
	; convention.
	pusha

	; Reset all bits except the nibble.
	and al, 0xF

	; Compare the the nibble decimal value 
	cmp al, 10
	jge greater_than_or_equal_to_ten

	; If the nibble is less than 10, we need to set the ASCII offset
	; to the '0' character, which is 0x30. If we add the decimal value
	; to the offset, we'll get the int to char conversion.
	add al, 0x30		
	jmp print_char 

	; If the nibble is greater than 10, we need to set the ASCII offset
	; to the 'a' character which is 0x61
	greater_than_or_equal_to_ten:
	add al, -10 ; We need to remove the most significant digit.
	add al, 0x61 ; Then add the 'a' character to the decimal value.

	print_char:
	mov ah, 0x0e
	int 0x10	
	popa
	ret

; Print hex that lives in dx.
print_hex:
	pusha
	mov ax, dx
	shr ax, 12 
	call print_nibble
	
	mov ax, dx
	shr ax, 8
	call print_nibble

	mov ax, dx
	shr ax, 4
	call print_nibble

	mov ax, dx
	call print_nibble
	popa
	ret

