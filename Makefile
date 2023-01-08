ASM = nasm
BOOT = boot/boot.asm
INIT_KERNEL = boot/start.asm
KERNEL_FILES = main.c
KERNEL_FLAGS = -Wall -m32 -c -ffreestanding -fno-asynchronous-unwind-tables -fno-pie
KERNEL_OBJECT = -o kernel.elf


build: $(BOOT) $(KERNEL)
	$(ASM) -f bin $(BOOT) -o boot.o
	$(ASM) -f elf32 $(INIT_KERNEL) -o start.o
	$(CC) $(KERNEL_FLAGS) $(KERNEL_FILES) $(KERNEL_OBJECT)
	$(CC) $(KERNEL_FLAGS) driver/screen.c -o screen.elf
	$(CC) $(KERNEL_FLAGS) driver/timer.c -o timer.elf
	$(CC) $(KERNEL_FLAGS) common.c -o common.elf
	ld -melf_i386 -Tlinker.ld start.o kernel.elf screen.elf timer.elf common.elf -o mykernel.elf
	objcopy -O binary mykernel.elf kernel.bin
	dd if=boot.o of=kernel.img
	dd seek=1 conv=sync if=kernel.bin of=kernel.img bs=512 count=5
	dd seek=6 conv=sync if=/dev/zero of=kernel.img bs=512 count=2046
