mov ax, 07C0h ; This is where the bootloader is loaded.
mov ds, ax

mov si, title
call print_string

mov si, message
call print_string

call load_kernel_from_disk
jmp 0900h:0000 ; This is where the kernel would be loaded

load_kernel_from_disk:

 ; BIOS routine 13h:02h loads contents into (es:bx)
 mov ax, [curr_sector_to_load]
 sub ax, 2
 mov bx, 512d
 mul bx
 mov bx, ax ; these instructions set the value of the offset correctly (curr_sector_to_load - 2) * 512. 512 is the size of each sector

 mov ax, 0900h 
 mov es, ax  ; Location where the contents would be loaded
 mov ah, 02h ; Service number 02h for reading the sectors
 mov al, 01h ; Number of sector to be read (1 in this case since the kernel.asm is less than 512 bytes of instructions
 mov ch, 0h  ; Track number
 mov cl, [curr_sector_to_load] ; Sector number 
 mov dh, 0h  ; Head number
 mov dl, 80h ; Type of disk (Hard disk #0)
 int 13h ; hard-disk service routine(es:bx)

 jc kernel_load_error ; carry flag is set if BIOS routine 13h fails
 add byte [curr_sector_to_load], 1
 sub byte [num_of_sectors_to_load], 1
 cmp byte [num_of_sectors_to_load], 0
 jne load_kernel_from_disk

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
num_of_sectors_to_load db 15d
curr_sector_to_load db 2d ; sector 1 contains the bootloader itself


times 510-($-$$) db 0 ; Padding
dw 0xAA55 ; Magic number
