Initialisation_du_jeu_ROM

	xor		a
	ld		(nbr_cle),a
	ld		hl,0
	ld		(nbr_rubi),hl
	ld		(nbr_bombe),hl
	
	
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////// POSITIONNEMENT de L'ECRAN ///////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
	LD 		BC,#BC01:OUT (C),C			; rognage du bord droit de 16 caracteres (32 octets)
	LD 		BC,#BD00+32:OUT (C),C	
	LD 		BC,#BC02:OUT (C),C			; on pousse l'ecran vers la droite pour le recentrer
	LD 		BC,#BD00+42:OUT (C),C	
	LD 		BC,#BC07:OUT (C),C			; on decale l'ecran vers le haut 
	LD 		BC,#BD00+35:OUT (C),C	
	LD 		BC,#BC06:OUT (C),C			; on agrandit l'ecran vers le bas	
	LD 		BC,#BD00+32:OUT (C),C	

; on active l'event de Link présent dans la boucle principale
	ld		a,#CD
	ld		(event_link),a
	ld		hl,link
	ld		(event_link+1),hl
	ld		a,ZOOM_normal
	ld		(SPRH_TYPE_ZOOM),a
	
; Le jeu demarre avec 3 vies (6 demis coeur)
	ld		a,6
	ld		(nbr_vies),a
	ld		(nbr_vies_max),a
	ld		a,1
	ld		(flag_vie_parite),a				; on demarre avec un nombre de vies paire
	ld		hl,Table_adresse_ecran
	ld		(pointeur_table_vie),hl
	
; Le jeu demarre avec aucune armes
	xor		a
	ld		(compteur_link_touche),a
	ld		(objet_hud_fire2),a
	ld		(objet_hud_fire1),a	
; on initialise les collisions bord ecran hyrule
ld	hl,#FFFC									; #FFFC pour vitesse -4 ////// #FFF0 pour vitesse -8
ld	(bord_gauche),hl
ld	hl,#01D2									;  #01E4 pour vitesse  4 ////// #01D2 pour vitesse 8 et 2
ld	(bord_droit),hl
ld	hl,#0050									;  #004E pour vitesse -2 ////// #0050 pour vitesse -4
ld	(bord_haut),hl
ld	hl,#00F0									;  #00F0 pour vitesse 2 /////// #00EE pour vitesse 4
ld	(bord_bas),hl		

; vitesse de deplacement de link
ld	hl,-2
ld	(vitesse_link_gauche),hl
ld	hl,2
ld	(vitesse_link_droite),hl
ld	hl,-1
ld	(vitesse_link_haut),hl
ld	hl,1
ld	(vitesse_link_bas),hl

; vitesse de rétablisseement de link après collision
ld	a,2
ld	(vitesse_link_X),a
ld	a,1
ld	(vitesse_link_Y),a


; on initialise le placement le Link apres changement de piece dans HYRULE
ld	hl,#0000
ld	(link_a_gauche),hl
ld	hl,#01E0
ld	(link_a_droite),hl
ld	hl,#0050
ld	(link_en_haut),hl
ld	hl,#00EE
ld	(link_en_bas),hl


ld		a,longueur_recul_monstre	
ld		(compteur_de_recul),a

ld		hl,PALETTE_HUD	
ld		(type_de_palette2),hl

ld		hl,PALETTE_HYRULE
ld		(type_de_palette),hl




; on initialise le numero des tiles caché pour hyrule (different dans les donjons)
	ld		a,8								; design une tile d'escalier vert
	ld		(no_tile_a_ecrire),a			; utilisé dans hyrule
	ld		hl,tile_escalier_vert_adr
	ld 		(tile_a_ecrire),hl
	
	LD		hl,1							; design une tile de porte noir
	ld		(no_tile_a_ecrire2),hl			; utilisé dans hyrule
	ld		hl,tile_grotte_hyrule_adr
	ld 		(tile_a_ecrire2),hl
; on initialise le déplacement du radar
	ld	hl,-1
	ld	(dep_gps_gauche),hl
	ld	hl,1
	ld	(dep_gps_droite),hl
	
	ld	hl,#2000
	ld	(dep_gps_haut_1),hl
	ld	hl,#1fc0
	ld	(dep_gps_haut_2),hl
	
	ld	hl,#2000
	ld	(dep_gps_bas_1),hl
	ld	hl,#1fc0
	ld	(dep_gps_bas_2),hl; on initialise la position du radar

	ld	hl,HYRULE_GPS_PIECE01						; point de depart fixe du jeu correspond a la piece 1
	ld	(hl),PIXEL_VERT						; on poke un pixel rose a l'adresse
	ld	(gps),hl		
	ld	hl,HYRULE_GPS_PIECE01+#800						; on va epaissir un peu le carre
	ld 	(hl),PIXEL_VERT
	ld	a,PIXEL_MARRON_HAUT
	ld	(couleur_fond_gps),a
	ld	a,PIXEL_MARRON_BAS
	ld	(couleur_fond2_gps),a
	ld	a,PIXEL_VERT
	ld	(couleur_link_gps),a
	ld	hl,OBJETS_ALEATOIRES_HYRULE
	ld	(pointeur_objets_aleatoires),hl
	
; Le jeu demarre avec la piece numero 01
	call	C6_on
	LD		A,#C6						; ------>   à l'origine #C6 pour Hyrule   <------
	LD 		(No_BANK),A
	LD 		HL,PIECE01+18				 ;le jeu demarre on est dans la piece 1 
	LD 		(PIECE_ACTUELLE),HL			; on met l'adresse de la piece  dans HL pour afficher la piece 
	LD 		A,1
	LD		(No_PIECE),A
	call	objet_en_cas_de_gameover
	call	c5_off
	call	c0_on
	CALL	CHEAT_MODE
	RET
	

	
objet_en_cas_de_gameover
	call	asic_off
	call	c5_on
	ld		hl,MEM_TAMPON_ETAT_GAMEOVER
	ld		a,(hl)
	cp		a,2
	RET		NZ

	LD		hl,MEM_TAMPON_GAMEOVER
	LD		de,FLAG_GAMEOVER
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
	LDI:LDI
	
		call	c0_on
		call	asic_on
		ld			a,(flag_bague)
		cp			a,1
		call		z,debloquer_passage_invisible	
		ld			a,(flag_bague2)
		cp			a,1
		call		z,debloquer_passage_invisible2
		ld			a,(flag_triforce_1)
		cp			a,1
		call		z,retabli_triforce_1_inventaire
		ld			a,(flag_triforce_2)
		cp			a,1
		call		z,retabli_triforce_2_inventaire
		ld			a,(flag_triforce_3)
		cp			a,1
		call		z,retabli_triforce_3_inventaire
		ld			a,(flag_triforce_4)
		cp			a,1
		call		z,retabli_triforce_4_inventaire
		call		quel_donjon_est_ok
		ld			a,(flag_baton)
		cp			a,1
		call		z,debloquer_donjon4
		RET
	
	
	
quel_donjon_est_ok
		ld		a,(flag_porte_donjon_1)
		cp		a,1
		jp		z,debloquer_donjon1
		ld		a,(flag_porte_donjon_2)
		cp		a,1
		jp		z,debloquer_donjon2
		ld		a,(flag_porte_donjon_3)
		cp		a,1
		jp		z,debloquer_donjon3
		ret
	
	
debloquer_tous_les_donjons
debloquer_donjon1
	call	asic_off
	call	c6_on
	LD		HL,#786D		
	ld		a,072						
	ld		(HL),a						
	call	c6_off
	call	c0_on
	call	asic_on
	ld		a,(flag_donjon1_ouvert)
	or		a
	call	nz,le_donjon_a_ete_ouvert
	RET
debloquer_donjon2
	call	asic_off
	call	c6_on
	LD		HL,#6f55		
	ld		a,072						
	ld		(HL),a						
	call	c6_off
	call	c0_on
	call	asic_on
	ld		a,(flag_donjon2_ouvert)
	or		a
	call	nz,le_donjon_a_ete_ouvert
	RET
debloquer_donjon3
	call	asic_off
	call	c7_on
	LD		HL,#5043		
	ld		a,072						
	ld		(HL),a
	inc		hl
	ld		(HL),a
	call	c7_off
	call	c0_on
	call	asic_on
	ld		a,(flag_donjon3_ouvert)
	or		a
	call	nz,le_donjon_a_ete_ouvert
	ret
debloquer_donjon4
	call	asic_off
	call	c6_on
	LD		HL,#58AA		
	ld		a,072						
	ld		(HL),a						
	call	c6_off
	call	c0_on
	call	asic_on
	ret
		
debloquer_teleporteur		
	call	asic_off
	call	c6_on
	LD		HL,#4363		
	ld		a,2						; je choisit la tile 001
	ld		(HL),a
	call	c7_on	
	LD		HL,#5102		
	ld		a,11									; je choisit la tile 001
	ld		(HL),a	
	call	c7_off
	call	c0_on
	call	asic_on
	ret
debloquer_passage_invisible
	call	asic_off
	call	c7_on
	LD		HL,#40DB		
	ld		a,roche_marron_passage						; je choisit la tile 001
	ld		(HL),a						; et  l'écrit à l'adresse
	LD		HL,#40EB		
	ld		a,roche_marron_passage						; je choisit la tile 001
	ld		(HL),a						; et  l'écrit à l'adresse	
	call	c0_on
	call	asic_on
	call	debloquer_teleporteur
	ret
debloquer_passage_invisible2
	call	asic_off
	call	c6_on
	LD		HL,#5dE7		
	ld		a,075						; je choisit la tile 016
	ld		(HL),a						; et  l'écrit à l'adresse
	LD		HL,#5df7		
	ld		a,075						; je choisit la tile 016
	ld		(HL),a						; et  l'écrit à l'adresse
	LD		HL,#5e07		
	ld		a,074						; je choisit la tile 016
	ld		(HL),a						; et  l'écrit à l'adresse
	call	c6_off
	call	asic_on
	ret
retabli_triforce_1_inventaire
	ld		hl,INVENTAIRE_MAPTILE+18
	ld		a,17
	ld		(hl),a
	inc		a
	inc		l 
	ld		(hl),a
	ret
retabli_triforce_2_inventaire
	ld		hl,INVENTAIRE_MAPTILE+33
	ld		a,35
	ld		(hl),a
	inc		a
	inc		l 
	ld		(hl),a
	inc		a
	inc		l 
	ld		(hl),a
	inc		a
	inc		l 
	ld		(hl),a
	ret
retabli_triforce_3_inventaire
	ld		hl,INVENTAIRE_MAPTILE+48
	ld		a,28
	ld		(hl),a
	inc		a
	inc		l 
	ld		(hl),a
	inc		a
	inc		l 
	ld		(hl),a
	ret
retabli_triforce_4_inventaire
	ld		hl,INVENTAIRE_MAPTILE+51
	ld		a,31
	ld		(hl),a
	inc		a
	inc		l 
	ld		(hl),a
	inc		a
	inc		l 
	ld		(hl),a
	ret
	
le_donjon_a_ete_ouvert
			ld	a,1
			ld	(flag_cle_donjon),a
			ret

link_est_invulnerable
ld		a,#C9						; RET
ld		(link_touche),a
ret

link_est_nu
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
ld		hl,12
ld		(decalage_epee_gauche),hl
ld		hl,-12
ld		(decalage_epee_droite),hl
ld		hl,2
ld		(decalage_epee_haut),hl
ld		hl,-2
ld		(decalage_epee_bas),hl

	
ret


CHEAT_MODE
	;call	link_est_nu
	;call	link_est_invulnerable
	;call debloquer_donjon1
	;call debloquer_donjon2
	;call debloquer_donjon3
	;call debloquer_donjon4
	;call debloquer_teleporteur
	;call debloquer_passage_invisible
	;ld		hl,SPRH_SCI_ADR
	;ld		(SPRH_JEU_ADR),hl

	ld		a,1
	ld		(flag_rien),a
	
	;ld		(flag_epee_01),a
	;ld		(flag_bombe),a
	;ld		(flag_fleche),a
	;ld		(flag_arc_et_fleche),a
	;ld		(flag_bougie),a
	;ld		(flag_flute),a
	;ld		(flag_viande),a
	;ld		(flag_parchemin),a
	;ld		(flag_fiole_rouge),a
	;ld		(flag_echelle),a
	;ld		(flag_radeau),a
	;ld		(on_peut_utiliser_le_radeau),a
	;ld		(flag_cle_donjon),a
	;ld		(flag_bague),a
	;ld		(flag_bague2),a
	;ld		(flag_game),a
	;ld		(flag_pang),a
	;ld		(flag_sci),a
	;ld		(flag_burningrubber),a
	;ld		(flag_noexit),a
	;ld		(flag_wildstreet),a
	;ld		(flag_tintin),a
	;ld 		(flag_baton),a
	;ld		(flag_triforce_1),a
	;ld		(flag_boss1_RIP),a
	;ld		(flag_boss2_RIP),a
	;ld		(flag_boss3_RIP),a
	;ld		(flag_triforce_2),a
	;ld		(flag_triforce_3),a
	;ld		(flag_triforce_4),a
	;ld		(flag_boss4_RIP),a
	;ld		(flag_stop_monstres),a
RET

