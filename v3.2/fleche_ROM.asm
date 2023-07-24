update_fleche_ROM
ld		a,(direction_fleche_en_cours)				; une direction est attribué à un numero
	cp		a,1
	jp		z,inc_fleche_gauche
	cp		a,2
	jp		z,inc_fleche_droite
	cp		a,3
	jp		z,inc_fleche_haut
	cp		a,4
	jp		z,inc_fleche_bas
inc_fleche_gauche									; 
	ld		hl,(SPRH3_X)			
	ld		de,-14
	add		hl,de
	ld		(SPRH3_X),hl						; la fleche avance encore et ecnore a chaque passage ici
	ld		a,h
	cp		a,255								; et si y'a collision avec le bord gauche de l'écran
	CALL		Z,fin_fleche					; alors on va faire disparaitre la fleche direct !
	RET											; sinon on rétablit le CALL
inc_fleche_droite
	ld		hl,(SPRH3_X)
	ld		de,14
	add		hl,de
	ld		(SPRH3_X),hl
	ld		de,#0200
	SBC		hl,de
	CALL		NC,fin_fleche
	RET
inc_fleche_haut
	ld		hl,(SPRH3_Y)
	ld		a,l
	ld		d,-6
	add		 a,d
	ld		l,a
	ld		(SPRH3_Y),hl
	ld		l,a
	ld		d,82
	sub		a,d
	CALL		C,fin_fleche
	ret
inc_fleche_bas
	ld		hl,(SPRH3_Y)
	ld		a,l
	ld		d,6
	add		 a,d
	ld		l,a
	ld		(SPRH3_Y),hl
	ld		l,a
	ld		d,6
	sub		a,d
	CALL		C,fin_fleche
	ret
	
	