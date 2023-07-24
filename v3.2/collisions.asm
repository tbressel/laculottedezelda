TEST_COLLISIONS
	ld		a,(flag_invulnerable)
	or		a
	RET		NZ
	ld		a,(BankROM)
	ld		(flag_rom_save),a
	ld		a,2
	ld		(BankROM),a
	call	rom_on
	call	collision_ROM
	call	rom_off
	ld		a,(flag_rom_save)
	ld		(BankROM),a
	ret
	
collision_epee
	ld		a,(flag_fire1)
	or		a
	RET		Z
	ld		a,(BankROM)
	ld		(flag_rom_save),a
	ld		a,2
	ld		(BankROM),a
	call	rom_on
	call	collision_epee_ROM
	call	rom_off
	ld		a,(flag_rom_save)
	ld		(BankROM),a
	ret
	
collision_fleche
	ld		a,(flag_fire2)
	or		a
	RET		Z
	ld		a,(une_bombe_est_en_cours)
	or 		a
	RET		NZ
	ld		a,(BankROM)
	ld		(flag_rom_save),a
	ld		a,2
	ld		(BankROM),a
	call	rom_on
	call	collision_FLECHE_ROM
	call	rom_off
	ld		a,(flag_rom_save)
	ld		(BankROM),a
	ret
	
collision_bombe_dodongo
	ld		a,(flag_fire2)
	OR		A
	RET		Z
	ld		a,(BankROM)
	ld		(flag_rom_save),a
	ld		a,2
	ld		(BankROM),a
	call	rom_on
	call	collision_fleche_ROM
	call	rom_off
	ld		a,(flag_rom_save)
	ld		(BankROM),a
	ret
	

collision_bouledefeu
	ld		a,(BankROM)
	ld		(flag_rom_save),a
	ld		a,2
	ld		(BankROM),a
	call	rom_on
	call	COLLISION_BOULEDEFEU_ROM
	call	rom_off
	ld		a,(flag_rom_save)
	ld		(BankROM),a
	ret

	
init_fee
ld	a,1
ld	(flag_contact_fee),a
call init_petite_fee
RET


link_touche
	NOP
	OR		A
	ld		hl,(TYPE_MONSTRE1_ADR)
	ld		de,PETITE_FEE_ROM
	SBC		hl,de
	jr		z,init_fee
	ld		a,(compteur_gros_link)
	or		a
	RET	NZ
	ld		a,(etape_zelda)
	cp		a,1
	JP		z,position_levrette
;	vide_pile
	ld		a,(flag_boss_donjon)
	or		a
	jr		z,on_vide_pas_la_pile
	EXX
	pop 	ix
	EXX
	;pop 	ix
on_vide_pas_la_pile
	ld 		a,5	 ;Sound effect number (>=1)
    ld 		c,2 ;channel (0-2)
    ld 		b,0 ;Inverted volume (0-16)
	call 	PLY_AKG_PlaySoundEffect
	ld		a,(flag_invulnerable)
	or		a
	jr		nz,link_invulnerable
	ld		a,(flag_rom_save)
	ld		(BankROM),a
Link_touche2
		ld		a,(flag_bouclier)
		or		a
		jr		z,test_bouclier_2
	bouclier_1
		ld		a,(compteur_bouclier1)
		or		a
		jr		z,on_se_fait_toucher
		dec		a
		ld		(compteur_bouclier1),a
		ret

test_bouclier_2	
		ld		a,(flag_bouclier2)
		or		a
		jr		z,on_se_fait_toucher
	bouclier_2
		ld		a,(compteur_bouclier2)
		or		a
		jr		z,on_se_fait_toucher
		dec	a
		ld		(compteur_bouclier2),a
		ld		a,1
		ld		(flag_invulnerable),a
		ret	
on_se_fait_toucher	
	ld		a,1
	ld		(flag_invulnerable),a
	ld		(compteur_bouclier1),a
	ld		(compteur_bouclier2),a
	ld		a,100
	ld		(compteur_invulnerable),a
	ld		a,(nbr_vies)
	dec	a
	ld		(nbr_vies),a
	;cp		a,0
	jp		z,init_mort_link
	call	affiche_vies

link_invulnerable

;ld		a,#CD
;ld		(event_link_clignote),a
;ld		hl,link_clignote
;ld		(event_link_clignote+1),hl
	ld		a,(une_bouledefeu_est_en_cours)
	or		a
	jr		nz,stop_bouledefeu
	

	
	ld		a,(flag_rom_save)
	ld		(BankROM),a
	RET
stop_bouledefeu
	ld		a,(flag_donjon)
	or		a
	jp		nz,stop_3_boules_de_feu
	xor		a
	LD		(event_bouledefeu),a
	LD		(event_bouledefeu+1),a
	LD		(event_bouledefeu+2),a
	LD		(SPRH13_ZOOM),a
	ld		(flag_sprh13),a
	ld		(une_bouledefeu_est_en_cours),a
	ld		a,3
	ld		(flag_etape_du_poisson),a
	ld		a,(flag_rom_save)
	ld		(BankROM),a
	RET
Link_tue
	ld 		a,(identification_monstre_en_cours)
	ld 		hl,table_pre_mort_monsters
	add 	a,a       ; index x 2     
	ld 		e,a 
	ld 		d,0
	add 	hl,de 
	ld 		a,(hl)
	inc 	hl 
	ld 		h,(hl)
	ld 		l,a 
	xor		a								; la fleche touche un ennemis elle disparait
	ld		(SPRH3_ZOOM),a
	ld		(flag_sprh3),a
	LD		(event_fleche),a
	LD		(event_fleche+1),a
	LD		(event_fleche+2),a
	ld		(flag_fire2),a
	ld		(une_fleche_est_en_cours),a
	ld		a,(flag_rom_save)
	
	ld		a,8
	ld		(BankROM),a
	call	rom_on
	jp 		(hl)         			; ce sont tes routines pre_mort_monstre, qui se termine par un ret

table_pre_mort_monsters
dw	0,pre_mort_monstre_1,pre_mort_monstre_2,pre_mort_monstre_3,pre_mort_monstre_4,pre_mort_monstre_5,pre_mort_monstre_6,pre_mort_monstre_7,pre_mort_poisson



soundfx_pre_mort_play
	ld 		a,5	 ;Sound effect number (>=1)
    ld 		c,2 ;channel (0-2)
    ld 		b,0 ;Inverted volume (0-16)
	call 	PLY_AKG_PlaySoundEffect
	ret

	
on_fait_reculer_le_monstre
ld		a,8
ld		(BankROM),a
call	rom_on
call	on_fait_reculer_le_monstre_ROM8
call	rom_off
ret	

