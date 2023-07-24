ennemis_bank28_ROM
	or		a
	XOR		A
	ld		(flag_anim_2_sprites),a
	ld		(flag_anim_4_sprites),a
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		de,#E000
	sbc		hl,de
	jp		nc,a2_sprites
	
	; ------------------------ 
	or		a
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		de,#C000
	sbc		hl,de
	jp		nc,a4_sprites
	; ------------------------ 
ret

a2_sprites_ROM

	ld		a,1
	ld		(flag_anim_2_sprites),a
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		de,PEAHAT_ROM
	sbc	hl,de
	jp		z,peathat_on
	OR		A
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		de,GHINI_ROM
	sbc	hl,de
	jp		z,ghini_on
	OR		A
	ld		hl,(TYPE_MONSTRE_ADR)
	ld		de,KEESES_ROM
	sbc	hl,de
	jp		z,keeses_on
	XOR	A
	ld		(flag_peahat),a
	RET


lecture_objets_donjon_ROM
ld		a,nbr_cycle_attente_monstre
	ld		(attente_naissance_des_monstres),a	
	ld		a,#C3
	ld		(event_objets_donjon),a
	ld		hl,(objet_donjon_label)
	LD		(event_objets_donjon+1),hl	
	ld		a,(flag_boss_donjon)
	cp		a,1
	call	Z,del_on
	cp		a,2
	call	Z,del_on
ret


DESACTIVATION_EVENTS_ROM
	xor		a
	LD		(event_bouledefeu),a
	LD		(event_bouledefeu+1),a
	LD		(event_bouledefeu+2),a
	ld		(flag_derniere_boule),a
	ld		(une_bouledefeu_est_en_cours),a
	ld		(direction_bouledefeu_en_cours),a
	LD		(event_objet_spawn_donjon),a
	LD		(event_objet_spawn_donjon+1),a
	LD		(event_objet_spawn_donjon+2),a
	LD		(event_passage_spawn_donjon),a
	LD		(event_passage_spawn_donjon+1),a
	LD		(event_passage_spawn_donjon+2),a
	LD		(event_bosses_donjon),a
	LD		(event_bosses_donjon+1),a
	LD		(event_bosses_donjon+2),a
	ld		(etape_boss_1),a
	ld		(etape_boss_2),a
	ld		(etape_boss_3),a
	ld		(etape_boss_4),a
	LD		(event_objet_hyrule_centre),a
	LD		(event_objet_hyrule_centre+1),a
	LD		(event_objet_hyrule_centre+2),a
	LD		(event_boss_3_boules_de_feu),a
	LD		(event_boss_3_boules_de_feu+1),a
	LD		(event_boss_3_boules_de_feu+2),a
	LD		(event_boss_3_boules_de_feu2),a
	LD		(event_boss_3_boules_de_feu2+1),a
	LD		(event_boss_3_boules_de_feu2+2),a
	ld		(flag_boss_donjon),a
	ld		(flag_anim_2_sprites),a
	ld		(flag_anim_4_sprites),a
	ld		(init_indice_donjon),a
	ld		(flag_stop_monstres),a
	;ld		(event_link_clignote),a
	ret
	
ACTIVATION_EVENTS_HYRULE_ROM
	ld		a,(flag_donjon)
	cp		a,0
	RET		NZ
	LD		a,#CD								; sinon on créer l'venement monstre 1
	LD		(event_objets_hyrule),a
	LD		hl,objet_hyrule
	LD		(event_objets_hyrule+1),hl
	ld		a,(No_PIECE)
	cp		a,255
	call	z,flag_ocean_on
	ld		a,(No_PIECE)
	cp		a,55
	call	z,flag_hyrule_on
	;cp		a,233
	;call	z,en_route_vers_zelda
	;cp		a,234
	;call	z,demi_tour_de_zelda
	ret
	
		
