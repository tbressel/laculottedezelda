feu
	ld	a,(un_feu_est_en_cours)
	or	a
	JP	NZ,update_feu_anim
	
affiche_feu
	ld		a,25
	ld		(bankROM),a
	Call 	rom_on
	LD		hl,(feu_SPR)
	ld		de,SPRH3_ADR
	LD		bc,#100
	LDIR
	call 	rom_off
	LD		a,9
	LD 		(SPRH3_ZOOM),a
	ld		a,1
	ld		(flag_sprh3),a
	ld		(un_feu_est_en_cours),a
	ld		(flag_attente_inc_feu),a
	jp		retour_feu
update_feu_anim
	ld		a,25
	ld		(bankROM),a
	ld		a,(compteur_anim_feu)
	dec		a
	ld		(compteur_anim_feu),a
	cp		a,0
	jp		z,reinit_anim_feu
	cp		a,cycle_animation_feu_etape1
	CALL	z,feu_anim_1
	cp		a,cycle_animation_feu_etape2
	CALL	z,feu_anim_2
update_feu
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	JP		update_feu_ROM
retour_update_feu_ROM
	call	rom_off
	JP 		retour_feu

fin_feu
	call	rom_off
	xor		a
	LD		(event_feu),a
	LD		(event_feu+1),a
	LD		(event_feu+2),a
	LD		(SPRH3_ZOOM),a
	ld		(flag_sprh3),a
	ld		(flag_fire2),a
	ld		(un_feu_est_en_cours),a
		
	ld		B,238					; tile buisson vert
	LD		A,(ntile_spr3)	
	SBC		A,B
	JP		Z,affiche_passage
	ld		B,243
	LD		A,(ntile_spr3)	
	SBC		A,B
	JP		Z,affiche_passage
retour_passage
	jp		retour_feu
feu_anim_1
	Call 	rom_on
	LD		hl,FLAMME_D
	ld		de,SPRH3_ADR
	LD		bc,#100
	LDIR
	call 	rom_off
	RET
feu_anim_2
	Call 	rom_on
	LD		hl,FLAMME_G
	ld		de,SPRH3_ADR
	LD		bc,#100
	LDIR
	call 	rom_off
	ret
reinit_anim_feu
	ld	a,cycle_total_animation_du_feu
	ld (compteur_anim_feu),a
	JP retour_feu
	