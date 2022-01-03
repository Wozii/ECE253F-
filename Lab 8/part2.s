.global _start
.global SWAP
_start:
	LDR R10, =LIST
	LDR R5, [R10] //takes number of elements
	MOV R11, #1 //counter for LOOPi
	LOOPi: 
		CMP R11, R5
		BEQ END
		
		MOV R6, R10 
		ADD R6, #4 //first element adr
		
		MOV R12, R11 //LOOPj counter		
		LOOPj: 
			CMP R12, R5 
			BEQ BREAK //exit loop if R12 = R5
			MOV R0, R6 //put first element adr into R0 
			BL SWAP
			ADD R6, #4
			ADD R12, #1
			B LOOPj
		BREAK: ADD R11, #1
		B LOOPi

SWAP:
	ADD R1, R0, #4
	LDR R2, [R0]
	LDR R3, [R1]
	CMP R2, R3
	BLT ENDSWAP
	STR R3, [R0]
	STR R2, [R1]
	
	MOV R0, #1
	MOV PC, LR
ENDSWAP: 
	MOV R0, #0
	MOV PC, LR

END: B END
.end