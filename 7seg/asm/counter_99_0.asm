ORG 0100H
PATTERNS:
    DB 3FH, 06H, 5BH, 4FH, 66H  ; 0 to 4
    DB 6DH, 7DH, 07H, 7FH, 6FH  ; 5 to 9

ORG 0000H
    SJMP START

START:
    MOV P0, #00H ; clear data port
    MOV P2, #0C0H ; initialize control port
    
    MOV R1, #09H ; tens digit (start at 9)
    MOV R0, #09H ; ones digit (start at 9)
    MOV DPTR, #PATTERNS
    
MAIN:
    ; Display current number for a while
    MOV R5, #0FFH ; long delay counter
DELAY_LONG:
    ACALL DISPLAY ; show the number
    DJNZ R5, DELAY_LONG
    
    ACALL COUNT_DOWN ; decrement the counter
    
    MOV A, R1 ; see if tens place is 0
    JNZ MAIN  ; if not zero, keep on looping
    MOV A, R0 ; if zero, see if ones place is also zero
    JNZ MAIN  ; if not zero, keep on looping
    
    MOV R0, #09H ; if zero, reset counter to 99
    MOV R1, #09H
	
    SJMP MAIN

DISPLAY:
    ; show ones digit
    SETB P2.7 ; enable first display
    CLR P2.6  ; disable second display
    
    MOV A, R0
    MOVC A, @A+DPTR
    MOV P0, A
    
    ACALL SHORT_DELAY
    
    ; Show tens digit
    CLR P2.7  ; disable first display
    SETB P2.6 ; enable second display
    
    MOV A, R1
    MOVC A, @A+DPTR
    MOV P0, A
    
    ACALL SHORT_DELAY
    
    CLR P2.6 ; turn off both displays
    RET

COUNT_DOWN:
    DEC R0 ; Decrement ones
    CJNE R0, #255, CHECK_TENS ; if not underflow, continue
    MOV R0, #09H ; reset ones to 9
    DEC R1       ; decrement tens
CHECK_TENS:
    CJNE R1, #255, DONE
    MOV R1, #09H ; reset tens to 9
DONE:
    RET

; NOTE: the delay is quite short, add nested looping if you want
SHORT_DELAY:
    MOV R6, #255
SD_LOOP:
    DJNZ R6, SD_LOOP
    RET

END
