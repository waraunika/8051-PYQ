#include <reg51.h>

// Store test data in code memory
unsigned char test_data _at_ 0x40;

void main(void) {
    unsigned char data_byte, zero_count = 0;
    unsigned char i;

    test_data = 0x55; // 01010101 = 4 zeros


    // Read from code memory address 0x40
    data_byte = *(unsigned char code *)0x40;

    // Count zeros
    for (i = 0; i < 8; i++) {
        if ((data_byte & 0x01) == 0)
            zero_count++;
        data_byte >>= 1;
    }

    // Store result in RAM at 0x41
    *(unsigned char *)0x41 = zero_count;

    // Display on Port 2 (debug)
    P2 = zero_count;

    while (1);  // Stop
}
