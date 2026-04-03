#include <reg51.h>

void delay_ms(unsigned int ms) {
    unsigned int i, j;
    for (i = 0; i < ms; i++)
        for (j = 0; j < 125; j++);  // Approx 1ms @ 12MHz
}

void main(void) {
    unsigned char celsius, fahrenheit;
    unsigned int temp;
    
    P1 = 0xFF;      // Port 1 as input
    P2 = 0x00;      // Port 2 as output
    
    while (1) {
        celsius = P1;  // Read from Port 1
        // Formula: F = (C × 9/5) + 32
        temp = celsius;
        temp = (temp * 9) / 5;
        fahrenheit = (unsigned char)(temp + 32);

        P2 = fahrenheit;  // Output to Port 2

        delay_ms(100);    // Small delay between readings
    }
}
