init_fire2_flute_ROM
	ld		a,(No_PIECE)								; on récupère de no de la pièce dans laquelle on se trouve
	cp		a,55
	jr		z,ca_joue_en_55
	cp		a,77
	jr		z,ca_joue_en_77
	RET
	
ca_joue_en_55
	ld		(flag_stop_monstres),a
	cp		a,1
	ret		z
	call	asic_off
	call	c6_on
	ld		a,3
	ld		hl,#6957
	ld		(hl),a
	inc		hl
	ld		(hl),a
	inc		hl
	ld		(hl),a
	inc		hl
	ld		(hl),a
	inc		hl
	ld		(hl),a
	inc		hl
	ld		(hl),a
	inc		hl
	ld		(hl),a
	call	c6_off
	call	C4_on	
	
	ld		hl,#40C0
	ld		de,#C524
	ld		b,7
	
boucle_passage_vers_ocean
	push	bc
	push	hl
	push	de
	ld		b,16
	call	passage_vers_ocean
	pop		de
	inc		de : inc  de : inc  de : inc de 
	pop		hl
	pop		bc
	djnz	boucle_passage_vers_ocean
	
	call	c4_off 	; on remet en C0
	call 	asic_on
	RET
	


ca_joue_en_77
	ld		(flag_stop_monstres),a
	cp		a,1
	ret		z
	call	asic_off
	call	c6_on
	ld		a,3
	ld		hl,#7a00
	ld		(hl),a
	call	c6_off
	call	C4_on	
	ld		hl,#40C0
	ld		de,#C518
	ld		b,1
	call	boucle_passage_vers_ocean
	RET
	
	
	
passage_vers_ocean
	PUSH 	BC
	LD 		BC,4
	PUSH 	DE
	LDIR
	POP 	DE
	CALL 	LIGNEINF_c000
	POP 	BC
	DJNZ	passage_vers_ocean
	RET
	
fire2_init_viande_ROM

call	asic_on
ld		a,1
ld		(compteur_gros_link),a
ld		a,ZOOM_gros
ld		(SPRH_TYPE_ZOOM),a
ld		(SPRH0_ZOOM),a
ld		(SPRH1_ZOOM),a
xor		a
ld		(flag_viande),a
ld		(objet_hud_fire2),a
ld		hl,-31
ld		(decalage_epee_gauche),hl
ld		hl,31
ld		(decalage_epee_droite),hl
ld		hl,-15
ld		(decalage_epee_haut),hl
ld		hl,15
ld		(decalage_epee_bas),hl

ret




	