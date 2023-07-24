link_joue_de_la_flute
	ld		a,255
	ld		(compteur_attente_objet),a
	call	clavier_off
	ld		a,29
	ld		(bankROM),a
	call 	rom_on
	ld		hl,LINK_POSE_FUTE
	ld		de,SPRH0_ADR
	ld		bc,#100
	LDIR
	call	rom_off
	xor		a
	ld		(SPRH1_ZOOM),a
	ld		(flag_sprh1),a
	ld		a,9
	ld		(SPRH0_ZOOM),a
	ld		a,1
	ld		(flag_sprh0),a
	ld		(link_joue),a
	Call	sfx_chanson_de_saria
	RET	
sfx_chanson_de_saria
	di
	ld 		hl,Music         				;Initialisation
	ld		a,MUSIC_FLUTE
	call 	PLY_AKG_Init
	ei
	RET


sfx_nouvel_objet
	di
	ld 		hl,Music         				;Initialisation
	ld		a,MUSIC_ITEM
	call 	PLY_AKG_Init
	ei
	ld		a,2							
	ld		(BankROM),a						
	call	rom_on
	ret
	
	