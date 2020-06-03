initial_sp:        .word    0x201FFFFC
reset_vector:     .word     _main
_main:		b ldr_r0
return0:	movs r1, #0 //sayac register
virusyap:	cmp r1, #0
			bne	atla0	
			movs	r6, #50	//row
			movs	r7, #120 //column
			b ldr_r3
return3:	add 	r4, r6, #6		//daire-son konumlar ayarlandı
			add 	r4, r4, #6
			add 	r4, r4, #6
			add 	r4, r4, #6
			add 	r4, r4, #6
			add 	r4, r4, #6
			add 	r4, r4, #6
			add 	r4, r4, #2		
			add		r6, r6, #18		//1.col ciziliyor
			sub		r4, r4, #18
col1:		str 	r6, [r0]
			str 	r7, [r0, #4]
			str		r3, [r0, #8]	
			add 	r6, r6, #1
			cmp 	r6,r4
			bls 	col1
			sub		r6, r6, #12	//2.col ciziliyor
			add		r7, r7, #1
			add		r4, r4, #3	
col2:		str 	r6, [r0]
			str 	r7, [r0, #4]
			str		r3, [r0, #8]
			add 	r6, r6, #1
			cmp 	r6,r4
			bls 	col2
			sub		r6, r6, #18	//3.col ciziliyor
			add		r7, r7, #1
			add		r4, r4, #3
col3:		str 	r6, [r0]
			str 	r7, [r0, #4]
			str		r3, [r0, #8]
			add 	r6, r6, #1
			cmp 	r6,r4
			bls 	col3
			sub		r6, r6, #22	//4.col ciziliyor
			add		r7, r7, #1
			add		r4, r4, #1
col4:		str 	r6, [r0]
			str 	r7, [r0, #4]
			str		r3, [r0, #8]
			add 	r6, r6, #1
			cmp 	r6,r4
			bls 	col4
			sub		r6, r6, #25	//5.col ciziliyor
			add		r7, r7, #1
			add		r4, r4, #2
col5:		str 	r6, [r0]
			str 	r7, [r0, #4]
			str		r3, [r0, #8]
			add 	r6, r6, #1
			cmp 	r6,r4
			bls 	col5
			sub		r6, r6, #28	//6.col ciziliyor
			add		r7, r7, #1
			add		r4, r4, #1
col6:		str 	r6, [r0]
			str 	r7, [r0, #4]
			str		r3, [r0, #8]
			add 	r6, r6, #1
			cmp 	r6,r4
			bls 	col6
			sub		r6, r6, #30	//7.col ciziliyor
			add		r7, r7, #1
			add 	r4, r4, #1
col7:		str 	r6, [r0]
			str 	r7, [r0, #4]
			str		r3, [r0, #8]
			add 	r6, r6, #1
			cmp 	r6,r4
			bls 	col7
			sub		r6, r6, #32	//8.col ciziliyor
			add		r7, r7, #1
			add		r4, r4, #1
col8:		str 	r6, [r0]
			str 	r7, [r0, #4]
			str		r3, [r0, #8]
			add 	r6, r6, #1
			cmp 	r6,r4
			bls 	col8
			sub		r6, r6, #34	//9.col ciziliyor
			add		r7, r7, #1
			add		r4, r4, #1
col9:		str 	r6, [r0]
			str 	r7, [r0, #4]
			str		r3, [r0, #8]
			add 	r6, r6, #1
			cmp 	r6,r4
			bls 	col9
			b goo
//-----------------------------------
atla0:	b atla1
//----------------------------------		
goo:	sub		r6, r6, #36	//10.col ciziliyor
		add		r7, r7, #1
		add		r4, r4, #1
col10:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col10
		sub		r6, r6, #37	//11.col ciziliyor
		add		r7, r7, #1
col11:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col11
		sub		r6, r6, #38	//12.col ciziliyor
		add		r7, r7, #1
		add		r4, r4, #1
col12:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col12	
		sub		r6, r6, #40	//13.col ciziliyor
		add		r7, r7, #1
		add		r4, r4, #1
col13:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col13	
		sub		r6, r6, #41	//14.col ciziliyor
		add		r7, r7, #1
col14:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col14	
		sub		r6, r6, #41	//15.col ciziliyor
		add		r7, r7, #1
col15:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col15
		sub		r6,	r6, #43
		add		r4, r4, #1	
		add		r5, r7, #6
		add		r5, r5, #6
		add		r5, r5, #3		
loop2:	add 	r7,r7, #1
loop1:	add 	r6,r6, #1
		str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]	
		cmp 	r6,r4
		bne		loop1
		sub		r6,r6,#43	
		cmp		r7,r5
		bne		loop2	
		add		r6, r6, #2	//31.col ciziliyor
		add		r7, r7, #1
		sub 	r4, r4, #1
col31:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col31		
		sub		r6, r6, #41	//32.col ciziliyor
		add		r7, r7, #1
col32:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col32	
		sub		r6, r6, #41	//33.col ciziliyor
		add		r7, r7, #1
col33:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col33	
		sub		r6, r6, #40	//34.col ciziliyor
		add		r7, r7, #1
		sub 	r4, r4, #1
col34:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col34
		sub		r6, r6, #38	//35.col ciziliyor
		add		r7, r7, #1
		sub 	r4, r4, #1
col35:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col35
		sub		r6, r6, #37	//36.col ciziliyor
		add		r7, r7, #1
col36:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col36
		sub		r6, r6, #36	//37.col ciziliyor
		add		r7, r7, #1
		sub 	r4, r4, #1
col37:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col37	
		sub		r6, r6, #34	//38.col ciziliyor
		add		r7, r7, #1
		sub 	r4, r4, #1
col38:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col38	
		sub		r6, r6, #32	//39.col ciziliyor
		add		r7, r7, #1
		sub 	r4, r4, #1
col39:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col39		
		sub		r6, r6, #30	//40.col ciziliyor
		add		r7, r7, #1
		sub 	r4, r4, #1
col40:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col40
		sub		r6, r6, #28	//41.col ciziliyor
		add		r7, r7, #1
		sub 	r4, r4, #1
col41:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col41		
		sub		r6, r6, #25	//42.col ciziliyor
		add		r7, r7, #1
		sub 	r4, r4, #2
col42:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col42	
		sub		r6, r6, #22	//43.col ciziliyor
		add		r7, r7, #1
		sub 	r4, r4, #1
col43:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col43	
		sub		r6, r6, #18	//44.col ciziliyor
		add		r7, r7, #1
		sub 	r4, r4, #3
col44:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col44	
		sub		r6, r6, #12	//45.col ciziliyor
		add		r7, r7, #1
		sub 	r4, r4, #3
col45:	str 	r6, [r0]
		str 	r7, [r0, #4]
		str		r3, [r0, #8]
		add 	r6, r6, #1
		cmp 	r6,r4
		bls 	col45
		b	kare2						
atla1:	cmp	r1,#1
		bne	atla2
		add	r7,r7,#2
		b	kare2		
atla2:	cmp r1,#2
		bne atla3
		add r7,r7,#2
		b	kare2
atla3:	cmp r1,#3
		bne atla4
		add r7,r7,#2
		sub r6,r6,#2
		b	kare2		
atla4:	cmp r1,#4
		bne atla5
		add r6,r6,#4
		b	kare2
atla5:	cmp r1,#5
		bne atla6
		sub r6,r6,#11
		b	kare2		
atla6:	cmp r1,#6
		bne atla7
		sub r6,r6,#4
		b	kare2	
atla7:	cmp r1,#7
		bne atla8
		add r6,r6,#2
		sub r7,r7,#2
		b	kare2
atla8:	cmp r1,#8
		bne atla9
		sub r7,r7,#2
		b	kare2
atla9:	cmp r1,#9
		bne atla10		
		sub r7,r7,#2
		b	kare2
atla10:	cmp r1,#10
		bne atla11		
		sub r7,r7,#1
		sub r6,r6,#6
		b	kare2		
atla11:	cmp r1,#11
		bne atla12		
		add r7,r7,#2
		b	kare2			
atla12:	cmp r1,#12
		bne atla13		
		add r7,r7,#2
		sub r6,r6,#2
		b	kare2
atla13:	cmp r1,#13
		bne atla14		
		add r7,r7,#2
		sub r6,r6,#2
		b	kare2		
atla14:	cmp r1,#14
		bne atla15		
		sub r7,r7,#11
		sub r6,r6,#1
		b	kare2		
atla15:	cmp r1,#15
		bne atla16		
		add r7,r7,#2
		sub r6,r6,#2
		b	kare2	
atla16:	cmp r1,#16
		bne atla17		
		add r7,r7,#2
		sub r6,r6,#2
		b	kare2	
atla17:	cmp r1,#17
		bne atla18		
		add r7,r7,#2
		sub r6,r6,#2
		b	kare2		
atla18:	cmp r1,#18
		bne atla19		
		sub r7,r7,#11
		add r6,r6,#1
		b	kare2
atla19:	cmp r1,#19
		bne atla20		
		sub r6,r6,#2	
		b	kare2
atla20:	cmp r1,#20
		bne atla21	
		add r7,r7,#2
		sub r6,r6,#2
		b	kare2		
atla21:	cmp r1,#21
		bne atla22		
		add r7,r7,#2
		sub r6,r6,#2
		b	kare2	
atla22:	cmp r1,#22
		bne atla23		
		sub r7,r7,#8
		sub r6,r6,#1
		b	kare2			
atla23:	cmp r1,#23
		bne atla24		
		sub r7,r7,#4
		b	kare2		
atla24:	cmp r1,#24
		bne atla25		
		add r7,r7,#2
		add r6,r6,#2
		b	kare2		
atla25:	cmp r1,#25
		bne atla26		
		add r6,r6,#2
		b	kare2
atla26:	cmp r1,#26
		bne atla27		
		add r6,r6,#2
		b	kare2					
atla27:	cmp r1,#27
		bne atla28		
		sub r7,r7,#9
		sub r6,r6,#6
		b	kare2		
atla28:	cmp r1,#28
		bne atla29		
		sub r7,r7,#4
		b	kare2		
atla29:	cmp r1,#29
		bne atla30		
		add r7,r7,#2
		add r6,r6,#2
		b	kare2
atla30:	cmp r1,#30
		bne atla31	
		add r6,r6,#2
		b	kare2		
atla31:	cmp r1,#31
		bne atla32		
		add r6,r6,#2
		b	kare2
atla32:	cmp r1,#32
		bne atla33		
		sub r7,r7,#6
		add r6,r6,#1
		b	kare2
atla33:	cmp r1,#33
		bne atla34		
		sub r6,r6,#2
		b	kare2	
atla34:	cmp r1,#34
		bne atla35		
		sub r7,r7,#2
		sub r6,r6,#2
		b	kare2	
atla35:	cmp r1,#35
		bne atla36		
		sub r7,r7,#2
		sub r6,r6,#2
		b	kare2		
atla36:	cmp r1,#36
		bne atla37		
		sub r7,r7,#1
		add r6,r6,#11
		b	kare2	
atla37:	cmp r1,#37
		bne atla38		
		sub r7,r7,#2
		sub r6,r6,#2
		b	kare2
atla38:	cmp r1,#38
		bne atla39		
		sub r7,r7,#2
		sub r6,r6,#2
		b	kare2
atla39:	cmp r1,#39
		bne atla40	
		sub r7,r7,#2
		sub r6,r6,#2
		b	kare2
atla40:	cmp r1,#40
		bne atla41	
		add r7,r7,#1
		add r6,r6,#11
		b	kare2			
atla41:	cmp r1,#41
		bne atla42	
		sub r7,r7,#2
		b	kare2		
atla42:	cmp r1,#42
		bne atla43		
		sub r7,r7,#2
		sub r6,r6,#2
		b	kare2		
atla43:	cmp r1,#43
		bne atla44		
		sub r7,r7,#2
		sub r6,r6,#2
		b	kare2		
atla44:	cmp r1,#44
		bne atla45		
		sub r7,r7,#1
		add r6,r6,#8
		b	kare2		
atla45:	cmp r1,#45
		bne atla46		
		add r6,r6,#4
		b	kare2
atla46:	cmp r1,#46
		bne atla47		
		add r7,r7,#2
		sub r6,r6,#2
		b	kare2		
atla47:	cmp r1,#47
		bne atla48		
		add r7,r7,#2
		b	kare2		
atla48:	cmp r1,#48
		bne atla49		
		add r7,r7,#2
		b	kare2		
atla49:	cmp r1,#49
		bne atla50		
		sub r7,r7,#6
		add r6,r6,#9
		b	kare2		
atla50:	cmp r1,#50
		bne atla51		
		add r6,r6,#4
		b	kare2		
atla51:	cmp r1,#51
		bne atla52		
		add r7,r7,#2
		sub r6,r6,#2
		b	kare2		
atla52:	cmp r1,#52
		bne atla53		
		add r7,r7,#2
		b	kare2		
atla53:	cmp r1,#53
		bne atla54		
		add r7,r7,#2
		b	kare2		
atla54:	cmp r1,#54
		bne atla55		
		add r7,r7,#1
		add r6,r6,#6
		b	kare2
atla55:	cmp r1,#55
		bne atla56		
		sub r7,r7,#2
		b	kare2		
atla56:	cmp r1,#56
		bne atla57		
		sub r7,r7,#2
		add r6,r6,#2
		b	kare2
atla57:	cmp r1,#57
		bne atla58		
		sub r7,r7,#2
		add r6,r6,#2
		b	kare2
atla58:	cmp r1,#58
		bne atla59		
		add r7,r7,#11
		add r6,r6,#1
		b	kare2
atla59:	cmp r1,#59
		bne atla60		
		sub r7,r7,#2
		add r6,r6,#2
		b	kare2
atla60:	cmp r1,#60
		bne atla61		
		sub r7,r7,#2
		add r6,r6,#2
		b	kare2	
atla61:	cmp r1,#61
		bne atla62		
		sub r7,r7,#2
		add r6,r6,#2
		b	kare2		
atla62:	cmp r1,#62
		bne atla63		
		add r7,r7,#11
		sub r6,r6,#1
		b	kare2
atla63:	cmp r1,#63
		bne atla64		
		add r6,r6,#2
		b	kare2
atla64:	cmp r1,#64
		bne atla65		
		sub r7,r7,#2
		add r6,r6,#2
		b	kare2
atla65:	cmp r1,#65
		bne atla66		
		sub r7,r7,#2
		add r6,r6,#2
		b	kare2		
atla66:	cmp r1,#66
		bne atla67		
		add r7,r7,#8
		add r6,r6,#1
		b	kare2		
atla67:	cmp r1,#67
		bne atla68		
		add r7,r7,#4
		b	kare2
atla68:	cmp r1,#68
		bne atla69		
		sub r7,r7,#2
		sub r6,r6,#2
		b	kare2		
atla69:	cmp r1,#69
		bne atla70		
		sub r6,r6,#2
		b	kare2		
atla70:	cmp r1,#70
		bne atla71		
		sub r6,r6,#2
		b	kare2
atla71:	cmp r1,#71
		bne atla72
		sub r6,r6, #1		
		add r7,r7,#2
		b	kare2
atla72:	cmp r1,#72
		bne atla73		
		add r7,r7,#2
		b	kare2
atla73:	cmp r1,#73
		bne atla74		
		add r7,r7,#2
		b	kare2
atla74:	cmp r1,#74
		bne atla75		
		add r7,r7,#2
		b	kare2		
atla75:	cmp r1,#75
		bne atla76	
		add r7,r7,#2
		b	kare2		
atla76:	cmp r1,#76
		bne atla77		
		add r7,r7,#1
		b	kare2
atla77:	cmp r1,#77
		bne atla78		
		add r6,r6,#2
		b	kare2
atla78:	cmp r1,#78
		bne atla79		
		add r6,r6,#2
		b	kare2	
atla79:	cmp r1,#79
		bne atla80		
		add r6,r6,#1
		b	kare2	
atla80:	cmp r1,#80
		bne atla81
		sub r7,r7,#2		
		add r6,r6,#2
		b	kare2
atla81:	cmp r1,#81
		bne atla82
		add r7,r7,#4		
		b	kare2
		
atla82:	cmp r1,#82
		bne atla83
		sub r6,r6,#7
		add r7,r7,#4		
		b	kare2
atla83:	cmp r1,#83
		bne atla84
		add r6,r6,#2		
		b	kare2			
atla84:	cmp r1,#84
		bne atla85
		add r6,r6,#2
		add r7,r7,#2		
		b	kare2	
atla85:	cmp r1,#85
		bne atla86
		add r6,r6,#2
		add r7,r7,#2		
		b	kare2			
atla86:	cmp r1,#86
		bne atla87
		sub r6,r6,#11
		add r7,r7,#1		
		b	kare2	
atla87:	cmp r1,#87
		bne atla88
		add r6,r6,#2
		add r7,r7,#2		
		b	kare2	
atla88:	cmp r1,#88
		bne atla89
		add r6,r6,#2
		add r7,r7,#2		
		b	kare2	
atla89:	cmp r1,#89
		bne atla90
		add r6,r6,#2
		add r7,r7,#2		
		b	kare2	
atla90:	cmp r1,#90
		bne atla91
		sub r6,r6,#11
		sub r7,r7,#1		
		b	kare2
atla91:	cmp r1,#91
		bne atla92
		add r7,r7,#2		
		b	kare2
atla92:	cmp r1,#92
		bne atla93
		add r6,r6,#2
		add r7,r7,#2		
		b	kare2
atla93:	cmp r1,#93
		bne atla94
		add r6,r6,#2
		add r7,r7,#2		
		b	kare2	
atla94:	cmp r1,#94
		bne atla95
		sub r6,r6,#37
		sub r7,r7,#24		
		b	kare2	
atla95:	cmp r1,#95
		bne atla96
		sub r7,r7,#2		
  	b	kare2
atla96:	cmp r1,#96
		bne atla97
		sub r7,r7,#2	
		b	kare2		
atla97:	cmp r1,#97
		bne atla98
		sub r7,r7,#2		
		b	kare2	
atla98:	cmp r1,#98
		bne atla99
		sub r7,r7,#2	
		b	kare2
//--------------------------renklendirme
atla99:	cmp r1,#99
		bne atla100
		ldr r3,=0xFFD8E145
		sub r7,r7,#4
		add r6,r6,#7	
		b	kare2		
atla100:cmp r1,#100
		bne atla101
		ldr r3,=0xFFD8E145
		sub r7,r7,#5
		add r6,r6,#4	
		b	kare2	
atla101:cmp r1,#101
		bne atla102
		ldr r3,=0xFFD8E145
		sub r7,r7,#3
		add r6,r6,#3	
		b	kare2
atla102:cmp r1,#102
		bne atla103
		ldr r3,=0xFFD8E145
		sub r7,r7,#1
		add r6,r6,#5	
		b	kare2
atla103:cmp r1,#103
		bne atla104
		ldr r3,=0xFFD8E145
		add r6,r6,#5	
		b	kare2	
atla104:cmp r1,#104
		bne atla105
		ldr r3,=0xFFD8E145
		add r7,r7,#1
		add r6,r6,#5	
		b	kare2	
atla105:cmp r1,#105
		bne atla106
		ldr r3,=0xFFD8E145
		add r7,r7,#2
		add r6,r6,#3	
		b	kare2	
atla106:cmp r1,#106
		bne atla107
		ldr r3,=0xFFD8E145
		add r7,r7,#4
		add r6,r6,#3	
		b	kare2
atla107:cmp r1,#107
		bne atla108
		ldr r3,=0xFFD8E145
		add r7,r7,#3
		sub r6,r6,#4	
		b	kare2
atla108:cmp r1,#108
		bne atla109
		ldr r3,=0xFFD8E145
		sub r7,r7,#3
		sub r6,r6,#6	
		b	kare2
atla109:cmp r1,#109
		bne atla110
		ldr r3,=0xFFD8E145
		sub r7,r7,#4
		sub r6,r6,#4	
		b	kare2
atla110:cmp r1,#110
		bne atla111
		ldr r3,=0xFFD8E145
		sub r6,r6,#4	
		b	kare2		
atla111:cmp r1,#111
		bne atla112
		ldr r3,=0xFFD8E145
		add r7,r7,#2
		sub r6,r6,#6	
		b	kare2		
atla112:cmp r1,#112
		bne atla113
		ldr r3,=0xFFD8E145
		add r7,r7,#1
		sub r6,r6,#8	
		b	kare2			
atla113:cmp r1,#113
		bne atla114
		ldr r3,=0xFFD8E145
		add r7,r7,#7
		add r6,r6,#17	
		b	kare2			
atla114:cmp r1,#114
		bne atla115
		ldr r3,=0xFFD8E145
		add r7,r7,#3
		sub r6,r6,#16	
		b	kare2		
atla115:cmp r1,#115
		bne atla116
		ldr r3,=0xFFD8E145
		add r7,r7,#1
		add r6,r6,#30	
		b	kare2	
atla116:cmp r1,#116
		bne atla117
		ldr r3,=0xFFD8E145
		add r7,r7,#1
		sub r6,r6,#21	
		b	kare2	
atla117:cmp r1,#117
		bne atla118
		ldr r3,=0xFFD8E145
		add r7,r7,#5
		add r6,r6,#15	
		b	kare2
atla118:cmp r1,#118
		bne atla119
		ldr r3,=0xFFD8E145
		sub r7,r7,#1
		sub r6,r6,#4	
		b	kare2
atla119:cmp r1,#119
		bne atla120
		ldr r3,=0xFFD8E145
		add r7,r7,#5
		add r6,r6,#10	
		b	kare2	
atla120:cmp r1,#120
		bne atla121
		ldr r3,=0xFFD8E145
		add r7,r7,#1
		sub r6,r6,#21	
		b	kare2		
atla121:			
		str	r3, [r0, #12]
timer:	movs r5,#0			//sonsuz loop- ana kodda bu silinecek ekran kapanmasın diye koydum
		add	r5, r5, #1
		cmp	r5, #100
		bne timer
kare2: 	add r4, r6, #1
		add r5, r7, #1
		sub r7,r7, #1
		sub r6,r6, #1
back2:	add r7,r7, #1
back1:	add r6,r6, #1
		str r6, [r0]
		str r7, [r0, #4]
		str	r3, [r0, #8]	
		cmp r6,r4
		bne	back1
		sub r6,r6,#2	
		cmp r7,r5
		bne back2
		add r6,r6,#1
		sub r7,r7,#1
		add r1,r1,#1
		b virusyap		
		b goo1
//---------------------------------		
ldr_r0:	ldr	r0, =0x40010000
		b return0
ldr_r3:	ldr 	r3, =0xFFB8C125	//sari renk	
		b return3
//-------------------------------
goo1:
		
