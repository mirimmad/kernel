#ifndef SCREEN_H
#define SCREEN_H

#define MAX_ROWS 25
#define MAX_COLS 80
volatile unsigned char * video_memory;

int nextTextPos;
int currLine;

void screen_init();
void print(char *);
void println();
void printi();

#endif