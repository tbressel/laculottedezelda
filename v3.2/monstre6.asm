monstre_6

; **********************************************************************
; ********************* RECUPERATION DES DONNES ************************
; **********************************************************************
;ld		a,(flag_stop_monstres)
;	or a
;	RET		NZ
ld		a,(flag_monstre_6_touche)
	or a
	ret		nz
	ld		a,(bankROM_monstre_6)
	ld		(bankROM),a
	LD		hl,(TYPE_monstre6_ADR)
	ld		(TYPE_MONSTRE_ADR),hl
	LD		hl,(SPRH_monstre6_ADR)
	ld		(SPRH_ADR),hl	
	ld		hl,(SPRH10_X)
	ld		(SPRH_X),hl
	ld		hl,(SPRH10_Y)
	ld		(SPRH_Y),hl	
	ld		a,(flag_etape_du_monstre6)		; A=0 il n'existe pas encore
	cp		a,1
	jp		z,naissance_monstre_6			; A=1 intit termine, naissance debut ou en cours
	cp		a,2
	jp		z,update_monstre_6			; monstre affiche, pret a metre a jour
	cp		a,3
	jp		z,mort_monstre_6
	cp		a,4
	jp		z,efface_monstre_6
init_monstre_6
	CALL	calcul_piece_monstre	; on recupere dans DE la valeur a ajouter
	ld		(resultat_piece_monstre),de
	ld		a,17
	ld		(bankROM),a
	call	rom_on	
	ld		hl,table_init_monstre_6		; hl contient l'adresse de la table monstre 1
	add		hl,de				; si NoPiece est 3 on est bien sur l'octet "8"
	ld		(pointeur_monstres6),hl
	ld		de,VARIABLE_INIT_MONSTRE_6		; 3 cible des suites de variable
	LDI										; 5 TYPE_MONSTRE1_ADR
	LDI										; 5 TYPE_MONSTRE1_ADR+1
	LDI										; 5 bankROM_monstre_1
	LDI										; 5
	LDI										; 5 SPRH_MONSTRE1_ADR
	LDI										; 5 SPRH_MONSTRE1_ADR+1
	LDI										; nombre de coups porté aux monstres (en nombres de cycle fois celui de l'épée)
	LDI
	ld		de,SPRH10_X_Y_ZOOM						; 3 on continu de lire la table init_monstre_1 
											; mais on cible les valeurs hl vers l'ASIC
	LDI										; 5 X1
	LDI										; 5 X2
	LDI										; 5 Y1
	LDI										; 5 Y2
	LDI										; 5 ZOOM
	LDI										; 5
	LD		de,VARIABLE_INIT_MONSTRE_6+8	; on rechange le pointeur ecriture
	ld		(pointeur_ecriture_aleatoire),de
	LDI											; 
	LDI											; numeros de l'objet laissé
	call rom_off
	ld		hl,(VARIABLE_INIT_MONSTRE_6)
	ld		(est_ce_des_kesses),hl
	call	distribution_aleatoire
	ld		a,1					
	ld		(flag_etape_du_monstre6),a	; init termine flag a 1 pour etape de la naissance
	ld		a,init_naissance_boucle
	ld		(compteur_naissance_monstre_6),a
	ld		a,init_mort_boucle
	ld		(compteur_mort_monstre_6),a
	ld		a,init_anim_boucle
	ld 		(compteur_anim_monstre_6),a
reinit_deplacements_monstre_6
	ld		hl,table_depX_monstre_6		; hl contient l'adresse de la table monstre 1
	ld		(pointeur_depX_monstre_6),hl	; 
	ld		ix,(pointeur_depX_monstre_6)
	ld		(pointeur_direction6),ix
	ld		a,(ix)				; 10 est dans A
	ld		(compteur_DepX_monstre_6),a
	ld		hl,table_depY_monstre_6		; hl contient l'adresse de la table monstre 1
	ld		(pointeur_depY_monstre_6),hl	; 
	ld		iy,(pointeur_depy_monstre_6)
	ld		(pointeur_direction6+2),iy
	ld		a,(iy)				; 10 est dans A
	ld		(compteur_DepY_monstre_6),a
	ld		a,nbr_direction
	ld		(compteur_direction6),a
	ret
	
; **********************************************************************
; *************** NAISSANCE et ANIMATION DES MONSTRES ******************
; **********************************************************************

naissance_monstre_6
	ld		a,(compteur_naissance_monstre_6)
	dec		a						; il est a 16
	ld		(compteur_naissance_monstre_6),a		; on le sauvegarde pour le prochain tour
	cp		a,0					; on verifie si il est a zero ou pas
	Jr		Z,affiche_monstre_6			; si il est a zero la naissance est terminee
	cp		A,cycle_naissance_1				
	JP		Z,naissance_monstre_phase_1
	cp		A,cycle_naissance_2				
	JP		Z,naissance_monstre_phase_2
	cp		A,cycle_naissance_3				
	JP		Z,naissance_monstre_phase_3
	RET
affiche_monstre_6
	ld		a,2
	ld		(flag_etape_du_monstre6),a
	call	rom_on
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		(SPRH10_ANIM_1),hl
	ld		hl,(SPRH10_ANIM_1)
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	ld		a,1
	ld		(flag_monstre6),a
	
	ld		a,(flag_ocean)
	or 		a
	call	nz,monstre_6_en_objet

	RET
update_monstre_6
	call 	test_collisions
	ld		a,6
	ld		(identification_monstre_en_cours),a
call 	collision_fleche
	call 	collision_epee
ld		a,(flag_stop_monstres)
	or		a
	RET		NZ
	ld		a,(compteur_anim_monstre_6)		; on recupere le compteur qui est a xx
	dec		a					; il est a xx-1
	ld		(compteur_anim_monstre_6),a		; on le sauvegarde pour le prochain tour
	cp		A,cycle_anim_1			
	Jr		Z,anim_monstre_6_phase_16
	cp		A,cycle_anim_2				
	Jr		Z,anim_monstre_6_phase_26
	cp		A,0
	Jr		Z,anim_monstre_6_reinit
	call	deplacement6
	RET
anim_monstre_6_phase_16
	call	deplacement6
	ld		a,(flag_etape_du_monstre6)
	CP		a,3
	RET		Z	
		LD		a,(bankROM_monstre_6)					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	ld		hl,(SPRH10_ANIM_1)
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	RET
anim_monstre_6_phase_26
	call	deplacement6
	LD		a,(bankROM_monstre_6)					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	ld		hl,(SPRH10_ANIM_2)
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	RET
anim_monstre_6_reinit
	ld		a,init_anim_boucle				; cycle d'animation termine on re initialise le compteur
	ld 		(compteur_anim_monstre_6),a				; pour le prochain cycle
	jr 		anim_monstre_6_phase_16	
	call	deplacement6
	ret
	
; **********************************************************************
; ********************* DEPLACEMENT  DES MONSTRES **********************
; **********************************************************************

deplacement6
;	ld		a,(flag_etat_du_dep6)
;	cp		a,0
;	jr		z,deplacement_init6
;	jr		on_bouge6
deplacement_init6
;	ld		a,1
;	ld		(flag_etat_du_dep6),a
;	ret
on_bouge6
ld		hl,(SPRH10_X)
	ld		(SPRH_X),hl
	;ld		(SPRH_X_recul),hl
	ld		hl,(SPRH10_Y)
	ld		(SPRH_Y),hl
	;ld		(SPRH_Y_recul),hl
	call	nombre_animations_monstre
	;call 	test_collisions
	;ld		a,6
	;ld		(identification_monstre_en_cours),a
	;call 	collision_fleche
	;call 	collision_epee
en_X6
	ld		a,(compteur_DepX_monstre_6)
	cp		a,0
	jp		z,en_Y6
	bit		7,a
	jr		Z,vers_la_droite6
	jr 		vers_la_gauche6
vers_la_droite6
	dec 	a
	ld		(compteur_DepX_monstre_6),a
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		A
	jr		nz,pas_de_collisions_droit_monstre6
	call 	collision_droite
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction6
pas_de_collisions_droit_monstre6
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	vers_la_droite6_ROM
	call	rom_off
	
	
calc_finanim_droite_monstre6

; test de la collision avec le bord droite de l'écran
	ld		de,	(SPRH10_X)						;	 on récupere les coordonnée Y de Link
	OR		A									;	 on remet les flag à zero
	LD		hl,limite_bord_droit_monstres							;	 on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction6				;			 egale à zéro on va vers le bas
	jr		en_Y6
vers_la_gauche6
	inc 	a
	ld		(compteur_DepX_monstre_6),a
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		a
	jr		nz,pas_de_collisions_gauche_monstre6
	call 	collision_gauche
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction6
pas_de_collisions_gauche_monstre6
		LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	vers_la_gauche6_ROM
	call	rom_off
	
calc_finanim_gauche_monstre6

; test de la collision avec le bord gauche de l'écran
	ld		hl,	(SPRH10_X)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		DE,#0016								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction6							; egale à zéro on va vers le bas
en_Y6
	ld		a,(compteur_DepY_monstre_6)
	cp		a,0
	jp		Z,test_compteur_X6
	bit		7,a
	jr		z,vers_le_bas6
	jr		vers_le_haut6
vers_le_bas6
	dec 	a
	ld		(compteur_DepY_monstre_6),a
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	cp		a,1
	jr		z,pas_de_collisions_bas_monstre6
	call 	collision_bas
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction6
pas_de_collisions_bas_monstre6
			LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	vers_le_bas6_ROM
	call	rom_off
	
; test de la collision avec le bord bas de l'écran
	ld		de,	(SPRH10_Y)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		hl,#00EB								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction6							; egale à zéro on va vers le bas
	RET
vers_le_haut6
	inc 	a
	ld		(compteur_DepY_monstre_6),a
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		a
	jr		nz,pas_de_collisions_haut_monstre6
	call 	collision_haut
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction6
pas_de_collisions_haut_monstre6
				LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	vers_le_haut6_ROM
	call	rom_off
	
	
; test de la collision avec le bord haut de l'écran
	ld		hl,	(SPRH10_Y)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		de,#005A							; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	Jr		C,changement_direction6						; egale à zéro on va vers le bas
	ret
test_compteur_X6
	ld		a,(compteur_DepX_monstre_6)
	cp		a,0
	jr		z,changement_direction6
	ret
changement_direction6
	ld		a,(compteur_direction6)
	dec		a
	ld		(compteur_direction6),a
	cp		a,0
	jp		z,reinit_deplacements_monstre_6
	ld		hl,(pointeur_direction6)		; 5 nops
	inc		l							; 1 nop	
	ld		(pointeur_direction6),hl		; 5 nops
	ld		a,(hl)						; 2 nops
	ld		(compteur_DepX_monstre_6),a ; 4 nops
	ld		hl,(pointeur_direction6+2)
	inc		l
	ld		(pointeur_direction6+2),hl
	ld		a,(hl)
	ld		(compteur_DepY_monstre_6),a
	ret
mort_monstre_6
	ld		a,3
	ld		(flag_etape_du_monstre6),a
	ld		a,(compteur_mort_monstre_6)
	dec		a						; il est a 16
	ld		(compteur_mort_monstre_6),a		; on le sauvegarde pour le prochain tour
	cp		a,0					; on verifie si il est a zero ou pas
	Jr		Z,efface_monstre_6			; si il est a zero la naissance est terminee
	cp		A,cycle_mort_1				
	JP		Z,mort_monstre_phase_1
	cp		A,cycle_mort_2				
	JP		Z,mort_monstre_phase_2
	cp		A,cycle_mort_3				
	JP		Z,mort_monstre_phase_3
	RET
efface_monstre_6
	ld		a,6
	ld		(identification_monstre_en_cours),a
	ld		a,(flag_etape_du_monstre6)
	cp		a,4
	call	test_collisions_items
	RET		Z
	ld		hl,(objet_laisse_6)
	ld		a,l
	cp		a,0
	jr		z,efface_event_monstre_6
	ld		(type_objet_laisse),a
	call	affiche_objet
	ld		a,4
	ld		(flag_etape_du_monstre6),a
	ret
efface_event_monstre_6
				LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	efface_event_monstre_6_ROM
	call	rom_off
	
    ;ld 		c,2   ;Channel (0-2)
	;call 	PLY_AKG_StopSoundEffectFromChannel
	
	ret
	
	monstre_6_en_objet
	LD		a,4
	LD		(flag_etape_du_monstre6),a
ret


	