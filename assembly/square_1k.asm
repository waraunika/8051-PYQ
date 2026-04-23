ORG 0000H
	SJMP MAIN
	
MAIN:
	MOV TMOD, #01H ; Timer 0, mode 1 : 16 bit timer
	
	; 1kHz wave
	; if at 50% duty cycle, on period = 500 us, off = 500 us
	; one machine cycle = 12 clock period
	; machine cycle = 12 * (1/f) = 12/11.0592M = 1.085 us
	
	; initial value for 500 us at 11.0592 MHz
	; 500 us / 1.085 us = 461 cycles
	; timer value = 65536 - 461 = FE33H
	
	; NOTE: while simulating in proteus, this got 0.47 ms not 0.5 ms
	MOV TH0, #0FEH
	MOV TL0, #33H
	
	CLR P1.5
	SETB TR0
	
AGAIN:
  SETB TR0
	JNB TF0, $ ; wait for overflow flag
	CLR TF0 ; clear overflow flag
  CLR TR0

	CPL P1.5 ; toggle between high and low
	
	; reload timer
	MOV TH0, #0FEH
	MOV TL0, #33H
	
	SJMP AGAIN
END
