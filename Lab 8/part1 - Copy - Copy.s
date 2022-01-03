.text
.global _start
.global ONES
_start: 
	MOV R0, #0
	MOV R5, #0
	LDR R3, =TEST_NUM	
LOOP1:
	LDR R1, [R3], #4
	CMP R1, #-1
	BEQ END
	BL ONES
	CMP R5, R0
	MOVMI R5, R0
	B LOOP1

END: B END

ONES:	
	MOV R0, #0
LOOP2: CMP R1, #0
	BEQ ENDSUB
	LSR R2, R1, #1
	AND R1, R1, R2
	ADD R0, #1
	B LOOP2
ENDSUB: 
	MOV PC, LR
.end
	
	