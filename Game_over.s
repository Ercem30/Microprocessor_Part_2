initial_sp:        .word    0x201FFFFC
reset_vector:     .word     _main
_main:	ldr	r0, =0x40010000
		
		movs	r1, #88
		

 		movs	r2, #120
		
		ldr r3, = 0xFFFFFFFF
			
		add  r6, r2, #6
		add  r6, r6, #6
 		movs r7, #1
		
	

		
					
	Game_over:
	cmp r7, #1
	bne x		 
	add  r1, r1, #1
	add  r2, r2, #1	
	cmp  r2, r6
	bls yol

x:  add  r7, r7, #1
	
	add  r1, r1, #4
	cmp r7, #2
	beq yol
	
	sub r1, r1, #3
	sub r2, r2, #19
	cmp r7, #3
	beq yol
	
	add r1, r1, #4
	add r2, r2, #16
	cmp r7, #4
	beq yol
	cmp r7, #5
	beq yol
	cmp r7, #6
	beq yol

	add r2, r2, #4
	cmp r7, #7
	beq yol

	sub r1, r1, #4
	cmp r7, #8
	beq yol

	cmp r7, #9
	beq yol

	sub r1, r1, #4
	cmp r7, #10
	beq yol

	sub r2, r2, #4
	cmp r7, #11
	beq yol

	add r1, r1, #4
	sub r2, r2, #4
	cmp r7, #12
	beq yol
	sub r1, r1, #8
	add r2, r2, #16
	cmp r7, #13
	beq yol
	add r1, r1, #12
	sub r2, r2, #12
	cmp r7, #14
	beq yol
	cmp r7, #15
	beq yol
	cmp r7, #16
	beq yol
	cmp r7, #17
	beq yol
	sub r1, r1, #24
	add r2, r2, #4
	cmp r7, #18
	beq yol
	add r1, r1, #20
	cmp r7, #19
	beq yol
	cmp r7, #20
	beq yol
	add r1, r1, #4
	cmp r7, #21
	beq yol
	sub r2, r2, #4
	cmp r7, #22
	beq yol
	cmp r7, #23
	beq yol
	cmp r7, #24
	beq yol
	cmp r7, #25
	beq yol
	sub r1, r1, #16
	sub r2, r2, #12
	cmp r7, #26
	beq yol
	add r1, r1, #12
	add r2, r2, #16
	cmp r7, #27
	beq yol
	cmp r7, #28
	beq yol
	sub r1, r1, #8
	add r2, r2, #8
	cmp r7, #29
	beq yol
	b devam
yol: b kare3
devam:	
	add r1, r1, #12
	sub r2, r2, #12
	cmp r7, #30
	beq yol
	cmp r7, #31
	beq yol
	cmp r7, #32
	beq yol
	cmp r7, #33
	beq yol
	cmp r7, #34
	beq yol
	sub r1, r1, #20
	add r2, r2, #4
	cmp r7, #35
	beq yol
	add r1, r1, #20
	cmp r7, #36
	beq yol
	sub r1, r1, #8
	cmp r7, #37
	beq yol
    cmp r7, #38
	beq yol
	add r1, r1, #8
	sub r2, r2, #4
	cmp r7, #39
	beq yol
	cmp r7, #40
	beq yol
	cmp r7, #41
	beq yol
	cmp r7, #42
	beq yol
	cmp r7, #43
	beq yol
	sub r1, r1, #24
	add r2, r2, #8
	cmp r7, #44
	beq yol
	add r1, r1, #24
	sub r2, r2, #8
	cmp r7, #45
	beq yol
	cmp r7, #46
	beq yol
	cmp r7, #47
	beq yol
	cmp r7, #48
	beq yol
	cmp r7, #49
	beq yol
	sub r1, r1, #24
	add r2, r2, #4
	cmp r7, #50
	beq yol
	add r1, r1, #20
	cmp r7, #51
	beq yol
	cmp r7, #52
	beq yol
	cmp r7, #53
	beq yol
	add r1, r1, #8
	sub r2, r2, #16
	cmp r7, #54
	beq yol
	sub r1, r1, #8
	add r2, r2, #16	
	cmp r7, #55
	beq yol
	cmp r7, #56
	beq yol
	add r1, r1, #12
	sub r2, r2, #12
	cmp r7, #57
	beq yol
	sub r1, r1, #12
	add r2, r2, #12
	cmp r7, #58
	beq yol
	cmp r7, #59
	beq yol
	cmp r7, #60
	beq yol
	add r1, r1, #16
	sub r2, r2, #92
	cmp r7, #61
	beq yol
	sub r1, r1, #12
	add r2, r2, #88
	cmp r7, #62
	beq yol
	cmp r7, #63
	beq yol
	cmp r7, #64
	beq yol
	add r2, r2, #4
	cmp r7, #65
	beq yol
	sub r1, r1, #4
	cmp r7, #66
	beq yol
	cmp r7, #67
	beq yol
	sub r1, r1, #4
    cmp r7, #68
	beq yol
	sub r2, r2, #4
	cmp r7, #69
	beq yol
	cmp r7, #70
	beq yol
	cmp r7, #71
	beq yol
	sub r2, r2, #4	
	cmp r7, #72
	beq yol
	add r1, r1, #4
	cmp r7, #73
	beq yol
	cmp r7, #74
	beq yol
	add r2, r2, #24
	cmp r7, #75
	beq yol
	sub r2, r2, #20
	add r1, r1, #4
	cmp r7, #76
	beq kare3
	cmp r7, #77
	beq kare3
	add r2, r2, #4
	cmp r7, #78
	beq kare3
	cmp r7, #79
	beq kare3
	sub r2, r2, #4
	cmp r7, #80
	beq kare3
	sub r1, r1, #12
	add r2, r2, #4
	cmp r7, #81
	beq kare3
	add r1, r1, #4
	cmp r7, #82
	beq kare3
	sub r2, r2, #4
	cmp r7, #83
	beq kare3
	cmp r7, #84
	beq kare3
	add r1, r1, #4
	add r2, r2, #8
	cmp r7, #85
	beq kare3
	sub r2, r2, #8
	add r1, r1, #4
	cmp r7, #86
	beq kare3
	cmp r7, #87
	beq kare3
	cmp r7, #88
	beq kare3
	cmp r7, #89
	beq kare3
	cmp r7, #90
	beq kare3
	sub r1, r1, #24
	add r2, r2, #4
	cmp r7, #91
	beq kare3
	add r1, r1, #20
	cmp r7, #92
	beq kare3
	cmp r7, #93
	beq kare3
	cmp r7, #94
	beq kare3
	add r1, r1, #8
	sub r2, r2, #16
	cmp r7, #95
	beq kare3
	sub r1, r1, #8
	add r2, r2, #16
	cmp r7, #96	
	beq kare3
	cmp r7, #97
	beq kare3
	add r1, r1, #12
	sub r2, r2, #12
	cmp r7, #98	
	beq kare3
	sub r1, r1, #12
	add r2, r2, #12
	cmp r7, #99	
	beq kare3
	cmp r7, #100	
	beq kare3
	cmp r7, #101	
	beq kare3
	sub r1, r1, #20
	add r2, r2, #4
	cmp r7, #102	
	beq kare3
	add r1, r1, #24
	sub r2, r2, #8
	cmp r7, #103	
	beq kare3
	cmp r7, #104	
	beq kare3
	cmp r7, #105	
	beq kare3
	cmp r7, #106	
	beq kare3
	cmp r7, #107	
	beq kare3
	sub r1, r1, #24
	add r2, r2, #4
	cmp r7, #108	
	beq kare3
	add r1, r1, #20
	cmp r7, #109	
	beq kare3
	cmp r7, #110	
	beq kare3
	add r1, r1, #4
	cmp r7, #111	
	beq kare3	
	sub r2, r2, #8
	cmp r7, #112	
	beq kare3
	sub r1, r1, #4
	cmp r7, #113	
	beq kare3
	cmp r7, #114	
	beq kare3
	add r1, r1, #4
	add r2, r2, #8
	cmp r7, #115	
	beq kare3
	cmp r7, #116	
	beq kare3
	cmp r7, #117	
	beq kare3
	b finish

kare3:
	    add r3, r3, #5
	    mul r3, r3, r1
	    
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
	
		b Game_over	
		


finish: 
		lsr r0, r0, #4
		movs r1, #0
z:		add r1, r1, #120
		cmp r1, r0
		bls z

		movs	r1, #88
 		movs	r2, #120	
		add  r6, r2, #6
		add  r6, r6, #6
 		movs r7, #1
		
		add r3, r3, #1
		lsl r0, r0, #4
b Game_over

