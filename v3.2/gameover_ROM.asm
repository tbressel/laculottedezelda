animation_link_gameover_ROM
	call	asic_on
	ld		a,(etape_gameover)
	cp		a,1
	jp		z,init_gameover_etape1
	cp		a,2
	jp		z,init_gameover_etape2
	cp		a,3
	jp		z,init_gameover_etape3
	cp		a,4
	jp		z,init_gameover_etape4
	cp		a,5
	jp		z,reinit_gameover
	ret
init_gameover_etape1
	ld		hl,LINK_B1_adr
	ld		(SPRH0_GAMEOVER),hl
	jp		affiche_gameover
init_gameover_etape2
	ld		hl,LINK_D1_adr
	ld		(SPRH0_GAMEOVER),hl
	jp		affiche_gameover
init_gameover_etape3
	ld		hl,LINK_H1_adr
	ld		(SPRH0_GAMEOVER),hl
	jp		affiche_gameover
init_gameover_etape4
	ld		hl,LINK_G1_adr
	ld		(SPRH0_GAMEOVER),hl
	jp		affiche_gameover
affiche_gameover
	LD		hl,(SPRH0_GAMEOVER)
	LD		de,(SPRH_ADR)
	LD		bc,#200
	LDIR
	ld		a,(compteur_gameover)
	dec	a
	ld		(compteur_gameover),a
	cp		a,0
	jp		z,affiche_gameover_suite
	ret
affiche_gameover_suite
	ld		a,(etape_gameover)
	inc	a
	ld		(etape_gameover),a
	ld		a,3
	ld		(compteur_gameover),a
	RET
reinit_gameover
	ld		a,(nbr_tour_complet)
	dec	a
	ld		(nbr_tour_complet),a
	cp		a,0
	jp		z,ecran_fade_out	
	ld		a,1
	ld		(etape_gameover),a
	RET
ecran_fade_out
	LD		hl,#E700
	LD		de,(SPRH_ADR)
	LD		bc,#200
	LDIR
Zelda_fini
	jp		init_screen_gameover



	
extinction_des_couleurs_Game_Over	
	call	asic_on
	Xor 	a									; on met 0 dans A
	ld 		hl,PALETTE_OCEAN							; début à effacer en #0FFF
	ld 		e,l									
	ld 		d,h									
	inc 	de									; on incremente de 1 l'adresse à effacer
	ld 		(hl),a								; et on met 0 dans l'octet de l'adresse 
	LD 		BC,#20							; sur une longueur de #3000
	ldir	
	ld	hl,PALETTE_OCEAN
	ld	(type_de_palette),hl
	ld	(type_de_palette2),hl
	RET
	
	
on_met_tout_a_zero_ROM
	xor	a
	LD		(event_passage_spawn_donjon),a
	LD		(event_passage_spawn_donjon+1),a
	LD		(event_passage_spawn_donjon+2),a
	LD		(event_attente),a
	LD		(event_attente+1),a
	LD		(event_attente+2),a
	LD		(event_attaque),a
	LD		(event_attaque+1),a
	LD		(event_attaque+2),a
	LD		(event_objets_donjon),a
	LD		(event_objets_donjon+1),a
	LD		(event_objets_donjon+2),a
	LD		(event_objets_hyrule),a
	LD		(event_objets_hyrule+1),a
	LD		(event_objets_hyrule+2),a
	LD		(event_objets_hyrule),a
	LD		(event_objets_hyrule),a
	LD		(event_objets_hyrule+1),a
	LD		(event_objets_hyrule+2),a
	LD		(event_link),a
	LD		(event_link+1),a
	LD		(event_link+2),a
	;ld		(event_testclavier),a
	;ld		(event_testclavier+1),a
	;ld		(event_testclavier+2),a
	ld		(event_testtouche),a
	ld		(event_testtouche+1),a
	ld		(event_testtouche+2),a
	LD		(event_boss_3_boules_de_feu),a
	LD		(event_boss_3_boules_de_feu+1),a
	LD		(event_boss_3_boules_de_feu+2),a
	LD		(flag_fire1),a
	ld		(flag_fire2),a
	ret
	
attente_fire_1_ou_2_ROM8
	ld		a,(cycle_fire1_et_2)
	inc		a
	ld		(cycle_fire1_et_2),a
	cp		a,1
	jp		z,afficher_fire_1
	cp		a,30
	jp		z,effacer_fire_1
	cp		a,60
	jp		z,afficher_fire_1
	cp		a,90	
	jp		z,effacer_fire_1
	cp		a,120
	jp		z,afficher_fire_2
	cp		a,150
	jp		z,effacer_fire_2
	cp		a,180
	jp		z,afficher_fire_2
	cp		a,210
	jp		z,effacer_fire_2
	cp		a,240
	jp		z,reinit_affiche_fire_1_et_2
	cp		a,255
	jp		z,reinit_affiche_fire_1_et_2
	RET
reinit_affiche_fire_1_et_2
	xor		a
	ld		(cycle_fire1_et_2),a
	ret
afficher_fire_1
	call	asic_on
	ld	hl,DEPART_FIRE1_XGO
	ld	de,DEPART_FIRE1_YGO
	ld	(SPRH0_X),hl
	ld	(SPRH0_Y),de
	ld	hl,DEPART_FIRE1_XGO+32
	ld	de,DEPART_FIRE1_YGO
	ld	(SPRH1_X),hl
	ld	(SPRH1_Y),de
	ld	hl,DEPART_FIRE1_XGO+64
	ld	de,DEPART_FIRE1_YGO
	ld	(SPRH2_X),hl
	ld	(SPRH2_Y),de
	ld	hl,DEPART_FIRE1_XGO+96
	ld	de,DEPART_FIRE1_YGO
	ld	(SPRH3_X),hl
	ld	(SPRH3_Y),de
	ld	hl,DEPART_FIRE1_XGO+128
	ld	de,DEPART_FIRE1_YGO
	ld	(SPRH4_X),hl
	ld	(SPRH4_Y),de	
	ld	hl,DEPART_FIRE1_XGO+160
	ld	de,DEPART_FIRE1_YGO
	ld	(SPRH5_X),hl
	ld	(SPRH5_Y),de
; pour commencer	
	ld	hl,DEPART_FIRE1B_XGO
	ld	de,DEPART_FIRE1B_YGO
	ld	(SPRH7_X),hl
	ld	(SPRH7_Y),de
	ld	hl,DEPART_FIRE1B_XGO+64
	ld	de,DEPART_FIRE1B_YGO
	ld	(SPRH8_X),hl
	ld	(SPRH8_Y),de
	ld	hl,DEPART_FIRE1B_XGO+96
	ld	de,DEPART_FIRE1B_YGO
	ld	(SPRH9_X),hl
	ld	(SPRH9_Y),de
	ld	hl,DEPART_FIRE1B_XGO+128
	ld	de,DEPART_FIRE1B_YGO
	ld	(SPRH10_X),hl
	ld	(SPRH10_Y),de

	
	ld	a,9
		ld	(SPRH0_ZOOM),a
		ld	(SPRH1_ZOOM),a
		ld	(SPRH2_ZOOM),a
		ld	(SPRH3_ZOOM),a
		ld	(SPRH4_ZOOM),a
		ld	(SPRH5_ZOOM),a
		ld	(SPRH7_ZOOM),a
		ld	(SPRH8_ZOOM),a
		ld	(SPRH9_ZOOM),a
		ld	(SPRH10_ZOOM),a
		
	xor	a
		ld	(SPRH6_ZOOM),a
		ld	(SPRH11_ZOOM),a
		ld	(SPRH12_ZOOM),a
		ld	(SPRH13_ZOOM),a
		ld	(SPRH14_ZOOM),a
			ld	(SPRH15_ZOOM),a
	ret
afficher_fire_2
	call	asic_on
	ld	hl,DEPART_FIRE1_XGO
	ld	de,DEPART_FIRE1_YGO
	ld	(SPRH0_X),hl
	ld	(SPRH0_Y),de
	ld	hl,DEPART_FIRE1_XGO+32
	ld	de,DEPART_FIRE1_YGO
	ld	(SPRH1_X),hl
	ld	(SPRH1_Y),de
	ld	hl,DEPART_FIRE1_XGO+64
	ld	de,DEPART_FIRE1_YGO
	ld	(SPRH2_X),hl
	ld	(SPRH2_Y),de
	ld	hl,DEPART_FIRE1_XGO+96
	ld	de,DEPART_FIRE1_YGO
	ld	(SPRH3_X),hl
	ld	(SPRH3_Y),de
	ld	hl,DEPART_FIRE1_XGO+128
	ld	de,DEPART_FIRE1_YGO
	ld	(SPRH4_X),hl
	ld	(SPRH4_Y),de	
	ld	hl,DEPART_FIRE1_XGO+160
	ld	de,DEPART_FIRE1_YGO
	ld	(SPRH6_X),hl
	ld	(SPRH6_Y),de
; pour recommancer
	ld	hl,DEPART_FIRE1B_XGO
	ld	de,DEPART_FIRE1B_YGO
	ld	(SPRH7_X),hl
	ld	(SPRH7_Y),de
	ld	hl,DEPART_FIRE1B_XGO+64
	ld	de,DEPART_FIRE1B_YGO
	ld	(SPRH11_X),hl
	ld	(SPRH11_Y),de
	ld	hl,DEPART_FIRE1B_XGO+96
	ld	de,DEPART_FIRE1B_YGO
	ld	(SPRH12_X),hl
	ld	(SPRH12_Y),de
	ld	hl,DEPART_FIRE1B_XGO+128
	ld	de,DEPART_FIRE1B_YGO
	ld	(SPRH13_X),hl
	ld	(SPRH13_Y),de
	ld	hl,DEPART_FIRE1B_XGO+160
	ld	de,DEPART_FIRE1B_YGO
	ld	(SPRH14_X),hl
	ld	(SPRH14_Y),de
	ld	hl,DEPART_FIRE1B_XGO+192
	ld	de,DEPART_FIRE1B_YGO
	ld	(SPRH15_X),hl
	ld	(SPRH15_Y),de
	
	
	
	
		ld	a,9
		ld	(SPRH0_ZOOM),a
		ld	(SPRH1_ZOOM),a
		ld	(SPRH2_ZOOM),a
		ld	(SPRH3_ZOOM),a
		ld	(SPRH4_ZOOM),a
		ld	(SPRH6_ZOOM),a
		ld	(SPRH7_ZOOM),a
	
		ld	(SPRH11_ZOOM),a
		ld	(SPRH12_ZOOM),a
		ld	(SPRH13_ZOOM),a
		ld	(SPRH14_ZOOM),a
		ld	(SPRH15_ZOOM),a
		
	
	
	
		xor	a
		ld	(SPRH5_ZOOM),a
			ld	(SPRH8_ZOOM),a
		ld	(SPRH9_ZOOM),a
		ld	(SPRH10_ZOOM),a
		
	ret





ret
effacer_fire_2

xor	a
	ld	(SPRH0_ZOOM),a
	ld	(SPRH1_ZOOM),a
	ld	(SPRH2_ZOOM),a
	ld	(SPRH3_ZOOM),a
	ld	(SPRH4_ZOOM),a
	ld	(SPRH6_ZOOM),a
	ld	(SPRH7_ZOOM),a
	ld	(SPRH8_ZOOM),a
	ld	(SPRH9_ZOOM),a
	ld	(SPRH10_ZOOM),a
	ld	(SPRH11_ZOOM),a
			ld	(SPRH12_ZOOM),a
		ld	(SPRH13_ZOOM),a
		ld	(SPRH14_ZOOM),a
			ld	(SPRH15_ZOOM),a
	RET


effacer_fire_1
	xor	a
	ld	(SPRH0_ZOOM),a
	ld	(SPRH1_ZOOM),a
	ld	(SPRH2_ZOOM),a
	ld	(SPRH3_ZOOM),a
	ld	(SPRH4_ZOOM),a
	ld	(SPRH5_ZOOM),a
	
	ld	(SPRH7_ZOOM),a
	ld	(SPRH8_ZOOM),a
	ld	(SPRH9_ZOOM),a
	ld	(SPRH10_ZOOM),a
	ld	(SPRH11_ZOOM),a
			ld	(SPRH12_ZOOM),a
		ld	(SPRH13_ZOOM),a
		ld	(SPRH14_ZOOM),a
			ld	(SPRH15_ZOOM),a
	RET
	


	
	