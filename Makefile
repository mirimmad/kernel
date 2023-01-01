ASM = nasm
BOOT = boot.asm
KERNEL = kernel.asm

build: $(BOOT) $(KERNEL)
	$(ASM) -f bin $(BOOT) -o boot.o
	$(ASM) -f bin $(KERNEL) -o kernel.o
	dd if=boot.o of=kernel.img
	dd seek=1 conv=sync if=kernel.o of=kernel.img bs=512
