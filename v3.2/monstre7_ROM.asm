vers_la_droite7_ROM


	ld		hl,(SPRH11_X)
	inc		hl
	inc		hl
	ld		(SPRH11_X),hl
	ld		(SPRH_X),hl
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_droite_monstre7
		ld		a,(flag_anim_4_sprites)
	cp		a,1
	jp		z,calc_4anim_droite_monstre7
	ld		a,h							; 1 nop
	add		a,#06						; 2 nops
	ld		h,a							; 1 nop
calc_2anim_droite_monstre7
	ld		(SPRH11_ANIM_1),hl
	inc 	h
	ld		(SPRH11_ANIM_2),hl
	jp		calc_finanim_droite_monstre7
calc_4anim_droite_monstre7
	inc	h:inc	h
	LD		(SPRH11_ANIM_1),hl			
	inc	h
	LD		(SPRH11_ANIM_2),hl
	ret
	
	
vers_la_gauche7_ROM

	
	ld		hl,(SPRH11_X)
	dec		hl
	dec		hl
	ld		(SPRH11_X),hl
	ld		(SPRH_X),hl
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_gauche_monstre7
		ld		a,(flag_anim_4_sprites)
	cp		a,1
	jp		z,calc_4anim_gauche_monstre7
	LD		a,h							; 1 nop
	add		a,#04						; 2 nops
	LD		h,a							; 1 nop
calc_2anim_gauche_monstre7
	ld		(SPRH11_ANIM_1),hl
	inc		h
	ld		(SPRH11_ANIM_2),hl
	jp		calc_finanim_gauche_monstre7
calc_4anim_gauche_monstre7
	
	LD		(SPRH11_ANIM_1),hl			
	inc	h
	LD		(SPRH11_ANIM_2),hl
	ret
	
	
vers_le_bas7_ROM

	
	ld		hl,(SPRH11_Y)
	inc		l
	ld		(SPRH11_Y),hl
	ld		(SPRH_Y),hl
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_bas_monstre7

	inc		h
	inc	 	h
calc_2anim_bas_monstre7
	ld		(SPRH11_ANIM_1),hl
	inc 	h
	ld		(SPRH11_ANIM_2),hl
ret

vers_le_haut7_ROM


	
	
	
	ld		hl,(SPRH11_Y)
	dec		l
	ld		(SPRH11_Y),hl
	ld		(SPRH_Y),hl
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_haut_monstre7
calc_2anim_haut_monstre7
	ld		(SPRH11_ANIM_1),hl
	inc		h
	ld		(SPRH11_ANIM_2),hl
	
	ret
	
efface_event_monstre_7_ROM

	ld		hl,(objet_laisse_7)
	ld		a,l
	ld		(type_objet),a
	call	compteur_objet
	call	asic_on
	xor		a
	ld		(event_monstre7),a
	ld		(event_monstre7+1),a
	LD		(event_monstre7+2),a
	LD		(SPRH11_ZOOM),a
	ld		(flag_monstre7),a
		ld		(flag_premort),a

	
	ret
	
	
	