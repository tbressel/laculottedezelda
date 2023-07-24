link_defonce_zelda
	ld		a,(etape_zelda)
	cp		a,0
	jr		z,init_link_nu
	cp		a,1
	jr		z,link_chasse
	cp		a,2
	jp		z,effacer_zelda
init_link_nu
	ld		a,8
	ld		(BankROM),a
	call	rom_on_bank_prog
	call	init_link_nu_ROM
	call	Link_Update
	call	rom_off
	ret
link_chasse
	ld		a,(flag_zelda_RIP)
	or		a
	JP		nz,zelda_est_nike
	ld		a,(attente_vers_la_fin)
	or		a
	RET		NZ
	ld		a,8
	ld		(BankROM),a
	call	rom_on_bank_prog
	call	link_chasse_ROM
	call	rom_off	
	ld		a,(flag_affiche_heritier)
	or		a
	jp		nz,on_affiche_heritier
	ret
on_affiche_heritier
	ld		a,26
	ld		(BankROM),a
	call	rom_on_bank_prog
	ld		hl,(SPRH_DESCENDENCE)
	ld		de,(SPRH_DESCENDENCE_ADR)
	ld		bc,#100
	LDIR
	ld		a,9
	ld		hl,(SPRH_DESCENDENCE_ZOOM)
	ld		(hl),a
	call	rom_off
	xor		a
	ld		(flag_affiche_heritier),a
	ret
	
zelda_est_nike
	ld		a,2
	ld		(etape_zelda),a
	ld		hl,(SPRH0_Y)
	ld		de,-30
	add		hl,de
	ld		(SPRH5_Y),hl
	RET
effacer_zelda
	xor		a
	ld		(event_gameover),a
	ld		(event_gameover+1),a
	ld		(event_gameover+2),a
	LD		a,#CD								; sinon on créer l'venement monstre 1
	LD		(event_gameover),a
	LD		hl,gameover
	LD		(event_gameover+1),hl
	ld		a,4
	ld		(flag_gameover_init),a
	RET
	

position_levrette
	ld		a,8
	ld		(BankROM),a
	call	rom_on_bank_prog
	call	position_levrette_ROM
	ld		a,26
	ld		(BankROM),a
	call	rom_on
	call	asic_on
	ld		hl,SPRH_ZELDA2_ADR
	ld		de,SPRH5_ADR
	ld		bc,#100
	LDIR
	ld		hl,SPRH_ZELDA2_ADR
	ld		de,SPRH5_ADR
	ld		bc,#100
	LDIR
	RET
	