on_ouvre_le_passage_vers_zelda_ROM
call	asic_off
	call	c5_on
	xor		a	
	LD		HL,#6C0E		
	ld		(HL),a
	
	inc		L
	ld		(HL),a
	
	ld		l,#1E
	ld		(HL),a
	inc		l
	ld		(HL),a
	
	call	c5_off
	call	asic_on

ret

