; for DEBUGGING, i'm putting the value manually to see output later
; no need to write in exam
ORG 0040H
	DB 55H ; 55H = 0101 0101, so, expected output = 4

ORG 0000H
	SJMP MAIN
	
MAIN:
	MOV P2, #00H ; clear port 2
	
	; read data from ROM address 40H
	MOV DPTR, #0040H ; point to ROM at 40H
	CLR A ; clear accumulator
	MOVC A, @A+DPTR ; move ROM data to accumulator (A = [40H])
	
	; count 0 by rotating
	MOV R0, #08H ; set counter for 8 bit
	MOV R1, #00H ; cleara R1 to store zero count
	
COUNT_ZEROS:
	RRC A ; rotate right through carry flag
	JC BIT_IS_ONE ; if carry = 1, bit is 1, skip increment
	INC R1 ; since carry != 1, bit is 0, increment
	
BIT_IS_ONE:
	DJNZ R0, COUNT_ZEROS ; repeat for all 8 bits
	
	; Store result in RAM at 41H
	MOV 41H, R1 ; store zero count in RAM 41H
	
	; this is just for DEBUGGING purpose
	; you don't need to write this in exam
	MOV P2, R1 ; output zero count to Port 2
	
	SJMP $ ; program gets stuck here as ending of infinite loop
	
END