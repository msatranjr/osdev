[bits 16]

switch_to_pm:
	cli
	lgdt [gdt_descriptor]

	mov eax, cr0
	or eax, 0x1
	mov cr0, eax

	jmp code_seg:init_pm

[bits 32]

init_pm:
	mov ax, data_seg
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000
	mov esp, ebp

	call begin_pm