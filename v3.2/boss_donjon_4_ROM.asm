init_sprite_boss_4_ROM
ld		hl,B4R_TETE_ROUGE
	LD		de,SPRH6_ADR
	ld		bc,#100
	LDIR
		
	ld		hl,DEPART_ANIM1
	ld		de,SPRH7_ADR		; je garde le sprite 5 pour afficher Mario
	ld		b,3
boucle_boss4_init_sprite
	push	bc					; sauvegarde de la boucle qui détermine le nombre de duo de sprites à envoyer dans l'Asic
	push	hl					 
	push	de
	ld		bc,#200				; #200 pour remplir 2 sprite hard d'un coup
	LDIR
	pop		de					; on récupère le sprh de destination initial
	ld		hl,#200				; on va aller 2 sprite hard plus loin
	add		hl,de				; le résultat est dans hl
	ex		de,hl				; on met le résultat dans de. DE = OK
	pop		hl					; on récupère l'adresse initial
	ld		bc,#600				; on lui ajoute #600
	ADD		hl,bc				; çà nous place à l'endroit du corp dans la ram HL = OK
	pop 	bc					; on récupère BC
	djnz	boucle_boss4_init_sprite
	RET

on_affiche_le_boss_4_ROM
call asic_on
	ld	hl,224
	ld	(SPRH7_X),hl
	ld	(SPRH9_X),hl
	ld	(SPRH11_X),hl
	ld	hl,112
	ld	(SPRH7_Y),hl
	ld	(SPRH8_Y),hl
	ld	hl,256
	ld	(SPRH8_X),hl
	ld	(SPRH10_X),hl
	ld	(SPRH12_X),hl
	ld	hl,128
	ld	(SPRH9_Y),hl
	ld	(SPRH10_Y),hl
	ld	hl,144
	ld	(SPRH11_Y),hl
	ld	(SPRH12_Y),hl
	
	ld	hl,245
	ld	(SPRH6_X),hl
	ld	hl,152
	ld	(SPRH6_Y),hl
	
	ld	a,9
	ld	(SPRH6_ZOOM),a
	ld	(SPRH7_ZOOM),a
	ld	(SPRH8_ZOOM),a
	ld	(SPRH9_ZOOM),a
	ld	(SPRH10_ZOOM),a
	ld	(SPRH11_ZOOM),a
	ld	(SPRH12_ZOOM),a
	
	ld	a,1
	ld	(flag_monstre2),a
	ld	(flag_monstre3),a
	ld	(flag_monstre4),a
	ld	(flag_monstre5),a
	ld	(flag_monstre6),a
	ld	(flag_monstre7),a
	ld	(flag_monstre_zora),a					
	LD		a,3
	LD		(etape_boss_4),a
	
	ld		a,#c3
	ld		(event_boss_3_boules_de_feu),a
	ld		hl,boss_3_boules_de_feu3
	ld		(event_boss_3_boules_de_feu+1),hl
RET



animation_1_boss4_ROM
	ld		hl,B4R_TETE_ROUGE
	LD		de,SPRH6_ADR
	ld		bc,#100
	LDIR
	ld		hl,DEPART_ANIM1
	ld		de,SPRH7_ADR		; je garde le sprite 5 pour afficher Mario
	ld		b,3
	call	boucle_boss4_init_sprite
	ld		a,25
	ld		(cycle_anim_boss_4),a
	LD		a,3
	LD		(etape_boss_4),a
	ld		a,1
	ld		(compteur_anim_boss_4),a
	ret
	
animation_2_boss4_ROM
	ld		hl,B4R_TETE_BLEUE
	LD		de,SPRH6_ADR
	ld		bc,#100
	LDIR
	ld		hl,DEPART_ANIM2
	ld		de,SPRH7_ADR		; je garde le sprite 5 pour afficher Mario
	ld		b,3
	call	boucle_boss4_init_sprite
	ld		a,25
	ld		(cycle_anim_boss_4),a
	LD		a,3
	LD		(etape_boss_4),a
	ld		a,2
	ld		(compteur_anim_boss_4),a
	ret
animation_3_boss4_ROM
	ld		hl,B4R_TETE_BLEUE
	LD		de,SPRH6_ADR
	ld		bc,#100
	LDIR
	ld		hl,DEPART_ANIM3
	ld		de,SPRH7_ADR		; je garde le sprite 5 pour afficher Mario
	ld		b,3
	call	boucle_boss4_init_sprite
	ld		a,25
	ld		(cycle_anim_boss_4),a
	LD		a,3
	LD		(etape_boss_4),a
	ld		a,3
	ld		(compteur_anim_boss_4),a
	ret

mort_boss_4_ROM
xor		a
	ld	(SPRH6_ZOOM),a
	ld	(SPRH7_ZOOM),a
	ld	(SPRH8_ZOOM),a
	ld	(SPRH9_ZOOM),a
	ld	(SPRH10_ZOOM),a
	ld	(SPRH11_ZOOM),a
	ld	(SPRH12_ZOOM),a
	ld	(flag_monstre2),a
	ld	(flag_monstre3),a
	ld	(flag_monstre4),a
	ld	(flag_monstre5),a
	ld	(flag_monstre6),a
	ld	(flag_monstre7),a
	ld	(flag_monstre_zora),a
	LD		(SPRH13_ZOOM),a
	LD		(SPRH14_ZOOM),a
	LD		(SPRH15_ZOOM),a
	ld		(flag_sprh13),a
	ld		(flag_sprh14),a
	ld		(flag_sprh15),a
affiche_porte_vers_trifoce4
	call	asic_off
	call	c5_on
	ld		hl,#5F3B			; adresse de la tile de la map
	ld		a,202				; une tile de porte que l'on peut ouvrir 
	ld		(hl),a
	ld		hl,#5F3C			; adresse de la tile de la map
	ld		a,203				; une tile de porte que l'on peut ouvrir 
	ld		(hl),a
	call	c5_off
	
	
	call	C4_on
	ld		de,#c31c			; l'adresse d'affichage de la tile est dans DE
	ld		hl,#7280			; hl contient l'adresse en RAM de la tile escalier
	ld		b,16
boucle_de_la_triforce4a
	PUSH 	BC
	LD 		BC,4
	PUSH 	DE
	LDIR
	POP 	DE
	CALL 	LIGNEINF_c000
	POP 	BC
	DJNZ	boucle_de_la_triforce4a
	
	ld		de,#c320			; l'adresse d'affichage de la tile est dans DE
	ld		hl,#72C0			; hl contient l'adresse en RAM de la tile escalier
	ld		b,16
boucle_de_la_triforce4b
	PUSH 	BC
	LD 		BC,4
	PUSH 	DE
	LDIR
	POP 	DE
	CALL 	LIGNEINF_c000
	POP 	BC
	DJNZ	boucle_de_la_triforce4b
	ld		a,4
	ld		(etape_boss_4),a
	call	c4_off 	; on remet en C0
	call 	asic_on
	ret
	
efface_event_boss_4_ROM
xor	 	a
	LD		(event_bosses_donjon),a
	LD		(event_bosses_donjon+1),a
	LD		(event_bosses_donjon+2),a
	LD		(event_boss_3_boules_de_feu),a
	LD		(event_boss_3_boules_de_feu+1),a
	LD		(event_boss_3_boules_de_feu+2),a
	ld		(etape_boss_4),a
	ld		(flag_boss_donjon),a
	ld		(etape_objet_spawn_donjon),a
	ld		a,1
	ld		(flag_boss4_RIP),a
	ld		(flag_stop_monstres),a
	call	del_on
	ret

