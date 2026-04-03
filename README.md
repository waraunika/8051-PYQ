This repository will function as the Past Year Questions' Solution for IoE's Embedded System.

I will not share their hex file, or the proteus simulation. However, if one desires to see my simulation (and other necessary files) please open an issue.

For each question:
- 1st link is for Assembly.
- 2nd link is for Embedded C.

And I humbly ask you to read comments, because I do talk about potential bugs and whatnots.

## Assembly Programs
### 1. [5] (`82 Ka`)
> ```Write a program to read an 8-bit temperature in Celsius from Port 1 and to output the Fahrenheit temperature equivalent onto port 2. (Note: F = C x (9/5) + 32)```

Solution:
1. [Temperature Assembly File](./assembly/temperature.asm)
2. [Temperature C File](./embedded_c/temperature.c)

### 2. [4] (`81 Ch`, `72 Ma`)
> ```Write an assembly language programming to alternatively blink the 8 LEDs connected at port 2 of the 8051 microcontroller.```

Solution: 
1. [Blinking Assembly File](./assembly/alt_blink.asm)
2. [Blinking C File](./embedded_c/alt_blink.c)

### 3. [4] (`79 Ch`)
> ```Write an assembly program for 8051 to count number of 0’s in an 8-bit data stored in ROM at 40H and result in RAM at 41H.```
Solution:
1. [Number of Zero Assembly File](./assembly/num_zero.asm)
2. [Number of Zero C File](./embedded_c/num_zero.asm)

### 4. [2+4] (`78 Ch`)
> ```Assume that XTAL = 11.0592 MHz, write a program to generate a square wave of 1 kHz frequency on pin P1.5 of 8051 microcontroller using timer.```

Solution:
1. [Simple 1k Wave Assembly](./assembly/square_1k.asm)
2. [Simple 1k Wave C](./embedded_c/square_1k.c)

### 5. [8] (`76 Bh`)
> ```Generate a periodic square wave having a period of 15 ms and a duty cycle of 20% in 8051 using assembly programming. The waveform should be produced at pin zero of port two (P2.0). The XTAL frequency is 11.0592 MHz and use Timer 1 in mode 0 (13-bit timer mode)```

Solution:
1. [15ms Square Wave Assembly](./assembly/square_15ms.asm)
2. [15ms Square Wave C](./embedded_c/square_15ms.c)

### 6. [6] (`77 Ch`)
> ```Write an assembly program to design a down counter that counts from 99 to 00```

Solution:
1. [99 Counter Assembly](./assembly/counter.asm)
2. [99 Counter C](./embedded_c/counter.c)

### 7. [6] (`76 Ba`)
> ```Using 8051 instructions, control rate of blink of LED at pin P1.1 by two switches at P2.1 and P2.2 (One switch to increase rate of blink, another to decrease the rate of blink)```

Solution:
1. [Blinker Control Assembly](./assembly/speed_control.asm)
2. [Blinker Control C](./embedded_c/speed_control.c)

### 8. [4] (`75 Ba`)
> ```Write an assembly language programming to blink 8 led connected at port 2 of 8051 microcontroller.```

solution:
1. [Simple blinker Assembly](./assembly/blink_all.asm)
2. [Simple blinker C](./embedded_c/blink_all.c)

### 9. [4] (`73 Ma`)
> ```Write an assembly language programming to blink 8 led connected at port 2 of 8051 microcontroller.```

solution:
1. [Port Reader Assembly](./assembly/port_reader.asm)
2. [Port Reader C](./embedded_c/port_reader.c)

### 10. [4] (`71 Ma`)
> ```Write a program in assembly language that computes a precise 5-millisecond delay using 8051 micro-controller.```

solution:
1. [5 MS Delay Assembly](./assembly/5_ms.asm)
2. [5 MS Delay C](./embedded_c/5_ms.c)

### 11. [4] (`72 Ash`)
> ```Write a program using C-programming language to find the sum between two 8-bit BCD data stored in RAM locations 50H and 51H and store the BCD sum at RAM locations 52H and 53H.```

solution:
1. [Adder Assembly](./assembly/adder.asm)
2. [Adder C](./embedded_c/adder.c)
