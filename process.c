#include "process.h"

void processes_init () {
	curr_pid = 0;
	process_count = 0;
}

void process_create (void * base_address, process_t * process) {
	process->pid = curr_pid++;
    
    process->context.eax = 0;
    process->context.ecx = 0;
    process->context.edx = 0;
    process->context.ebx = 0;
    process->context.esp = 0;
    process->context.ebp = 0;
    process->context.esi = 0;
    process->context.edi = 0;
    process->context.eip = base_address;
    
    process->state = READY;
    process->base_address = base_address;
    
    process_table [process->pid ] = process;
    
    process_count++;
}

