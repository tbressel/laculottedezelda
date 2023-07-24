update_feu_ROM
ld		a,(direction_feu_en_cours)
	cp		a,1
	jp		z,inc_feu_gauche
	cp		a,2
	jp		z,inc_feu_droite
	cp		a,3
	jp		z,inc_feu_haut
	cp		a,4
	jp		z,inc_feu_bas
inc_feu_gauche
	ld		hl,(SPRH3_X)
	dec		hl
	ld		(SPRH3_X),hl
	ld		de,14
	or		a
	SBC		hl,de
	JP	C,fin_feu
	ld		a,(compteur_distanceX)
	dec		a
	ld		(compteur_distanceX),a
	cp		a,0
	JP	z,fin_feu
	jp	retour_update_feu_ROM
	
inc_feu_droite
	ld		hl,(SPRH3_X)
	inc 	hl
	ld		(SPRH3_X),hl
	ld		de,#0200
	SBC		hl,de
	JP		NC,fin_feu
	ld		a,(compteur_distanceX)
	dec		a
	ld		(compteur_distanceX),a
	;cp		a,0
	JP		z,fin_feu
	jp		retour_update_feu_ROM
inc_feu_haut
	ld		a,(flag_attente_inc_feu)			; flag à 1 on passe pas
	dec		a
	ld		(flag_attente_inc_feu),a
	jp		nz,retour_update_feu_ROM				; flag à 0 on passe
	ld		a,2
	ld		(flag_attente_inc_feu),a			; on le remet à 1 pour la prochaine fois
	
	ld		hl,(SPRH3_Y)
	dec		l
	ld		(SPRH3_Y),hl
	ld		a,l
	ld		d,82
	sub		a,d
	JP		C,fin_feu
	ld		a,(compteur_distanceY)
	dec		a
	ld		(compteur_distanceY),a
	JP		z,fin_feu
	jp		retour_update_feu_ROM
inc_feu_bas
	ld		a,(flag_attente_inc_feu)			; flag à 1 on passe pas
	dec		a
	ld		(flag_attente_inc_feu),a
	jp		nz,retour_update_feu_ROM				; flag à 0 on passe
	ld		a,2
	ld		(flag_attente_inc_feu),a			; on le remet à 1 pour la prochaine fois
	ld		hl,(SPRH3_Y)
	inc		l
	ld		(SPRH3_Y),hl
	ld		a,l
	ld		d,6
	sub		a,d
	JP		C,fin_feu
	ld		a,(compteur_distanceY)
	dec		a
	ld		(compteur_distanceY),a
	;cp		a,0
	JP		z,fin_feu
	jp		retour_update_feu_ROM

