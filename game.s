initial_sp:        .word    0x201FFFFC 							 	  //window size: 320x240
reset_vector:      .word    _main    								    //RAM: 1020 -> row value
_main:                             								      //     1016 -> column value
		movs r1, #200    //initialization       			      //     1012 -> fire position, row
 		movs r2, #106                  								      //     1008 -> fire position, col
    str  r2, [sp, #1008]           									    //     1004 -> enemy 1, row position
		str  r1, [sp, #1012]            								    //     1000 -> enemy 1, col position
		sub  r2, r2, #6                   								  //      996 -> enemy 1, is dead? T = 0
		str  r2, [sp, #1016]               								  //      992 -> fire 1 pos, row
		str  r1, [sp, #1020]              								  //      988 -> fire 2 pos, col
		ldr	 r0, =0x40010000               							    //      984 -> enemy 2, row position
    ldr  r3, color1               							      	//      980 -> enemy 2, col position
		movs r7, #50                        								//      976 -> enemy 2, is dead
		str  r7, [sp, #1004] //load enemy 1 to RAM          //      972 -> fire 2 pos, row
		add  r7, r7, #10																		//      968 -> fire 2 pos, col
		str  r7, [sp, #992]																	//
		movs r7, #200																				//
		str  r7, [sp, #1000]																//
		add  r7, r7, #15																		//     16 -> is player dead?, T = 0
		str  r7, [sp, #988]																	//     12 -> local counter
		movs r7, #10                                        //     current state: f12
		str  r7, [sp, #984] //load enemy 2 to RAM
		add  r7, r7, #10
		str  r7, [sp, #972]
		movs r7, #50
		str  r7, [sp, #980]
		add  r7, r7, #15
		str  r7, [sp, #968]
		movs r7, #1
		str  r7, [sp, #996] //enemy1 is alive
		str  r7, [sp, #976] //enemy2 is alive
		str  r7, [sp, #16]  //player is alive
		movs r7, #0
		str  r7, [sp, #12]  //assign initial state of counter

		str	r3, [r0, #12]   //refresh the screen
		str	r3, [r0, #0x10] //clear the screen

main_loop:
      str	r3, [r0, #12] //refresh the screen
	   	b show            //show
			str	r3, [r0, #12] //refresh the screen
f1:		b update          //update
      str	r3, [r0, #12] //refresh the screen
//-------------------------------------------------------------
update:
      b update_movement    //update player position -> f2
f2:   b collide            //check wall collision -> f7
f7:   ldr r7, [sp, #1012]  //check if fire has expired
      cmp r7, #0
      beq update_fire      // -> f9
f9:   b update_enemy       // -> f10
f10:  b update_enemy_fire_jump  // -> f12
f12:	b update_player_jump        // -> f4
f4:		str	r3, [r0, #12]
      b main_loop
show:
			str	r3, [r0, #12]    //refresh the screen
			str	r3, [r0, #0x10]  //clear the screen
      b show_charater      // -> f3
f3:		b show_enemy         // -> f8
f8:   ldr r7, [sp, #1012]  //show fire
  		cmp r7, #0
  		bhi show_fire        // -> f5
f5:   b show_enemy_fire_jump  // -> f11
f11:  b delay                   // -> f6
f6:   b f1
//-------------------------------------------------------------
update_movement:
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
		movs r5, #0
		movs r6, #0
		ldr r5, [sp, #1020]
		ldr r6, [sp, #1016]
		ldr r7, width
	  sub r7, r7, #12

		cmp r6, r7  //if x > width => x=width
		bhs r6_max
c1:	cmp r6, #10
		bls r6_min
c2:	cmp r5, #220
		bhs r5_max
c3: cmp r5, #160
		bls r5_min
b f7

r6_max:
		movs r6, r7
		str  r6, [sp, #1016]
b c1
r6_min:
		movs r6, #10
		str  r6, [sp, #1016]
b c2
r5_max:
		movs r5, #220
		str  r5, [sp, #1020]
b c3
r5_min:
		movs r5, #160
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
//-------------------------------------------------------------//jump point
show_enemy_fire_jump: b show_enemy_fire
update_enemy_fire_jump: b update_enemy_fire
update_player_jump: b update_player
//-------------------------------------------------------------
show_charater:
		ldr   r5, [sp, #16] //is the enemy dead?
		cmp   r5, #1
		beq   player_cont
		b f3

player_cont:

    ldr 	r1, [sp, #1020]
    ldr 	r2, [sp, #1016]
    str 	r1, [r0]
    str 	r2, [r0, #4]
		ldr   r3, color1
    str	  r3, [r0, #8]

		movs r4, #12
		add  r4, r4, r1
		movs r5, #13
		add  r5, r5, r2

b:	add	r2, r2, #1
a:	add	r1, r1, #1
		str	r1, [r0]
		str	r2, [r0, #4]
		str	r3, [r0, #8]

		cmp	r1, r4
		bne	a
		ldr r1, [sp, #1020]
		cmp	r2, r5
		bne	b
		ldr r2, [sp, #1016]
b f3
//-------------------------------------------------------------
show_fire:
    ldr r5, [sp, #1012] //row data
    movs r7, r5
    ldr r6, [sp, #1008] //column data
    sub r7, r7, #1
    str r7, [sp, #1012]
    movs r7, #0
draw_fire:
    str	r5, [r0]
    str	r6, [r0, #4]
		ldr r3, color3
    str	r3, [r0, #8]
    add r7, r7, #1
    sub r5, r5, #1
    cmp r7, #4
    bne draw_fire
		str	r3, [r0, #12]
    movs r7, #0
b f5
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
show_enemy:
		ldr r4, [sp, #12]

		cmp   r4, #0
		beq   en1
		cmp   r4, #1
		beq   en2
		movs  r4, #0
		str   r4, [sp, #12] //reset counter
		b f8

en1:movs  r7, #0 //draw enemy 1
    ldr   r5, [sp, #996] //is the enemy dead?
		ldr   r1, [sp, #1004]
		ldr   r2, [sp, #1000]
		ldr 	r6, [sp, #1004]
		ldr 	r7, [sp, #1000]
    cmp   r5, #1
		beq   enemy_cont
		b lcun1

en2:movs  r7, #0  //draw enemy 2
   ldr   r5, [sp, #976] //is the enemy dead?
	 ldr   r1, [sp, #984]
	 ldr   r2, [sp, #980]
	 ldr 	 r6, [sp, #984]
	 ldr   r7, [sp, #980]
   cmp   r5, #1
	 beq   enemy_cont
 	 b lcun1

enemy_cont:

		str 	r6, [r0]
		str 	r7, [r0, #4]
		ldr   r3, color1
		str	  r3, [r0, #8]

		movs r4, #12
		add  r4, r4, r6
		movs r5, #30
		add  r5, r5, r7

be:	add	r7, r7, #1
ae:	add	r6, r6, #1
		str	r6, [r0]
		str	r7, [r0, #4]
		str	r3, [r0, #8]

		cmp	r6, r4
		bne	ae
		movs r6, r1
		cmp	r7, r5
		bne	be
		movs r7, r2
		str	r3, [r0, #12]
lcun1:
    ldr r7, [sp, #12]
		add r7, r7, #1
		str r7, [sp, #12] //update counter
b show_enemy
//-------------------------------------------------------------
update_enemy:
    ldr r2, [sp, #12]   //counter
update_enemy_cont:
    cmp r2, #0
		beq up_en_1
		cmp r2, #1
		beq up_en_2
		movs r2, #0
		str r2, [sp, #12]
		b f10

up_en_1:
		ldr r6, [sp, #1012] //fire position
		ldr r7, [sp, #1008]
		ldr r4, [sp, #1004] //enemy position
		ldr r5, [sp, #1000]
		ldr r3, [sp, #996]  //is enemy dead
		b update_chain1
up_en_2:
		ldr r6, [sp, #1012] //fire position
		ldr r7, [sp, #1008]
		ldr r4, [sp, #984] //enemy position
		ldr r5, [sp, #980]
		ldr r3, [sp, #976]  //is enemy dead
		b update_chain1

update_chain1:
		cmp r7, r5
		bhs check1
		b lcun4
check1:
		add r5, r5, #30
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

kill_enemy:
		cmp r2, #0
		beq kill1
		cmp r2, #1
		beq kill2
		movs r2, #0
		str r2, [sp, #12]
		b f10

kill1:
		movs r1, #0
		str r1, [sp, #996]
		b lcun4_ld
kill2:
		movs r1, #0
		str r1, [sp, #976]
		b lcun4_ld

lcun4_ld:
		ldr r5, [sp, #1020] //row data
		ldr r6, [sp, #1016] //column data
		add r6, r6, #6
		str r5, [sp, #1012]
		str r6, [sp, #1008] //update fire
lcun4:
		add r2, r2, #1
		b update_enemy_cont
//-------------------------------------------------------------
show_enemy_fire:
    ldr  r4, [sp, #12]  //load counter
enemy_fire_cont:
		cmp   r4, #0
		beq   f_en1
		cmp   r4, #1
		beq   f_en2
		movs  r4, #0
		str   r4, [sp, #12] //reset counter
		b f11

f_en1:
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

draw_fire_enemy:
		str	r5, [r0]
		str	r6, [r0, #4]
		ldr r3, color2
		str	r3, [r0, #8]
		add r7, r7, #1
		sub r5, r5, #1
		cmp r7, #4
		bne draw_fire_enemy
lcun2:
		movs r7, #0
		ldr r3, color2
		str r3, [r0, #12]
		add r4, r4, #1  //increment counter
b enemy_fire_cont
//-------------------------------------------------------------
update_enemy_fire:
		ldr r4, [sp, #12]  //load counter

up_en_fire_cont:
		cmp r4, #0
		beq uef1
		cmp r4, #1
		beq uef2
		movs r4, #0
		str r4, [sp, #12] //reset counter
		b f12

uef1:
    ldr r7, [sp, #992]
		cmp r7, #255
		beq uef1_1
		b lcun3
uef1_1:
    ldr r7, [sp, #996]
		cmp r7, #1  //if enemy alive, update fire
		beq up_fire_1
		b lcun3
up_fire_1:
		ldr r5, [sp, #1004] //row data
		ldr r6, [sp, #1000] //column data
		add r6, r6, #15
    add r5, r5, #10
		str r5, [sp, #992] //reset fire position to enemy position
		str r6, [sp, #988]
		b lcun3

uef2:
	  ldr r7, [sp, #972]
		cmp r7, #255
		beq uef2_1
		b lcun3
uef2_1:
    ldr r7, [sp, #976]
		cmp r7, #1  //if enemy alive, update fire
		beq up_fire_2
		b lcun3
up_fire_2:
		ldr r5, [sp, #984] //row data
		ldr r6, [sp, #980] //column data
		add r6, r6, #15
    add r5, r5, #10
		str r5, [sp, #972] //reset fire position to enemy position
		str r6, [sp, #968]
		b lcun3

lcun3:
		add r4, r4, #1 //increment counter
b up_en_fire_cont
//-------------------------------------------------------------
update_player:
		ldr r2, [sp, #12]

update_player_cont:
		cmp r2, #0
		beq up_pl_1
	  cmp r2, #1
		beq up_pl_2
		movs r2, #0
		str r2, [sp, #12]
		b f4

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
		
update_chain_2:
		cmp r7, r5
		bhs checkp1
		b lcun5
checkp1:
		add r5, r5, #12
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
		bls checkp4
		b lcun5
checkp4:
		cmp r3, #1
		beq kill_player
		b lcun5

kill_player:
		cmp r2, #0
		beq killp1
		cmp r2, #1
		beq killp2
		movs r2, #0
		str r2, [sp, #12]
		b f4

killp1:
		movs r1, #0
		str r1, [sp, #16]  //player is dead
		ldr r5, [sp, #1004] //row data
		ldr r6, [sp, #1000] //column data
		add r6, r6, #15
		str r5, [sp, #992]
		str r6, [sp, #988] //update fire
		b lcun5
killp2:
		movs r1, #0
		str r1, [sp, #16]  //player is dead
		ldr r5, [sp, #984] //row data
		ldr r6, [sp, #980] //column data
		add r6, r6, #15
		str r5, [sp, #972]
		str r6, [sp, #968] //update fire
		b lcun5
lcun5:
		add r2, r2, #1
		b update_player_cont
//------------------------------------------------------------

.balign 4
delay_constant:  .word 15000
width:           .word 310
data:            .word 996
color1:          .word 0xFFFFFF00
color2:          .word 0xFFFF0000
color3:          .word 0xFF00FF00
