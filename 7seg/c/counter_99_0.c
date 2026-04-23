#include <reg51.h>

// common cathode
code unsigned char patterns[10] = {
    0x3F, 0x06, 0x5B, 0x4F, 0x66,  // 0-4
    0x6D, 0x7D, 0x07, 0x7F, 0x6F   // 5-9
};

sbit DISP1 = P2^7;    // first display control
sbit DISP2 = P2^6;    // second display control

void short_delay(void) {
    unsigned int i;
    for (i = 0; i < 255; i++);
}

void display(unsigned char tens, unsigned char ones) {
    // Display ones digit
    DISP1 = 1;
    DISP2 = 0;
    P0 = patterns[ones];
    short_delay();
    
    // Display tens digit
    DISP1 = 0;
    DISP2 = 1;
    P0 = patterns[tens];
    short_delay();
    
    DISP2 = 0; // Turn off both
}

void main(void) {
    unsigned char tens = 9, ones = 9;
    unsigned int delay_count;
    
    P0 = 0x00;
    P2 = 0xC0;
    
    while (1) {
        // Display for a while
        for (delay_count = 0; delay_count < 255; delay_count++) {
            display(tens, ones);
        }
        
        // Decrement counter
        if (ones == 0) {
            ones = 9;
            if (tens == 0)
                tens = 9;
            else
                tens--;
        } else {
            ones--;
        }
    }
}
