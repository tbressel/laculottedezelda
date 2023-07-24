POISSON_ZORA_ROM
ld	a,(No_PIECE)
	CP 	a,3
	JP	z,riviere1
	cp 	a,28
	JP	z,riviere1
	cp	a,78
	JP	z,riviere2
	cp	a,81
	jp	z,riviere_haut
	cp	a,79
	jp	z,riviere_haut2
	cp	a,80
	jp	z,riviere_haut2
	cp	a,71
	jp	z,rive_gauche
	cp	a,72
	jp	z,rive_haut_gauche
	cp	a,73
	jp	z,rive_haut
	cp	a,74
	jp	z,rive_haut_gauche
	cp	a,107
	jp	z,rive_bas
	cp	a,76
	jp	z,rive_bas_droite
	cp	a,109
	jp	z,rive_bas_droite
	cp	a,70
	jp	z,rive_bas_gauche2
	cp	a,108
	jp	z,rive_droite
	cp	a,12
	jp	z,rive_droite
	cp	a,21
	jp	z,rive_bas_gauche2
	cp	a,22
	jp	z,rive_haut_gauche
	cp	a,23
	jp	z,rive_bas_droite
	cp	a,24
	JP	z,rive_haut_droite
	cp	a,7
	jp	z,rive_bas
	cp	a,8
	jp	z,rive_bas2
	cp	a,9
	jp	z,rive_bas3
	cp	a,10
	jp	z,rive_bas2
	cp	a,55
	jp	z,rive_droite
	cp	a,57
	jp	z,rive_haut_droite
	cp	a,58
	JP	z,rive_haut_droite
	cp	a,59
	jp	z,rive_droite
	cp	a,60
	JP	z,rive_haut_droite
	cp	a,90
	JP	z,etang
	
	
	
	ret
	
	
; **********************************************************************
; ********************* RECUPERATION DES DONNES ************************
; **********************************************************************

rive_gauche
ld		a,(position_zora)
	cp		a,1
	jp		z,rive_gauche_pos_1
	cp		a,2
	jp		z,rive_gauche_pos_2
	rive_gauche_pos_1
	ld		hl,128
	ld		(ZORA_en_X),hl
	ld		hl,144
	ld		(ZORA_en_Y),hl
	ret
	rive_gauche_pos_2
	ld		hl,96
	ld		(ZORA_en_X),hl
	ld		hl,192
	ld		(ZORA_en_Y),hl
	ret
rive_droite
ld		a,(position_zora)
	cp		a,1
	jp		z,rive_droite_pos_1
	cp		a,2
	jp		z,rive_droite_pos_2
	rive_droite_pos_1
	ld		hl,416
	ld		(ZORA_en_X),hl
	ld		hl,144
	ld		(ZORA_en_Y),hl
	ret
	rive_droite_pos_2
	ld		hl,448
	ld		(ZORA_en_X),hl
	ld		hl,208
	ld		(ZORA_en_Y),hl
	ret
rive_bas_droite
ld		a,(position_zora)
	cp		a,1
	jp		z,rive_bas_droite_pos_1
	cp		a,2
	jp		z,rive_bas_droite_pos_2
	rive_bas_droite_pos_1
	ld		hl,416
	ld		(ZORA_en_X),hl
	ld		hl,208
	ld		(ZORA_en_Y),hl
	ret
	rive_bas_droite_pos_2
	ld		hl,320
	ld		(ZORA_en_X),hl
	ld		hl,192
	ld		(ZORA_en_Y),hl
	ret
rive_bas_gauche
ld		a,(position_zora)
	cp		a,1
	jp		z,rive_bas_gauche_pos_1
	cp		a,2
	jp		z,rive_bas_gauche_pos_2
	rive_bas_gauche_pos_1
	ld		hl,416
	ld		(ZORA_en_X),hl
	ld		hl,144
	ld		(ZORA_en_Y),hl
	ret
	rive_bas_gauche_pos_2
	ld		hl,128
	ld		(ZORA_en_X),hl
	ld		hl,128
	ld		(ZORA_en_Y),hl
	ret
rive_bas_gauche2
	ld		a,(position_zora)
	cp		a,1
	jp		z,rive_bas_gauche2_pos_1
	cp		a,2
	jp		z,rive_bas_gauche2_pos_2
	rive_bas_gauche2_pos_1
	ld		hl,96
	ld		(ZORA_en_X),hl
	ld		hl,208
	ld		(ZORA_en_Y),hl
	ret
	rive_bas_gauche2_pos_2
	ld		hl,192
	ld		(ZORA_en_X),hl
	ld		hl,176
	ld		(ZORA_en_Y),hl
	ret
	
rive_haut_droite
ld		a,(position_zora)
	cp		a,1
	jp		z,rive_haut_droite_pos_1
	cp		a,2
	jp		z,rive_haut_droite_pos_2
	rive_haut_droite_pos_1
	ld		hl,288
	ld		(ZORA_en_X),hl
	ld		hl,144
	ld		(ZORA_en_Y),hl
	ret
	rive_haut_droite_pos_2
	ld		hl,384
	ld		(ZORA_en_X),hl
	ld		hl,128
	ld		(ZORA_en_Y),hl
	ret
rive_haut_gauche
ld		a,(position_zora)
	cp		a,1
	jp		z,rive_haut_gauche_pos_1
	cp		a,2
	jp		z,rive_haut_gauche_pos_2
	rive_haut_gauche_pos_1
	ld		hl,160
	ld		(ZORA_en_X),hl
	ld		hl,128
	ld		(ZORA_en_Y),hl
	ret
	rive_haut_gauche_pos_2
	ld		hl,96
	ld		(ZORA_en_X),hl
	ld		hl,112
	ld		(ZORA_en_Y),hl
	ret

riviere1
	ld		a,(position_zora)
	cp		a,1
	jp		z,riviere1_pos_1
	cp		a,2
	jp		z,riviere1_pos_2
	riviere1_pos_1
	ld		hl,160
	ld		(ZORA_en_X),hl
	ld		hl,128
	ld		(ZORA_en_Y),hl
	ret
	riviere1_pos_2
	ld		hl,192
	ld		(ZORA_en_X),hl
	ld		hl,192
	ld		(ZORA_en_Y),hl
	ret
riviere2
	ld		a,(position_zora)
	cp		a,1
	jp		z,riviere2_pos_1
	cp		a,2
	jp		z,riviere2_pos_2
	riviere2_pos_1
	ld		hl,288
	ld		(ZORA_en_X),hl
	ld		hl,144
	ld		(ZORA_en_Y),hl
	ret
	riviere2_pos_2
	ld		hl,192
	ld		(ZORA_en_X),hl
	ld		hl,176
	ld		(ZORA_en_Y),hl
	ret
riviere_haut
	ld		hl,192
	ld		(ZORA_en_X),hl
	ld		hl,144
	ld		(ZORA_en_Y),hl
	ret
rive_haut
riviere_haut2
	ld		a,(position_zora)
	cp		a,1
	jp		z,riviere_haut2_pos_1
	cp		a,2
	jp		z,riviere_haut2_pos_2
	riviere_haut2_pos_1
	ld		hl,128
	ld		(ZORA_en_X),hl
	ld		hl,144
	ld		(ZORA_en_Y),hl
	ret
	riviere_haut2_pos_2
	ld		hl,384
	ld		(ZORA_en_X),hl
	ld		hl,144
	ld		(ZORA_en_Y),hl
	ret

rive_bas
	ld		a,(position_zora)
	cp		a,1
	jp		z,rive_bas_pos_1
	cp		a,2
	jp		z,rive_bas_pos_2
	rive_bas_pos_1
	ld		hl,256
	ld		(ZORA_en_X),hl
	ld		hl,208
	ld		(ZORA_en_Y),hl
	ret
	rive_bas_pos_2
	ld		hl,384
	ld		(ZORA_en_X),hl
	ld		hl,192
	ld		(ZORA_en_Y),hl
	ret
rive_bas2
	ld		a,(position_zora)
	cp		a,1
	jp		z,rive_bas2_pos_1
	cp		a,2
	jp		z,rive_bas2_pos_2
	rive_bas2_pos_1
	ld		hl,64
	ld		(ZORA_en_X),hl
	ld		hl,224
	ld		(ZORA_en_Y),hl
	ret
	rive_bas2_pos_2
	ld		hl,352
	ld		(ZORA_en_X),hl
	ld		hl,176
	ld		(ZORA_en_Y),hl
	ret
rive_bas3
	ld		a,(position_zora)
	cp		a,1
	jp		z,rive_bas3_pos_1
	cp		a,2
	jp		z,rive_bas3_pos_2
	rive_bas3_pos_1
	ld		hl,256
	ld		(ZORA_en_X),hl
	ld		hl,176
	ld		(ZORA_en_Y),hl
	ret
	rive_bas3_pos_2
	ld		hl,128
	ld		(ZORA_en_X),hl
	ld		hl,208
	ld		(ZORA_en_Y),hl
	ret
etang
	ld		a,(position_zora)
	cp		a,1
	jp		z,etang_pos_1
	cp		a,2
	jp		z,etang_pos_2
	etang_pos_1
	ld		hl,192
	ld		(ZORA_en_X),hl
	ld		hl,192
	ld		(ZORA_en_Y),hl
	ret
	etang_pos_2
	ld		hl,256
	ld		(ZORA_en_X),hl
	ld		hl,160
	ld		(ZORA_en_Y),hl
	ret
	
	
INITIALISATION_ZORA_ROM
LD		a,1					
	LD		(flag_etape_du_poisson),a				; init termine flag a 1 pour etape de la naissance
	ld		(nombre_de_coups_p),a
	LD		a,init_naissance_boucle_zora
	LD		(compteur_naissance_poisson),a			; nombre de boucle pour faire durer la naissance
	LD		a,init_mort_boucle_zora
	LD		(compteur_mort_poisson),a
	LD		a,init_mort_boucle_zora
	LD		(compteur_mort_definitive),a
	LD		a,9
	LD		(SPRH12_ZOOM),a							; ZOOM
	ld		a,100
	ld		(compteur_poisson),a
	ld		(compteur_poisson_absent),a
	ret
	
	
	reinit_zora_ROM8
	LD		a,init_naissance_boucle_zora
	LD		(compteur_naissance_poisson),a
	LD		a,init_mort_boucle_zora
	LD		(compteur_mort_poisson),a
	LD		a,9
	LD		(SPRH12_ZOOM),a
	ld		hl,(SPRH_X)
	ld		(SPRH12_X),hl
	ld		(SPRH_X),hl
	ld		hl,(SPRH_Y)
	ld		(SPRH12_Y),hl
	ld		(SPRH_Y),hl
	ld		a,30
	ld		(compteur_poisson),a
	ld		(compteur_poisson_absent),a
	LD		a,0				
	LD		(flag_etape_du_poisson),a
	ld		a,(position_zora)
	cp		a,1
	jp		z,changer_position_1
	cp		a,2
	jp		z,changer_position_2
changer_position_1
	ld		a,2
	ld		(position_zora),a
	ret
changer_position_2
	ld		a,1
	ld		(position_zora),a
	ret


