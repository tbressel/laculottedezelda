init_sprite_boss_3_ROM

	
	ld		hl,(SPRH5_X)
	ld		(SPRH6_X),hl
	ld		(SPRH7_X),hl
	ld		de,32
	add		hl,de
	ld		(SPRH9_X),hl
	ld		de,-64
	add		hl,de
	ld		(SPRH8_X),hl
	
	ld		hl,(SPRH5_Y)
	ld		(SPRH8_Y),hl
	ld		(SPRH9_Y),hl
	ld		de,16
	add		hl,de
	ld		(SPRH7_Y),hl
	ld		de,-32
	add		hl,de
	ld		(SPRH6_Y),hl
	
	LD		hl,MEM_TAMPON_BOSS
	LD		(SPRH5_ANIM_1),hl
	ld		(SPRH5_ANIM_2),hl
	LD		hl,(SPRH5_ANIM_1)
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	ld		hl,BOSS3_H1
	LD		(SPRH6_ANIM_1),hl
	ld		hl,BOSS3_H2
	LD		(SPRH6_ANIM_2),hl
	LD		hl,(SPRH6_ANIM_1)
	LD		de,SPRH6_ADR
	LD		bc,#100
	LDIR
	ld		hl,BOSS3_B1
	LD		(SPRH7_ANIM_1),hl
	ld		hl,BOSS3_B2
	LD		(SPRH7_ANIM_2),hl
	LD		hl,(SPRH7_ANIM_1)
	LD		de,SPRH7_ADR
	LD		bc,#100
	LDIR
	ld		hl,BOSS3_G1
	LD		(SPRH8_ANIM_1),hl
	ld		hl,BOSS3_G2
	LD		(SPRH8_ANIM_2),hl
	LD		hl,(SPRH8_ANIM_1)
	LD		de,SPRH8_ADR
	LD		bc,#100
	LDIR
	ld		hl,BOSS3_D1
	LD		(SPRH9_ANIM_1),hl
	ld		hl,BOSS3_D2
	LD		(SPRH9_ANIM_2),hl
	LD		hl,(SPRH9_ANIM_1)
	LD		de,SPRH9_ADR
	LD		bc,#100
	LDIR
	ld		a,9
	ld		(SPRH5_ZOOM),a
	ld		(SPRH6_ZOOM),a
	ld		(SPRH7_ZOOM),a
	ld		(SPRH8_ZOOM),a
	ld		(SPRH9_ZOOM),a
	ld		a,1
	ld		(flag_monstre1),a
	ld		(flag_monstre2),a
	ld		(flag_monstre3),a
	ld		(flag_monstre4),a
	ld		(flag_monstre5),a
	ret


init_deplacement_boss_3_ROM
	LD		hl,table_depX_monstre_1					; hl contient l'adresse de la table monstre 1
	LD		(pointeur_depX_monstre_1),hl	 
	LD		ix,(pointeur_depX_monstre_1)
	LD		(pointeur_direction),ix
	LD		a,(ix)									; on lit le nombre de pas X de direction
	LD		(compteur_depX_monstre_1),a
	LD		hl,table_depY_monstre_1					; hl contient l'adresse de la table monstre 1
	LD		(pointeur_depY_monstre_1),hl	 
	LD		iy,(pointeur_depy_monstre_1)
	LD		(pointeur_direction+2),iy
	LD		a,(iy)									; on lit le nombre de pas Y de direction
	LD		(compteur_depY_monstre_1),a
	LD		a,nbr_direction
	LD		(compteur_direction),a
	ret
	
ANIM_BOSS_3_PHASE_1_ROM
	LD		hl,(SPRH5_ANIM_1)							; adresse du sprite dans la RAM
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	LD		hl,(SPRH6_ANIM_1)
	LD		de,SPRH6_ADR
	LD		bc,#100
	LDIR
	LD		hl,(SPRH7_ANIM_1)
	LD		de,SPRH7_ADR
	LD		bc,#100
	LDIR
	LD		hl,(SPRH8_ANIM_1)
	LD		de,SPRH8_ADR
	LD		bc,#100
	LDIR
	LD		hl,(SPRH9_ANIM_1)
	LD		de,SPRH9_ADR
	LD		bc,#100
	LDIR
	ret
	
ANIM_BOSS_3_PHASE_2_ROM
	LD		hl,(SPRH5_ANIM_2)
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	LD		hl,(SPRH6_ANIM_2)
	LD		de,SPRH6_ADR
	LD		bc,#100
	LDIR
	LD		hl,(SPRH7_ANIM_2)
	LD		de,SPRH7_ADR
	LD		bc,#100
	LDIR
	LD		hl,(SPRH8_ANIM_2)
	LD		de,SPRH8_ADR
	LD		bc,#100
	LDIR
	LD		hl,(SPRH9_ANIM_2)
	LD		de,SPRH9_ADR
	LD		bc,#100
	LDIR	
	ret
	
VERS_LA_DROITE_BOSS3_ROM

LD		hl,(SPRH5_X)				; on récupère les coordonnées du monstre
	inc		hl							; déplacement X d'un pixel du monstre
	inc		hl							; déplacement X d'un pixel du monstre
	inc		hl							; déplacement X d'un pixel du monstre
	inc		hl	
	LD		(SPRH5_X),hl				; on met à jour ses coordonnées
	LD		(SPRH6_X),hl
	LD		(SPRH7_X),hl
	ld		(SPRH_X),hl
	ld		de,32
	add		hl,de
	ld		(SPRH9_X),hl
	ld		de,-64
	add		hl,de
	ld		(SPRH8_X),hl
	ret
	
VERS_LA_GAUCHE_BOSS3_ROM
	LD		hl,(SPRH5_X)
	dec		hl
	dec		hl
	dec		hl
	dec		hl
	LD		(SPRH5_X),hl
	LD		(SPRH6_X),hl
	LD		(SPRH7_X),hl
	ld		(SPRH_X),hl
	ld		de,32
	add		hl,de
	ld		(SPRH9_X),hl
	ld		de,-64
	add		hl,de
	ld		(SPRH8_X),hl
	RET
	
VERS_LE_BAS_BOSS3_ROM
	ld		hl,(SPRH5_Y)
	inc		l
	inc		l
	ld		(SPRH5_Y),hl
	ld		(SPRH8_Y),hl
	ld		(SPRH9_Y),hl
	ld		de,16
	add		hl,de
	ld		(SPRH7_Y),hl
	ld		de,-32
	add		hl,de
	ld		(SPRH6_Y),hl	
	ret
	
VERS_LE_HAUT_BOSS3_ROM
ld		hl,(SPRH5_Y)
	dec		l
	dec		l
	ld		(SPRH5_Y),hl
	ld		(SPRH8_Y),hl
	ld		(SPRH9_Y),hl
	ld		de,16
	add		hl,de
	ld		(SPRH7_Y),hl
	ld		de,-32
	add		hl,de
	ld		(SPRH6_Y),hl
	ret
	
	
MORT_BOSS_3_ROM
	call	asic_on
	xor 	a
	ld		(SPRH5_ZOOM),a
	ld		(SPRH6_ZOOM),a
	ld		(SPRH7_ZOOM),a
	ld		(SPRH8_ZOOM),a
	ld		(SPRH9_ZOOM),a
	LD		(SPRH10_ZOOM),a
	LD		(SPRH11_ZOOM),a
	LD		(SPRH12_ZOOM),a
	LD		(SPRH13_ZOOM),a
	LD		(SPRH14_ZOOM),a
	LD		(SPRH15_ZOOM),a
	ld		(flag_monstre1),a
	ld		(flag_monstre2),a
	ld		(flag_monstre3),a
	ld		(flag_monstre4),a
	ld		(flag_monstre5),a
	LD		(flag_monstre6),a
	LD		(flag_monstre7),a
	LD		(flag_monstre_zora),a 
	ld		(flag_sprh13),a
	ld		(flag_sprh14),a
	ld		(flag_sprh15),a
	LD		(event_boss_3_boules_de_feu),a
	LD		(event_boss_3_boules_de_feu+1),a
	LD		(event_boss_3_boules_de_feu+2),a
	LD		(event_boss_3_boules_de_feu2),a
	LD		(event_boss_3_boules_de_feu2+1),a
	LD		(event_boss_3_boules_de_feu2+2),a
	ld		a,1
	ld		(flag_boss3_RIP),a
	call	del_on
	
affiche_porte_vers_trifoce3
	call	asic_off
	call	c5_on
	ld		hl,#4F51			; adresse de la tile de la map
	ld		a,202				; une tile de porte que l'on peut ouvrir 
	ld		(hl),a
	ld		hl,#4F52			; adresse de la tile de la map
	ld		a,203				; une tile de porte que l'on peut ouvrir 
	ld		(hl),a
	call	c5_off
	call	C4_on
	ld		de,#c31c			; l'adresse d'affichage de la tile est dans DE
	ld		hl,#7280			; hl contient l'adresse en RAM de la tile escalier
	ld		b,16
boucle_de_la_triforce3a
	PUSH 	BC
	LD 		BC,4
	PUSH 	DE
	LDIR
	POP 	DE
	CALL 	LIGNEINF_c000
	POP 	BC
	DJNZ	boucle_de_la_triforce3a
	
	ld		de,#c320			; l'adresse d'affichage de la tile est dans DE
	ld		hl,#72C0			; hl contient l'adresse en RAM de la tile escalier
	ld		b,16
boucle_de_la_triforce3b
	PUSH 	BC
	LD 		BC,4
	PUSH 	DE
	LDIR
	POP 	DE
	CALL 	LIGNEINF_c000
	POP 	BC
	DJNZ	boucle_de_la_triforce3b
	
	call	c4_off 	; on remet en C0
	call 	asic_on
	ret
	
recompense_boss_3_ROM
ld		hl,SPRH_COEUR2_ADR
	ld		(OBJET_AUTRE_ADR),hl
	ld		a,#C3
	ld		(event_objet_spawn_donjon),a
	ld		hl,objet_spawn_donjon
	LD		(event_objet_spawn_donjon+1),hl
efface_event_boss_3
	xor	a
	LD		(event_bosses_donjon),a
	LD		(event_bosses_donjon+1),a
	LD		(event_bosses_donjon+2),a
	ld		(etape_boss_3),a
	ld		(flag_boss_donjon),a
	ld		(etape_objet_spawn_donjon),a
	ret




init_3_boules_de_feu2_ROM
	ld		hl,(SPRH5_X)
	LD		(SPRH10_X),hl
	LD		(SPRH11_X),hl
	LD		(SPRH12_X),hl
	ld		hl,(SPRH5_Y)
	LD		(SPRH10_Y),hl
	LD		(SPRH11_Y),hl
	LD		(SPRH12_Y),hl
	ld		a,9
	ld		(SPRH10_ZOOM),a
	ld		(SPRH11_ZOOM),a
	ld		(SPRH12_ZOOM),a
	ld		a,1
	ld		(flag_monstre6),a
	ld		(flag_monstre7),a
	ld		(flag_monstre_zora),a
	ld		a,1
	ld		(etape_3_boule_de_feu2),a
	ld		(une_bouledefeu_est_en_cours2),a
	ret



	
reinit_3_boules_de_feu2_ROM
ld	hl,(SPRH5_X)
	LD	(SPRH10_X),hl
	LD	(SPRH11_X),hl
	LD	(SPRH12_X),hl
	ld	hl,(SPRH5_Y)
	LD	(SPRH10_Y),hl
	LD	(SPRH11_Y),hl
	LD	(SPRH12_Y),hl
	ld	a,9
	ld	(SPRH10_ZOOM),a
	ld	(SPRH11_ZOOM),a
	ld	(SPRH12_ZOOM),a
	ld	a,1
	ld	(flag_monstre6),a
	ld	(flag_monstre7),a
	ld	(flag_monstre_zora),a
	ld	a,0
	ld	(etape_3_boule_de_feu2),a
	ld	(une_bouledefeu_est_en_cours2),a
	ret
	
CHANGEMENT_DIRECTION_BOSS3_ROM
	LD		a,(compteur_direction)
	dec		a
	LD		(compteur_direction),a
	CP		a,0
	JP		z,reinit_deplacements_boss_3
	LD		hl,(pointeur_direction)		; 5 nops
	inc		l							; 1 nop	
	LD		(pointeur_direction),hl		; 5 nops
	LD		a,(hl)						; 2 nops
	LD		(compteur_depX_monstre_1),a ; 4 nops
	LD		hl,(pointeur_direction+2)
	inc		l
	LD		(pointeur_direction+2),hl
	LD		a,(hl)
	LD		(compteur_depY_monstre_1),a
	ret
	




	

	
	
	
	