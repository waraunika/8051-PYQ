ORG 0000H
	MOV P2, #00H; Port 2 with all LEDs OFF
	MOV A, #01H ; start with LSB LED ON (bit 0)
	
MAIN:
	MOV P2, A ; Output to Port 2
	ACALL DELAY ; Wait for some time
	RL A ; Rotate left (shift bit to next LED)
	SJMP MAIN ; Repeat forever

DELAY:
	MOV R0, #0FFH
DELAY1:
	MOV R1, #0FFH
DELAY2:
	DJNZ R1, DELAY2
	DJNZ R0, DELAY1
	RET
	
END
