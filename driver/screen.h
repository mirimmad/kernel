#ifndef SCREEN_H
#define SCREEN_H

#define MAX_ROWS 25
#define MAX_COLS 80
static volatile unsigned char * video_memory;

static int nextTextPos;
static int currLine;

void screen_init();
void print(char *);
void println();
void printi();

#endif
