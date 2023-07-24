	
quel_type_de_tile
	ld		a,(flag_donjon)
	cp		a,1
	ret		Z
	ld		a,(No_PIECE)
	cp		a,2
	jp		z,tile_type_arbre
	cp		a,26
	jp		z,tile_type_arbre

		ld		hl,1
		ld		(no_tile_a_ecrire2),hl
		ld		hl,tile_grotte_hyrule_adr
		ld 		(tile_a_ecrire2),hl
		ret	

		tile_type_arbre
			ld		hl,34
			ld		(no_tile_a_ecrire2),hl
			ld		hl,tile_arbre_hyrule_adr
			ld 		(tile_a_ecrire2),hl
			ret	
