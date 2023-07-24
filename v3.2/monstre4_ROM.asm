VERS_LA_DROITE4_ROM


	LD		hl,(SPRH8_X)				; 5 nops
	inc		hl							; 1 nop
	;inc		hl							; 1 nop
	LD		(SPRH8_X),hl				; 5 nops
	ld		(SPRH_X),hl
	LD		hl,(TYPE_MONSTRE_ADR)		; 5 nops
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_droite_monstre4
		ld		a,(flag_anim_4_sprites)
	cp		a,1
	jp		z,calc_4anim_droite_monstre4
	LD		a,h							; 1 nop
	add		a,#06						; 2 nops
	LD		h,a							; 1 nop
calc_2anim_droite_monstre4
	LD		(SPRH8_ANIM_1),hl			
	inc		h
	LD		(SPRH8_ANIM_2),hl
	jp		calc_finanim_droite_monstre4
calc_4anim_droite_monstre4
	inc	h:inc	h
	LD		(SPRH8_ANIM_1),hl			
	inc	h
	LD		(SPRH8_ANIM_2),hl
	REt
	
VERS_LA_GAUCHE4_ROM

	LD		hl,(SPRH8_X)
	dec		hl
	;dec		hl
	LD		(SPRH8_X),hl
	ld		(SPRH_X),hl
	LD		hl,(TYPE_MONSTRE_ADR)
		ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_gauche_monstre4
		ld		a,(flag_anim_4_sprites)
	cp		a,1
	jp		z,calc_4anim_gauche_monstre4
	LD		a,h							; 1 nop
	add		a,#04						; 2 nops
	LD		h,a							; 1 nop
calc_2anim_gauche_monstre4
	LD		(SPRH8_ANIM_1),hl
	inc	 	h
	LD		(SPRH8_ANIM_2),hl
	jp		calc_finanim_gauche_monstre4
calc_4anim_gauche_monstre4
	LD		(SPRH8_ANIM_1),hl			
	inc	h
	LD		(SPRH8_ANIM_2),hl
	ret
	
	VERS_LE_bas4_ROM
	
	LD		hl,(SPRH8_Y)
	inc		l
	LD		(SPRH8_Y),hl
	ld		(SPRH_Y),hl
	LD		hl,(TYPE_MONSTRE_ADR)
		ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_bas_monstre4
	inc		h
	inc		h
calc_2anim_bas_monstre4
	LD		(SPRH8_ANIM_1),hl
	inc		h
	LD		(SPRH8_ANIM_2),hl
	ret
	
	
VERS_LE_haut4_ROM

	
	LD		hl,(SPRH8_Y)
	dec		l
	LD		(SPRH8_Y),hl
	ld		(SPRH_Y),hl
	LD		hl,(TYPE_MONSTRE_ADR)
		ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_haut_monstre4
calc_2anim_haut_monstre4
	LD		(SPRH8_ANIM_1),hl
	inc		h
	LD		(SPRH8_ANIM_2),hl
	
	ret
	
	
	MORT_MONSTRE_4_ROM
	
	
	EFFACE_MONSTRE_4_ROM
	

	efface_event_monstre_4_ROM
	
	ld		hl,(objet_laisse_4)
	ld		a,l
	ld		(type_objet),a
	call	compteur_objet
	call	asic_on
	xor		a
	LD		(event_MONSTRE4),a
	LD		(event_MONSTRE4+1),a
	LD		(event_MONSTRE4+2),a
	LD		(SPRH8_ZOOM),a
	ld		(flag_monstre4),a
		ld		(flag_premort),a

	
	ret
	