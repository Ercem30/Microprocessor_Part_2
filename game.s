initial_sp:        .word    0x201FFFFC
reset_vector:      .word    initialize
initialize:
		movs r1, #150    //initialization
		add  r1, r1, #150
		movs r2, #106
    str  r2, [sp, #1008]
		str  r1, [sp, #1012]
		sub  r2, r2, #6
		str  r2, [sp, #1016]
		str  r1, [sp, #1020]
    b    ldr_r0_1
ret1:
    b    ldr_r3_1
ret2:
		add  r7, r7, #10
		str  r7, [sp, #992]
		movs r7, #250
		str  r7, [sp, #1000]
		add  r7, r7, #7
		str  r7, [sp, #988]
		movs r7, #15
	//	str  r7, [sp, #984] //load enemy 2 to RAM
		add  r7, r7, #10
		str  r7, [sp, #972]
		str  r7, [sp, #912]
		movs r7, #25
		str  r7, [sp, #980]
		add  r7, r7, #7
		str  r7, [sp, #968]

		add  r7, r7, #10
		str  r7, [sp, #952]
		movs r7, #50
		str  r7, [sp, #960]
		add  r7, r7, #7
		str  r7, [sp, #948]

		add  r7, r7, #10
		str  r7, [sp, #932]
		movs r7, #150
		str  r7, [sp, #940]
		add  r7, r7, #7
		str  r7, [sp, #928]
		movs r7, #1
		str  r7, [sp, #20]
		str  r7, [sp, #996] //enemy1 is alive
		str  r7, [sp, #976] //enemy2 is alive
		str  r7, [sp, #956] //enemy3 is alive
		str  r7, [sp, #936] //enemy4 is alive
		str  r7, [sp, #916] //enemy5 is alive
		str  r7, [sp, #16]  //player is alive
		str  r7, [sp, #20]  //1 means moves left
		movs r7, #0
		str  r7, [sp, #12]  //assign initial state of the counter
		str  r7, [sp, #24]  //0 means moves right
		str  r7, [sp, #8]   //assign initial state of the timer
		str  r7, [sp, #100]
		str  r7, [sp, #104]
		str  r7, [sp, #96]  //player not set
		str  r7, [sp, #92]  //enemy 1 not set
		str  r7, [sp, #88]  //enemy 2 not set
		str  r7, [sp, #84]  //enemy 3 not set
		str  r7, [sp, #80]  //enemy 4 not set
		str  r7, [sp, #76]  //enemy 5 not set
		movs r7, #3
		str  r7, [sp, #4]   //assign 3 life points
		movs r7, #75
		b e1_time_ldr
e1_t_ret:
	  sub  r7, r7, r1
		str  r7, [sp, #1004] //load enemy 1 to RAM
		str  r7, [sp, #964] //load enemy 3 to RAM
		str  r7, [sp, #944] //load enemy 4 to RAM
		movs r7, #15
		b e2_time_ldr
e2_t_ret:
	  sub  r7, r7, r1
		str  r7, [sp, #984]
		movs r7, #45
		sub  r7, r7, r1
		str  r7, [sp, #924]
		movs r7, #250
		add  r7, r7, #35
		str  r7, [sp, #920]
		add  r7, r7, #7
		str  r7, [sp, #908]

		str	r3, [r0, #12]   //refresh the screen
		str	r3, [r0, #0x10] //clear the screen
//-------------------------------------------------------------
start_page:
			b start_jump_1

main_loop:
      str	r3, [r0, #12] //refresh the screen
	   	b show            //show
			str	r3, [r0, #12] //refresh the screen
f1:		b update          //update
main_loop_2:
      str	r3, [r0, #12] //refresh the screen
			ldr r7, [sp, #4]
			cmp r7, #0
			beq game_over_page
			b main_loop

game_over_page:
			str	r3, [r0, #0x10]
			b game_over_jump_1
//-------------------------------------------------------------
update:
			b set_enemy
f15:	ldr r7, [sp, #96]
			cmp r7, #0
			beq set_player
f14:  b update_movement    //update player position -> f2
f2:   b collide            //check wall collision -> f7
f7:   ldr r7, [sp, #1012]  //check if fire has expired
      cmp r7, #0
      beq update_fire      // -> f9
f9:   b update_enemy       // -> f10 (update movement inside)
f10:  b update_enemy_fire_jump  // -> f12
f12:	b update_player_jump        // -> f4
f4:		str	r3, [r0, #12]
      b main_loop_2
show:
			str	r3, [r0, #12]    //refresh the screen
			str	r3, [r0, #0x10]  //clear the screen
			b show_life_points_jump // -> f13
f13:  b show_charater      // -> f3
      str	r3, [r0, #12]
f3:		b show_enemy         // -> f8
      str	r3, [r0, #12]
f8:   ldr r7, [sp, #1012]  //show fire
  		cmp r7, #0
  		bhi show_fire        // -> f5
f5:   b show_enemy_fire_jump  // -> f11
      str	r3, [r0, #12]
f11:  b delay                   // -> f6
f6:   b f1
//-------------------------------------------------------------
set_player:
			ldr r1, [sp, #1020]
			cmp r1, #200
			beq finish_player_setup
			sub r1, r1, #1
			str r1, [sp, #1020]
b f14

finish_player_setup:
      str  r1, [sp, #1012]
			movs r1, #1
			str  r1, [sp, #96]
b f14
//-------------------------------------------------------------
update_movement:
		ldr r1, [sp, #96]
		cmp r1, #0
		beq f2
		ldr r1, [sp, #16]
		cmp r1, #0
		beq f2
    ldr r4, [r0, #0x20]

    movs	r5, #0x4
		and	r5, r4, r5
		cmp	r5, #0x4
		beq	left

		movs	r5, #0x8
		and	r5, r4, r5
		cmp	r5, #0x8
		beq	down

		movs	r5, #0x10
		and	r5, r4, r5
		cmp	r5, #0x10
		beq	right

		movs	r5, #0x20
		and	r5, r4, r5
		cmp	r5, #0x20
		beq	up
b f2

left: ldr r2, [sp, #1016]
      sub	r2, r2, #1
			str  r2, [sp, #1016]
	    b	f2
right: ldr r2, [sp, #1016]
       add	r2, r2, #1
			 str  r2, [sp, #1016]
       b f2
up: ldr  r1, [sp, #1020]
    sub	r1, r1, #1
		str  r1, [sp, #1020]
		b	f2
down:	ldr  r1, [sp, #1020]
      add	r1, r1, #1
			str  r1, [sp, #1020]
	   	b	f2
//-------------------------------------------------------------
collide:
		ldr r1, [sp, #96]
		cmp r1, #0
		beq f7

		movs r5, #0
		movs r6, #0
		ldr r5, [sp, #1020]
		ldr r6, [sp, #1016]
		ldr r7, width
	  sub r7, r7, #12

		cmp r6, r7  //if x > width => x=width
		bhs r6_max
c1:	cmp r6, #15
		bls r6_min
c2:	cmp r5, #225
		bhs r5_max
c3: cmp r5, #140
		bls r5_min
b f7

r6_max:
		movs r6, r7
		str  r6, [sp, #1016]
b c1
r6_min:
		movs r6, #15
		str  r6, [sp, #1016]
b c2
r5_max:
		movs r5, #225
		str  r5, [sp, #1020]
b c3
r5_min:
		movs r5, #140
		str  r5, [sp, #1020]
b f7
//-------------------------------------------------------------
update_fire:
		ldr r7, [sp, #16]
		cmp r7, #1
		beq cont_update_fire_p
		b f9
cont_update_fire_p:
    ldr r5, [sp, #1020] //row data
		ldr r6, [sp, #1016] //column data
		add r6, r6, #6
		str r5, [sp, #1012]
		str r6, [sp, #1008]
b f9
//-------------------------------------------------------------//1'st jump point
show_enemy_fire_jump: b show_enemy_fire
update_enemy_fire_jump: b update_enemy_fire
update_player_jump: b update_player
ldr_r0_1: b ldr_r0_2
ldr_r3_1: b ldr_r3_2
show_life_points_jump: b show_life_points
//-------------------------------------------------------------
show_charater:
		ldr   r5, [sp, #16] //is the enemy dead?
		cmp   r5, #1
		beq   player_cont
		b f3

player_cont:
    ldr 	r1, [sp, #1020]
    ldr 	r2, [sp, #1016]
		cmp   r1, #230
		bls   draw_game_character_p
		b f3

draw_game_character_p:    b draw_game_character
//-------------------------------------------------------------
delay:
    movs r7, #0
		ldr  r6, delay_constant
delay_loop:
    cmp  r7, r6
    beq  f6
    add  r7, r7, #1
    b delay_loop
//-------------------------------------------------------------
show_fire:
		ldr r1, [sp, #96]
		cmp r1, #0
		beq f5

    ldr r5, [sp, #1012] //row data
    movs r7, r5
    ldr r6, [sp, #1008] //column data
    sub r7, r7, #1
    str r7, [sp, #1012]
    movs r7, #0
draw_fire:
    str	r5, [r0]
    str	r6, [r0, #4]
		b ldr_r3_3
ret3:
    str	r3, [r0, #8]
    add r7, r7, #1
    sub r5, r5, #1
    cmp r7, #4
    bne draw_fire
		str	r3, [r0, #12]
    movs r7, #0
b f5
//-------------------------------------------------------------
.balign 4
delay_constant:  .word 5000
width:           .word 310
//-------------------------------------------------------------
show_enemy:
		ldr   r4, [sp, #12]
		cmp   r4, #0
		beq   en1
		cmp   r4, #1
		beq   en2
		cmp   r4, #2
		beq   en3
		cmp   r4, #3
		beq   en4
		cmp   r4, #4
		beq   en5
		movs  r4, #0
		str   r4, [sp, #12] //reset counter
		b f8

en1:ldr r1, [sp, #1004]
    cmp r1, #10
		blt lcun1
		movs  r7, #0 //draw enemy 1
    ldr   r5, [sp, #996] //is the enemy dead?
		ldr   r2, [sp, #1000]
		ldr 	r6, [sp, #1004]
		ldr 	r7, [sp, #1000]
    cmp   r5, #1
		beq   enemy_cont
		b lcun1

en2:ldr r1, [sp, #984]
 	 cmp r1, #10
   blt  lcun1
	 movs  r7, #0  //draw enemy 2
   ldr   r5, [sp, #976] //is the enemy dead?
	 ldr   r2, [sp, #980]
	 ldr 	 r6, [sp, #984]
	 ldr   r7, [sp, #980]
   cmp   r5, #1
	 beq   enemy_cont
 	 b lcun1

en3:ldr r1, [sp, #964]
   cmp r1, #10
	 blt lcun1
	 movs  r7, #0  //draw enemy 3
	 ldr   r5, [sp, #956] //is the enemy dead?
	 ldr   r2, [sp, #960]
	 ldr 	 r6, [sp, #964]
	 ldr   r7, [sp, #960]
   cmp   r5, #1
	 beq   enemy_cont
	 b lcun1

en4:ldr r1, [sp, #944]
	  cmp r1, #10
	 	blt lcun1
	 	movs  r7, #0  //draw enemy 4
	  ldr   r5, [sp, #936] //is the enemy dead?
	  ldr   r2, [sp, #940]
	 	ldr 	r6, [sp, #944]
	 	ldr   r7, [sp, #940]
	  cmp   r5, #1
	 	beq   enemy_cont
	 	b lcun1

en5:ldr r1, [sp, #924]
	  cmp r1, #10
		blt  lcun1
	  movs  r7, #0  //draw enemy 5
		ldr   r5, [sp, #916] //is the enemy dead?
	  ldr   r2, [sp, #920]
		ldr 	r6, [sp, #924]
		ldr   r7, [sp, #920]
		cmp   r5, #1
	  beq   enemy_cont
	  b lcun1

enemy_cont:
		str 	r6, [r0]
		str 	r7, [r0, #4]
		b draw_game_enemy_jump
end_game_enemy:

		movs r7, r2
		str	r3, [r0, #12]
lcun1:
    ldr r7, [sp, #12]
		add r7, r7, #1
		str r7, [sp, #12] //update counter
b show_enemy
//-------------------------------------------------------------
e1_time_ldr: ldr r1, e1_time
						 b e1_t_ret
e2_time_ldr: ldr r1, e2_time
						 b e2_t_ret
//-------------------------------------------------------------
set_enemy:
		ldr r2, [sp, #12]

cont_set_en:
		cmp r2, #0
		beq set_e1
		cmp r2, #1
		beq set_e2
		cmp r2, #2
		beq set_e3
		cmp r2, #3
		beq set_e4
		cmp r2, #4
		beq set_e5
end_set:
    b f15

		set_e1:
				ldr r1, [sp, #92]
				cmp r1, #1
				beq lcun6
				ldr r7,[sp, #1004]// e_wait //enemy 1 row. position
				cmp r7, #75
				bge finish_set_e1
				add r7, r7, #1
				str r7, [sp, #1004]
				str r7, [sp, #992]
				cmp r7, #3
				bhs resurrect_e_1
				b lcun6
		resurrect_e_1:
				movs r7, #1
				ldr  r7, [sp, #996]
		    b lcun6
		finish_set_e1:
		    movs r7, #1
				str r7, [sp, #92]
				movs r7, #75
				str r7, [sp, #992]
				movs r7, #255
				str r7, [sp, #988]
				b lcun6

		set_e2:
				ldr r1, [sp, #88]
				cmp r1, #1
				beq lcun6
				ldr r7,[sp, #984]  // e_wait //enemy 2 row. position
				cmp r7, #15 //important
				bge finish_set_e2
				add r7, r7, #1
				str r7, [sp, #984]
			  str r7, [sp, #972]
				cmp r7, #3
				bhs resurrect_e_2
				b lcun6
		resurrect_e_2:
				movs r7, #1
				ldr  r7, [sp, #976]
				b lcun6
		finish_set_e2:
				movs r7, #1
				str r7, [sp, #88]
				movs r7, #15 //important
				str r7, [sp, #972]
				movs r7, #25 //important
				str r7, [sp, #968]
				b lcun6

		set_e3:
				ldr r1, [sp, #84]
				cmp r1, #1
				beq lcun6
				ldr r7,[sp, #964]  // e_wait //enemy 1 row. position
				cmp r7, #75
				bge finish_set_e3
				add r7, r7, #1
				str r7, [sp, #964]
				str r7, [sp, #952]
				cmp r7, #3
				bhs resurrect_e_3
				b lcun6
		resurrect_e_3:
				movs r7, #1
				ldr  r7, [sp, #956]
				b lcun6
		finish_set_e3:
				movs r7, #1
				str r7, [sp, #84]
				movs r7, #75
				str r7, [sp, #952]
				movs r7, #55 //important
				str r7, [sp, #948]
				b lcun6

		set_e4:
				ldr r1, [sp, #80]
				cmp r1, #1
				beq lcun6
				ldr r7,[sp, #944]  // e_wait //enemy 1 row. position
				cmp r7, #75
				bge finish_set_e4
				add r7, r7, #1
				str r7, [sp, #944]
				str r7, [sp, #932]
				cmp r7, #3
				bhs resurrect_e_4
				b lcun6
		resurrect_e_4:
				movs r7, #1
				ldr  r7, [sp, #936]
				b lcun6
		finish_set_e4:
				movs r7, #1
				str r7, [sp, #80]
				movs r7, #75
				str r7, [sp, #932]
				movs r7, #155 //important
				str r7, [sp, #928]
				b lcun6

		set_e5:
				ldr r1, [sp, #76]
				cmp r1, #1
				beq lcun6
				ldr r7,[sp, #924]  // e_wait //enemy 2 row. position
				cmp r7, #45 //important
				bge finish_set_e5
				add r7, r7, #1
				str r7, [sp, #924]
				str r7, [sp, #912]
				cmp r7, #3
				bhs resurrect_e_5
				b lcun6
		resurrect_e_5:
				movs r7, #1
				ldr  r7, [sp, #916]
				b lcun6
		finish_set_e5:
				movs r7, #1
				str r7, [sp, #76]
				movs r7, #45 //important
				str r7, [sp, #912]
				movs r7, #250 //important
				add r7, r7, #35
				str r7, [sp, #908]
		   	b lcun6

		lcun6:
				add r2, r2, #1
				b cont_set_en
//-------------------------------------------------------------3'rd jump point
game_over_jump_1: b game_over_jump_2
start_jump_1: b start_jump_2
main_jump_3: b main_loop
//-------------------------------------------------------------
update_enemy:
    ldr r2, [sp, #12]   //counter
		b move_enemy
update_enemy_cont:
    cmp r2, #0
		beq up_en_1
		cmp r2, #1
		beq up_en_2
		cmp r2, #2
		beq up_en_3
		cmp r2, #3
		beq up_en_4
		cmp r2, #4
		beq up_en_5
		movs r2, #0
		str r2, [sp, #12]
		b f10

up_en_1:
		ldr r1, [sp, #92]
		cmp r1, #0
		beq lcun4_j
		ldr r6, [sp, #1012] //fire position
		ldr r7, [sp, #1008]
		ldr r4, [sp, #1004] //enemy position
		ldr r5, [sp, #1000]
		ldr r3, [sp, #996]  //is enemy dead
		b update_chain1
up_en_2:
		ldr r1, [sp, #88]
		cmp r1, #0
		beq lcun4
		ldr r6, [sp, #1012] //fire position
		ldr r7, [sp, #1008]
		ldr r4, [sp, #984] //enemy position
		ldr r5, [sp, #980]
		ldr r3, [sp, #976]  //is enemy dead
		b update_chain1
up_en_3:
		ldr r1, [sp, #84]
		cmp r1, #0
		beq lcun4
		ldr r6, [sp, #1012] //fire position
		ldr r7, [sp, #1008]
		ldr r4, [sp, #964] //enemy position
		ldr r5, [sp, #960]
		ldr r3, [sp, #956]  //is enemy dead
		b update_chain1
up_en_4:
		ldr r1, [sp, #80]
		cmp r1, #0
		beq lcun4
		ldr r6, [sp, #1012] //fire position
		ldr r7, [sp, #1008]
		ldr r4, [sp, #944] //enemy position
		ldr r5, [sp, #940]
		ldr r3, [sp, #936]  //is enemy dead
		b update_chain1
up_en_5:
		ldr r1, [sp, #76]
		cmp r1, #0
		beq lcun4
		ldr r6, [sp, #1012] //fire position
		ldr r7, [sp, #1008]
		ldr r4, [sp, #924] //enemy position
		ldr r5, [sp, #920]
		ldr r3, [sp, #916]  //is enemy dead
		b update_chain1

update_chain1:
		cmp r7, r5
		bhs check1
		b lcun4
check1:
		add r5, r5, #13
		cmp r7, r5
		bls check2
		b lcun4
check2:
		cmp r6, r4
		bhs check3
		b lcun4
check3:
		add r4, r4, #12
		cmp r6, r4
		bls check4
		b lcun4
check4:
		cmp r3, #1
		beq kill_enemy
		b lcun4

lcun4_j: b lcun4

kill_enemy:
		cmp r2, #0
		beq kill1
		cmp r2, #1
		beq kill2
		cmp r2, #2
		beq kill3
		cmp r2, #3
		beq kill4
		cmp r2, #4
		beq kill5
		movs r2, #0
		str r2, [sp, #12]
		b f10

kill1:
		movs r1, #0
		//str r1, [sp, #996]
		str r1, [sp, #92]
		movs r7, #75
		ldr r1, e1_time
	  sub  r7, r7, r1
		str r7, [sp, #1004]
		str r7, [sp, #992]
		b lcun4_ld
kill2:
		movs r1, #0
		str r1, [sp, #88]
		movs r7, #75
		ldr r1, e2_time
		sub  r7, r7, r1
		str r7, [sp, #984]
		str r7, [sp, #972]
		movs r7, #15
		str r7, [sp, #980]
		b lcun4_ld
kill3:
		movs r1, #0
		str r1, [sp, #84]
		movs r7, #75
		ldr r1, e1_time
	  sub  r7, r7, r1
		str r7, [sp, #964]
		str r7, [sp, #952]
		b lcun4_ld
kill4:
		movs r1, #0
		str r1, [sp, #80]
		movs r7, #75
		ldr r1, e1_time
		sub  r7, r7, r1
		str r7, [sp, #944]
		str r7, [sp, #932]
		b lcun4_ld
kill5:
		movs r1, #0
		str r1, [sp, #76]
		movs r7, #75
		ldr r1, e2_time
		sub  r7, r7, r1
		str r7, [sp, #924]
		str r7, [sp, #912]
		movs r7, #250
		add r7, r7, #35
		str r7, [sp, #920]
		b lcun4_ld

lcun4_ld:
    ldr r3, [sp, #16]
		cmp r3, #0
		beq reset_fire_player
		b lcun4_ld_pl
reset_fire_player:
		movs r5, #0
		//sub  r5, r5, #5
		movs  r6, #1
		str r5, [sp, #1012]
		str r6, [sp, #1008] //update fire
b lcun4
lcun4_ld_pl:
		ldr r5, [sp, #1020] //row data
		ldr r6, [sp, #1016] //column data
		add r6, r6, #6
		str r5, [sp, #1012]
		str r6, [sp, #1008] //update fire
lcun4:
		add r2, r2, #1
		b update_enemy_cont
//-------------------------------------------------------------
.balign 4
enemy_ram: .word 992
e_wait:    .word 400
e1_time:   .word 500
e2_time:   .word 620
//-------------------------------------------------------------
show_life_points:
		ldr r7, [sp, #4] //how many lifes left
		movs r6, #2

end_heart:
		cmp r7, #1
		beq draw_one_p
		cmp r7, #2
		beq draw_two_p
		cmp r7, #3
		beq draw_three_p
		b f13

draw_one_p:
		movs r5, #226
		b draw_heart

draw_two_p:
		movs r5, #212
		b draw_heart

draw_three_p:
		movs r5, #198
		b draw_heart
//-------------------------------------------------------------
f3_back: b f3
ret1_j: b ret1
ret2_j: b ret2
ret3_j: b ret3
//-------------------------------------------------------------
show_enemy_fire:
    ldr r4, [sp, #12]  //load counter
		ldr r1, [sp, #16]
		b ldr_r3_4

enemy_fire_cont:
		cmp   r4, #0
		beq   f_en1
		cmp   r4, #1
		beq   f_en2
		cmp   r4, #2
		beq   f_en3
		cmp   r4, #3
		beq   f_en4
		cmp   r4, #4
		beq   f_en5
		movs  r4, #0
		str   r4, [sp, #12] //reset counter
		b f11

f_en1:
    ldr  r1, [sp, #92]
		cmp  r1, #0
		beq  lcun2
		ldr  r5, [sp, #992] //row data
		movs r7, r5
		ldr  r6, [sp, #988] //column data
		ldr  r1, [sp, #992]
		cmp  r1, #255
		bls  f_en1_fire
		b lcun2
f_en1_fire:
  	add  r7, r7, #1
		str  r7, [sp, #992]
		movs r7, #0
		b draw_fire_enemy

f_en2:
		ldr  r1, [sp, #88]
		cmp  r1, #0
		beq  lcun2
		ldr  r5, [sp, #972] //row data
		movs r7, r5
		ldr  r6, [sp, #968] //column data
		ldr  r1, [sp, #972] //is enemy dead
		cmp  r1, #255
		bls  f_en2_fire
		b lcun2
f_en2_fire:
		add  r7, r7, #1
		str  r7, [sp, #972]
		movs r7, #0
		b draw_fire_enemy

f_en3:
		ldr  r1, [sp, #84]
		cmp  r1, #0
		beq  lcun2
		ldr  r5, [sp, #952] //row data
		movs r7, r5
		ldr  r6, [sp, #948] //column data
		ldr  r1, [sp, #952] //is enemy dead
		cmp  r1, #255
		bls  f_en3_fire
		b lcun2
f_en3_fire:
		add  r7, r7, #1
		str  r7, [sp, #952]
		movs r7, #0
		b draw_fire_enemy

f_en4:
		ldr  r1, [sp, #80]
		cmp  r1, #0
		beq  lcun2
		ldr  r5, [sp, #932] //row data
		movs r7, r5
		ldr  r6, [sp, #928] //column data
		ldr  r1, [sp, #932] //is enemy dead
		cmp  r1, #255
		bls  f_en4_fire
		b lcun2
f_en4_fire:
		add  r7, r7, #1
		str  r7, [sp, #932]
		movs r7, #0
		b draw_fire_enemy

f_en5:
		ldr  r1, [sp, #76]
		cmp  r1, #0
		beq  lcun2
		ldr  r5, [sp, #912] //row data
		movs r7, r5
		ldr  r6, [sp, #908] //column data
		ldr  r1, [sp, #912] //is enemy dead
		cmp  r1, #255
		bls  f_en5_fire
		b lcun2
f_en5_fire:
		add  r7, r7, #1
		str  r7, [sp, #912]
		movs r7, #0
		b draw_fire_enemy

draw_fire_enemy:
		str	r5, [r0]
		str	r6, [r0, #4]
		str	r3, [r0, #8]
		add r7, r7, #1
		sub r5, r5, #1
		cmp r7, #4
		bne draw_fire_enemy
lcun2:
		movs r7, #0
		str r3, [r0, #12]
		add r4, r4, #1  //increment counter
b enemy_fire_cont
//-------------------------------------------------------------
update_enemy_fire:
		ldr r4, [sp, #12]  //load counter
		ldr r7, [sp, #96]
		cmp r7, #0
		beq e_u_e

up_en_fire_cont:
		cmp r4, #0
		beq uef1
		cmp r4, #1
		beq uef2
		cmp r4, #2
		beq uef3
		cmp r4, #3
		beq uef4
		cmp r4, #4
		beq uef5
		movs r4, #0
		str r4, [sp, #12] //reset counter
e_u_e:
		b f12

uef1:
    ldr r7, [sp, #992]
		cmp r7, #255
		bhs uef1_1
		b lcun3
uef1_1:
    ldr r7, [sp, #996]
		cmp r7, #1  //if enemy alive, update fire
		beq up_fire_1
		b lcun3
up_fire_1:
		ldr r5, [sp, #1004] //row data
		ldr r6, [sp, #1000] //column data
		add r6, r6, #7
    add r5, r5, #10
		str r5, [sp, #992] //reset fire position to enemy position
		str r6, [sp, #988]
		b lcun3

uef2:
	  ldr r7, [sp, #972]
		cmp r7, #255
		bhs uef2_1
		b lcun3
uef2_1:
    ldr r7, [sp, #976]
		cmp r7, #1  //if enemy alive, update fire
		beq up_fire_2
		b lcun3
up_fire_2:
		ldr r5, [sp, #984] //row data
		ldr r6, [sp, #980] //column data
		add r6, r6, #7
    add r5, r5, #10
		str r5, [sp, #972] //reset fire position to enemy position
		str r6, [sp, #968]
		b lcun3

uef3:
	  ldr r7, [sp, #952]
		cmp r7, #255
		bhs uef3_1
		b lcun3
uef3_1:
		ldr r7, [sp, #956]
		cmp r7, #1  //if enemy alive, update fire
		beq up_fire_3
		b lcun3
up_fire_3:
		ldr r5, [sp, #964] //row data
		ldr r6, [sp, #960] //column data
		add r6, r6, #7
	  add r5, r5, #10
		str r5, [sp, #952] //reset fire position to enemy position
		str r6, [sp, #948]
		b lcun3

uef4:
	  ldr r7, [sp, #932]
		cmp r7, #255
		bhs uef4_1
		b lcun3
uef4_1:
		ldr r7, [sp, #936]
		cmp r7, #1  //if enemy alive, update fire
		beq up_fire_4
		b lcun3
up_fire_4:
		ldr r5, [sp, #944] //row data
		ldr r6, [sp, #940] //column data
		add r6, r6, #7
		add r5, r5, #10
		str r5, [sp, #932] //reset fire position to enemy position
		str r6, [sp, #928]
		b lcun3

uef5:
	  ldr r7, [sp, #912]
		cmp r7, #255
		bhs uef5_1
		b lcun3
uef5_1:
		ldr r7, [sp, #916]
		cmp r7, #1  //if enemy alive, update fire
		beq up_fire_5
		b lcun3
up_fire_5:
		ldr r5, [sp, #924] //row data
		ldr r6, [sp, #920] //column data
		add r6, r6, #7
	  add r5, r5, #10
		str r5, [sp, #912] //reset fire position to enemy position
		str r6, [sp, #908]
		b lcun3

lcun3:
		add r4, r4, #1 //increment counter
b up_en_fire_cont
//-------------------------------------------------------------
.balign 4
exit1: .word 260
exit2: .word 300
exit3: .word 255
exit4: .word 284
exit5: .word 275
//-------------------------------------------------------------
update_player:
		ldr r2, [sp, #12]

		ldr r1, [sp, #16] //is player dead?
		cmp r1, #0 //if dead
		beq reset_player_j

update_player_cont:
		cmp r2, #0
		beq up_pl_1
	  cmp r2, #1
		beq up_pl_2
		cmp r2, #2
		beq up_pl_3
		cmp r2, #3
		beq up_pl_4
		movs r2, #0
		str r2, [sp, #12]
		b f4

reset_player_j: b reset_player

up_pl_1:
		ldr r6, [sp, #992] //fire position
		add r6, r6, #4
		ldr r7, [sp, #988]
		ldr r4, [sp, #1020] //player position
		ldr r5, [sp, #1016]
		ldr r3, [sp, #996]
		b update_chain_2
up_pl_2:
		ldr r6, [sp, #972] //fire position
		add r6, r6, #4
		ldr r7, [sp, #968]
		ldr r4, [sp, #1020] //player position
		ldr r5, [sp, #1016]
		ldr r3, [sp, #976]
		b update_chain_2
up_pl_3:
		ldr r6, [sp, #952] //fire position
		add r6, r6, #4
		ldr r7, [sp, #948]
		ldr r4, [sp, #1020] //player position
		ldr r5, [sp, #1016]
		ldr r3, [sp, #956]
		b update_chain_2
up_pl_4:
		ldr r6, [sp, #932] //fire position
		add r6, r6, #4
		ldr r7, [sp, #928]
		ldr r4, [sp, #1020] //player position
		ldr r5, [sp, #1016]
		ldr r3, [sp, #936]
		b update_chain_2

update_chain_2:
		cmp r7, r5
		bhs checkp1
		b lcun5
checkp1:
		add r5, r5, #13
		cmp r7, r5
		bls checkp2
		b lcun5
checkp2:
		cmp r6, r4
		bhs checkp3
		b lcun5
checkp3:
		add r4, r4, #12
		cmp r6, r4
		bls kill_player//checkp4
		b lcun5
/*checkp4:
		cmp r3, #1
		beq kill_player
		b lcun5*/

kill_player:
		cmp r2, #0
		beq killp1
		cmp r2, #1
		beq killp2
		cmp r2, #2
		beq killp3
		cmp r2, #3
		beq killp4
		movs r2, #0
		str r2, [sp, #12]
		b f4

killp1:
		movs r1, #150
		add r1, r1, #150
		str r1, [sp, #1020]
		sub r1, r1, #200
		str r1, [sp, #1016]
		movs r1, #0
		str r1, [sp, #16]   //player is dead
		ldr r1, [sp, #4]    //life points
		sub r1, r1, #1
		str r1, [sp, #4]    //update life points
		ldr r5, [sp, #1004] //row data
		ldr r6, [sp, #1000] //column data
		add r6, r6, #7
		str r5, [sp, #992]
		str r6, [sp, #988] //update fire
		b lcun5
killp2:
		movs r1, #150
		add r1, r1, #150
		str r1, [sp, #1020]
		sub r1, r1, #200
		str r1, [sp, #1016]
		movs r1, #0
		str r1, [sp, #16]  //player is dead
		ldr r1, [sp, #4]    //life points
		sub r1, r1, #1
		str r1, [sp, #4]    //update life points
		ldr r5, [sp, #984] //row data
		ldr r6, [sp, #980] //column data
		add r6, r6, #7
		str r5, [sp, #972]
		str r6, [sp, #968] //update fire
		b lcun5
killp3:
		movs r1, #150
		add r1, r1, #150
		str r1, [sp, #1020]
		sub r1, r1, #200
		str r1, [sp, #1016]
		movs r1, #0
		str r1, [sp, #16]  //player is dead
		ldr r1, [sp, #4]    //life points
		sub r1, r1, #1
		str r1, [sp, #4]    //update life points
		ldr r5, [sp, #964] //row data
		ldr r6, [sp, #960] //column data
		add r6, r6, #7
		str r5, [sp, #952]
		str r6, [sp, #948] //update fire
		b lcun5
killp4:
		movs r1, #150
		add r1, r1, #150
		str r1, [sp, #1020]
		sub r1, r1, #200
		str r1, [sp, #1016]
		movs r1, #0
		str r1, [sp, #16]  //player is dead
		ldr r1, [sp, #4]    //life points
		sub r1, r1, #1
		str r1, [sp, #4]    //update life points
		ldr r5, [sp, #944] //row data
		ldr r6, [sp, #940] //column data
		add r6, r6, #7
		str r5, [sp, #932]
		str r6, [sp, #928] //update fire
		b lcun5
lcun5:
		add r2, r2, #1
		b update_player_cont
//------------------------------------------------------------
reset_player:
		ldr r1, [sp, #8]
		ldr r2, [sp, #4]
		cmp r2, #0
		beq jump_f4
		add r1, r1, #1
		str r1, [sp, #8]
		cmp r1, #255
		bhs reset_player_now
		b f4
reset_player_now:
		movs r1, #1
		str r1, [sp, #16]
		movs r1, #0
		str r1, [sp, #8]
b f4
jump_f4: b f4
//------------------------------------------------------------
move_enemy: //counter defined in r2
		movs r4, #1
move_loop:
		cmp r4, #1
		beq move_e1
		cmp r4, #2
		beq move_e2
		b update_enemy_cont

move_e1:
		ldr r7, [sp, #88]
		cmp r7, #0
		beq exit_move_enemy

		ldr r5, [sp, #104]
		cmp r5, #1
		blt update_enemy_cont_1
		b move_enemy_cont
update_enemy_cont_1:
		add r5, r5, #1
		str r5, [sp, #104]
		b lcun7
move_enemy_cont:
		movs r5, #0
		str r5, [sp, #104]
		ldr r1, [sp, #24]
		ldr r7, [sp, #980]
		cmp r1, #0
		beq move_enemy_right
		cmp r1, #1
		beq move_enemy_left
		b lcun7

move_enemy_right:
		add r7, r7, #1
		str r7, [sp, #980]
		movs r6, #250
		add  r6, r6, #35
		cmp r7, r6
		bhs assign_1
		b lcun7
move_enemy_left:
		sub r7, r7, #1
		str r7, [sp, #980]
		cmp r7, #20
		bls assign_0
		b lcun7

assign_0:
		movs r1, #0
		str  r1, [sp, #24]
		b lcun7
assign_1:
		movs r1, #1
		str  r1, [sp, #24]
exit_move_enemy:
		b lcun7

move_e2:
		ldr r7, [sp, #76]
		cmp r7, #0
    beq exit_move_enemy1

		ldr r5, [sp, #100]
		cmp r5, #1
		blt update_enemy_cont_1_1
		b move_enemy_cont_1
update_enemy_cont_1_1:
		add r5, r5, #1
		str r5, [sp, #100]
		b lcun7
move_enemy_cont_1:
		movs r5, #0
		str r5, [sp, #100]
		ldr r1, [sp, #20]
		ldr r7, [sp, #920]
		cmp r1, #0
		beq move_enemy_right_1
		cmp r1, #1
		beq move_enemy_left_1
		b lcun7

move_enemy_right_1:
		add r7, r7, #1
		str r7, [sp, #920]
		movs r6, #250
		add  r6, r6, #35
		cmp r7, r6
		bhs assign_1_1
		b lcun7
move_enemy_left_1:
		sub r7, r7, #1
		str r7, [sp, #920]
		cmp r7, #20
		bls assign_0_1
		b lcun7

assign_0_1:
		movs r1, #0
		str  r1, [sp, #20]
		b lcun7
assign_1_1:
		movs r1, #1
		str  r1, [sp, #20]
exit_move_enemy1:
		b lcun7

lcun7:
    add r4, r4, #1
		b move_loop
//------------------------------------------------------------2'nd jump point
ldr_r0_2: ldr r0, peripheral
					b ret1_j
ldr_r3_2:	ldr r3, yellow
					b ret2_j
ldr_r3_3: ldr r3, green
					b ret3_j
ldr_r3_4: ldr r3, red
					b enemy_fire_cont
draw_game_enemy_jump: b draw_game_enemy
end_game_enemy_jump: b end_game_enemy
game_over_jump_2: b game_over
start_jump_2: b start_jump_3
main_jump_2: b main_jump_3
//------------------------------------------------------------
//next section of the code is dedicated to sprites and animation
//------------------------------------------------------------
draw_game_character:
	  ldr  r3, cyan
		ldr  r0, peripheral
    str	 r3, [r0, #8]
		movs r5, #0
		movs r4, #8
		add  r4, r4, r2
		add  r1, r1, #12

a:	add r2, r2, #1
		sub	r1, r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		cmp	r2, r4
		bne	a

		cmp r5, #2
		beq	final1
		cmp r5, #1
		beq	b

		add r5, r5, #1
		sub r2, r2, #8
		add r1,	r1, #7 //11. satır, 1. sütun noktası
		sub r4, r4, #1
		cmp r5, #1
		beq	a

b:	add r5, r5, #1
		add r1,	r1, #6
		sub r2, r2, #7	//10. satır, 1. sütun noktası
		sub r4, r4, #1
		cmp r5, #2
		beq	a

final1:
    str	  r3, [r0, #12]

		movs r5, #0
		add r2, r2, #8
		add r1, r1, #8
c:	sub r2, r2, #1
		sub	r1, r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		cmp	r2, r4
		bne	c

		cmp r5, #2
		beq	final2
		cmp r5, #1
		beq	d

		add r5, r5, #1
		add r2, r2, #8
		add r1,	r1, #7 //11. satır, 13. sütun noktası
		add r4, r4, #1
		cmp r5, #1
		beq	c

d:	add r5, r5, #1
		add r1,	r1, #6
		add r2, r2, #7	//10. satır, 1. sütun noktası
		add r4, r4, #1
		cmp r5, #2
		beq	c

final2:
    add r1, r1, #2
		sub r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		add r1, r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		sub r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		add r2, r2, #2
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		ldr 	r1, [sp, #1020]
    ldr 	r2, [sp, #1016]

		add r2, r2, #7
		add r4,	r1, #2
		ldr r3, red

e:	add r1,	r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		cmp r1,r4
		bls	e

		add r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		sub r2, r2, #2
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		add r1,	r1, #1
		sub r2, r2, #2
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		add r2,	r2, #6
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		ldr r3, white
		sub r2,	r2, #6
		add r1,	r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		add r2, r2, #6
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		ldr r3, red
		add r2, r2, #3
		add r1, r1, #2
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		sub	r2, r2, #12
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		ldr r3, white
		add r1,	r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		add r2, r2, #12
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		sub r2, r2, #9
		add r5, r2, #5

f:	add r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		cmp r2, r5
		bls	f

		sub r2, r2, #3
		add r1, r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		cmp r2, r5
		add r1, r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		cmp r2, r5

		str	r3, [r0, #12]
		ldr r2, [sp, #1016]
		ldr r3, red
		b f3_back
//------------------------------------------------------------
draw_game_enemy:
		ldr  r3, s_col3    //=0xFF6666FF
		movs r5, r7
		movs r4, r6
		add	 r4, r4, #3
		add  r5, r5, #12

		sub r7, r7, #1
		sub r6,	r6, #1

		bb:		add r7, r7, #1
		aa:		add	r6, r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]
		cmp	r6, r4
		bne	aa
		sub r6, r6, #4
		cmp r7, r5
		bne bb

		add r4, r6, #7
		cc:		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]
		add r6, r6, #1
		cmp r6, r4
		bls cc

		sub r7, r7, #2
		sub r6,	r6, #3
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		sub r7, r7, #1
		add r4, r6, #4

		dd:		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]
		add r6, r6, #1
		cmp r6, r4
		bls dd

		sub r6, r6, #5
		sub r7, r7, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		add r6, r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		sub r6, r6, #2
		sub r7, r7, #1
		add r4, r6, #5

		ff:		add r6, r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]
		cmp r6, r4
		bne ff

		sub r7, r7, #1
		sub r6, r6, #10
		add r4, r4, #2
		gg:		add r6, r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]
		cmp r6, r4
		bne gg

		sub r6, r6, #7
		sub r7, r7, #1
		add r4, r6, #5
		hh:		add r6, r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]
		cmp r6, r4
		bne hh

		sub r6, r6, #4
		sub r7, r7, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]
		add r6, r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		sub r6, r6, #2
		sub r7, r7, #1
		add r4, r6, #5
		jj:		add r6, r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]
		cmp r6, r4
		bne jj

		sub r6, r6, #4
		sub r7, r7, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		sub r7, r7, #2
		add r4, r6, #2
		sub r6, r6, #6
		mm:		add r6, r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]
		cmp r6, r4
		bne mm
		ldr r3, red
		sub r6, r6, #7
		add r7, r7, #12 	//[konum 13,1]

		sub r7, r7, #3
		add r6,	r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		add r6,	r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		sub r7, r7, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		sub r6,	r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		add r6,	r6, #2
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		sub r7, r7, #1
		add r6,	r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		add r6,	r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		add r6,	r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		sub r7, r7, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		add r6,	r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		sub r7, r7, #1
		sub r6, r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		sub r6, r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		sub r6, r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		sub r7, r7, #1
		sub r6, r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		sub r6, r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		sub r6, r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		sub r7, r7, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		add r6, r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		add r6, r6, #5
		sub r7, r7, #3
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		add r6, r6, #2
		add r7, r7, #3
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		add r7, r7, #6
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		add r7, r7, #3
		sub r6, r6, #2
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		ldr r3, white
		add	r6, r6, #4
		sub r7, r7, #6
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]
b end_game_enemy_jump
//------------------------------------------------------------
draw_heart:
    ldr r3, red
		ldr r0, peripheral

		movs r1, r5
		movs r2, r6
		add r2, r2, #2
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		add r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		add r2, r2, #2
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		add r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		movs r4, #1
		add r1, r1, #1
		movs r2, r6
life_loop_1:
		cmp r4, #8
		bhs pass_1
		add r2, r2, #1
		ldr r3, red
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		add r4, r4, #1
		b life_loop_1

pass_1:
		movs r4, #0
		add r1, r1, #1
		movs r2, r6
life_loop_2:
		cmp r4, #9
		bhs pass_2
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		add r2, r2, #1
		add r4, r4, #1
		b life_loop_2

pass_2:
		movs r4, #1
		add r1, r1, #1
		movs r2, r6
life_loop_3:
		cmp r4, #8
		bhs pass_3
		add r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		add r4, r4, #1
		b life_loop_3

pass_3:
		movs r4, #2
		add r1, r1, #1
		movs r2, r6
		add r2, r2, #1
life_loop_4:
		cmp r4, #7
		bhs pass_4
		add r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		add r4, r4, #1
		b life_loop_4

pass_4:
		movs r4, #3
		add r1, r1, #1
		movs r2, r6
		add r2, r2, #2
life_loop_5:
		cmp r4, #6
		bhs pass_5
		add r2, r2, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]
		add r4, r4, #1
		b life_loop_5

pass_5:
		add r1, r1, #1
		movs r2, #6
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		str	r3, [r0, #12]
		sub r7, r7, #1
b end_heart
//------------------------------------------------------------
.balign 4
peripheral:      .word 0x40010000
yellow:          .word 0xFFFFFF00 //yellow
red:             .word 0xFFFF0000 //red
green:           .word 0xFF00FF00 //green
white:           .word 0xFFFFFFFF //white
cyan:            .word 0xFF33FFFF //cyan
s_col1:          .word 0xFFFFFF8D
s_col2:          .word 0xFFFFF9C4
s_col3:          .word 0xFF6666FF
//------------------------------------------------------------
start_jump_3: b start
main_jump_1: b main_jump_2
//------------------------------------------------------------
game_over:
		ldr	r0, peripheral2

		movs	r1, #88
		movs	r2, #120

		ldr r3, white2

		add  r6, r2, #6
		add  r6, r6, #6
		movs r7, #1

Game_over_1:
		cmp r7, #1
		bne x_g_o
		add  r1, r1, #1
		add  r2, r2, #1
		cmp  r2, r6
		bls  yol

x_g_o:
		add  r7, r7, #1
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
		b finish_g_o

kare3:
	add r3, r3, #20

	sub r2, r2, #1
	sub r1, r1, #1
	add r4, r1, #4
	add r5, r2, #4
b_g_o:
	add r2, r2, #1
a_g_o:
	add r1, r1, #1
	str r1, [r0]
	str r2, [r0, #4]
	str r3, [r0, #8]

	cmp r1, r4
	bne a_g_o
	sub r1, r1, #4
	cmp r2, r5
	bne b_g_o

	str	r3, [r0, #12]

	b Game_over_1

finish_g_o:
	lsr r0, r0, #4
	movs r1, #0
z_g_o:
	add r1, r1, #120
	cmp r1, r0
	bls z_g_o

	movs	r1, #88
	movs	r2, #117
	add  r6, r2, #6
	add  r6, r6, #6
	movs r7, #1

	add r3, r3, #200
	lsl r0, r0, #4
b Game_over_1
//------------------------------------------------------------
.balign 4
peripheral2:      .word 0x40010000
white2:           .word 0xFFFFFFFF //white
//------------------------------------------------------------
start:
ldr	r0, =0x40010000

		movs	r1, #100
		movs	r2, #103
		ldr r3, = 0xFFFFFFFF
		movs r7, #0

		start_game:
		ldr r4, [r0, #0x20]
		cmp r4, #2
		beq jump_main_t
		b cont_start

		jump_main_t: b main_jump_1

cont_start:
		add r7, r7, #1

		cmp r7, #1
		beq yol1
		add r1, r1, #1
		add r2, r2, #1
		cmp r7, #2
		beq yol1
		cmp r7, #3
		beq yol1
		cmp r7, #4
		beq yol1
		add r1, r1, #4
		sub r2, r2, #20
		cmp r7, #5
		beq yol1
		add r2, r2, #20
		cmp r7, #6
		beq yol1
		sub r1, r1, #4
		cmp r7, #7
		beq yol1
		cmp r7, #8
		beq yol1
		add r1, r1, #4
		cmp r7, #9
		beq yol1
		sub r2, r2, #4
		cmp r7, #10
		beq yol1
		sub r2, r2, #4
		cmp r7, #11
		beq yol1
		sub r1, r1, #4
		cmp r7, #12
		beq yol1
		cmp r7, #13
		beq yol1

		cmp r7, #14
		beq yol1
		sub r1, r1, #20
		add r2, r2, #28
		cmp r7, #15
		beq yol1
		add r1, r1, #20
		sub r2, r2, #20
		cmp r7, #16
		beq yol1
		cmp r7, #17
		beq yol1
		cmp r7, #18
		beq yol1
		cmp r7, #19
		beq yol1
		add r1, r1, #4
		sub r2, r2, #12
		cmp r7, #20
		beq yol1
		add r2, r2, #8
		cmp r7, #21
		beq yol1
		cmp r7, #22
		beq yol1
		cmp r7, #23
		beq yol1
		cmp r7, #24
		beq yol1
		sub r1, r1, #20
		add r2, r2, #16
		cmp r7, #25
		beq yol1
		add r1, r1, #20
		sub r2, r2, #16
		cmp r7, #26
		beq yol1
		cmp r7, #27
		beq yol1
		cmp r7, #28
		beq yol1
		cmp r7, #29
		beq yol1
		sub r1, r1, #16
		add r2, r2, #4
		cmp r7, #30
		beq yol1
		add r1, r1, #12
		cmp r7, #31
		beq yol1
		cmp r7, #32
		beq yol1
		cmp r7, #33
		beq yol1
		sub r2, r2, #4
		sub r1, r1, #4
		cmp r7, #34
		beq yol1
		b devam_start
		yol1: b kare3_1
devam_start:
		add r1, r1, #12
		cmp r7, #35
		beq kare3_1
		sub r1, r1, #4
		cmp r7, #36
		beq kare3_1
		cmp r7, #37
		beq kare3_1
		sub r1, r1, #24
		sub r2, r2, #4
		cmp r7, #38
		beq kare3_1
		add r1, r1, #20
		cmp r7, #39
		beq kare3_1
		cmp r7, #40
		beq kare3_1
		add r2, r2, #24
		cmp r7, #41
		beq kare3_1
		add r1, r1, #4
		sub r2, r2, #20
		cmp r7, #42
		beq kare3_1
		cmp r7, #43
		beq kare3_1
		cmp r7, #44
		beq kare3_1
		cmp r7, #45
		beq kare3_1
		cmp r7, #46
		beq kare3_1
		sub r1, r1, #24
		add r2, r2, #4
		cmp r7, #47
		beq kare3_1
		add r1, r1, #20
		cmp r7, #48
		beq kare3_1
		cmp r7, #49
		beq kare3_1
		add r1, r1, #4
		cmp r7, #50
		beq kare3_1
		sub r2, r2, #8
		cmp r7, #51
		beq kare3_1
		sub r1, r1, #4
		cmp r7, #52
		beq kare3_1
		cmp r7, #53
		beq kare3_1
		add r1, r1, #4
		add r2, r2, #8
		cmp r7, #54
		beq kare3_1
		cmp r7, #55
		beq kare3_1
		cmp r7, #56
		beq kare3_1
		sub r1, r1, #24
		add r2, r2, #4
		cmp r7, #57
		beq kare3_1
		add r1, r1, #20
		sub r2, r2, #4
		cmp r7, #58
		beq kare3_1
		cmp r7, #59
		beq kare3_1
		cmp r7, #60
		beq kare3_1
		cmp r7, #61
		beq kare3_1
		add r1, r1, #4
		sub r2, r2, #12
		cmp r7, #62
		beq kare3_1
		add r2, r2, #8
		cmp r7, #63
		beq kare3_1
		cmp r7, #64
		beq kare3_1
		cmp r7, #65
		beq kare3_1
		cmp r7, #66
		beq kare3_1
		b finish_start

kare3_1:
		add r3, r3, #20

		sub r2, r2, #1
		sub r1, r1, #1
		add r4, r1, #4
		add r5, r2, #4
b_sp:
	 add r2, r2, #1
a_sp:
	 add r1, r1, #1
	str r1, [r0]
	str r2, [r0, #4]
	str r3, [r0, #8]

	cmp r1, r4
	bne a_sp
	sub r1, r1, #4
	cmp r2, r5
	bne b_sp

	str	r3, [r0, #12]

	b start_game

finish_start:
	lsr r0, r0, #4
	movs r1, #0
z_sp:
  add r1, r1, #120
	cmp r1, r0
	bls z_sp

	movs	r1, #100
	movs	r2, #101
	add  r6, r2, #6
	add  r6, r6, #6
	movs r7, #0

	add r3, r3, #1
	lsl r0, r0, #4
b start_game
