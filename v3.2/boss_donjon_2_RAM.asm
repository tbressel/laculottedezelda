; /////////////////////////////<////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////// BOSS DU DONJON 2 - RAM///////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
boss_donjon_2

; **********************************************************************
; ********************* RECUPERATION DES DONNES ************************
; **********************************************************************
	call	del_off
	call	test_bombe_dodongo
	ld			a,(flag_stop_monstres)
	cp			a,1
	RET		Z
	xor		a
	ld		(flag_stop_monstres),a
		
	LD		hl,MEM_TAMPON_BOSS							; Adresse en ROM du type de monstre choisit en table d'init
	LD		(TYPE_MONSTRE_ADR),hl
	LD		hl,SPRH5_ADR							; Sprite Hard ASIC de destination
	LD		(SPRH_ADR),hl
	LD		hl,(SPRH5_X)							; récupération de la position X acutelle
	LD		(SPRH_X),hl
	LD		hl,(SPRH5_Y)							; récupération de la position Y actuelle
	LD		(SPRH_Y),hl	

	LD		a,(etape_boss_2)				; A=0 il na pas encore poppé
	CP		a,1
	JP		z,AFFICHE_BOSS_2					; A=1 intit termine, naissance debut ou en cours
	CP		a,2
	JP		z,update_boss_2						; monstre affiche, pret a metre a jour
	CP		a,3
	JP		z,mort_boss_2
	cp		a,4
	jp		z,recompense_boss_2

INIT_BOSS_2
	CALL	calcul_piece_monstre				; 5 on recupere dans de la valeur a ajouter
	LD		(resultat_piece_monstre),de			; 6 je la sauvegarde pour plus tard
	ld		a,18
	ld		(bankROM),a
	call	rom_on	
	LD		hl,table_init_monstre_1				; 3 Adresse de la table d'init du monstre 1
	add		hl,de								; 3 on ajoute le No de la piece pour tomber sur la bonne ligne
	LD		(pointeur_monstres),hl				; 6 je la sauvagarde pour plus tard
	LD		de,VARIABLE_INIT_MONSTRE_1			; 3 cible des suites de variable
	LDI											; 5 TYPE_MONSTRE1_ADR
	LDI											; 5 TYPE_MONSTRE1_ADR+1
	LDI											; 5 bankROM_monstre_1
	LDI											; 5 monstre présent ou non dans la piece
	LDI											; 5 SPRH_MONSTRE1_ADR
	LDI											; 5 SPRH_MONSTRE1_ADR+1
	LDI											; nombre de coups porté aux monstres (en nombres de cycle fois celui de l'épée)
	LDI											; nombre de couprs porté aux monstre avec une flêche
	LD		de,SPRH5_X_Y_ZOOM					; 3 on continu de lire la table init_monstre_1 
												; mais on cible les valeurs hl vers l'ASIC
	LDI											; 5 X1
	LDI											; 5 X2
	LDI											; 5 Y1
	LDI											; 5 Y2
	LDI											; 5 ZOOM
	LDI											; 5
	LD		de,VARIABLE_INIT_MONSTRE_1+8	; on rechange le pointeur ecriture
	LDI											; presence de zora ou non
	LDI											; numeros de l'objet laissé
	
	ld		a,30
	ld		(bankROM),a
	call	rom_on
	LD		HL,#D000
	LD		DE,MEM_TAMPON_BOSS
	LD		BC,#1000
	LDIR
	LD		HL,#CC00
	LD		DE,MEM_TAMPON_BOSS+#1000
	LD		BC,#200
	LDIR
	call 	rom_off
	LD		a,1					
	LD		(etape_boss_2),a				; init termine flag a 1 pour etape de la naissance
	LD		a,2
	LD		(bankROM),a
	call	rom_on
	call	init_sprite_boss_2_ROM
	call	rom_off
	ret
REINIT_DEPLACEMENTS_BOSS_2
	LD		a,2
	LD		(bankROM),a
	call	rom_on
	call	REINIT_DEPLACEMENTS_BOSS_2_ROM
	call	rom_off
	ld		a,2
	ld		(etape_boss_2),a
	ret

	
; **********************************************************************
; *************** NAISSANCE et ANIMATION DES MONSTRES ******************
; **********************************************************************
AFFICHE_BOSS_2
	LD		a,2
	LD		(bankROM),a
	call	rom_on
	call	AFFICHE_BOSS_2_ROM
	call	rom_off
	ret
UPDATE_BOSS_2
	
	LD		a,2
	LD		(bankROM),a
	call	rom_on
	call	UPDATE_BOSS_2_ROM
	call	rom_off
	call	deplacement_boss_2
	ret
ANIM_BOSS_2_PHASE_1
	LD		a,2
	LD		(bankROM),a
	call	rom_on
	call	ANIM_BOSS_2_PHASE_1_ROM
	call	rom_off
	call	deplacement_boss_2
	ret
ANIM_BOSS_2_PHASE_2
	LD		a,2
	LD		(bankROM),a
	call	rom_on
	call	ANIM_BOSS_2_PHASE_2_ROM
	call	rom_off
	call	deplacement_boss_2
	ret
; **********************************************************************
; ********************* DEPLACEMENT  DES MONSTRES **********************
; **********************************************************************

DEPLACEMENT_BOSS_2
;	LD		a,(flag_etat_du_dep)
;	CP		a,0
;	JP		z,deplacement_init_boss_2
;	JP		on_bouge_boss_2
DEPLACEMENT_INIT_BOSS_2
;	LD		a,1
;	LD		(flag_etat_du_dep),a
;	ret
ON_BOUGE_BOSS_2
	ld		hl,(SPRH5_X)
	ld		(SPRH_X),hl
	call 	test_collisions
	ld		a,1
	ld		(identification_monstre_en_cours),a

EN_X_BOSS_2
	LD		a,(compteur_depX_monstre_1)
	CP		a,0
	JP		z,en_Y_boss_2
	bit		7,a
	JP		Z,vers_la_droite_boss_2
	JP 		vers_la_gauche_boss_2
VERS_LA_DROITE_BOSS_2
	dec 	a
	LD		(compteur_depX_monstre_1),a
	LD		a,8
	LD		(bankROM),a
	call	rom_on
	call	VERS_LA_DROITE_BOSS_2_ROM
	call	rom_off
; test de la collision avec le bord droite de l'écran
	ld		de,	(SPRH5_X)							 ;on récupere les coordonnée Y de Link
	OR		A										 ;on remet les flag à zero
	LD		hl,#01d0								 ;on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction_boss_2						;	 egale à zéro on va vers le bas
	JP		en_Y_boss_2
VERS_LA_GAUCHE_BOSS_2
	inc 	a
	LD		(compteur_depX_monstre_1),a
	LD		a,8
	LD		(bankROM),a
	call	rom_on
	call	VERS_LA_GAUCHE_BOSS_2_ROM
	call	rom_off
; test de la collision avec le bord gauche de l'écran
	ld		hl,	(SPRH5_X)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		DE,#0016								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction_boss_2							; egale à zéro on va vers le bas
EN_Y_BOSS_2
	LD		a,(compteur_depY_monstre_1)
	CP		a,0
	JP		Z,test_compteur_X
	bit	7,a
	JP		z,vers_le_bas_boss_2
	JP		vers_le_haut_boss_2
VERS_LE_BAS_BOSS_2
	dec 	a
	LD		(compteur_depY_monstre_1),a
	LD		a,8
	LD		(bankROM),a
	call	rom_on
	call	VERS_LE_BAS_BOSS_2_ROM
	call	rom_off	
; test de la collision avec le bord bas de l'écran
	ld		de,(SPRH5_Y)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		hl,#00EB								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC	HL,DE									
	JP		C,changement_direction_boss_2							; egale à zéro on va vers le bas
	RET
VERS_LE_HAUT_BOSS_2
	inc 	a
	LD		(compteur_depY_monstre_1),a
	LD		a,8
	LD		(bankROM),a
	call	rom_on
	call	VERS_LE_HAUT_BOSS_2_ROM
	call	rom_off	
; test de la collision avec le bord haut de l'écran
	ld		hl,	(SPRH5_Y)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		DE,#005A							; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE
	JP		C,changement_direction_boss_2						; egale à zéro on va vers le bas
	ret
	
TEST_COMPTEUR_X_BOSS_2
	LD		a,(compteur_depX_monstre_1)
	CP		a,0
	JP		z,changement_direction_boss_2
	ret
CHANGEMENT_DIRECTION_BOSS_2
	LD		a,2
	LD		(bankROM),a
	call	rom_on
	call	CHANGEMENT_DIRECTION_BOSS_2_ROM
	call	rom_off
	ret

	
MORT_BOSS_2
LD		a,2
LD		(bankROM),a
call	rom_on
call	mort_boss_2_ROM
RET


	
