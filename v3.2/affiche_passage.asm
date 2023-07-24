affiche_passage
	call	rom_off	
	call 	asic_off
	
	di
	ld 		hl,Music         				;Initialisation
	ld		a,MUSIC_SECRET 
	call 	PLY_AKG_Init
	EI
	
	LD		A,(No_BANK)
	CP		a,#C6
	call	z,C6_on
	CP		a,#C7
	call	z,C7_on
	CP		a,#C5
	call	z,C5_on
	
	
	LD		HL,(tile_a_lire_spr3)		; recupération de l'adresse de la tile_a_lire_spr3
	ld		a,(no_tile_a_ecrire)						; je choisit la tile 001
	ld		(HL),a						; et  l'écrit à l'adresse
	call	c4_on
	call	calcul_piece_grottes
	LD		(resultat_piece_grottes),de			; 6 je la sauvegarde pour plus tard
	ld		a,16
	ld		(bankROM),a
	call	rom_on	
	LD		hl,table_init_grottes				; 3 Adresse de la table d'init du monstre 1
	add		hl,de								; 3 on ajoute le No de la piece pour tomber sur la bonne ligne
	LD		(pointeur_grottes),hl				; 6 je la sauvagarde pour plus tard
	LD		de,VARIABLE_INIT_GROTTES			; 3 cible des suites de variable
	LDI											; 5 ZORA_X
	LDI											; 5 ZORA_X+1
	LDI											; 5 ZORA_Y
	LDI											; 5 ZORA_Y+1
	LDI											; 5 GROTTES
	LDI											; 5 GROTTE ADR+1
	LDI											; PASSAGE 
	LDI											; PASSAGE ADR+1
	call 	rom_off
	call	C4_on
	ld		de,(PASSAGE_ADR)				; l'adresse d'affichage de la tile est dans DE
	ld		hl,(tile_a_ecrire)			; hl contient l'adresse en RAM de la tile escalier
	ld		b,16
boucle_de_la_tile2
	PUSH 	BC
	LD 		BC,4
	PUSH 	DE
	LDIR
	POP 	DE
	CALL 	LIGNEINF_c000
	POP 	BC
	DJNZ	boucle_de_la_tile2
	call	c4_off 	; on remet en C0
	call 	asic_on

	ld		a,120
	ld		(compteur_attente_objet),a
	call	clavier_off
	jp 		retour_passage
	RET
	


