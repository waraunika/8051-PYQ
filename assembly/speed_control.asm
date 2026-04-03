; READ COMMENT AT THE END

ORG 0000H
	SJMP MAIN

MAIN:
	MOV R0, #150 ; baase delay for outer loop of delay function
	
LOOP:
	; check switch in priority order P2.1, if not P2.1 then P2.2
	JB P2.1, INCREASE ; if P2.1 is high, jump to increase rate
	JB P2.2, DECREASE ; if p2.2 is high, jump to decrease rate
	SJMP BLINK ; neither pressed, use base delay
	
INCREASE:
	MOV R0, #75 ; faster blink = smaller delay
	SJMP BLINK
	
DECREASE:
	MOV R0, #250 ; slower blink = larger delay
	
BLINK:
	SETB P1.1 ; turn the led on
	CALL DELAY
	
	CLR P1.1 ; turn off the led
	CALL DELAY
	
	SJMP LOOP
	
DELAY:
    MOV A, R0 ; moving from register to register not allowed      
    MOV R5, A
    
DELAY_OUTER:
    MOV R1, #255 ; inner loop with fixed 255 value
DELAY_INNER:
    DJNZ R1, DELAY_INNER
    DJNZ R5, DELAY_OUTER ; r0 not to be used as counter
    RET
	
END

; OR
;
; DELAY:
;	  MOV R1, #255 ; inner loop with fixed 255 value
; DELAY_INNER:
;	  DJNZ R1, DELAY_INNER
;	  DJNZ R0, DELAY
;	  RET
;
;	  This is a bit tricky.
;	  originally i had this commented out version of DELAY, but i ran into a problem.
;	  i couldn't get it to work with base speed.
;	  if neither of the switch was ON, then it just wouldn't use normal speed, it would
;	  revert back to slower blinking speed.
;
;	  however, this new delay function, despite being nearly identical, has a tiny improvement
;	  now, we can see the base speed to be working, but i ran into another problem
;	  now, you just cannot revert back to base speed after toggling any switch.
;	  at first, if its on base speed, and you toggle faster or slower switch, it works fine
;	  but as soon as you untoggle both switch, it just wouldn't go back to base speed.
;
;	  i've already wasted a lot of time on this, so i cannot deliver a perfect version, hopefully
;	  this is good enough
