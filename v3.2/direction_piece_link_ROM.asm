VERS_LE_BAS_LINK_ROM
	ld		a,4
	call	calcul_radar
	call	asic_off
	
LD		A,(No_BANK)
	CP		a,#C6
	call	z,C6_on
	CP		a,#C7
	call	z,C7_on
	CP		a,#C5
	call	z,C5_on
	
	LD		HL,(PIECE_ACTUELLE)
	DEC 	HL
	DEC 	HL 										; HL contient la l'adresses des octets a lire
	LD		A,(HL)									;on lit l'octet contenu a l'adresse HL
	LD 		(No_BANK),A								;on stock le numero de bank OU ON VA
	DEC		HL
	DEC		HL										; 2 octets en arriere on a l'adresse de la piece de droite
													; HL contient l'adresses des octets a lire	
	PUSH 	DE
	LD 		A,(HL)
	LD 		E,A
	INC 	HL
	LD 		A,(HL)
	LD 		D,A
	EX 		HL,DE
	POP 	DE

; calcul du future numéro de pièce actuelle 
	ld		a,(hl)								; à ce moment du calcule je tombe sur le numéro de la pièce
	ld		(No_PIECE),a						; on sauvegarde
	inc		hl									; on pointe sur l'adresse suivante
	ld		a,(hl)								; on lit egalement son octet
	ld      (No_PIECE+1),a						; on sauvegarde

; calcul de la future piece actuelle
	LD		DE,17								; on se redeplace de 18-1 octet (juste en haut on a déjà INC une fois) 
	ADD		HL,DE								; on a le résultat dans HL
	
	call	C0_on
	
	LD		(PIECE_ACTUELLE),HL
	
	ld		a,(flag_cave)
	or		a
	jp		nz,vers_la_cave
	
; on est dans la map d'Hyrule
	LD		HL,(link_en_haut)								; on position Link en Y = bas de l'ecran car X reste le meme.
	call	asic_on
	LD		(SPRH_Y),HL								; et on sauvegarde la modif de coordonne pour qu'elle soit lue au changement de piece
	LD		(SPRH0_Y),HL	
	LD		(SPRH1_Y),HL	
	call	asic_off
	CALL 	AFFICHAGE_GPS
	RET
vers_la_cave
		ld		hl,#004E
		ld		(bord_haut),hl
		call	asic_on
		ld		hl,link_en_haut_X_cave
		ld		(SPRH_X),HL
		ld		(SPRH0_X),HL
		ld		(SPRH1_X),HL
		ld		hl,link_en_haut_Y_cave
		ld		(SPRH_Y),HL
		ld		(SPRH0_Y),HL
		ld		(SPRH1_Y),HL
		call	asic_off
	CALL 	AFFICHAGE_GPS
	RET
	
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
VERS_LE_HAUT_LINK_ROM
	ld	a,3
	call	calcul_radar
	call	asic_off
	ld		a,(radeau_en_cours)
	or		a
	CALL	nz,link_radeau_off
	

LD		A,(No_BANK)
	CP		a,#C6
	call	z,C6_on
	CP		a,#C7
	call	z,C7_on
	CP		a,#C5
	call	z,C5_on
	
	LD		HL,(PIECE_ACTUELLE)
	ld		de,-6							;on decrement 6 octet en arriere pour avoir la bank
	add		hl,de							; HL contient la l'adresses des octets a lire
	LD		A,(HL)				;on lit l'octet contenu a l'adresse HL
	LD 		(No_BANK),A			;on stock le numero de bank a lire
	DEC		HL
	DEC		HL					; 2 octets en arriere on a l'adresse de la piece de droite
								; HL contient l'adresses des octets a lire	
	PUSH 	DE
	LD 		A,(HL)
	LD 		E,A
	INC 	HL
	LD 		A,(HL)
	LD 		D,A
	EX 		HL,DE
	POP 	DE

; calcul du future numéro de pièce actuelle 
	ld		a,(hl)								; à ce moment du calcule je tombe sur le numéro de la pièce
	ld		(No_PIECE),a						; on sauvegarde
	inc		hl									; on pointe sur l'adresse suivante
	ld		a,(hl)								; on lit egalement son octet
	ld      (No_PIECE+1),a						; on sauvegarde
	
; calcul de la future piece actuelle
	LD		DE,17								; on se redeplace de 18-1 octet (juste en haut on a déjà INC une fois) 
	ADD		HL,DE								; on a le résultat dans HL
	call	C0_on
	
	LD		(PIECE_ACTUELLE),HL
	
ld		a,(flag_cave)
or		a
jp		nz,retour_de_cave_config
	
; on est dans la map d'Hyrule
	LD		HL,(link_en_bas)								; on position Link en Y = bas de l'ecran car X reste le meme.
	call	asic_on
	LD		(SPRH_Y),HL								; et on sauvegarde la modif de coordonne pour qu'elle soit lue au changement de piece
	LD		(SPRH0_Y),HL	
	LD		(SPRH1_Y),HL	
	call	asic_off
	CALL 	AFFICHAGE_GPS
	RET
	
retour_de_cave_config	
	xor		a
	ld		(flag_cave),a
	ld		hl,#0064
	ld		(bord_haut),hl
	ld		hl,link_en_haut_X_cave
		call asic_on
		LD		(SPRH_X),HL	
		ld		(SPRH0_X),HL
		ld		(SPRH1_X),HL
		ld		hl,208
		LD		(SPRH_Y),HL	
		ld		(SPRH0_Y),HL
		ld		(SPRH1_Y),HL
		call	asic_off
		CALL 	AFFICHAGE_GPS
		RET
	
	; //////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
VERS_LA_DROITE_LINK_ROM	
	ld	a,2
	call	calcul_radar

	call	asic_off

LD		A,(No_BANK)
	CP		a,#C6
	call	z,C6_on
	CP		a,#C7
	call	z,C7_on
	CP		a,#C5
	call	z,C5_on
	
	LD		HL,(PIECE_ACTUELLE)	; on recupere l'adresse enregistre
					; au label piece actuelle donc #853F
	ld		de,-10
	add		hl,de
	LD		A,(HL)			;on lit l'octet contenu a l'adresse HL
	LD 		(No_BANK),A		;on stock le numero de bank a lire
	DEC		HL
	DEC		HL			; 2 octets en arriere on a l'adresse de la piece de droite
					; HL contient l'adresses des octets a lire	
	PUSH 	DE
	LD 		A,(HL)
	LD 		E,A
	INC 	HL
	LD 		A,(HL)
	LD 		D,A
	EX 		HL,DE
	POP 	DE

; calcul du future numéro de pièce actuelle 
	ld		a,(hl)								; à ce moment du calcule je tombe sur le numéro de la pièce
	ld		(No_PIECE),a						; on sauvegarde
	inc		hl									; on pointe sur l'adresse suivante
	ld		a,(hl)								; on lit egalement son octet
	ld      (No_PIECE+1),a						; on sauvegarde

	; calcul de la future piece actuelle
	LD		DE,17								; on se redeplace de 18-1 octet (juste en haut on a déjà INC une fois) 
	ADD		HL,DE								; on a le résultat dans HL
	call	C0_on
	
	LD		(PIECE_ACTUELLE),HL
	
; on est dans la map d'Hyrule
	LD		HL,(link_a_gauche)								; on position Link en Y = bas de l'ecran car X reste le meme.
	call	asic_on
	LD		(SPRH_X),HL								; et on sauvegarde la modif de coordonne pour qu'elle soit lue au changement de piece
	LD		(SPRH0_X),HL	
	LD		(SPRH1_X),HL	
	call	asic_off
	
	CALL 	AFFICHAGE_GPS
	ret
	

; //////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
VERS_LA_GAUCHE_LINK_ROM	

	; on modifie le GPS
	ld		a,1
	call	calcul_radar
	call	asic_off
	
LD		A,(No_BANK)
	CP		a,#C6
	call	z,C6_on
	CP		a,#C7
	call	z,C7_on
	CP		a,#C5
	call	z,C5_on
	
	LD		HL,(PIECE_ACTUELLE)				; on recupere l'adresse enregistre
	ld		de,-14
	add		hl,de
	LD		A,(HL)			;on lit l'octet contenu a l'adresse HL
	LD 		(No_BANK),A		;on stock le numero de bank a lire
	DEC		HL
	DEC		HL
					; 2 octets en arriere on a l'adresse de la piece de gauche
	PUSH 	DE
	;LD 		A,(HL)
	ld		e,(hl)
	;LD 		E,A
	INC 	HL
	;LD 		A,(HL)
	ld		d,(hl)
	;LD 		D,A
	EX 		HL,DE
	POP 	DE

; calcul du future numéro de pièce actuelle 
	ld		a,(hl)								; à ce moment du calcule je tombe sur le numéro de la pièce
	ld		(No_PIECE),a						; on sauvegarde
	inc		hl									; on pointe sur l'adresse suivante
	ld		a,(hl)								; on lit egalement son octet
	ld      (No_PIECE+1),a						; on sauvegarde

	; calcul de la future piece actuelle
	LD		DE,17								; on se redeplace de 18-1 octet (juste en haut on a déjà INC une fois) 
	ADD		HL,DE								; on a le résultat dans HL
	call	C0_on
	
	LD		(PIECE_ACTUELLE),HL
	
; on est dans la map d'Hyrule
	LD		HL,(link_a_droite)								; on position Link en Y = bas de l'ecran car X reste le meme.
	call	asic_on
	LD		(SPRH_X),HL								; et on sauvegarde la modif de coordonne pour qu'elle soit lue au changement de piece
	LD		(SPRH0_X),HL	
	LD		(SPRH1_X),HL	
	call	asic_off
	
	CALL 	AFFICHAGE_GPS
	ret
	

	
; ************************************************************************************
; ************************* Effacage des sprites hard  *******************************
; ************************************************************************************
; on efface d'abord les sprite hards des armes, link et monstres

NETTOYAGE_SPRITES_HARD
	call 	asic_on
	ld		hl,SPRH0_ZOOM
	xor		a 
	ld		b,16
ZOOM_OFF_0a15
	push	bc
	ld		(hl),a
	ld		a,l
	add		a,#08
	ld		l,a
	pop		bc
	djnz	ZOOM_OFF_0a15

	
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////// TOUS LES FLAGS ZOOM MIS A ZERO ////////////////////////////////
; ////////////////////////////////////////////////(sauf link)///////////////////////////////////////////
	ld		hl,FLAGS_ZOOM+2
	ld		b,14
	xor		a
flag_monstres_zoom_boucle
	push	bc
	ld		(hl),a
	inc		hl
	pop		bc
	djnz	flag_monstres_zoom_boucle
	call 	asic_off
		
; puis on efface les evenements
	xor		a
	LD		(flag_etape_du_monstre1),a
	LD		(event_monstre1),a
	LD		(event_monstre1+1),a
	LD		(event_monstre1+2),a
	
	
	LD		(flag_etape_du_monstre2),a
	LD		(event_monstre2),a
	LD		(event_monstre2+1),a
	LD		(event_monstre2+2),a
	
	LD		(flag_etape_du_monstre3),a
	LD		(event_monstre3),a
	LD		(event_monstre3+1),a
	LD		(event_monstre3+2),a
	
	LD		(flag_etape_du_monstre4),a
	LD		(event_monstre4),a
	LD		(event_monstre4+1),a
	LD		(event_monstre4+2),a
	
	LD		(flag_etape_du_monstre5),a
	LD		(event_monstre5),a
	LD		(event_monstre5+1),a
	LD		(event_monstre5+2),a
	
	LD		(flag_etape_du_monstre6),a
	LD		(event_monstre6),a
	LD		(event_monstre6+1),a
	LD		(event_monstre6+2),a
	
	LD		(flag_etape_du_monstre7),a
	LD		(event_monstre7),a
	LD		(event_monstre7+1),a
	LD		(event_monstre7+2),a
	
	ld		(une_fleche_est_en_cours),a
	LD		(event_fleche),a
	LD		(event_fleche+1),a
	LD		(event_fleche+2),a
	
	ld		(une_bombe_est_en_cours),a
	LD		(event_bombe),a
	LD		(event_bombe+1),a
	LD		(event_bombe+2),a	

	ld		(un_feu_est_en_cours),a
	LD		(event_feu),a
	LD		(event_feu+1),a
	LD		(event_feu+2),a	

	ld		(flag_fire2),a
	LD		(event_attaque),a
	LD		(event_attaque+1),a
	LD		(event_attaque+2),a	
	
	ld		(flag_zora),a
	LD		(flag_etape_du_poisson),a
	LD		(event_poisson_zora),a
	LD		(event_poisson_zora+1),a
	LD		(event_poisson_zora+2),a	
	ret
	
	