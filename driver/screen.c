
#include "screen.h"

void screen_init () {
	video_memory = (unsigned char *) 0xB8000;
	nextTextPos = 0;
	currLine = 0;
}
 


void print (char *s) {
	// MAX_ROWS = 25 ; MAX_COLS = 80
	// if we are past the last line, SCROLL
	
	 if (currLine == MAX_ROWS  &&  (nextTextPos % (MAX_COLS * 2) == 0)) {
	/*	// TODO: make scroll work AGAIN
		for (int i = 0; i < MAX_ROWS; i++) {
			for (int j = 0; j < MAX_COLS * 2; j = j + 2) {
				// Put in a row 'i' what is in row 'i+1'
				* (video_memory + (i * MAX_COLS * 2) + j) = *(video_memory + ((i+1) * MAX_COLS * 2) +  j);
				// Background
				* (video_memory + (i * MAX_COLS * 2) + (j+1)) = 15;
			}
		} 
		*/
		//nextTextPos -= 160;
		//currLine  -= 1;
		
	}

	while (*s != '\0') {
		video_memory[nextTextPos] = *s;
		video_memory[nextTextPos + 1] = 15; // background
		nextTextPos += 2;
		s++;
	}


}

void println() {
	nextTextPos = ++currLine * MAX_COLS * 2; // ++currLine as it is initialized with 0
}

void printi(int n)
{
	
	char* d2s[] = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
	if (n >= 0 && n <= 9)
		print(d2s[n]);
	else
	{
		int r = n % 10;
		int d = n / 10;
		printi(d);
		printi(r);
	}

}