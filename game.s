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
    ldr  r3, =0xFFFFFF00                								//      980 -> enemy 2, col position
		movs r7, #50                        								//      976 -> enemy 2, is dead
		str  r7, [sp, #1004] //load enemy 1 to RAM          //      972 -> fire 2 pos, row
		add  r7, r7, #10																		//      968 -> fire 2 pos, col
		str  r7, [sp, #992]																	//
		movs r7, #200																				//
		str  r7, [sp, #1000]																//
		add  r7, r7, #15																		//     16 -> is player dead?, T = 0
		str  r7, [sp, #988]																	//     12 -> local counter
		movs r7, #20                                        //     current state: f12
		str  r7, [sp, #984] //load enemy 2 to RAM
		add  r7, r7, #10
		str  r7, [sp, #972]
		movs r7, #100
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
f10:  ldr r7, [sp, #992]
      cmp r7, #255
      beq update_enemy_fire_jump  // -> f12
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
f5:   ldr r7, [sp, #992]
			cmp r7, #255
			bls show_enemy_fire_jump  // -> f11
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
    str	  r3, [r0, #8]

		movs r4, #12
		add  r4, r4, r1
		movs r5, #12
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
		b lcun

en2:movs  r7, #0  //draw enemy 2
   ldr   r5, [sp, #976] //is the enemy dead?
	 ldr   r1, [sp, #984]
	 ldr   r2, [sp, #980]
	 ldr 	 r6, [sp, #984] //counter is used to draw x number of enemies
	 ldr   r7, [sp, #980]   //x is the number of enemies loaded into ram
   cmp   r5, #1
	 beq   enemy_cont
 	 b lcun

enemy_cont:

		str 	r6, [r0]
		str 	r7, [r0, #4]
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
lcun:
    ldr r7, [sp, #12]
		add r7, r7, #1
		str r7, [sp, #12] //update counter
b show_enemy
//-------------------------------------------------------------
update_enemy:
		ldr r6, [sp, #1012] //fire position
		ldr r7, [sp, #1008]
		ldr r4, [sp, #1004] //enemy position
		ldr r5, [sp, #1000]

		cmp r7, r5
		bhs check1     //this part will be updated for multiple enemy condition
		b f10
check1:
		add r5, r5, #30
		cmp r7, r5
		bls check2
		b f10
check2:
		cmp r6, r4
		bhs check3
		b f10
check3:
		add r4, r4, #12
		cmp r6, r4
		bls check4
		b f10
check4:
		ldr r7, [sp, #996]
		cmp r7, #1
		beq kill_enemy
		b f10
kill_enemy:
		movs r2, #0
		str r2, [sp, #996]
		ldr r5, [sp, #1020] //row data
		ldr r6, [sp, #1016] //column data
		add r6, r6, #6
		str r5, [sp, #1012]
		str r6, [sp, #1008] //update fire
b f10
//-------------------------------------------------------------
show_enemy_fire:
		ldr r5, [sp, #992] //row data
		movs r7, r5
		ldr r6, [sp, #988] //column data
		add r7, r7, #1
		str r7, [sp, #992]
		movs r7, #0  //this part will be updated for multiple enemy fire
draw_fire_enemy:
		str	r5, [r0]
		str	r6, [r0, #4]
		str	r3, [r0, #8]
		add r7, r7, #1
		sub r5, r5, #1
		cmp r7, #4
		bne draw_fire_enemy
		movs r7, #0
		str	r3, [r0, #12]
b f11
//-------------------------------------------------------------
update_enemy_fire:
    ldr r7, [sp, #996]
		cmp r7, #1
		beq cont_update_fire_e
		b f12          //going to be updated for multiple enemy
cont_update_fire_e:
		ldr r5, [sp, #1004] //row data
		ldr r6, [sp, #1000] //column data
		add r6, r6, #15
    add r5, r5, #10
		str r5, [sp, #992]
		str r6, [sp, #988]
b f12
//-------------------------------------------------------------
update_player:
		ldr r6, [sp, #992] //fire position
		add r6, r6, #4
		ldr r7, [sp, #988]
		ldr r4, [sp, #1020] //player position
		ldr r5, [sp, #1016]

		cmp r7, r5
		bhs checkp1
		b f4
checkp1:
		add r5, r5, #12    //going to be updated for getting hit from any enemy
		cmp r7, r5
		bls checkp2
		b f4
checkp2:
		cmp r6, r4
		bhs checkp3
		b f4
checkp3:
		add r4, r4, #12
		cmp r6, r4
		bls checkp4
		b f4
checkp4:
		ldr r7, [sp, #996]
		cmp r7, #1
		beq kill_player
		b f4
kill_player:
		movs r2, #0
		str r2, [sp, #16]  //player is dead
		ldr r5, [sp, #1004] //row data
		ldr r6, [sp, #1000] //column data
		add r6, r6, #15
		str r5, [sp, #992]
		str r6, [sp, #988] //update fire
b f4
//------------------------------------------------------------

.balign 4
delay_constant:  .word 10000
width:           .word 310
data:            .word 996