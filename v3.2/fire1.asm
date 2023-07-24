fire1

	
	ld		a,(direction_en_cours)
	cp		a,0
	jp		z,retour_fire1
	ld		a,(flag_gameover_init)
	cp		5
	jp		z,on_continu_le_jeu
	LD		a,(flag_fire1)							; on test le flag_fire1
	or		a										; pour vérifier si link n'attaque pas déjà
	JP 		nz,retour_fire1							; si l'attaque est en cours, on initialise rien
													; si a=0 on initialise l'attaque
	ld		a,(objet_hud_fire1)
	cp		a,epee_en_bois
	jr		z,init_fire1_attaque
	
	ld		a,(objet_hud_fire1)
	cp		a,epee_en_acier
	jr		z,init_fire1_attaque
	
	ld		a,(objet_hud_fire1)
	cp		a,epee_master_sword
	jr		z,init_fire1_attaque
	JP 		retour_fire1
													
init_fire1_attaque
	ld 		a,1 ;Sound effect number (>=1)
    ld 		c,2 ;channel (0-2)
    ld 		b,0 ;Inverted volume (0-16)
    call 	PLY_AKG_PlaySoundEffect
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	jp		fire1_init_ROM
	call	rom_off
	jr		attaque
attaque
	ld		a,(compteur_attaque_epee)
	dec		a
	ld		(compteur_attaque_epee),a
	;CP 		A,0
	Jr		Z,fin_attaque
	CP		a,Cycle_epee-1
	Jr		Z,debut_attaque
	JP 		NZ,retour_attaque
debut_attaque
	LD		a,(bankROM_link1)						 ;on recupère le no de Bank de Link
	LD		(bankROM),a								 ;on l'envoie dans une variable générale 
	Call 	rom_on
	LD		hl,(LINK_ADR)
	ld		de,SPRH0_ADR
	LD		bc,#100
	LDIR
	LD		hl,(LINK_ADR)
	ld		de,SPRH1_ADR
	LD		bc,#100
	LDIR
	LD		hl,(EPEE_SPR)
	ld		de,SPRH2_ADR
	LD		bc,#100
	LDIR
	call 	rom_off
	LD		a,(SPRH_TYPE_ZOOM)
	LD 		(SPRH2_ZOOM),a
	JP 		retour_attaque
fin_attaque
	xor		a
	LD		(event_attaque),a
	LD		(event_attaque+1),a
	LD		(event_attaque+2),a
	LD		(SPRH2_ZOOM),a
	ld		(flag_fire1),a
	ld		(compteur_sans_attaquer),a
	LD		a,(bankROM_link1)						; on recupère le no de Bank de Link
	LD		(bankROM),a								; on l'envoie dans une variable générale 
	ld		hl,(direction_retablit)
	JP		(hl)
fin_attaque_a_gauche
	call	rom_on									; çà sélèctionne la ROM où se trouve Link.
	LD		hl,(table_type_link)
	LD		de,SPRH0_ADR
	LD		bc,#200
	LDIR
	call	rom_off
	JP		retour_attaque
fin_attaque_a_droite
	call	rom_on									; çà sélèctionne la ROM où se trouve Link.
	LD		hl,(table_type_link+4)
	LD		de,SPRH0_ADR
	LD		bc,#200
	LDIR
	call	rom_off
	JP		retour_attaque
fin_attaque_en_haut
	call	rom_on									; çà sélèctionne la ROM où se trouve Link.
	LD		hl,(table_type_link+12)
	LD		de,SPRH0_ADR
	LD		bc,#200
	LDIR
	call	rom_off
	JP		retour_attaque
fin_attaque_en_bas
	call	rom_on									; çà sélèctionne la ROM où se trouve Link.
	LD		hl,(table_type_link+8)
	LD		de,SPRH0_ADR
	LD		bc,#200
	LDIR
	call	rom_off
	JP		retour_attaque
	
