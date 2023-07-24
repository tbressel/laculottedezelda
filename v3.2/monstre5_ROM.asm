vers_la_droite5_ROM


	ld		hl,(SPRH9_X)
	inc		hl
	inc		hl
	ld		(SPRH9_X),hl
	ld		(SPRH_X),hl
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_droite_monstre5
		ld		a,(flag_anim_4_sprites)
	cp		a,1
	jp		z,calc_4anim_droite_monstre5
	ld		a,h							; 1 nop
	add		a,#06						; 2 nops
	ld		h,a							; 1 nop
calc_2anim_droite_monstre5
	ld		(SPRH9_ANIM_1),hl
	inc	 	h
	ld		(SPRH9_ANIM_2),hl
	jp		calc_finanim_droite_monstre5
calc_4anim_droite_monstre5
	inc	h:inc	h
	LD		(SPRH9_ANIM_1),hl			
	inc	h
	LD		(SPRH9_ANIM_2),hl
	ret
	
	vers_la_gauche5_ROM
	
	
	
	ld		hl,(SPRH9_X)
	dec		hl
	dec		hl
	ld		(SPRH9_X),hl
	ld		(SPRH_X),hl
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_gauche_monstre5
		ld		a,(flag_anim_4_sprites)
	cp		a,1
	jp		z,calc_4anim_gauche_monstre5
	LD		a,h							; 1 nop
	add		a,#04						; 2 nops
	LD		h,a							; 1 nop
calc_2anim_gauche_monstre5
	ld		(SPRH9_ANIM_1),hl
	inc		h
	ld		(SPRH9_ANIM_2),hl
	jp		calc_finanim_gauche_monstre5
calc_4anim_gauche_monstre5
	
	LD		(SPRH9_ANIM_1),hl			
	inc	h
	LD		(SPRH9_ANIM_2),hl
	ret
	
	
vers_le_bas5_ROM


	ld		hl,(SPRH9_Y)
	inc		l
	ld		(SPRH9_Y),hl
	ld		(SPRH_Y),hl
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_bas_monstre5
	inc 	h
	inc 	h
calc_2anim_bas_monstre5
	ld		(SPRH9_ANIM_1),hl
	inc	 	h
	ld		(SPRH9_ANIM_2),hl
	ret
	

vers_le_haut5_ROM

	
	ld		hl,(SPRH9_Y)
	dec		l
	ld		(SPRH9_Y),hl
	ld		(SPRH_Y),hl
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_haut_monstre5
calc_2anim_haut_monstre5
	ld		(SPRH9_ANIM_1),hl
	inc	 	h
	ld		(SPRH9_ANIM_2),hl
ret

efface_event_monstre_5_ROM

	
