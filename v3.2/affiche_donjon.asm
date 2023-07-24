; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////// ON ENTRE DANS LE DONJON  ////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
entree_donjon
	
; ///////////////////////////////////////  MISE a ZERO PALLETTE ///////////////////////////////
	call	pallette_off
	ld		a,24							
	ld		(BankROM),a						
	call	rom_on
						; on met toutes les couleurs de la palette à 0

; ///////////////////////////////  COPIE TILES DES DONJONS EN RAM ////////////////////////////
	
	call 	asic_off
	call	c4_on
	
	ld		hl,#c000							; lecture
	ld		de,TILE_ADR							; ecriture
	ld		bc,#4000							; longueur
	LDIR
; ///////////////////////////////  COPIE FONTES TEXTE ET COEURS EN RAM ////////////////////////////
	ld		a,15							; sélèction de la banque contenant
	ld		(BankROM),a						; les tiles des différents donjons
	call	rom_on
	call	c4_on
		; Tiles de 8 octets de large pour la fonte des boutique
			ld		hl,#D400							; lecture
			ld		de,FONTE_TEXTE						; ecriture
			ld		bc,#05B0							; longueur
			LDIR
		; Tiles de  coeur
			ld		hl,#D9B0							; lecture
			ld		de,COEURS_VIE_ADR_RAM				; ecriture
			ld		bc,#0060							; longueur
			LDIR
			

; /////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////  ON CONFIGURE LE DONJON  ///////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
	call	c4_off
	call	code_bank2_on
	call	rom_on
	call	entree_donjon_ROM
	call	rom_off
	call 	code_bankx_off
; /////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////  ON EFFACE LA MAP DE HYRULE //// ////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; On efface la map avec une map noir
	call	affiche_carte					; on arrive iici soit avec MAP_DONJON0 ou 1 ou autre
	call	code_bank2_on
	call	rom_on
	call	test_affiche_boussole
	call	calcul_radar
	call	rom_off
	call 	code_bankx_off

; /////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////  ON CHANGE DE MUSIQUE ////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
	di
	ld 		hl,Music         				;Initialisation
	ld		a,MUSIC_DONJON
	ld		(save_musique_retour),a 
	call 	PLY_AKG_Init
	ei
	JP		NOUVELLE_PIECE

; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////// ON SORT DU DONJON  /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
sortir_donjon

; /////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////  MISE a ZERO PALLETTE ///////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
	ld		a,2								
	ld		(BankROM),a						
	call	rom_on
	call	pallette_off					; on met toutes les couleurs de la palette à 0

; /////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////  COPIE TILES DU HYRULE EN RAM ////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
	
	ld		a,23							; sélèction de la banque contenant
	ld		(BankROM),a						; les palettes des différents donjons
	call	rom_on
	call 	asic_off
	call	c4_on
	ld		hl,#c000							; lecture
	ld		de,TILE_ADR							; ecriture
	ld		bc,#4000							; longueur
	LDIR

	ld		a,15							; sélèction de la banque contenant
	ld		(BankROM),a						; les tiles des différents donjons
	call	rom_on
	call	c4_on
; Tiles de 8 octets de large pour la fonte des boutique
	ld		hl,#D400							; lecture
	ld		de,FONTE_TEXTE						; ecriture
	ld		bc,#05B0							; longueur
	LDIR
; Tiles de  coeur
	ld		hl,#D9B0							; lecture
	ld		de,COEURS_VIE_ADR_RAM				; ecriture
	ld		bc,#0060							; longueur
	LDIR
	call	c4_off	
; /////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////  ON CONFIGURE HYRULE  ///////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
	call	code_bank2_on
	call	rom_on
	call	sortir_donjon_ROM
	call	rom_off
	call 	code_bankx_off
; /////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////  ON REMET LA MAP DE HYRULE //// ////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; On efface la map avec une map noir
	ld		hl,MAP_HYRULE
	ld		(map_a_lire),hl
	call	on_affiche_la_putain_de_carte

; /////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////  ON CHANGE DE MUSIQUE ////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
	di
	ld 		hl,Music         				;Initialisation
	ld		a,MUSIC_HYRULE
	ld		(save_musique_retour),a 
	call 	PLY_AKG_Init
	ei
	JP		NOUVELLE_PIECE

; *********************************************************************************************
; *********************************************************************************************
; *********************************************************************************************
; *********************************************************************************************
; *********************************************************************************************
; *********************************************************************************************
; *********************************************************************************************
; *********************************************************************************************
; *********************************************************************************************
; *********************************************************************************************
; *********************************************************************************************
; *********************************************************************************************
; *********************************************************************************************
; *********************************************************************************************

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////    TEST ON AFFICHE LA CARTE     ///////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
affiche_carte								; par défaukt on a MAP_DONJON0 ou 1 quand on arrive dans un donjon
	ld		a,(flag_donjon)					; si ona dejà pris la carte alors flag_carte_de_ce_donjon=1
	or		a
	jr		z,carte_hyrule
	or		a
	jr		nz,test_carte_donjon

test_carte_donjon
	ld		a,(flag_ok_affiche_carte)
	or		a
	RET		Z
	ld		a,(flag_carte_de_ce_donjon)
	or		a
	jr		nz,on_affiche_la_putain_de_carte
	jr		on_affiche_la_putain_de_carte
; 	on affiche la carte si on vient juste de la prendre. Le flag revient aussitot à 0	
carte_hyrule
	ld		hl,MAP_HYRULE
	ld		(map_a_lire),hl
on_affiche_la_putain_de_carte
	xor		a
	ld		(flag_ok_affiche_carte),a
	ld		a,14							; sélèction de la banque contenant
	ld		(BankROM),a						; les tiles des différents donjons
	call	rom_on
	ld		hl,(map_a_lire)							; lecture
	ld		de,MAP_ECRAN_ADR							; ecriture
	ld		b,48
boucle_hud_donjon0
	PUSH 	BC
	LD 		BC,22
	PUSH 	DE
	LDIR
	POP 	DE
	CALL 	LIGNEINF_c000
	POP 	BC
	DJNZ 	boucle_hud_donjon0
	call	code_bank2_on
	call	rom_on
	ld		a,(flag_donjon)
	or		a
	call	nz,test_affiche_boussole
	ret


; /////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////  TEST DE SORTIE DE DONJON  ///////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
test_collision_bord_donjon
	ld		hl,	(SPRH_Y)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		DE,(bord_bas)							; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JR		NC,collision_bord_donjon							; egale à zéro on va vers le bas
	jp		retour_test_collision_bord_donjon
collision_bord_donjon	
	; on est dans la map d'un donjon
	or		a
	ld		A,(No_PIECE)						; on recupère le numéro de la pièce dans laquelle NOUS SOMMES
	cp		129									; en dessous de 129 on est à Hyrule
	jp		Z,sortir_donjon					; (flag Z ou NZ ) et dans ce cas on sait qu'on doit sortir du donjon
	cp		147									; en dessous de 129 on est à Hyrule
	jp		Z,sortir_donjon					; (flag Z ou NZ ) et dans ce cas on sait qu'on doit sortir du donjon
	cp		165									; en dessous de 129 on est à Hyrule
	jp		Z,sortir_donjon					; (flag Z ou NZ ) et dans ce cas on sait qu'on doit sortir du donjon
	cp		184									; en dessous de 129 on est à Hyrule
	jp		Z,sortir_donjon					; (flag Z ou NZ ) et dans ce cas on sait qu'on doit sortir du donjon
	jp		retour_test_collision_bord_donjon
	
	
; /////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////  TEST SI ON OBJET DOIT SPAWN  ///////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
objet_donjon_1
	ld		a,(flag_naissance_en_cours)
	or		a
	jp		nz,retour_objet_donjon
	call	code_bank2_on
	call	rom_on
	call	objet_donjon_1_ROM
	call	affiche_carte
	call	rom_off
	call 	code_bankx_off
	JP		retour_objet_donjon
objet_donjon_2
		ld		a,(flag_naissance_en_cours)
	or		a
	jp		nz,retour_objet_donjon
	call	code_bank2_on
	call	rom_on
	call	objet_donjon_2_ROM
	call	affiche_carte
	call	rom_off
	call 	code_bankx_off
	JP		retour_objet_donjon
objet_donjon_3
	ld		a,(flag_naissance_en_cours)
	or		a
	jp		nz,retour_objet_donjon
	call	code_bank2_on
	call	rom_on
	call	objet_donjon_3_ROM
	call	affiche_carte
	call	rom_off
	call 	code_bankx_off
	JP		retour_objet_donjon
objet_donjon_4
	ld		a,(flag_naissance_en_cours)
	or		a
	jp		nz,retour_objet_donjon
	call	code_bank2_on
	call	rom_on
	call	objet_donjon_4_ROM
	call	affiche_carte
	call	rom_off
	call 	code_bankx_off
	JP		retour_objet_donjon


; /////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////  TEST SI UN OBJET DOIT SPAWN  ///////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
objet_spawn_donjon
	ld		a,(etape_objet_spawn_donjon)
	cp		a,0
	jr		z,init_objet_spawn_donjon
	cp		a,1
	jp		z,update_objet_spawn_donjon
	cp		a,2
	jp		z,fin_objet_spawn_donjon
init_objet_spawn_donjon
	ld		a,1
	ld		(etape_objet_spawn_donjon),a
	xor		a
	LD		(event_objets_donjon),a
	LD		(event_objets_donjon+1),a
	LD		(event_objets_donjon+2),a
	call	asic_on
	ld		a,25
	ld		(bankROM),a
	call	rom_on
	ld		hl,(OBJET_AUTRE_ADR)
	ld		de,SPRH11_ADR
	ld		bc,#100
	LDIR
	call	rom_off
; pour les objets qui spawn au centre
	ld		a,(No_PIECE)
	cp		a,164						;la trifoce du donjon 2
	jp		z,spawn_au_centre
	; pour les objets qui spawn à droite	
	ld		hl,384
	ld		(SPRH11_X),hl
	ld		(SPRH_X),hl
	ld		hl,160
	ld		(SPRH11_Y),hl
	ld		(SPRH_Y),hl
	ld		a,9
	ld		(SPRH11_ZOOM),a
	ld		a,1
	ld		(flag_monstre7),a
	ld		a,nbr_cycle_attente_monstre
	ld		(attente_naissance_des_monstres),a
	JP		retour_objet
spawn_au_centre	
	ld		hl,240
	ld		(SPRH11_X),hl
	ld		(SPRH_X),hl
	ld		hl,160
	ld		(SPRH11_Y),hl
	ld		(SPRH_Y),hl
	ld		a,9
	ld		(SPRH11_ZOOM),a
	ld		a,1
	ld		(flag_monstre7),a
	ld		a,nbr_cycle_attente_monstre
	ld		(attente_naissance_des_monstres),a
	JP		retour_objet
update_objet_spawn_donjon
	ld		a,(No_PIECE)
	cp		a,164						;la trifoce du donjon 2
	call	z,faire_reapparaitre
	call	code_bank2_on
	call	rom_on
	ld		hl,(SPRH11_X)
	ld		(SPRH_X),hl
	ld		hl,(SPRH11_Y)
	ld		(SPRH_Y),hl
	ld		a,9
	ld		(identification_monstre_en_cours),a
	call	test_collisions_items
	JP		retour_objet
faire_reapparaitre
	ld		a,9
	ld		(SPRH11_ZOOM),a
	ld		a,1
	ld		(flag_monstre7),a
	RET	
fin_objet_spawn_donjon
	xor	a
	LD		(event_objet_spawn_donjon),a
	LD		(event_objet_spawn_donjon+1),a
	LD		(event_objet_spawn_donjon+2),a
	ld		(etape_objet_spawn_donjon),a
	ld		(flag_monstre7),a
	ld		(SPRH11_ZOOM),a
	ld		(etape_objet_spawn_donjon),a
	ld		a,nbr_cycle_attente_monstre
	ld		(attente_naissance_des_monstres),a
	ld		a,(flag_ok_affiche_carte)
	or		a
	JP		z,retour_objet
	call	affiche_carte
	xor 	a
	ld		(flag_ok_affiche_carte),a
	jp		retour_objet

; /////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////  TEST SI UN PASSAGE DOIT SPAWN  ///////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
	
passage_spawn_donjon
	ld		a,(etape_passage_spawn_donjon)
	or		a
	jr		z,init_passage_spawn_donjon
	or		a
	jr		nz,fin_passage_spawn_donjon
	
init_passage_spawn_donjon
	ld		a,1
	ld		(etape_passage_spawn_donjon),a
	ld		hl,(tile_cave)
	ld		(tile_a_lire_spr3),hl
	ld		a,9
	ld		(no_tile_a_ecrire),a
	ld		hl,tile_escalier_donjon1_adr
	ld		(tile_a_ecrire),hl
	jp		affiche_passage
fin_passage_spawn_donjon
	xor		a
	ld		(etape_passage_spawn_donjon),a
	LD		(event_passage_spawn_donjon),a
	LD		(event_passage_spawn_donjon+1),a
	LD		(event_passage_spawn_donjon+2),a
	
	LD		(event_objets_donjon),a
	LD		(event_objets_donjon+1),a
	LD		(event_objets_donjon+2),a
	
	
	ld		(flag_monstre7),a
	ld		(SPRH11_ZOOM),a
	ld		(etape_passage_spawn_donjon),a
	ld		a,nbr_cycle_attente_monstre
	ld		(attente_naissance_des_monstres),a
	jp 		retour_passage_donjon
	

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////    TEST DES PORTES DES DONJONS   ///////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
test_portes_donjon
	call	code_bank2_on
	call	rom_on
	call 	test_portes_donjon_ROM
	call	rom_off
	call 	code_bankx_off
	ret



	