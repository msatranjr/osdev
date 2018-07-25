[bits 32]
; constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

;prints a null-terminated string pointed to by EBX

print_string_pm:
	pusha
	mov edx, VIDEO_MEMORY

print_string_pm_loop:
	mov al, [ebx]
	mov ah, WHITE_ON_BLACK

	cmp al, 0
	je print_string_pm_done

	mov [edx], ax
	
	add ebx, 1
	add edx, 2

	jmp print_string_pm_loop

print_string_pm_done:
	popa
	ret
