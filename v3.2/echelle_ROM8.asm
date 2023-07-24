affiche_echelle_haut_ROM8
	ld		a,16
	ld		(nombre_de_pas),a
	ld		hl,(SPRH_Y)
	ld		de,16
	sbc		hl,de
	ld		(SPRH4_Y),hl
	ld		hl,(SPRH_X)
	ld		(SPRH4_X),hl
	ld		a,9
	ld		(SPRH4_ZOOM),a
	ld		a,1
	ld		(flag_sprh4),a
	
	call	gauche_off
	call	droite_off
RET
	
	

affiche_echelle_bas_ROM8
ld		a,16
	ld		(nombre_de_pas),a
	ld		hl,(SPRH_Y)
	ld		de,16
	add		hl,de
	ld		(SPRH4_Y),hl
	ld		hl,(SPRH_X)
	ld		(SPRH4_X),hl
	ld		a,9
	ld		(SPRH4_ZOOM),a
	ld		a,1
	ld		(flag_sprh4),a
	call	gauche_off
	call	droite_off
	RET
affiche_echelle_gauche_ROM8	
ld		a,16
	ld		(nombre_de_pas),a
	ld		hl,(SPRH_X)
	ld		de,32
	sbc		hl,de
	ld		(SPRH4_X),hl
	ld		hl,(SPRH_Y)
	ld		(SPRH4_Y),hl
	ld		a,9
	ld		(SPRH4_ZOOM),a
	ld		a,1
	ld		(flag_sprh4),a
	call	haut_off
	call	bas_off
	RET
affiche_echelle_droite_ROM8
ld		a,16
	ld		(nombre_de_pas),a
	ld		hl,(SPRH_X)
	ld		de,32
	add		hl,de
	ld		(SPRH4_X),hl
	ld		hl,(SPRH_Y)
	ld		(SPRH4_Y),hl
	ld		a,9
	ld		(SPRH4_ZOOM),a
	ld		a,1
	ld		(flag_sprh4),a
	call	haut_off
	call	bas_off
	RET
	
	
on_efface_echelle_ROM8
ld		a,0
	ld		(SPRH4_ZOOM),a
	ld		a,0
	ld		(flag_sprh4),a
	call	gauche_on
	call	droite_on
	call	bas_on
	call	haut_on	
	ret




gauche_on
	ld	a,#CA
	ld	(gauche_jpz),a
	ld	hl,allez_a_gauche
	ld	(gauche_jpz+1),hl
	ret
gauche_off
	ld	a,0
	ld	(gauche_jpz),a
	ld	(gauche_jpz+1),a
	ld	(gauche_jpz+2),a
	ret	
	
	
droite_on
	ld	a,#CA
	ld	(droite_jpz),a
	ld	hl,allez_a_droite
	ld	(droite_jpz+1),hl
	ret
droite_off
	ld	a,0
	ld	(droite_jpz),a
	ld	(droite_jpz+1),a
	ld	(droite_jpz+2),a
	ret
	
haut_on
	ld	a,#CA
	ld	(haut_jpz),a
	ld	hl,allez_en_haut
	ld	(haut_jpz+1),hl
	ret
haut_off
	ld	a,0
	ld	(haut_jpz),a
	ld	(haut_jpz+1),a
	ld	(haut_jpz+2),a
	ret	
bas_on
	ld	a,#CA
	ld	(bas_jpz),a
	ld	hl,allez_en_bas
	ld	(bas_jpz+1),hl
	ret
bas_off
	ld	a,0
	ld	(bas_jpz),a
	ld	(bas_jpz+1),a
	ld	(bas_jpz+2),a
	ret

	