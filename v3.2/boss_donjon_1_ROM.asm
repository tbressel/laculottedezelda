; /////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////// BOSS DU DONJON 1 - ROM ///////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
init_sprite_boss_1_ROM
	ld		a,2
	ld		(etape_boss_1),a

	ld	hl,(SPRH5_Y)
	ld	(SPRH6_Y),HL
	ld	de,16
	add	 hl,de
	ld	(SPRH7_Y),HL
	ld	(SPRH8_Y),HL

	ld	hl,(SPRH5_X)
	ld  (SPRH7_X),HL
	ld	de,32
	add	 hl,de
	ld	(SPRH6_X),HL
	ld	(SPRH8_X),HL

	ld	hl,BOSS1_RAM
	ld	de,SPRH5_ADR
	ld	bc,#200
	LDIR
	ld	hl,BOSS1_RAM+#400
	ld	de,SPRH7_ADR
	ld	bc,#200
	LDIR

	ld	a,9
	ld	(SPRH5_ZOOM),a
	ld	(SPRH6_ZOOM),a
	ld	(SPRH7_ZOOM),a
	ld	(SPRH8_ZOOM),a
	ld	a,1
	ld	(flag_monstre1),a
	ld	(flag_monstre2),a
	ld	(flag_monstre3),a
	ld	(flag_monstre4),a

	ld	a,71
	ld	(cycle_anim_boss_1),a
	ret

init_deplacement_boss_1_ROM
	ld		a,3
	ld		(etape_boss_1),a
	LD		hl,table_depX_boss_1					; hl contient l'adresse de la table monstre 1
	LD		(pointeur_depX_boss_1),hl	 
	LD		ix,(pointeur_depX_boss_1)
	LD		(pointeur_direction),ix
	LD		a,(ix)									; on lit le nombre de pas X de direction
	LD		(compteur_depX_boss_1),a
	LD		hl,table_depY_boss_1					; hl contient l'adresse de la table monstre 1
	LD		(pointeur_depY_boss_1),hl	 
	LD		iy,(pointeur_depy_boss_1)
	LD		(pointeur_direction+2),iy
	LD		a,(iy)									; on lit le nombre de pas Y de direction
	LD		(compteur_depY_boss_1),a
	LD		a,nbr_direction
	LD		(compteur_direction),a
	ret



	
CHANGEMENT_DIRECTION_BOSS1_ROM
LD		a,(compteur_direction_boss1)
	dec		a
	LD		(compteur_direction_boss1),a
	CP		a,0
	JP		z,reinit_deplacements_boss_1
	LD		hl,(pointeur_direction_boss1)		; 5 nops
	inc		l							; 1 nop	
	LD		(pointeur_direction_boss1),hl		; 5 nops
	LD		a,(hl)						; 2 nops
	LD		(compteur_depX_boss_1),a ; 4 nops
	LD		hl,(pointeur_direction_boss1+2)
	inc		l
	LD		(pointeur_direction_boss1+2),hl
	LD		a,(hl)
	LD		(compteur_depY_boss_1),a
RET





reinit_3_boules_de_feu_ROM
	ld	hl,(SPRH5_X)
	LD	(SPRH13_X),hl
	LD	(SPRH14_X),hl
	LD	(SPRH15_X),hl
	ld	hl,(SPRH5_Y)
	LD	(SPRH13_Y),hl
	LD	(SPRH14_Y),hl
	LD	(SPRH15_Y),hl
	ld	a,9
	ld	(SPRH13_ZOOM),a
	ld	(SPRH14_ZOOM),a
	ld	(SPRH15_ZOOM),a
	ld	a,1
	ld	(flag_sprh13),a
	ld	(flag_sprh14),a
	ld	(flag_sprh15),a
	xor a
	ld	(etape_3_boule_de_feu),a
	ld	(une_bouledefeu_est_en_cours),a
	ret






mort_boss_1_ROM
	call	asic_on
	xor 	a
	ld		(SPRH5_ZOOM),a
	ld		(SPRH6_ZOOM),a
	ld		(SPRH7_ZOOM),a
	ld		(SPRH8_ZOOM),a
	ld		(flag_monstre1),a
	ld		(flag_monstre2),a
	ld		(flag_monstre3),a
	ld		(flag_monstre4),a

	LD		(event_boss_3_boules_de_feu),a
	LD		(event_boss_3_boules_de_feu+1),a
	LD		(event_boss_3_boules_de_feu+2),a
	LD		(SPRH13_ZOOM),a
	LD		(SPRH14_ZOOM),a
	LD		(SPRH15_ZOOM),a
	ld		(flag_sprh13),a
	ld		(flag_sprh14),a
	ld		(flag_sprh15),a
	
	ld		a,1
	ld		(flag_boss1_RIP),a
	call	del_on
	ld		a,4
	ld		(etape_boss_1),a
	
affiche_porte_vers_trifoce
	call	asic_off
	call	c7_on
	ld		hl,#71B2		; adresse de la tile de la map
	ld		a,206			; une tile de porte que l'on peut ouvrir 
	ld		(hl),a
	call	c7_off
	call	C4_on
	
	ld		de,#c538				; l'adresse d'affichage de la tile est dans DE
	ld		hl,#7380			; hl contient l'adresse en RAM de la tile escalier
	ld		b,16
boucle_de_la_triforce
	PUSH 	BC
	LD 		BC,4
	PUSH 	DE
	LDIR
	POP 	DE
	CALL 	LIGNEINF_c000
	POP 	BC
	DJNZ	boucle_de_la_triforce
	call	c4_off 	; on remet en C0
	call 	asic_on
	jp 		retour_passage
	RET
	jp		retour_boss_donjon
	
affiche_recompense
	ld		a,(flag_receptacle_coeur_donjon1)
	cp		a,0
	RET		nz

recompense_boss_1
	ld		hl,SPRH_COEUR2_ADR
	ld		(OBJET_AUTRE_ADR),hl
	ld		a,#C3
	ld		(event_objet_spawn_donjon),a
	ld		hl,objet_spawn_donjon
	LD		(event_objet_spawn_donjon+1),hl	
efface_event_boss_1
	xor	 	a
	LD		(event_bosses_donjon),a
	LD		(event_bosses_donjon+1),a
	LD		(event_bosses_donjon+2),a
	ld		(etape_boss_1),a
	ld		(flag_boss_donjon),a
	ld		(etape_objet_spawn_donjon),a
	
	ld 		c,2   ;Channel (0-2)
    call 	PLY_AKG_StopSoundEffectFromChannel
	RET
	
	