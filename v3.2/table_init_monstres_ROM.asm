nombre_animations_monstre_ROM
	ld		a,(bankROM)
	cp		a,26
	jp		z,ennemis_bank26
	cp		a,27
	jp		z,ennemis_bank27
	cp		a,28
	jp		z,ennemis_bank28
	RET
ennemis_bank26
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		de,#F000
	sbc		hl,de
	jp		nc,a2_sprites
	ld		a,0
	ld		(flag_anim_2_sprites),a
	RET
ennemis_bank27
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		de,#F000
	sbc		hl,de
	jp		nc,a2_sprites
	ld		a,0
	ld		(flag_anim_2_sprites),a
	RET
ennemis_bank28
	or		a
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		de,#E000
	sbc		hl,de
	jp		nc,a2_sprites
	ld		a,0
	ld		(flag_anim_2_sprites),a
	RET	
a2_sprites
	ld	a,1
	ld	(flag_anim_2_sprites),a
	ld	hl,(TYPE_MONSTRE_ADR)
	ld	de,PEAHAT_ROM
	sbc	hl,de
	jp	z,peathat_on
	ld	a,0
	ld	(flag_peahat),a
	RET
peathat_on
	ld	a,1
	ld	(flag_peahat),a
	RET
	
a4_sprites
	ld	a,1
	ld	(flag_anim_2_sprites),a
	RET
a8_sprites
	ld	a,1
	ld	(flag_anim_2_sprites),a
	RET	


