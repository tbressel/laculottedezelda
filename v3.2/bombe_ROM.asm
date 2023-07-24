fin_bombe_ROM
	xor		a
	LD		(event_bombe),a
	LD		(event_bombe+1),a
	LD		(event_bombe+2),a
	LD		(event_bombe_dodongo),a
	LD		(event_bombe_dodongo+1),a
	LD		(event_bombe_dodongo+2),a
	LD		(SPRH3_ZOOM),a
	ld		(flag_sprh3),a
	ld		(flag_fire2),a
	ld		(une_bombe_est_en_cours),a
	call	flag_hyrule_on
	ld		(flag_stop_monstres),a


; ///////////////////////////////////////////////  TEST DES GROTTES //////////////////////////
	Or		A
	ld		B,test_tile_entree_arbre_sable				; ou grotte haut pour les donjons
	LD		A,(ntile_spr3)	
	SBC	A,B
	JP		Z,affiche_grotte
	
	Or		A
	ld		B,test_tile_entree_arbre_herbe				; ou grotte bas pour les donjons
	LD		A,(ntile_spr3)	
	SBC		A,B
	JP		Z,affiche_grotte
	
	Or		A
	ld		B,test_tile_entree_arbre_marron				; ou grotte gauche pour les donjons
	LD		A,(ntile_spr3)	
	SBC		A,B
	JP		Z,affiche_grotte
	
	Or		A
	ld		B,roche_neige						; pour les donjons  : no d'une tile d'un mur droite
	LD		A,(ntile_spr3)	
	SBC		A,B
	JP		Z,affiche_grotte
	
	Or		A
	ld		B,roche_marron_vert
	LD		A,(ntile_spr3)	
	SBC		A,B
	JP		Z,affiche_grotte
	
	Or		A	
	ld		B,roche_marron
	LD		A,(ntile_spr3)	
	SBC		A,B
	JP		Z,affiche_grotte
	
	Or		A	
	ld		B,test_tile_grotte_roche_marron
	LD		A,(ntile_spr3)	
	SBC		A,B
	JP		Z,affiche_grotte
	
	
; ///////////////////////////////////////////////  TEST DES PASSAGE AVEC ESCALIER //////////////////////////
	Or		A
	ld		B,242
	LD		A,(ntile_spr3)
	SBC		A,B
	JP		Z,affiche_passage
	
	ld		B,248
	LD		A,(ntile_spr3)
	SBC		A,B
	JP		Z,affiche_passage
	
	ld		B,250
	LD		A,(ntile_spr3)	
	SBC		A,B
	JP		Z,affiche_passage
	
	JP		retour_grotte
	
	
	
	
quel_type_de_tile
	ld		a,(flag_donjon)
	cp		a,1
	ret		Z
	ld		a,(No_PIECE)
	cp		a,2
	jp		z,tile_type_arbre_herbe
	cp		a,26
	jp		z,tile_type_arbre_herbe
	cp		a,28
	jp		z,tile_type_arbre_herbe

		ld		hl,1
		ld		(no_tile_a_ecrire2),hl
		ld		hl,tile_grotte_hyrule_adr
		ld 		(tile_a_ecrire2),hl
		ret	

		tile_type_arbre_herbe
			ld		hl,tile_entree_arbre_herbe
			ld		(no_tile_a_ecrire2),hl
			ld		hl,tile_arbre_herbe_hyrule_adr
			ld 		(tile_a_ecrire2),hl
			ret	

		tile_type_arbre_sable
			ld		hl,tile_entree_arbre_sable
			ld		(no_tile_a_ecrire2),hl
			ld		hl,tile_arbre_sable_hyrule_adr
			ld 		(tile_a_ecrire2),hl
			ret		
		