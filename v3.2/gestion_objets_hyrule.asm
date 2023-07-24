; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////// OBJET DANS HYRULE ////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////

objet_hyrule

	or		a
	ld		a,(No_PIECE)								; on récupère de no de la pièce dans laquelle on se trouve
	cp		a,40										; pièce no 2 ?
	Jr		z,event_objet_porte_donjon_1				; ... alors on va afficher l'event qui affiche l'objet dans hyrule
	cp		a,255
	JP		z,musique_des_oceans
	cp		a,55
	JP		z,musique_de_hyrule
	;cp		a,233
	;JP		z,en_route_vers_zelda
	;cp		a,234
	;JP		z,demi_tour_de_zelda
	RET												; on retourne dans la boucle
event_objet_porte_donjon_1
	ld		a,(flag_porte_donjon_1)						; avant d'afficher l'objet on vérifie qu'on l'a pas déjà
	or		a
	RET		NZ											; si on l'a déjà (flag à 1) on retourne dans la boucle. Sinon on continue.
	ld		a,#CD										; #cd = call
	ld		(event_objet_hyrule_centre),a
	ld		hl,affiche_objet_hyrule
	ld		(event_objet_hyrule_centre+1),hl					; l'évenement affiche_objet_hyrule est présent dans la boucle
	ld		a,objet_porte_donjon_1
	ld		(type_objet_centre),a
	xor		a
	ld		(compteur_etape_objet_hyrule),a
	ret												; on retourne dans la boucle
	
affiche_objet_hyrule
	ld		a,9
	ld		(identification_monstre_en_cours),a
	ld		a,(compteur_etape_objet_hyrule)
	cp		a,0
	jp		nz,test_objet_porte_donjon_1
	inc		a
	ld		(compteur_etape_objet_hyrule),a
	xor		a											; on arrive ici si on a un objet à afficher et que l'event "affiche_objet_hyrule" est présent dans la boucle.
	LD		(event_objets_hyrule),a						; dans ce cas on à plus besoin de tester innutilement la pièce donc on efface l'event "event_objets_hyrule"
	LD		(event_objets_hyrule+1),a
	LD		(event_objets_hyrule+2),a
affiche_objet_porte_donjon_1								; ici on va afficher l'objet au bon endroit
	ld		a,25
	ld		(bankROM),a
	call 	rom_on
	ld		hl,148
	ld		(SPRH11_Y),hl
	ld		(SPRH_Y),hl
	ld		hl,224
	ld		(SPRH11_X),hl
	ld		(SPRH_X),hl
	ld		hl,SPRH_CLE_DONJON_ADR
	ld		de,SPRH11_ADR
	ld		bc,#100
	LDIR
	ld		a,1
	ld		(flag_monstre7),a
	ld		a,9
	ld		(identification_monstre_en_cours),a
	ld		(SPRH11_ZOOM),a
	call 	rom_off
	RET
test_objet_porte_donjon_1
	ld		hl,148
	ld		(SPRH_Y),hl
	ld		hl,224
	ld		(SPRH_X),hl
	call	code_bank2_on
	call	rom_on
	call	test_collisions_items
	call	rom_off
	call 	code_bankx_off
	ret
	


link_porte_objet
	ld		a,120
	ld		(compteur_attente_objet),a
	call	clavier_off
	
	ld		a,29
	ld		(bankROM),a
	call 	rom_on
	ld		hl,LINK_POSE_FACE
	ld		de,SPRH0_ADR
	ld		bc,#100
	LDIR
	call	rom_off
	
	xor		a
	ld		(SPRH1_ZOOM),a
	ld		(flag_sprh1),a
	ld		a,9
	ld		(SPRH0_ZOOM),a
	ld		(SPRH11_ZOOM),a
	ld		a,1
	ld		(flag_sprh0),a
	ld		(flag_monstre7),a
	ld		hl,(SPRH0_X)
	ld		de,-13
	add		hl,de
	ld		(SPRH11_X),hl
	ld		de,(SPRH0_Y)
	ld		hl,-16
	add		hl,de
	ld		(SPRH11_Y),hl
	
	Call	sfx_nouvel_objet
	RET

link_porte_objet2
	ld		a,120
	ld		(compteur_attente_objet),a
	call	clavier_off
	ld		a,29
	ld		(bankROM),a
	call 	rom_on
	ld		hl,LINK_POSE_FACE2
	ld		de,SPRH0_ADR
	ld		bc,#100
	LDIR
	call	rom_off
	
	xor		a
	ld		(SPRH1_ZOOM),a
	ld		(flag_sprh1),a
	ld		a,9
	ld		(SPRH0_ZOOM),a
	ld		(SPRH11_ZOOM),a
	ld		a,1
	ld		(flag_sprh0),a
	ld		(flag_monstre7),a
	ld		hl,(SPRH0_X)
	ld		(SPRH11_X),hl
	ld		de,(SPRH0_Y)
	ld		hl,-16
	add		hl,de
	ld		(SPRH11_Y),hl
	
	Call	sfx_nouvel_objet
	RET
	
link_porte_objet3
	ld		a,120
	ld		(compteur_attente_objet),a
	call	clavier_off
	ld		a,29
	ld		(bankROM),a
	call 	rom_on
	ld		hl,LINK_POSE_FACE
	ld		de,SPRH0_ADR
	ld		bc,#100
	LDIR
	xor		a
	ld		(SPRH1_ZOOM),a
	ld		(flag_sprh1),a
	ld		a,9
	ld		(SPRH0_ZOOM),a
	ld		(SPRH12_ZOOM),a
	ld		a,1
	ld		(flag_sprh0),a
	ld		(flag_monstre_zora),a
	ld		hl,(SPRH0_X)
	ld		de,-13
	add		hl,de
	ld		(SPRH12_X),hl
	ld		de,(SPRH0_Y)
	ld		hl,-16
	add		hl,de
	ld		(SPRH12_Y),hl
	call	rom_off
	Call	sfx_nouvel_objet
	RET	
	
	
link_porte_objet4
	ld		a,120
	ld		(compteur_attente_objet),a
	call	clavier_off
	ld		a,29
	ld		(bankROM),a
	call 	rom_on
	ld		hl,LINK_POSE_FACE
	ld		de,SPRH0_ADR
	ld		bc,#100
	LDIR
	xor		a
	ld		(SPRH1_ZOOM),a
	ld		(flag_sprh1),a
	ld		a,9
	ld		(SPRH0_ZOOM),a
	ld		(SPRH10_ZOOM),a
	ld		a,1
	ld		(flag_sprh0),a
	ld		(flag_monstre6),a
	ld		hl,(SPRH0_X)
	ld		de,-13
	add		hl,de
	ld		(SPRH10_X),hl
	ld		de,(SPRH0_Y)
	ld		hl,-16
	add		hl,de
	ld		(SPRH10_Y),hl
	call	rom_off
	Call	sfx_nouvel_objet
	RET	
	
	
clavier_off
	ld		a,1
	ld		(flag_stop_monstres),a
	xor		A
	ld		(event_testtouche),a
	ld		(event_testtouche+1),a
	ld		(event_testtouche+2),a
	ld		(event_objet_spawn_donjon),a
	ld		(event_objet_spawn_donjon+1),a
	ld		(event_objet_spawn_donjon+2),a
	ld		a,#CD
	ld		(event_attente),a
	ld		hl,decompte_attente
	LD		(event_attente+1),hl	
	ret
decompte_attente
	ld		a,(compteur_attente_objet)
	dec		a
	ld		(compteur_attente_objet),a
	cp		a,0
	jp		z,fin_de_attente
	ret
fin_de_attente
	xor	A
	ld		(flag_stop_monstres),a
	call	flag_hyrule_on
	xor		a
	ld		(event_attente),a
	ld		(event_attente+1),a
	ld		(event_attente+2),a
	ld		(event_objet_gauche),a
	ld		(event_objet_gauche+1),a
	ld		(event_objet_gauche+2),a
	ld		(event_objet_droite),a
	ld		(event_objet_droite+1),a
	ld		(event_objet_droite+2),a
	ld		(event_objet_centre),a
	ld		(event_objet_centre+1),a
	ld		(event_objet_centre+2),a
	ld		(link_joue),a
	ld		(compteur_attente_objet),a
	;ld		a,(flag_boutique)
	;or		a
	;jp		z,on_remet_la_musique
	xor		a
	ld		(SPRH10_ZOOM),a
	ld		(SPRH11_ZOOM),a
	ld		(flag_monstre6),a
	ld		(flag_monstre7),a
	
	ld		a,26
	ld		(bankROM),a
	call 	rom_on
	ld		hl,SPRH_RIEN
	ld		(OBJET_CENTRE_ADR),hl
	ld		de,SPRH10_ADR
	ld		bc,#100
	ldir
	ld		hl,SPRH_RIEN
	ld		(OBJET_DROITE_ADR),hl
	ld		de,SPRH11_ADR
	ld		bc,#100
	ldir
		
	ld		a,(flag_perso_special)				; on test si on a un perdo plus grand genre TODD
	or		a
	jp		nz,on_efface_pas_perso_special
	xor	A
	LD		(SPRH12_ZOOM),a
	ld		(flag_monstre_zora),a
	ld		hl,SPRH_RIEN
	ld		(OBJET_GAUCHE_ADR),hl
	ld		de,SPRH12_ADR
	ld		bc,#100
	ldir
	call	rom_off
on_efface_pas_perso_special
	xor	A
	ld		a,#C3
	ld		(event_testtouche),a
	ld		hl,test_de_touches
	LD		(event_testtouche+1),hl

	di
	ld 		hl,Music         				;Initialisation
	ld		a,(save_musique_retour)
	call 	PLY_AKG_Init
	ei
	ret

	
musique_des_oceans
	ld		a,(flag_ocean)
	or		a
	jp		z,on_envoie_la_zik_ocean
	or		a
	RET		NZ
on_envoie_la_zik_ocean
		ld		a,1
		ld		(flag_ocean),a
		ld		hl,OBJETS_ALEATOIRES_OCEAN
		ld		(pointeur_objets_aleatoires),hl
		di
		ld 		hl,Music         				;Initialisation
		ld		a,MUSIC_OCEAN
		call 	PLY_AKG_Init
	ld	hl,PALETTE_OCEAN
	ld	(type_de_palette),hl
		ei
		ld		a,(on_peut_utiliser_le_radeau)
		or		a
		jr		nz,on_stop_utilisation_radeau
		RET
	on_stop_utilisation_radeau
			xor		a
			ld		(flag_radeau),a
			RET
	
musique_de_hyrule
		ld		a,(flag_ocean)
		or		a
		jp		nz,on_envoie_la_zik_hyrule
		RET
	on_envoie_la_zik_hyrule
			di
			ld 		hl,Music         				;Initialisation
			ld		a,MUSIC_HYRULE
			call 	PLY_AKG_Init
			EI
			xor		a
			ld		(flag_ocean),a
			ld	hl,OBJETS_ALEATOIRES_HYRULE
			ld	(pointeur_objets_aleatoires),hl
			ld		a,(on_peut_utiliser_le_radeau)
			or		a
			jr		nz,on_allume_utilisation_radeau
			RET	
		on_allume_utilisation_radeau
					ld		a,1
					ld		(flag_radeau),a
					RET

test_si_on_va_ou_vient_de_ocean
	ld		a,(No_PIECE)								; on récupère de no de la pièce dans laquelle on se trouve
	cp		a,255
	JR		z,on_copie_les_tiles_ocean
	cp		a,55
	JP		z,on_copie_les_tiles_hyrule
	ret


; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////// ON ENTRE DANS L'OCEAN ////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////	
on_copie_les_tiles_ocean
	ld		a,13							; sélèction de la banque contenant
	ld		(BankROM),a						; les tiles des différents donjons
	call	rom_on
	call 	asic_off
	call	c4_on
	ld		hl,#c000							; lecture
	ld		de,TILE_ADR							; ecriture
	ld		bc,#4000							; longueur
	LDIR
	ld		a,15							; sélèction de la banque contenant
	ld		(BankROM),a						; les tiles des différents donjons
	call	rom_on
	call	c4_on
; Tiles de 8 octets de large pour la fonte des boutique
	ld		hl,#D400							; lecture
	ld		de,FONTE_TEXTE						; ecriture
	ld		bc,#05B0							; longueur
	LDIR
; Tiles de  coeur
	ld		hl,#D9B0							; lecture
	ld		de,COEURS_VIE_ADR_RAM				; ecriture
	ld		bc,#0060							; longueur
	LDIR
; on change l'aspect de Link
	call 	asic_on
	call	c4_off
	LD		hl,LINK3_D1						; on met le type de link dans une variable générale.
	LD		(LINK_ADR),hl
; on sauvegarde le link actuel mou_vement + attaque (16+8=24)
	ld		hl,Table_type_link					; on lit la première ligne qui corresponds au link dans hyrule (actualisé ou non)
	ld		de,Table_type_link+56				; on cible la ligne (5) pour sauvegarder l'état de link
	ld		bc,24								; on copie également ses attaques
	LDIR
; on met à jour le link actuel	
	ld		hl,Table_type_link+40				; on lit la ligne (4) de link qui nage dans l'océan
	ld		de,Table_type_link					; et on ecrit le link qui nage en première ligne 
	ld		bc,16								; link n'attaque jamais dans l'eau donc on touche à rien
	LDIR
	call	Link_Update
	call	fire1_off
	call	fire2_off
; on met à jour le gps
	ld		hl,(gps)
	ld		(save_gps_hyrule),hl
	ld		hl,OCEAN_GPS_DEPART
	ld		(gps),hl
; /////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////  ON REMET LA MAP DE HYRULE //// ////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////
; On efface la map avec une map noir
	ld		hl,MAP_HYRULE
	ld		(map_a_lire),hl
	call	on_affiche_la_putain_de_carte

	ld		a,(flag_triforce_4)
	or		a
	call	nz,on_ouvre_le_passage_vers_zelda	
	REt 

on_ouvre_le_passage_vers_zelda
	ld		a,8
	ld		(BankROM),a
	call	rom_on_bank_prog
	call	on_ouvre_le_passage_vers_zelda_ROM
	call	rom_off
	ret

	
	
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////// ON REVIENT DANS HYRULE ////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////	
	
on_copie_les_tiles_hyrule
	
	ld		a,23							; sélèction de la banque contenant
	ld		(BankROM),a						; les tiles des différents donjons
	call	rom_on
	call 	asic_off
	call	c4_on
	ld		hl,#c000							; lecture
	ld		de,TILE_ADR							; ecriture
	ld		bc,#4000							; longueur
	LDIR
	ld		a,15							; sélèction de la banque contenant
	ld		(BankROM),a						; les tiles des différents donjons
	call	rom_on
	call	c4_on
	; Tiles de 8 octets de large pour la fonte des boutique
	ld		hl,#D400							; lecture
	ld		de,FONTE_TEXTE						; ecriture
	ld		bc,#05B0							; longueur
	LDIR
	; Tiles de  coeur
	ld		hl,#D9B0							; lecture
	ld		de,COEURS_VIE_ADR_RAM				; ecriture
	ld		bc,#0060							; longueur
	LDIR
	call 	asic_on
	call	c4_off
	LD		hl,LINK_G1						; on met le type de link dans une variable générale.
	LD		(LINK_ADR),hl
	; on recupère la sauvegarde de link
	ld		hl,Table_type_link+56				; On lit la ligne (6) qui a été sauvegardé précédement
	ld		de,Table_type_link					; on la recopie dans la ligne (1)
	ld		bc,24		
	LDIR
	
	call	Link_Update
	; on récupère le gps
	ld		hl,(save_gps_hyrule)
	ld		(gps),hl
; /////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////  ON REMET LA MAP DE HYRULE //// ////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////

; On efface la map avec une map noir
	ld		hl,MAP_HYRULE
	ld		(map_a_lire),hl
	call	on_affiche_la_putain_de_carte
	call	fire1_on
	call	fire2_on
	RET 
	
;en_route_vers_zelda
;	xor	a
;	ld		(flag_stop_monstres),a
;	ld		(flag_etape_du_monstre1),a
;	ld		(flag_ocean),a
;	ld		a,1
;	ld		(flag_route_vers_zelda),a
;	ret
	
;demi_tour_de_zelda
;	ld		a,1
;	ld		(flag_stop_monstres),a
;	ld		(flag_ocean),a
;	xor		a
;	ld		(flag_route_vers_zelda),a
	
;	ret
	

	
	

