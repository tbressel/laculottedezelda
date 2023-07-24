; //////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////  ON ENTRE DANS LE DONJON   /////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
entree_donjon_ROM
	call		asic_on
	ld			a,1
	ld			(flag_donjon),a			; on signale qu'on est dans le donjon 1
		ld	hl,OBJETS_ALEATOIRES_DONJON
	ld	(pointeur_objets_aleatoires),hl
; ************** entrer et sortir du donjon en etant au bonnes coordonnes
											; et qu'au retour il faudra initialiser les coordonne X et Y
											; pour se situer a cote de la porte d'entree
	LD		hl,(SPRH0_X)					; les portes et passage sont à different endroit
	ld		(posx_spr0_donjon),hl			; on sauvegarde la dernière position de link
	LD		hl,(SPRH0_Y)					; afin d'y revenir une fois sortit de la boutique
	ld		(posy_spr0_donjon),hl

			; on positionne Link en bas au centre
			;	placement du perso a l'ecran
	LD		HL,#00DE			; c'est la que Link sera place
	LD		(SPRH0_Y),HL
	LD		(SPRH1_Y),HL
	LD		HL,236
	LD		(SPRH0_X),HL
	LD		(SPRH1_X),HL
	; on initialise les collisions bord ecran donjon
	ld			hl,#001D
	ld			(bord_gauche),hl
	ld			hl,#01C0
	ld			(bord_droit),hl
	ld			hl,#0064
	ld			(bord_haut),hl
	ld			hl,#00DE
	ld			(bord_bas),hl
	; on initialise le placement le Link apres changement de piece dans un DONJON
	ld			hl,#0024						; anciennement 001c
	ld			(link_a_gauche),hl
	ld			hl,#01b8						; anciennement 01c0
	ld			(link_a_droite),hl
	ld			hl,#0066
	ld			(link_en_haut),hl
	ld			hl,#00de
	ld			(link_en_bas),hl
	ld			a,1
	ld			(flag_champi_vert),a
	; vitesse de deplacement de link
ld	hl,-4
ld	(vitesse_link_gauche),hl
ld	hl,4
ld	(vitesse_link_droite),hl
ld	hl,-2
ld	(vitesse_link_haut),hl
ld	hl,2
ld	(vitesse_link_bas),hl
; vitesse de rétablisseement de link après collision
ld	a,4
ld	(vitesse_link_X),a
ld	a,2
ld	(vitesse_link_Y),a

	; on initialise le déplacement du radar
	ld		hl,-3
	ld		(dep_gps_gauche),hl
	ld		hl,3
	ld		(dep_gps_droite),hl
	
	ld			a,nbr_cycle_attente_monstre
	ld			(attente_naissance_des_monstres),a
	
		
	; on test de quelle piece on vient pour savoir de quel donjoon il s'agit
	ld		a,(No_BANK)
	ld		(No_BANK_RETOUR),a 
	ld		hl,(PIECE_ACTUELLE)
	ld		(RETOUR_PIECE_ACTUELLE),hl 		; on récupère AUSSITOT, JUSTE APRES la piece d'ou l'on vient
	ld		HL,(No_PIECE)
	ld		(No_PIECE_RETOUR),HL 		; on récupère AUSSITOT, JUSTE APRES la piece d'ou l'on vient										
	ld		a,l											
	cp			75
	JP			Z,donjon_1
	cp			63
	JP			Z,donjon_2
	cp			33
	JP			Z,donjon_3
	cp			103
	JP			Z,donjon_4
	

; //////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////  ON SORT DU DONJON   /////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
sortir_donjon_ROM
		ld	hl,OBJETS_ALEATOIRES_HYRULE
	ld	(pointeur_objets_aleatoires),hl
	call		asic_on
	xor			a
	ld			(flag_donjon),a			; on signale qu'on est dans le donjon 1	
	LD			HL,(posy_spr0_donjon)			; c'est la que Link sera place
	LD			(SPRH0_Y),HL
	LD			(SPRH1_Y),HL
	LD			HL,(posx_spr0_donjon)
	LD			(SPRH0_X),HL
	LD			(SPRH1_X),HL
	
; on initialise les collisions bord ecran hyrule
ld	hl,#FFFC									; #FFFC pour vitesse -4 ////// #FFF0 pour vitesse -8
ld	(bord_gauche),hl
ld	hl,#01E0									;  #01E4 pour vitesse  4 ////// #01D2 pour vitesse 8 et 2
ld	(bord_droit),hl
ld	hl,#004F									;  #004E pour vitesse -2 ////// #0050 pour vitesse -4
ld	(bord_haut),hl
ld	hl,#00F0									;  #00F0 pour vitesse 2 /////// #00EE pour vitesse 4
ld	(bord_bas),hl		
; on initialise le placement le Link apres changement de piece dans HYRULE
ld	hl,#0000
ld	(link_a_gauche),hl
ld	hl,#01E0
ld	(link_a_droite),hl
ld	hl,#0050
ld	(link_en_haut),hl
ld	hl,#00EE
ld	(link_en_bas),hl


	ld		hl,PALETTE_HYRULE
	ld		(type_de_palette),hl
; On reconfigure le radar et ses couleur	
	ld		hl,(save_gps_hyrule)
	ld		(gps),hl
	ld	a,PIXEL_MARRON_HAUT
	ld	(couleur_fond_gps),a
	ld	a,PIXEL_MARRON_BAS
	ld	(couleur_fond2_gps),a
	ld		a,PIXEL_VERT
	ld		(couleur_link_gps),a
	call	calcul_radar
	; on initialise le déplacement du radar
	ld		hl,-1
	ld		(dep_gps_gauche),hl
	ld		hl,1
	ld		(dep_gps_droite),hl
	
	ld		hl,#2000
	ld		(dep_gps_haut_1),hl
	ld		hl,#1fc0
	ld		(dep_gps_haut_2),hl
	
	ld		hl,#2000
	ld		(dep_gps_bas_1),hl
	ld		hl,#1fc0
	ld		(dep_gps_bas_2),hl				; on initialise la position du radar
	
; on test de quelle piece on vient pour savoir de quel donjoon il s'agit
	
	LD			hl,(RETOUR_PIECE_ACTUELLE)		; on precise ou est le donjon dans la map tiles
	LD			(PIECE_ACTUELLE),HL		; qui sera affiché à la prochain piece à afficher
	
	LD			A,(No_BANK_RETOUR)					; on precise la bank dans laquelle la maptile
	LD			(No_BANK),A				; se trouve pour la lecture des tiles.
	
	LD			hl,(No_PIECE_RETOUR)					; on précise qu'on est dans la pièce 129
	ld			(No_PIECE),hl
	
	
; on initialise le numero des tiles caché pour hyrule (different dans les donjons)
	ld		a,8								; design une tile d'escalier vert
	ld		(no_tile_a_ecrire),a			; utilisé dans hyrule
	ld		hl,tile_escalier_vert_adr
	ld 		(tile_a_ecrire),hl
	
	LD		a,1								; design une tile de porte noir
	ld		(no_tile_a_ecrire2),a			; utilisé dans hyrule
	ld		hl,tile_grotte_hyrule_adr
	ld 		(tile_a_ecrire2),hl
	xor		a
	LD		(event_objet_spawn_donjon),a
	LD		(event_objet_spawn_donjon+1),a
	LD		(event_objet_spawn_donjon+2),a
	LD		(event_objets_donjon),a
	LD		(event_objets_donjon+1),a
	LD		(event_objets_donjon+2),a
	LD		a,#CD								; sinon on créer l'venement monstre 1
	LD		(event_objets_hyrule),a
	LD		hl,objet_hyrule
	LD		(event_objets_hyrule+1),hl

ld	a,(flag_no_donjon) : cp	a,1 : call	z,donjon_1_termine
ld	a,(flag_no_donjon) : cp	a,2 : call	z,donjon_2_termine
ld	a,(flag_no_donjon) : cp	a,3 : call	z,donjon_3_termine
ld	a,(flag_no_donjon) : cp	a,4 : call	z,donjon_4_termine

; on remet dans les tile de l'inventaire la triforce gagné
call	asic_off
call 	c4_on
ld	a,(flag_triforce_1) : cp a,1 : 	call z,ajoute_triforce_1_inventaire
ld	a,(flag_triforce_2) : cp a,1 : 	call z,ajoute_triforce_2_inventaire
ld	a,(flag_triforce_3) : cp a,1 : 	call z,ajoute_triforce_3_inventaire
ld	a,(flag_triforce_4) : cp a,1 : 	call z,ajoute_triforce_4_inventaire
call	c4_off
call	asic_on	
RET


; ////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////   DONJON 1 ////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////
donjon_1
	ld			a,1
	ld			(No_DONJON),a
	ld			(flag_no_donjon),a
	ld			(flag_donjon1_ouvert),a
	xor			a
	LD			(event_objets_hyrule),a						; dans ce cas on à plus besoin de tester innutilement la pièce donc on efface l'event "event_objets_hyrule"
	LD			(event_objets_hyrule+1),a
	LD			(event_objets_hyrule+2),a
	ld			(flag_cle_donjon),a
	LD			hl,DONJON_1_129+18		; on precise ou est le donjon dans la map tiles
	LD			(PIECE_ACTUELLE),HL		; qui sera affiché à la prochain piece à afficher
	LD			A,#C7					; on precise la bank dans laquelle la maptile
	LD			(No_BANK),A				; se trouve pour la lecture des tiles.
	LD			A,129					; on précise qu'on est dans la pièce 129
	ld			(No_PIECE),A
	call	asic_off
	call	c6_on
	LD		HL,#786D		
	ld		a,071						; je choisit la tile 071 (porte ouverte)
	ld		(HL),a						
	call	c6_off
	call	asic_on
		
	
	; on initialise la palette du donjon 1	
	call 		asic_on	
	ld			hl,PALETTE_DONJON
	ld			(type_de_palette),hl
	
	ld			hl,#7028				; adresse en RAM du numero de tile du passage vers la cave
	ld			(tile_cave),hl
	ld			hl,(gps)
	ld			(save_gps_hyrule),hl
	ld			hl,DONJON_GPS_PIECE01
	ld			(gps),hl
	ld			hl,TRIFORCE_GPS_DONJON1
	ld			(boussole_de_ce_donjon_adr),hl
	ld			hl,boss_donjon_1
	ld			(boss_donjon_label),hl
	
	ld		a,(flag_carte_donjon1)
	or		a
	jr		nz,ok_carte_donjon1
	jr		pas_de_carte_donjon1
ok_carte_donjon1
	ld		hl,MAP_DONJON_1
	ld		(map_a_lire),hl
	ld		a,(flag_carte_donjon1)
	ld		(flag_carte_de_ce_donjon),a
	ld		(flag_ok_affiche_carte),a
	ld		a,PIXEL_BLEU
	ld		(couleur_fond_gps),a
	ld		(couleur_fond2_gps),a
	jr		fin_config_carte_donjon
pas_de_carte_donjon1
	ld		hl,MAP_DONJON_0
	ld		(map_a_lire),hl
	ld		a,1
	ld		(flag_ok_affiche_carte),a
	xor		a
	ld		a,(flag_carte_donjon1)
	ld		(flag_carte_de_ce_donjon),a
	ld		a,PIXEL_NOIR
	ld		(couleur_fond_gps),a
	ld		(couleur_fond2_gps),a
	ld		a,PIXEL_ORANGE
	ld		(couleur_link_gps),a
fin_config_carte_donjon
	ld		a,#C3
	ld		(event_objets_donjon),a
	ld		hl,objet_donjon_1
	ld		(objet_donjon_label),hl
	LD		(event_objets_donjon+1),hl	
	RET
donjon_1_termine
	ld	a,(flag_triforce_1)
	or	a
	call	nz,fermer_donjon_1
	ret
fermer_donjon_1   
	call	asic_off
	call	c6_on
	LD		HL,#786D		
	ld		a,198						; je choisit la tile 072 (porte fermé que l'on peut pas franchir)
	ld		(HL),a						
	call	c6_off
	call	asic_on

	ret
	
; ////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////   DONJON 2 ////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////
donjon_2
	ld			a,2
	ld			(No_DONJON),a
	ld			(flag_no_donjon),a
	ld			a,1
	ld			(flag_donjon2_ouvert),a
	xor		a
		LD		(event_objets_hyrule),a						; dans ce cas on à plus besoin de tester innutilement la pièce donc on efface l'event "event_objets_hyrule"
	LD		(event_objets_hyrule+1),a
	LD		(event_objets_hyrule+2),a
	ld			(flag_cle_donjon),a
	
	LD			hl,DONJON_2_147+18		; on precise ou est le donjon dans la map tiles
	LD			(PIECE_ACTUELLE),HL		; qui sera affiché à la prochain piece à afficher
	LD			A,#C7					; on precise la bank dans laquelle la maptile
	LD			(No_BANK),A				; se trouve pour la lecture des tiles.
	LD			A,147					; on précise qu'on est dans la pièce 129
	ld			(No_PIECE),A
	call	c6_on
	LD		HL,#6f55		
	ld		a,071						; je choisit la tile 071 (porte ouverte)
	ld		(HL),a						
	call	c6_off
	
	; On envoie la pallette CPC+ propre au donjon 2
	call 		asic_on	
	ld			hl,PALETTE_DONJON
	ld			(type_de_palette),hl
	ld			hl,#7028				; adresse en RAM du numero de tile du passage vers la cave
	ld			(tile_cave),hl
	ld			hl,(gps)
	ld			(save_gps_hyrule),hl
	ld			hl,DONJON_GPS_PIECE02

	ld			(gps),hl
	ld			hl,TRIFORCE_GPS_DONJON2
	ld			(boussole_de_ce_donjon_adr),hl
	ld			hl,boss_donjon_2
	ld			(boss_donjon_label),hl
	
	ld		a,(flag_carte_donjon2)
	or		a
	jr		nz,ok_carte_donjon2
	jr		pas_de_carte_donjon2
ok_carte_donjon2
	ld		hl,MAP_DONJON_2
	ld		(map_a_lire),hl
	ld		a,(flag_carte_donjon2)
	ld		(flag_carte_de_ce_donjon),a
	ld		(flag_ok_affiche_carte),a
	ld		a,PIXEL_BLEU
	ld		(couleur_fond_gps),a
	ld		(couleur_fond2_gps),a
	jr		fin_config_carte_donjon2
pas_de_carte_donjon2
	ld		hl,MAP_DONJON_0
	ld		(map_a_lire),hl
	ld		a,1
	ld		(flag_ok_affiche_carte),a
	xor		a
	ld		a,(flag_carte_donjon2)
	ld		(flag_carte_de_ce_donjon),a
		ld		a,PIXEL_NOIR
	ld		(couleur_fond_gps),a
	ld		(couleur_fond2_gps),a
	ld		a,PIXEL_ORANGE
	ld		(couleur_link_gps),a
fin_config_carte_donjon2
	ld		a,#C3
	ld		(event_objets_donjon),a
	ld		hl,objet_donjon_2
	ld		(objet_donjon_label),hl
	LD		(event_objets_donjon+1),hl	
	RET
donjon_2_termine
	ld	a,(flag_triforce_2)
	or	a
	call	nz,fermer_donjon_2
	ret
fermer_donjon_2   
	call	asic_off
	call	c6_on
	LD		HL,#6f55		
	ld		a,198						; je choisit la tile 072 (porte fermé que l'on peut franchir)
	ld		(HL),a						
	call	c6_off
	call	asic_on

	ret
; ////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////   DONJON 3 ////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////
donjon_3
	ld			a,3
	ld			(No_DONJON),a
	ld			(flag_no_donjon),a
	ld			a,1
	ld			(flag_donjon3_ouvert),a
	xor		a
	LD		(event_objets_hyrule),a						; dans ce cas on à plus besoin de tester innutilement la pièce donc on efface l'event "event_objets_hyrule"
	LD		(event_objets_hyrule+1),a
	LD		(event_objets_hyrule+2),a
	ld		(flag_cle_donjon),a
	LD		hl,DONJON_3_165+18		; on precise ou est le donjon dans la map tiles
	LD		(PIECE_ACTUELLE),HL		; qui sera affiché à la prochain piece à afficher
	LD		A,#C5					; on precise la bank dans laquelle la maptile
	LD		(No_BANK),A				; se trouve pour la lecture des tiles.
	LD		A,165					; on précise qu'on est dans la pièce 129
	ld		(No_PIECE),A
	call	asic_off
	call	c6_on
	LD		HL,#58AA		
	ld		a,071						; je choisit la tile 072 (porte fermé que l'on peut franchir)
	ld		(HL),a						
	call	c6_off
	call	asic_on
	; On envoie la pallette CPC+ propre au donjon 1	
	ld			hl,PALETTE_DONJON
	ld			(type_de_palette),hl
	
	ld			hl,#4741				; adresse en RAM du numero de tile du passage vers la cave
	ld			(tile_cave),hl
	ld			hl,(gps)
	ld			(save_gps_hyrule),hl
	ld			hl,DONJON_GPS_PIECE03
	ld			(gps),hl
	ld			hl,TRIFORCE_GPS_DONJON3
	ld			(boussole_de_ce_donjon_adr),hl
	ld			hl,boss_donjon_3
	ld			(boss_donjon_label),hl
	
	ld		a,(flag_carte_donjon3)
	or		a
	jr		nz,ok_carte_donjon3
	jr		pas_de_carte_donjon3
ok_carte_donjon3
	ld		hl,MAP_DONJON_3
	ld		(map_a_lire),hl
	ld		a,(flag_carte_donjon3)
	ld		(flag_carte_de_ce_donjon),a
	ld		(flag_ok_affiche_carte),a
	ld		a,PIXEL_BLEU
	ld		(couleur_fond_gps),a
	ld		(couleur_fond2_gps),a
	jr		fin_config_carte_donjon3
pas_de_carte_donjon3
	ld		hl,MAP_DONJON_0
	ld		(map_a_lire),hl
	ld		a,1
	ld		(flag_ok_affiche_carte),a
	xor		a
	ld		a,(flag_carte_donjon3)
	ld		(flag_carte_de_ce_donjon),a
	ld		a,PIXEL_NOIR
	ld		(couleur_fond_gps),a
	ld		(couleur_fond2_gps),a
	ld		a,PIXEL_ORANGE
	ld		(couleur_link_gps),a
fin_config_carte_donjon3
	ld		a,#C3
	ld		(event_objets_donjon),a
	ld		hl,objet_donjon_3
	ld		(objet_donjon_label),hl
	LD		(event_objets_donjon+1),hl
RET	
donjon_3_termine
	ld		a,(flag_triforce_3)
	or		a
	call	nz,fermer_donjon_3
	ret
fermer_donjon_3
	ld		a,(flag_radeau)
	or		a
	RET	Z   
	call	asic_off
	call	c6_on
	LD		HL,#58AA		
	ld		a,198						; je choisit la tile 072 (porte fermé que l'on peut franchir)
	ld		(HL),a						
	call	c6_off
	call	asic_on
	RET
; ////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////   DONJON 4 ////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////
donjon_4
	ld			a,4
	ld			(No_DONJON),a
	ld			(flag_no_donjon),a
	ld			a,1
	ld			(flag_donjon4_ouvert),a
	xor			a
	LD			(event_objets_hyrule),a						; dans ce cas on à plus besoin de tester innutilement la pièce donc on efface l'event "event_objets_hyrule"
	LD			(event_objets_hyrule+1),a
	LD			(event_objets_hyrule+2),a
	ld			(flag_cle_donjon),a
	ld			(flag_calcul),a
	LD			hl,DONJON_4_184+18		; on precise ou est le donjon dans la map tiles
	LD			(PIECE_ACTUELLE),HL		; qui sera affiché à la prochain piece à afficher
	LD			A,#C5					; on precise la bank dans laquelle la maptile
	LD			(No_BANK),A				; se trouve pour la lecture des tiles.
	LD			A,184					; on précise qu'on est dans la pièce 129
	ld			(No_PIECE),A
	call		asic_off
	call		c7_on					; la maptile Hyrule où se situe l'entré du donjon 4 se trouve en bank C7
	LD			HL,#5043				; adresse précise de la tile de la porte dans la maptile		
	ld			a,071					; je choisit la tile 071 (porte ouverte)
	ld			(HL),a					; hop on poke
	inc			hl	
	ld			a,071					; je choisit la tile 071 (porte ouverte)
	ld			(HL),a					; hop on poke	
	call		c7_off
	call		asic_on
		
	
	; On envoie la pallette CPC+ propre au donjon 4
	ld			hl,PALETTE_DONJON
	ld			(type_de_palette),hl
	ld			hl,#57BD				; adresse en RAM du numero de tile du passage vers la cave
	ld			(tile_cave),hl
	ld			hl,(gps)
	ld			(save_gps_hyrule),hl
	ld			hl,DONJON_GPS_PIECE04
	ld			(gps),hl
	ld			hl,TRIFORCE_GPS_DONJON4
	ld			(boussole_de_ce_donjon_adr),hl
	ld			hl,boss_donjon_4
	ld			(boss_donjon_label),hl
	ld			a,(flag_carte_donjon4)
	or			a
	jr			nz,ok_carte_donjon4
	jr			pas_de_carte_donjon4
ok_carte_donjon4
	ld		hl,MAP_DONJON_4
	ld		(map_a_lire),hl
	ld		a,(flag_carte_donjon4)
	ld		(flag_carte_de_ce_donjon),a
	ld		(flag_ok_affiche_carte),a
	ld		a,PIXEL_BLEU
	ld		(couleur_fond_gps),a
	ld		(couleur_fond2_gps),a
	jr		fin_config_carte_donjon4
pas_de_carte_donjon4
	ld		hl,MAP_DONJON_0
	ld		(map_a_lire),hl
	ld		a,1
	ld		(flag_ok_affiche_carte),a
	xor		a
	ld		a,(flag_carte_donjon4)
	ld		(flag_carte_de_ce_donjon),a
	ld		a,PIXEL_NOIR
	ld		(couleur_fond_gps),a
	ld		(couleur_fond2_gps),a
	ld		a,PIXEL_ORANGE
	ld		(couleur_link_gps),a
fin_config_carte_donjon4
	ld		a,#C3
	ld		(event_objets_donjon),a
	ld		hl,objet_donjon_4
	ld		(objet_donjon_label),hl
	LD		(event_objets_donjon+1),hl
	ret
donjon_4_termine
	ld	a,1
	ld	(flag_calcul),a
	ld	a,(flag_triforce_4)
	or	a
	call	nz,fermer_donjon_4
	ret
fermer_donjon_4
	ld		a,(flag_echelle)
	or		a
	RET	Z  
	call	asic_off
	call	c7_on
	LD			HL,#5043				; adresse précise de la tile de la porte dans la maptile		
	ld			a,198					; je choisit la tile 071 (porte ouverte)
	ld			(HL),a					; hop on poke
	inc			hl	
	ld			a,198					; je choisit la tile 071 (porte ouverte)
	ld			(HL),a					; hop on poke	
	call	c7_off
	call	asic_on
	ret



test_flag_monstres
	ld		a,nbr_cycle_attente_monstre
	ld		(attente_naissance_des_monstres),a
	ld		hl,flag_monstre1
		ld		b,7
	boucle_test_flag_monstre
			push	bc
			ld		a,(hl)
			cp		a,0
			jp		nz,fin_test_flag_monstre
			inc		hl
			pop		bc
			djnz	boucle_test_flag_monstre
			ld		a,(flag_naissance_en_cours)
			or		a
			RET		NZ
			ld		a,1
			ld		(flag_les_monstres_sont_tues),a
			ld		a,#C3
			ld		(event_objet_spawn_donjon),a
			ld		hl,objet_spawn_donjon
			LD		(event_objet_spawn_donjon+1),hl	
			RET
fin_test_flag_monstre
		pop		bc
		xor		a
		ld		(flag_les_monstres_sont_tues),a
		RET
		
test_flag_monstres2
		ld		hl,flag_monstre1
		ld		b,7
	boucle_test_flag_monstre2
			push	bc
			ld		a,(hl)
			cp		a,0
			jp		nz,fin_test_flag_monstre2
			inc		hl
			pop		bc
			djnz	boucle_test_flag_monstre2
			ld		a,1
			ld		(flag_les_monstres_sont_tues),a
			ld			a,#C3
			ld			(event_passage_spawn_donjon),a
			ld			hl,passage_spawn_donjon
			LD			(event_passage_spawn_donjon+1),hl	
			RET
fin_test_flag_monstre2
		pop		bc
		xor		a
		ld		(flag_les_monstres_sont_tues),a
		RET

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////    TEST DES PORTES DES DONJONS   ///////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

test_portes_donjon_ROM
	ld		a,(nbr_cle)
	cp		a,0
	RET		Z
	LD		A,(ntile_spr0)	
	cp		a,202					
	CALL	Z,porte_haut
	cp		a,203					
	CALL	Z,porte_haut
	cp		a,204					
	CALL	Z,porte_bas
	cp		a,205					
	CALL	Z,porte_bas
	cp		a,206					
	CALL	Z,porte_droite
	cp		a,207					
	CALL	Z,porte_gauche
	RET
	
porte_haut
	ld		a,(nbr_cle)
	dec		a
	ld		(nbr_cle),a
	ld		a,4
	ld		(type_objet),a
	ld		hl,compteur_cle
	ld		a,l
	ld		(selection_compteur),a
	ld		a,h
	ld		(selection_compteur+1),a
	call	calcul_decompteur_objet
	LD		A,(ntile_spr0)
	cp		a,202
	jp		nz,porte_haut_droite
porte_haut_gauche							; 202
	ld		a,007
	ld		(no_tile_a_ecrire),a
	LD		HL,(tile_a_lire_spr0)		; recupération de l'adresse de la tile_a_lire_spr3
	call 	on_ouvre_la_porte
	ld		a,008
	ld		(no_tile_a_ecrire),a
	LD		HL,(tile_a_lire_spr0)		; recupération de l'adresse de la tile_a_lire_spr3
	inc 	hl
	call 	on_ouvre_la_porte
	xor		a
	ret
porte_haut_droite	
	ld		a,008
	ld		(no_tile_a_ecrire),a
	LD		HL,(tile_a_lire_spr0)		; recupération de l'adresse de la tile_a_lire_spr3
	call 	on_ouvre_la_porte
	ld		a,007
	ld		(no_tile_a_ecrire),a
	LD		HL,(tile_a_lire_spr0)		; recupération de l'adresse de la tile_a_lire_spr3
	dec 	hl
	call 	on_ouvre_la_porte
	xor		a
	ret
	
	
porte_bas
	ld		a,(nbr_cle)
	dec		a
	ld		(nbr_cle),a
	ld		a,4
	ld		(type_objet),a
	ld		hl,compteur_cle
	ld		a,l
	ld		(selection_compteur),a
	ld		a,h
	ld		(selection_compteur+1),a
	call	calcul_decompteur_objet
	LD		A,(ntile_spr0)
	cp		a,204
	jp		nz,porte_bas_droite
porte_bas_gauche							; 202
	ld		a,005
	ld		(no_tile_a_ecrire),a
	LD		HL,(tile_a_lire_spr0)		; recupération de l'adresse de la tile_a_lire_spr3
	call 	on_ouvre_la_porte
	ld		a,006
	ld		(no_tile_a_ecrire),a
	LD		HL,(tile_a_lire_spr0)		; recupération de l'adresse de la tile_a_lire_spr3
	inc 	hl
	call 	on_ouvre_la_porte
	xor		a
	ret
porte_bas_droite	
	ld		a,006
	ld		(no_tile_a_ecrire),a
	LD		HL,(tile_a_lire_spr0)		; recupération de l'adresse de la tile_a_lire_spr3
	call 	on_ouvre_la_porte
	ld		a,005
	ld		(no_tile_a_ecrire),a
	LD		HL,(tile_a_lire_spr0)		; recupération de l'adresse de la tile_a_lire_spr3
	dec 	hl
	call 	on_ouvre_la_porte
	xor	a
	ret
porte_gauche
	ld		a,(nbr_cle)
	dec		a
	ld		(nbr_cle),a
	ld		a,4
	ld		(type_objet),a
	ld		hl,compteur_cle
	ld		a,l
	ld		(selection_compteur),a
	ld		a,h
	ld		(selection_compteur+1),a
	call	calcul_decompteur_objet
	ld		a,003
	ld		(no_tile_a_ecrire),a
	LD		HL,(tile_a_lire_spr0)		; recupération de l'adresse de la tile_a_lire_spr3
	call 	on_ouvre_la_porte
	xor		a
	ret
	

porte_droite
	ld		a,(nbr_cle)
	dec		a
	ld		(nbr_cle),a
	ld		a,4
	ld		(type_objet),a
	ld		hl,compteur_cle
	ld		a,l
	ld		(selection_compteur),a
	ld		a,h
	ld		(selection_compteur+1),a
	call	calcul_decompteur_objet
	ld		a,061
	ld		(no_tile_a_ecrire),a
	LD		HL,(tile_a_lire_spr0)		; recupération de l'adresse de la tile_a_lire_spr3
	call 	on_ouvre_la_porte
	xor		a
	ret

on_ouvre_la_porte
	call 	asic_off
	
	LD		A,(No_BANK)
	CP		a,#C6
	call	z,C6_on
	CP		a,#C7
	call	z,C7_on
	CP		a,#C5
	call	z,C5_on
	ld		a,(no_tile_a_ecrire)		; je choisit la tile 001
	ld		(HL),a						; et  l'écrit à l'adresse
	call 	asic_on
ret


	
	

placement_des_items_donjon
	ld		hl,140
	ld		(SPRH14_Y),hl
	ld		(SPRH15_Y),hl
	ld		hl,135
	ld		(SPRH14_X),hl
	ld		hl,350
	ld		(SPRH15_X),hl
	ld		hl,140
	ld		(SPRH13_Y),hl
	ld		hl,240
	ld		(SPRH13_X),hl
	ret	
	
init_indice_donjon1234	
	ld		a,(init_indice_donjon)
	cp		1
	ret		Z
	CALL	ACTIVATION_EVENTS_BOUTIQUE
	call	asic_on
	call	placement_des_items_donjon
	ld		hl,SPRH_RIEN
	ld		hl,SPRH_VIEILLE_ADR
	ld		(PERSO_SPR_ADR),hl
	
	ld		hl,SPRH_RIEN
	ld		(OBJET_AUTRE_ADR),hl
	ld		(OBJET_GAUCHE_ADR),hl
	ld		(OBJET_DROITE_ADR),hl
	ld		(OBJET_CENTRE_ADR),hl
	call	texte_init_boutique
	ld		a,1
	ld		(init_indice_donjon),a
	call	texte_init_boutique2
	RET
	

