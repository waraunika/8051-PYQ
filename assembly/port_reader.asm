ORG 0000H

MAIN:
    MOV P0, #00H ; starting with all led off

LOOP:
    MOV A, P1 ; read all 8 switches from Port 1
    MOV P0, A ; display switch states on LEDs
    
    SJMP LOOP
    
END
