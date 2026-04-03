ORG 0000H
	SJMP MAIN
	
MAIN:
	MOV P1, #0FFH; Port 1 as input
	MOV P2, #00H ; Port 2 as output

READ_TEMP:
	MOV A, P1 ; read celsium from P1
	
	CJNE A, #0FFH, CONVERT ; if not 255, continue
	SJMP READ_TEMP ; re read if invalid
	
CONVERT:
	MOV R0, A ; save original celsius value to R0
	
	MOV B, #09H
	MUL AB ; C x 9
	
	MOV B, #05H
	DIV AB ; (C x 9) / 5
	ADD A, #32 ; + 32
	
	MOV P2, A
	
	ACALL DELAY_MS
	SJMP READ_TEMP

DELAY_MS:
	; Approx 1ms delay at 12 MHz crystal
	MOV R7, #02H
DELAY_MS_LOOP:
	MOV R6, #0FFH
	DJNZ R6, $
	DJNZ R7, DELAY_MS_LOOP
	RET
	
END

