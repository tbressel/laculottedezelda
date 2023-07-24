monstre_7

; **********************************************************************
; ********************* RECUPERATION DES DONNES ************************
; **********************************************************************
	;ld		a,(flag_stop_monstres)
	;or		a
	;RET		NZ
ld		a,(flag_monstre_7_touche)
	or		a
	ret		nz
	ld		a,(bankROM_monstre_7)
	ld		(bankROM),a
	LD		hl,(TYPE_monstre7_ADR)
	ld		(TYPE_MONSTRE_ADR),hl
	LD		hl,(SPRH_monstre7_ADR)
	ld		(SPRH_ADR),hl	
	ld		hl,(SPRH11_X)
	ld		(SPRH_X),hl
	ld		hl,(SPRH11_Y)
	ld		(SPRH_Y),hl	
	ld		a,(flag_etape_du_monstre7)		; A=0 il n'existe pas encore
	cp		a,1
	jp		z,naissance_monstre_7			; A=1 intit termine, naissance debut ou en cours
	cp		a,2
	jp		z,update_monstre_7			; monstre affiche, pret a metre a jour
	cp		a,3
	jp		z,mort_monstre_7
	cp		a,4
	jp		z,efface_monstre_7
init_monstre_7
	CALL	calcul_piece_monstre			; on recupere dans DE la valeur a ajouter
	ld		(resultat_piece_monstre),de
	ld		a,16
	ld		(bankROM),a
	call	rom_on	
	ld		hl,table_init_monstre_7			; hl contient l'adresse de la table monstre 1
	add		hl,de							; si NoPiece est 3 on est bien sur l'octet "8"
	ld		(pointeur_monstres7),hl
	ld		de,VARIABLE_INIT_MONSTRE_7		; 3 cible des suites de variable
	LDI										; 5 TYPE_MONSTRE1_ADR
	LDI										; 5 TYPE_MONSTRE1_ADR+1
	LDI										; 5 bankROM_monstre_1
	LDI										; 5
	LDI										; 5 SPRH_MONSTRE1_ADR
	LDI										; 5 SPRH_MONSTRE1_ADR+1
	LDI										; nombre de coups porté aux monstres (en nombres de cycle fois celui de l'épée)
	LDI
	ld		de,SPRH11_X_Y_ZOOM						; 3 on continu de lire la table init_monstre_1 
											; mais on cible les valeurs hl vers l'ASIC
	LDI										; 5 X1
	LDI										; 5 X2
	LDI										; 5 Y1
	LDI										; 5 Y2
	LDI										; 5 ZOOM
	LDI										; 5
	LD		de,VARIABLE_INIT_MONSTRE_7+8	; on rechange le pointeur ecriture
	ld		(pointeur_ecriture_aleatoire),de
	LDI											; 
	LDI											; numeros de l'objet laissé
	call 	rom_off
	ld		hl,(VARIABLE_INIT_MONSTRE_7)
	ld		(est_ce_des_kesses),hl
	call	distribution_aleatoire
	ld		a,1					
	ld		(flag_etape_du_monstre7),a	; init termine flag a 1 pour etape de la naissance
	ld		a,init_naissance_boucle
	ld		(compteur_naissance_monstre_7),a
	ld		a,init_mort_boucle
	ld		(compteur_mort_monstre_7),a
	ld		a,init_anim_boucle
	ld 		(compteur_anim_monstre_7),a
reinit_deplacements_monstre_7
	ld		hl,table_depX_monstre_7		; hl contient l'adresse de la table monstre 1
	ld		(pointeur_depX_monstre_7),hl	; 
	ld		ix,(pointeur_depX_monstre_7)
	ld		(pointeur_direction7),ix
	ld		a,(ix)				; 10 est dans A
	ld		(compteur_DepX_monstre_7),a
	ld		hl,table_depY_monstre_7		; hl contient l'adresse de la table monstre 1
	ld		(pointeur_depY_monstre_7),hl	; 
	ld		iy,(pointeur_depy_monstre_7)
	ld		(pointeur_direction7+2),iy
	ld		a,(iy)				; 10 est dans A
	ld		(compteur_DepY_monstre_7),a
	ld		a,nbr_direction
	ld		(compteur_direction7),a
	ret

; **********************************************************************
; *************** NAISSANCE et ANIMATION DES MONSTRES ******************
; **********************************************************************

naissance_monstre_7
	ld		a,(compteur_naissance_monstre_7)
	dec		a						; il est a 17
	ld		(compteur_naissance_monstre_7),a		; on le sauvegarde pour le prochain tour
	cp		a,0					; on verifie si il est a zero ou pas
	Jr		Z,affiche_monstre_7			; si il est a zero la naissance est terminee
	cp		A,cycle_naissance_1				
	JP		Z,naissance_monstre_phase_1
	cp		A,cycle_naissance_2				
	JP		Z,naissance_monstre_phase_2
	cp		A,cycle_naissance_3				
	JP		Z,naissance_monstre_phase_3
	RET
affiche_monstre_7
	ld		a,2
	ld		(flag_etape_du_monstre7),a
	call	rom_on
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		(SPRH11_ANIM_1),hl
	ld		hl,(SPRH11_ANIM_1)
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	ld		a,1
	ld		(flag_monstre7),a
	ld		a,(flag_ocean)
	or 		a
	call	nz,monstre_7_en_objet

	RET
update_monstre_7
call 	test_collisions
	ld		a,7
	ld		(identification_monstre_en_cours),a
call 	collision_fleche
	call 	collision_epee
ld		a,(flag_stop_monstres)
	or		a
	RET		NZ
	ld		a,(compteur_anim_monstre_7)		; on recupere le compteur qui est a xx
	dec		a					; il est a xx-1
	ld		(compteur_anim_monstre_7),a		; on le sauvegarde pour le prochain tour
	cp		A,cycle_anim_1			
	Jr		Z,anim_monstre_7_phase_17
	cp		A,cycle_anim_2				
	Jr		Z,anim_monstre_7_phase_27
	cp		A,0
	Jr		Z,anim_monstre_7_reinit
	call	deplacement7
	RET
anim_monstre_7_phase_17
	call	deplacement7
	ld		a,(flag_etape_du_monstre7)
	CP		a,3
	RET		Z	
	LD		a,(bankROM_monstre_7)					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	ld		hl,(SPRH11_ANIM_1)
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	RET
anim_monstre_7_phase_27
	call	deplacement7
	LD		a,(bankROM_monstre_7)					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	ld		hl,(SPRH11_ANIM_2)
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	RET
anim_monstre_7_reinit
	ld		a,init_anim_boucle				; cycle d'animation termine on re initialise le compteur
	ld 		(compteur_anim_monstre_7),a				; pour le prochain cycle
	jr 		anim_monstre_7_phase_17	
	call	deplacement7
	ret
	
; **********************************************************************
; ********************* DEPLACEMENT  DES MONSTRES **********************
; **********************************************************************

deplacement7
	;ld		a,(flag_etat_du_dep7)
	;cp		a,0
	;jr		z,deplacement_init7
	;jr		on_bouge7
deplacement_init7
	;ld		a,1
	;ld		(flag_etat_du_dep7),a
	;ret
on_bouge7
ld		hl,(SPRH11_X)
	ld		(SPRH_X),hl
	;ld		(SPRH_X_recul),hl
	ld		hl,(SPRH11_Y)
	ld		(SPRH_Y),hl
	;ld		(SPRH_Y_recul),hl
	call	nombre_animations_monstre
	call 	test_collisions
	ld		a,7
	ld		(identification_monstre_en_cours),a
	;call 	collision_fleche
	;call 	collision_epee
en_X7
	ld		a,(compteur_DepX_monstre_7)
	cp		a,0
	jp		z,en_Y7
	bit		7,a
	jr		Z,vers_la_droite7
	jr		vers_la_gauche7
vers_la_droite7
	dec 	a
	ld		(compteur_DepX_monstre_7),a
	
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		a
	jr		nz,pas_de_collisions_droit_monstre7
	call 	collision_droite
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction7
pas_de_collisions_droit_monstre7
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	vers_la_droite7_ROM
	call	rom_off
	
	
	
calc_finanim_droite_monstre7

; test de la collision avec le bord droite de l'écran
	ld		de,	(SPRH11_X)							; on récupere les coordonnée Y de Link
	OR		A										 ;on remet les flag à zero
	LD		hl,limite_bord_droit_monstres								 ;on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction7						;	 egale à zéro on va vers le bas
	jr		en_Y7
vers_la_gauche7
	inc 	a
	ld		(compteur_DepX_monstre_7),a
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		a
	jr		nz,pas_de_collisions_gauche_monstre7
	call 	collision_gauche
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction7
pas_de_collisions_gauche_monstre7
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	vers_la_gauche7_ROM
	call	rom_off
calc_finanim_gauche_monstre7

; test de la collision avec le bord gauche de l'écran
	ld		hl,	(SPRH11_X)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		DE,#0016								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction7							; egale à zéro on va vers le bas
en_Y7
	ld		a,(compteur_DepY_monstre_7)
	cp		a,0
	jp		Z,test_compteur_X7
	bit		7,a
	jr		z,vers_le_bas7
	jr		vers_le_haut7
vers_le_bas7
	dec 	a
	ld		(compteur_DepY_monstre_7),a
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	cp		a,1
	jr		z,pas_de_collisions_bas_monstre7
	call 	collision_bas
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction7
pas_de_collisions_bas_monstre7
		LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	vers_le_bas7_ROM
	call	rom_off
	
	
; test de la collision avec le bord bas de l'écran
	ld		de,	(SPRH11_Y)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		hl,#00EB								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction7							; egale à zéro on va vers le bas
	RET
vers_le_haut7
	inc 	a
	ld		(compteur_DepY_monstre_7),a
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		a
	jr		nz,pas_de_collisions_haut_monstre7
	call 	collision_haut
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	Jr		NC,changement_direction7
pas_de_collisions_haut_monstre7
		LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	vers_le_haut7_ROM
	call	rom_off
	

; test de la collision avec le bord haut de l'écran
	ld		hl,	(SPRH11_Y)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		DE,#005A							; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	Jr		C,changement_direction7							; egale à zéro on va vers le bas
	ret
test_compteur_X7
	ld		a,(compteur_DepX_monstre_7)
	cp		a,0
	jr		z,changement_direction7
	ret
changement_direction7
	ld		a,(compteur_direction7)
	dec		a
	ld		(compteur_direction7),a
	cp		a,0
	jp		z,reinit_deplacements_monstre_7
	ld		hl,(pointeur_direction7)		; 5 nops
	inc		l							; 1 nop	
	ld		(pointeur_direction7),hl		; 5 nops
	ld		a,(hl)						; 2 nops
	ld		(compteur_DepX_monstre_7),a ; 4 nops
	ld		hl,(pointeur_direction7+2)
	inc		l
	ld		(pointeur_direction7+2),hl
	ld		a,(hl)
	ld		(compteur_DepY_monstre_7),a
	ret
mort_monstre_7
	ld		a,3
	ld		(flag_etape_du_monstre7),a
	ld		a,(compteur_mort_monstre_7)
	dec		a						; il est a 17
	ld		(compteur_mort_monstre_7),a		; on le sauvegarde pour le prochain tour
	cp		a,0					; on verifie si il est a zero ou pas
	Jr		Z,efface_monstre_7			; si il est a zero la naissance est terminee
	cp		A,cycle_mort_1				
	JP		Z,mort_monstre_phase_1
	cp		A,cycle_mort_2				
	JP		Z,mort_monstre_phase_2
	cp		A,cycle_mort_3				
	JP		Z,mort_monstre_phase_3
	RET
efface_monstre_7
	ld		a,7
	ld		(identification_monstre_en_cours),a
	ld		a,(flag_etape_du_monstre7)
	cp		a,4
	call	test_collisions_items
	RET		Z
	ld		hl,(objet_laisse_7)
	ld		a,l
	cp		a,0
	jr		z,efface_event_monstre_7
	ld		(type_objet_laisse),a
	call	affiche_objet
	ld		a,4
	ld		(flag_etape_du_monstre7),a
	ret
	efface_event_monstre_7
		LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	efface_event_monstre_7_ROM
	call	rom_off
	
	
	

  ;  ld 		c,2   ;Channel (0-2)
   ; call PLY_AKG_StopSoundEffectFromChannel
	
	ret
	
	
	monstre_7_en_objet
	LD		a,4
	LD		(flag_etape_du_monstre7),a
ret
	