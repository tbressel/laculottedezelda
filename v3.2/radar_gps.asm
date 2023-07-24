; //////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////  EFFACER LE POINT GPS ACTUELLE ////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////
calcul_radar

		ld		(flag_radar),a							; 1=gauche, 2=droite, 3=haut, 4=bas  
		ld		hl,(gps)								; on recupere les coorodonne gps actuelles
		ld		a,(couleur_fond_gps)					; on prends la valeur de la couleur d'une case
		ld		(hl),a									; on efface le pixel du haut contenu a l'adresse hl
		ld		d,#08									
		ld		a,h				
		add	a,d
		ld		h,a										; on se place juste dessous ...
		ld		a,(couleur_fond2_gps)					; pour effacer le pixel du bas
		ld		(hl),a									; avec la couleur du fond
		ret



; //////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////  AFFICHER LE POINT GPS SUIVANT ////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////
AFFICHAGE_GPS
	
	LD		A,(No_BANK)					; on recupere d'abort dans quelle piece on est ? 
	CP		a,#C6
	call	z,C6_on
	CP		a,#C7
	call	z,C7_on
	CP		a,#C5
	call	z,C5_on
	
 
	LD	HL,(PIECE_ACTUELLE)				;HL est l'emplacement du premier numero de tile
	ld	de,-18
	add hl,de
	LD	A,(HL)							;on lit l'octet contenu a l'adresse HL
	LD 	(No_PIECE),A					;on stock le numero de la piece
	cp	93
	call	z,radar_on					; on ré active le radar pour certaine pièces dans lequelles
	cp	31								; un labyrinthe de pièce est existant
	call	z,radar_on
	cp	81
	call	z,radar_on
	cp	127
	call	z,radar_on

	
	ld 	a,(flag_radar)					; on récupère la direction vers laquelle le GPS va 
	cp	1								; devoir aller
	jr	z,radar_gauche
	cp	2
	jr	z,radar_droite
	cp	3
	jp	z,radar_haut
	cp	4
	jp	z,radar_bas




; //////////////////////////////  LE GPS VA VERS LA GAUCHE ////////////////////////////////////
radar_gauche
	ld		hl,(gps)						; on recupere l'adresse du gps1
	ld		a,(flag_radar_piece_special)	; on verifie qu'on est pas dans une piece chelou
	or		a								; c'est le cas si c'ets a 1
	jr		nz,on_ne_dec_pas					; et du coup on ne decremente pas le gps
	ld		de,(dep_gps_gauche)				; si c'est pas le cas on place la valeur initialisé
	add		hl,de							; pour avoir l'adresse ecran du gps gauche
on_ne_dec_pas
	ld		(gps),hl						; on sauve la nouvelle adresse gps
	ld		a,(couleur_link_gps)			; ainsi que la couleur du point
	ld		(hl),a							; on la poke a l'adresse du gps
	ld		d,#08
	ld		a,h				
	add		a,d
	ld		h,a
	ld		a,(couleur_link_gps)
	ld		(hl),a					; on poke 7 a nouveau 
	ld		a,(No_PIECE)
	cp		37
	jp		z,radar_off
	cp		82
	jp		z,radar_off
	RET

; //////////////////////////////  LE GPS VA VERS LA DROITE ////////////////////////////////////
radar_droite
	ld	hl,(gps)
	ld	a,(flag_radar_piece_special)
	or	a
	jr	nz,on_ne_inc_pas
	;inc hl
	ld	de,(dep_gps_droite)
	add	hl,de	
on_ne_inc_pas
	ld	(gps),hl
		ld	a,(couleur_link_gps)
	ld	(hl),a
	ld	d,#08
	ld	a,h				
	add	a,d
	ld	h,a
		ld	a,(couleur_link_gps)
	ld	(hl),a				; on poke 7 a nouveau 
	ld	a,(No_PIECE)
	cp	37
	jp	z,radar_off
	cp	82
	jp	z,radar_off
	RET

; //////////////////////////////  LE GPS VA VERS LE HAUT ////////////////////////////////////
radar_haut
	ld	hl,(gps)									; on récupère l'adresse gps du point
	ld	a,(flag_radar_piece_special)					
	or	a
	jr	nz,on_ne_dec_pas2
	ld	a,(flag_calcul)								; 
	or	a
	jr	nz,premier_calcul_radar_haut
	or	a
	jr	z,deuxieme_calcul_radar_haut


premier_calcul_radar_haut	
	ld	de,(dep_gps_haut_1)
	sbc	hl,de
	xor	a
	ld	(flag_calcul),a
	jp	on_ne_dec_pas2		; bah si on vient de le fair
deuxieme_calcul_radar_haut	
	ld	de,(dep_gps_haut_2)
	add	hl,de
	ld	a,1
	ld	(flag_calcul),a
on_ne_dec_pas2
	ld	(gps),hl
	ld	a,(couleur_link_gps)
	ld	(hl),a
	ld	d,#08
	ld	a,h				
	add	a,d
	ld	h,a
	ld	a,(couleur_link_gps)
	ld	(hl),a				; on poke 7 a nouveau
	ld	a,(No_PIECE)
	cp	37
	jp	z,radar_off
	cp	82
	jp	z,radar_off
	ret

radar_bas
	ld	hl,(gps)
	ld	a,(flag_radar_piece_special)
	or	a
	jr	nz,on_ne_inc_pas2
	ld	a,(flag_calcul)
	or	a
	jr	z,premier_calcul_radar_bas
	or	a
	jr	nz,deuxieme_calcul_radar_bas


premier_calcul_radar_bas	
	ld	de,(dep_gps_bas_1)
	add	hl,de
	ld	a,1
	ld	(flag_calcul),a
	jr	on_ne_inc_pas2		; bah si on vient de le fair

deuxieme_calcul_radar_bas	
	ld	de,(dep_gps_bas_2)
	sbc	hl,de
	xor	a
	ld	(flag_calcul),a
on_ne_inc_pas2
	ld	(gps),hl
	ld	a,(couleur_link_gps)
	ld	(hl),a
	ld	d,#08
	ld	a,h				
	add	a,d
	ld	h,a
	ld	a,(couleur_link_gps)
	ld	(hl),a			; on poke 7 a nouveau 

	ld	a,(No_PIECE)
	cp	37
	jp	z,radar_off
	cp	82
	jp	z,radar_off
	ret



radar_off
	ld	a,1
	ld	(flag_radar_piece_special),a
	ret
radar_on
	xor	a
	ld	(flag_radar_piece_special),a
	ret


	
	
	