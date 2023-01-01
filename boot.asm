mov ax, 07C0h
mov ds, ax

mov si, title
call print_string

mov si, message
call print_string

call load_kernel_from_disk
jmp 0900h:0000 ; This is where the kernel would be loaded

load_kernel_from_disk:
 mov ax, 0900h ; Location where the contents would be loaded
 mov es, ax 
 mov ah, 02h ; Service number 02h for reading the sectors
 mov al, 01h ; Number of sector to be read (1 in this case since the kernel.asm is less than 512 bytes of instructions
 mov ch, 0h  ; Track number
 mov cl, 02h ; Sector number (2 since 1 is where the bootsector itself resides)
 mov dh, 0h  ; Head number
 mov dl, 80h ; Type of disk (Hard disk #0)
 mov bx, 0h  ; offset from 900h where the contentes would be loaded
 int 13h ; hard-disk service routine

 jc kernel_load_error
 ret

 kernel_load_error:
  mov si, error_string
  call print_string
  jmp $

print_string:
 mov ah, 0Eh

print_char:
 lodsb
 cmp al, 0
 je printing_finished
 int 10h
 jmp print_char

printing_finished:
 mov al, 10d
 int 10h ; Print new line

 mov ah, 03h
 mov bh, 0
 int 10h ; Get cursor position

 mov ah, 02h
 mov dl, 0
 int 10h ; Move the cursor to the beginning
 ret

title db 'Bootloader', 0
message db 'The kernel is loading', 0
error_string db 'Errror...', 0

times 510-($-$$) db 0
dw 0xAA55
