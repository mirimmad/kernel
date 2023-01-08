#include "driver/screen.h"
#include "driver/timer.h"



void kernel_main()
{
	//video_memory[0] = 'A';
	screen_init();
	timer_init();
	print("Welcome to the bare bones kernel -- in protectected mode.");
	println();
	int i = timer_count(), j = i;

	while (i != j + 10) {
		print("Hello ");
		printi(i);
		println();
		i = timer_count();
	}
	print("END");
	/*for (int i = 0; i < 10000;i++) {
		printi(i);println();
	}*/
	/*for (int i = 0; i < 1000; i++)
		asm volatile ("int $0x03");*/
	while(1);
}

