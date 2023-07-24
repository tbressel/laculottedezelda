champi_rouge
ld		a,(flag_champi_rouge)
cp		a,1
ret		z
	ld	a,(flag_champi_pourrit)
	cp	a,1
	call	z,test_de_touche_retablit
	ld	a,1
	ld	(flag_champi_rouge),a
	xor	a
	ld	(flag_champi_vert),a
	ld	(flag_champi_pourrit),a
	; on initialise les collisions bord ecran hyrule
	ld	hl,#FFF0									; #FFFC pour vitesse -4 ////// #FFF0 pour vitesse -8
	ld	(bord_gauche),hl
	ld	hl,#01D2									;  #01E4 pour vitesse  4 ////// #01D2 pour vitesse 8 et 2
	ld	(bord_droit),hl
	ld	hl,#0050									;  #004E pour vitesse -2 ////// #0050 pour vitesse -4
	ld	(bord_haut),hl
	ld	hl,#00EE									;  #00F0 pour vitesse 2 /////// #00EE pour vitesse 4
	ld	(bord_bas),hl		

	; vitesse de deplacement de link
	ld	hl,-8
	ld	(vitesse_link_gauche),hl
	ld	hl,8
	ld	(vitesse_link_droite),hl
	ld	hl,-4
	ld	(vitesse_link_haut),hl
	ld	hl,4
	ld	(vitesse_link_bas),hl

	; vitesse de rétablisseement de link après collision
	ld	a,8
	ld	(vitesse_link_X),a
	ld	a,4
	ld	(vitesse_link_Y),a

	ret


champi_vert
ld		a,(flag_champi_vert)
cp		a,1
ret		z
	ld	a,(flag_champi_pourrit)
	cp	a,1
	call	z,test_de_touche_retablit
ld	a,1
	ld	(flag_champi_vert),a
	xor a
	ld	(flag_champi_pourrit),a
	ld	(flag_champi_rouge),a
; on initialise les collisions bord ecran hyrule
ld	hl,#FFFC									; #FFFC pour vitesse -4 ////// #FFF0 pour vitesse -8
ld	(bord_gauche),hl
ld	hl,#01E0									;  #01E4 pour vitesse  4 ////// #01D2 pour vitesse 8 et 2
ld	(bord_droit),hl
ld	hl,#004F									;  #004E pour vitesse -2 ////// #0050 pour vitesse -4
ld	(bord_haut),hl
ld	hl,#00F0									;  #00F0 pour vitesse 2 /////// #00EE pour vitesse 4
ld	(bord_bas),hl		

; vitesse de deplacement de link
ld	hl,-4
ld	(vitesse_link_gauche),hl
ld	hl,4
ld	(vitesse_link_droite),hl
ld	hl,-2
ld	(vitesse_link_haut),hl
ld	hl,2
ld	(vitesse_link_bas),hl

; vitesse de rétablisseement de link après collision
ld	a,4
ld	(vitesse_link_X),a
ld	a,2
ld	(vitesse_link_Y),a


ret




champi_pourrit
	ld		a,(flag_champi_pourrit)
	cp		a,1
	ret		z
	ld		a,1
	ld		(flag_champi_pourrit),a
	xor 	 a
	ld		(flag_champi_rouge),a
	ld		(flag_champi_vert),a
; on initialise les collisions bord ecran hyrule
ld	hl,#FFFC									; #FFFC pour vitesse -4 ////// #FFF0 pour vitesse -8
ld	(bord_gauche),hl
ld	hl,#01D2									;  #01E4 pour vitesse  4 ////// #01D2 pour vitesse 8 et 2
ld	(bord_droit),hl
ld	hl,#0050									;  #004E pour vitesse -2 ////// #0050 pour vitesse -4
ld	(bord_haut),hl
ld	hl,#00F0									;  #00F0 pour vitesse 2 /////// #00EE pour vitesse 4
ld	(bord_bas),hl		

; vitesse de deplacement de link
ld	hl,-2
ld	(vitesse_link_gauche),hl
ld	hl,2
ld	(vitesse_link_droite),hl
ld	hl,-1
ld	(vitesse_link_haut),hl
ld	hl,1
ld	(vitesse_link_bas),hl

; vitesse de rétablisseement de link après collision
ld	a,2
ld	(vitesse_link_X),a
ld	a,1
ld	(vitesse_link_Y),a


; test de touche inverse
ld		b,8
ld		hl,haut_test+1
ld		a,(hl)
add		a,b
ld		(hl),a
ld		hl,gauche_test+1
ld		a,(hl)
add		a,b
ld		(hl),a

ld		b,-8
ld		hl,bas_test+1
ld		a,(hl)
add		a,b
ld		(hl),a
ld		hl,droite_test+1
ld		a,(hl)
add		a,b
ld		(hl),a
ret

test_de_touche_retablit
; test de touche inverse
ld		b,-8
ld		hl,haut_test+1
ld		a,(hl)
add		a,b
ld		(hl),a
ld		hl,gauche_test+1
ld		a,(hl)
add		a,b
ld		(hl),a

ld		b,8
ld		hl,bas_test+1
ld		a,(hl)
add		a,b
ld		(hl),a
ld		hl,droite_test+1
ld		a,(hl)
add		a,b
ld		(hl),a
ret
