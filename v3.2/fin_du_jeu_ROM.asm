le_lit_de_zelda_ROM
	LD		a,#CD								; sinon on créer l'venement monstre 1
	LD		(event_gameover),a
	LD		hl,link_defonce_zelda
	LD		(event_gameover+1),hl
	ret


init_link_nu_ROM
	call 	asic_on
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
	xor	a
	ld		(event_objets_hyrule),a
	ld		(event_objets_hyrule+1),a
	ld		(event_objets_hyrule+2),a
	ld		a,1
	ld		(etape_zelda),a
	ld		hl,12
ld		(decalage_epee_gauche),hl
ld		hl,-12
ld		(decalage_epee_droite),hl
ld		hl,2
ld		(decalage_epee_haut),hl
ld		hl,-2
ld		(decalage_epee_bas),hl
	RET
	
link_chasse_ROM
	ld		a,(flag_mario_nu)
	cp		a,1
	jp		z,texte_mario
	ld		hl,(nombre_de_coups_1)
	ld		a,h
	cp		140
	jp		z,affiche_descendence_1
	cp		120
	jp		z,affiche_descendence_2
	cp		100
	jp		z,affiche_descendence_3
	cp		80
	jp		z,affiche_descendence_4
	cp		60
	jp		z,affiche_descendence_5
	cp		40
	jp		z,affiche_descendence_6
	cp		20
	jp		z,affiche_descendence_7
	cp		0
	jp		z,reactive_recul_mario
	ret

affiche_descendence_1
	ld		hl,PETIT_TODD_3_ADR
	ld		(SPRH_DESCENDENCE),hl
	ld		hl,SPRH6_ADR
	ld		(SPRH_DESCENDENCE_ADR),hl
	ld		hl,128
	ld		(SPRH6_X),hl
	ld		hl,144
	ld		(SPRH6_Y),hl
	ld		hl,SPRH6_ZOOM
	ld		(SPRH_DESCENDENCE_ZOOM),hl
	ld		a,1
	ld		(flag_affiche_heritier),a
	RET
	
affiche_descendence_2
	ld		hl,PETIT_TODD_1_ADR
	ld		(SPRH_DESCENDENCE),hl
	ld		hl,SPRH7_ADR
	ld		(SPRH_DESCENDENCE_ADR),hl
	ld		hl,64
	ld		(SPRH7_X),hl
	ld		hl,176
	ld		(SPRH7_Y),hl
	ld		hl,SPRH7_ZOOM
	ld		(SPRH_DESCENDENCE_ZOOM),hl
	ld		a,1
	ld		(flag_affiche_heritier),a
	RET
affiche_descendence_3
	ld		hl,PETIT_TODD_2_ADR
	ld		(SPRH_DESCENDENCE),hl
	ld		hl,SPRH8_ADR
	ld		(SPRH_DESCENDENCE_ADR),hl
	ld		hl,160
	ld		(SPRH8_X),hl
	ld		hl,192
	ld		(SPRH8_Y),hl
	ld		hl,SPRH8_ZOOM
	ld		(SPRH_DESCENDENCE_ZOOM),hl
		ld		a,1
	ld		(flag_affiche_heritier),a
	RET
affiche_descendence_4
	ld		hl,PETIT_TODD_3_ADR
	ld		(SPRH_DESCENDENCE),hl
	ld		hl,SPRH9_ADR
	ld		(SPRH_DESCENDENCE_ADR),hl
	ld		hl,384
	ld		(SPRH9_X),hl
	ld		hl,208
	ld		(SPRH9_Y),hl
	ld		hl,SPRH9_ZOOM
	ld		(SPRH_DESCENDENCE_ZOOM),hl
		ld		a,1
	ld		(flag_affiche_heritier),a
	RET
affiche_descendence_5
	ld		hl,PETIT_TODD_2_ADR
	ld		(SPRH_DESCENDENCE),hl
	ld		hl,SPRH10_ADR
	ld		(SPRH_DESCENDENCE_ADR),hl
	ld		hl,256	
	ld		(SPRH10_X),hl
	ld		hl,192
	ld		(SPRH10_Y),hl
	ld		hl,SPRH10_ZOOM
	ld		(SPRH_DESCENDENCE_ZOOM),hl
		ld		a,1
	ld		(flag_affiche_heritier),a
	RET
affiche_descendence_6
	ld		hl,PETIT_TODD_1_ADR
	ld		(SPRH_DESCENDENCE),hl
	ld		hl,SPRH11_ADR
	ld		(SPRH_DESCENDENCE_ADR),hl
	ld		hl,288
	ld		(SPRH11_X),hl
	ld		hl,144
	ld		(SPRH11_Y),hl
	ld		hl,SPRH11_ZOOM
	ld		(SPRH_DESCENDENCE_ZOOM),hl
		ld		a,1
	ld		(flag_affiche_heritier),a
	RET
affiche_descendence_7
	ld		hl,PETIT_TODD_3_ADR
	ld		(SPRH_DESCENDENCE),hl
	ld		hl,SPRH12_ADR
	ld		(SPRH_DESCENDENCE_ADR),hl
	ld		hl,128
	ld		(SPRH12_X),hl
	ld		hl,208
	ld		(SPRH12_Y),hl
	ld		hl,SPRH12_ZOOM
	ld		(SPRH_DESCENDENCE_ZOOM),hl
	ld		a,1
	ld		(flag_affiche_heritier),a
	RET

reactive_recul_mario
	xor	a
	ld		(flag_zelda),a
	ld		a,1
	ld		(flag_premort),a
	; si link ne tue pas le monstre celui ci recul
	ld		a,1
	ld		(flag_monstre_1_touche),a				; la première fois qu'on passe ici le monstre est touché et immobilisé	
	ld		a,#CD									; on créer l'évenement du recul dans la boucle	
	ld		(event_recul_du_montre),a
	ld		hl,on_fait_reculer_le_monstre
	ld		(event_recul_du_montre+1),hl
	ld		a,(identification_monstre_en_cours)		; on recupère de quel monstre il s'agit
	ld		(monstre_a_faire_reculer),a				; et on stock lequel devra reculer 
	ld		a,(direction_en_cours)					; on recupère la direction de link
	ld		(direction_du_recul),a					; qui correspond à la direction du recul
	
	ld		hl,SPRH5_X
	ld		(recul_X_monstre),hl
	ld		hl,SPRH5_Y
	ld		(recul_Y_monstre),hl
	ld		hl,(SPRH_X)
	ld		(SPRH_X_recul),hl
		ld		hl,(SPRH_Y)
	ld		(SPRH_Y_recul),hl
	ret




texte_mario
	call 	test_de_touche_on
	call	bas_on
	call 	gauche_on
	call	droite_on
	ld		a,1
	ld		(flag_texte),a
	Ld 		a,#cd				; affiche un jp
	ld 		(event_texte),a
	ld 		hl,affiche_texte
	ld 		(event_texte+1),hl
	call	texte_init_mario_link
	ld		hl,TEXTE_BOUTIQUE_MARIO_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	ld		a,1
	ld		(attente_vers_la_fin),a
	ret
	
	
texte_init_mario_link
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
	
	
		
TEXTE_BOUTIQUE_MARIO_ligne1
	DEFM      "AIIIIiiiie, J'AI LE CUL"
TEXTE_BOUTIQUE_MARIO_ligne2
	DEFM      "RAVAGE !! VOICI NOTRE  "
TARIF_BOUTIQUE_MARIO
	DEFM      "DESCENDANCE ..."	
	
	
	
position_levrette_ROM
	
	ld		a,1
	ld		(compteur_gros_link),a
	ld		a,5
	LD		(flag_etape_du_monstre1),a
	ld		hl,(SPRH0_X)
	ld		(SPRH5_X),hl
	ld		hl,(SPRH0_Y)
	ld		de,-15
	add	hl,de
	ld		(SPRH5_Y),hl
	;ld		a,ZOOM_gros
	;ld		(SPRH0_ZOOM),a
	;ld		(SPRH1_ZOOM),a
	;ld		(SPRH5_ZOOM),a
	call	bas_off
	call	gauche_off
	call	droite_off
	
	;xor		a
	;ld		(haut_jpz+3),a
	;ld		(haut_jpz+4),a
	;ld		(haut_jpz+5),a
	;ld		(haut_jpz+6),a
	;ld		(haut_jpz+7),a
	;ld		(haut_jpz+8),a
	;ld		(haut_jpz+9),a
	;ld		(haut_jpz+10),a
	;ld		(haut_jpz+11),a
	;ld		(haut_jpz+12),a
	;ld		(haut_jpz+13),a
	;ld		(haut_jpz+14),a
	;ld		(haut_jpz+15),a
	;ld		(haut_jpz+16),a
	;ld		(haut_jpz+17),a
	RET
	

