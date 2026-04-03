#include <reg51.h>

void delay(void) {
    unsigned int i, j;
    for (i = 0; i < 0xFF; i++)
        for (j = 0; j < 0xFF; j++);
}

void main(void) {
    while (1) {
        P2 = 0x00; // All OFF
        delay();
        P2 = 0xFF; // All ON
        delay();
    }
}
