.equ TIMER, 0XFFFEC600
.equ LEDR, 0XFF200000
.equ KEYS, 0XFF200050
.equ PERIOD, 50000000

.global _start
_start:
    LDR R4, =LEDR
    LDR R5, =TIMER
    LDR R6, =PERIOD
	LDR R7, =KEYS
	LDR R9, [R7]
    STR R6, [R5]
    MOV R6, #0b011 // A = 1, E = 1
    STR R6, [R5, #8]
    
    MOV R0, #512
    MOV R1, #1
    MOV R12, #0 //store LEDR direction, 0 for inwards, 1 for outwards
    ADD R2, R1, R0
    B DISPLAY    

DISPLAY: 
    STR R2, [R4] //update LEDR
    
//shifting     
SHIFT:    
	CMP R12, #0
    BEQ IN_SHIFT
	CMP R12, #1 
	BEQ OUT_SHIFT

IN_SHIFT:
    LSR R0, R0, #1
    LSL R1, R1, #1
	CMP R0, #32
    MOVEQ R12, #1
    ADD R2, R0, R1
    B KEY_CHECK
    
OUT_SHIFT: 
    LSL R0, R0, #1 
    LSR R1, R1, #1
	CMP R0, #512
    MOVEQ R12, #0
    ADD R2, R0, R1
    B KEY_CHECK

KEY_CHECK: 
	LDR R3, [R7]
	CMP R3, #0x8
	BEQ PRESS1
	B DELAY

PRESS1:
	LDR R3, [R7]
	CMP R3, #0
	BEQ RELEASE1
	MOV R9, R3
	B DELAY

RELEASE1:
	LDR R3, [R7]
	CMP R3, #0x8
	BEQ PRESS2
	B RELEASE1

PRESS2: 
	LDR R3, [R7]
	CMP R3, #0
	BEQ DELAY
	B PRESS2

INTER:
	MOV R9, R3
	B PRESS1

DELAY: 
    LDR R8, [R5, #0xC] //load status reg
	
	LDR R3, [R7]
	CMP R3, R9
	BNE INTER
	
    CMP R8, #0
    BEQ DELAY    
    STR R8, [R5, #0xC]
	B DISPLAY
	