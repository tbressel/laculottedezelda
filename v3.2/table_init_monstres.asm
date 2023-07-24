; ***************************************************************************************************
; *************** TROUVER LA LIGNE DU MONSTRE CONCERNE DANS LES TABLE DE MONSTRES  ******************
; ***************************************************************************************************
calcul_piece_monstre
	LD		hl,(No_PIECE)				; de contient le numero de la piece actuelle
	add 	hl,hl						; si hl=3 au depart çà devient  hl=6
	add		hl,hl					; hl=12
	add		hl,hl					; hl=18
	add 	hl,hl					; hl=24
	LD		d,h
	LD		e,l					; de contient ce qu'il faut additionner
	RET
; ***************************************************************************************************
; *************************** DISTRIBUTION ALEATOIRE DES OBJETS  ************************************
; ***************************************************************************************************	
distribution_aleatoire
	call	asic_off
	call	c0_on
	ld		ix,(pointeur_objets_aleatoires)		; adresse du tableau d'objets
	ld		iy,(pointeur_ecriture_aleatoire)	; on recupère l'adresse d'écriture
	ld		a,(ix)					; on prends l'octet située sur le poid faible de l'adresse ciblées
	cp		a,#FF
	call	z,reinit_pointeur_objets_aleatoires
	
; on test si ce sont des ennemis volant genre les chauve souris		
	ld		c,a
	ld		hl,(est_ce_des_kesses)
	ld		de,KEESES_ROM
	ld		a,h
	ld		b,d
	sub		a,b
	cp		a,0
	jr		z,aucun_objet
	ld		a,c
objet_zero
	ld		(iy),a
	inc		ix
	inc		ix
	ld		(pointeur_objets_aleatoires),ix
	call	asic_on
	ret
reinit_pointeur_objets_aleatoires
	ld	a,(flag_donjon)
	or	a
	jr	nz,table_objets_donjon
	
	ld	ix,OBJETS_ALEATOIRES_HYRULE
	ld	(pointeur_objets_aleatoires),ix
	RET
table_objets_donjon
	ld	ix,OBJETS_ALEATOIRES_DONJON
	ld	(pointeur_objets_aleatoires),ix
	RET
aucun_objet
	xor	a
	jr	objet_zero

; ***************************************************************************************************
; **********************************  RECONNAISSANCE NOMBRE D'ANIM  *******************************
; ****************************************************************************************************
nombre_animations_monstre
	ld		a,(bankROM)
	cp		a,28
	jp		z,ennemis_bank28
	XOR		A
	ld		(flag_anim_2_sprites),a
	ld		(flag_anim_4_sprites),a
	ld		(flag_peahat),a
	RET
ennemis_bank28
	ld		a,8
	ld		(BankROM),a
	call	rom_on_bank_prog
	call	ennemis_bank28_ROM
	call	rom_off
	RET	
a2_sprites
	ld		a,8
	ld		(BankROM),a
	call	rom_on_bank_prog
	call	a2_sprites_ROM
	call	rom_off
	RET		
a4_sprites
	ld		a,1
	ld		(flag_anim_4_sprites),a
	xor		a
	ld		(flag_peahat),a
	RET
ghini_on
peathat_on
keeses_on
	ld	a,1
	ld	(flag_peahat),a
	RET

	

; ************************************************************************************
; ***********  CHOIX DE LA BANK SELON NAISSANCE EN COURS OU PAS *********************
; ************************************************************************************

bank_naissance_monstres
	LD		a,(link_bouge)
	OR		a
	JR		nz,bank_link_bouge
	LD		a,26
	LD		(bankROM),a
	RET
bank_link_bouge
	LD		a,(bankROM_link1)
	LD		(bankROM),a
	RET
	
; ************************************************************************************
; *****************************  NAISSANCE DES MONSTRES*******************************
; ************************************************************************************
Naissances
naissance_monstre_phase_1
	LD		a,1
	LD		(flag_naissance_en_cours),a
	CALL	rom_on
	LD		hl,BORNdeAD_ROM_SPR							; adresse du sprite dans la ROM
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	call	rom_off
	XOR		A
	RET
naissance_monstre_phase_2
	LD		a,1
	LD		(flag_naissance_en_cours),a
	CALL	rom_on
	LD		hl,BORNdeAD_ROM_SPR+#100
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	call	rom_off
	XOR		A
	RET
naissance_monstre_phase_3
	LD		a,1
	LD		(flag_naissance_en_cours),a
	CALL	rom_on
	LD		hl,BORNdeAD_ROM_SPR+#200
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	call	rom_off
	XOR		A
	LD		(flag_naissance_en_cours),a
	RET
	
; ************************************************************************************
; **********************************  MORT DES MONSTRES*******************************
; ************************************************************************************
mort_monstre_phase_1
	LD		a,1
	LD		(flag_mort_en_cours),a
	LD		a,(bankROM_link1)
	LD		(bankROM),a
	CALL	rom_on
	LD		hl,BORNdeAD_ROM_SPR+#300
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	call	rom_off
	XOR		A
	LD		(flag_mort_en_cours),a
	ld 		a,2	 ;Sound effect number (>=1)
	ld 		c,2 ;channel (0-2)
	ld 		b,0 ;Inverted volume (0-16)
	call 	PLY_AKG_PlaySoundEffect
	RET
mort_monstre_phase_2
	LD		a,1
	LD		(flag_mort_en_cours),a
	LD		a,(bankROM_link1)
	LD		(bankROM),a
	CALL	rom_on
	LD		hl,BORNdeAD_ROM_SPR+#400
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	call	rom_off
	XOR		A
	LD		(flag_mort_en_cours),a
	RET
mort_monstre_phase_3
	LD		a,1
	LD		(flag_mort_en_cours),a
	LD		a,(bankROM_link1)
	LD		(bankROM),a
	CALL	rom_on
	LD		hl,BORNdeAD_ROM_SPR+#500
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	XOR		A
	LD		(flag_mort_en_cours),a
	RET
; ***************************************************************************************************
; **********************************  ACTIVATION DESACTIVATION DES EVENTS MONSTRES  *******************************
; ****************************************************************************************************

ACTIVATION_EVENTS
	ld		a,(flag_boutique)
	OR		A
	jp		NZ,ACTIVATION_EVENTS_BOUTIQUE
	CALL 	ACTIVATION_EVENTS_HYRULE
	CALL	calcul_piece_monstre				; 5 on recupere dans de la valeur a ajouter
	LD		(resultat_piece_monstre),de			; 6 je la sauvegarde pour plus tard
	ld		a,(radeau_en_cours)
	OR		A
	CALL	NZ,link_radeau_on
lecture_monstre_1
	ld		a,18
	ld		(bankROM),a
	call	rom_on	
	LD		hl,table_init_monstre_1				; 3 Adresse de la table d'init du monstre 1
	add		hl,de								; 3 on ajoute le No de la piece pour tomber sur la bonne ligne
	inc		l									; on tombera sur le poid fort de l'octet à lire qui n'ets jamais à 0
	ld		a,(hl)
	OR		A									; si aucun monstre indiqué dans la table ...
	JR		Z,lecture_monstre_2					; alors on lit le monstre suivant
	LD		a,#CD									; sinon on créer l'venement monstre 1
	LD		(event_monstre1),a
	LD		hl,monstre_1
	LD		(event_monstre1+1),hl
lecture_monstre_2
	ld		a,18
	ld		(bankROM),a
	call	rom_on	
	LD		hl,table_init_monstre_2				; 3 Adresse de la table d'init du monstre 1
	add		hl,de								; 3 on ajoute le No de la piece pour tomber sur la bonne ligne
	inc		l									; on tombera sur le poid fort de l'octet à lire qui n'ets jamais à 0
	ld		a,(hl)
	or		a									; si aucun monstre indiqué dans la table ...
	JR		Z,lecture_monstre_3					; alors on lit le monstre suivant
	LD		a,#CD								; sinon on créer l'venement monstre 1
	LD		(event_monstre2),a
	LD		hl,monstre_2
	LD		(event_monstre2+1),hl
lecture_monstre_3
	ld		a,18
	ld		(bankROM),a
	call	rom_on	
	LD		hl,table_init_monstre_3				; 3 Adresse de la table d'init du monstre 1
	add		hl,de								; 3 on ajoute le No de la piece pour tomber sur la bonne ligne
	inc		l									; on tombera sur le poid fort de l'octet à lire qui n'ets jamais à 0
	ld		a,(hl)
	or		a									; si aucun monstre indiqué dans la table ...
	JR		Z,lecture_monstre_4					; alors on lit le monstre suivant
	LD		a,#CD								; sinon on créer l'venement monstre 1
	LD		(event_monstre3),a
	LD		hl,monstre_3
	LD		(event_monstre3+1),hl
lecture_monstre_4
	ld		a,17
	ld		(bankROM),a
	call	rom_on	
	LD		hl,table_init_monstre_4				; 3 Adresse de la table d'init du monstre 1
	add		hl,de								; 3 on ajoute le No de la piece pour tomber sur la bonne ligne
	inc		l									; on tombera sur le poid fort de l'octet à lire qui n'ets jamais à 0
	ld		a,(hl)
	or		a									; si aucun monstre indiqué dans la table ...
	JR		Z,lecture_monstre_5					; alors on lit le monstre suivant
	LD		a,#CD								; sinon on créer l'venement monstre 1
	LD		(event_monstre4),a
	LD		hl,monstre_4
	LD		(event_monstre4+1),hl
lecture_monstre_5
	ld		a,17
	ld		(bankROM),a
	call	rom_on	
	LD		hl,table_init_monstre_5				; 3 Adresse de la table d'init du monstre 1
	add		hl,de								; 3 on ajoute le No de la piece pour tomber sur la bonne ligne
	inc		l									; on tombera sur le poid fort de l'octet à lire qui n'ets jamais à 0
	ld		a,(hl)
	or		a									; si aucun monstre indiqué dans la table ...
	JR		Z,lecture_monstre_6					; alors on lit le monstre suivant
	LD		a,#CD								; sinon on créer l'venement monstre 1
	LD		(event_monstre5),a
	LD		hl,monstre_5
	LD		(event_monstre5+1),hl
lecture_monstre_6
	ld		a,17
	ld		(bankROM),a
	call	rom_on	
	LD		hl,table_init_monstre_6				; 3 Adresse de la table d'init du monstre 1
	add		hl,de								; 3 on ajoute le No de la piece pour tomber sur la bonne ligne
	inc		l									; on tombera sur le poid fort de l'octet à lire qui n'ets jamais à 0
	ld		a,(hl)
	or		a									; si aucun monstre indiqué dans la table ...
	JR		Z,lecture_monstre_7					; alors on lit le monstre suivant
	LD		a,#CD									; sinon on créer l'venement monstre 1
	LD		(event_monstre6),a
	LD		hl,monstre_6
	LD		(event_monstre6+1),hl
lecture_monstre_7
	ld		a,16
	ld		(bankROM),a
	call	rom_on	
	LD		hl,table_init_monstre_7				; 3 Adresse de la table d'init du monstre 1
	add		hl,de								; 3 on ajoute le No de la piece pour tomber sur la bonne ligne
	inc		l									; on tombera sur le poid fort de l'octet à lire qui n'ets jamais à 0
	ld		a,(hl)
	OR		A									; si aucun monstre indiqué dans la table ...
	JR		Z,lecture_poisson									; alors on lit le monstre suivant
	LD		a,#CD									; sinon on créer l'venement monstre 1
	LD		(event_monstre7),a
	LD		hl,monstre_7
	LD		(event_monstre7+1),hl
lecture_poisson
	ld		a,18								; la table poisson est en fait la table monstre 1
	ld		(bankROM),a							; l'avant dernier octet est à #01 ou #00
	call	rom_on	
	LD		hl,table_init_monstre_1				; Adresse de la table d'init du monstre 1 (avec zora)
	add		hl,de								; 3 on ajoute le No de la piece pour tomber sur la bonne ligne
	ld		bc,15								; on transfert hl dans ix
	add		hl,bc								; 15 octet plus loin on lit la présence ou non de ZORA
	ld		a,(hl)
	or		a									; si aucun monstre indiqué dans la table ...
	JR		Z,lecture_objets_donjon									; alors on lit le monstre suivant
	LD		a,#CD									; sinon on créer l'venement monstre 1
	LD		(event_poisson_zora),a
	LD		hl,poisson_zora
	LD		(event_poisson_zora+1),hl
	RET
lecture_objets_donjon
	ld		a,(flag_donjon)
	OR		A
	RET		Z
	ld		a,8								; la table poisson est en fait la table monstre 1
	ld		(bankROM),a							; l'avant dernier octet est à #01 ou #00
	call	rom_on
	call	lecture_objets_donjon_ROM
	call	rom_off
	ret
	
	

DESACTIVATION_EVENTS
	ld		a,8
	ld		(BankROM),a
	call	rom_on_bank_prog
	call	DESACTIVATION_EVENTS_ROM
	call	rom_off
	call	flag_hyrule_on
	call	del_on
	ld		a,(flag_donjon)
	OR		A
	RET		Z
	xor		a
	ld		(flag_flammes),a
	LD		(event_flammes),a
	LD		(event_flammes+1),a
	LD		(event_flammes+2),a
	LD		(event_flammes+3),a
	RET
ACTIVATION_EVENTS_BOUTIQUE
	LD		a,#CD								; sinon on créer l'venement monstre 1
	LD		(event_flammes),a
	LD		hl,flammes
	LD		(event_flammes+1),hl
	ret
ACTIVATION_EVENTS_HYRULE
	ld		a,8
	ld		(BankROM),a
	call	rom_on
	call	ACTIVATION_EVENTS_HYRULE_ROM
	call	rom_off
	ret
flag_ocean_on
	xor		a
	ld		(flag_etape_du_monstre1),a
	ld		(flag_stop_monstres),a
	ret
flag_hyrule_on
	ld		a,(link_joue)
	cp		a,1
	ret		z
	ld		a,(flag_bombe)
	cp		a,1
	jr		z,on_reinit_pas_le_monstre_1
on_reinit_pas_le_monstre_1
	ld		a,(flag_boss4_RIP)
	or		a
	ret		Z
	ld		a,(No_PIECE)
	cp		a,220
	RET		Z
	ld		a,(flag_route_vers_zelda)
	or		a
	RET		nZ
	ret	
	

	
; ***************************************************************************************************
; **********************************  Résultat collision des monstres et décors  *******************************
; ****************************************************************************************************
stop_bas_monstres
	ld		hl,(SPRH_Y)
	ld		de,vitesseY_monstres
	sbc		hl,de
	ld		(SPRH_Y),hl
	RET
stop_gauche_monstres
	ld		hl,(SPRH_X)
	ld		de,vitesseX_monstres
	add		hl,de
	ld		(SPRH_X),hl
	RET
stop_droite_monstres
	ld		hl,(SPRH_X)
	ld		de,vitesseX_monstres
	sbc		hl,de
	ld		(SPRH_X),hl
	RET
stop_haut_monstres
	ld		hl,(SPRH_Y)
	ld		de,vitesseY_monstres
	add		hl,de
	ld		(SPRH_Y),hl
	RET
; ***************************************************************************************************
; **********************************  Listes des objets laisse par les monstre   *******************************
; ****************************************************************************************************
affiche_objet
	cp		a,1
	jp		z,objet_rubi1
	cp		a,2
	jp		z,objet_coeur
	cp		a,3
	jp		z,objet_bombe3
	cp		a,4
	jp		z,objet_cle4
	cp		a,5
	jp		z,objet_montre
	cp		a,6
	jp		z,objet_viande
	cp		a,7
	jr		z,objet_champi_rouge
	cp		a,8
	jr		z,objet_champi_vert
	cp		a,9
	jp		z,zelda_en_mario
	cp		a,10
	jr		z,objet_champi_pourrit
	cp		a,11
	jr		z,objet_rubi11
	cp		a,objet_porte_donjon_3  		; numero 32
	jp		z,objet_cle_du_donjon_3
	cp		a,12
	jp		z,objet_rubi12
	cp		a,13
	jp		z,objet_rubi13
objet_champi_rouge
	LD		a,26					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	LD		hl,SPRH_CHAMPI_ROUGE_ADR
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	ret
objet_champi_vert
	LD		a,26					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	LD		hl,SPRH_CHAMPI_VERT_ADR
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	ret
objet_champi_pourrit
	LD		a,26					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	LD		hl,SPRH_CHAMPI_POURRIT_ADR
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	ret
objet_rubi1
	LD		a,25					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	LD		hl,SPRH_RUBIJ_ADR
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	ret
objet_rubi11
	LD		a,25					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	LD		hl,SPRH_RUBIB_ADR
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	ret
objet_coeur
	LD		a,25					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	LD		hl,SPRH_COEUR_ADR
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	ret	
objet_bombe3
	LD		a,25					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	LD		hl,SPRH_BOMBE_ADR
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	ret	
objet_cle4
	LD		a,25					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	LD		hl,SPRH_CLE_ADR
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	ret	
zelda_en_mario
	LD		a,26					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	LD		hl,MARIO_NU
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	ld		a,1
	ld		(flag_mario_nu),a
	ret
objet_montre
	LD		a,25					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	LD		hl,SPRH_MONTRE_ADR
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	ret
objet_viande
	LD		a,25					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	LD		hl,SPRH_VIANDE_ADR
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	ret	
objet_cle_du_donjon_3
	LD		a,25					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	LD		hl,SPRH_CLE_DONJON_ADR
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	ret
objet_rubi12
	LD		a,25					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	LD		hl,SPRH_RUBIN_ADR
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	ret
objet_rubi13
	LD		a,25					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	LD		hl,SPRH_RUBIV_ADR
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	ret
	
	
	

