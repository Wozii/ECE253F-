.text
.global _start
_start:
	LDR R0, =TEST_NUM
	LDR R1, [R0], #4
	MOV R7, #0
	MOV R8, #0
	LOOP: CMN R1, #1
	BEQ END 		
		ADD R7, R7, R1
		ADD R8, R8, #1
		LDR R1, [R0], #4
	B LOOP
END: B END

