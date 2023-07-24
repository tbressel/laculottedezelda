; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////   DECOMPTE DES POINTS DE VIE DES MONSTRES       //////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
pre_mort_monstre_1
	ld		a,(flag_type_arme_utilise)
	cp		a,5									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_1_bombe
	cp		a,4									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_1_fleche
	cp		a,1									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_1_epee
	cp		a,epee_en_acier									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_1_epee


; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

pre_mort_monstre_1_bombe
	ld		a,(flag_boss_donjon)
	cp		A,0
	RET		Z
	ld		a,8
	ld		(BankROM),a
	call	rom_on
	call	dodongo_touche
	ld		hl,(nombre_de_coups_1)
	dec	l
	ld		(nombre_de_coups_1),hl
	ld		a,l
	cp		a,0
	jp		z,mort_boss_2
	call	soundfx_pre_mort_play
	RET
pre_mort_monstre_1_fleche
	ld		a,(flag_premort)
	cp		a,0
	RET	Z
	or		a						
	ld		de,puissance_fleche		; point de puissance de l'épée en cours
	ld		hl,(nombre_de_coups_1)
	push	hl
	ld		h,0
	sbc		hl,de
	pop 	de
	ld		e,l
	ex		hl,de
	jp		resultat_pre_mort_1
pre_mort_monstre_1_epee
		ld		a,(flag_premort)		; on arrive ici la première fois le flag est à mis à 1 dans fire 1 init (remis à zero plus bas)
									; ainsi que l'orsque le monstre est mort
		cp		a,0						; donc à 1 son passe et on configure la mort du monstre ou son recul
		RET		Z						; si il est à zero on revient d'ou l'on est pour avoir un décompte unitaire des points de vie du monstre
		or		a						
		ld		de,(puissance_epee)		; point de puissance de l'épée en cours
		ld		hl,(nombre_de_coups_1)	; points de vie du monstre
		push	hl
		ld		l,h						
		ld		h,0
		sbc		hl,de
		pop 	de
		ld		d,l
		ex		hl,de
	resultat_pre_mort_1
			ld		(nombre_de_coups_1),hl
			jp		z,mort_monstre_1		; si c'est à zero il est mort
			jp		c,mort_monstre_1		; si c'est négatif, il est mort aussi
			ld		a,(flag_monstre_1_touche)
			cp		a,1
			jr		z,pas_de_recul1
			ld		a,(flag_zelda)
			cp		a,1
			jp		z,pas_de_recul1
	; si link ne tue pas le monstre celui ci recul
			ld		a,1
			ld		(flag_monstre_1_touche),a				; la première fois qu'on passe ici le monstre est touché et immobilisé	
			ld		a,#CD									; on créer l'évenement du recul dans la boucle	
			ld		(event_recul_du_montre),a
			ld		hl,on_fait_reculer_le_monstre
			ld		(event_recul_du_montre+1),hl
			ld		a,(identification_monstre_en_cours)		; on recupère de quel monstre il s'agit
			ld		(monstre_a_faire_reculer),a				; et on stock lequel devra reculer 
			ld		a,(direction_en_cours)					; on recupère la direction de link
			ld		(direction_du_recul),a					; qui correspond à la direction du recul
			ld		hl,SPRH5_X
			ld		(recul_X_monstre),hl
			ld		hl,SPRH5_Y
			ld		(recul_Y_monstre),hl
			ld		hl,(SPRH_X)
			ld		(SPRH_X_recul),hl
			ld		hl,(SPRH_Y)
			ld		(SPRH_Y_recul),hl
		pas_de_recul1
				call	soundfx_pre_mort_play
				xor		a									; qu'on ait tué ou touché un monstre, il faut le remettre à zero
				ld		(flag_premort),a					; pour le prochain passage
				RET
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

pre_mort_monstre_2
ld		a,(flag_type_arme_utilise)
	cp		a,4									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_2_fleche
	cp		a,1									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_2_epee
	cp		a,epee_en_acier									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_2_epee
pre_mort_monstre_2_fleche
	ld		a,(flag_premort)
	cp		a,0
	RET	Z
	or		a						
	ld		de,puissance_fleche		; point de puissance de l'épée en cours
	ld		hl,(nombre_de_coups_2)
	push	hl
	ld		h,0
	sbc		hl,de
	pop 	de
	ld		e,l
	ex		hl,de
	jp		resultat_pre_mort_2
pre_mort_monstre_2_epee
	ld		a,(flag_premort)		; on arrive ici la première fois le flag est à mis à 1 dans fire 1 init (remis à zero plus bas)
									; ainsi que l'orsque le monstre est mort
	cp		a,0						; donc à 1 son passe et on configure la mort du monstre ou son recul
	RET		Z						; si il est à zero on revient d'ou l'on est pour avoir un décompte unitaire des points de vie du monstre
	or		a						
	ld		de,(puissance_epee)		; point de puissance de l'épée en cours
	ld		hl,(nombre_de_coups_2)	; points de vie du monstre
push	hl
		ld		l,h						
		ld		h,0
		sbc		hl,de
		pop 	de
		ld		d,l
		ex		hl,de
resultat_pre_mort_2
	ld		(nombre_de_coups_2),hl		; on sauvegarde 
	jp		z,mort_monstre_2		; si c'est à zero il est mort
	jp		c,mort_monstre_2		; si c'est négatif, il est mort aussi
	
	ld		a,(flag_monstre_2_touche)
	cp		a,1
	jr		z,pas_de_recul2
	ld		a,(flag_zelda)
	cp		a,1
	jp		z,pas_de_recul2
	; si link ne tue pas le monstre celui ci recul
	ld		a,1
	ld		(flag_monstre_2_touche),a				; la première fois qu'on passe ici le monstre est touché et immobilisé	
	ld		a,#CD									; on créer l'évenement du recul dans la boucle	
	ld		(event_recul_du_montre),a
	ld		hl,on_fait_reculer_le_monstre
	ld		(event_recul_du_montre+1),hl
	ld		a,(identification_monstre_en_cours)		; on recupère de quel monstre il s'agit
	ld		(monstre_a_faire_reculer),a				; et on stock lequel devra reculer 
	ld		a,(direction_en_cours)					; on recupère la direction de link
	ld		(direction_du_recul),a					; qui correspond à la direction du recul
	
	ld		hl,SPRH6_X
	ld		(recul_X_monstre),hl
	ld		hl,SPRH6_Y
	ld		(recul_Y_monstre),hl
	ld		hl,(SPRH_X)
	ld		(SPRH_X_recul),hl
		ld		hl,(SPRH_Y)
	ld		(SPRH_Y_recul),hl
pas_de_recul2
	call	soundfx_pre_mort_play
	xor		a									; qu'on ait tué ou touché un monstre, il faut le remettre à zero
	ld		(flag_premort),a					; pour le prochain passage
	RET





pre_mort_monstre_3
ld		a,(flag_type_arme_utilise)
	cp		a,4									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_3_fleche
	cp		a,1									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_3_epee
	cp		a,epee_en_acier									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_3_epee
pre_mort_monstre_3_fleche
	ld		a,(flag_premort)
	cp		a,0
	RET	Z
	or		a						
	ld		de,puissance_fleche		; point de puissance de l'épée en cours
	ld		hl,(nombre_de_coups_3)
push	hl
	ld		h,0
	sbc		hl,de
	pop 	de
	ld		e,l
	ex		hl,de
	jp		resultat_pre_mort_3
pre_mort_monstre_3_epee
ld		a,(flag_premort)		; on arrive ici la première fois le flag est à mis à 1 dans fire 1 init (remis à zero plus bas)
									; ainsi que l'orsque le monstre est mort
	cp		a,0						; donc à 1 son passe et on configure la mort du monstre ou son recul
	RET		Z						; si il est à zero on revient d'ou l'on est pour avoir un décompte unitaire des points de vie du monstre
	or		a						
	ld		de,(puissance_epee)		; point de puissance de l'épée en cours
	ld		hl,(nombre_de_coups_3)	; points de vie du monstre
	push	hl
		ld		l,h						
		ld		h,0
		sbc		hl,de
		pop 	de
		ld		d,l
		ex		hl,de
resultat_pre_mort_3
	ld		(nombre_de_coups_3),hl		; on sauvegarde 
	jp		z,mort_monstre_3		; si c'est à zero il est mort
	jp		c,mort_monstre_3		; si c'est négatif, il est mort aussi
	
	ld		a,(flag_monstre_3_touche)
	cp		a,1
	jr		z,pas_de_recul3
		ld		a,(flag_zelda)
	cp		a,1
	jp		z,pas_de_recul3
	; si link ne tue pas le monstre celui ci recul
	ld		a,1
	ld		(flag_monstre_3_touche),a				; la première fois qu'on passe ici le monstre est touché et immobilisé	
	ld		a,#CD									; on créer l'évenement du recul dans la boucle	
	ld		(event_recul_du_montre),a
	ld		hl,on_fait_reculer_le_monstre
	ld		(event_recul_du_montre+1),hl
	ld		a,(identification_monstre_en_cours)		; on recupère de quel monstre il s'agit
	ld		(monstre_a_faire_reculer),a				; et on stock lequel devra reculer 
	ld		a,(direction_en_cours)					; on recupère la direction de link
	ld		(direction_du_recul),a					; qui correspond à la direction du recul
	
	ld		hl,SPRH7_X
	ld		(recul_X_monstre),hl
	ld		hl,SPRH7_Y
	ld		(recul_Y_monstre),hl
	ld		hl,(SPRH_X)
	ld		(SPRH_X_recul),hl
		ld		hl,(SPRH_Y)
	ld		(SPRH_Y_recul),hl
pas_de_recul3
	call	soundfx_pre_mort_play
	xor		a									; qu'on ait tué ou touché un monstre, il faut le remettre à zero
	ld		(flag_premort),a					; pour le prochain passage
	RET
	




pre_mort_monstre_4
ld		a,(flag_type_arme_utilise)
	cp		a,4									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_4_fleche
	cp		a,1									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_4_epee
		cp		a,epee_en_acier									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_4_epee
pre_mort_monstre_4_fleche
	ld		a,(flag_premort)
	cp		a,0
	RET	Z
	or		a						
	ld		de,puissance_fleche		; point de puissance de l'épée en cours
	ld		hl,(nombre_de_coups_4)
push	hl
	ld		h,0
	sbc		hl,de
	pop 	de
	ld		e,l
	ex		hl,de
	jp		resultat_pre_mort_4
pre_mort_monstre_4_epee
	ld		a,(flag_premort)		; on arrive ici la première fois le flag est à mis à 1 dans fire 1 init (remis à zero plus bas)
									; ainsi que l'orsque le monstre est mort
	cp		a,0						; donc à 1 son passe et on configure la mort du monstre ou son recul
	RET		Z						; si il est à zero on revient d'ou l'on est pour avoir un décompte unitaire des points de vie du monstre
	or		a						
	ld		de,(puissance_epee)		; point de puissance de l'épée en cours
	ld		hl,(nombre_de_coups_4)	; points de vie du monstre
	push	hl
		ld		l,h						
		ld		h,0
		sbc		hl,de
		pop 	de
		ld		d,l
		ex		hl,de
resultat_pre_mort_4
	ld		(nombre_de_coups_4),hl		; on sauvegarde 
	jp		z,mort_monstre_4		; si c'est à zero il est mort
	jp		c,mort_monstre_4		; si c'est négatif, il est mort aussi
	
	ld		a,(flag_monstre_4_touche)
	cp		a,1
	jr		z,pas_de_recul4
		ld		a,(flag_zelda)
	cp		a,1
	jp		z,pas_de_recul4
	; si link ne tue pas le monstre celui ci recul
	ld		a,1
	ld		(flag_monstre_4_touche),a				; la première fois qu'on passe ici le monstre est touché et immobilisé	
	ld		a,#CD									; on créer l'évenement du recul dans la boucle	
	ld		(event_recul_du_montre),a
	ld		hl,on_fait_reculer_le_monstre
	ld		(event_recul_du_montre+1),hl
	ld		a,(identification_monstre_en_cours)		; on recupère de quel monstre il s'agit
	ld		(monstre_a_faire_reculer),a				; et on stock lequel devra reculer 
	ld		a,(direction_en_cours)					; on recupère la direction de link
	ld		(direction_du_recul),a					; qui correspond à la direction du recul
	
	ld		hl,SPRH8_X
	ld		(recul_X_monstre),hl
	ld		hl,SPRH8_Y
	ld		(recul_Y_monstre),hl
	ld		hl,(SPRH_X)
	ld		(SPRH_X_recul),hl
		ld		hl,(SPRH_Y)
	ld		(SPRH_Y_recul),hl
pas_de_recul4
	call	soundfx_pre_mort_play
	xor		a									; qu'on ait tué ou touché un monstre, il faut le remettre à zero
	ld		(flag_premort),a					; pour le prochain passage
	RET






pre_mort_monstre_5
ld		a,(flag_type_arme_utilise)
	cp		a,4									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_5_fleche
	cp		a,1									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_5_epee
			cp		a,epee_en_acier									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_5_epee

pre_mort_monstre_5_fleche
	ld		a,(flag_premort)
	cp		a,0
	RET	Z
	or		a						
	ld		de,puissance_fleche		; point de puissance de l'épée en cours
	ld		hl,(nombre_de_coups_5)
	push	hl
	ld		h,0
	sbc		hl,de
	pop 	de
	ld		e,l
	ex		hl,de
	jp		resultat_pre_mort_5
pre_mort_monstre_5_epee
ld		a,(flag_premort)		; on arrive ici la première fois le flag est à mis à 1 dans fire 1 init (remis à zero plus bas)
									; ainsi que l'orsque le monstre est mort
	cp		a,0						; donc à 1 son passe et on configure la mort du monstre ou son recul
	RET		Z						; si il est à zero on revient d'ou l'on est pour avoir un décompte unitaire des points de vie du monstre
	or		a						
	ld		de,(puissance_epee)		; point de puissance de l'épée en cours
	ld		hl,(nombre_de_coups_5)	; points de vie du monstre
	push	hl
		ld		l,h						
		ld		h,0
		sbc		hl,de
		pop 	de
		ld		d,l
		ex		hl,de
resultat_pre_mort_5
	ld		(nombre_de_coups_5),hl		; on sauvegarde 
	jp		z,mort_monstre_5		; si c'est à zero il est mort
	jp		c,mort_monstre_5		; si c'est négatif, il est mort aussi
	
	ld		a,(flag_monstre_5_touche)
	cp		a,1
	jr		z,pas_de_recul5
		ld		a,(flag_zelda)
	cp		a,1
	jp		z,pas_de_recul5
	; si link ne tue pas le monstre celui ci recul
	ld		a,1
	ld		(flag_monstre_5_touche),a				; la première fois qu'on passe ici le monstre est touché et immobilisé	
	ld		a,#CD									; on créer l'évenement du recul dans la boucle	
	ld		(event_recul_du_montre),a
	ld		hl,on_fait_reculer_le_monstre
	ld		(event_recul_du_montre+1),hl
	ld		a,(identification_monstre_en_cours)		; on recupère de quel monstre il s'agit
	ld		(monstre_a_faire_reculer),a				; et on stock lequel devra reculer 
	ld		a,(direction_en_cours)					; on recupère la direction de link
	ld		(direction_du_recul),a					; qui correspond à la direction du recul
	
	ld		hl,SPRH9_X
	ld		(recul_X_monstre),hl
	ld		hl,SPRH9_Y
	ld		(recul_Y_monstre),hl
	ld		hl,(SPRH_X)
	ld		(SPRH_X_recul),hl
		ld		hl,(SPRH_Y)
	ld		(SPRH_Y_recul),hl
pas_de_recul5
	call	soundfx_pre_mort_play
	xor		a									; qu'on ait tué ou touché un monstre, il faut le remettre à zero
	ld		(flag_premort),a					; pour le prochain passage
	RET






pre_mort_monstre_6
ld		a,(flag_type_arme_utilise)
	cp		a,4									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_6_fleche
	cp		a,1									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_6_epee
	cp		a,epee_en_acier									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_6_epee
pre_mort_monstre_6_fleche
	ld		a,(flag_premort)
	cp		a,0
	RET	Z
	or		a						
	ld		de,puissance_fleche		; point de puissance de l'épée en cours
	ld		hl,(nombre_de_coups_6)
	push	hl
	ld		h,0
	sbc		hl,de
	pop 	de
	ld		e,l
	ex		hl,de
	jp		resultat_pre_mort_6
pre_mort_monstre_6_epee
	ld		a,(flag_premort)		; on arrive ici la première fois le flag est à mis à 1 dans fire 1 init (remis à zero plus bas)
									; ainsi que l'orsque le monstre est mort
	cp		a,0						; donc à 1 son passe et on configure la mort du monstre ou son recul
	RET		Z						; si il est à zero on revient d'ou l'on est pour avoir un décompte unitaire des points de vie du monstre
	or		a						
	ld		de,(puissance_epee)		; point de puissance de l'épée en cours
	ld		hl,(nombre_de_coups_6)	; points de vie du monstre
	push	hl
		ld		l,h						
		ld		h,0
		sbc		hl,de
		pop 	de
		ld		d,l
		ex		hl,de
resultat_pre_mort_6
	ld		(nombre_de_coups_6),hl		; on sauvegarde 
	jp		z,mort_monstre_6		; si c'est à zero il est mort
	jp		c,mort_monstre_6		; si c'est négatif, il est mort aussi
	
	ld		a,(flag_monstre_6_touche)
	cp		a,1
	jr		z,pas_de_recul6
		ld		a,(flag_zelda)
	cp		a,1
	jp		z,pas_de_recul6
	; si link ne tue pas le monstre celui ci recul
	ld		a,1
	ld		(flag_monstre_6_touche),a				; la première fois qu'on passe ici le monstre est touché et immobilisé	
	ld		a,#CD									; on créer l'évenement du recul dans la boucle	
	ld		(event_recul_du_montre),a
	ld		hl,on_fait_reculer_le_monstre
	ld		(event_recul_du_montre+1),hl
	ld		a,(identification_monstre_en_cours)		; on recupère de quel monstre il s'agit
	ld		(monstre_a_faire_reculer),a				; et on stock lequel devra reculer 
	ld		a,(direction_en_cours)					; on recupère la direction de link
	ld		(direction_du_recul),a					; qui correspond à la direction du recul
	
	ld		hl,SPRH10_X
	ld		(recul_X_monstre),hl
	ld		hl,SPRH10_Y
	ld		(recul_Y_monstre),hl
	ld		hl,(SPRH_X)
	ld		(SPRH_X_recul),hl
		ld		hl,(SPRH_Y)
	ld		(SPRH_Y_recul),hl
pas_de_recul6
	call	soundfx_pre_mort_play
	xor		a									; qu'on ait tué ou touché un monstre, il faut le remettre à zero
	ld		(flag_premort),a					; pour le prochain passage
	RET






pre_mort_monstre_7
	ld		a,(flag_type_arme_utilise)
	cp		a,4									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_7_fleche
	cp		a,1									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_7_epee
		cp		a,epee_en_acier									; 4 designe l'utilisation d'une flêche
	jp		z,pre_mort_monstre_7_epee
pre_mort_monstre_7_fleche
ld		a,(flag_premort)
	cp		a,0
	RET	Z
	or		a						
	ld		de,puissance_fleche		; point de puissance de l'épée en cours
	ld		hl,(nombre_de_coups_7)
	push	hl
	ld		h,0
	sbc		hl,de
	pop 	de
	ld		e,l
	ex		hl,de
	jp		resultat_pre_mort_7
pre_mort_monstre_7_epee	
ld		a,(flag_premort)		; on arrive ici la première fois le flag est à mis à 1 dans fire 1 init (remis à zero plus bas)
									; ainsi que l'orsque le monstre est mort
	cp		a,0						; donc à 1 son passe et on configure la mort du monstre ou son recul
	RET		Z						; si il est à zero on revient d'ou l'on est pour avoir un décompte unitaire des points de vie du monstre
	or		a						
	ld		de,(puissance_epee)		; point de puissance de l'épée en cours
	ld		hl,(nombre_de_coups_7)	; points de vie du monstre
push	hl
		ld		l,h						
		ld		h,0
		sbc		hl,de
		pop 	de
		ld		d,l
		ex		hl,de
resultat_pre_mort_7
	ld		(nombre_de_coups_7),hl		; on sauvegarde 
	jp		z,mort_monstre_7		; si c'est à zero il est mort
	jp		c,mort_monstre_7		; si c'est négatif, il est mort aussi
	
	ld		a,(flag_monstre_7_touche)
	cp		a,1
	jr		z,pas_de_recul7
	ld		a,(flag_zelda)
	cp		a,1
	jp		z,pas_de_recul7
	; si link ne tue pas le monstre celui ci recul
	ld		a,1
	ld		(flag_monstre_7_touche),a				; la première fois qu'on passe ici le monstre est touché et immobilisé	
	ld		a,#CD									; on créer l'évenement du recul dans la boucle	
	ld		(event_recul_du_montre),a
	ld		hl,on_fait_reculer_le_monstre
	ld		(event_recul_du_montre+1),hl
	ld		a,(identification_monstre_en_cours)		; on recupère de quel monstre il s'agit
	ld		(monstre_a_faire_reculer),a				; et on stock lequel devra reculer 
	ld		a,(direction_en_cours)					; on recupère la direction de link
	ld		(direction_du_recul),a					; qui correspond à la direction du recul
	
	ld		hl,SPRH11_X
	ld		(recul_X_monstre),hl
	ld		hl,SPRH11_Y
	ld		(recul_Y_monstre),hl
	ld		hl,(SPRH_X)
	ld		(SPRH_X_recul),hl
	ld		hl,(SPRH_Y)
	ld		(SPRH_Y_recul),hl
pas_de_recul7
	call	soundfx_pre_mort_play
	xor		a									; qu'on ait tué ou touché un monstre, il faut le remettre à zero
	ld		(flag_premort),a					; pour le prochain passage
	RET


pre_mort_poisson
	ld		a,(nombre_de_coups_P)
	dec		a
	ld		(nombre_de_coups_P),a
	cp		a,0
	jp		z,mort_definitive_ou_objet
	call	soundfx_pre_mort_play
	RET
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	
fin_du_recul
	xor		a
	ld		(flag_recul_en_cours),a
	ld		(event_recul_du_montre),a
	ld		(event_recul_du_montre+1),a
	ld		(event_recul_du_montre+2),a
	ld		(direction_du_recul),a
	ld		ix,TABLEAU_MONSTRES_TOUCHES
	ld		(ix),a
	ld		(ix+1),a
	ld		(ix+2),a
	ld		(ix+3),a
	ld		(ix+4),a
	ld		(ix+5),a
	ld		(ix+6),a
	ld		a,longueur_recul_monstre	
	ld		(compteur_de_recul),a
	ret

calcul_du_reculX
				ld		de,(SPRH_X_recul)					; on reprends les coordonnée modifié et on les met dans de
				ld		hl,(recul_X_monstre)		; on récupère l'adresse ASIC des coordonnées du sprites
				ld		a,e								
				ld		(hl),a
				inc		l
				ld		a,d								
				ld		(hl),a
				ret

calcul_du_reculY
				ld		de,(SPRH_Y_recul)					; on reprends les coordonnée modifié et on les met dans de
				ld		hl,(recul_Y_monstre)		; on récupère l'adresse ASIC des coordonnées du sprites
				ld		a,e								
				ld		(hl),a
				inc		l
				ld		a,d								
				ld		(hl),a
				ret

dodongo_touche
	ld		a,(direction_en_cours_boss2)
	cp		a,gauche
	jp		z,dodongo_bouffe_bombe_gauche
	cp		a,droite
	jp		z,dodongo_bouffe_bombe_droite
	cp		a,haut
	jp		z,dodongo_bouffe_bombe_haut
	cp		a,bas
	jp		z,dodongo_bouffe_bombe_bas

dodongo_bouffe_bombe_gauche
	
	ld		hl,BOSS2_G3A
	ld		de,SPRH5_ADR
	ld		bc,#200
	LDIR
	
	RET
dodongo_bouffe_bombe_droite
	
	ld		hl,BOSS2_D3B
	ld		de,SPRH5_ADR
	ld		bc,#100
	LDIR
	ld		hl,BOSS2_D3A
	ld		de,SPRH6_ADR
	ld		bc,#100
	LDIR
	
	RET
dodongo_bouffe_bombe_haut
	
	ld		hl,BOSS2_H3
	ld		de,SPRH5_ADR
	ld		bc,#100
	LDIR
	ld		hl,BOSS2_H3
	ld		de,SPRH6_ADR
	ld		bc,#100
	LDIR
	
	RET
dodongo_bouffe_bombe_bas
	
	ld		hl,BOSS2_B3
	ld		de,SPRH5_ADR
	ld		bc,#100
	LDIR
	ld		hl,BOSS2_B3
	ld		de,SPRH6_ADR
	ld		bc,#100
	LDIR
	
	RET
	
	
link_clignote_ROM8
		call	asic_on
		ld		a,(compteur_invulnerable)
		cp		0
		jp		z,on_retablit_le_vert		
		ld		a,(cycle_colorisation_link)
		cp		a,0
		jp		z,link_clignote_passe_1
		cp		a,1
		jp		z,link_clignote_passe_2
	link_clignote_passe_1
			ld		hl,SPRH0_ADR				; on cible l'adresse du sprite hard 0 de link
			ld		b,255
		boucle_link_clignote_sprh0
				push	bc
				ld		a,(hl)						; on lit le premier octet
				cp		7							; est-il à #07 (vert clair)
				call 	z,on_le_met_en_blanc		; on colorie ce pixel en blanc
				inc		hl							; puis on selectione l'adresse suivante
				pop		bc
				djnz 	boucle_link_clignote_sprh0
				ld		hl,SPRH1_ADR				; on cible l'adresse du sprite hard 0 de link
				ld		b,255
			boucle_link_clignote_sprh1
					push	bc
					ld		a,(hl)						; on lit le premier octet
					cp		7							; est-il à #07 (vert clair)
					call 	z,on_le_met_en_blanc		; on colorie ce pixel en blanc
					inc		hl							; puis on selectione l'adresse suivante
					pop		bc
					djnz 	boucle_link_clignote_sprh1
					ld		a,1
					ld		(cycle_colorisation_link),a
					ret
			on_le_met_en_blanc
					ld		a,#0A
					ld		(hl),a
					ret
	link_clignote_passe_2
			ld		hl,SPRH0_ADR				; on cible l'adresse du sprite hard 0 de link
			ld		b,255
		boucle_link_clignote2_sprh0
				push	bc
				ld		a,(hl)						; on lit le premier octet
				cp		#0A							; est-il à #07 (vert clair)
				call 	z,on_le_met_en_vert		; on colorie ce pixel en blanc
				inc		hl							; puis on selectione l'adresse suivante
				pop		bc
				djnz 	boucle_link_clignote2_sprh0
				ld		hl,SPRH1_ADR				; on cible l'adresse du sprite hard 0 de link
				ld		b,255
		boucle_link_clignote2_sprh1
				push	bc
				ld		a,(hl)						; on lit le premier octet
				cp		#0A							; est-il à #07 (vert clair)
				call 	z,on_le_met_en_vert		; on colorie ce pixel en blanc
				inc		hl							; puis on selectione l'adresse suivante
				pop		bc
				djnz 	boucle_link_clignote2_sprh1
				ld		a,0
				ld		(cycle_colorisation_link),a
				ret
			on_le_met_en_vert
					ld		a,#07
					ld		(hl),a
					ret
on_retablit_le_vert
call	link_clignote_passe_2
xor		a
;ld		(event_link_clignote),a
;ld		(event_link_clignote+1),a
;ld		(event_link_clignote+2),a
ret




	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

