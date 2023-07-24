AFFICHE_PIECE
	ld		a,2
	ld		(BankROM),a
	call	rom_on
	call	affiche_piece_rom
	call	rom_off



LIGNEINF_c000
	LD 		A,D
	ADD 	A,#08
	LD 		D,A
	RET 	NC					; debordement
	EX 		DE,HL
	LD 		BC,#C040			; valeur de ligne inférieur pour un ecran de 16 tiles de large
	ADD 	HL,BC
	EX 		DE,HL
	RET




