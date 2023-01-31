#ifndef PROCESS_H
#define PROCESS_H

typedef enum  { READY, RUNNING } process_state_t;

typedef struct {
	int eax, ecx, edx, ebx, esp, ebp, esi, edi, eip;
} process_context_t;

typedef struct {
	int pid;
	process_context_t context;
	process_state_t state;
	void * base_address;
} process_t;

static process_t* process_table[15];

static int process_count, curr_pid;

void processes_init();

void process_create (void *, process_t *);

#endif
