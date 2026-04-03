ORG 0000H
	SJMP MAIN
	
MAIN:
	MOV TMOD, #00H ; Timer 1, mode 9 : 13 bit timer
	
	; 15ms wave
	; if at 20% duty cycle, on period = 3 ms, off = 12 ms
	; one machine cycle = 12 clock period
	; machine cycle = 12 * (1/f) = 12/11.0592M = 1.085 us
	
	; 3 ms : 3000 us / 1.085 us = 2765 cycles
	; 12 ms: 12000us / 1.085 us = 11059 cycles 
	
	; but, max cycle count = 2^13 = 8192, so 12 ms : 8192 + 2867
	; one full timer + 2867 cycles.

	; for 2765, timer value = 8192 - 2765 = 5427 = 1533H
	; in binary, 1533H = 0001 0101 0011 0011
	; so we shift to right by 3 bits for higher byte and 3 bits in lower byte is don't care
	; 1010 1001 (000)1 0011
	; TH1 = 1010 1001 = A9H;
	; TL1 = 0001 0011 = 13H;
	
	; NOTE: while simulating in proteus, this got 2.78 ms, not 3ms
	
	SETB P2.0 ; start with HIGH 3ms
	MOV TH1, #0A9H
	MOV TL1, #13H
	
	SETB TR1 ; start timer
WAIT_HIGH: ; wait timer for 3 ms
	JNB TF1, WAIT_HIGH ; wait for overflow flag
	CLR TF1 ; clear overflow flag
	CLR TR1 ; stop timer
	
	; OFF period: 12ms (P2.0 LOW)
	CLR P2.0
	
	; fully count one entire timer of 8192
	MOV TL1, #00H
	MOV TH1, #00H
	SETB TR1
	
WAIT_LOW1:
	JNB TF1, WAIT_LOW1
	CLR TF1
	CLR TR1
	
	; second part: 2867 cycles, so count = 8192 - 2867 = 5325
	; 5325 in hex = 14CD H
	; in binary = 0001 0100 1100 1101
	; right shift by 3 for higher byte and introduce 3 bits in msb of lower byte
	; 1010 0110 (000)0 1101
	; new value = A6 0D H
	
	; NOTE: while simulating in proteus, this got 11.1 ms, not 12ms
	
	MOV TH1, #0A6H
	MOV TL1, #0DH
	SETB TR1
	
WAIT_LOW2: ; wait timer for 2nd phase of 12 ms
	JNB TF1, WAIT_LOW2
	CLR TF1
	CLR TR1
	
	SJMP MAIN
END