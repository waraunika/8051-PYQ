ORG 0000H
    SJMP BLINK

DELAY_5MS:
    MOV TMOD, #10H ; Timer 1, Mode 1 (16-bit)
    
	; assuming 11.0592 MHz
    ; 5ms = 5000µs / 1.085µs = 4608 cycles
    ; timer value = 65536 - 4608 = 60928 = EE00H
	
	; NOTE: while simulating in proteus this got 5.01 ms not 5 ms
    MOV TH1, #0EEH ; Load high byte (EEH)
    MOV TL1, #00H ; Load low byte (00H)
    
    SETB TR1 ; Start Timer 1
WAIT:
    JNB TF1, WAIT ; Wait for overflow
    CLR TF1 ; clear overflow flag
    CLR TR1 ; stop Timer 1
    RET
    
BLINK:
    SETB P0.0
    ACALL DELAY_5MS
    CLR P0.0
    ACALL DELAY_5MS
    SJMP BLINK

END
