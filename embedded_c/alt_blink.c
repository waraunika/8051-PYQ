#include <reg51.h>

void delay(void) {
    unsigned int i, j;
    for (i = 0; i < 0xFF; i++)
        for (j = 0; j < 0xFF; j++);
}

void main(void) {
    unsigned char pattern = 0x01;  // Start with LSB
    
    P2 = 0x00; // All LEDs OFF
    
    while (1) {
        P2 = pattern;   // Output to Port 2
        delay();
        pattern = (pattern << 1) | (pattern >> 7);  // Rotate left
        if (pattern == 0x01) pattern = 0x01;        // Keep valid
    }
}
