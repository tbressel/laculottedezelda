VERS_LA_DROITE3_ROM


	LD		hl,(SPRH7_X)				; 5 nops
	inc		hl							; 1 nop
	;inc		hl							; 1 nop
	LD		(SPRH7_X),hl				; 5 nops
	ld		(SPRH_X),hl
	LD		hl,(TYPE_MONSTRE_ADR)		; 5 nops
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_droite_monstre3
		ld		a,(flag_anim_4_sprites)
	cp		a,1
	jp		z,calc_4anim_droite_monstre3
	LD		a,h							; 1 nop
	add	a,#06						; 2 nops
	LD		h,a							; 1 nop
calc_2anim_droite_monstre3
	LD		(SPRH7_ANIM_1),hl			
	inc		h
	LD		(SPRH7_ANIM_2),hl
	jp		calc_finanim_droite_monstre3
calc_4anim_droite_monstre3
	inc	h:inc	h
	LD		(SPRH7_ANIM_1),hl			
	inc	h
	LD		(SPRH7_ANIM_2),hl
	ret
	
VERS_LA_GAUCHE3_ROM
	
	LD		hl,(SPRH7_X)
	dec		hl
	;dec		hl
	LD		(SPRH7_X),hl
	ld		(SPRH_X),hl
	LD		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_gauche_monstre3
		ld		a,(flag_anim_4_sprites)
	cp		a,1
	jp		z,calc_4anim_gauche_monstre3
	LD		a,h							; 1 nop
	add		a,#04						; 2 nops
	LD		h,a							; 1 nop
calc_2anim_gauche_monstre3
	LD		(SPRH7_ANIM_1),hl
	inc	 	h
	LD		(SPRH7_ANIM_2),hl
	jp		calc_finanim_gauche_monstre3
calc_4anim_gauche_monstre3

	LD		(SPRH7_ANIM_1),hl			
	inc	h
	LD		(SPRH7_ANIM_2),hl
	ret

VERS_LE_BAS3_ROM

	LD		hl,(SPRH7_Y)
	inc		l
	LD		(SPRH7_Y),hl
	ld		(SPRH_Y),hl
	LD		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_bas_monstre3
	inc		h
	inc		h
calc_2anim_bas_monstre3
	LD		(SPRH7_ANIM_1),hl
	inc		h
	LD		(SPRH7_ANIM_2),hl
	ret

VERS_LE_HAUT3_ROM
	
	LD		hl,(SPRH7_Y)
	dec		l
	LD		(SPRH7_Y),hl
	ld		(SPRH_Y),hl
	LD		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_haut_monstre3
calc_2anim_haut_monstre3
	LD		(SPRH7_ANIM_1),hl
	inc		h
	LD		(SPRH7_ANIM_2),hl
	ret
	
MORT_MONSTRE_3_ROM

	
EFFACE_MONSTRE_3_ROM
	



efface_event_monstre_3_ROM
	ld		hl,(objet_laisse_3)
	ld		a,l
	ld		(type_objet),a
	call	compteur_objet
	call	asic_on
	xor		a
	LD		(event_MONSTRE3),a
	LD		(event_MONSTRE3+1),a
	LD		(event_MONSTRE3+2),a
	LD		(SPRH7_ZOOM),a
	ld		(flag_monstre3),a
		ld		(flag_premort),a

	ret
	
