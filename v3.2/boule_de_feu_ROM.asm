init_3_boules_de_feu3_ROM

	ld		hl,(SPRH6_X)
	LD		(SPRH13_X),hl
	LD		(SPRH14_X),hl
	LD		(SPRH15_X),hl
	ld		hl,(SPRH6_Y)
	LD		(SPRH13_Y),hl
	LD		(SPRH14_Y),hl
	LD		(SPRH15_Y),hl
	ld		a,9
	ld		(SPRH13_ZOOM),a
	ld		(SPRH14_ZOOM),a
	ld		(SPRH15_ZOOM),a
	ld		a,1
	ld		(flag_sprh13),a
	ld		(flag_sprh14),a
	ld		(flag_sprh15),a
	ld		a,1
	ld		(etape_3_boule_de_feu3),a
	ld		(une_bouledefeu_est_en_cours),a

ret




reinit_3_boules_de_feu3_ROM
	ld	hl,(SPRH6_X)
	LD	(SPRH13_X),hl
	LD	(SPRH14_X),hl
	LD	(SPRH15_X),hl
	ld	hl,(SPRH6_Y)
	LD	(SPRH13_Y),hl
	LD	(SPRH14_Y),hl
	LD	(SPRH15_Y),hl
	ld	a,9
	ld	(SPRH13_ZOOM),a
	ld	(SPRH14_ZOOM),a
	ld	(SPRH15_ZOOM),a
	ld	a,1
	ld	(flag_sprh13),a
	ld	(flag_sprh14),a
	ld	(flag_sprh15),a
	ld	a,0
	ld	(etape_3_boule_de_feu3),a
	ld	(une_bouledefeu_est_en_cours),a
	ret





init_3_boules_de_feu_ROM
	ld		hl,(SPRH5_X)
	LD		(SPRH13_X),hl
	LD		(SPRH14_X),hl
	LD		(SPRH15_X),hl
	ld		hl,(SPRH5_Y)
	LD		(SPRH13_Y),hl
	LD		(SPRH14_Y),hl
	LD		(SPRH15_Y),hl
	ld		a,9
	ld		(SPRH13_ZOOM),a
	ld		(SPRH14_ZOOM),a
	ld		(SPRH15_ZOOM),a
	ld		a,1
	ld		(flag_sprh13),a
	ld		(flag_sprh14),a
	ld		(flag_sprh15),a
	ld		a,1
	ld		(etape_3_boule_de_feu),a
	ld		(une_bouledefeu_est_en_cours),a
	ret
	



update_bouledefeu_ROM
ld		a,(direction_bouledefeu_en_cours)		; à déterminer en fonction de la position de link
	cp		a,1
	jp		z,inc_bouledefeu_gauchehaut
	cp		a,2
	jp		z,inc_bouledefeu_gauchebas
	cp		a,3
	jp		z,inc_bouledefeu_droitebas
	cp		a,4
	jp		z,inc_bouledefeu_droitehaut
	cp		a,5
	jp		z,fin_bouledefeu
	
inc_bouledefeu_gauchehaut
	ld		hl,(SPRH13_X)			; gauche
	ld		de,-8
	add		hl,de
	ld		(SPRH13_X),hl
	ld		a,h
	cp		a,255
	JP		Z,boulesuivante
	ld		hl,(SPRH13_Y)			; haut
	dec		l
	ld		(SPRH13_Y),hl
	ld		a,l
	ld		d,82
	sub		a,d
	JP		C,boulesuivante
	;JP 		retour_bouledefeu
	RET
inc_bouledefeu_droitehaut
	ld		hl,(SPRH13_X)			; droite
	ld		de,8
	add		hl,de
	ld		(SPRH13_X),hl
	ld		de,#0200
	SBC		hl,de
	JP		NC,boulesuivante
	ld		hl,(SPRH13_Y)			; haut
	dec		l
	ld		(SPRH13_Y),hl
	ld		a,l
	ld		d,82
	sub		a,d
	JP		C,boulesuivante
	;JP 		retour_bouledefeu
	RET
inc_bouledefeu_gauchebas
	ld		hl,(SPRH13_X)			; gauche
	ld		de,-8
	add		hl,de
	ld		(SPRH13_X),hl
	ld		a,h
	cp		a,255
	JP		Z,boulesuivante
	ld		hl,(SPRH13_Y)			; bas
	inc		l
	ld		(SPRH13_Y),hl
	ld		a,l
	ld		d,82
	sub		a,d
	JP		C,boulesuivante
	;JP 		retour_bouledefeu
	RET
inc_bouledefeu_droitebas
	ld		a,1
	ld		(flag_derniere_boule),a
	ld		hl,(SPRH13_X)			; droite
	ld		de,8
	add		hl,de
	ld		(SPRH13_X),hl
	ld		de,#0200
	SBC		hl,de
	JP		NC,boulesuivante
	ld		hl,(SPRH13_Y)			; bas
	inc 	l
	ld		(SPRH13_Y),hl
	ld		a,l
	ld		d,6
	sub		a,d
	JP		C,boulesuivante
	;JP 		retour_bouledefeu
	RET
boulesuivante
	ld		a,(direction_bouledefeu_en_cours)
	inc		a
	ld		(direction_bouledefeu_en_cours),a
	LD		hl,(SPRH12_X)							; récupération de la position X acutelle de zora
	LD		(SPRH13_X),hl
	LD		hl,(SPRH12_Y)							; récupération de la position Y actuelle de zora
	LD		(SPRH13_Y),hl	
	;JP 		retour_bouledefeu
	RET
fin_bouledefeu
	xor		a
	LD		(event_bouledefeu),a
	LD		(event_bouledefeu+1),a
	LD		(event_bouledefeu+2),a
	LD		(SPRH13_ZOOM),a
	ld		(flag_sprh13),a
	ld		(flag_derniere_boule),a
	ld		(une_bouledefeu_est_en_cours),a
	ld		(direction_bouledefeu_en_cours),a
	ld		a,3
	ld		(flag_etape_du_poisson),a
	;JP 		retour_bouledefeu
	ret




