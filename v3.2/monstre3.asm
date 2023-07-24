MONSTRE_3

; **********************************************************************
; ********************* RECUPERATION DES DONNES ************************
; **********************************************************************
	;ld		a,(flag_stop_monstres)
	;or		a
	;RET		NZ
	ld		a,(flag_monstre_3_touche)
	or		a
	ret		nz
	LD		a,(bankROM_MONSTRE_3)					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	LD		hl,(TYPE_MONSTRE3_ADR)					; Adresse en ROM du type de monstre choisit en table d'init
	LD		(TYPE_MONSTRE_ADR),hl
	LD		hl,(SPRH_MONSTRE3_ADR)					; Sprite Hard ASIC de destination
	LD		(SPRH_ADR),hl
	LD		hl,(SPRH7_X)							; récupération de la position X acutelle
	LD		(SPRH_X),hl
	LD		hl,(SPRH7_Y)							; récupération de la position Y actuelle
	LD		(SPRH_Y),hl	
	
	LD		a,(flag_etape_du_MONSTRE3)				; A=0 il na pas encore poppé
	CP		a,1
	Jp		z,naissance_MONSTRE_3					; A=1 intit termine, naissance debut ou en cours
	CP		a,2
	JP		z,update_MONSTRE_3						; monstre affiche, pret a metre a jour
	CP		a,3
	JP		z,mort_MONSTRE_3
	cp		a,4
	jp		z,efface_MONSTRE_3
INIT_MONSTRE_3
	CALL	calcul_piece_monstre				; 5 on recupere dans de la valeur a ajouter
	LD		(resultat_piece_monstre),de			; 6 je la sauvegarde pour plus tard
	ld		a,18
	ld		(bankROM),a
	call	rom_on	
	LD		hl,table_init_MONSTRE_3				; 3 Adresse de la table d'init du monstre 1
	add		hl,de								; 3 on ajoute le No de la piece pour tomber sur la bonne ligne
	LD		(pointeur_monstres3),hl				; 6 je la sauvagarde pour plus tard
	LD		de,VARIABLE_INIT_MONSTRE_3			; 3 cible des suites de variable
	LDI											; 5 TYPE_MONSTRE3_ADR
	LDI											; 5 TYPE_MONSTRE3_ADR+1
	LDI											; 5 bankROM_MONSTRE_3
	LDI											; 5
	LDI											; 5 SPRH_MONSTRE3_ADR
	LDI											; 5 SPRH_MONSTRE3_ADR+1
	LDI											; nombre de coups porté aux monstres (en nombres de cycle fois celui de l'épée)
	LDI											; nombre de couprs porté aux monstre avec une flêche
	LD		de,SPRH7_X_Y_ZOOM					; 3 on continu de lire la table init_MONSTRE_3 
												; mais on cible les valeurs hl vers l'ASIC
	LDI											; 5 X1
	LDI											; 5 X2
	LDI											; 5 Y1
	LDI											; 5 Y2
	LDI											; 5 ZOOM
	LDI											; 5
	LD		de,VARIABLE_INIT_MONSTRE_3+8	; on rechange le pointeur ecriture
	ld		(pointeur_ecriture_aleatoire),de
	LDI											; 
	LDI											; numeros de l'objet laissé
	call rom_off
	ld		hl,(VARIABLE_INIT_MONSTRE_3)
	ld		(est_ce_des_kesses),hl
	call	distribution_aleatoire
	LD		a,1					
	LD		(flag_etape_du_MONSTRE3),a				; init termine flag a 1 pour etape de la naissance
	LD		a,init_naissance_boucle
	LD		(compteur_naissance_MONSTRE_3),a
	LD		a,init_mort_boucle
	LD		(compteur_mort_MONSTRE_3),a
	LD		a,init_anim_boucle
	LD 		(compteur_anim_MONSTRE_3),a
REINIT_DEPLACEMENTS_MONSTRE_3
	LD		hl,table_depX_MONSTRE_3					; hl contient l'adresse de la table monstre 1
	LD		(pointeur_depX_MONSTRE_3),hl	 
	LD		ix,(pointeur_depX_MONSTRE_3)
	LD		(pointeur_direction3),ix
	LD		a,(ix)									; on lit le nombre de pas X de direction
	LD		(compteur_depX_MONSTRE_3),a
	LD		hl,table_depY_MONSTRE_3					; hl contient l'adresse de la table monstre 1
	LD		(pointeur_depY_MONSTRE_3),hl	 
	LD		iy,(pointeur_depy_MONSTRE_3)
	LD		(pointeur_direction3+2),iy
	LD		a,(iy)									; on lit le nombre de pas Y de direction
	LD		(compteur_depY_MONSTRE_3),a
	LD		a,nbr_direction
	LD		(compteur_direction),a
	ret
	
; **********************************************************************
; *************** NAISSANCE et ANIMATION DES MONSTRES ******************
; **********************************************************************

NAISSANCE_MONSTRE_3
	LD		a,(compteur_naissance_MONSTRE_3)
	dec		a										; il est a 15
	LD		(compteur_naissance_MONSTRE_3),a		; on le sauvegarde pour le prochain tour
	CP		a,0										; on verifie si il est a zero ou pas
	JP		Z,affiche_MONSTRE_3						; si il est a zero la naissance est terminee
	CP		A,cycle_naissance_1				
	JP		Z,naissance_monstre_phase_1
	CP		A,cycle_naissance_2				
	JP		Z,naissance_monstre_phase_2
	CP		A,cycle_naissance_3				
	JP		Z,naissance_monstre_phase_3
	RET	
AFFICHE_MONSTRE_3
	LD		a,2
	LD		(flag_etape_du_MONSTRE3),a
	call	rom_on
	LD		hl,(TYPE_MONSTRE_ADR)
	LD		(SPRH7_ANIM_1),hl
	LD		hl,(SPRH7_ANIM_1)
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	call	rom_off
	ld		a,1
	ld		(flag_monstre3),a
	
	;ld		a,(flag_ocean)
	;or 		a
	;call	nz,monstre_3_en_objet
	RET
UPDATE_MONSTRE_3
call 	test_collisions
	ld		a,3
	ld		(identification_monstre_en_cours),a
call 	collision_fleche
	call 	collision_epee
ld		a,(flag_stop_monstres)
	or		a
	RET		NZ
	LD		a,(compteur_anim_MONSTRE_3)					; on recupere le compteur qui est a xx
	dec		a											; il est a xx-1
	LD		(compteur_anim_MONSTRE_3),a					; on le sauvegarde pour le prochain tour
	CP		A,cycle_anim_1			
	JR		Z,anim_MONSTRE_3_phase_13
	CP		A,cycle_anim_2				
	JR		Z,anim_MONSTRE_3_phase_23
	CP		A,0
	Jr		Z,anim_MONSTRE_3_reinit
	call	deplacement3
	RET
ANIM_MONSTRE_3_PHASE_13
	call	deplacement3
	LD		a,(flag_etape_du_MONSTRE3)
	CP		a,3
	RET		Z
	LD		a,(bankROM_monstre_3)					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on

	LD		hl,(SPRH7_ANIM_1)							; adresse du sprite dans la RAM
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	call	rom_off
	RET
ANIM_MONSTRE_3_PHASE_23
	call	deplacement3
	LD		a,(bankROM_monstre_3)					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	LD		hl,(SPRH7_ANIM_2)
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	call	rom_off
	RET
ANIM_MONSTRE_3_REINIT
	LD		a,init_anim_boucle				; cycle d'animation termine on re initialise le compteur
	LD 		(compteur_anim_MONSTRE_3),a				; pour le prochain cycle
	JR 		anim_MONSTRE_3_phase_13
	call	deplacement3
	ret
	
; **********************************************************************
; ********************* DEPLACEMENT  DES MONSTRES **********************
; **********************************************************************

DEPLACEMENT3
;	LD		a,(flag_etat_du_dep3)
;	CP		a,0
;	JR		z,deplacement_init3
;	Jr		on_bouge3
DEPLACEMENT_INIT3
;	LD		a,1
;	LD		(flag_etat_du_dep3),a
;	ret
ON_BOUGE3
ld		hl,(SPRH7_X)
	ld		(SPRH_X),hl
	;ld		(SPRH_X_recul),hl
	ld		hl,(SPRH7_Y)
	ld		(SPRH_Y),hl
	;ld		(SPRH_Y_recul),hl
	call	nombre_animations_monstre
	;call 	test_collisions
	;ld		a,3
	;ld		(identification_monstre_en_cours),a
	;call 	collision_fleche
	;call 	collision_epee
EN_X3
	LD		a,(compteur_depX_MONSTRE_3)
	CP		a,0
	JP		z,en_Y3
	bit		7,a
	JR		Z,vers_la_droite3
	JR 		vers_la_gauche3
VERS_LA_DROITE3
	dec 	a
	LD		(compteur_depX_MONSTRE_3),a
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		a
	jr		nz,pas_de_collisions_droit_monstre3

	call 	collision_droite
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction3
pas_de_collisions_droit_monstre3
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	VERS_LA_DROITE3_ROM
	call	rom_off
calc_finanim_droite_monstre3	
; test de la collision avec le bord droite de l'écran
	ld		de,	(SPRH7_X)							; on récupere les coordonnée Y de Link
	OR		A										 ;on remet les flag à zero
	LD		hl,limite_bord_droit_monstres								 ;on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction3						;	 egale à zéro on va vers le bas
	JR		en_Y3
VERS_LA_GAUCHE3
	inc 	a
	LD		(compteur_depX_MONSTRE_3),a
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		a
	jr		nz,pas_de_collisions_gauche_monstre3

	call 	collision_gauche
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction3
pas_de_collisions_gauche_monstre3
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	VERS_LA_GAUCHE3_ROM
	call	rom_off
calc_finanim_gauche_monstre3	
; test de la collision avec le bord gauche de l'écran
	ld		hl,	(SPRH7_X)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		DE,#0016								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction3							; egale à zéro on va vers le bas
EN_Y3
	LD		a,(compteur_depY_MONSTRE_3)
	CP		a,0
	JP		Z,test_compteur_X3
	bit		7,a
	Jr		z,vers_le_bas3
	Jr		vers_le_haut3
VERS_LE_BAS3
	dec 	a
	LD		(compteur_depY_MONSTRE_3),a
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		a
	jr		nz,pas_de_collisions_bas_monstre3
	call 	collision_bas
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction3
pas_de_collisions_bas_monstre3
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	VERS_LE_BAS3_ROM
	call	rom_off
	
; test de la collision avec le bord bas de l'écran
	ld		de,	(SPRH7_Y)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		HL,#00EB								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction3							; egale à zéro on va vers le bas
	RET
VERS_LE_HAUT3
	inc 	a
	LD		(compteur_depY_MONSTRE_3),a
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		a
	jr		nz,pas_de_collisions_haut_monstre3

	call 	collision_haut
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction3
pas_de_collisions_haut_monstre3	
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	VERS_LE_HAUT3_ROM
	call	rom_off
	
; test de la collision avec le bord haut de l'écran
	ld		hl,	(SPRH7_Y)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		DE,#005A							; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	Jr		C,changement_direction3						; egale à zéro on va vers le bas
	ret
TEST_COMPTEUR_X3
	LD		a,(compteur_depX_MONSTRE_3)
	CP		a,0
	Jr		z,changement_direction3
	ret
CHANGEMENT_DIRECtion3
	LD		a,(compteur_direction3)
	dec		a
	LD		(compteur_direction3),a
	CP		a,0
	JP		z,reinit_deplacements_MONSTRE_3
	LD		hl,(pointeur_direction3)		; 5 nops
	inc		l							; 1 nop	
	LD		(pointeur_direction3),hl		; 5 nops
	LD		a,(hl)						; 2 nops
	LD		(compteur_depX_MONSTRE_3),a ; 4 nops
	LD		hl,(pointeur_direction3+2)
	inc		l
	LD		(pointeur_direction3+2),hl
	LD		a,(hl)
	LD		(compteur_depY_MONSTRE_3),a
	ret
MORT_MONSTRE_3
		LD		a,3
	LD		(flag_etape_du_MONSTRE3),a
	LD		a,(compteur_mort_MONSTRE_3)
	dec		a								; il est a 15
	LD		(compteur_mort_MONSTRE_3),a		; on le sauvegarde pour le prochain tour
	CP		a,0									; on verifie si il est a zero ou pas
	Jr		Z,efface_MONSTRE_3					; si il est a zero la naissance est terminee
	CP		A,cycle_mort_1				
	JP		Z,mort_monstre_phase_1
	CP		A,cycle_mort_2				
	JP		Z,mort_monstre_phase_2
	CP		A,cycle_mort_3				
	JP		Z,mort_monstre_phase_3
	ret
EFFACE_MONSTRE_3
	ld		a,3
	ld		(identification_monstre_en_cours),a
	ld		a,(flag_etape_du_monstre3)
	cp		a,4
	call	test_collisions_items
	RET		Z
	ld		hl,(objet_laisse_3)
	ld		a,l
	cp		a,0
	jr		z,efface_event_monstre_3
	ld		(type_objet_laisse),a
	call	affiche_objet
	ld		a,4
	ld		(flag_etape_du_monstre3),a
	ret
efface_event_monstre_3
		LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	efface_event_monstre_3_ROM
	call	rom_off
	;ld 		c,2   ;Channel (0-2)
	;call 	PLY_AKG_StopSoundEffectFromChannel
	
	ret
	
monstre_3_en_objet
	LD		a,4
	LD		(flag_etape_du_monstre3),a
ret
	
	
	