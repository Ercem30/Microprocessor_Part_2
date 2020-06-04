initial_sp:        .word    0x201FFFFC
reset_vector:     .word     _main
_main:	ldr	r0, =0x40010000	
		movs	r1, #80   //silinecek 12x13 lük objenin sol üst köşe adresleri r1->row r2->column
 		movs	r2, #100 
 		
 		ldr r3, =0xFFFF9933 //orange	
frame1:	add	r2, r2, #6		
		add	r1, r1, #4
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2,r2, #1
		add r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2,r2, #1
		add r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2,r2, #1
		sub r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		str	r3, [r0, #12]	//refresh the screen 
		
		//delay
		lsr r0, r0, #4
		movs r4, #0
x:		add r4, r4, #90
		cmp r4, r0
		bls x
		lsl r0, r0, #4
		
		str	r3, [r0, #0x10]
		
		ldr r3, =0xFFFF6666 //pink
frame2:	sub	r1, r1, #4
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2,r2, #1
		sub r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2,r2, #1
		add r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2,r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2,r2, #1
		add r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2,r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2,r2, #1
		add r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2,r2, #1
		add r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2,r2, #1
		add r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2,r2, #1
		add r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2,r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
				
		sub r2,r2, #1
		add r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		sub r2,r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
				
		sub r2,r2, #1
		add r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2,r2, #1
		sub r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub	r2,r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2,r2, #1
		sub r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub	r2,r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2,r2, #1
		sub r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2,r2, #1
		sub r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
			
		sub r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2,r2, #1
		sub r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2,r2, #1
		sub r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2,r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2,r2, #1
		sub r1,r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		str	r3, [r0, #12]	//refresh the screen 
		
		//delay
		lsr r0, r0, #4
		movs r4, #0
y:		add r4, r4, #90
		cmp r4, r0
		bls y
		lsl r0, r0, #4
		
		str	r3, [r0, #0x10]
		
		ldr r3, =0xFF99004C //purple
frame3:	sub	r1, r1, #5
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2,r2, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub	r1, r1, #1
		add r2,r2, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add	r1, r1, #1
		add r2,r2, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2,r2, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add	r1, r1, #1
		add r2,r2, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2,r2, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add	r1, r1, #1
		add r2,r2, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2,r2, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
	
		add	r1, r1, #1
		add r2,r2, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2,r2, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add	r1, r1, #1
		add r2,r2, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
				
		add	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add	r1, r1, #1
		add r2,r2, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
				
		add	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		
		add	r1, r1, #1
		add r2,r2, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
				
		add	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		add	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
	
		add	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		add	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
	
		add	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		add	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
	
		add	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		add	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		add	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		add	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		add	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		sub	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		sub	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		sub	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		sub	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r1, r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		sub	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r1, r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		sub	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r1, r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r2, r2, #1
		sub	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r1, r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2, r2, #1
		sub	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r1, r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2, r2, #1
		sub	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r1, r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2, r2, #1
		sub	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		sub r1, r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2, r2, #1
		sub	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2, r2, #1
		sub	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		
		add r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		add r2, r2, #1
		sub	r1, r1, #1	
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]		
	
		str	r3, [r0, #12]	//refresh the screen 
		
		//delay
		lsr r0, r0, #4
		movs r4, #0
z:		add r4, r4, #90
		cmp r4, r0
		bls z
		lsl r0, r0, #4
		
		str	r3, [r0, #0x10]
		
		b _main
		
