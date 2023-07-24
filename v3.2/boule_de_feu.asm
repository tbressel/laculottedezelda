; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////   LE POISSON ZOLA  ////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
boule_de_feu	
	ld		a,(flag_stop_monstres)
	or		a
	JP		NZ,retour_bouledefeu
	ld		a,(une_bouledefeu_est_en_cours)
	or		a
	JP		NZ,update_bouledefeu
	
affiche_bouledefeu
	LD		hl,(SPRH12_X)							; récupération de la position X acutelle de zora
	LD		(SPRH_X),hl
	LD		hl,(SPRH12_Y)							; récupération de la position Y actuelle de zora
	LD		(SPRH_Y),hl	
	ld		a,25
	ld		(bankROM),a
	Call 	rom_on
	LD		hl,bouledefeu_SPR
	ld		de,SPRH13_ADR
	LD		bc,#100
	LDIR
	call 	rom_off
	LD		a,9
	LD 		(SPRH13_ZOOM),a
	ld		a,1
	ld		(flag_sprh13),a
	ld		(une_bouledefeu_est_en_cours),a
	ld		(direction_bouledefeu_en_cours),a
	jp		retour_bouledefeu
	
update_bouledefeu
	Call	collision_bouledefeu
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	update_bouledefeu_ROM
	call	rom_off
	JP 		retour_bouledefeu
	
	

; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////   LE BOSS 1  ////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
boss_3_boules_de_feu
	ld		a,(etape_3_boule_de_feu)
	cp		a,0
	jp		z,init_3_boules_de_feu
	cp		a,1
	jr		z,update_3_boules_de_feu
	cp		a,2
	jp		z,reinit_3_boules_de_feu

init_3_boules_de_feu
	LD		a,25
	LD		(bankROM),a
	call	rom_on
	call	asic_on
	ld		hl,BOULEDEFEU_SPR
	ld		de,SPRH13_ADR
	ld		bc,#100
	LDIR
	ld		hl,BOULEDEFEU_SPR
	ld		de,SPRH14_ADR
	ld		bc,#100
	LDIR
	ld		hl,BOULEDEFEU_SPR
	ld		de,SPRH15_ADR
	ld		bc,#100
	LDIR
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	init_3_boules_de_feu_ROM
	call	rom_off
	jp		retour_3_boules_de_feu

update_3_boules_de_feu
	ld		hl,(SPRH13_X)
	ld		de,-4
	add		hl,de
	ld		(SPRH13_X),hl
	ld		(SPRH_X),hl
	ld		hl,(SPRH13_Y)
	dec		l
	ld		(SPRH13_Y),hl
	ld		(SPRH_Y),hl
	call 	test_collisions
	ld		hl,(SPRH13_X)
	ld		de,(bord_gauche)
	SBC		hl,de
	CALL	C,stop_boule_1_sur_3
	
	ld		hl,(SPRH14_X)
	ld		de,-4
	add		hl,de
	ld		(SPRH14_X),hl
	ld		(SPRH_X),hl
	ld		hl,(SPRH14_Y)
	ld 		(SPRH_Y),HL
	call 	test_collisions
	ld		hl,(SPRH14_X)
	ld		de,(bord_gauche)
	SBC		hl,de
	CALL	C,stop_boule_2_sur_3
	
	ld		hl,(SPRH15_X)
	ld		de,-4
	add		hl,de
	ld		(SPRH15_X),hl
	ld		(SPRH_X),hl
	ld		hl,(SPRH15_Y)
	inc		l
	ld		(SPRH15_Y),hl
	ld 		(SPRH_Y),HL
	call 	test_collisions
	ld		hl,(SPRH15_X)
	ld		de,(bord_gauche)
	SBC		hl,de
	CALL	C,stop_boule_3_sur_3
	jp		retour_3_boules_de_feu

stop_boule_1_sur_3
	xor a
	ld	(SPRH13_ZOOM),a
	ld	(flag_sprh13),a
	ret
stop_boule_2_sur_3
	xor a
	ld	(SPRH14_ZOOM),a
	ld	(flag_sprh14),a
	ret
stop_boule_3_sur_3
	xor a
	ld	(SPRH15_ZOOM),a
	ld	(flag_sprh15),a
	ld	a,2
	ld	(etape_3_boule_de_feu),a
	ret
stop_3_boules_de_feu
	ld	a,2
	ld	(etape_3_boule_de_feu3),a
reinit_3_boules_de_feu
	LD		a,2
	LD		(bankROM),a
	call	rom_on
	call	reinit_3_boules_de_feu_ROM
	call	rom_off
	jp	retour_3_boules_de_feu
	
	
; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////   LE BOSS 3  ////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////	
	
boss_3_boules_de_feu2
	ld		a,(etape_3_boule_de_feu2)
	cp		a,0
	jr		z,init_3_boules_de_feu2
	cp		a,1
	jr		z,update_3_boules_de_feu2
	cp		a,2
	jp		z,reinit_3_boules_de_feu2

init_3_boules_de_feu2
	LD		a,25
	LD		(bankROM),a
	call	rom_on
	call	asic_on
	ld		hl,BOULEDEFEU_SPR
	ld		de,SPRH10_ADR
	ld		bc,#100
	LDIR
	ld		hl,BOULEDEFEU_SPR
	ld		de,SPRH11_ADR
	ld		bc,#100
	LDIR
	ld		hl,BOULEDEFEU_SPR
	ld		de,SPRH12_ADR
	ld		bc,#100
	LDIR
	
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	init_3_boules_de_feu2_ROM
	call	rom_off
	jp		retour_3_boules_de_feu2

update_3_boules_de_feu2

	ld		hl,(SPRH10_X)
	ld		de,4
	add		hl,de
	ld		(SPRH10_X),hl
	ld		(SPRH_X),hl
	ld		hl,(SPRH10_Y)
	dec		l
	ld		(SPRH10_Y),hl
	ld		(SPRH_Y),hl
	call 	test_collisions
	ld		hl,(SPRH10_X)
	ld		de,(bord_gauche)
	SBC		hl,de
	CALL	C,stop_boule_1_sur_32
	
	ld		hl,(SPRH11_X)
	ld		de,4
	add		hl,de
	ld		(SPRH11_X),hl
	ld		(SPRH_X),hl
	ld		hl,(SPRH11_Y)
	ld 		(SPRH_Y),HL
	call 	test_collisions
	ld		hl,(SPRH11_X)
	ld		de,(bord_gauche)
	SBC		hl,de
	CALL	C,stop_boule_2_sur_32
	
	ld		hl,(SPRH12_X)
	ld		de,4
	add		hl,de
	ld		(SPRH12_X),hl
	ld		(SPRH_X),hl
	ld		hl,(SPRH12_Y)
	inc		l
	ld		(SPRH12_Y),hl
	ld 		(SPRH_Y),HL
	call 	test_collisions
	ld		hl,(SPRH12_X)
	ld		de,(bord_gauche)
	SBC		hl,de
	CALL	C,stop_boule_3_sur_32
	jp		retour_3_boules_de_feu2

stop_boule_1_sur_32
	xor a
	ld	(SPRH10_ZOOM),a
	ld	(flag_monstre6),a
	ret
stop_boule_2_sur_32
	xor a
	ld	(SPRH11_ZOOM),a
	ld	(flag_monstre7),a
	ret
stop_boule_3_sur_32
	xor a
	ld	(SPRH12_ZOOM),a
	ld	(flag_monstre_zora),a
	ld	a,2
	ld	(etape_3_boule_de_feu2),a
	ret
stop_3_boules_de_feu2


reinit_3_boules_de_feu2
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	reinit_3_boules_de_feu2_ROM
	call	rom_off
	
	jp	retour_3_boules_de_feu2




; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////   LE BOSS 4  ////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////	
boss_3_boules_de_feu3
	ld		a,(etape_3_boule_de_feu3)
	cp		a,0
	jr		z,init_3_boules_de_feu3
	cp		a,1
	jr		z,update_3_boules_de_feu3
	cp		a,2
	jp		z,reinit_3_boules_de_feu3

init_3_boules_de_feu3
	LD		a,25
	LD		(bankROM),a
	call	rom_on
	call	asic_on
	ld		hl,BOULEDEFEU_SPR
	ld		de,SPRH13_ADR
	ld		bc,#100
	LDIR
	ld		hl,BOULEDEFEU_SPR
	ld		de,SPRH14_ADR
	ld		bc,#100
	LDIR
	ld		hl,BOULEDEFEU_SPR
	ld		de,SPRH15_ADR
	ld		bc,#100
	LDIR
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	init_3_boules_de_feu3_ROM
	call	rom_off
	jp		retour_3_boules_de_feu

update_3_boules_de_feu3
	ld		hl,(SPRH13_X)
	dec 	hl
	dec 	hl
	ld		(SPRH13_X),hl
	ld		(SPRH_X),hl
	
	ld		hl,(SPRH13_Y)
	inc		l
	ld		(SPRH13_Y),hl
	ld		(SPRH_Y),hl
	
	call 	test_collisions
	ld		hl,(SPRH13_X)
	ld		de,(bord_gauche)
	SBC		hl,de
	CALL	C,stop_boule_1_sur_33
	
	ld		hl,(SPRH14_X)
	ld		(SPRH_X),hl
	ld		hl,(SPRH14_Y)
	inc		l
	ld		(SPRH14_Y),hl
	ld 		(SPRH_Y),HL
	call 	test_collisions
	ld		hl,(SPRH14_X)
	ld		de,(bord_gauche)
	SBC		hl,de
	CALL	C,stop_boule_2_sur_33
	
	ld		hl,(SPRH15_X)
	inc		hl
	inc		hl
	ld		(SPRH15_X),hl
	ld		(SPRH_X),hl
	
	ld		hl,(SPRH15_Y)
	inc		l
	ld		(SPRH15_Y),hl
	ld 		(SPRH_Y),HL
	
	call 	test_collisions
	ld		hl,(SPRH15_X)
	ld		de,(bord_gauche)
	SBC		hl,de
	CALL	C,stop_boule_3_sur_33
		
	jp		retour_3_boules_de_feu

stop_boule_1_sur_33
	xor a
	ld	(SPRH13_ZOOM),a
	ld	(flag_sprh13),a
	
	ld	a,2
	ld	(etape_3_boule_de_feu3),a
	ret
stop_boule_2_sur_33
	xor a
	ld	(SPRH14_ZOOM),a
	ld	(flag_sprh14),a
	ld	a,2
	ld	(etape_3_boule_de_feu3),a
	ret
stop_boule_3_sur_33
	xor a
	ld	(SPRH15_ZOOM),a
	ld	(flag_sprh15),a
	ld	a,2
	ld	(etape_3_boule_de_feu3),a
	ret
stop_3_boules_de_feu3


reinit_3_boules_de_feu3
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	reinit_3_boules_de_feu3_ROM
	call	rom_off
	jp	retour_3_boules_de_feu
