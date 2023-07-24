; *********************************************************************************************
; ********************************** ON ENTRE DANS LA BOUTIQUE ********************************
; *********************************************************************************************
affiche_boutique
	di
	ld 		hl,Music         				;Initialisation
	ld		a,MUSIC_BOUTIQUE
	ld		(save_musique_retour),a 
	call 	PLY_AKG_Init
	ei
	call	fire1_off
	call	code_bank2_on
	call	rom_on
	JP		affiche_boutique_ROM
	
; *********************************************************************************************
; ********************************** ON SORT DE LA BOUTIQUE ********************************
; *********************************************************************************************
RETOUR_DE_BOUTIQUE						; on arrive ici depuis le label VERS_LE_BAS (Direction.asm)
	di
	ld		a,(flag_ocean)
	cp		a,1
	jr		z,retour_zic_ocean
			ld			hl,PALETTE_HYRULE
	ld			(type_de_palette),hl
	ld 		hl,Music         				;Initialisation
	ld		a,MUSIC_HYRULE
	jr		on_envoie_la_zicmu
retour_zic_ocean
		ld			hl,PALETTE_OCEAN
	ld			(type_de_palette),hl
	ld 		hl,Music         				;Initialisation
	ld		a,MUSIC_OCEAN

	jr		on_envoie_la_zicmu

on_envoie_la_zicmu
	ld		(save_musique_retour),a 	
	call 	PLY_AKG_Init
	ei
	call	code_bank2_on
	call	rom_on
	call	retour_de_boutique_ROM
	call	rom_off
	call 	code_bankx_off
	call	fire1_on
	call	fire2_on
	JP 		NOUVELLE_PIECE				; si on a rien pris on laisse les objets dans la maptile

; *********************************************************************************************
; ********************************** ON EST DANS LA BOUTIQUE ********************************
; *********************************************************************************************
FLAMMES
	ld		a,(flag_flammes)
	cp		a,1
	jr		z,init_perso
	cp		a,2
	jp		z,init_items
	cp		a,3
	jp		z,update_flammes
init_flammes
; Dans une boutique
	ld		a,1								; on signale que les flammes,présentes, en sont à l'étape 1
	ld		(flag_flammes),a				; c'est à dire l'init.
	ld		a,cycle_total_animation_flammes
	ld		(compteur_anim_flammes),a
; Dans une maison	
	ld		a,(flag_maison)					; sauf que si on est dans une maison, le flag maison
	or		a								; est à 1 et donc on veut pas de feu dans les baraques
	jr		nz,init_perso					; donc on zappe le code qui suite et on s'occupe du perso.
	ld		a,25 : ld (bankROM),a : call rom_on
	ld		hl,FLAMME_G							; flamme gauche et droite se suivent en mémoire
	ld		de,SPRH14_ADR						; sprh14 et 15 également
	ld		bc,#200								; on définit une longueur équivalente aux deux sprites
	LDIR
	call 	rom_off											; ld b,2  on aggne 1 octet  que si on fait ld bc,#200
	ld		a,9
	ld		(SPRH14_ZOOM),a
	ld		(SPRH15_ZOOM),a
	ld		a,1
	ld		(flag_sprh14),a
	ld		(flag_sprh15),a

init_perso
	ld		a,2							; on est l'étape 2 des flammes, mais là c'ets le perso.
	ld		(flag_flammes),a
	ld		a,26:	ld		(bankROM),a:	call 	rom_on
	ld		hl,(PERSO_SPR_ADR)
	ld		de,SPRH13_ADR
	ld		bc,#100
	LDIR
	call 	rom_off
	
	ld		a,9									; si on est chez un marchands on laisse à 9
	ld		(SPRH13_ZOOM),a
	ld		a,1
	ld		(flag_sprh13),a
	
	ld		a,(flag_perso_special)				; on test si on a un perdo plus grand genre TODD
	or		a
	jr		nz,perso_special						; si oui alors on a une routine special pour çà
	RET
perso_special
	call	rom_on
	ld		hl,(PERSO_SPR_ADR2)
	ld		de,SPRH12_ADR
	ld		bc,#100
	LDIR
	call 	rom_off
	ld		a,9
	ld		(SPRH12_ZOOM),a
	ld		a,1
	ld		(flag_monstre_zora),a
	RET
init_items
	ld		a,3
	ld		(flag_flammes),a
	ld		a,25 : 	ld		(bankROM),a :	call 	rom_on
	ld		hl,(OBJET_CENTRE_ADR)
	ld		de,SPRH11_ADR
	ld		bc,#100
	LDIR
	ld		hl,(OBJET_AUTRE_ADR)				
	ld		de,SPRH9_ADR						
	ld		bc,#100								
	LDIR										
	ld		hl,(OBJET_GAUCHE_ADR)
	ld		de,SPRH10_ADR
	ld		bc,#100
	LDIR
	ld		a,(flag_perso_special)
	or		a
	jr		nz,perso_special2
	ld		hl,(OBJET_DROITE_ADR)
	ld		de,SPRH12_ADR
	ld		bc,#100
	LDIR
perso_special2
	call 	rom_off
	ld		a,9
	ld		(SPRH9_ZOOM),a
	ld		(SPRH10_ZOOM),a
	ld		(SPRH11_ZOOM),a
	ld		(SPRH12_ZOOM),a
	ld		a,1
	ld		(flag_monstre5),a				; à remonner dans tous les fichier plus
	ld		(flag_monstre6),a
	ld		(flag_monstre7),a
	ld		(flag_monstre_zora),a
	RET
update_flammes
	ld		a,(flag_maison)						; si on est dans une baraque alors pas de flammes.
	or		a
	ret		nz
	ld		a,(compteur_anim_flammes)
	dec		a
	ld		(compteur_anim_flammes),a
	cp		a,cycle_animation_flammes_etape1
	jr		z,anim_flammes_etape_1
	cp		a,cycle_animation_flammes_etape2
	jr		z,anim_flammes_etape_2
	cp		a,0
	jr		z,reinit_flammes
anim_flammes_etape_1
	ld		a,25
	ld		(bankROM),a
	call 	rom_on
	ld		hl,FLAMME_G
	ld		de,SPRH15_ADR
	ld		bc,#100
	LDIR
	ld		hl,FLAMME_D
	ld		de,SPRH14_ADR
	ld		bc,#100
	LDIR
	call 	rom_off
	RET
anim_flammes_etape_2
	ld		a,25
	ld		(bankROM),a
	call 	rom_on
	ld		hl,FLAMME_G
	ld		de,SPRH14_ADR
	ld		bc,#200
	LDIR
	call 	rom_off
	RET	
reinit_flammes
	ld		a,cycle_total_animation_flammes
	ld		(compteur_anim_flammes),a
	RET
	
; *********************************************************************************************
; ********************************** AFFICHAGE DES TEXTES ********************************
; *********************************************************************************************
affiche_texte
	ld		a,2
	ld		(bankROM),a
	call 	rom_on
	call	affiche_texte_ROM
	call	rom_off	
	ret

affiche_objet_gauche
	call	code_bank2_on
	call	rom_on
	ld		hl,(SPRH10_X)
	ld		(SPRH_X),hl
	ld		hl,(SPRH10_Y)
	ld		(SPRH_Y),hl
	ld		a,8
	ld		(identification_monstre_en_cours),a
	call	test_collisions_items
	call	rom_off
	ret		
affiche_objet_centre
	call	code_bank2_on
	call	rom_on
	ld		hl,(SPRH11_X)
	ld		(SPRH_X),hl
	ld		hl,(SPRH11_Y)
	ld		(SPRH_Y),hl
	ld		a,9
	ld		(identification_monstre_en_cours),a
	call	test_collisions_items
	call	rom_off
	ret		
affiche_objet_droite
	call	code_bank2_on
	call	rom_on
	ld		hl,(SPRH12_X)
	ld		(SPRH_X),hl
	ld		hl,(SPRH12_Y)
	ld		(SPRH_Y),hl
	ld		a,10
	ld		(identification_monstre_en_cours),a
	call	test_collisions_items
	call	rom_off
	ret		
