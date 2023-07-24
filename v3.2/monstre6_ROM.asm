vers_la_droite6_ROM

	ld		hl,(SPRH10_X)
	inc		hl
	inc		hl
	ld		(SPRH10_X),hl
	ld		(SPRH_X),hl
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_droite_monstre6
		ld		a,(flag_anim_4_sprites)
	cp		a,1
	jp		z,calc_4anim_droite_monstre6
	ld		a,h							; 1 nop
	add		a,#06						; 2 nops
	ld		h,a							; 1 nop
calc_2anim_droite_monstre6
	ld		(SPRH10_ANIM_1),hl
	inc	 	h
	ld		(SPRH10_ANIM_2),hl
	jp		calc_finanim_droite_monstre6
calc_4anim_droite_monstre6
inc	 	h
inc	 	h
	LD		(SPRH10_ANIM_1),hl			
	inc	h
	LD		(SPRH10_ANIM_2),hl
	ret
	


vers_la_gauche6_ROM

	ld		hl,(SPRH10_X)
	dec		hl
	dec		hl
	ld		(SPRH10_X),hl
	ld		(SPRH_X),hl
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_gauche_monstre6
		ld		a,(flag_anim_4_sprites)
	cp		a,1
	jp		z,calc_4anim_gauche_monstre6
	LD		a,h							; 1 nop
	add		a,#04						; 2 nops
	LD		h,a							; 1 nop
calc_2anim_gauche_monstre6
	ld		(SPRH10_ANIM_1),hl
	inc 	h
	ld		(SPRH10_ANIM_2),hl
	jp		calc_finanim_gauche_monstre6
calc_4anim_gauche_monstre6
	LD		(SPRH10_ANIM_1),hl			
	inc	h
	LD		(SPRH10_ANIM_2),hl
	ret
	
	
vers_le_bas6_ROM

	
	
	ld		hl,(SPRH10_Y)
	inc		l
	ld		(SPRH10_Y),hl
	ld		(SPRH_Y),hl
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_bas_monstre6
	inc 	h
	inc 	h
calc_2anim_bas_monstre6
	ld		(SPRH10_ANIM_1),hl
	inc 	h
	ld		(SPRH10_ANIM_2),hl
ret

vers_le_haut6_ROM


	
	ld		hl,(SPRH10_Y)
	dec		l
	ld		(SPRH10_Y),hl
	ld		(SPRH_Y),hl
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_haut_monstre6
calc_2anim_haut_monstre6
	ld		(SPRH10_ANIM_1),hl
	inc 	h
	ld		(SPRH10_ANIM_2),hl

ret

efface_event_monstre_6_ROM


	
	ld		hl,(objet_laisse_6)
	ld		a,l
	ld		(type_objet),a
	call	compteur_objet
	call	asic_on
	xor		a
	LD		(event_MONSTRE6),a
	LD		(event_MONSTRE6+1),a
	LD		(event_MONSTRE6+2),a
	LD		(SPRH10_ZOOM),a
	ld		(flag_monstre6),a
	ld		(flag_premort),a

	ret
	
