; ***********************************************************************************
; ********************************* INTERRUPTION  ***********************************
; ***********************************************************************************
                     	;ca c'est notre tampon d'1 octet pour le numero de l'int
int76
	push 	af					; sauvegarde des registres
	push 	hl
	push 	bc
	push 	de
	push	ix
	push	iy
	LD 		BC,#7FB8
	OUT (C),C  ; Asic ON
	ld		a,(#6800)
	ld		a,255				; en bas de l'écan  la ligne 255
	ld		(#6800),a			; interruption PRI
	ld		hl,int255			
	ld		(#39),hl
	ld		hl,(type_de_palette)
	ld		de,#6400
	ld		BC,#20
	LDIR
	
	call	remise_en_place_des_banks_RAM	
	pop 	iy
	pop		ix
	pop 	de
	pop 	bc
	pop 	hl
	pop 	af
	EI
	ret

int255
	push 	af					; sauvegarde des registres
	push 	hl
	push 	bc
	push 	de
	push	ix
	push	iy
	
	LD 		BC,#7FB8:OUT 	(C),C  
	ld  	a,75
	ld 		(#6800),a
	ld 		hl,int76
	ld		(#39),hl
	ld		hl,(type_de_palette2)
	;ld		hl,PALETTE_HUD
	ld		de,#6400
	ld		BC,#20
	LDIR
	call	remise_en_place_des_banks_RAM

event_musique			ds	3,0				; call 	PLY_AKG_Play
	pop 	iy
	pop		ix
	pop 	de
	pop 	bc
	pop 	hl
	pop 	af
	EI
	ret
	
remise_en_place_des_banks_RAM
	LD		a,(flag_C0)
	or		a
	CALL	NZ,C0_on_inter

	LD		a,(flag_C4)
	OR		A
	CALL	NZ,C4_on_inter
	LD		a,(flag_C4)
	OR		A
	CALL	Z,C4_off
	
	LD		a,(flag_C5)
	OR		A
	CALL	NZ,C5_on_inter
	LD		a,(flag_C5)
	OR		A
	CALL	Z,C5_off
	
	LD		a,(flag_C6)
	OR		A
	CALL	NZ,C6_on_inter
	LD		a,(flag_C6)
	OR		A
	CALL	Z,C6_off
	
	LD		a,(flag_C7)
	OR		A
	CALL	NZ,C7_on_inter
	LD		a,(flag_C7)
	OR		A
	CALL	Z,C7_off
	
	LD		a,(flag_asic)
	or		a
	CALL	NZ,asic_on_inter
	LD		a,(flag_asic)
	OR		A
	CALL	Z,asic_off_inter
	ret
	
	
	
asic_on_inter
	LD		a,1
	LD		(flag_asic),a
	LD 		bc,#7fB8:out (c),c
	ret
asic_off_inter
	XOR		A
	LD		(flag_asic),a
	LD 		bc,#7fA0:out (c),c
	ret
C0_on_inter
	ld		a,1
	ld		(flag_C0),a
	xor		a
	ld		(flag_C4),a
	ld		(flag_C5),a
	ld		(flag_C6),a
	ld		(flag_C7),a
	LD 		BC,#7FC0:OUT (C),c
	ret
C4_on_inter
	ld		a,1
	ld		(flag_C4),a
	LD 		BC,#7FC4:OUT (C),c
	xor		a
	ld		(flag_C0),a
	ld		(flag_C5),a
	ld		(flag_C6),a
	ld		(flag_C7),a
	ret
C5_on_inter
	ld		a,1
	ld		(flag_C5),a
	LD 		BC,#7FC5:OUT (C),c
	xor		a
	ld		(flag_C4),a
	ld		(flag_C0),a
	ld		(flag_C6),a
	ld		(flag_C7),a
	ret
C6_on_inter
	ld		a,1
	ld		(flag_C6),a
	LD 		BC,#7FC6:OUT (C),c
	xor		a
	ld		(flag_C4),a
	ld		(flag_C5),a
	ld		(flag_C0),a
	ld		(flag_C7),a
	ret
C7_on_inter
	ld		a,1
	ld		(flag_C7),a
	LD 		BC,#7FC7:OUT (C),c
	xor		a
	ld		(flag_C4),a
	ld		(flag_C5),a
	ld		(flag_C6),a
	ld		(flag_C0),a
	ret

