// not tested. i genuinely cannot figure out the switches with 8051
// but the logic seems to be tight
#include <reg51.h>

sbit switch1 = P2^1;
sbit switch2 = P2^2;

sbit disp = P1^1;

void delay(unsigned char speed) {
    unsigned char i, j;
    for (i = 0; i < speed; i++)
        for (j = 0; j < 255; j++);
}

void main(void) {
    unsigned char speed = 150;  // Base speed
    
    P1 = 0x00;      // LED on P1.1
    P2 = 0x00;      // Switches on P2.1, P2.2
    
    while (1) {
        // Read switches and adjust speed
        if (switch1 == 1) {        // Increase speed (P2.1)
            if (speed > 20) speed -= 5;  // Faster = smaller delay
        }
        else if (switch2 == 1) {   // Decrease speed (P2.2)
            if (speed < 250) speed += 5; // Slower = larger delay
        }
        
        // Blink LED
        disp = 1;       // LED ON
        delay(speed);
        disp = 0;       // LED OFF
        delay(speed);
    }
}
