
VERS_LA_DROITE_BOSS1_ROM
	ld		hl,(SPRH6_X)
	ld		(SPRH_X),hl
	call 	collision_droite
	ld		B,115
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction_boss1
	ld		hl,(SPRH8_X)
	ld		(SPRH_X),hl
	call 	collision_droite
	ld		B,115
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction_boss1
	LD		hl,(SPRH5_X)				; on récupère les coordonnées du monstre
	inc		hl							; déplacement X d'un pixel du monstre
	inc		hl							; déplacement X d'un pixel du monstre
	LD		(SPRH5_X),hl				; on met à jour ses coordonnées
	LD		(SPRH7_X),hl				; on met à jour ses coordonnées
	ld		(SPRH_X),hl
	ld		de,32
	add		hl,de
	ld		(SPRH6_X),HL
	ld		(SPRH8_X),HL
	RET
VERS_LA_GAUCHE_BOSS1_ROM
	ld		hl,(SPRH5_X)
	ld		(SPRH_X),hl

	call 	collision_gauche
	ld		B,115
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction_boss1
	ld		hl,(SPRH7_X)
	ld		(SPRH_X),hl

	call 	collision_gauche
	ld		B,115
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction_boss1
	
	LD		hl,(SPRH5_X)				; on récupère les coordonnées du monstre
	dec		hl							; déplacement X d'un pixel du monstre
	dec		hl							; déplacement X d'un pixel du monstre
	LD		(SPRH5_X),hl				; on met à jour ses coordonnées
	LD		(SPRH7_X),hl				; on met à jour ses coordonnées
	ld		(SPRH_X),hl
	ld		de,32
	add		hl,de
	ld		(SPRH6_X),HL
	ld		(SPRH8_X),HL
	RET
	
VERS_LE_BAS_BOSS1_ROM
	ld		hl,(SPRH7_Y)
	ld		(SPRH_Y),hl
	call 	collision_bas
	ld		B,115
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction_boss1

	ld		hl,(SPRH8_Y)
	ld		(SPRH_Y),hl
	call 	collision_bas
	ld		B,115
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction_boss1
	
	
	LD		hl,(SPRH5_Y)
	inc		l
	ld		(SPRH5_Y),HL
	ld		(SPRH6_Y),HL
	ld		(SPRH_Y),hl
	ld		de,16
	add	 	hl,de
	ld		(SPRH7_Y),HL
	ld		(SPRH8_Y),HL
	RET

VERS_LE_HAUT_BOSS1_ROM
	ld		hl,(SPRH5_Y)
	ld		(SPRH_Y),hl
	call 	collision_haut
	ld		B,115
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction_boss1
	
	ld		hl,(SPRH6_Y)
	ld		(SPRH_Y),hl
	call 	collision_haut
	ld		B,115
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction_boss1
	
	
	LD		hl,(SPRH5_Y)
	dec		l
	ld		(SPRH5_Y),HL
	ld		(SPRH6_Y),HL
	ld		(SPRH_Y),hl
	ld		de,16
	add	 	hl,de
	ld		(SPRH7_Y),HL
	ld		(SPRH8_Y),HL
	RET
	
	