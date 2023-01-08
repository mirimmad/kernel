#include "timer.h"

void timer_init(){
	timer_c = 0;
}

void timer_tick() {
	timer_c++;
}

int timer_count() {
	return timer_c;
}