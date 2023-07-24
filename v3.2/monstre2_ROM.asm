VERS_LA_DROITE2_ROM


	LD		hl,(SPRH6_X)				; 5 nops
	;inc		hl							; 1 nop
	inc		hl							; 1 nop
	LD		(SPRH6_X),hl				; 5 nops
	ld		(SPRH_X),hl
	LD		hl,(TYPE_MONSTRE_ADR)		; 5 nops
	
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_droite_monstre2
	ld		a,(flag_anim_4_sprites)
	cp		a,1
	jp		z,calc_4anim_droite_monstre2
	
	LD		a,h							; 1 nop
	add	a,#06						; 2 nops
	LD		h,a							; 1 nop
calc_2anim_droite_monstre2
	LD		(SPRH6_ANIM_1),hl			
	inc		h
	LD		(SPRH6_ANIM_2),hl
	jp		calc_finanim_droite_monstre2
calc_4anim_droite_monstre2
	inc	h:inc	h
	LD		(SPRH6_ANIM_1),hl			
	inc	h
	LD		(SPRH6_ANIM_2),hl
	ret
	

VERS_LA_GAUCHE2_ROM

	LD		hl,(SPRH6_X)
	dec		hl
	;dec		hl
	LD		(SPRH6_X),hl
	ld		(SPRH_X),hl
	LD		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_gauche_monstre2
	ld		a,(flag_anim_4_sprites)
	cp		a,1
	jp		z,calc_4anim_gauche_monstre2
	LD		a,h							; 1 nop
	add		a,#04						; 2 nops
	LD		h,a							; 1 nop
calc_2anim_gauche_monstre2
	LD		(SPRH6_ANIM_1),hl
	inc	 	h
	LD		(SPRH6_ANIM_2),hl
	jp		calc_finanim_gauche_monstre2
calc_4anim_gauche_monstre2
	LD		(SPRH6_ANIM_1),hl			
	inc	h
	LD		(SPRH6_ANIM_2),hl
	ret
	
	
	
	
VERS_LE_BAS2_ROM
	
	LD		hl,(SPRH6_Y)
	inc		l
	LD		(SPRH6_Y),hl
	ld		(SPRH_Y),hl
	LD		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_bas_monstre2
	inc		h
	inc		h
calc_2anim_bas_monstre2
	LD		(SPRH6_ANIM_1),hl
	inc		h
	LD		(SPRH6_ANIM_2),hl
	ret
	
	
	
	
VERS_LE_HAUT2_ROM
	
	LD		hl,(SPRH6_Y)
	dec		l
	LD		(SPRH6_Y),hl
	ld		(SPRH_Y),hl
	LD		hl,(TYPE_MONSTRE_ADR)
		ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_haut_monstre2
calc_2anim_haut_monstre2
	LD		(SPRH6_ANIM_1),hl
	inc		h
	LD		(SPRH6_ANIM_2),hl
	ret
	
	
MORT_MONSTRE_2_ROM
	
	
EFFACE_MONSTRE_2_ROM

	
	
efface_event_monstre_2_ROM
	ld		hl,(objet_laisse_2)
	ld		a,l
	ld		(type_objet),a
	call	compteur_objet
	call	asic_on
	xor		a
	LD		(event_MONSTRE2),a
	LD		(event_MONSTRE2+1),a
	LD		(event_MONSTRE2+2),a
	LD		(SPRH6_ZOOM),a
	ld		(flag_monstre2),a
		ld		(flag_premort),a

	ret
	
	
	
	