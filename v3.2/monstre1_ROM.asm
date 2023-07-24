VERS_LA_DROITE_ROM


	LD		hl,(SPRH5_X)				; on récupère les coordonnées du monstre
	;inc		hl							; déplacement X d'un pixel du monstre
	inc		hl							; déplacement X d'un pixel du monstre
	LD		(SPRH5_X),hl				; on met à jour ses coordonnées
	ld		(SPRH_X),hl
	LD		hl,(TYPE_MONSTRE_ADR)		; 5 nops
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_droite_monstre1
	ld		a,(flag_anim_4_sprites)
	cp		a,1
	jp		z,calc_4anim_droite_monstre1
	LD		a,h							; 1 nop
	add	a,#06						; 2 nops
	LD		h,a							; 1 nop
calc_2anim_droite_monstre1
	LD		(SPRH5_ANIM_1),hl			
	inc	h
	LD		(SPRH5_ANIM_2),hl
	jp		calc_finanim_droite_monstre1
calc_4anim_droite_monstre1
	inc	h:inc	h
	LD		(SPRH5_ANIM_1),hl			
	inc	h
	LD		(SPRH5_ANIM_2),hl
	ret

VERS_LA_GAUCHE_ROM

	LD		hl,(SPRH5_X)
	dec		hl
	;dec		hl
	LD		(SPRH5_X),hl
	ld		(SPRH_X),hl
	LD		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_gauche_monstre1
	ld		a,(flag_anim_4_sprites)
	cp		a,1
	jp		z,calc_4anim_gauche_monstre1
	LD		a,h							; 1 nop
	add	a,#04						; 2 nops
	LD		h,a							; 1 nop
calc_2anim_gauche_monstre1
	LD		(SPRH5_ANIM_1),hl
	inc	 h
	LD		(SPRH5_ANIM_2),hl
	jp		calc_finanim_gauche_monstre1
calc_4anim_gauche_monstre1
	LD		(SPRH5_ANIM_1),hl			
	inc	h
	LD		(SPRH5_ANIM_2),hl
calc_finanim_gauche_monstre1	
ret


VERS_LE_BAS_ROM
	LD		hl,(SPRH5_Y)								; on récupère les coordonnées du monstre 1 en Y
	ld		a,(on_bouge_monstre1_ou_pas)				; on récupère l'état s'il doit bouger ou pas (0 oui,  1 non)
	cp		1											; au début il est à 0 donc il bouge
	jp		z,on_zappe_le_deplacement_monstre1bas			; mais s'il est à 1 on zappe le INC L
	inc		l											; on le déplace de 1 pixel 
	inc		A											; par contre pour la prochaine fois il ne doit pas bouger 
	ld		(on_bouge_monstre1_ou_pas),a				; donc on inc A pour le stocker au prochain tour
	jp		on_ne_zappe_PAS_le_deplacement_monstre1bas		; et donc si on zappe PAS, on saute
	
	on_zappe_le_deplacement_monstre1bas		
		dec		A											; la prochaine fois il rebouge 
		ld		(on_bouge_monstre1_ou_pas),a				; donc on inc A pour le stocker au prochain tour
		on_ne_zappe_PAS_le_deplacement_monstre1bas
			LD		(SPRH5_Y),hl							; on modifie ses coordonnées avec la nouvelle valeur.
			ld		(SPRH_Y),hl								; pareil pour la variable générale.
			LD		hl,(TYPE_MONSTRE_ADR)
			ld		a,(flag_anim_2_sprites)
			cp		a,1
			jp		z,calc_2anim_bas_monstre1
			inc		h
			inc		h
calc_2anim_bas_monstre1	
	LD		(SPRH5_ANIM_1),hl
	inc		h
	LD		(SPRH5_ANIM_2),hl
	RET
	
VERS_LE_HAUT_ROM

	LD		hl,(SPRH5_Y)
	
	
	ld		a,(on_bouge_monstre1_ou_pas)				; on récupère l'état s'il doit bouger ou pas (0 oui,  1 non)
	cp		1											; au début il est à 0 donc il bouge
	jp		z,on_zappe_le_deplacement_monstre1haut			; mais s'il est à 1 on zappe le INC L
	
	
	
	
	dec		l
	
	
	inc		A											; par contre pour la prochaine fois il ne doit pas bouger 
	ld		(on_bouge_monstre1_ou_pas),a				; donc on inc A pour le stocker au prochain tour
	jp		on_ne_zappe_PAS_le_deplacement_monstre1haut		; et donc si on zappe PAS, on saute
	
	on_zappe_le_deplacement_monstre1haut		
		dec		A											; la prochaine fois il rebouge 
		ld		(on_bouge_monstre1_ou_pas),a				; donc on inc A pour le stocker au prochain tour
		on_ne_zappe_PAS_le_deplacement_monstre1haut
	
	
	
	
	LD		(SPRH5_Y),hl
	ld		(SPRH_Y),hl
	LD		hl,(TYPE_MONSTRE_ADR)
	ld		a,(flag_anim_2_sprites)
	cp		a,1
	jp		z,calc_2anim_haut_monstre1
calc_2anim_haut_monstre1	
	LD		(SPRH5_ANIM_1),hl
	inc		h
	LD		(SPRH5_ANIM_2),hl
	RET


MORT_MONSTRE_1_ROM
	

EFFACE_MONSTRE_1_ROM

efface_event_monstre_1_ROM
	ld		hl,(objet_laisse_1)
	ld		a,l
	ld		(type_objet),a
	call	compteur_objet
	call	asic_on
	xor		a
	LD		(event_monstre1),a
	LD		(event_monstre1+1),a
	LD		(event_monstre1+2),a
	LD		(SPRH5_ZOOM),a
	ld		(flag_monstre1),a
	ld		(flag_premort),a
	ld		a,(No_PIECE)
	cp		a,220
	jp		z,zelda_RIP
	ret
	
zelda_RIP
	ld		a,1
	ld		(flag_zelda_RIP),a
	ret
	

