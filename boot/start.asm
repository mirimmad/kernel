; start.asm runs right after the bootloader

bits 16
extern kernel_main
extern remap_pic
extern interrupt_handler
extern timer_tick

start:
	mov ax, cs
	mov ds, ax
	call load_gdt
	call init_video_mode
	call enter_protected_mode
	call setup_interrupts

	call 08h:start_kernel ; 32-bit code is called here from the "context" of 16-bit code.
						  ; logical memory address that refers to kernel's code should refer to the segment 
						  ; selector 08 which is the index and the offset of kernel's code segment descriptor in GDT



load_gdt: 
	cli
	lgdt [gdtr - start] ; (gdtr - start) is the correct addr due to segmentation
	ret

enter_protected_mode:
	mov eax, cr0 ; cr0 is a control register
	or eax, 1 ;  bit-0 = 1 means protected mode is enabled
	mov cr0, eax

	ret

init_video_mode:
	mov ah, 0h ; set-video-mode
	mov al, 03h ; text-mode 16 colors
	int 10h

	mov ah, 01h ; set-cursor
	mov cx, 2000h ; disable cursor
	int 10h;

	ret


setup_interrupts:
	
	call load_idt
	ret

load_idt:
	lidt [idtr - start]
	ret

bits 32

start_kernel:
	mov eax, 10h ; this points to kernel-data descriptor in the GDT
	mov ds, eax
	mov ss, eax

	mov eax, 0h ; null descriptor
	mov es, eax
	mov fs, eax
	mov gs, eax
	call remap_pic
	sti
	call kernel_main


%include "boot/gdt.asm"
%include "boot/idt.asm"