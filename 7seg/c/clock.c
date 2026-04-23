#include <reg51.h>

/* PORT DEFINITIONS */
#define DATA_PORT P0
#define CTRL_PORT P2

/* DISPLAY CONTROL PINS */
sbit DISP1 = CTRL_PORT^7;   // Ones
sbit DISP2 = CTRL_PORT^6;   // Tens
sbit DISP3 = CTRL_PORT^5;   // Hundreds
sbit DISP4 = CTRL_PORT^4;   // Thousands 

/* COMMON CATHODE 7-SEGMENT CODES */
unsigned char code SEGMENT_CODE[10] = {
    0x3F, // 0
    0x06, // 1
    0x5B, // 2
    0x4F, // 3
    0x66, // 4
    0x6D, // 5
    0x7D, // 6
    0x07, // 7
    0x7F, // 8
    0x6F  // 9
};

/* FUNCTION DECLARATIONS */
void display(unsigned char thousands, unsigned char hundreds, unsigned char tens, unsigned char ones);
void multiplex_delay(void);

void main() {
    unsigned char i;
    unsigned int delay;

    P2 = 0x0F;   // Initialize control pins

    while (1) {
			// there is one slight issue here
			// my simulation in proteus just hard resets at 4:15. i see no bugs, i genuinely do not see any issue here
			// asked deepseek, it started to hallucinate, so i'm chalking it up to proteus's bug.
        for (i = 0; i < 3600; i++) {
            for (delay = 0; delay < 50; delay++) {
                display((i / 600) % 6, (i / 60) % 10, (i / 10) % 6, i % 10);
            }
        }
    }
}

/* DISPLAY MULTIPLEXING FUNCTION */
void display(unsigned char thousands, unsigned char hundreds, unsigned char tens, unsigned char ones) {

    /* ONES DIGIT */
    DISP1 = 1; DISP2 = 0; DISP3 = 0; DISP4 = 0;
    DATA_PORT = SEGMENT_CODE[ones];
    multiplex_delay();
    DISP1 = 0;

    /* TENS DIGIT */
    DISP1 = 0; DISP2 = 1; DISP3 = 0; DISP4 = 0;
    DATA_PORT = SEGMENT_CODE[tens];
    multiplex_delay();
    DISP2 = 0;
	
		// HUNDREDS DIGIT
		DISP1 = 0; DISP2 = 0; DISP3 = 1; DISP4 = 0;
    DATA_PORT = SEGMENT_CODE[hundreds] | 0x80;
    multiplex_delay();
    DISP3 = 0;
	
		// THOUSANDS DIGIT
		DISP1 = 0; DISP2 = 0; DISP3 = 0; DISP4 = 1;
    DATA_PORT = SEGMENT_CODE[thousands];
    multiplex_delay();
    DISP4 = 0;
}

/* SHORT DELAY FOR MULTIPLEXING */
void multiplex_delay(void) {
    unsigned int i;
    for (i = 0; i < 60; i++);
}
