#include "common.h"
#include "driver/screen.h"
void outb(short port, char val) {
	asm volatile ("outb %1, %0" : : "dN" (port), "a" (val));
}

char inb(short port) {
	unsigned char ret;
  	asm volatile("inb %1, %0" : "=a" (ret) : "dN" (port));
  	return ret;
}

void remap_pic() {
  outb(0x20, 0x11);  // Initialize master PIC
  outb(0xa0, 0x11);  // Initialize slave PIC
  outb(0x21, 32);    // Master PIC IRQs start from 32d
  outb(0xa1, 40);    // Slave PIC IRQs start from 40d
  outb(0x21, 4);     // Tell Master PIC where the slave is connected
  outb(0xa1, 2);     // vice-versa
  outb(0x21, 1);     // Arch = x86 M
  outb(0xa1, 1);     // Arch = x86 S
  outb(0x21, 0);     // Enable IRQs M
  outb(0xa1, 0);     // Enable IRQs S
}

void memcpy(char * src, char * dst, int n) {
	for (int i = 0; i < n; i++) {
		*(dst + i) = *(src + i);
	}
}

void interrupt_handler(int i)
{ 
	print("interrupt recieved ");
	printi(i);
	println(); 
}

