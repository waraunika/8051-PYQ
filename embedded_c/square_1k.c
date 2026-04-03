#include <reg51.h>

sbit disp = P0^5;

void main(void) {
    TMOD |= 0x01;      // Timer 0, Mode 1 (16-bit)
    
    // 1kHz @ 11.0592MHz (500us HIGH, 500us LOW)
    TH0 = 0xFE;        // 500us timer value
    TL0 = 0x33;

    disp = 0;          // Start LOW
    TR0 = 1;           // Start timer

    while (1) {
        while (!TF0);  // Wait for overflow
        TF0 = 0;       // Clear flag
        TR0 = 0;
        disp = !disp;  // Toggle pin

        // Reload timer
        TH0 = 0xFE;
        TL0 = 0x33;
        TR0 = 1;
    }
}
