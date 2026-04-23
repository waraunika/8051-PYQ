ORG 0100H
PATTERNS:
    DB 0C0H, 0F9H, 0A4H, 0B0H, 99H  ; 0 to 4
    DB 92H, 82H, 0F8H, 80H, 90H  ; 5 to 9

ORG 0000H
    SJMP START

START:
    MOV P1, #00H ; clear data port
	MOV P2, #0CH ; intialize control port
	
	MOV R0, #00H ; second ones (so) digit, starting at 0
	MOV R1, #00H ; second tens (st) digit, starting at 0
	MOV R2, #00H ; minute ones (mo) digit, starting at 0
	MOV R3, #00H ; minute ones (mt) digit, starting at 0
	
	; control pins are P2.0-3 0 for mt, 1 for mo, 2 fr st, 3 for so
	
MAIN:
	MOV R5, #0FFH
DELAY_LONG:
	ACALL DISPLAY
	DJNZ R5, DELAY_LONG
	
	ACALL COUNT_UP
	
	SJMP MAIN
	
DISPLAY:
	MOV P2, #0
	MOV P2, #08H ; enable only so pin
	
	MOV DPTR, #PATTERNS
	MOV A, R0
	MOVC A, @A+DPTR
	MOV P0, A
	
	ACALL SHORT_DELAY
	
	MOV P2, #0
	MOV P2, #04H ; enable only st pin
	
	MOV A, R1
	MOVC A, @A+DPTR
	MOV P0, A
	
	ACALL SHORT_DELAY
	
	MOV P2, #0
	MOV P2, #02H ; enable only mo pin
	
	MOV A, R2
	MOVC A, @A+DPTR
	MOV P0, A
	
	ACALL SHORT_DELAY
	
	MOV P2, #0
	MOV P2, #01H ; enable only mt pin
	
	MOV A, R3
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
	CJNE R0, #10, CHECK_ST
	MOV R0, #00H
	INC R1
CHECK_ST:
	CJNE R1, #6, CHECK_MO
	MOV R1, #00H
	INC R2
CHECK_MO:
	CJNE R2, #10, CHECK_MT
	MOV R2, #0
	INC R3
CHECK_MT:
	CJNE R3, #6, RETURN
	MOV R3, #0
RETURN:
	RET
END
