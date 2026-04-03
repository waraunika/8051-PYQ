ORG 0050H
    DB 99H
    DB 99H 
		
ORG 0000H
    SJMP MAIN

MAIN:    
    MOV A, 50H
    ADD A, 51H
    DA A

    MOV 52H, A 

    MOV 53H, #00H ; assume no carry
    JNC NO_CARRY
    MOV 53H, #01H ; set if carry occurred

NO_CARRY:
    SJMP $

END
