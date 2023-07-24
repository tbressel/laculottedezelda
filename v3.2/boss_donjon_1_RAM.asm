; /////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////// BOSS DU DONJON 1 - RAM///////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
boss_donjon_1
	ld		a,(flag_boss4_RIP)
	or		a
	ret		NZ
	call	del_off
	LD		hl,(SPRH5_X)							; récupération de la position X acutelle
	LD		(SPRH_X),hl
	LD		hl,(SPRH5_Y)							; récupération de la position Y actuelle
	LD		(SPRH_Y),hl	

	ld		a,(etape_boss_1)
	cp		a,0
	jr		z,init_variable_boss_1
	cp		a,1
	jr		z,init_sprite_boss_1
	cp		a,2
	jp		z,init_deplacement_boss_1
	cp		a,3
	jp		z,update_boss_1
	cp		a,4
	jp		z,recompense_boss_1
	ret

init_variable_boss_1
	ld		a,1
	ld		(etape_boss_1),a
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
	
	
	
	ld		a,1
	ld		(flag_boss_donjon),a
	LD		a,30
	LD		(bankROM),a
	call	rom_on
	LD		HL,#C000
	LD		DE,MEM_TAMPON_BOSS
	LD		BC,#1000
	LDIR
	call 	rom_off
	
	ld		a,#c3
	ld		(event_boss_3_boules_de_feu),a
	ld		hl,boss_3_boules_de_feu
	ld		(event_boss_3_boules_de_feu+1),hl
	xor		a
	ld		(etape_3_boule_de_feu),a
	ret

init_sprite_boss_1
	LD		a,2
	LD		(bankROM),a
	call	rom_on
	call	init_sprite_boss_1_ROM
	call	rom_off
	ret

reinit_deplacements_boss_1
init_deplacement_boss_1
	LD		a,2
	LD		(bankROM),a
	call	rom_on
	call	init_deplacement_boss_1_ROM
	call	rom_off
	RET


update_boss_1
	ld		a,(cycle_anim_boss_1)
	dec		a
	ld		(cycle_anim_boss_1),a
	cp		a,70
	jr		z,anim_boss1_etape_1
	cp		a,50
	jr		z,anim_boss1_etape_2
	cp		a,25
	jr		z,anim_boss1_etape_3
	cp		a,12
	jr		z,anim_boss1_etape_4
	cp		a,0
	jP		z,reinit_anim_boss1
	call	deplacement_boss_1
	ret

anim_boss1_etape_1
	ld	hl,BOSS1_RAM+#600
	ld	de,SPRH7_ADR
	ld	bc,#200
	LDIR
	call	deplacement_boss_1
	ret
anim_boss1_etape_2
	ld	hl,BOSS1_RAM+#400
	ld	de,SPRH7_ADR
	ld	bc,#200
	LDIR
	call	deplacement_boss_1
	ret
anim_boss1_etape_3
	ld	hl,BOSS1_RAM+#600
	ld	de,SPRH7_ADR
	ld	bc,#200
	LDIR
	call	deplacement_boss_1
	ret
anim_boss1_etape_4
	ld	hl,BOSS1_RAM+#200
	ld	de,SPRH5_ADR
	ld	bc,#200
	LDIR
	call	deplacement_boss_1
	ret
reinit_anim_boss1_ROM
	ld	a,71
	ld	(cycle_anim_boss_1),a
	ld	hl,BOSS1_RAM
	ld	de,SPRH5_ADR
	ld	bc,#200
	LDIR
	ld	hl,BOSS1_RAM+#400
	ld	de,SPRH7_ADR
	ld	bc,#200
	LDIR
	call	deplacement_boss_1
	ret



deplacement_boss_1
;	LD		a,(flag_etat_du_dep_boss1)
;	or		a
;	JP		z,deplacement_boss_1_init
;	Jr		on_bouge_boss1
deplacement_boss_1_init
;	LD		a,1
;	LD		(flag_etat_du_dep_boss1),a
;	ret
on_bouge_boss1
	ld		hl,(SPRH5_X)
	ld		(SPRH_X),hl
	call 	test_collisions
	ld		hl,(SPRH7_X)
	ld		(SPRH_X),hl
	call 	test_collisions
	
	ld		a,1
	ld		(identification_monstre_en_cours),a
	ld		hl,(SPRH5_X)
	ld		(SPRH_X),hl
	call 	collision_fleche
	ld		a,2
	ld		(identification_monstre_en_cours),a
	ld		hl,(SPRH7_X)
	ld		(SPRH_X),hl
	call 	collision_fleche
	
	
EN_X_boss1
	LD		a,(compteur_depX_boss_1)
	or		a
	JP		z,en_Y_boss1
	bit		7,a
	JR		Z,vers_la_droite_boss1
	JR 		vers_la_gauche_boss1
VERS_LA_DROITE_BOSS1
	dec 	a
	LD		(compteur_depX_boss_1),a
	LD		a,8
	LD		(bankROM),a
	call	rom_on
	call	VERS_LA_DROITE_BOSS1_ROM
	call	rom_off
; test de la collision avec le bord droite de l'écran
	ld		de,	(SPRH6_X)							 ;on récupere les coordonnée Y de Link
	OR		A										 ;on remet les flag à zero
	LD		hl,#01d0								 ;on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction_boss1						;	 egale à zéro on va vers le bas
	JP		en_Y_boss1
VERS_LA_GAUCHE_BOSS1
	dec 	a
	LD		(compteur_depX_boss_1),a
	LD		a,8
	LD		(bankROM),a
	call	rom_on
	call	VERS_LA_GAUCHE_BOSS1_ROM
	call	rom_off
; test de la collision avec le bord gauche de l'écran
	ld		de,	(SPRH5_X)							 ;on récupere les coordonnée Y de Link
	OR		A										 ;on remet les flag à zero
	LD		hl,#0016								 ;on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,changement_direction_boss1						;	 egale à zéro on va vers le bas
EN_Y_BOSS1
	LD		a,(compteur_depY_boss_1)
	CP		a,0
	JP		Z,test_compteur_X_boss1
	bit		7,a
	JR		z,vers_le_bas_boss1
	JP		vers_le_haut_boss1
VERS_LE_BAS_BOSS1
	dec 	a
	LD		(compteur_depY_boss_1),a
	LD		a,8
	LD		(bankROM),a
	call	rom_on
	call	VERS_LE_BAS_BOSS1_ROM
	call	rom_off
; test de la collision avec le bord bas de l'écran
	ld		de,(SPRH7_Y)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		hl,#00EB								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JR		C,changement_direction_boss1							; egale à zéro on va vers le bas
	RET
VERS_LE_HAUT_BOSS1
	dec 	a
	LD		(compteur_depY_boss_1),a
	LD		a,8
	LD		(bankROM),a
	call	rom_on
	call	VERS_LE_HAUT_BOSS1_ROM
	call	rom_off
	
	
; test de la collision avec le bord haut de l'écran
	ld		de,(SPRH5_Y)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		hl,#005A								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JR		C,changement_direction_boss1							; egale à zéro on va vers le bas
	RET
TEST_COMPTEUR_X_BOSS1
	LD		a,(compteur_depX_boss_1)
	CP		a,0
	JP		z,changement_direction_boss1
	ret
CHANGEMENT_DIRECTION_BOSS1
	LD		a,2
	LD		(bankROM),a
	call	rom_on
	call	CHANGEMENT_DIRECTION_BOSS1_ROM
	call	rom_off
	ret
reinit_anim_boss1
LD		a,2
LD		(bankROM),a
call	rom_on
call	reinit_anim_boss1_ROM
RET
mort_boss_1							; on arrive ici par un JP
LD		a,2
LD		(bankROM),a
call	rom_on
call	mort_boss_1_ROM
RET


	
	
	
