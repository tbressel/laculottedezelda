MONSTRE_1
	
; **********************************************************************
; ********************* RECUPERATION DES DONNES ************************
; **********************************************************************
	ld		a,(flag_monstre_1_touche)
	or		a
	ret		nz
	LD		a,(bankROM_monstre_1)					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	LD		hl,(TYPE_MONSTRE1_ADR)					; Adresse en ROM du type de monstre choisit en table d'init
	LD		(TYPE_MONSTRE_ADR),hl
	LD		hl,(SPRH_MONSTRE1_ADR)					; Sprite Hard ASIC de destination
	LD		(SPRH_ADR),hl
	LD		hl,(SPRH5_X)							; récupération de la position X acutelle
	LD		(SPRH_X),hl
	LD		hl,(SPRH5_Y)							; récupération de la position Y actuelle
	LD		(SPRH_Y),hl	
	LD		a,(flag_etape_du_monstre1)				; A=0 il na pas encore poppé
	CP		a,1
	JP		z,naissance_monstre_1					; A=1 intit termine, naissance debut ou en cours
	CP		a,2
	JP		z,update_monstre_1						; monstre affiche, pret a metre a jour
	CP		a,3
	JP		z,mort_monstre_1
	cp		a,4
	jp		z,EFFACE_MONSTRE_1
	cp		a,5
	jp		z,defonce_cul_zelda
INIT_MONSTRE_1
		CALL	calcul_piece_monstre				; 5 on recupere dans de la valeur a ajouter
		LD		(resultat_piece_monstre),de			; 6 je la sauvegarde pour plus tard
		ld		a,18
		ld		(bankROM),a
		call	rom_on	
		LD		hl,table_init_monstre_1				; 3 Adresse de la table d'init du monstre 1
		add		hl,de								; 3 on ajoute le No de la piece pour tomber sur la bonne ligne
		LD		(pointeur_monstres),hl				; 6 je la sauvagarde pour plus tard
			LD	de,VARIABLE_INIT_MONSTRE_1			; 3 cible des suites de variable
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
		LD		de,VARIABLE_INIT_MONSTRE_1+8		; on rechange le pointeur ecriture
		LDI											; presence de zora ou non
		LDI											; numeros de l'objet laissé
		call 	rom_off
		LD		a,1					
		LD		(flag_etape_du_monstre1),a			; init termine flag a 1 pour etape de la naissance
		LD		a,init_naissance_boucle
		LD		(compteur_naissance_monstre_1),a
		LD		a,init_mort_boucle
		LD		(compteur_mort_monstre_1),a
		LD		a,init_anim_boucle
		LD 		(compteur_anim_monstre_1),a
	REINIT_DEPLACEMENTS_MONSTRE_1
			LD		hl,table_depX_monstre_1					; hl contient l'adresse de la table monstre 1
			LD		(pointeur_depX_monstre_1),hl	 
			LD		ix,(pointeur_depX_monstre_1)
			LD		(pointeur_direction),ix
			LD		a,(ix)									; on lit le nombre de pas X de direction
			LD		(compteur_depX_monstre_1),a
			LD		hl,table_depY_monstre_1					; hl contient l'adresse de la table monstre 1
			LD		(pointeur_depY_monstre_1),hl	 
			LD		iy,(pointeur_depy_monstre_1)
			LD		(pointeur_direction+2),iy
			LD		a,(iy)									; on lit le nombre de pas Y de direction
			LD		(compteur_depY_monstre_1),a
			LD		a,nbr_direction
			LD		(compteur_direction),a
			ret
	
; **********************************************************************
; *************** NAISSANCE et ANIMATION DES MONSTRES ******************
; **********************************************************************

NAISSANCE_MONSTRE_1
	LD		a,(compteur_naissance_monstre_1)
	dec		a										; il est a 15
	LD		(compteur_naissance_monstre_1),a		; on le sauvegarde pour le prochain tour
	CP		a,0										; on verifie si il est a zero ou pas
	Jr		Z,affiche_monstre_1						; si il est a zero la naissance est terminee
	CP		A,cycle_naissance_1				
	JP		Z,naissance_monstre_phase_1
	CP		A,cycle_naissance_2				
	JP		Z,naissance_monstre_phase_2
	CP		A,cycle_naissance_3				
	JP		Z,naissance_monstre_phase_3
	RET	
AFFICHE_MONSTRE_1
	LD		a,2
	LD		(flag_etape_du_monstre1),a
	call	rom_on
	LD		hl,(TYPE_MONSTRE_ADR)
	LD		(SPRH5_ANIM_1),hl
	LD		hl,(SPRH5_ANIM_1)
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	call	rom_off
	ld		a,1
	ld		(flag_monstre1),a
	;ld		a,(flag_ocean)
	;or		a
	;call	nz,monstre_1_en_objet
	RET
UPDATE_MONSTRE_1
	call 	test_collisions
	ld		a,1
	ld		(identification_monstre_en_cours),a
	call 	collision_fleche
	call 	collision_epee
	ld		a,(flag_stop_monstres)
	or		a
	RET		NZ
	LD		a,(compteur_anim_monstre_1)					; on recupere le compteur qui est a xx
	dec		a											; il est a xx-1
	LD		(compteur_anim_monstre_1),a					; on le sauvegarde pour le prochain tour
	CP		A,cycle_anim_1			
	Jr		Z,anim_monstre_1_phase_1
	CP		A,cycle_anim_2				
	Jr		Z,anim_monstre_1_phase_2
	CP		A,0
	JP		Z,anim_monstre_1_reinit
	call	deplacement
	RET
ANIM_MONSTRE_1_PHASE_1
	call	deplacement
	LD		a,(flag_etape_du_monstre1)
	CP		a,3
	RET		Z
	LD		a,(bankROM_monstre_1)					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	LD		hl,(SPRH5_ANIM_1)							; adresse du sprite dans la RAM
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	call	rom_off
	RET
ANIM_MONSTRE_1_PHASE_2
	call	deplacement
	LD		a,(bankROM_monstre_1)					; numero de ROM où se trouve le monstre
	LD		(bankROM),a
	call	rom_on
	LD		hl,(SPRH5_ANIM_2)
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	call	rom_off
	RET
ANIM_MONSTRE_1_REINIT
	LD		a,init_anim_boucle				; cycle d'animation termine on re initialise le compteur
	LD 		(compteur_anim_monstre_1),a				; pour le prochain cycle
	JP 		anim_monstre_1_phase_1	
	call	deplacement
	ret

; **********************************************************************
; ********************* DEPLACEMENT  DES MONSTRES **********************
; **********************************************************************

DEPLACEMENT
;	LD		a,(flag_etat_du_dep)
;	CP		a,0
;	JP		z,deplacement_init
;	JR		on_bouge
DEPLACEMENT_INIT
;	LD		a,1
;	LD		(flag_etat_du_dep),a
;	ret
ON_BOUGE
	ld		hl,(SPRH5_X)
	ld		(SPRH_X),hl
	;ld		(SPRH_X_recul),hl
	ld		hl,(SPRH5_Y)
	ld		(SPRH_Y),hl
	;ld		(SPRH_Y_recul),hl
	call	nombre_animations_monstre
	;call 	test_collisions
	;ld		a,1
	;ld		(identification_monstre_en_cours),a
	;call 	collision_fleche
	;call 	collision_epee
EN_X
	LD		a,(compteur_depX_monstre_1)
	CP		a,0
	JP		z,en_Y
	bit		7,a
	Jr		Z,vers_la_droite
	Jr 		vers_la_gauche
VERS_LA_DROITE
	dec 	a
	LD		(compteur_depX_monstre_1),a
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		a
	jr		nz,pas_de_collisions_droit_monstre1
	call 	collision_droite
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction
pas_de_collisions_droit_monstre1	
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	VERS_LA_DROITE_ROM
	call	rom_off
	
	
	
	
	
calc_finanim_droite_monstre1
; test de la collision avec le bord droite de l'écran
	ld		de,	(SPRH5_X)							 ;on récupere les coordonnée Y de Link
	OR		A										 ;on remet les flag à zero
	LD		hl,limite_bord_droit_monstres								 ;on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction						;	 egale à zéro on va vers le bas
	JR		en_Y
VERS_LA_GAUCHE
	inc 	a
	LD		(compteur_depX_monstre_1),a
; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		a
	jr		nz,pas_de_collisions_gauche_monstre1
	call 	collision_gauche
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction
pas_de_collisions_gauche_monstre1	
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	VERS_LA_GAUCHE_ROM
	call	rom_off
; test de la collision avec le bord gauche de l'écran
	ld		hl,(SPRH5_X)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		DE,limite_bord_gauche_monstres								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction							; egale à zéro on va vers le bas
EN_Y
	LD		a,(compteur_depY_monstre_1)
	OR		A
	JP		Z,test_compteur_X
	bit		7,a
	JR		z,vers_le_bas
	JR		vers_le_haut
VERS_LE_BAS
	dec 	a
	LD		(compteur_depY_monstre_1),a
	; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		a
	jr		nz,pas_de_collisions_bas_monstre1
	call 	collision_bas
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction
pas_de_collisions_bas_monstre1
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	VERS_LE_BAS_ROM
	call	rom_off	
; test de la collision avec le bord bas de l'écran
	ld		de,(SPRH5_Y)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		hl,limite_bord_bas_monstre								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction							; egale à zéro on va vers le bas
	RET
VERS_LE_HAUT
	inc 	a
	LD		(compteur_depY_monstre_1),a
; test de la collision avec le décors
	ld		a,(flag_peahat)
	or		a
	jr		nz,pas_de_collisions_haut_monstre1
	call 	collision_haut
	ld		B,114
	ld		A,(ntile_spr0)	
	SBC		A,B
	JP		NC,changement_direction
pas_de_collisions_haut_monstre1
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	VERS_LE_HAUT_ROM
	call	rom_off	
; test de la collision avec le bord haut de l'écran
	ld		hl,	(SPRH5_Y)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		DE,limite_bord_haut_monstre							; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE
	JR		C,changement_direction							; egale à zéro on va vers le bas
	ret
TEST_COMPTEUR_X
	LD		a,(compteur_depX_monstre_1)
	OR		A
	JR		z,changement_direction
	ret
CHANGEMENT_DIRECTION
	LD		a,(compteur_direction)
	dec		a
	LD		(compteur_direction),a
	CP		a,0
	JP		z,reinit_deplacements_monstre_1
	LD		hl,(pointeur_direction)		; 5 nops
	inc		l							; 1 nop	
	LD		(pointeur_direction),hl		; 5 nops
	LD		a,(hl)						; 2 nops
	LD		(compteur_depX_monstre_1),a ; 4 nops
	LD		hl,(pointeur_direction+2)
	inc		l
	LD		(pointeur_direction+2),hl
	LD		a,(hl)
	LD		(compteur_depY_monstre_1),a
	ret
MORT_MONSTRE_1
	ld		a,(flag_no_donjon)
	cp		a,0
	jr		z,pas_de_test_de_boss
	cp		a,1
	jp		z,test_de_mort_du_boss_1
	cp		a,3
	jp		z,test_de_mort_du_boss_3
	cp		a,4
	jp		z,test_de_mort_du_boss_4
test_de_mort_du_boss_1
	ld		a,(flag_boss_donjon)					; on arrive ici quand un boss meurt en sortie de collision 'link tue"
	or		a
	jp		nz,mort_boss_1
test_de_mort_du_boss_3
	ld		a,(flag_boss_donjon)					; on arrive ici quand un boss meurt en sortie de collision 'link tue"
	or		a
	jp		nz,mort_boss_3
test_de_mort_du_boss_4
	ld		a,(flag_boss_donjon)					; on arrive ici quand un boss meurt en sortie de collision 'link tue"
	or		a
	jp		nz,mort_boss_4
pas_de_test_de_boss
	LD		a,3
	LD		(flag_etape_du_monstre1),a
	LD		a,(compteur_mort_monstre_1)
	dec		a								; il est a 15
	LD		(compteur_mort_monstre_1),a		; on le sauvegarde pour le prochain tour
	CP		a,0									; on verifie si il est a zero ou pas
	Jr		Z,efface_monstre_1					; si il est a zero la naissance est terminee
	CP		A,cycle_mort_1				
	JP		Z,mort_monstre_phase_1
	CP		A,cycle_mort_2				
	JP		Z,mort_monstre_phase_2
	CP		A,cycle_mort_3				
	JP		Z,mort_monstre_phase_3
	ret
EFFACE_MONSTRE_1
	ld		a,1
	ld		(identification_monstre_en_cours),a
	ld		a,(flag_etape_du_monstre1)
	cp		a,4
	call	test_collisions_items
	RET		Z
	
	ld		hl,(objet_laisse_1)				; on lit le numeo de l'objet (lu dans la table du monstre 1 et placé ensuite dans cette variable.)
	ld		a,l								; on a récupéré dans L mais on compare qu'avec A donc on transfert.		
	cp		a,0								; si l'objet est le numéro 0
	jr		z,efface_event_monstre_1		; alors y'a aucun objet de laissé, donc on peut effacer l'vent monstre de la boucle
	ld		(type_objet_laisse),a			; MAIS si l'objet est identifié autre que zéros on le met dans le type d'objet pour l'identifier après
	call	affiche_objet					; puis on affiche l'objet
	ld		a,4
	ld		(flag_etape_du_monstre1),a
	ret
efface_event_monstre_1
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	efface_event_monstre_1_ROM
	call	rom_off	
	ret
	
monstre_1_en_objet
	ld		a,(flag_chez_zelda)
	or		a
	JR		nz,init_chez_zelda
	LD		a,4
	LD		(flag_etape_du_monstre1),a
	ld		a,(No_PIECE)
	cp		a,220
	JR		z,init_jardin_zelda
	ret

init_chez_zelda
	xor		a
	LD		(flag_etape_du_monstre1),a
	ld		(flag_stop_monstres),a
	ret
init_jardin_zelda
	ld		a,1
	ld		(flag_stop_monstres),a
	xor		a
	ld		(flag_monstre1),a
	ld		(SPRH5_ZOOM),a
	ret

defonce_cul_zelda
	call 	collision_epee
	RET
