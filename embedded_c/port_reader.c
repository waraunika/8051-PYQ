#include <reg51.h>
// lol, why was this question asked honestly
// or maybe i'm missing something. but either way, LOL
void main(void) {
    P1 = 0xFF;      // Configure Port 1 as input
    P0 = 0x00;      // Configure Port 0 as output
    
    while (1) {
        P0 = P1;    // Read from P1, write to P0
    }
}
