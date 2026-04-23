ORG 0100H
PATTERNS:
    DB 3FH, 06H, 5BH, 4FH, 66H  ; 0 to 4
    DB 6DH, 7DH, 07H, 7FH, 6FH  ; 5 to 9

ORG 0000H
    SJMP START

START:
    MOV P1, #00H ; clear data port for lsb
	MOV P0, #00H ; clear data port for msb
	MOV P2, #0C0H ; intialize control port
	
	MOV R0, #00H ; second ones (so) digit, starting at 0
	MOV R1, #00H ; second tens (st) digit, starting at 0
	
	; control pins are P2.7 for lsb (P1) P2.6 for msb(P0)

	MOV DPTR, #PATTERNS
	MOV TMOD, #01H
	
MAIN: ; this is wayyyyyyyyyyyyyy too short of a delay to be simulated properly
; calculation:
; 2 ms = 2000 ms, machine cycle = 1.085 us for 11.0592 MHz clock
; total cycle neeeded = 2000/1.085 = 1843
; counting cycle = 2^16 - 1843 = 63693, which when converted to hexa
; gives F8CDH.
	MOV TH0, #0F8H
	MOV TL0, #0CDH
	SETB TR0
	JNB TF0, $
	CLR TF0
	CLR TR0
		
	ACALL DISPLAY
	
	ACALL COUNT_UP
	
	SJMP MAIN
	
DISPLAY:
	MOV P2, #0 ; clear all pin
	MOV P2, #80H ; enable only lsb pin
	
	MOV A, R0
	MOVC A, @A+DPTR
	MOV P1, A
	
	ACALL SHORT_DELAY
	
	MOV P2, #0 ; clear all pin
	MOV P2, #40H ; enable only msb pin
	
	MOV A, R1
	MOVC A, @A+DPTR
	MOV P0, A
	
	ACALL SHORT_DELAY
	
	RET
	
SHORT_DELAY:
    MOV R6, #255
SD_LOOP:
    DJNZ R6, SD_LOOP
    RET
	
COUNT_UP:
	INC R0
	CJNE R0, #10, CHECK_MSB
	MOV R0, #00H
	INC R1
CHECK_MSB:
	CJNE R1, #10, RETURN
	MOV R1, #00H
RETURN:
	RET
END
