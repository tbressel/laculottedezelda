; //////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
affiche_boutique_ROM
	call	del_off
	ld		a,1
	ld		(flag_boutique),a			; on signale qu'on est dans la boutique

;	*****************************************************************************************
; du a un bug dans la boutique 3, où la vieille s'envolait si Zora était en train de tirer une boule de feu au même moment
; du coup on efface l'evenement boule de feu qui de toute façon ne sert plus à rien une foit dans la boutique
	xor		a
	LD		(event_bouledefeu),a
	LD		(event_bouledefeu+1),a
	LD		(event_bouledefeu+2),a
	LD		(event_objets_hyrule),a						; dans ce cas on à plus besoin de tester innutilement la pièce donc on efface l'event "event_objets_hyrule"
	LD		(event_objets_hyrule+1),a
	LD		(event_objets_hyrule+2),a
	ld		(flag_perso_special),a
		
; ************** entrer et sortir de la boutique en etant au bonnes coordonnes
									; et qu'au retour il faudra initialiser les coordonne X et Y
									; pour se situer a cote de la porte d'entree
	LD		hl,(SPRH0_X)				; les portes et passage sont à different endroit
	ld		(posx_spr0_boutique),hl				; on sauvegarde la dernière position de link
	LD		hl,(SPRH0_Y)				; afin d'y revenir une fois sortit de la boutique
	ld		(posy_spr0_boutique),hl

	; **********************  On "configure" la maptile BOUTIQUE ou MAISON ****************************
	
ld	a,(flag_ocean)
or	a
jr	nz,config_maison	
or	a
jr	z,config_boutique

config_maison
ld		a,1
ld		(flag_maison),a
ld			hl,PALETTE_MAISON
ld			(type_de_palette),hl
call	fire2_off
;	configuration de l'adresse
	ld 		HL,(PIECE_ACTUELLE)			; on recupere l'adresse de la piece en cours
	LD		DE,-18						; qui pointe toujours sur la premiere tile
	ADD		HL,DE						; donc il faut revenir en arriere
									; de 18 octets pour pointer sur l'adresse qui
									; va contenir l'adresse de retour  de la d'ou l'on vient
	call 	c5_on
	call 	asic_off
	ld		(MAISON+14),HL			; on modifie le #0000 actuel de la maptile "boutique" 
									; pour indiquer l'adresse de retour bas de la d'ou 
	ld	(RETOUR_PIECE_ACTUELLE),HL	; l'on vient et on la sauvegarde.

	;	configuration de la bank memoire
	ld	A,(No_BANK)			; on recupere la banque de la piece en cours
	ld	(MAISON+16),A			; on auto-modifie l'autre #00 pour indiquer la bank de retour
	ld	(No_BANK_RETOUR),A		; on la sauvegarde pour y revenir

	LD	HL,MAISON+18			; on met l'adresse de la piece boutique en pointant la premiere tile
	LD	(PIECE_ACTUELLE),HL		; qu'on transfert dans la futur piece a afficher
	LD	A,#C5				; on precise la bank dans laquelle la maptile "boutique"
	LD	(No_BANK),A			; se trouve pour la lecture des tiles
	call	asic_on
	;	placement du perso a l'ecran
	LD	HL,#00EC			; c'est la que Link sera place
	LD	(SPRH0_Y),HL
	LD	(SPRH1_Y),HL
	LD	HL,236
	LD	(SPRH0_X),HL
	LD	(SPRH1_X),HL
jp	test_des_boutiques
	
config_boutique
	;	configuration de l'adresse
	ld 		HL,(PIECE_ACTUELLE)			; on recupere l'adresse de la piece en cours
	LD		DE,-18						; qui pointe toujours sur la premiere tile
	ADD		HL,DE						; donc il faut revenir en arriere
									; de 18 octets pour pointer sur l'adresse qui
									; va contenir l'adresse de retour  de la d'ou l'on vient
	call 	c5_on
	call 	asic_off
	ld		(BOUTIQUE+14),HL			; on modifie le #0000 actuel de la maptile "boutique" 
									; pour indiquer l'adresse de retour bas de la d'ou 
	ld	(RETOUR_PIECE_ACTUELLE),HL	; l'on vient et on la sauvegarde.

	;	configuration de la bank memoire
	ld	A,(No_BANK)			; on recupere la banque de la piece en cours
	ld	(BOUTIQUE+16),A			; on auto-modifie l'autre #00 pour indiquer la bank de retour
	ld	(No_BANK_RETOUR),A		; on la sauvegarde pour y revenir

	LD	HL,BOUTIQUE+18			; on met l'adresse de la piece boutique en pointant la premiere tile
	LD	(PIECE_ACTUELLE),HL		; qu'on transfert dans la futur piece a afficher
	LD	A,#C5				; on precise la bank dans laquelle la maptile "boutique"
	LD	(No_BANK),A			; se trouve pour la lecture des tiles
	call	asic_on
	;	placement du perso a l'ecran
	LD	HL,#00EC			; c'est la que Link sera place
	LD	(SPRH0_Y),HL
	LD	(SPRH1_Y),HL
	LD	HL,236
	LD	(SPRH0_X),HL
	LD	(SPRH1_X),HL
	
test_des_boutiques
	;	on test de quelle boutique il s'agit
	LD	a,(No_PIECE)	; on recupere le numeros de la piece par laquelle
	cp	1				; on est arrive dans cette boutique
	call	z,boutique_piece_01		; on affichera la boutique de la piece 01
	cp	2				; on est arrive dans cette boutique
	call	z,boutique_piece_02		; on affichera la boutique de la piece 01
	cp	3				; on est arrive dans cette boutique
	call	z,boutique_piece_03		; on affichera la boutique de la piece 01
	cp	4				; on est arrive dans cette boutique
	call	z,boutique_piece_04		; on affichera la boutique de la piece 01
	cp	5				; on est arrive dans cette boutique
	call	z,boutique_piece_05		; on affichera la boutique de la piece 01
	cp	7				; on est arrive dans cette boutique
	call	z,boutique_piece_07		; on affichera la boutique de la piece 01
	cp	8				; on est arrive dans cette boutique
	call	z,boutique_piece_08		; on affichera la boutique de la piece 01
	cp	9				; on est arrive dans cette boutique
	call	z,boutique_piece_09		; on affichera la boutique de la piece 01
	cp	12				; on est arrive dans cette boutique
	call	z,boutique_piece_12		; on affichera la boutique de la piece 01
	cp	28				; on est arrive dans cette boutique
	call	z,boutique_piece_28		; on affichera la boutique de la piece 01
	cp	17				; on est arrive dans cette boutique
	call	z,boutique_piece_17		; on affichera la boutique de la piece 01
	cp	19				; on est arrive dans cette boutique
	call	z,boutique_piece_19		; on affichera la boutique de la piece 01
	cp	20				; on est arrive dans cette boutique
	call	z,boutique_piece_20		; on affichera la boutique de la piece 01
	cp	22				; on est arrive dans cette boutique
	call	z,boutique_piece_22		; on affichera la boutique de la piece 01
	cp	25				; on est arrive dans cette boutique
	call	z,boutique_piece_25		; on affichera la boutique de la piece 01
	cp	26				; on est arrive dans cette boutique
	call	z,boutique_piece_26		; on affichera la boutique de la piece 01
	cp	27				; on est arrive dans cette boutique
	call	z,boutique_piece_27		; on affichera la boutique de la piece 01
	cp	29				; on est arrive dans cette boutique
	call	z,boutique_piece_29		; on affichera la boutique de la piece 01
	cp	30				; on est arrive dans cette boutique
	call	z,boutique_piece_30		; on affichera la boutique de la piece 01
	cp	31				; on est arrive dans cette boutique
	call	z,boutique_piece_31		; on affichera la boutique de la piece 01
	cp	35				; on est arrive dans cette boutique
	call	z,boutique_piece_35		; on affichera la boutique de la piece 01
	cp	36				; on est arrive dans cette boutique
	call	z,boutique_piece_36		; on affichera la boutique de la piece 01
	cp	38				; on est arrive dans cette boutique
	call	z,boutique_piece_38		; on affichera la boutique de la piece 01
	cp	39				; on est arrive dans cette boutique
	call	z,boutique_piece_39		; on affichera la boutique de la piece 01
	cp	45				; on est arrive dans cette boutique
	call	z,boutique_piece_45		; on affichera la boutique de la piece 01
	cp	46			; on est arrive dans cette boutique
	call	z,boutique_piece_46		; on affichera la boutique de la piece 01
	cp	49			; on est arrive dans cette boutique
	call	z,boutique_piece_49		; on affichera la boutique de la piece 01
	cp	50				; on est arrive dans cette boutique
	call	z,boutique_piece_50		; on affichera la boutique de la piece 01
	cp	51				; on est arrive dans cette boutique
	call	z,boutique_piece_51		; on affichera la boutique de la piece 01
	cp	52				; on est arrive dans cette boutique
	call	z,boutique_piece_52		; on affichera la boutique de la piece 01
	cp	54				; on est arrive dans cette boutique
	call	z,boutique_piece_54		; on affichera la boutique de la piece 01
	cp	60				; on est arrive dans cette boutique
	call	z,boutique_piece_60		; on affichera la boutique de la piece 01
	cp	61				; on est arrive dans cette boutique
	call	z,boutique_piece_61		; on affichera la boutique de la piece 01
	cp	62				; on est arrive dans cette boutique
	call	z,boutique_piece_62		; on affichera la boutique de la piece 01
	cp	70				; on est arrive dans cette boutique
	call	z,boutique_piece_70		; on affichera la boutique de la piece 01
	cp	72			; on est arrive dans cette boutique
	call	z,boutique_piece_72		; on affichera la boutique de la piece 01
	cp	73				; on est arrive dans cette boutique
	call	z,boutique_piece_73		; on affichera la boutique de la piece 01
	cp	74				; on est arrive dans cette boutique
	call	z,boutique_piece_74		; on affichera la boutique de la piece 01
	cp	76				; on est arrive dans cette boutique
	call	z,boutique_piece_76		; on affichera la boutique de la piece 01
	cp	77				; on est arrive dans cette boutique
	call	z,boutique_piece_77	; on affichera la boutique de la piece 01
	cp	83				; on est arrive dans cette boutique
	call	z,boutique_piece_83		; on affichera la boutique de la piece 01
	cp	85				; on est arrive dans cette boutique
	call	z,boutique_piece_85		; on affichera la boutique de la piece 01
	cp	86				; on est arrive dans cette boutique
	call	z,boutique_piece_86		; on affichera la boutique de la piece 01
	cp	87
	call	z,boutique_piece_87		; on affichera la boutique de la piece 01
	cp	88
	call	z,boutique_piece_88		; on affichera la boutique de la piece 01
	cp	89				; on est arrive dans cette boutique
	call	z,boutique_piece_89		; on affichera la boutique de la piece 01
	cp	90				; on est arrive dans cette boutique
	call	z,boutique_piece_90		; on affichera la boutique de la piece 01
	cp	91				; on est arrive dans cette boutique
	call	z,boutique_piece_91		; on affichera la boutique de la piece 01
	cp	92				; on est arrive dans cette boutique
	call	z,boutique_piece_92		; on affichera la boutique de la piece 01
	cp	96				; on est arrive dans cette boutique
	call	z,boutique_piece_96		; on affichera la boutique de la piece 01
	cp	98				; on est arrive dans cette boutique
	call	z,boutique_piece_98		; on affichera la boutique de la piece 01
	cp	102				; on est arrive dans cette boutique
	call	z,boutique_piece_102		; on affichera la boutique de la piece 01
	cp	103				; on est arrive dans cette boutique
	call	z,boutique_piece_103		; on affichera la boutique de la piece 01
	cp	104				; on est arrive dans cette boutique
	call	z,boutique_piece_104		; on affichera la boutique de la piece 01
	cp	106				; on est arrive dans cette boutique
	call	z,boutique_piece_106		; on affichera la boutique de la piece 01
	cp	109				; on est arrive dans cette boutique
	call	z,boutique_piece_109		; on affichera la boutique de la piece 01
	cp	110				; on est arrive dans cette boutique
	call	z,boutique_piece_110		; on affichera la boutique de la piece 01
	cp	111				; on est arrive dans cette boutique
	call	z,boutique_piece_111		; on affichera la boutique de la piece 01
	cp	112				; on est arrive dans cette boutique
	call	z,boutique_piece_112		; on affichera la boutique de la piece 01
	cp	114				; on est arrive dans cette boutique
	call	z,boutique_piece_114		; on affichera la boutique de la piece 01
	cp	116				; on est arrive dans cette boutique
	call	z,boutique_piece_116		; on affichera la boutique de la piece 01
	cp	118				; on est arrive dans cette boutique
	call	z,boutique_piece_118		; on affichera la boutique de la piece 01
	cp	120				; on est arrive dans cette boutique
	call	z,boutique_piece_120		; on affichera la boutique de la piece 01
	cp	121				; on est arrive dans cette boutique
	call	z,boutique_piece_121		; on affichera la boutique de la piece 01
	cp	123				; on est arrive dans cette boutique
	call	z,boutique_piece_123		; on affichera la boutique de la piece 01
	cp	125				; on est arrive dans cette boutique
	call	z,boutique_piece_125		; on affichera la boutique de la piece 01
	cp	126				; on est arrive dans cette boutique
	call	z,boutique_piece_126		; on affichera la boutique de la piece 01
	cp	127				; on est arrive dans cette boutique
	call	z,boutique_piece_127		; on affichera la boutique de la piece 01
	cp	128				; on est arrive dans cette boutique
	call	z,boutique_piece_128		; on affichera la boutique de la piece 01
	cp	222
	call	z,maison_piece_222
	cp	225
	call	z,maison_piece_225
	cp	220
	call	z,maison_piece_220
	cp	243
	call	z,maison_piece_243
	cp	231
	call	z,maison_piece_231
	cp	232
	call	z,maison_piece_232
	cp	250
	call	z,maison_piece_250
	JP		NOUVELLE_PIECE			; sinon on affiche une boutique vide





; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  01       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_01
	call	placement_des_items
	ld		a,(flag_epee_01)
	cp		a,1
	jp		z,tout_masquer
	ld		hl,SPRH_VIEUX_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RIEN
	ld		(OBJET_AUTRE_ADR),hl
	ld		(OBJET_GAUCHE_ADR),hl
	ld		(OBJET_DROITE_ADR),hl
	ld		hl,SPRH_EPEE1_ADR	
	ld		(OBJET_CENTRE_ADR),hl
	
	call	objet_centre_on
	ld		a,epee_en_bois								
	ld		(type_objet_centre),a
	ld		hl,flag_epee_01
	ld		(flag_objet_centre),hl
	
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_01_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  28       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_28

	call	tout_masquer
	call 	asic_off
	call	link_est_nu2
	call 	asic_on
	ret

; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  98       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_98
	call	placement_des_items
	ld		a,(flag_epee_03)
	cp		a,1
	jp		z,tout_masquer
	
	ld		hl,SPRH_VIEUX_ADR
	ld		(PERSO_SPR_ADR),hl
	
	ld		hl,SPRH_RIEN
	ld		(OBJET_AUTRE_ADR),hl
	ld		(OBJET_GAUCHE_ADR),hl
	ld		(OBJET_DROITE_ADR),hl
	ld		hl,SPRH_EPEE3_ADR	
	ld		(OBJET_CENTRE_ADR),hl
	
	call	objet_centre_on
	ld		a,epee_master_sword								
	ld		(type_objet_centre),a
	ld		hl,flag_epee_03
	ld		(flag_objet_centre),hl
	
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_98_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  92       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////

BOUTIQUE_PIECE_92
	call	placement_des_items
	call	asic_off
	call	C0_on
	Call	BOUTIQUE_PIECE_92_RAM
	call	C5_on
	RET
	

	
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  03       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////

BOUTIQUE_PIECE_03
	call	placement_des_items
	ld		hl,SPRH_VIEILLE_ADR
	ld		(PERSO_SPR_ADR),hl
	call	pas_d_items
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_03_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  83       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////

BOUTIQUE_PIECE_83
	call	placement_des_items
	ld		hl,SPRH_VIEILLE_ADR
	ld		(PERSO_SPR_ADR),hl
	call	pas_d_items
	call	texte_init_boutique
	
	ld		hl,TEXTE_BOUTIQUE_83_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret

	
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  38       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////

BOUTIQUE_PIECE_38
	call	placement_des_items
	ld		hl,SPRH_VIEILLE_ADR
	ld		(PERSO_SPR_ADR),hl
	call	pas_d_items	
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_38_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret	
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  96       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////

BOUTIQUE_PIECE_96
	call	placement_des_items
	ld		hl,SPRH_VIEILLE_ADR
	ld		(PERSO_SPR_ADR),hl
	call	pas_d_items
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_96_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret		
	
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  104       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_05
BOUTIQUE_PIECE_104
	ld		a,1
	ld		(flag_perso_special),a
	call	placement_des_items_speciaux
	
	
	ld		hl,SPRH_TODD2_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_TODD1_ADR
	ld		(PERSO_SPR_ADR2),hl
	ld		(OBJET_DROITE_ADR),hl
	
	ld		hl,SPRH_RIEN
	ld		(OBJET_GAUCHE_ADR),hl
	ld		(OBJET_AUTRE_ADR),hl
	ld		hl,SPRH_SHOOE_ADR	
	ld		(OBJET_CENTRE_ADR),hl
	ld		hl,SPRH_SHOOE_ADR	

	
	call	objet_centre_on
	ld		a,objet_teleportation								
	ld		(type_objet_centre),a
		
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_05_104_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  128       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_128
	call	placement_des_items
	ld		a,(flag_cle_donjon)
	or		a
	jp		nz,indice_donjon_2
	ld		a,(flag_triforce_1)
	or		a
	jp		z,indice_donjon_2
	
	
	ld		hl,SPRH_VIEILLE_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RIEN
	ld		(OBJET_AUTRE_ADR),hl
	ld		(OBJET_GAUCHE_ADR),hl
	ld		(OBJET_DROITE_ADR),hl
	ld		hl,SPRH_CLE_DONJON_ADR	
	ld		(OBJET_CENTRE_ADR),hl
	call	objet_centre_on
	ld		a,objet_porte_donjon_2								
	ld		(type_objet_centre),a
	ld		hl,flag_cle_donjon
	ld		(flag_objet_centre),hl
	ret

; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  09       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  30       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  25       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  22       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  110       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  114       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  118       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  121       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_09
BOUTIQUE_PIECE_22
BOUTIQUE_PIECE_25
BOUTIQUE_PIECE_30
BOUTIQUE_PIECE_110
BOUTIQUE_PIECE_114
BOUTIQUE_PIECE_118
BOUTIQUE_PIECE_121
	call	placement_des_items
	ld		hl,SPRH_RIEN
	ld		hl,SPRH_VIEUX_ADR
	ld		(PERSO_SPR_ADR),hl
	call	pas_d_items
	
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_25_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2

	ld		hl,0
	ld		(nbr_rubi),hl
	xor		a
	call		print_decimal_byte
	call		affiche_compteur
	ret
		
pas_assez_de_rubi
	ld		hl,0
	ld		(nbr_rubi),hl
	xor		a
	call		print_decimal_byte
	call		affiche_compteur
	ret


; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  17       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_49
BOUTIQUE_PIECE_125
BOUTIQUE_PIECE_17
call	placement_des_items
	ld		hl,SPRH_PECOR_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RUBIJ_ADR
	ld		(OBJET_AUTRE_ADR),hl
	ld		hl,SPRH_BOUCLIER2_ADR
	ld		(OBJET_GAUCHE_ADR),hl
	ld		hl,SPRH_CLE_ADR
	ld		(OBJET_CENTRE_ADR),hl
	ld		hl,SPRH_BOUGIE_ADR
	ld		(OBJET_DROITE_ADR),hl
	
	call	texte_init_boutique
; on ecopie les données du texte en mémoire tampon
	ld		hl,TEXTE_BOUTIQUE_17_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	
	
	call	objet_gauche_on
	ld		a,objet_bouclier2							
	ld		(type_objet_gauche),a
	ld		hl,flag_bouclier2
	ld		(flag_objet_gauche),hl
	
	call	objet_centre_on
	ld		a,objet_cle								
	ld		(type_objet_centre),a
	
	call	objet_droite_on
	ld		a,objet_bougie							
	ld		(type_objet_droite),a
	ld		hl,flag_bougie
	ld		(flag_objet_droite),hl
	ret	


; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  27       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_27
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  89       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_89
	call	placement_des_items
	ld		hl,SPRH_PECOR_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RUBIJ_ADR
	ld		(OBJET_AUTRE_ADR),hl
	ld		hl,SPRH_BOUCLIER_ADR
	ld		(OBJET_GAUCHE_ADR),hl
	ld		hl,SPRH_CLE_ADR
	ld		(OBJET_CENTRE_ADR),hl
	ld		hl,SPRH_BOUGIE_ADR
	ld		(OBJET_DROITE_ADR),hl
	
	call	texte_init_boutique
; on ecopie les données du texte en mémoire tampon
	ld		hl,TEXTE_BOUTIQUE_27_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	
	
	call	objet_gauche_on
	ld		a,objet_bouclier							
	ld		(type_objet_gauche),a
	ld		hl,flag_bouclier
	ld		(flag_objet_gauche),hl
	
	call	objet_centre_on
	ld		a,objet_cle								
	ld		(type_objet_centre),a
	
	call	objet_droite_on
	ld		a,objet_bougie							
	ld		(type_objet_droite),a
	ld		hl,flag_bougie
	ld		(flag_objet_droite),hl
	ret	
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  51       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_51
	ld		a,1
	ld		(flag_perso_special),a
	call	placement_des_items_speciaux
	ld		a,(flag_bague2)
	or		a
	jp		nz,masquer_item_bague
	
	ld		hl,SPRH_TODD2_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_TODD1_ADR
	ld		(PERSO_SPR_ADR2),hl
	ld		(OBJET_DROITE_ADR),hl
	
	ld		hl,SPRH_RIEN
	ld		(OBJET_GAUCHE_ADR),hl
	ld		(OBJET_AUTRE_ADR),hl
	ld		hl,SPRH_BAGUE_ROUGE_ADR	
	ld		(OBJET_CENTRE_ADR),hl
	ld		hl,SPRH_BAGUE_ROUGE_ADR	

	
	call	objet_centre_on
	ld		a,objet_bague_rouge								
	ld		(type_objet_centre),a
	ld		hl,flag_bague2
	ld		(flag_objet_centre),hl
	
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_51_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret
masquer_item_bague
	ld		hl,SPRH_RIEN
	ld		(OBJET_AUTRE_ADR),hl
	ld		(OBJET_GAUCHE_ADR),hl
	ld		(OBJET_DROITE_ADR),hl
	ld		(OBJET_CENTRE_ADR),hl
	ld		(PERSO_SPR_ADR),hl
	ld		(PERSO_SPR_ADR2),hl
	
	ret
placement_des_items_speciaux
	ld		hl,180
	ld		(SPRH9_Y),hl
	ld		hl,160
	ld		(SPRH10_Y),hl
	ld		(SPRH11_Y),hl
	
	ld		hl,145
	ld		(SPRH10_X),hl
	ld		hl,240
	ld		(SPRH11_X),hl
	ld		hl,340
	
	
	ld		hl,124
	ld		(SPRH12_Y),hl
	ld		hl,140
	ld		(SPRH13_Y),hl
	ld		hl,240
	ld		(SPRH12_X),hl
	ld		(SPRH13_X),hl
	
	
	ld		hl,140
	ld		(SPRH14_Y),hl
	ld		(SPRH15_Y),hl
	ld		hl,135
	ld		(SPRH14_X),hl
	ld		hl,90
	ld		(SPRH9_X),hl
	ld		hl,350
	ld		(SPRH15_X),hl
	ret



; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  04       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  51       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  102       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  77       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  88       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  126       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  29       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
;   POTION BLEUE ET ROUGE

BOUTIQUE_PIECE_04

BOUTIQUE_PIECE_102
BOUTIQUE_PIECE_77
BOUTIQUE_PIECE_88
BOUTIQUE_PIECE_85
BOUTIQUE_PIECE_126
BOUTIQUE_PIECE_29
	call	placement_des_items
	ld		hl,SPRH_RIEN
	ld		hl,SPRH_VIEILLE_ADR
	ld		(PERSO_SPR_ADR),hl
	call	pas_d_items
	ret
deblocage_boutique_piece_29
	call	asic_on
	call	placement_des_items
	ld		hl,SPRH_VIEILLE_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RUBIJ_ADR
	ld		(OBJET_AUTRE_ADR),hl
	ld		hl,SPRH_FIOLE_ROUGE_ADR	
	ld		(OBJET_DROITE_ADR),hl
	ld		hl,SPRH_FIOLE_BLEU_ADR
	ld		(OBJET_GAUCHE_ADR),hl
	call	texte_init_boutique
; on ecopie les données du texte en mémoire tampon
	ld		hl,TEXTE_BOUTIQUE_29_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	
	call	objet_gauche_on
	ld		a,objet_fiole_bleu					
	ld		(type_objet_gauche),a
	ld		hl,flag_fiole_bleu
	ld		(flag_objet_gauche),hl
	
	call	objet_droite_on
	ld		a,objet_fiole_rouge							
	ld		(type_objet_droite),a
	ld		hl,flag_fiole_rouge
	ld		(flag_objet_droite),hl
	
	call	fire2_off
	ld		a,2
	ld		(flag_flammes),a
	xor		a
	ret	

; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  36       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////

BOUTIQUE_PIECE_36
	call	placement_des_items
	ld		hl,SPRH_VIEILLE_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RUBIJ_ADR
	ld		(OBJET_AUTRE_ADR),hl
	ld		hl,SPRH_RUBIB_ADR
	ld		(OBJET_GAUCHE_ADR),hl
	ld		hl,SPRH_RUBIB_ADR
	ld		(OBJET_CENTRE_ADR),hl
	ld		hl,SPRH_RUBIB_ADR
	ld		(OBJET_DROITE_ADR),hl
	
	call	texte_init_boutique
; on copie les données du texte en mémoire tampon
	ld		hl,TEXTE_BOUTIQUE_36_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
		
	call	objet_gauche_on
	ld		a,objet_rubi_bleu_1							
	ld		(type_objet_gauche),a
	ld		hl,flag_rubi_bleu_1
	ld		(flag_objet_gauche),hl
	
	call	objet_centre_on
	ld		a,objet_rubi_bleu_2							
	ld		(type_objet_centre),a
	ld		hl,flag_rubi_bleu_2
	ld		(flag_objet_centre),hl
	
	call	objet_droite_on
	ld		a,objet_rubi_bleu_3							
	ld		(type_objet_droite),a
	ld		hl,flag_rubi_bleu_3
	ld		(flag_objet_droite),hl
	ret
scenario_rubi_bleu_1_boutique_36
	ld		a,(flag_boutique)			; suite à un bug où le texte s'affichait lors
	or		a							; d'un déplacement aléatoir dans la map, je place ce flag ici
	ret		z							; la routine sera renvoyé si on est pas dans une boutique
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_36B_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret	
scenario_rubi_bleu_2_boutique_36
	ld		a,(flag_boutique)			; suite à un bug où le texte s'affichait lors
	or		a							; d'un déplacement aléatoir dans la map, je place ce flag ici
	ret		z							; la routine sera renvoyé si on est pas dans une boutique
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_36C_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret		
scenario_rubi_bleu_3_boutique_36
	ld		a,(flag_boutique)			; suite à un bug où le texte s'affichait lors
	or		a							; d'un déplacement aléatoir dans la map, je place ce flag ici
	ret		z							; la routine sera renvoyé si on est pas dans une boutique
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_36D_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret		
	



; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  02       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  08       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  116       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  120       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  86       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_02
	call	placement_des_items
	ld		a,(flag_rubi_bleu02_gagne)
	or		a
	jp		nz,tout_masquer
	jp		affiche_boutique_suite	
BOUTIQUE_PIECE_08
	call	placement_des_items
	ld		a,(flag_rubi_bleu08_gagne)
	or		a
	jp		nz,tout_masquer
	jp		affiche_boutique_suite

BOUTIQUE_PIECE_116
	call	placement_des_items
	ld		a,(flag_rubi_bleu116_gagne)
	or		a
	jp		nz,tout_masquer
	jp		affiche_boutique_suite

BOUTIQUE_PIECE_120
	call	placement_des_items
	ld		a,(flag_rubi_bleu120_gagne)
	or		a
	jp		nz,tout_masquer
	jp		affiche_boutique_suite

BOUTIQUE_PIECE_86
	call	placement_des_items
	ld		a,(flag_rubi_bleu86_gagne)
	or		a
	jp		nz,tout_masquer

	

affiche_boutique_suite	
	ld		hl,SPRH_VIEUX_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RUBIJ_ADR
	ld		(OBJET_AUTRE_ADR),hl
	ld		hl,SPRH_RUBIB_ADR
	ld		(OBJET_GAUCHE_ADR),hl
	ld		hl,SPRH_RUBIB_ADR
	ld		(OBJET_CENTRE_ADR),hl
	ld		hl,SPRH_RUBIB_ADR
	ld		(OBJET_DROITE_ADR),hl
	
	call	texte_init_boutique
; on ecopie les données du texte en mémoire tampon
	ld		hl,TEXTE_BOUTIQUE_86_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
		
	call	objet_gauche_on
	ld		a,objet_rubi_bleu86_1							
	ld		(type_objet_gauche),a
	ld		hl,flag_rubi_bleu86_1
	ld		(flag_objet_gauche),hl
	
	call	objet_centre_on
	ld		a,objet_rubi_bleu86_2							
	ld		(type_objet_centre),a
	ld		hl,flag_rubi_bleu86_2
	ld		(flag_objet_centre),hl
	
	call	objet_droite_on
	ld		a,objet_rubi_bleu86_3							
	ld		(type_objet_droite),a
	ld		hl,flag_rubi_bleu86_3
	ld		(flag_objet_droite),hl
	xor 	a
	ret
scenario_rubi_bleu_1_boutique_86
	ld		a,(flag_boutique)			; suite à un bug où le texte s'affichait lors
	or		a							; d'un déplacement aléatoir dans la map, je place ce flag ici
	ret		z							; la routine sera renvoyé si on est pas dans une boutique

	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_86B_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret	
scenario_rubi_bleu_2_boutique_86
	ld		a,(flag_boutique)			; suite à un bug où le texte s'affichait lors
	or		a							; d'un déplacement aléatoir dans la map, je place ce flag ici
	ret		z							; la routine sera renvoyé si on est pas dans une boutique
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_86C_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret		
scenario_rubi_bleu_3_boutique_86
	ld		a,(flag_boutique)			; suite à un bug où le texte s'affichait lors
	or		a							; d'un déplacement aléatoir dans la map, je place ce flag ici
	ret		z							; la routine sera renvoyé si on est pas dans une boutique
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_86D_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret		

; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  87       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_87
call	placement_des_items
	ld		a,(flag_parchemin)
	or		a
	jp		nz,tout_masquer
	
	ld		hl,SPRH_VIEUX_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RIEN
	ld		(OBJET_AUTRE_ADR),hl
	ld		(OBJET_GAUCHE_ADR),hl
	ld		(OBJET_DROITE_ADR),hl
	ld		hl,SPRH_PARCHEMIN_ADR	
	ld		(OBJET_CENTRE_ADR),hl
	
	call	objet_centre_on
	ld		a,objet_parchemin								
	ld		(type_objet_centre),a
	ld		hl,flag_parchemin
	ld		(flag_objet_centre),hl
	
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_87_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret


; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  90       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_90
call	placement_des_items
	ld		a,(flag_epee_02)
	or		a
	jp		nz,tout_masquer
	
	ld		hl,SPRH_VIEUX_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RIEN
	ld		(OBJET_AUTRE_ADR),hl
	ld		(OBJET_GAUCHE_ADR),hl
	ld		(OBJET_DROITE_ADR),hl
	ld		hl,SPRH_EPEE2_ADR	
	ld		(OBJET_CENTRE_ADR),hl
	
	call	objet_centre_on
	ld		a,epee_en_acier								
	ld		(type_objet_centre),a
	ld		hl,flag_epee_02
	ld		(flag_objet_centre),hl
	
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_90_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret


; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  12       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_12
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  45       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_45
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  50       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_50
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  106       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_106
call	placement_des_items
	ld		hl,SPRH_PECOR_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RUBIJ_ADR
	ld		(OBJET_AUTRE_ADR),hl
	ld		hl,SPRH_BOUCLIER_ADR
	ld		(OBJET_GAUCHE_ADR),hl
	ld		hl,SPRH_BOMBE_ADR
	ld		(OBJET_CENTRE_ADR),hl
	ld		hl,SPRH_FLECHE_ADR
	ld		(OBJET_DROITE_ADR),hl
	
	call	texte_init_boutique
; on ecopie les données du texte en mémoire tampon
	ld		hl,TEXTE_BOUTIQUE_50_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	
	call	objet_gauche_on
	ld		a,objet_bouclier							
	ld		(type_objet_gauche),a
	ld		hl,flag_bouclier
	ld		(flag_objet_gauche),hl
	
	call	objet_centre_on
	ld		a,objet_bombe								
	ld		(type_objet_centre),a
	
	call	objet_droite_on
	ld		a,objet_fleche								
	ld		(type_objet_droite),a
	ld		hl,flag_fleche
	ld		(flag_objet_droite),hl
	ret	
	
	
	
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  123       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_123
call	placement_des_items
	ld		hl,SPRH_SARIA_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RUBIJ_ADR
	ld		(OBJET_AUTRE_ADR),hl
	ld		hl,SPRH_FLUTE_ADR
	ld		(OBJET_GAUCHE_ADR),hl
	ld		hl,SPRH_BOMBE_ADR
	ld		(OBJET_CENTRE_ADR),hl
	ld		hl,SPRH_FLECHE_ADR
	ld		(OBJET_DROITE_ADR),hl
	
	call	texte_init_boutique
; on ecopie les données du texte en mémoire tampon
	ld		hl,TEXTE_BOUTIQUE_123_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	
	call	objet_gauche_on
	ld		a,objet_flute							
	ld		(type_objet_gauche),a
	ld		hl,flag_flute
	ld		(flag_objet_gauche),hl
	
	call	objet_centre_on
	ld		a,objet_bombe								
	ld		(type_objet_centre),a
	
	call	objet_droite_on
	ld		a,objet_fleche								
	ld		(type_objet_droite),a
	ld		hl,flag_fleche
	ld		(flag_objet_droite),hl
	ret	












	
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  127       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  19        /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////

; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  54       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  39       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
	
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  111       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  70       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  60       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  62       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  31       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  35       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  26       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////   GROTTE CACHEE   /////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////

	
BOUTIQUE_PIECE_19
	call	placement_des_items
	ld		a,(flag_rubi19)
	or		a
	jp		nz,tout_masquer
	ld		hl,flag_rubi19							; on stock l'adresse du flag du ribu de CETTE pièce 26
	jp		on_choppe_30_rubis

BOUTIQUE_PIECE_54
	call	placement_des_items
	ld		a,(flag_rubi54)
	or		a
	jp		nz,tout_masquer
	ld		hl,flag_rubi54							; on stock l'adresse du flag du ribu de CETTE pièce 26
	jp		on_choppe_30_rubis
BOUTIQUE_PIECE_39
	call	placement_des_items
	ld		a,(flag_rubi39)
	or		a
	jp		nz,tout_masquer
	ld		hl,flag_rubi39							; on stock l'adresse du flag du ribu de CETTE pièce 26
	jp		on_choppe_30_rubis
BOUTIQUE_PIECE_20
	call	placement_des_items
	ld		a,(flag_rubi20)
	or		a
	jp		nz,tout_masquer
	ld		hl,flag_rubi20
	jp		on_choppe_30_rubis	            		; on stock l'adresse du flag du ribu de CETTE pièce 26
	



BOUTIQUE_PIECE_111
	call	placement_des_items
	ld		a,(flag_rubi111)
	or		a
	jp		nz,tout_masquer
	ld		hl,flag_rubi111							; on stock l'adresse du flag du ribu de CETTE pièce 26
	jp		on_choppe_50_rubis	
BOUTIQUE_PIECE_70
	call	placement_des_items
	ld		a,(flag_rubi70)
	or		a
	jp		nz,tout_masquer
	ld		hl,flag_rubi70							; on stock l'adresse du flag du ribu de CETTE pièce 26
	jp		on_choppe_50_rubis
BOUTIQUE_PIECE_72
	call	placement_des_items
	ld		a,(flag_rubi72)
	or		a
	jp		nz,tout_masquer
	ld		hl,flag_rubi72							; on stock l'adresse du flag du ribu de CETTE pièce 26
	jp		on_choppe_50_rubis
BOUTIQUE_PIECE_60
	call	placement_des_items
	ld		a,(flag_rubi60)
	or		a
	jp		nz,tout_masquer	
	ld		hl,flag_rubi60							; on stock l'adresse du flag du ribu de CETTE pièce 26
	jp		on_choppe_50_rubis
BOUTIQUE_PIECE_62
	call	placement_des_items
	ld		a,(flag_rubi62)
	or		a
	jp		nz,tout_masquer
	ld		hl,flag_rubi62							; on stock l'adresse du flag du ribu de CETTE pièce 26
	jp		on_choppe_50_rubis
BOUTIQUE_PIECE_31
	call	placement_des_items
	ld		a,(flag_rubi31)
	or		a
	jp		nz,tout_masquer
	ld		hl,flag_rubi31							; on stock l'adresse du flag du ribu de CETTE pièce 26
	jp		on_choppe_50_rubis
BOUTIQUE_PIECE_35
	call	placement_des_items
	ld		a,(flag_rubi35)
	or		a
	jp		nz,tout_masquer
	ld		hl,flag_rubi35							; on stock l'adresse du flag du ribu de CETTE pièce 26
	jp		on_choppe_100_rubis
BOUTIQUE_PIECE_26
	call	placement_des_items
	ld		a,(flag_rubi26)
	or		a
	jp		nz,tout_masquer
	ld		hl,flag_rubi26							; on stock l'adresse du flag du ribu de CETTE pièce 26
	jp		on_choppe_100_rubis
BOUTIQUE_PIECE_46
	call	placement_des_items
	ld		a,(flag_rubi46)
	or		a
	jp		nz,tout_masquer
	ld		hl,flag_rubi46							; on stock l'adresse du flag du ribu de CETTE pièce 26
	jp		on_choppe_100_rubis

affiche_rubi_vert_secret_suite						; donne 100 rubis
	ld		hl,SPRH_GOOMBA_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RIEN
	ld		(OBJET_AUTRE_ADR),hl
	ld		(OBJET_DROITE_ADR),hl
	ld		(OBJET_GAUCHE_ADR),hl
	
	ld		hl,SPRH_RUBIV_ADR
	ld		(OBJET_CENTRE_ADR),hl
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_26_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	
	call	objet_centre_on							; on ective l'évenement objet centre
	ld		a,objet_rubi_bleu26						; on met le numero idientifiant de ce type de rubis (ici 25) dans A.
	ld		(type_objet_centre),a					; et on stock cette valeure dans type_objet_centre, pour sauter au bon label en cas d'effacage de l'objet.
	xor		a
	ret
	
affiche_rubi_jaune_secret_suite
	ld		hl,SPRH_GOOMBA_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RIEN
	ld		(OBJET_AUTRE_ADR),hl
	ld		(OBJET_DROITE_ADR),hl
	ld		(OBJET_GAUCHE_ADR),hl
	
	ld		hl,SPRH_RUBIJ_ADR
	ld		(OBJET_CENTRE_ADR),hl
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_54_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	
	call	objet_centre_on							; on ective l'évenement objet centre
	ld		a,objet_rubi_bleu26						; on met le numero idientifiant de ce type de rubis (ici 25) dans A.
	ld		(type_objet_centre),a					; et on stock cette valeure dans type_objet_centre, pour sauter au bon label en cas d'effacage de l'objet.
	xor		a
	ret
	
affiche_rubi_bleu_secret_suite
	ld		hl,SPRH_GOOMBA_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RIEN
	ld		(OBJET_AUTRE_ADR),hl
	ld		(OBJET_DROITE_ADR),hl
	ld		(OBJET_GAUCHE_ADR),hl
	
	ld		hl,SPRH_RUBIB_ADR
	ld		(OBJET_CENTRE_ADR),hl
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_72_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	
	call	objet_centre_on							; on ective l'évenement objet centre
	ld		a,objet_rubi_bleu26						; on met le numero idientifiant de ce type de rubis (ici 25) dans A.
	ld		(type_objet_centre),a					; et on stock cette valeure dans type_objet_centre, pour sauter au bon label en cas d'effacage de l'objet.
	xor		a
	ret



; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  07       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////   GROTTE CACHEE   /////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_61
	call	placement_des_items
	
	ld		a,(flag_receptacle_coeur61)
	or		a
	jp		nz,tout_masquer
	ld		a,(flag_fiole_rouge_gratuite_61)
	or		a
	jp		nz,tout_masquer
	ld		hl,flag_receptacle_coeur61				; on stock l'adresse du flag du ribu de CETTE pièce 26
	ld		(flag_objet_gauche),hl					; et on l'envoie dans une variable générale qui sera réutilisée pour signaler la possession ou non de l'objet.
	jp		affiche_receptacle_coeur_suite	
BOUTIQUE_PIECE_73
	call	placement_des_items
	ld		a,(flag_receptacle_coeur73)
	or		a
	jp		nz,tout_masquer
	ld		a,(flag_fiole_rouge_gratuite_73)
	or		a
	jp		nz,tout_masquer
	ld		hl,flag_receptacle_coeur73				; on stock l'adresse du flag du ribu de CETTE pièce 26
	ld		(flag_objet_gauche),hl					; et on l'envoie dans une variable générale qui sera réutilisée pour signaler la possession ou non de l'objet.
	jp		affiche_receptacle_coeur_suite	
BOUTIQUE_PIECE_91
	call	placement_des_items
	ld		a,(flag_receptacle_coeur91)
	or		a
	jp		nz,tout_masquer
	ld		a,(flag_fiole_rouge_gratuite_91)
	or		a
	jp		nz,tout_masquer
	ld		hl,flag_receptacle_coeur91				; on stock l'adresse du flag du ribu de CETTE pièce 26
	ld		(flag_objet_gauche),hl					; et on l'envoie dans une variable générale qui sera réutilisée pour signaler la possession ou non de l'objet.
	jp		affiche_receptacle_coeur_suite	

BOUTIQUE_PIECE_127
	call	placement_des_items
	ld		a,(flag_receptacle_coeur127)
	or		a
	jp		nz,tout_masquer
	ld		a,(flag_fiole_rouge_gratuite_127)
	or		a
	jp		nz,tout_masquer
	ld		hl,flag_receptacle_coeur127				; on stock l'adresse du flag du ribu de CETTE pièce 26
	ld		(flag_objet_gauche),hl					; et on l'envoie dans une variable générale qui sera réutilisée pour signaler la possession ou non de l'objet.
	jp		affiche_receptacle_coeur_suite	

BOUTIQUE_PIECE_07
	call	placement_des_items
	ld		a,(flag_receptacle_coeur07)
	or		a
	jp		nz,tout_masquer
	ld		a,(flag_fiole_rouge_gratuite_07)
	or		a
	jp		nz,tout_masquer
	ld		hl,flag_receptacle_coeur07
	ld		(flag_objet_gauche),hl	
	jp		affiche_receptacle_coeur_suite	

affiche_receptacle_coeur_suite
	ld		hl,SPRH_VIEUX_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RIEN
	ld		(OBJET_AUTRE_ADR),hl
	ld		(OBJET_CENTRE_ADR),hl
	
	ld		hl,SPRH_FIOLE_ROUGE_ADR
	ld		(OBJET_DROITE_ADR),hl
	ld		hl,SPRH_COEUR2_ADR
	ld		(OBJET_GAUCHE_ADR),hl
	
	call	objet_droite_on
	ld		a,objet_fiole_rouge								
	ld		(type_objet_droite),a
	ld		hl,flag_fiole_rouge
	ld		(flag_objet_droite),hl
	
	call	objet_gauche_on
	ld		a,objet_receptacle_coeur							
	ld		(type_objet_gauche),a

	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_07_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret



; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  109      /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  112      /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  52       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  74       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////   PASSAGE CACHEE   /////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; BOUCLIER COEUR VIANDE

BOUTIQUE_PIECE_112
BOUTIQUE_PIECE_52
BOUTIQUE_PIECE_74
	call	placement_des_items
	ld		hl,SPRH_PECOR_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RUBIB_ADR
	ld		(OBJET_AUTRE_ADR),hl
	ld		hl,SPRH_BOUCLIER_ADR
	ld		(OBJET_GAUCHE_ADR),hl
	ld		hl,SPRH_COEUR_ADR
	ld		(OBJET_CENTRE_ADR),hl
	ld		hl,SPRH_VIANDE_ADR
	ld		(OBJET_DROITE_ADR),hl
	
	call	texte_init_boutique
; on ecopie les données du texte en mémoire tampon
	ld		hl,TEXTE_BOUTIQUE_74_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	
	call	objet_gauche_on
	ld		a,objet_bouclier3							
	ld		(type_objet_gauche),a
	ld		hl,flag_bouclier3
	ld		(flag_objet_gauche),hl
	
	call	objet_centre_on
	ld		a,objet_coeur							
	ld		(type_objet_centre),a
	ld		hl,flag_coeur
	ld		(flag_objet_centre),hl
	
	call	objet_droite_on
	ld		a,objet_viande								
	ld		(type_objet_droite),a
	ld		hl,flag_viande
	ld		(flag_objet_droite),hl
	ret	
	



; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  109       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////   GROTTE CACHEE   /////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
BOUTIQUE_PIECE_109
call	placement_des_items
ld		a,(flag_game)
or		a
jp		nz,tout_masquer

	ld		hl,SPRH_PECOR_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RUBIB_ADR
	ld		(OBJET_AUTRE_ADR),hl
	ld		hl,SPRH_SCI_ADR
	ld		(OBJET_GAUCHE_ADR),hl
	ld		hl,SPRH_RIEN
	ld		(OBJET_CENTRE_ADR),hl
	ld		hl,SPRH_PANG_ADR
	ld		(OBJET_DROITE_ADR),hl
	
	call	texte_init_boutique
; on ecopie les données du texte en mémoire tampon
	ld		hl,TEXTE_BOUTIQUE_109_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	
	call	objet_gauche_on
	ld		a,objet_sci							
	ld		(type_objet_gauche),a
	ld		hl,flag_sci
	ld		(flag_objet_gauche),hl
	
	call	objet_droite_on
	ld		a,objet_pang								
	ld		(type_objet_droite),a
	ld		hl,flag_pang
	ld		(flag_objet_droite),hl
	ret	
	















; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  76       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////   GROTTE CACHEE   /////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; cle bague viande
BOUTIQUE_PIECE_76
	call	placement_des_items
	ld		hl,SPRH_PECOR_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RUBIB_ADR
	ld		(OBJET_AUTRE_ADR),hl
	ld		hl,SPRH_CLE_ADR
	ld		(OBJET_GAUCHE_ADR),hl
	ld		hl,SPRH_BAGUE_ADR
	ld		(OBJET_CENTRE_ADR),hl
	ld		hl,SPRH_VIANDE_ADR
	ld		(OBJET_DROITE_ADR),hl
	
	call	texte_init_boutique
; on ecopie les données du texte en mémoire tampon
	ld		hl,TEXTE_BOUTIQUE_76_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	
	call	objet_gauche_on
	ld		a,objet_cle							
	ld		(type_objet_gauche),a
	ld		hl,flag_cle
	ld		(flag_objet_gauche),hl
	
	call	objet_centre_on
	ld		a,objet_bague							
	ld		(type_objet_centre),a
	ld		hl,flag_bague
	ld		(flag_objet_centre),hl
	
	call	objet_droite_on
	ld		a,objet_viande								
	ld		(type_objet_droite),a
	ld		hl,flag_viande
	ld		(flag_objet_droite),hl
	ret	
	

; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        BOUTIQUE  VIDE     /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////

BOUTIQUE_PIECE_103
call	placement_des_items
	ld		hl,SPRH_VIEILLE_ADR
	ld		(PERSO_SPR_ADR),hl
	call	pas_d_items
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_103_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret
	






BOUTIQUE_VIDE
	call	placement_des_items
	call	tout_masquer
	ret
	


; //////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
retour_de_boutique_ROM
	xor		a
	ld		(flag_boutique),a			; on signale qu'on est PLUS dans la boutique
	call	del_on
	call	fire2_on
	ld		hl,(posy_spr0_boutique)		; comme il faut revenir a la piece d'ou on est venu
	ld		(SPRH0_Y),hl				; on recupere les coordonnees de l'emplacement
	ld		(SPRH1_Y),HL
	ld		hl,(posx_spr0_boutique)		; de Link, qui correspondait a l'emplacement 
	ld		(SPRH0_X),hl				; de la porte de la grotte
	ld		(SPRH1_X),hl

	ld		hl,(RETOUR_PIECE_ACTUELLE)
	LD		DE,18				; qui pointe toujours sur la premiere tile
	ADD		HL,DE				; donc il faut revenir en arriere	
	ld		(PIECE_ACTUELLE),HL
	ld		A,(No_BANK_RETOUR)
	ld		(No_BANK),A	
	
	xor		a
	ld		(event_flammes),a
	ld		(event_flammes+1),a
	ld		(event_flammes+2),a
	ld		(flag_flammes),a
	ld		(flag_porte_au_loin),a
	
	call	routine_efface_objet_centre
	call	routine_efface_objet_gauche
	call	routine_efface_objet_droite
	
	ld		(event_Link_Update),a
	ld		(event_Link_Update+1),a
	ld		(event_Link_Update+2),a
	
	RET
	
	
	
	
placement_des_items
	ld		hl,180
	ld		(SPRH9_Y),hl
	ld		hl,160
	ld		(SPRH10_Y),hl
	ld		(SPRH11_Y),hl
	ld		(SPRH12_Y),hl
	ld		hl,145
	ld		(SPRH10_X),hl
	ld		hl,240
	ld		(SPRH11_X),hl
	ld		hl,340
	ld		(SPRH12_X),hl
	ld		hl,140
	ld		(SPRH14_Y),hl
	ld		(SPRH15_Y),hl
	ld		hl,135
	ld		(SPRH14_X),hl
	ld		hl,90
	ld		(SPRH9_X),hl
	ld		hl,350
	ld		(SPRH15_X),hl
	ld		hl,140
	ld		(SPRH13_Y),hl
	ld		hl,240
	ld		(SPRH13_X),hl
	
	ret
	placement_des_items_chez_link
	ld		hl,192
	ld		(SPRH10_Y),hl
	ld		hl,96
	ld		(SPRH10_X),hl
	ld		hl,140 
	ld		(SPRH11_Y),hl
	ld		hl,140
	ld		(SPRH11_X),hl
	ld		hl,384
	ld		(SPRH12_X),hl
	ld		hl,170
	ld		(SPRH12_Y),hl
	ret

	
texte_init_boutique
	ld		a,1
	ld		(flag_texte),a
	Ld 		a,#cd				; affiche un jp
	ld 		(event_texte),a
	ld 		hl,affiche_texte
	ld 		(event_texte+1),hl
	RET
texte_init_boutique2
	ld		a,23
	ld		(nombre_de_lettre),a
	ld		a,3
	ld		(nbr_de_ligne),a
; texte de la boutique 1 ligne 1
	ld		de,TEXTE_LIGNE1
	ld		(DEPART_DU_TEXTE_1),de
	LD 		HL,MEM_TAMPON_TEXTE    ;on met l'adresse du depart du texte dans HL
	ld		(texte_boutique_ligne1),hl
; texte de la boutique 1 ligne 2
	ld		de,TEXTE_LIGNE2
	ld		(DEPART_DU_TEXTE_2),de
	LD 		HL,MEM_TAMPON_TEXTE+23    ;on met l'adresse du depart du texte dans HL
	ld		(texte_boutique_ligne2),hl
; texte de la boutique 1 ligne 3 (TARIFS)
	ld		de,TARIFS
	ld		(DEPART_DU_TEXTE_3),de
	LD 		HL,MEM_TAMPON_TEXTE+46	    ;on met l'adresse du depart du texte dans HL
	ld		(texte_boutique_ligne3),hl
	xor		a
	ret
texte_init_boutique3	
	ld		a,23
	ld		(nombre_de_lettre),a
	ld		a,3
	ld		(nbr_de_ligne),a
; texte de la boutique 1 ligne 1
	ld		de,TEXTE_LIGNE3
	ld		(DEPART_DU_TEXTE_1),de
	LD 		HL,MEM_TAMPON_TEXTE    ;on met l'adresse du depart du texte dans HL
	ld		(texte_boutique_ligne1),hl
; texte de la boutique 1 ligne 2
	ld		de,TEXTE_LIGNE4
	ld		(DEPART_DU_TEXTE_2),de
	LD 		HL,MEM_TAMPON_TEXTE+23    ;on met l'adresse du depart du texte dans HL
	ld		(texte_boutique_ligne2),hl
; texte de la boutique 1 ligne 3 (TARIFS)
	ld		de,TEXTE_LIGNE5
	ld		(DEPART_DU_TEXTE_3),de
	LD 		HL,MEM_TAMPON_TEXTE+46	    ;on met l'adresse du depart du texte dans HL
	ld		(texte_boutique_ligne3),hl
	xor		a
	ret

; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        MAISON  243       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
MAISON_PIECE_222
MAISON_PIECE_231
MAISON_PIECE_232
MAISON_PIECE_243									; maison de Link
	ld		a,(flag_noexit)
	or		a
	ret		nz
	call	placement_des_items
	ld		hl,SPRH_RIEN
	ld		(PERSO_SPR_ADR),hl
	ld		(OBJET_AUTRE_ADR),hl
	ld		(OBJET_DROITE_ADR),hl
	ld		(OBJET_CENTRE_ADR),hl
	
	ld		hl,SPRH_NOEXIT_ADR
	ld		(OBJET_GAUCHE_ADR),hl

	call	objet_gauche_on
	ld		a,objet_noexit								
	ld		(type_objet_gauche),a
	
	ret


; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        MAISON  225       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////

MAISON_PIECE_225									; maison de Link
	call	placement_des_items_chez_link
	ld		hl,SPRH_RIEN
	ld		(PERSO_SPR_ADR),hl
	ld		(OBJET_AUTRE_ADR),hl
	
	ld		hl,SPRH_BOMBE_ADR
	ld		(OBJET_GAUCHE_ADR),hl
	
	ld		hl,SPRH_RUBIN_ADR
	ld		(OBJET_CENTRE_ADR),hl

	ld		hl,SPRH_FIOLE_ROUGE_ADR
	ld		(OBJET_DROITE_ADR),hl


	call	objet_gauche_on
	ld		a,objet_bombe							
	ld		(type_objet_gauche),a
	call	objet_droite_on
	ld		a,objet_fiole_rouge								
	ld		(type_objet_droite),a
	ld		hl,flag_fiole_rouge
	ld		(flag_objet_droite),hl
	call	objet_centre_on
	ld		a,objet_rubi_vert								
	ld		(type_objet_centre),a
	
	ret


; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        MAISON  220       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////

MAISON_PIECE_220								; maison de zelda
	call	placement_des_items
	ld		hl,SPRH_RIEN
	ld		(PERSO_SPR_ADR),hl
	ld		(OBJET_AUTRE_ADR),hl
	ld		(OBJET_GAUCHE_ADR),hl
	ld		(OBJET_DROITE_ADR),hl
	ld		(OBJET_CENTRE_ADR),hl
	xor		a
	ld		(flag_stop_monstres),a
	ld		(flag_boutique),a
	ld		(flag_ocean),a
	ld		(flag_mario_nu),a
	ld		(Link_touche),a
	ld		hl,puissance_bite_de_link
	ld		(puissance_epee),hl
	call	fire1_on
	call	fire2_off
	call	del_off
	LD		a,#CD								; sinon on créer l'venement monstre 1
	LD		(event_gameover),a
	LD		hl,link_defonce_zelda
	LD		(event_gameover+1),hl
	call	asic_off
	call	c5_on
	ld		a,181
	ld		hl,#7D59
	ld		(hl),a
	call	c5_off
	call	asic_on
		LD	HL,#00E0			; c'est la que Link sera place
	LD	(SPRH0_Y),HL
	LD	(SPRH1_Y),HL
	ld	a,1
	ld	(flag_zelda),a
	RET

; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////        MAISON  250       /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////

MAISON_PIECE_250								; maison de pecors
	call	placement_des_items
	ld		a,(flag_baton)
	or		a
	jp		nz,tout_masquer
	ld		hl,SPRH_PECOR_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RIEN
	ld		(OBJET_AUTRE_ADR),hl
	ld		(OBJET_GAUCHE_ADR),hl
	ld		(OBJET_DROITE_ADR),hl
	
	ld		hl,SPRH_BATON_ADR
	ld		(OBJET_CENTRE_ADR),hl


	call	objet_centre_on
	ld		a,objet_baton								
	ld		(type_objet_centre),a

	
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_250_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique3
	ret


tout_masquer
	ld		hl,SPRH_RIEN
	ld		(OBJET_AUTRE_ADR),hl
	ld		(OBJET_GAUCHE_ADR),hl
	ld		(OBJET_DROITE_ADR),hl
	ld		(OBJET_CENTRE_ADR),hl
	ld		(PERSO_SPR_ADR),hl
	ret
pas_d_items
	ld		hl,SPRH_RIEN
	ld		(OBJET_AUTRE_ADR),hl
	ld		(OBJET_GAUCHE_ADR),hl
	ld		(OBJET_DROITE_ADR),hl
	ld		(OBJET_CENTRE_ADR),hl
	RET
indice_donjon_2
	ld		hl,SPRH_VIEILLE_ADR
	ld		(PERSO_SPR_ADR),hl
	ld		hl,SPRH_RIEN
	ld		(OBJET_AUTRE_ADR),hl
	ld		(OBJET_GAUCHE_ADR),hl
	ld		(OBJET_DROITE_ADR),hl
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_128_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2
	ret

on_choppe_50_rubis	
	ld		(flag_objet_centre),hl					; et on l'envoie dans une variable générale qui sera réutilisée pour signaler la possession ou non de l'objet.
	ld		de,50
	ld		(gain_rubi_bleu26),de
	jp		affiche_rubi_bleu_secret_suite

on_choppe_100_rubis	
	ld		(flag_objet_centre),hl					; et on l'envoie dans une variable générale qui sera réutilisée pour signaler la possession ou non de l'objet.
	ld		de,100
	ld		(gain_rubi_bleu26),de
	jp		affiche_rubi_vert_secret_suite

on_choppe_30_rubis	
	ld		(flag_objet_centre),hl					; et on l'envoie dans une variable générale qui sera réutilisée pour signaler la possession ou non de l'objet.
	ld		de,30
	ld		(gain_rubi_bleu26),de
	jp		affiche_rubi_jaune_secret_suite	