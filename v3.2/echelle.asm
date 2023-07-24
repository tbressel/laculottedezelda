on_affiche_echelle
	ld		a,(nombre_de_pas)
	dec		a
	ld		(nombre_de_pas),a
	or		a
	jp		z,nombre_de_pas_atteint


	ld		a,(flag_sprh4)
	or		a
	jp 		nz,pas_de_test_de_collision_haut
on_reaffiche_echelle
	ld		a,(direction_en_cours)
	cp		a,1						; gauche
	jr		z,affiche_echelle_gauche
	cp		a,2						; droite
	jp		z,affiche_echelle_droite
	cp		a,3						; haut
	jr		z,affiche_echelle_haut
	cp		a,4						; bas
	jr		z,affiche_echelle_bas

echelle_a_afficher
	ld		a,25
	ld		(Bankrom),a
	call	rom_on
	ld		hl,SPRH_ECHELLE_ADR
	ld		de,SPRH4_ADR
	ld		bc,#100
	LDir
	call	rom_off
	RET
affiche_echelle_haut
	ld		a,8
	ld		(Bankrom),a
	call	rom_on
	call	affiche_echelle_haut_ROM8
	call	rom_off
	call	echelle_a_afficher
	jp 		pas_de_test_de_collision_haut
affiche_echelle_bas
	ld		a,8
	ld		(Bankrom),a
	call	rom_on
	call	affiche_echelle_bas_ROM8
	call	rom_off
	call	echelle_a_afficher
	jp 		pas_de_test_de_collision_bas
affiche_echelle_gauche
	ld		a,8
	ld		(Bankrom),a
	call	rom_on
	call	affiche_echelle_gauche_ROM8
	call	rom_off
	call	echelle_a_afficher
	jp 		pas_de_test_de_collision_gauche
affiche_echelle_droite
	ld		a,8
	ld		(Bankrom),a
	call	rom_on
	call	affiche_echelle_droite_ROM8
	call	rom_off
	call	echelle_a_afficher
	jp 		pas_de_test_de_collision_droite
	
	
on_efface_echelle
	ld		a,8
	ld		(Bankrom),a
	call	rom_on
	call	on_efface_echelle_ROM8
	call	rom_off
	RET
	


nombre_de_pas_atteint
	xor		a
	ld		(nombre_de_pas),a
	jp		on_reaffiche_echelle
	