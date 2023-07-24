monstre_5

; **********************************************************************
; ********************* RECUPERATION DES DONNES ************************
; **********************************************************************
;ld		a,(flag_stop_monstres)
;	or		a
;	RET		nZ
ld		a,(flag_monstre_5_touche)
	or		a
	ret		nz
	ld		a,(bankROM_monstre_5)
	ld		(bankROM),a
	LD		hl,(TYPE_MONSTRE5_ADR)
	ld		(TYPE_MONSTRE_ADR),hl
	LD		hl,(SPRH_MONSTRE5_ADR)
	ld		(SPRH_ADR),hl	
	ld		hl,(SPRH9_X)
	ld		(SPRH_X),hl
	ld		hl,(SPRH9_Y)
	ld		(SPRH_Y),hl	
	ld		a,(flag_etape_du_monstre5)		; A=0 il n'existe pas encore
	cp		a,1
	jp		z,naissance_monstre_5			; A=1 intit termine, naissance debut ou en cours
	cp		a,2
	jp		z,update_monstre_5			; monstre affiche, pret a metre a jour
	cp		a,3
	jp		z,mort_monstre_5
	cp		a,4
	jp		z,efface_monstre_5
init_monstre_5
	CALL	calcul_piece_monstre	; on recupere dans DE la valeur a ajouter
	ld		(resultat_piece_monstre),de
	ld		a,17
	ld		(bankROM),a
	call	rom_on	
	ld		hl,table_init_monstre_5		; hl contient l'adresse de la table monstre 1
	add		hl,de				; si NoPiece est 3 on est bien sur l'octet "8"
	ld		(pointeur_monstres5),hl
	ld		de,VARIABLE_INIT_MONSTRE_5		; 3 cible des suites de variable
	LDI										; 5 TYPE_MONSTRE1_ADR
	LDI										; 5 TYPE_MONSTRE1_ADR+1
	LDI										; 5 bankROM_monstre_1
	LDI										; 5
	LDI										; 5 SPRH_MONSTRE1_ADR
	LDI										; 5 SPRH_MONSTRE1_ADR+1
	LDI										; nombre de coups porté aux monstres (en nombres de cycle fois celui de l'épée)
	LDI
	ld		de,SPRH9_X_Y_ZOOM						; 3 on continu de lire la table init_monstre_1 
											; mais on cible les valeurs hl vers l'ASIC
	LDI										; 5 X1
	LDI										; 5 X2
	LDI										; 5 Y1
	LDI										; 5 Y2
	LDI										; 5 ZOOM
	LDI										; 5
	LD		de,VARIABLE_INIT_MONSTRE_5+8	; on rechange le pointeur ecriture
	LDI											; 
	LDI											; numeros de l'objet laissé
	call rom_off
	ld		a,1					
	ld		(flag_etape_du_monstre5),a	; init termine flag a 1 pour etape de la naissance
	ld		a,init_naissance_boucle
	ld		(compteur_naissance_monstre_5),a
	ld		a,init_mort_boucle
	ld		(compteur_mort_monstre_5),a
	ld		a,init_anim_boucle
	ld 		(compteur_anim_monstre_5),a
reinit_deplacements_monstre_5
	ld		hl,table_depX_monstre_5		; hl contient l'adresse de la table monstre 1
	ld		(pointeur_depX_monstre_5),hl	; 
	ld		ix,(pointeur_depX_monstre_5)
	ld		(pointeur_direction5),ix
	ld		a,(ix)				; 10 est dans A
	ld		(compteur_DepX_monstre_5),a
	ld		hl,table_depY_monstre_5		; hl contient l'adresse de la table monstre 1
	ld		(pointeur_depY_monstre_5),hl	; 
	ld		iy,(pointeur_depy_monstre_5)
	ld		(pointeur_direction5+2),iy
	ld		a,(iy)				; 10 est dans A
	ld		(compteur_DepY_monstre_5),a
	ld		a,nbr_direction
	ld		(compteur_direction5),a
	ret

; **********************************************************************
; *************** NAISSANCE et ANIMATION DES MONSTRES ******************
; **********************************************************************

naissance_monstre_5
	ld		a,(compteur_naissance_monstre_5)
	dec		a						; il est a 15
	ld		(compteur_naissance_monstre_5),a		; on le sauvegarde pour le prochain tour
	cp		a,0					; on verifie si il est a zero ou pas
	Jr		Z,affiche_monstre_5			; si il est a zero la naissance est terminee
	cp		A,cycle_naissance_1				
	JP		Z,naissance_monstre_phase_1
	cp		A,cycle_naissance_2				
	JP		Z,naissance_monstre_phase_2
	cp		A,cycle_naissance_3				
	JP		Z,naissance_monstre_phase_3
	RET
affiche_monstre_5
	ld		a,2
	ld		(flag_etape_du_monstre5),a
	call	rom_on
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		(SPRH9_ANIM_1),hl
	ld		hl,(SPRH9_ANIM_1)
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	ld		a,1
	ld		(flag_monstre5),a
	ld		a,(flag_ocean)
	or		a
	call	nz,monstre_5_en_objet

	RET
update_monstre_5
call 	test_collisions
	ld		a,5
	ld		(identification_monstre_en_cours),a
call 	collision_fleche
	call 	collision_epee
ld		a,(flag_stop_monstres)
	or		a
	RET		NZ
	ld		a,(compteur_anim_monstre_5)		; on recupere le compteur qui est a xx
	dec		a					; il est a xx-1
	ld		(compteur_anim_monstre_5),a		; on le sauvegarde pour le prochain tour
	cp		A,cycle_anim_1			
	Jr		Z,anim_monstre_5_phase_15
	cp		A,cycle_anim_2				
	Jr		Z,anim_monstre_5_phase_25
	cp		A,0
	Jr		Z,anim_monstre_5_reinit
	call	deplacement5
	RET
anim_monstre_5_phase_15
	call	deplacement5
	ld		a,(flag_etape_du_monstre5)
	CP		a,3
	RET		Z	
		LD		a,(bankROM_monstre_5)					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	ld		hl,(SPRH9_ANIM_1)
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	RET
anim_monstre_5_phase_25
	call	deplacement5
	LD		a,(bankROM_monstre_5)					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	ld		hl,(SPRH9_ANIM_2)
	ld		de,(SPRH_ADR)
	ld		bc,#100
	LDIR
	call	rom_off
	RET
anim_monstre_5_reinit
	ld		a,init_anim_boucle				; cycle d'animation termine on re initialise le compteur
	ld 		(compteur_anim_monstre_5),a				; pour le prochain cycle
	jr 		anim_monstre_5_phase_15	
	call	deplacement5
	ret
	
; **********************************************************************
; ********************* DEPLACEMENT  DES MONSTRES **********************
; **********************************************************************

deplacement5
;	ld		a,(flag_etat_du_dep5)
;	cp		a,0
;	jr		z,deplacement_init5
;	jr		on_bouge5
deplacement_init5
;	ld		a,1
;	ld		(flag_etat_du_dep5),a
;	ret
on_bouge5
ld		hl,(SPRH9_X)
	ld		(SPRH_X),hl
	;ld		(SPRH_X_recul),hl
	ld		hl,(SPRH9_Y)
	;ld		(SPRH_Y_recul),hl
	ld		(SPRH_Y),hl
	call	nombre_animations_monstre
	;call 	test_collisions
	;ld		a,5
	;ld		(identification_monstre_en_cours),a
	;call 	collision_fleche
	;call 	collision_epee
en_X5
	ld		a,(compteur_DepX_monstre_5)
	cp		a,0
	jp		z,en_Y5
	bit		7,a
	jr		Z,vers_la_droite5
	jr 		vers_la_gauche5
vers_la_droite5
	dec 	a
	ld		(compteur_DepX_monstre_5),a
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		a
	jr		nz,pas_de_collisions_droit_monstre5

	call 	collision_droite
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction5
pas_de_collisions_droit_monstre5
		LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	vers_la_droite5_ROM
	call	rom_off
calc_finanim_droite_monstre5
; test de la collision avec le bord droite de l'écran
	ld		de,	(SPRH9_X)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		hl,limite_bord_droit_monstres								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	Jp		C,changement_direction5					;		 egale à zéro on va vers le bas
	jr		en_Y5
vers_la_gauche5
	inc 	a
	ld		(compteur_DepX_monstre_5),a
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		a
	jr		nz,pas_de_collisions_gauche_monstre5

	call 	collision_gauche
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction5
pas_de_collisions_gauche_monstre5
		LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	vers_la_gauche5_ROM
	call	rom_off
	
	
calc_finanim_gauche_monstre5

; test de la collision avec le bord gauche de l'écran
	ld		hl,	(SPRH9_X)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		DE,#0016								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction5							; egale à zéro on va vers le bas
en_Y5
	ld		a,(compteur_DepY_monstre_5)
	cp		a,0
	jp		Z,test_compteur_X5
	bit		7,a
	jr		z,vers_le_bas5
	jr		vers_le_haut5
vers_le_bas5
	dec 	a
	ld		(compteur_DepY_monstre_5),a
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		a
	jr		nz,pas_de_collisions_bas_monstre5

	call 	collision_bas
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction5
pas_de_collisions_bas_monstre5	
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	vers_le_bas5_ROM
	call	rom_off
	
	
	
; test de la collision avec le bord bas de l'écran
	ld		de,	(SPRH9_Y)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		hl,#00EB								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction5							; egale à zéro on va vers le bas
	RET
vers_le_haut5
	inc 	a
	ld		(compteur_DepY_monstre_5),a
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		a
	jr		nz,pas_de_collisions_haut_monstre5

	call 	collision_haut
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	Jr		NC,changement_direction5
pas_de_collisions_haut_monstre5
		LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	vers_le_haut5_ROM
	call	rom_off
	
	
; test de la collision avec le bord haut de l'écran
	ld		hl,	(SPRH9_Y)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		DE,#005A							; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	Jr		C,changement_direction5							; egale à zéro on va vers le bas
	ret
test_compteur_X5
	ld		a,(compteur_DepX_monstre_5)
	cp		a,0
	jr		z,changement_direction5
	ret
changement_direction5
	ld		a,(compteur_direction5)
	dec		a
	ld		(compteur_direction5),a
	cp		a,0
	jp		z,reinit_deplacements_monstre_5
	ld		hl,(pointeur_direction5)		; 5 nops
	inc		l							; 1 nop	
	ld		(pointeur_direction5),hl		; 5 nops
	ld		a,(hl)						; 2 nops
	ld		(compteur_DepX_monstre_5),a ; 4 nops
	ld		hl,(pointeur_direction5+2)
	inc		l
	ld		(pointeur_direction5+2),hl
	ld		a,(hl)
	ld		(compteur_DepY_monstre_5),a
	ret
mort_monstre_5
	ld		a,3
	ld		(flag_etape_du_monstre5),a
	ld		a,(compteur_mort_monstre_5)
	dec		a						; il est a 15
	ld		(compteur_mort_monstre_5),a		; on le sauvegarde pour le prochain tour
	cp		a,0					; on verifie si il est a zero ou pas
	Jr		Z,efface_monstre_5			; si il est a zero la naissance est terminee
	cp		A,cycle_mort_1				
	JP		Z,mort_monstre_phase_1
	cp		A,cycle_mort_2				
	JP		Z,mort_monstre_phase_2
	cp		A,cycle_mort_3				
	JP		Z,mort_monstre_phase_3
	RET
efface_monstre_5
	ld		a,5
	ld		(identification_monstre_en_cours),a
	ld		a,(flag_etape_du_monstre5)
	cp		a,4
	call	test_collisions_items
	RET		Z
	ld		hl,(objet_laisse_5)
	ld		a,l
	cp		a,0
	jr		z,efface_event_monstre_5
	ld		(type_objet_laisse),a
	call	affiche_objet
	ld		a,4
	ld		(flag_etape_du_monstre5),a
	ret
efface_event_monstre_5
	ld		hl,(objet_laisse_5)
	ld		a,l
	ld		(type_objet),a
	call	compteur_objet
	call	asic_on
	xor		a
	LD		(event_MONSTRE5),a
	LD		(event_MONSTRE5+1),a
	LD		(event_MONSTRE5+2),a
	LD		(SPRH9_ZOOM),a
		ld		(flag_premort),a

	ld		(flag_monstre5),a
	ld		a,(type_objet)
	cp		a,0
	jr		z,on_zappe_la_vie_monstre5
	ld		a,1
	ld		(flag_ajoute_vie),a
	call	affiche_vies
on_zappe_la_vie_monstre5
	;ld 		c,2   
	;call 	PLY_AKG_StopSoundEffectFromChannel
	ret
	
	
monstre_5_en_objet
	LD		a,4
	LD		(flag_etape_du_monstre5),a
ret

