#include <reg51.h>

sbit DISP = P0^0;

// 5ms delay using Timer 1, Mode 1
// XTAL = 11.0592 MHz
void delay_5ms(void) {
    TMOD |= 0x10;      // Timer 1, Mode 1 (16-bit)
    TH1 = 0xEE;        // 5ms @ 11.0592MHz
    TL1 = 0x00;
    TR1 = 1;           // Start timer
    while (!TF1);      // Wait for overflow
    TF1 = 0;           // Clear flag
    TR1 = 0;           // Stop timer
}

void main(void) {
    while (1) {
        DISP = 1;      // LED ON
        delay_5ms();
        DISP = 0;      // LED OFF
        delay_5ms();
    }
}
