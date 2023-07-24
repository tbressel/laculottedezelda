; /////////////////////////////<////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////// BOSS DU DONJON 3 - RAM///////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
boss_donjon_3

; **********************************************************************
; ********************* RECUPERATION DES DONNES ************************
; **********************************************************************
	call	del_off
	LD		a,ROM30					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	LD		hl,MEM_TAMPON_BOSS							; Adresse en ROM du type de monstre choisit en table d'init
	LD		(TYPE_MONSTRE_ADR),hl
	LD		hl,SPRH5_ADR				; Sprite Hard ASIC de destination
	LD		(SPRH_ADR),hl
	
	
	LD		hl,(SPRH5_X)							; récupération de la position X acutelle
	LD		(SPRH_X),hl
	LD		hl,(SPRH5_Y)							; récupération de la position Y actuelle
	LD		(SPRH_Y),hl	
	
	LD		a,(etape_boss_3)				; A=0 il na pas encore poppé
	CP		a,0
	JR		z,init_variable_boss_3					; A=1 intit termine, naissance debut ou en cours
	CP		a,1
	JP		z,init_sprite_boss_3							; monstre affiche, pret a metre a jour
	CP		a,2
	JP		z,init_deplacement_boss_3							; monstre affiche, pret a metre a jour
	CP		a,3
	JP		z,update_boss_3
	cp		a,4
	jp		z,affiche_recompense3	
	
	
init_variable_boss_3
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
	LDI
	ld		a,1
	ld		(flag_boss_donjon),a	; numeros de l'objet laissé
	ld		a,30
	ld		(bankROM),a
	call	rom_on
	LD		HL,#E000
	LD		DE,MEM_TAMPON_BOSS
	LD		BC,#1000
	LDIR
	call 	rom_off
	
	ld		a,#c3
	ld		(event_boss_3_boules_de_feu),a
	ld		hl,boss_3_boules_de_feu
	ld		(event_boss_3_boules_de_feu+1),hl
	ld		a,#c3
	ld		(event_boss_3_boules_de_feu2),a
	ld		hl,boss_3_boules_de_feu2
	ld		(event_boss_3_boules_de_feu2+1),hl
	ld		a,1
	ld		(etape_boss_3),a
	call 	test_de_touche_off
	ret
	
init_sprite_boss_3
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	init_sprite_boss_3_ROM
	call	rom_off
	LD		a,2
	LD		(etape_boss_3),a
	call 	test_de_touche_on
	ret

REINIT_DEPLACEMENTS_BOSS_3
init_deplacement_boss_3
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	init_sprite_boss_3_ROM
	call	rom_off
	LD		a,3
	LD		(etape_boss_3),a
	ret

UPDATE_BOSS_3
	LD		a,(compteur_anim_monstre_1)					; on recupere le compteur qui est a xx
	dec		a											; il est a xx-1
	LD		(compteur_anim_monstre_1),a					; on le sauvegarde pour le prochain tour
	
	CP		A,cycle_anim_1			
	JR		Z,anim_boss_3_phase_1
	CP		A,cycle_anim_2				
	JR		Z,anim_boss_3_phase_2
	CP		A,0
	JR		Z,anim_boss_3_reinit
	
	call	deplacement_boss3
	RET
	
ANIM_BOSS_3_PHASE_1
	call	deplacement_boss3
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	ANIM_BOSS_3_PHASE_1_ROM
	call	rom_off
	RET
ANIM_BOSS_3_PHASE_2
	call	deplacement_boss3
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	ANIM_BOSS_3_PHASE_2_ROM
	call	rom_off
	RET
ANIM_BOSS_3_REINIT
	LD		a,init_anim_boucle				; cycle d'animation termine on re initialise le compteur
	LD 		(compteur_anim_monstre_1),a				; pour le prochain cycle
	JP 		anim_BOSS_3_phase_1	
	call	deplacement_boss3
	ret

; **********************************************************************
; ********************* DEPLACEMENT  DES MONSTRES **********************
; **********************************************************************

DEPLACEMENT_BOSS3
	;LD		a,(flag_etat_du_dep)
	;or		a
	;JR		z,deplacement_init_boss3
	;JR		on_bouge_boss3
DEPLACEMENT_INIT_boss3
	;LD		a,1
	;LD		(flag_etat_du_dep),a
	;ret
ON_BOUGE_BOSS3
	ld		hl,(SPRH5_X)
	ld		(SPRH_X),hl
	call 	test_collisions
	ld		a,1
	ld		(identification_monstre_en_cours),a
	call 	collision_fleche
	call 	collision_epee
EN_X_BOSS3
	LD		a,(compteur_depX_monstre_1)
	CP		a,0
	JP		z,en_Y_BOSS3
	bit		7,a
	JR		Z,vers_la_droite_boss3
	JR 		vers_la_gauche_boss3
	

VERS_LA_DROITE_BOSS3
	dec 	a
	LD		(compteur_depX_monstre_1),a
	call 	collision_droite
	ld		B,115
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction_boss3
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	VERS_LA_DROITE_BOSS3_ROM
	call	rom_off
	

; test de la collision avec le bord droite de l'écran
	ld		de,	(SPRH5_X)							 ;on récupere les coordonnée Y de Link
	OR		A										 ;on remet les flag à zero
	LD		hl,#01d0								 ;on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction_boss3						;	 egale à zéro on va vers le bas
	JR		en_Y_BOSS3
	
	
VERS_LA_GAUCHE_BOSS3
	inc 	a
	LD		(compteur_depX_monstre_1),a
	call 	collision_gauche
	ld		B,115
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction_boss3
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	VERS_LA_GAUCHE_BOSS3_ROM
	call	rom_off

; test de la collision avec le bord gauche de l'écran
	ld		hl,	(SPRH5_X)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		DE,#0016								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction_boss3							; egale à zéro on va vers le bas
	
	
EN_Y_BOSS3
	LD		a,(compteur_depY_monstre_1)
	CP		a,0
	JP		Z,test_compteur_X_boss3
	bit		7,a
	JR		z,vers_le_bas_boss3
	JR		vers_le_haut_boss3
	
	
VERS_LE_BAS_BOSS3
	dec 	a
	LD		(compteur_depY_monstre_1),a
	call 	collision_bas
	ld		B,115
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction_boss3
	
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	VERS_LE_BAS_BOSS3_ROM
	call	rom_off

; test de la collision avec le bord bas de l'écran
	ld		de,(SPRH5_Y)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		hl,#00EB								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JR		C,changement_direction_boss3							; egale à zéro on va vers le bas
	RET

VERS_LE_HAUT_BOSS3
	inc 	a
	LD		(compteur_depY_monstre_1),a
	call 	collision_haut
	ld		B,115
	ld		A,(ntile_spr0)	
	SBC		A,B
	JR		NC,changement_direction_boss3
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	VERS_LE_HAUT_BOSS3_ROM
	call	rom_off
	

; test de la collision avec le bord haut de l'écran
	ld		hl,	(SPRH5_Y)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		DE,#005A							; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE
	JR		C,changement_direction_boss3						; egale à zéro on va vers le bas
	ret
TEST_COMPTEUR_X_BOSS3
	LD		a,(compteur_depX_monstre_1)
	CP		a,0
	JR		z,changement_direction_boss3
	ret
CHANGEMENT_DIRECTION_BOSS3
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	CHANGEMENT_DIRECTION_BOSS3_ROM
	call	rom_off
	ret
MORT_BOSS_3
	LD		a,8
	LD		(bankROM),a
	call	rom_on
	call	MORT_BOSS_3_ROM
	call	rom_off
	ld 		c,2   ;Channel (0-2)
    call 	PLY_AKG_StopSoundEffectFromChannel
	ld		a,4
	ld		(etape_boss_3),a
	jp		retour_boss_donjon

affiche_recompense3
	ld		a,(flag_receptacle_coeur_donjon3)
	or		a
	RET		nz
recompense_boss_3
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	recompense_boss_3_ROM
	call	rom_off
	
	ld 		c,2   ;Channel (0-2)
    call 	PLY_AKG_StopSoundEffectFromChannel
	RET

	

