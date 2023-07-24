ORG CODE_PROGRAMME_3



BOUTIQUE_PIECE_92_RAM


	ld		a,(flag_game)
	cp		a,0
	jp		z,aucun_jeu_trouve
	ld		a,(flag_sci)
	cp		a,1
	jp		z,on_lance_sci
	ld		a,(flag_pang)
	cp		a,1
	jp		z,on_lance_pang
	ld		a,(flag_noexit)
	cp		a,1
	jp		z,on_lance_noexit
	ld		a,(flag_burningrubber)
	cp		a,1
	jp		z,on_lance_burningrubber
	ld		a,(flag_tintin)
	cp		a,1
	jp		z,on_lance_tintin
	ld		a,(flag_wildstreet)
	cp		a,1
	jp		z,on_lance_wildstreet

aucun_jeu_trouve
	ld		hl,SPRH_VIEILLE_ADR
	ld		(PERSO_SPR_ADR),hl
	call	pas_d_items
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_92_rien_ligne1
	jp		fin_piece_92
	
	
on_lance_sci	
	ld		a,255
	ld		(nbr_rubi),a
	call	print_decimal_byte
	
	ld		hl,255
	ld		(nbr_bombe),hl
	ld		a,2
	ld		hl,compteur_bombe
	ld		(hl),a
	ld		a,5
	inc		hl
	ld		(hl),a
	inc		hl
	ld		(hl),a
	ld		a,3
	ld		(type_objet),a
	call	affiche_compteur
	
	
	
	ld		a,255
	ld		(nbr_cle),a
	ld		a,2
	ld		hl,compteur_cle
	ld		(hl),a
	ld		a,5
	inc		hl
	ld		(hl),a
	inc		hl
	ld		(hl),a
	
	ld		a,4
	ld		(type_objet),a
	call	affiche_compteur
	xor		a
	ld		(flag_sci),a
	
	
	ld		a,#C9						; RET
	ld		(link_touche),a
	ld		a,0
	ld		(une_fleche_en_moins),a
	ld		a,1
	ld		(flag_fleche_illimite),a
	ld		hl,SPRH_VIEILLE_ADR
	ld		(PERSO_SPR_ADR),hl
	call	pas_d_items
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_92_sci_ligne1
	jp		fin_piece_92
	
on_lance_pang
	ld		a,255
	ld		(nbr_rubi),a
	call	print_decimal_byte
	call	affiche_compteur
	xor		a
	ld		(flag_pang),a
	
	
	ld		hl,SPRH_VIEILLE_ADR
	ld		(PERSO_SPR_ADR),hl
	call	pas_d_items
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_92_pang_ligne1
	jp		fin_piece_92
	
on_lance_burningrubber
	ld		a,8
	ld		(Bankrom),a
	call	rom_on
	call	champi_rouge
	ld		a,2
	ld		(Bankrom),a
	call	rom_on
	xor		a
	ld		(flag_burningrubber),a
	ld		hl,SPRH_VIEILLE_ADR
	ld		(PERSO_SPR_ADR),hl
	call	pas_d_items
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_92_burningrubber_ligne1
	jp		fin_piece_92
	
on_lance_noexit
	ld		a,2
	ld		(flag_noexit),a
	ld		hl,SPRH_VIEILLE_ADR
	ld		(PERSO_SPR_ADR),hl
	call	pas_d_items
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_92_noexit_ligne1
	jp		fin_piece_92

on_lance_wildstreet
on_lance_tintin
	ld		hl,SPRH_VIEILLE_ADR
	ld		(PERSO_SPR_ADR),hl
	call	pas_d_items
	call	texte_init_boutique
	ld		hl,TEXTE_BOUTIQUE_92_autres_ligne1
	jp		fin_piece_92

	
	
	
fin_piece_92
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	call	texte_init_boutique2	
	ret
	
	


;Master using it and you can have this.
TEXTE_BOUTIQUE_92_rien_ligne1
	DEFM      "YOU  WILL  NEED A  GAME"
TEXTE_BOUTIQUE_92_rien_ligne2
	DEFM      "FOR GX4000! DOUCHEBAG !"
TEXTE_BOUTIQUE_92_rien_ligne3
	DEFM      "               "
	
TEXTE_BOUTIQUE_92_sci_ligne1
	DEFM      "IT'S THE ONLY ONE COPIE"
TEXTE_BOUTIQUE_92_sci_ligne2
	DEFM      "  IN THE WHOLE WORLD ! "
TEXTE_BOUTIQUE_92_sci_ligne3
	DEFM      "             "	

TEXTE_BOUTIQUE_92_pang_ligne1
	DEFM      "HEY ! IT'S THE GAME I  "
TEXTE_BOUTIQUE_92_pang_ligne2
	DEFM      "WAS LOOKING FOR,THANK U"
TEXTE_BOUTIQUE_92_pang_ligne3
	DEFM      "             "	

TEXTE_BOUTIQUE_92_burningrubber_ligne1
	DEFM      " OHHH ! NOT  SO  QUICK "
TEXTE_BOUTIQUE_92_burningrubber_ligne2
	DEFM      "WELL OK, GET THAT !    "
TEXTE_BOUTIQUE_92_burningrubber_ligne3
	DEFM      "             "	

TEXTE_BOUTIQUE_92_noexit_ligne1
	DEFM      "THIS SHITTY GAME ??????"
TEXTE_BOUTIQUE_92_noexit_ligne2
	DEFM      "NO WAY !!!!!!          "
TEXTE_BOUTIQUE_92_noexit_ligne3
	DEFM      "PUNITION  !! "	

TEXTE_BOUTIQUE_92_autres_ligne1
	DEFM      "I AM NOT INTERESTED !  "
TEXTE_BOUTIQUE_92_autres_ligne2
	DEFM      "                       "
TEXTE_BOUTIQUE_92_autres_ligne3
	DEFM      "             "	



on_se_teleporte_CO	
	ld		a,(flag_porte_au_loin)
	or		a
	RET		nz
	ld		a,(No_PIECE)
	cp		104
	jp		z,on_va_en_piece_05
	cp		05
	jp		z,on_va_en_piece_104
	

on_va_en_piece_104
	LD		hl,224				; les portes et passage sont à different endroit
	ld		(posx_spr0_boutique),hl				; on sauvegarde la dernière position de link
	LD		hl,208				; afin d'y revenir une fois sortit de la boutique
	ld		(posy_spr0_boutique),hl
	
	ld		hl,PIECE104
	ld		(RETOUR_PIECE_ACTUELLE),HL
	ld		a,#c7
	ld		(No_BANK_RETOUR),A
	ld		a,104
	ld		(No_PIECE),a
	call	calcul_radar
	ld		hl,#E146
	ld  	(gps),hl
	ld		a,1
	ld		(flag_calcul),a
	ld		(flag_porte_au_loin),a
	
	CALL 	AFFICHAGE_GPS
	RET
	
on_va_en_piece_05
	LD		hl,224				; les portes et passage sont à different endroit
	ld		(posx_spr0_boutique),hl				; on sauvegarde la dernière position de link
	LD		hl,208				; afin d'y revenir une fois sortit de la boutique
	ld		(posy_spr0_boutique),hl
	ld		hl,PIECE05
	ld		(RETOUR_PIECE_ACTUELLE),HL
	ld		a,#c6
	ld		(No_BANK_RETOUR),A		; on la sauvegarde pour y revenir
	ld		a,5
	ld		(No_PIECE),a
	call	calcul_radar
	ld		hl,#C20B
	ld		(gps),hl
	xor		a
	ld		(flag_calcul),a
	ld		a,1
	ld		(flag_porte_au_loin),a
	CALL 	AFFICHAGE_GPS
	RET

link_est_nu2

	call	c4_off
	LD		hl,LINK4_SPR						; on met le type de link dans une variable générale.
	LD		(LINK_ADR),hl
	ld		hl,Table_type_link+80				; on va lire la table des sprite de link tout nu ligne (7)
	ld		de,Table_type_link					; on la copie vers la 1ere ligne 
	ld		bc,24								; on copie 24 octets incluant les attacks
	LDIR
	ld		hl,table_type_arme+8				; on lit la table de la bite de link
	ld		de,table_type_arme					; on la copie vers la 1ere ligne
	ld		bc,8								; on copie 8 octets 
	LDIR
ld		hl,12
ld		(decalage_epee_gauche),hl
ld		hl,-12
ld		(decalage_epee_droite),hl
ld		hl,2
ld		(decalage_epee_haut),hl
ld		hl,-2
ld		(decalage_epee_bas),hl

	
ret



OBJETS_ALEATOIRES_HYRULE
DW	RUBI_1,AUCUN,RUBI_1,AUCUN,RUBI_11,RUBI_1,AUCUN,RUBI_11
DW	AUCUN,RUBI_1,BOMBE_3,AUCUN,RUBI_1,MONTRE_5,CHAMPI_VERT_8,AUCUN
DW  RUBI_1,MONTRE_5,AUCUN,BOMBE_3,RUBI_1,AUCUN,CHAMPI_POURRIT_10,AUCUN
DW  RUBI_11,RUBI_1,AUCUN,RUBI_11,AUCUN,RUBI_1,BOMBE_3,AUCUN,CHAMPI_VERT_8
DW	RUBI_1,RUBI_11,CHAMPI_POURRIT_10,AUCUN,RUBI_1,MONTRE_5,AUCUN,RUBI_11,CHAMPI_ROUGE_7
DW	RUBI_1,RUBI_12,RUBI_1,AUCUN,MONTRE_5,RUBI_1,AUCUN,RUBI_11
DW	AUCUN,RUBI_1,BOMBE_3,AUCUN,RUBI_1,RUBI_11,CHAMPI_VERT_8,AUCUN
DW  RUBI_12,CHAMPI_POURRIT_10,AUCUN,BOMBE_3,RUBI_1,AUCUN,RUBI_12,AUCUN,CHAMPI_VERT_8
DW  RUBI_11,RUBI_1,AUCUN,MONTRE_5,AUCUN,RUBI_12,BOMBE_3,AUCUN
DW	RUBI_1,MONTRE_5,CHAMPI_ROUGE_7,AUCUN,CHAMPI_POURRIT_10,MONTRE_5,AUCUN,RUBI_11
DW	RUBI_11,RUBI_12,RUBI_11,MONTRE_5,AUCUN,RUBI_12,AUCUN,VIANDE_6
DW	#FFFF

OBJETS_ALEATOIRES_DONJON
DW	RUBI_1,AUCUN,RUBI_1,AUCUN,MONTRE_5,RUBI_1,CLE_4,RUBI_11
DW	AUCUN,RUBI_1,BOMBE_3,CLE_4,RUBI_1,RUBI_11,BOMBE_3,AUCUN
DW  RUBI_1,MONTRE_5,CLE_4,BOMBE_3,RUBI_12,AUCUN,RUBI_1,AUCUN
DW  RUBI_11,RUBI_1,AUCUN,RUBI_11,AUCUN,RUBI_1,BOMBE_3,RUBI_12
DW	RUBI_1,RUBI_11,BOMBE_3,CLE_4,RUBI_1,MONTRE_5,AUCUN,RUBI_11
DW	RUBI_1,CLE_4,RUBI_12,AUCUN,RUBI_11,RUBI_1,AUCUN,MONTRE_5
DW	AUCUN,RUBI_1,BOMBE_3,MONTRE_5,RUBI_12,RUBI_11,BOMBE_3,CLE_4
DW  RUBI_12,BOMBE_3,AUCUN,BOMBE_3,RUBI_1,CLE_4,RUBI_1,AUCUN
DW  RUBI_11,RUBI_12,AUCUN,MONTRE_5,CLE_4,RUBI_1,BOMBE_3,AUCUN
DW	RUBI_12,MONTRE_5,BOMBE_3,CLE_4,RUBI_1,MONTRE_5,AUCUN,RUBI_11
DW	RUBI_11,RUBI_12,MONTRE_5,RUBI_11,CLE_4,AUCUN,MONTRE_5,VIANDE_6
DW	#FFFF


OBJETS_ALEATOIRES_OCEAN
DW	RUBI_12,AUCUN,RUBI_12,AUCUN,RUBI_12,RUBI_12,RUBI_12,RUBI_12
DW	AUCUN,RUBI_12,CHAMPI_POURRIT_10,RUBI_12,RUBI_12,RUBI_12,CHAMPI_POURRIT_10,AUCUN
DW  RUBI_12,CHAMPI_ROUGE_7,RUBI_12,CHAMPI_POURRIT_10,RUBI_12,AUCUN,RUBI_12,AUCUN
DW  RUBI_12,RUBI_12,AUCUN,RUBI_12,AUCUN,RUBI_12,CHAMPI_POURRIT_10,RUBI_12
DW	RUBI_12,RUBI_12,CHAMPI_POURRIT_10,RUBI_12,RUBI_12,CHAMPI_ROUGE_7,AUCUN,RUBI_12
DW	RUBI_12,RUBI_12,RUBI_12,AUCUN,RUBI_12,RUBI_12,AUCUN,RUBI_12
DW	AUCUN,RUBI_12,CHAMPI_POURRIT_10,CHAMPI_ROUGE_7,RUBI_12,RUBI_12,CHAMPI_POURRIT_10,RUBI_12
DW  RUBI_12,CHAMPI_POURRIT_10,AUCUN,CHAMPI_POURRIT_10,RUBI_12,RUBI_12,RUBI_12,AUCUN
DW  RUBI_12,RUBI_12,AUCUN,RUBI_12,RUBI_12,RUBI_12,CHAMPI_POURRIT_10,AUCUN
DW	RUBI_12,RUBI_12,CHAMPI_POURRIT_10,RUBI_12,RUBI_12,CHAMPI_ROUGE_7,AUCUN,RUBI_12
DW	RUBI_12,RUBI_12,CHAMPI_ROUGE_7,RUBI_12,RUBI_12,AUCUN,CHAMPI_ROUGE_7,VIANDE_6
DW	#FFFF

