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
	
	; NOTE: while simulating in proteus, this got 0.97 ms not 1 ms
SETVALUE:
	MOV TH0, #0FEH
	MOV TL0, #33H
	
	CPL P1.5
  ACALL TIMER_START
	SJMP SETVALUE
	
TIMER_START:
  SETB TR0
WAIT:
  JNB TF0, WAIT
  CLR TR0 ; clear timer start flag
	CLR TF0 ; clear overflow flag
  RET

END
