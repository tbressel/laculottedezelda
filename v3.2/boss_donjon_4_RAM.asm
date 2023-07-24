; /////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////// BOSS DU DONJON 1 - RAM///////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
boss_donjon_4
	LD		a,(flag_naissance_en_cours)
	or		a
	ret		NZ
	call	del_off
	LD		a,(etape_boss_4)				; A=0 il na pas encore poppé
	CP		a,0
	JR		z,init_RAM_boss_4					; A=1 intit termine, naissance debut ou en cours
	CP		a,1
	JR		z,init_sprite_boss_4						; monstre affiche, pret a metre a jour
	CP		a,2
	JR		z,on_affiche_le_boss_4
	cp		a,3
	jR		z,update_du_boss_4
	cp		a,4
	jp		z,recompense_boss_4
init_RAM_boss_4
	LD		a,1
	LD		(etape_boss_4),a
	ld		(flag_boss_donjon),a	; numeros de l'objet laissé
	ld		a,30
	ld		(bankROM),a
	call	rom_on
	LD		HL,BOSS4_ROM_30
	LD		DE,MEM_TAMPON_BOSS
	LD		BC,#1000
	LDIR
	call 	rom_off
	call	asic_off
	call	c0_on	
	ld		a,31
	ld		(bankROM),a
	call	rom_on
	LD		HL,BOSS4_ROM_31
	LD		DE,MEM_TAMPON_BOSS+#1000
	LD		BC,#1000
	LDIR
	call 	rom_off
	call	asic_on
	ld		a,25
	ld		(cycle_anim_boss_4),a
	ld		(compteur_anim_boss_4),a
	ret
	

init_sprite_boss_4
	call	asic_on
	LD		a,2
	LD		(etape_boss_4),a
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	init_sprite_boss_4_ROM
	call	rom_off
	RET
on_affiche_le_boss_4
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	on_affiche_le_boss_4_ROM
	call	rom_off
	ret
	
update_du_boss_4
	ld		a,(cycle_anim_boss_4)
	dec		a
	ld		(cycle_anim_boss_4),a
	cp		a,0
	jr		z,animation_suivante_boss_4
	RET
animation_suivante_boss_4
	ld		a,(compteur_anim_boss_4)
	cp		a,1
	jr		z,animation_2_boss4
	cp		a,2
	jr		z,animation_3_boss4
	cp		a,3
	jr		z,animation_1_boss4
animation_1_boss4
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	animation_1_boss4_ROM
	call	rom_off
	ret
animation_2_boss4
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	animation_2_boss4_ROM
	call	rom_off
	ret
animation_3_boss4
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	animation_3_boss4_ROM
	call	rom_off
	ret
mort_boss_4
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	mort_boss_4_ROM
	call	rom_off
	ret
affiche_recompense4
	ld		a,(flag_receptacle_coeur_donjon4)
	or		a
	RET		nz
recompense_boss_4
	ld		hl,SPRH_COEUR2_ADR
	ld		(OBJET_AUTRE_ADR),hl
	ld		a,#C3
	ld		(event_objet_spawn_donjon),a
	ld		hl,objet_spawn_donjon
	LD		(event_objet_spawn_donjon+1),hl
efface_event_boss_4
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	efface_event_boss_4_ROM
	call	rom_off
	ld 		c,2   ;Channel (0-2)
    call 	PLY_AKG_StopSoundEffectFromChannel
	call	MORT_MONSTRE_1
	RET
	

	
	
	