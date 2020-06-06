initial_sp:        .word    0x201FFFFC
reset_vector:      .word    initialize
initialize:
		movs r1, #20
		str r1, [sp, #208]
		add r1, r1, #30
		str r1, [sp, #196]
		str r1, [sp, #188]
		add r1, r1, #14
		str r1, [sp, #180]
		movs r1, #140
	  str r1, [sp, #204]
		add r1, r1, #13
		str r1, [sp, #192]
		add r1, r1, #19
		str r1, [sp, #184]
		movs r1, #158
		str  r1, [sp, #176]
		movs r1, #150    //initialization
		add  r1, r1, #150
		movs r2, #156
    str  r2, [sp, #1008]
		str  r1, [sp, #1012]
		str  r1, [sp, #132]
		str  r1, [sp, #128]
		str  r1, [sp, #116]
		str  r1, [sp, #112]
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
		str  r7, [sp, #400]
		str  r7, [sp, #156]
		str  r7, [sp, #152]
		str  r7, [sp, #148]
		str  r7, [sp, #144]
		str  r7, [sp, #140]
		str  r7, [sp, #136]
		str  r7, [sp, #168]
		str  r7, [sp, #172]
		str  r7, [sp, #200]
		str  r7, [sp, #32]
		str  r7, [sp, #28]  //zero kills, yet...
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
			str	r3, [r0, #0x10]
	     	b show            //show
f1:		    b update          //update
main_loop_2:
			ldr r7, [sp, #4]
			cmp r7, #0
			beq game_over_page
			b main_loop

game_over_page:
			str	r3, [r0, #0x10]
			b game_over_jump_1

you_win_page:
			str	r3, [r0, #0x10]
			b you_win_jump_1
//-------------------------------------------------------------
update:
		b set_enemy
f15:	ldr r7, [sp, #96]
		cmp r7, #0
		beq set_player
f14:    b update_movement    //update player position -> f2
f2:     b collide            //check wall collision -> f7
f7:     ldr r7, [sp, #1012]  //check if fire has expired
        cmp r7, #0
        beq update_fire_j      // -> f9
f9:     b update_enemy       // -> f10 (update movement inside)
f10:    b update_enemy_fire_jump  // -> f12
f12:	b update_player_jump        // -> f4
f4:		b check_boss_level_jump
f16:	b update_boss_hit_jump
f18:	b update_fire_boss_jump
f19:    ldr r7, [sp, #32]
		cmp r7, #10
		bhs you_win_page_reset
        b main_loop_2
show:
		b show_life_points_jump // -> f13
f13:    b show_charater      // -> f3
f3:		b show_enemy         // -> f8
f8:     ldr r7, [sp, #1012]  //show fire
  		cmp r7, #0
  		bhi show_fire_jj        // -> f5
f5:     b show_enemy_fire_jump  // -> f11
f11:    b show_boss_fire_jump
f20:    b show_boss_jump
f17:    b show_explosion_jump
f21:    b delay                   // -> f6
f6:     str	r3, [r0, #12]
 		b f1

show_fire_jj: b show_fire
update_fire_j: b update_fire
//-------------------------------------------------------------
you_win_page_reset:
		movs r7, #3
		str r7, [sp, #200]
		ldr r7, [sp, #1020]
		movs r6, #0
		cmp r7, r6
		blt you_win_page
		sub r7, r7, #1
		str r7, [sp, #1020]
		b main_loop_2
//-------------------------------------------------------------
set_player:
			ldr r7, [sp, #200]
			cmp r7, #0
			bne e_set_player

			ldr r1, [sp, #1020]
			cmp r1, #200
			beq finish_player_setup
			sub r1, r1, #1
			str r1, [sp, #1020]
e_set_player:
			b f14

finish_player_setup:
      str  r1, [sp, #1012]
			movs r1, #1
			str  r1, [sp, #96]
b f14
//-------------------------------------------------------------
update_movement:
		ldr r1, [sp, #96]
		ldr r2, [sp, #200]
		orr r1, r1, r2
		cmp r1, #0
		beq f2
		cmp r2, #3
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
		ldr r2, [sp, #200]
		orr r1, r1, r2
		cmp r1, #0
		beq f7
		cmp r2, #3
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
		ldr r7, [sp, #200]
		cmp r7, #3
		beq f9_exit
    ldr r5, [sp, #1020] //row data
		ldr r6, [sp, #1016] //column data
		add r6, r6, #6
		str r5, [sp, #1012]
		str r6, [sp, #1008]
f9_exit:
		b f9
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
		bls   draw_game_character_p_jj
		b f3
draw_game_character_p_jj: b draw_game_character_p_j
//-------------------------------------------------------------
delay:
    movs r7, #0
		ldr  r6, delay_constant
delay_loop:
    cmp  r7, r6
    beq  f6_exit
    add  r7, r7, #1
    b delay_loop
f6_exit: b f6
//-------------------------------------------------------------
show_fire:
		ldr r7, [sp, #200]
		cmp r7, #3
		beq e_show_fire

		ldr r1, [sp, #96]
		cmp r1, #0
		beq e_show_fire

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
		//str	r3, [r0, #12]
    movs r7, #0
e_show_fire:
		b f5
//-------------------------------------------------------------//1'st jump point
show_enemy_fire_jump: b show_enemy_fire
update_enemy_fire_jump: b update_enemy_fire
update_player_jump: b update_player
ldr_r0_1: b ldr_r0_2_j
ldr_r3_1: b ldr_r3_2_j
show_life_points_jump: b show_life_points
update_boss_hit_jump: b update_boss_hit
update_fire_boss_jump: b update_fire_boss
show_boss_fire_jump: b show_boss_fire
//-------------------------------------------------------------
.balign 4
delay_constant:  .word 10000
width:           .word 310
//-------------------------------------------------------------
show_enemy:
		ldr r7, [sp, #200]
		cmp r7, #2
		beq e_show_enemy

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
e_show_enemy:
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
		b draw_game_enemy_jump_j
end_game_enemy:

		movs r7, r2
		//str	r3, [r0, #12]
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
check_boss_level_jump: b check_boss_level
f16_j: b f16
show_boss_jump: b show_boss_jump_1
show_explosion_jump: b show_explosion_jump_1
f17_j1: b f17
draw_game_character_p_j: b draw_game_character_p
//-------------------------------------------------------------
update_boss_hit:
ldr r7, [sp, #200]
cmp r7, #2
bne e_update_boss
b up_b

e_update_boss:
b f18

up_b:
		ldr r6, [sp, #1012] //fire position
		ldr r7, [sp, #1008]
		ldr r4, [sp, #208] //enemy position
		ldr r5, [sp, #204]

		cmp r7, r5
		bhs check1b
		b f18
check1b:
		add r5, r5, #45
		cmp r7, r5
		bls check2b
		b f18
check2b:
		cmp r6, r4
		bhs check3b
		b f18
check3b:
		add r4, r4, #45
		cmp r6, r4
		bls check4b
		b f18
check4b:
		movs r1, #0
		ldr r1, [sp, #32]
		add r1, r1, #1
		str r1, [sp, #32]

		ldr r3, [sp, #16]
		cmp r3, #0
		beq reset_fire_player_b
		b lcun4_ld_pl_b

reset_fire_player_b:
		movs r5, #0
		movs  r6, #1
		str r5, [sp, #1012]
		str r6, [sp, #1008] //update fire
		b f18
lcun4_ld_pl_b:
		ldr r5, [sp, #1020] //row data
		ldr r6, [sp, #1016] //column data
		add r6, r6, #6
		str r5, [sp, #1012]
		str r6, [sp, #1008] //update fire
		b f18
//-------------------------------------------------------------
update_fire_boss:
		ldr r7, [sp, #200]
		cmp r7, #2
		bne f19_exit

		ldr r4, [sp, #12]  //load counter
		ldr r7, [sp, #96]
		cmp r7, #0
		beq f19_exit

up_boss_fire_cont:
		cmp r4, #0
		beq ubf1
		cmp r4, #1
		beq ubf2
		movs r4, #0
		str r4, [sp, #12] //reset counter
		b f19

ubf1:
		ldr r7, [sp, #196]
		cmp r7, #255
		bhs up_fire_1_b
		b lcun_boss_1
up_fire_1_b:
		ldr r5, [sp, #208] //row data
		ldr r6, [sp, #204] //column data
		add r6, r6, #13
    add r5, r5, #30
		str r5, [sp, #196] //reset fire position to boss position
		str r6, [sp, #192]
		b lcun_boss_1

ubf2:
	  ldr r7, [sp, #188]
		cmp r7, #255
		bhs up_fire_2_b
		b lcun_boss_1
up_fire_2_b:
		ldr r5, [sp, #208] //row data
		ldr r6, [sp, #204] //column data
		add r6, r6, #32
		add r5, r5, #30
		str r5, [sp, #188] //reset fire position to enemy position
		str r6, [sp, #184]
		b lcun_boss_1

lcun_boss_1:
		add r4, r4, #1 //increment counter
		b up_boss_fire_cont

f19_exit:
		b f19
//-------------------------------------------------------------
show_boss_fire:
		ldr r7, [sp, #200]
		cmp r7, #2
		bne f20_exit

		ldr r4, [sp, #12]  //load counter
		b ldr_r3_4b_j

boss_fire_cont:
		cmp   r4, #0
		beq   f_b1
		cmp   r4, #1
		beq   f_b2
		cmp   r4, #2
		beq   f_b3
		movs  r4, #0
		str   r4, [sp, #12] //reset counter
		b f20_exit

f_b1:
		ldr  r5, [sp, #196] //row data
		movs r7, r5
		ldr  r6, [sp, #192] //column data
		ldr  r1, [sp, #196]
		cmp  r1, #255
		bls  f_b1_fire
		b lcun_boss_2
f_b1_fire:
		add  r7, r7, #1
		str  r7, [sp, #196]
		movs r7, #0
		b draw_fire_boss

f_b2:
		ldr  r5, [sp, #188] //row data
		movs r7, r5
		ldr  r6, [sp, #184] //column data
		ldr  r1, [sp, #188]
		cmp  r1, #255
		bls  f_b2_fire
		b lcun_boss_2
f_b2_fire:
		add  r7, r7, #1
		str  r7, [sp, #188]
		movs r7, #0
		b draw_fire_boss

f_b3:
		movs r6, #200
		add r6, r6, #200
		add r6, r6, #100
		ldr  r7, [sp, #172]
		cmp  r7, r6
		bls  laser_timer_inc
		add r6, r6, #100
		cmp  r7, r6
		bls  draw_laser_boss
		cmp  r7, r6
		bhi  reset_laser_timer
		b lcun_boss_2
laser_timer_inc:
		add r7, r7, #1
		str r7, [sp, #172]
		b lcun_boss_2
reset_laser_timer:
		movs r7, #0
		str r7, [sp, #168]
		str r7, [sp, #172]
		b lcun_boss_2

draw_fire_boss:
		str	r5, [r0]
		str	r6, [r0, #4]
		str	r3, [r0, #8]
		add r7, r7, #1
		sub r5, r5, #1
		cmp r7, #4
		bne draw_fire_boss
		b lcun_boss_2

draw_laser_boss:
		movs r5, #1
		str r5, [sp, #168]
		add r7, r7, #1
		str r7, [sp, #172]
		ldr  r5, [sp, #180] //row data
		ldr  r6, [sp, #176] //column data
		b ldr_r3_white_boss_j
return_laser:
		str   r5, [r0]
		str 	r6, [r0, #4]
		str	  r3, [r0, #8]
		movs r1, #200
		movs r2, #9
		add r1, r1, r5
		add r2, r2, r6
b_laser:
		add	r6, r6, #1
a_laser:
		add	r5, r5, #1
		str	r5, [r0]
		str	r6, [r0, #4]
		str	r3, [r0, #8]

		cmp	r5, r1
		bne	a_laser
		ldr r5, [sp, #180]
		cmp	r6, r2
		bne	b_laser
		ldr r6, [sp, #176]
    b lcun_boss_2

lcun_boss_2:
		movs r7, #0
		str r3, [r0, #12]
		add r4, r4, #1  //increment counter
		b boss_fire_cont

f20_exit:
		b f20
//-------------------------------------------------------------
set_enemy:
		ldr r2, [sp, #200]
		cmp r2, #0
		bne end_set

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
you_win_jump_1: b you_win_jump_2
start_jump_1: b start_jump_2
main_jump_3: b main_loop
ldr_f4_j: b f4
ldr_r3_2_j: b ldr_r3_2
ldr_r0_2_j: b ldr_r0_2
draw_game_enemy_jump_j: b draw_game_enemy_jump
draw_game_character_p:    b draw_game_character
boss_fire_cont_j: b boss_fire_cont
f12_j: b f12
f21_jump5: b f21
//-------------------------------------------------------------
update_enemy:
		ldr r7, [sp, #200]
	//	cmp r7, #1
	//	beq remove_enemies_j
		cmp r7, #2
		beq e_update_enemy

    ldr r2, [sp, #12]   //counter
		b move_enemy

remove_enemies_j: b remove_enemies

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
e_update_enemy:
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
		beq lcun4_j
		ldr r6, [sp, #1012] //fire position
		ldr r7, [sp, #1008]
		ldr r4, [sp, #984] //enemy position
		ldr r5, [sp, #980]
		ldr r3, [sp, #976]  //is enemy dead
		b update_chain1
up_en_3:
		ldr r1, [sp, #84]
		cmp r1, #0
		beq lcun4_j
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
		ldr r1, [sp, #28]
		add r1, r1, #1
		str r1, [sp, #28]
		movs r7, #75
		ldr r1, e1_time
	  sub  r7, r7, r1
		str r7, [sp, #1004]
		str r7, [sp, #992]
		b lcun4_ld
kill2:
		ldr r1, [sp, #984]
		str r1, [sp, #116]
		movs r1, #0
		str r1, [sp, #88]
		ldr r1, [sp, #28]
		add r1, r1, #1
		str r1, [sp, #28]
		movs r7, #75
		ldr r1, e2_time
		sub  r7, r7, r1
		str r7, [sp, #984]
		str r7, [sp, #972]
		ldr r7, [sp, #980]
		str r7, [sp, #132]
		movs r7, #15
		str r7, [sp, #980]
		b lcun4_ld
kill3:
		movs r1, #0
		str r1, [sp, #84]
		ldr r1, [sp, #28]
		add r1, r1, #1
		str r1, [sp, #28]
		movs r7, #75
		ldr r1, e1_time
	  sub  r7, r7, r1
		str r7, [sp, #964]
		str r7, [sp, #952]
		b lcun4_ld
kill4:
		movs r1, #0
		str r1, [sp, #80]
		ldr r1, [sp, #28]
		add r1, r1, #1
		str r1, [sp, #28]
		movs r7, #75
		ldr r1, e1_time
		sub  r7, r7, r1
		str r7, [sp, #944]
		str r7, [sp, #932]
		b lcun4_ld
kill5:
		ldr r1, [sp, #924]
		str r1, [sp, #112]
		movs r1, #0
		str r1, [sp, #76]
		ldr r1, [sp, #28]
		add r1, r1, #1
		str r1, [sp, #28]
		movs r7, #75
		ldr r1, e2_time
		sub  r7, r7, r1
		str r7, [sp, #924]
		str r7, [sp, #912]
		ldr r7, [sp, #920]
		str r7, [sp, #128]
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
check_boss_level:
		ldr r7, [sp, #28]
		cmp r7, #10
		bhs reset_enemies
		ldr r7, [sp, #200]
		cmp r7, #1
		beq remove_enemies
		cmp r7, #2
		beq set_boss
		b f16_j

reset_enemies:
		movs r7, #1
		str r7, [sp, #200]
		str r7, [sp, #28]
		movs r7, #0
		str r7, [sp, #92]
		str r7, [sp, #88]
		str r7, [sp, #84]
		str r7, [sp, #80]
		str r7, [sp, #76]
		str r7, [sp, #96]
		movs r7, #250
		add r7, r7, #50
		str r7, [sp, #992]
		str r7, [sp, #972]
		str r7, [sp, #952]
		str r7, [sp, #932]
		str r7, [sp, #912]
		b f16_j
//-------------------------------------------------------------
remove_enemies:
		movs r7, #10
		sub r7, r7, #35
		movs r5, #0

re1:
    ldr r1, [sp, #1004]
		cmp r1, r7
		blt re2_1
		sub r1, r1, #1
		str r1, [sp, #1004]
		b re2
re2_1: add r5, r5, #1
re2:
  	ldr r1, [sp, #984]
		cmp r1, r7
		blt re3_1
		sub r1, r1, #1
		str r1, [sp, #984]
		b re3
re3_1: add r5, r5, #1
re3:
		ldr r1, [sp, #964]
		cmp r1, r7
		blt re4_1
		sub r1, r1, #1
		str r1, [sp, #964]
		b re4
re4_1: add r5, r5, #1
re4:
		ldr r1, [sp, #944]
		cmp r1, r7
		blt re5_1
		sub r1, r1, #1
		str r1, [sp, #944]
		b re5
re5_1: add r5, r5, #1
re5:
		ldr r1, [sp, #924]
		cmp r1, r7
		blt e_rem_en_1
		sub r1, r1, #1
		str r1, [sp, #924]
		b e_rem_en
e_rem_en_1: add r5, r5, #1
		cmp r5, #5
		beq set_boss
e_rem_en:
		b f16_j

set_boss:
		movs r7, #2
		str r7, [sp, #200]
		ldr r5, [sp, #104]
		cmp r5, #1
		blt update_boss_cont_1
		b move_boss_cont
update_boss_cont_1:
		add r5, r5, #1
		str r5, [sp, #104]
		b exit_move_boss
move_boss_cont:
		movs r5, #0
		str r5, [sp, #104]
		ldr r1, [sp, #24]
		ldr r7, [sp, #204]
		ldr r6, [sp, #176]
		cmp r1, #0
		beq move_boss_right
		cmp r1, #1
		beq move_boss_left
		b exit_move_boss

move_boss_right:
		add r7, r7, #1
		add r6, r6, #1
		str r6, [sp, #176]
		str r7, [sp, #204]
		movs r6, #250
		cmp r7, r6
		bhs assign_1_boss
		b exit_move_boss
move_boss_left:
		sub r7, r7, #1
		sub r6, r6, #1
		str r6, [sp, #176]
		str r7, [sp, #204]
		cmp r7, #60
		bls assign_0_boss
		b exit_move_boss

assign_0_boss:
		movs r1, #0
		str  r1, [sp, #24]
		b exit_move_boss
assign_1_boss:
		movs r1, #1
		str  r1, [sp, #24]
exit_move_boss:
		b f16_j
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
f17_j2: b f17_j1
show_boss_jump_1: b show_boss_jump_2
show_explosion_jump_1: b show_explosion_jump_2
f21_jump4: b f21_jump5
ldr_r3_3: b ldr_r3_3_j
end_game_enemy_j: b end_game_enemy
ldr_r3_4b_j: b ldr_r3_4b
return_laser_j: b return_laser
ldr_r3_white_boss_j: b ldr_r3_white_boss
//-------------------------------------------------------------
show_enemy_fire:
		ldr r7, [sp, #200]
		cmp r7, #2
		beq e_s_e_f

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
e_s_e_f:
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
		movs r1, #1
		str r1, [sp, #400]
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
		ldr r7, [sp, #200]
		cmp r7, #2
		beq e_u_e

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
		b f12_j

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

update_player_cont_test:
		ldr r7, [sp, #200]
		cmp r7, #2
		beq boss_kill_player_j
		b update_player_cont

boss_kill_player_j: b boss_kill_player

update_player_cont:
		cmp r2, #0
		beq up_pl_1
	  cmp r2, #1
		beq up_pl_2
		cmp r2, #2
		beq up_pl_3
		cmp r2, #3
		beq up_pl_4
		cmp r2, #4
		beq up_pl_5
		movs r2, #0
		str r2, [sp, #12]
		b ldr_f4_j

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
up_pl_5:
		ldr r6, [sp, #912] //fire position
		add r6, r6, #4
		ldr r7, [sp, #908]
		ldr r4, [sp, #1020] //player position
		ldr r5, [sp, #1016]
		ldr r3, [sp, #916]
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

kill_player:
		cmp r2, #0
		beq killp1
		cmp r2, #1
		beq killp2
		cmp r2, #2
		beq killp3
		cmp r2, #3
		beq killp4
		cmp r2, #4
		beq killp5
		movs r2, #0
		str r2, [sp, #12]
		b ldr_f4_j

killp1:
		ldr r1, [sp, #1020]
		str r1, [sp, #124]
		ldr r1, [sp, #1016]
		str r1, [sp, #120]
		movs r1, #150
		add r1, r1, #150
		str r1, [sp, #1020]
		sub r1, r1, #250
		sub r1, r1, #50
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
		ldr r1, [sp, #1020]
		str r1, [sp, #124]
		ldr r1, [sp, #1016]
		str r1, [sp, #120]
		movs r1, #150
		add r1, r1, #150
		str r1, [sp, #1020]
		sub r1, r1, #250
		sub r1, r1, #50
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
		ldr r1, [sp, #1020]
		str r1, [sp, #124]
		ldr r1, [sp, #1016]
		str r1, [sp, #120]
		movs r1, #150
		add r1, r1, #150
		str r1, [sp, #1020]
		sub r1, r1, #250
		sub r1, r1, #50
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
		ldr r1, [sp, #1020]
		str r1, [sp, #124]
		ldr r1, [sp, #1016]
		str r1, [sp, #120]
		movs r1, #150
		add r1, r1, #150
		str r1, [sp, #1020]
		sub r1, r1, #250
		sub r1, r1, #50
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
killp5:
		ldr r1, [sp, #1020]
		str r1, [sp, #124]
		ldr r1, [sp, #1016]
		str r1, [sp, #120]
		movs r1, #150
		add r1, r1, #150
		str r1, [sp, #1020]
		sub r1, r1, #250
		sub r1, r1, #50
		str r1, [sp, #1016]
		movs r1, #0
		str r1, [sp, #16]  //player is dead
		ldr r1, [sp, #4]    //life points
		sub r1, r1, #1
		str r1, [sp, #4]    //update life points
		ldr r5, [sp, #924] //row data
		ldr r6, [sp, #920] //column data
		add r6, r6, #7
		str r5, [sp, #912]
		str r6, [sp, #908] //update fire
		b lcun5

boss_kill_player:
		cmp r2, #0
		beq up_pl_1b
		cmp r2, #1
		beq up_pl_2b
		cmp r2, #2
		beq up_pl_3b
		movs r2, #0
		str r2, [sp, #12]
		b ldr_f4_j

up_pl_1b:
		ldr r6, [sp, #196] //fire position
		add r6, r6, #4
		ldr r7, [sp, #192]
		ldr r4, [sp, #1020] //player position
		ldr r5, [sp, #1016]
		b update_chain_2b
up_pl_2b:
		ldr r6, [sp, #188] //fire position
		add r6, r6, #4
		ldr r7, [sp, #184]
		ldr r4, [sp, #1020] //player position
		ldr r5, [sp, #1016]
		b update_chain_2b
up_pl_3b:
		ldr r7, [sp, #176]
		ldr r5, [sp, #1016]
		b update_chain_3b

update_chain_2b:
		cmp r7, r5
		bhs checkp1b
		b lcun5
checkp1b:
		add r5, r5, #13
		cmp r7, r5
		bls checkp2b
		b lcun5
checkp2b:
		cmp r6, r4
		bhs checkp3b
		b lcun5
checkp3b:
		add r4, r4, #12
		cmp r6, r4
		bls kill_player_b //checkp4
		b lcun5

update_chain_3b:
		add r5, r5, #12
		cmp r5, r7
		bhs checkp1b_1
		b lcun5
checkp1b_1:
		ldr r5, [sp, #1016]
		add r7, r7, #9
		cmp r5, r7
		bls checkp2b_1
		b lcun5
checkp2b_1:
		ldr r5, [sp, #168]
		cmp r5, #1
		beq kill_player_b
		b lcun5

kill_player_b:
		cmp r2, #0
		beq killp1b
		cmp r2, #1
		beq killp2b
		cmp r2, #2
		beq killp3b
		movs r2, #0
		str r2, [sp, #12]
		b ldr_f4_j

killp1b:
		ldr r1, [sp, #1020]
		str r1, [sp, #124]
		ldr r1, [sp, #1016]
		str r1, [sp, #120]
		movs r1, #150
		add r1, r1, #150
		str r1, [sp, #1020]
		sub r1, r1, #250
		sub r1, r1, #50
		str r1, [sp, #1016]
		movs r1, #0
		str r1, [sp, #16]   //player is dead
		ldr r1, [sp, #4]    //life points
		sub r1, r1, #1
		str r1, [sp, #4]    //update life points
		ldr r5, [sp, #208] //row data
		ldr r6, [sp, #204] //column data
		add r6, r6, #13
		add r5, r5, #30
		str r5, [sp, #196]
		str r6, [sp, #192] //update fire
		b lcun5
killp2b:
		ldr r1, [sp, #1020]
		str r1, [sp, #124]
		ldr r1, [sp, #1016]
		str r1, [sp, #120]
		movs r1, #150
		add r1, r1, #150
		str r1, [sp, #1020]
		sub r1, r1, #250
		sub r1, r1, #50
		str r1, [sp, #1016]
		movs r1, #0
		str r1, [sp, #16]  //player is dead
		ldr r1, [sp, #4]    //life points
		sub r1, r1, #1
		str r1, [sp, #4]    //update life points
		ldr r5, [sp, #208] //row data
		ldr r6, [sp, #204] //column data
		add r6, r6, #32
		add r5, r5, #30
		str r5, [sp, #188]
		str r6, [sp, #184] //update fire
		b lcun5
killp3b:
		movs r1, #0
		str r1, [sp, #16]  //player is dead
		str r1, [sp, #4]    //life points = 0
		b lcun5

lcun5:
		add r2, r2, #1
		b update_player_cont_test
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
		b ldr_f4_j
reset_player_now:
		movs r1, #1
		str r1, [sp, #16]
		movs r1, #0
		str r1, [sp, #8]
b ldr_f4_j
jump_f4: b ldr_f4_j
//------------------------------------------------------------
end_heart_j: b end_heart
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
ldr_r3_3_j: ldr r3, green
					b ret3_j
ldr_r3_4: ldr r3, red
					b enemy_fire_cont
ldr_r3_4b: ldr r3, red
					b boss_fire_cont_j
draw_game_enemy_jump: b draw_game_enemy
end_game_enemy_jump: b end_game_enemy_j
game_over_jump_2: b game_over
you_win_jump_2: b you_win_jump_3
start_jump_2: b start_jump_3
main_jump_2: b main_jump_3
f17_j3: b f17_j2
show_boss_jump_2: b show_boss_jump_3
show_explosion_jump_2: b show_explosion_jump_3
f21_jump3: b f21_jump4
ldr_r3_white_boss: ldr r3, white
                   b return_laser_j
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
b end_heart_j
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
f17_j4: b f17_j3
show_boss_jump_3: b show_boss
show_explosion_jump_3: b show_explosion_jump_4
f21_jump2: b f21_jump3
you_win_jump_3: b you_win_jump_4
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
		//ldr	r0, =0x40010000
		b ldr_r0_3
ret_r0_3:
		movs	r1, #100
		movs	r2, #103
		//ldr r3, = 0xFFFFFFFF
		b ldr_r3_5
ret_r3_5:
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
//------------------------------------------------------------
f17_j5: b f17_j4
you_win_jump_4: b you_win_jump_5
show_explosion_jump_4: b show_explosion_jump_5
f21_jump1: b f21_jump2
//------------------------------------------------------------
show_boss:
ldr r1, [sp, #200]
cmp r1, #2
bne exit_show_boss_jj
b cont_show_boss
exit_show_boss_jj: b exit_show_boss_j

cont_show_boss:
movs r1, #1
str r1, [sp, #96]

b ldr_r0_boss_j
return0:	movs r1, #0 //sayac register
virusyap:
    	cmp r1, #0
			bne	atla0
			ldr	r6, [sp, #208]	//row
			ldr	r7, [sp, #204] //column
			b ldr_r3_boss_j
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
//-----------------------
		ldr_r0_3: ldr r0, per2
							b ret_r0_3
		ldr_r3_5: ldr r3, whi2
							b ret_r3_5
exit_show_boss_j: b exit_show_boss
you_win_jump_5: b you_win_s
ldr_r0_boss_j: b ldr_r0_boss
ldr_r3_boss_j: b ldr_r3_boss
return0_j: b return0
return3_j: b return3
//-----------------------
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
		ldr r3,colorx
		sub r7,r7,#4
		add r6,r6,#7
		b	kare2
atla100:cmp r1,#100
		bne atla101
		ldr r3,colorx
		sub r7,r7,#5
		add r6,r6,#4
		b	kare2
atla101:cmp r1,#101
		bne atla102
		ldr r3,colorx
		sub r7,r7,#3
		add r6,r6,#3
		b	kare2
atla102:cmp r1,#102
		bne atla103
		ldr r3,colorx
		sub r7,r7,#1
		add r6,r6,#5
		b	kare2
atla103:cmp r1,#103
		bne atla104
		ldr r3,colorx
		add r6,r6,#5
		b	kare2
atla104:cmp r1,#104
		bne atla105
		ldr r3,colorx
		add r7,r7,#1
		add r6,r6,#5
		b	kare2
atla105:cmp r1,#105
		bne atla106
		ldr r3,colorx
		add r7,r7,#2
		add r6,r6,#3
		b	kare2
atla106:cmp r1,#106
		bne atla107
		ldr r3,colorx
		add r7,r7,#4
		add r6,r6,#3
		b	kare2
atla107:cmp r1,#107
		bne atla108
		ldr r3,colorx
		add r7,r7,#3
		sub r6,r6,#4
		b	kare2
atla108:cmp r1,#108
		bne atla109
		ldr r3,colorx
		sub r7,r7,#3
		sub r6,r6,#6
		b	kare2
atla109:cmp r1,#109
		bne atla110
		ldr r3,colorx
		sub r7,r7,#4
		sub r6,r6,#4
		b	kare2
atla110:cmp r1,#110
		bne atla111
		ldr r3,colorx
		sub r6,r6,#4
		b	kare2
atla111:cmp r1,#111
		bne atla112
		ldr r3,colorx
		add r7,r7,#2
		sub r6,r6,#6
		b	kare2
atla112:cmp r1,#112
		bne atla113
		ldr r3,colorx
		add r7,r7,#1
		sub r6,r6,#8
		b	kare2
atla113:cmp r1,#113
		bne atla114
		ldr r3,colorx
		add r7,r7,#7
		add r6,r6,#17
		b	kare2
atla114:cmp r1,#114
		bne atla115
		ldr r3,colorx
		add r7,r7,#3
		sub r6,r6,#16
		b	kare2
atla115:cmp r1,#115
		bne atla116
		ldr r3,colorx
		add r7,r7,#1
		add r6,r6,#30
		b	kare2
atla116:cmp r1,#116
		bne atla117
		ldr r3,colorx
		add r7,r7,#1
		sub r6,r6,#21
		b	kare2
atla117:cmp r1,#117
		bne atla118
		ldr r3,colorx
		add r7,r7,#5
		add r6,r6,#15
		b	kare2
atla118:cmp r1,#118
		bne atla119
		ldr r3,colorx
		sub r7,r7,#1
		sub r6,r6,#4
		b	kare2
atla119:cmp r1,#119
		bne atla120
		ldr r3,colorx
		add r7,r7,#5
		add r6,r6,#10
		b	kare2
atla120:cmp r1,#120
		bne atla121
		ldr r3,colorx
		add r7,r7,#1
		sub r6,r6,#21
		b	kare2
atla121:
		str	r3, [r0, #12]
		b f17_j5
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
exit_show_boss:
		b f17_j5
//------------------------------------------------------------
show_explosion_jump_5: b show_explosion
f21_jump: b f21_jump1
//------------------------------------------------------------
.balign 4
per2: .word 0x40010000
whi2: .word 0xFFFFFFFF
colorx: .word 0xFFD8E145
//------------------------------------------------------------
you_win_s:
		b ldr_r0_win
ret_win_r0:

		movs	r1, #88
 		movs	r2, #120
		b ldr_r3_win
ret_win_r3:
 		movs r7, #0

you_win:
	add r7, r7, #1

	cmp r7, #1
	beq yol_win

	add r1, r1, #5
	add r2, r2, #1
	cmp r7, #2
	beq yol_win
	cmp r7, #3
	beq yol_win
	sub r1, r1, #8
	cmp r7, #4
	beq yol_win
	cmp r7, #5
	beq yol_win
	sub r2, r2, #12
	add r1, r1, #16
	cmp r7, #6
	beq yol_win
	add r2, r2, #8
	sub r1, r1, #8
	cmp r7, #7
	beq yol_win
	cmp r7, #8
	beq yol_win
	sub r1, r1, #20
	add r2, r2, #16
	cmp r7, #9
	beq yol_win
	add r1, r1, #20
	sub r2, r2, #16
	cmp r7, #10
	beq yol_win
	cmp r7, #11
	beq yol_win
	cmp r7, #12
	beq yol_win
	add r2, r2, #4
	cmp r7, #13
	beq yol_win
	sub r1, r1, #4
	cmp r7, #14
	beq yol_win
	cmp r7, #15
	beq yol_win
	sub r1, r1, #4
	cmp r7, #16
	beq yol_win
	sub r2, r2, #4
	cmp r7, #17
	beq yol_win
	cmp r7, #18
	beq yol_win
	cmp r7, #19
	beq yol_win
	sub r2, r2, #4
	cmp r7, #20
	beq yol_win
	add r1, r1, #4
	cmp r7, #21
	beq yol_win
	cmp r7, #22
	beq yol_win
	add r2, r2, #24
	cmp r7, #23
	beq yol_win
	b devam_win
yol_win: b kare3_win
devam_win:
	add r1, r1, #4
	sub r2, r2, #20
	cmp r7, #24
	beq yol_win
	cmp r7, #25
	beq yol_win
	cmp r7, #26
	beq yol_win
	cmp r7, #27
	beq yol_win
	add r2, r2, #4
	cmp r7, #28
	beq yol_win
	sub r1, r1, #4
	cmp r7, #29
	beq yol_win
	cmp r7, #30
	beq yol_win
	sub r1, r1, #4
	cmp r7, #31
	beq yol_win
	sub r2, r2, #4
	cmp r7, #32
	beq yol_win
	cmp r7, #33
	beq yol_win
	cmp r7, #34
	beq yol_win
	cmp r7, #35
	beq yol_win

	add r1, r1, #36
	sub r2, r2, #52
	cmp r7, #36
	beq kare3_win
	sub r1, r1, #28
	add r2, r2, #52
	cmp r7, #37
	beq kare3_win
	cmp r7, #38
	beq kare3_win
	cmp r7, #39
	beq kare3_win
	cmp r7, #40
	beq kare3_win
	cmp r7, #41
	beq kare3_win
	sub r1, r1, #8
	add r2, r2, #4
	cmp r7, #42
	beq kare3_win
	cmp r7, #43
	beq kare3_win
	add r1, r1, #8
	cmp r7, #44
	beq kare3_win
	cmp r7, #45
	beq kare3_win
	sub r1, r1, #8
	sub r2, r2, #4
	cmp r7, #46
	beq kare3_win
	cmp r7, #47
	beq kare3_win
	cmp r7, #48
	beq kare3_win
	cmp r7, #49
	beq kare3_win
	cmp r7, #50
	beq kare3_win
	add r1, r1, #4
	add r2, r2, #8
	cmp r7, #51
	beq kare3_win
	add r1, r1, #4
	sub r2, r2, #8
	cmp r7, #52
	beq kare3_win
	cmp r7, #53
	beq kare3_win
	cmp r7, #54
	beq kare3_win
	cmp r7, #55
	beq kare3_win
	cmp r7, #56
	beq kare3_win
	sub r1, r1, #24
	add r2, r2, #8
	cmp r7, #57
	beq kare3_win
	add r1, r1, #24
	sub r2, r2, #8
	cmp r7, #58
	beq kare3_win
	cmp r7, #59
	beq kare3_win
	cmp r7, #60
	beq kare3_win
	cmp r7, #61
	beq kare3_win
	cmp r7, #62
	beq kare3_win
	sub r1, r1, #20
	add r2, r2, #4
	cmp r7, #63
	beq kare3_win
	add r1, r1, #20
	add r2, r2, #0
	cmp r7, #64
	beq kare3_win
	cmp r7, #65
	beq kare3_win
	cmp r7, #66
	beq kare3_win
	sub r2, r2, #4
	cmp r7, #67
	beq kare3_win
	sub r1, r1, #12
	cmp r7, #68
	beq kare3_win
	add r1, r1, #4
	cmp r7, #69
	beq kare3_win
	cmp r7, #70
	beq kare3_win
	cmp r7, #71
	beq kare3_win

	b finish_win

kare3_win:
		add r3, r3, #1
		mul r3, r3, r2

	    sub r2, r2, #1
	    sub r1, r1, #1
	    add r4, r1, #4
	    add r5, r2, #4
b_win:
		add r2, r2, #1
a_win:
		add r1, r1, #1
		str r1, [r0]
		str r2, [r0, #4]
		str r3, [r0, #8]

		cmp r1, r4
		bne a_win
		sub r1, r1, #4
		cmp r2, r5
		bne b_win
		str	r3, [r0, #12]
		b you_win

finish_win:
		lsr r0, r0, #4
		movs r1, #0
z_win:
		add r1, r1, #100
		cmp r1, r0
		bls z_win
		movs	r1, #88
 		movs	r2, #119
 		movs r7, #0
		add r3, r3, #1
		lsl r0, r0, #4
		b you_win
//------------------------------------------------------------
show_explosion:
		b ldr_r0_exp
ret_exp_r0:
		b ldr_r3_exp
ret_exp_r3:
		ldr r4, [sp, #200]
		cmp r4, #0
		beq cont_exp
		cmp r4, #2
		beq exp6_start
		b show_exp_exit

cont_exp:
		ldr r4, [sp, #400]
		cmp r4, #0  //if game did not started yet, exit
		beq show_exp_exit

		ldr r4, [sp, #12] //extract counter

show_exp_cont:
		cmp r4, #0
		beq exp1_start
		cmp r4, #1
		beq exp2_start
		cmp r4, #2
		beq exp3_start
		cmp r4, #3
		beq exp4_start
		cmp r4, #4
		beq exp5_start
		cmp r4, #5
		beq exp6_start
		b show_exp_exit

exp1_start:
		ldr r7, [sp, #92]
  	cmp r7, #0
		beq exp_frames_init_1
		cmp r7, #1
		beq reset_exp_c_1
		b lcun_exp
exp_frames_init_1:
		ldr r6, [sp, #156]
		add r6, r6, #1
		str r6, [sp, #156]
		movs r1, #75
		movs r2, #250
		b exp_frames
exp2_start:
		ldr r7, [sp, #88]
		cmp r7, #0
		beq exp_frames_init_2
		cmp r7, #1
		beq reset_exp_c_2
		b lcun_exp
exp_frames_init_2:
		ldr r6, [sp, #152]
		add r6, r6, #1
		str r6, [sp, #152]
		ldr r1, [sp, #116]
		ldr r2, [sp, #132]
		b exp_frames
exp3_start:
		ldr r7, [sp, #84]
		cmp r7, #0
		beq exp_frames_init_3
		cmp r7, #1
		beq reset_exp_c_3
		b lcun_exp
exp_frames_init_3:
		ldr r6, [sp, #148]
		add r6, r6, #1
		str r6, [sp, #148]
		movs r1, #75
		movs r2, #50
		b exp_frames
exp4_start:
		ldr r7, [sp, #80]
	 	cmp r7, #0
		beq exp_frames_init_4
		cmp r7, #1
		beq reset_exp_c_4
		b lcun_exp
exp_frames_init_4:
		ldr r6, [sp, #144]
		add r6, r6, #1
		str r6, [sp, #144]
		movs r1, #75
		movs r2, #150
		b exp_frames
exp5_start:
		ldr r7, [sp, #76]
		cmp r7, #0
		beq exp_frames_init_5
		cmp r7, #1
		beq reset_exp_c_5
		b lcun_exp
exp_frames_init_5:
		ldr r6, [sp, #140]
		add r6, r6, #1
		str r6, [sp, #140]
		ldr r1, [sp, #112]
		ldr r2, [sp, #128]
		b exp_frames
exp6_start:
		ldr r7, [sp, #16]
		cmp r7, #0
		beq exp_frames_init_6
		cmp r7, #1
		beq reset_exp_c_6
		b lcun_exp
exp_frames_init_6:
		ldr r6, [sp, #136]
		add r6, r6, #1
		str r6, [sp, #136]
		ldr r1, [sp, #124]
		ldr r2, [sp, #120]
		b exp_frames

exp_frames:
		cmp r6, #30
		bls exp_frame1
		cmp r6, #60
		bls exp_frame2
		cmp r6, #90
		bls exp_frame3
		b lcun_exp
exp_frame1:
		b frame1
exp_frame2:
		b frame2
exp_frame3:
		b frame3

reset_exp_c_1:
		movs r7, #0
		str r7, [sp, #156]
		b lcun_exp
reset_exp_c_2:
		movs r7, #0
		str r7, [sp, #152]
		b lcun_exp
reset_exp_c_3:
		movs r7, #0
		str r7, [sp, #148]
		b lcun_exp
reset_exp_c_4:
		movs r7, #0
		str r7, [sp, #144]
		b lcun_exp
reset_exp_c_5:
		movs r7, #0
		str r7, [sp, #140]
		b lcun_exp
reset_exp_c_6:
		movs r7, #0
		str r7, [sp, #136]
		b lcun_exp

lcun_exp:
		add r4, r4, #1
		b show_exp_cont

show_exp_exit:
		b f21_jump
//------------------------------------------------------------
ldr_r0_win: ldr	r0, =0x40010000
						b ret_win_r0
ldr_r3_win: ldr r3, = 0xFF000000
						b ret_win_r3
ldr_r0_boss:	ldr	r0, =0x40010000
						b return0_j
ldr_r3_boss:	ldr r3, =0xFFB8C125	//sari renk
						b return3_j
ldr_r0_exp: ldr r0, =0x40010000
					  b ret_exp_r0
ldr_r3_exp: ldr r3, =0xFF99004C
            b ret_exp_r3
//------------------------------------------------------------
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
		b show_exp_exit
//------------------------------------------------------------
frame2:
		add r2, r2, #5
		add r1, r1, #5
		sub	r1, r1, #4
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
		b show_exp_exit
//------------------------------------------------------------
frame3:
		add r2, r2, #5
		sub	r1, r1, #5
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
		b show_exp_exit
//------------------------------------------------------------
