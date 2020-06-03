initial_sp:        .word    0x201FFFFC
reset_vector:     .word     _main
_main:	ldr	r0, =0x40010000
		
		movs	r1, #88
 		movs	r2, #120
		ldr r3, = 0xFF000000
 		movs r7, #0
	
you_win:
	add r7, r7, #1
	
	cmp r7, #1
	beq yol
	
	add r1, r1, #5	
	add r2, r2, #1
	cmp r7, #2
	beq yol
	cmp r7, #3
	beq yol
	sub r1, r1, #8
	cmp r7, #4
	beq yol
	cmp r7, #5
	beq yol
	sub r2, r2, #12
	add r1, r1, #16
	cmp r7, #6
	beq yol
	add r2, r2, #8
	sub r1, r1, #8
	cmp r7, #7
	beq yol
	cmp r7, #8
	beq yol
	sub r1, r1, #20
	add r2, r2, #16
	cmp r7, #9
	beq yol
	add r1, r1, #20
	sub r2, r2, #16
	cmp r7, #10
	beq yol
	cmp r7, #11
	beq yol
	cmp r7, #12	
	beq yol
	add r2, r2, #4
	cmp r7, #13
	beq yol
	sub r1, r1, #4
	cmp r7, #14
	beq yol
	cmp r7, #15
	beq yol
	sub r1, r1, #4
	cmp r7, #16
	beq yol
	sub r2, r2, #4
	cmp r7, #17
	beq yol
	cmp r7, #18
	beq yol
	cmp r7, #19
	beq yol
	sub r2, r2, #4
	cmp r7, #20
	beq yol
	add r1, r1, #4
	cmp r7, #21
	beq yol
	cmp r7, #22
	beq yol
	add r2, r2, #24
	cmp r7, #23
	beq yol
	b devam
yol: b kare3
devam:	
	add r1, r1, #4
	sub r2, r2, #20
	cmp r7, #24
	beq yol
	cmp r7, #25
	beq yol
	cmp r7, #26
	beq yol
	cmp r7, #27
	beq yol
	add r2, r2, #4
	cmp r7, #28
	beq yol
	sub r1, r1, #4
	cmp r7, #29
	beq yol
	cmp r7, #30
	beq yol
	sub r1, r1, #4
	cmp r7, #31
	beq yol
	sub r2, r2, #4
	cmp r7, #32
	beq yol
	cmp r7, #33
	beq yol
	cmp r7, #34
	beq yol
	cmp r7, #35
	beq yol

	add r1, r1, #36
	sub r2, r2, #52
	cmp r7, #36
	beq kare3
	sub r1, r1, #28
	add r2, r2, #52
	cmp r7, #37
	beq kare3
	cmp r7, #38
	beq kare3
	cmp r7, #39
	beq kare3
	cmp r7, #40
	beq kare3
	cmp r7, #41
	beq kare3
	sub r1, r1, #8
	add r2, r2, #4
	cmp r7, #42
	beq kare3
	cmp r7, #43
	beq kare3
	add r1, r1, #8
	cmp r7, #44
	beq kare3
	cmp r7, #45
	beq kare3
	sub r1, r1, #8
	sub r2, r2, #4
	cmp r7, #46
	beq kare3
	cmp r7, #47
	beq kare3
	cmp r7, #48
	beq kare3
	cmp r7, #49
	beq kare3
	cmp r7, #50
	beq kare3
	add r1, r1, #4
	add r2, r2, #8
	cmp r7, #51
	beq kare3
	add r1, r1, #4
	sub r2, r2, #8
	cmp r7, #52
	beq kare3
	cmp r7, #53
	beq kare3
	cmp r7, #54
	beq kare3
	cmp r7, #55
	beq kare3
	cmp r7, #56
	beq kare3
	sub r1, r1, #24
	add r2, r2, #8
	cmp r7, #57
	beq kare3
	add r1, r1, #24
	sub r2, r2, #8
	cmp r7, #58
	beq kare3
	cmp r7, #59
	beq kare3
	cmp r7, #60
	beq kare3
	cmp r7, #61
	beq kare3
	cmp r7, #62
	beq kare3
	sub r1, r1, #20
	add r2, r2, #4
	cmp r7, #63
	beq kare3
	add r1, r1, #20
	add r2, r2, #0
	cmp r7, #64
	beq kare3
	cmp r7, #65
	beq kare3
	cmp r7, #66
	beq kare3
	sub r2, r2, #4
	cmp r7, #67
	beq kare3
	sub r1, r1, #12
	cmp r7, #68
	beq kare3
	add r1, r1, #4
	cmp r7, #69
	beq kare3
	cmp r7, #70
	beq kare3
	cmp r7, #71
	beq kare3
	
	b finish




kare3:
	
		add r3, r3, #1
		mul r3, r3, r2
	     
	    sub r2, r2, #1
	    sub r1, r1, #1
	    add r4, r1, #4
	    add r5, r2, #4
b:		add r2, r2, #1
a:		add r1, r1, #1	
		str r1, [r0]
		str r2, [r0, #4]
		str r3, [r0, #8]
		
		cmp r1, r4
		bne a
		sub r1, r1, #4
		cmp r2, r5
		bne b
		
		str	r3, [r0, #12]
	
		b you_win
		
		
			
finish: 
		
		lsr r0, r0, #4
		movs r1, #0
z:		add r1, r1, #100
		
		
		cmp r1, r0
		bls z

		movs	r1, #88
 		movs	r2, #119
			
	
 		movs r7, #0
		
		add r3, r3, #1
			
		lsl r0, r0, #4
		
	
b you_win
