; /////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////             ENTREE                ///////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////	
; //////////////////////////////////////////////////////////////////////////////////////////////////////
INVENTAIRE


	ld		a,1
	ld		(flag_inventaire),a					; on met le flag à 1 pour signaler que l'inventaire est activé
	ld		a,(bankrom)							; On recupère le numero de la dernière bank utilisé
	ld		(bankrom_save),a					; et on la sauvegarde 
	ld		a,(flag_rom)						; On recupere l'état de la derniere bank connecté
	ld		(flag_rom_save),a					; et on la sauve aussi
	ld		a,(flag_asic)
	ld		(flag_asic_save),a
	ld		a,2
	ld		(bankrom),a
	call	rom_on
	call	inventaire_sauvegarde
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////// SAUVEGARDE DU CONTENU DES SPRITES HARD /////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////// SAUVEGARDE DES FLAGS ZOOM DES SPRITES HARDS ////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////// SAUVEGARDE DES COORDONNEES DES SPRITES HARD ////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////// ON EFFACE TOUT  //////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////// SAUVEGARDE DU FOND ///////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
CAPTURE_FOND
	call	asic_off			; on coupe l'asic pour utiliser la bank #4000
	call	rom_off				; on coupe les connexions de rom pour lire l'écran en #C000
	call	c0_on
	LD 		HL,INVENTAIRE_OFFSET_ECRAN			
	LD 		DE,SAUVEGARDE_DU_FOND_ADR
	LD 		B,SAUVEGARDE_DU_FOND_NBR_TILES
BOUCLE_CAPTURE1
    PUSH 	BC
	LD 		BC,LARGEUR_ECRAN
	PUSH 	HL
	LDIR
	POP 	HL
	EX		HL,DE
	CALL 	LIGNEINF_c000
	EX		HL,DE
	POP 	BC                 		;on récupère le nombre de ligne
    DJNZ  	BOUCLE_CAPTURE1          ;Et on boucle
; /////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////// AFFICHAGE DES GFX  ///////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
	ld		a,2
	ld		(bankrom),a
	call	rom_on
	call	AFFICHE_INVENTAIRE_HYRULE
; /////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////// AFFICHAGE DES SPRITE HARD  ////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
	; on initialise l'inventaire
	call	asic_on
	call	test_inventaire
	call	rom_off


	ld		a,BankROM_objets
	ld		(bankrom),a
	call	rom_on
affiche_inventaire_objet_1											; RIEN
	ld		a,(flag_rien)
	or		a
	ld		hl,SPRH_RIEN
	ld		(objet1_sous_curseur),hl
	jr		z,affiche_inventaire_objet_2
	ld		hl,SPRH_RIEN
	push	hl
	ld		de,SPRH1_ADR
	LD		BC,#100
	ldir
	pop		hl
	ld		(objet1_sous_curseur),hl
	ld		a,ZOOM_normal:ld (SPRH1_ZOOM),a
	
affiche_inventaire_objet_2											; BOMEBE
	ld		a,(flag_bombe)
	or		a
	ld		hl,SPRH_RIEN
	ld		(objet2_sous_curseur),hl
	jr		z,affiche_inventaire_objet_3
	ld		hl,SPRH_BOMBE_ADR
	push	hl
	ld		de,SPRH2_ADR
	LD		BC,#100
	ldir
	pop		hl
	ld		(objet2_sous_curseur),hl
	ld		a,ZOOM_normal:ld (SPRH2_ZOOM),a

affiche_inventaire_objet_3											; ARC ET FLECHe
	ld		a,(flag_arc_et_fleche)
	or		a
	ld		hl,SPRH_RIEN
	ld		(objet3_sous_curseur),hl
	jr		z,test_objet_32
	ld		hl,SPRH_FLECHE_ADR
	push	hl
	ld		de,SPRH3_ADR
	LD		BC,#100
	ldir
	pop		hl
	ld		(objet3_sous_curseur),hl
	ld		a,ZOOM_normal:ld (SPRH3_ZOOM),a
	jr		affiche_inventaire_objet_4
test_objet_32
	ld		a,(flag_arc)
	or		a
	ld		hl,SPRH_RIEN
	ld		(objet3_sous_curseur),hl
	jr		z,affiche_inventaire_objet_4
	ld		hl,SPRH_ARC_ADR
	push	hl
	ld		de,SPRH3_ADR
	LD		BC,#100
	ldir
	pop		hl
	ld		(objet3_sous_curseur),hl
	ld		a,ZOOM_normal:ld (SPRH3_ZOOM),a

affiche_inventaire_objet_4
	ld		a,(flag_bougie)										; BOUGIE
	or		a
	ld		hl,SPRH_RIEN
	ld		(objet4_sous_curseur),hl
	jr		z,affiche_inventaire_objet_5
	ld		hl,SPRH_BOUGIE_ADR
	push	hl
	ld		de,SPRH4_ADR
	LD		BC,#100
	ldir
	pop		hl
	ld		(objet4_sous_curseur),hl
	ld		a,ZOOM_normal:ld (SPRH4_ZOOM),a

affiche_inventaire_objet_5											; flute
	ld		a,(flag_flute)
	or		a
	ld		hl,SPRH_RIEN
	ld		(objet5_sous_curseur),hl
	jr		z,affiche_inventaire_objet_6
	ld		hl,SPRH_FLUTE_ADR
	push	hl
	ld		de,SPRH5_ADR
	LD		BC,#100
	ldir
	pop		hl
	ld		(objet5_sous_curseur),hl
	ld		a,ZOOM_normal:ld (SPRH5_ZOOM),a

affiche_inventaire_objet_6										; viande
	ld		a,(flag_viande)
	or		a
	ld		hl,SPRH_RIEN
	ld		(objet6_sous_curseur),hl
	jr		z,affiche_inventaire_objet_7
	ld		hl,SPRH_VIANDE_ADR
	push	hl
	ld		de,SPRH6_ADR
	LD		BC,#100
	ldir
	pop		hl
	ld		(objet6_sous_curseur),hl
	ld		a,ZOOM_normal:ld (SPRH6_ZOOM),a
 
affiche_inventaire_objet_7										; parchemin
	ld		a,(flag_parchemin)
	or		a
	ld		hl,SPRH_RIEN
	ld		(objet7_sous_curseur),hl
	jr		z,test_objet_72
	ld		hl,SPRH_PARCHEMIN_ADR
	push	hl
	ld		de,SPRH7_ADR
	LD		BC,#100
	ldir
	pop		hl
	ld		(objet7_sous_curseur),hl
	ld		a,ZOOM_normal:ld (SPRH7_ZOOM),a
	jr		affiche_inventaire_objet_8
test_objet_72	
	ld		a,(flag_fiole_bleu)
	or		a
	ld		hl,SPRH_RIEN
	ld		(objet7_sous_curseur),hl
	jr		z,test_objet_73
	ld		hl,SPRH_FIOLE_BLEU_ADR
	push	hl
	ld		de,SPRH7_ADR
	LD		BC,#100
	ldir
	pop		hl
	ld		(objet7_sous_curseur),hl
	ld		a,ZOOM_normal:ld (SPRH7_ZOOM),a
	jr		affiche_inventaire_objet_8
test_objet_73
	ld		a,(flag_fiole_rouge)
	or		a
	ld		hl,SPRH_RIEN
	ld		(objet7_sous_curseur),hl
	jr		z,affiche_inventaire_objet_8
	
	ld		hl,SPRH_FIOLE_ROUGE_ADR
	push	hl
	ld		de,SPRH7_ADR
	LD		BC,#100
	ldir
	pop		hl
	ld		(objet7_sous_curseur),hl
	ld		a,ZOOM_normal:ld (SPRH7_ZOOM),a
affiche_inventaire_objet_8														; rien
	ld		a,(flag_game)
	or		a
	ld		hl,SPRH_RIEN
	ld		(objet8_sous_curseur),hl
	jr		z,affiche_inventaire_objet_9
	ld		hl,(SPRH_JEU_ADR)
	push	hl
	ld		de,SPRH8_ADR
	LD		BC,#100
	ldir
	pop		hl
	ld		(objet8_sous_curseur),hl
	ld		a,ZOOM_normal:ld (SPRH8_ZOOM),a
affiche_inventaire_objet_9
	ld		a,(flag_radeau)
	or		a
	jr		z,affiche_inventaire_objet_10
	ld		hl,SPRH_RADEAU_ADR
	ld		de,SPRH9_ADR
	LD		BC,#100
	ldir
	ld		a,ZOOM_normal:ld (SPRH9_ZOOM),a
affiche_inventaire_objet_10
	ld		a,(flag_baton)
	or		a
	jr		z,affiche_inventaire_objet_11
	ld		hl,SPRH_BATON_ADR
	ld		de,SPRH10_ADR
	LD		BC,#100
	ldir
	ld		a,ZOOM_normal:ld (SPRH10_ZOOM),a
affiche_inventaire_objet_11
	ld		a,(flag_bague)
	or		a
	jr		z,affiche_inventaire_objet_12
	ld		hl,SPRH_BAGUE_ADR
	ld		de,SPRH11_ADR
	LD		BC,#100
	ldir
	ld		a,ZOOM_normal:ld (SPRH11_ZOOM),a	
affiche_inventaire_objet_12
	ld		a,(flag_bague2)
	or		a
	jr		z,affiche_inventaire_objet_13
	ld		hl,SPRH_BAGUE_ROUGE_ADR
	ld		de,SPRH12_ADR
	LD		BC,#100
	ldir
	ld		a,ZOOM_normal:ld (SPRH12_ZOOM),a	
affiche_inventaire_objet_13
	ld		a,(flag_cle_donjon)
	or		a
	jr		z,affiche_inventaire_objet_14
	ld		hl,SPRH_CLE_DONJON_ADR
	ld		de,SPRH13_ADR
	LD		BC,#100
	ldir
	ld		a,ZOOM_normal:ld (SPRH13_ZOOM),a	
affiche_inventaire_objet_14
	ld		a,(flag_echelle)
	or		a
	jr		z,fin_inventaire
	ld		hl,SPRH_ECHELLE_ADR
	ld		de,SPRH14_ADR
	LD		BC,#100
	ldir
	ld		a,ZOOM_normal:ld (SPRH14_ZOOM),a		
	
	
	
	
	fin_inventaire
	
; /////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////  INITIALISATION DU CURSEUR DE SELECTION ///////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////
	ld		a,BankROM_objets
	ld		(bankrom),a
	call	rom_on
	ld		hl,SPRH_CURSEUR_ADR
	ld		de,SPRH0_ADR
	ld		bc,#100
	LDIR
	ld		hl,INVENTAIRE_CURSEUR_X
	ld		(SPRH0_X),hl
	ld		hl,INVENTAIRE_CURSEUR_Y
	ld		(SPRH0_Y),hl
	ld		a,ZOOM_normal
	ld		(SPRH0_ZOOM),a
	ld		a,1
	ld		(selection_curseur),a
	call	affiche_apercu
	ld		a,ZOOM_normal
	ld		(SPRH15_ZOOM),a

; /////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////// BOUCLE PINCIPALE  ///////////////////////////////////////////
; //////////////////////////////////////     SECONDAIRE   /////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////
boucle_inventaire_retour
call	rom_off



boucle_inventaire
	CALL TEST_VBL
	
	CALL	test_du_clavier
	Jr	test_de_touches_inv
retour_test_de_touches_inv
	jp		boucle_inventaire	

test_de_touches_inv
		BIT		5,A
		JP 		Z,invent_fire2
		BIT		7,A
		Jp 		Z,sortie
		BIT		3,A
		Jr 		z,droite_curseur
		BIT		2,A
		Jr 		z,gauche_curseur
		Jr			retour_test_de_touches_inv

; /////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////

	
; /////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////       DIRECTION CURSEUR     ///////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////

droite_curseur
	call	curseur_slow
	ld		a,(selection_curseur)
	inc		a
	cp		5
	call	z,ligne_suivante
	cp		9
	jr		z,boucle_inventaire
	ld		(selection_curseur),a
	LD		hl,(SPRH0_X)
	ld		d,0
	ld		de,50
	add		hl,de
	ld		(SPRH0_X),hl
	ld		a,BankROM_objets
	ld		(bankrom),a
	call	rom_on
	ld		a,(selection_curseur)
	call	affiche_apercu
	jr		boucle_inventaire
gauche_curseur
	call	curseur_slow
	ld		a,(selection_curseur)
	dec		a
	cp		4
	call	z,ligne_precedante
	cp		0
	jr		z,boucle_inventaire
	ld		(selection_curseur),a
	LD		hl,(SPRH0_X)
	ld		d,0
	ld		de,-50
	add		hl,de
	ld		(SPRH0_X),hl
	ld		a,BankROM_objets
	ld		(bankrom),a
	call	rom_on
	ld		a,(selection_curseur)
	call	affiche_apercu
	jp		boucle_inventaire
ligne_suivante
	ld		hl,(SPRH0_Y)
	ld		de,22
	add		hl,de
	ld		(SPRH0_Y),hl
	ld		hl,(SPRH0_X)
	ld		de,-200
	add		hl,de
	ld		(SPRH0_X),hl
	ret
ligne_precedante
	ld		hl,(SPRH0_Y)
	ld		de,-22
	add		hl,de
	ld		(SPRH0_Y),hl
	ld		hl,(SPRH0_X)
	ld		de,200
	add		hl,de
	ld		(SPRH0_X),hl
	ret
curseur_slow
	ld	b,255
boucle_curseur_slow
	push	bc
	ld	b,200
boucle_curseur_slow2
	nop
djnz boucle_curseur_slow2
	pop 	bc
djnz boucle_curseur_slow
	ret


; **************************************** AFFICHAGE DES OBJETS DANS L'INVENTAIRE ********************************************
; ******************************************************************************************************************************
affiche_apercu
	cp		a,1
	jr		z,apercu_objet1
	cp		a,2
	jr		z,apercu_objet2
	cp		a,3
	jr		z,apercu_objet3
	cp		a,4
	jr		z,apercu_objet4
	cp		a,5
	jr		z,apercu_objet5
	cp		a,6
	jr		z,apercu_objet6
	cp		a,7
	jr		z,apercu_objet7
	cp		a,8
	jr		z,apercu_objet8
	call	rom_off
ret

apercu_objet1
	ld		hl,(objet1_sous_curseur)
	ld		de,SPRH15_ADR
	ld		bc,#100
	LDIR
	ret
apercu_objet2
	ld		hl,(objet2_sous_curseur)
	ld		de,SPRH15_ADR
	ld		bc,#100
	LDIR
	ret
apercu_objet3
	ld		hl,(objet3_sous_curseur)
	ld		de,SPRH15_ADR
	ld		bc,#100
	LDIR
	ret
apercu_objet4
	ld		hl,(objet4_sous_curseur)
	ld		de,SPRH15_ADR
	ld		bc,#100
	LDIR
	ret
apercu_objet5
	ld		hl,(objet5_sous_curseur)
	ld		de,SPRH15_ADR
	ld		bc,#100
	LDIR
	ret
apercu_objet6
	ld		hl,(objet6_sous_curseur)
	ld		de,SPRH15_ADR
	ld		bc,#100
	LDIR
	ret
apercu_objet7
	ld		hl,(objet7_sous_curseur)
	ld		de,SPRH15_ADR
	ld		bc,#100
	LDIR
	ret
apercu_objet8
	ld		hl,(objet8_sous_curseur)
	ld		de,SPRH15_ADR
	ld		bc,#100
	LDIR
	ret


invent_fire2
ld	a,2
ld	(bankrom),a
call	rom_on
jp	invent_fire2_ROM
	

; /////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////             SORTIE                ///////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////	
; //////////////////////////////////////////////////////////////////////////////////////////////////////	
sortie
;call 	music_on
ld	a,2
ld	(bankrom),a
call	rom_on
; /////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////// ON EFFACE TOUT  //////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
call 	asic_on
CALL	EFFACE_SPRITES_HARD_ZOOM
call 	inventaire_sortie
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////// RECUPERE DU CONTENU DES SPRITES HARD ///////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////// RECUPERATION DES COORDONNEES DES SPRITES HARD ////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////	
call	rom_off
call	asic_off
call	C4_off
call	c0_on
; /////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////// ON RESTITUE DU FOND ///////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
restitue_fond
	LD 		DE,INVENTAIRE_OFFSET_ECRAN
	LD 		HL,SAUVEGARDE_DU_FOND_ADR
	LD 		B,SAUVEGARDE_DU_FOND_NBR_TILES
BOUCLE_RESTITUTION
    PUSH 	BC
	LD 		BC,LARGEUR_ECRAN
	PUSH 	de
	LDIR
	POP 	de
	CALL 	LIGNEINF_c000
	POP 	BC                 ;on récupère le nombre de ligne
   	DJNZ  	BOUCLE_RESTITUTION          ;Et on boucle


call	rom_on
call	inventaire_sortie2
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////// RESTITUTION DES ZOOM DES SPRITES HARDS ////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
call	rom_off
	
; /////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////// RECUPERE L'ETAT des FLAG OM et ASIC  //////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
ld	a,(bankrom_save)
ld	(bankrom),a
ld	a,(flag_rom_save)
ld	(flag_rom),a
ld	a,(flag_asic_save)
ld	(flag_asic),a
xor		A
ld	(flag_inventaire),a
jp	retour_test_de_touches

affiche_rien_hud
	call 	asic_off
	call 	affiche_rien_hud_ROM	
	call	affichage_de_sprite_hud
	call	asic_on
	ret

affiche_flute_hud
	call 	asic_off
	call 	affiche_flute_hud_ROM	
	call	affichage_de_sprite_hud
	call	asic_on
	ret

affiche_viande_hud
	call 	asic_off
	call 	affiche_viande_hud_ROM	
	call	affichage_de_sprite_hud
	call	asic_on
	ret

affiche_bombe_hud
	call 	asic_off
	call 	affiche_bombe_hud_ROM	
	call	affichage_de_sprite_hud
	call	asic_on
	ret
affiche_fleche_hud
	call 	asic_off
	call 	affiche_fleche_hud_ROM	
	call	affichage_de_sprite_hud
	call	asic_on
	ret
affiche_bougie_hud
	call 	asic_off
	call 	affiche_bougie_hud_ROM	
	call	affichage_de_sprite_hud
	call	asic_on
	ret
affiche_parchemin_hud
	call 	asic_off
	call 	affiche_parchemin_hud_ROM	
	call	affichage_de_sprite_hud
	call	asic_on
	ret
affiche_fiole_bleu_hud
	call 	asic_off
	call 	affiche_fiole_bleu_hud_ROM	
	call	affichage_de_sprite_hud
	call	asic_on
	ret
affiche_fiole_rouge_hud
	call 	asic_off
	call 	affiche_fiole_rouge_hud_ROM	
	call	affichage_de_sprite_hud
	call	asic_on
	ret
affiche_epee_01_hud
	call 	asic_off
	call 	affiche_epee_01_hud_ROM	
	call	affichage_de_sprite_hud
	call	asic_on
	ret
affiche_epee_02_hud
	call 	asic_off
	call 	affiche_epee_02_hud_ROM	
	call	affichage_de_sprite_hud
	call	asic_on
	ret
affiche_epee_03_hud
	call 	asic_off
	call 	affiche_epee_03_hud_ROM	
	call	affichage_de_sprite_hud
	call	asic_on
	ret
	



; /////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////// ON EFFACE TOUT  //////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////	


	INVENTAIRE_MAPTILE	
	db	058,054,055,056,057,058,025,026,026,026,026,026,027,019,019,019
	db	058,040,041,042,058,058,020,019,019,019,019,019,021,025,026,027
	db	058,050,051,052,053,058,020,019,019,019,019,019,021,020,019,021
	db	043,044,045,046,047,048,022,023,023,023,023,023,024,022,023,024
	db	058,059,058,058,059,058,019,019,019,019,019,019,019,019,019,019
	

