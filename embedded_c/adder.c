#include <reg51.h>

void main(void) {
    unsigned char bcd1, bcd2, sum_low, sum_high;
    unsigned int temp;
    
    bcd1 = 0x99;       // First BCD number
    bcd2 = 0x99;       // Second BCD number
    
    // BCD addition
    temp = bcd1 + bcd2;
    
    if ((temp & 0x0F) > 9) {
        temp += 6;
    }
    if ((temp & 0xF0) > 0x90) {
        temp += 0x60;
    }
    
    sum_low = (unsigned char)(temp & 0xFF);
    sum_high = (unsigned char)(temp >> 8);
    
    // Store results
    // In C, we just use variables
    // For absolute RAM addressing, use: *(unsigned char *)0x52 = sum_low;
    
    while (1);         // Infinite loop
}
