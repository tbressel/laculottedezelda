VERS_LA_DROITE_BOSS_2_ROM
ld		a,droite
	ld		(direction_en_cours_boss2),a
	ld		a,1
	ld		(flag_monstre2),a
	call 	collision_droite
	ld		B,115
	ld		A,(ntile_spr0)	
	SBC	A,B
	JP		NC,changement_direction_boss_2
	
	LD		hl,(SPRH5_X)				; on récupère les coordonnées du monstre
	inc	hl							; déplacement X d'un pixel du monstre
	LD		(SPRH5_X),hl				; on met à jour ses coordonnées
	ld		(SPRH_X),hl
	ld		de,-32
	add	hl,de
	ld		(SPRH6_X),hl
	
	
	LD		hl,(TYPE_MONSTRE_ADR)		; 5 nops
	LD		a,h							; 1 nop
	add		a,#08						; 2 nops
	LD		h,a							; 1 nop
	LD		(SPRH6_ANIM_1),hl
	inc	h
	LD		(SPRH5_ANIM_1),hl
	inc	h
	LD		(SPRH6_ANIM_2),hl
	inc	h
	LD		(SPRH5_ANIM_2),hl
	RET
	
VERS_LA_GAUCHE_BOSS_2_ROM
	ld		a,gauche
	ld		(direction_en_cours_boss2),a
		ld		a,1
	ld		(flag_monstre2),a
	call 	collision_gauche
	ld		B,115
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction_boss_2

	LD		hl,(SPRH5_X)
	dec	hl
	
	LD		(SPRH5_X),hl
	ld		(SPRH_X),hl
	ld		de,32
	add	hl,de
	ld		(SPRH6_X),hl
	
	LD		hl,(TYPE_MONSTRE_ADR)
	LD		a,h							; 1 nop
	add	a,#04						; 2 nops
	LD		h,a							; 1 nop
	LD		(SPRH5_ANIM_1),hl
	inc	h
	LD		(SPRH6_ANIM_1),hl
	inc	h
	LD		(SPRH5_ANIM_2),hl
	inc	h
	LD		(SPRH6_ANIM_2),hl
	RET

VERS_LE_BAS_BOSS_2_ROM
	ld		a,bas
	ld		(direction_en_cours_boss2),a
	ld		a,0
	ld		(flag_monstre2),a
	call 	collision_bas
	ld		B,115
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction_boss_2
	LD		hl,(SPRH5_Y)
	inc	l
	LD		(SPRH5_Y),hl
	ld		(SPRH_Y),hl
	LD		(SPRH6_Y),hl
	LD		hl,(TYPE_MONSTRE_ADR)
	inc	h
	inc	h
	LD		(SPRH5_ANIM_1),hl
	LD		(SPRH6_ANIM_1),hl
	inc	h
	LD		(SPRH5_ANIM_2),hl
	LD		(SPRH6_ANIM_2),hl
	RET
	
VERS_LE_HAUT_BOSS_2_ROM
	ld		a,haut
	ld		(direction_en_cours_boss2),a
	ld		a,0
	ld		(flag_monstre2),a

	call 	collision_haut
	ld		B,115
	ld		A,(ntile_spr0)	
	SBC	A,B
	JP		NC,changement_direction_boss_2

	LD		hl,(SPRH5_Y)
	dec	l
	LD		(SPRH5_Y),hl
	LD		(SPRH6_Y),hl
	ld		(SPRH_Y),hl
	LD		hl,(TYPE_MONSTRE_ADR)
	LD		(SPRH5_ANIM_1),hl
	LD		(SPRH6_ANIM_1),hl
	inc	h
	LD		(SPRH5_ANIM_2),hl
	LD		(SPRH6_ANIM_2),hl
	RET
	
	
	