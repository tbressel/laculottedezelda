; /////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////// BOSS DU DONJON 2 - ROM ///////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
init_sprite_boss_2_ROM
	ld		hl,(SPRH5_Y)
	ld		(SPRH6_Y),HL
	ld		hl,(SPRH5_X)
	ld		de,32
	add	 hl,de
	ld		(SPRH6_X),HL

	xor		a
	ld		(SPRH6_ZOOM),a
	ld		(flag_monstre2),a
	ld		a,71
	ld		(cycle_anim_boss_2),a
	ret

init_deplacement_boss_2_ROM
	ld		a,3
	ld		(etape_boss_2),a
	LD		hl,table_depX_boss_2					; hl contient l'adresse de la table monstre 1
	LD		(pointeur_depX_boss_2),hl	 
	LD		ix,(pointeur_depX_boss_2)
	LD		(pointeur_direction),ix
	LD		a,(ix)									; on lit le nombre de pas X de direction
	LD		(compteur_depX_boss_2),a
	LD		hl,table_depY_boss_2					; hl contient l'adresse de la table monstre 1
	LD		(pointeur_depY_boss_2),hl	 
	LD		iy,(pointeur_depy_boss_2)
	LD		(pointeur_direction+2),iy
	LD		a,(iy)									; on lit le nombre de pas Y de direction
	LD		(compteur_depY_boss_2),a
	LD		a,nbr_direction
	LD		(compteur_direction),a
	ret

AFFICHE_BOSS_2_ROM
	LD		hl,(TYPE_MONSTRE_ADR)					; on recupère dans HL l'adresse du sprite du boss en RAM
	LD		(SPRH5_ANIM_1),hl						; et on envoie l'adesse comme celle à utiliser pour l'animation
	LD		(SPRH6_ANIM_1),hl						; et dans le deuxième aussi (il n'est pas allumé au départ)
	
	LD		hl,(SPRH5_ANIM_1)						; on envoie dans le SPRH l'animation 1
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	LD		hl,(SPRH6_ANIM_1)						; et ici idem pour l'animation 1, un second sprh
	LD		de,SPRH6_ADR
	LD		bc,#100
	LDIR
	ld		a,1
	ld		(flag_monstre1),a						; on indique que le sprh5 est allumé
	LD		a,2
	LD		(etape_boss_2),a
	RET


REINIT_DEPLACEMENTS_BOSS_2_ROM
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
	RET


UPDATE_BOSS_2_ROM
	LD		a,(compteur_anim_monstre_1)					; on recupere le compteur qui est a xx
	dec	a											; il est a xx-1
	LD		(compteur_anim_monstre_1),a					; on le sauvegarde pour le prochain tour
	CP		A,cycle_anim_1								
	JP		Z,anim_boss_2_phase_1_rom
	CP		A,cycle_anim_2				
	JP		Z,anim_boss_2_phase_2_rom
	CP		A,0
	JP		Z,anim_boss_2_reinit
	RET
ANIM_BOSS_2_PHASE_1_ROM
	LD		a,(etape_boss_2)
	CP		a,3
	RET	Z
	LD		hl,(SPRH5_ANIM_1)							; adresse du sprite dans la RAM
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	ld		a,(flag_monstre2)
	or		a
	jr		z,on_eteint_le_sprh6_anim1
	or		a
	jr		nz,on_allume_le_sprh6_anim1
on_eteint_le_sprh6_anim1
	xor	a
	ld		(SPRH6_ZOOM),a
	LD		hl,(SPRH6_ANIM_1)							; adresse du sprite dans la RAM
	LD		de,SPRH6_ADR
	LD		bc,#100
	LDIR
	RET
on_allume_le_sprh6_anim1

	LD		hl,(SPRH6_ANIM_1)							; adresse du sprite dans la RAM
	LD		de,SPRH6_ADR
	LD		bc,#100
	LDIR
	ld		a,9
	ld		(SPRH6_ZOOM),a
	RET

ANIM_BOSS_2_PHASE_2_ROM
	LD		hl,(SPRH5_ANIM_2)
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	ld		a,(flag_monstre2)
	or		a
	jr		z,on_eteint_le_sprh6_anim2
	or		a
	jr		nz,on_allume_le_sprh6_anim2
on_eteint_le_sprh6_anim2
	xor	a
	ld		(SPRH6_ZOOM),a
	LD		hl,(SPRH6_ANIM_2)							; adresse du sprite dans la RAM
	LD		de,SPRH6_ADR
	LD		bc,#100
	LDIR
	RET
on_allume_le_sprh6_anim2
	LD		hl,(SPRH6_ANIM_2)							; adresse du sprite dans la RAM
	LD		de,SPRH6_ADR
	LD		bc,#100
	LDIR
	ld		a,9
	ld		(SPRH6_ZOOM),a

	RET
ANIM_BOSS_2_REINIT
	LD		a,init_anim_boucle							; cycle d'animation termine on re initialise le compteur
	LD 		(compteur_anim_monstre_1),a					; pour le prochain cycle
	JP 		anim_boss_2_phase_1_rom
	call	deplacement_boss_2
	ret





mort_boss_2_ROM
	call	asic_on
	xor 	a
	ld		(SPRH5_ZOOM),a
	ld		(SPRH6_ZOOM),a
	ld		(flag_monstre1),a
	ld		(flag_monstre2),a
	ld		a,1
	ld		(flag_boss2_RIP),a
	call	del_on
	ld		a,4
	ld		(etape_boss_2),a
	
affiche_porte_vers_trifoce2
	call	asic_off
	call	c5_on
	ld		hl,#4063		; adresse de la tile de la map
	ld		a,206			; une tile de porte que l'on peut ouvrir 
	ld		(hl),a
	call	c5_off
	call	C4_on
	
	ld		de,#c504				; l'adresse d'affichage de la tile est dans DE
	ld		hl,#73c0			; hl contient l'adresse en RAM de la tile escalier
	ld		b,16
boucle_de_la_triforce2
	PUSH 	BC
	LD 		BC,4
	PUSH 	DE
	LDIR
	POP 	DE
	CALL 	LIGNEINF_c000
	POP 	BC
	DJNZ	boucle_de_la_triforce2
	call	c4_off 	; on remet en C0
	call 	asic_on
	jp 		retour_passage
	RET	
	jp		retour_boss_donjon
	
affiche_recompense2
	ld		a,(flag_receptacle_coeur_donjon2)
	or		a
	RET	nz
recompense_boss_2
	ld		hl,SPRH_COEUR2_ADR
	ld		(OBJET_AUTRE_ADR),hl
	ld		a,#C3
	ld		(event_objet_spawn_donjon),a
	ld		hl,objet_spawn_donjon
	LD		(event_objet_spawn_donjon+1),hl	
efface_event_boss_2
	xor	a
	LD		(event_bosses_donjon),a
	LD		(event_bosses_donjon+1),a
	LD		(event_bosses_donjon+2),a
	ld		(etape_boss_2),a
	ld		(flag_boss_donjon),a
	ld		(etape_objet_spawn_donjon),a
	ld 		c,2   ;Channel (0-2)
    call 	PLY_AKG_StopSoundEffectFromChannel
	RET

CHANGEMENT_DIRECTION_BOSS_2_ROM
LD		a,(compteur_direction)
	dec		a
	LD		(compteur_direction),a
	CP		a,0
	JP		z,reinit_deplacements_boss_2
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
	
	

	
	