#ifndef COMMON_H
#define COMMON_H

void outb(short port, char val);
char inb(short port);
void memcpy(char * src, char * dst, int n);
#endif