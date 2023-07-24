fire2_init_fleche_ROM
	call	fire2_off
	ld		a,#CD
	ld		(event_compteur_tirer),a
	ld		hl,compteur_tirer
	ld		(event_compteur_tirer+1),hl	
	ld		a,(flag_fleche_illimite)
	or		a
	jp		nz,on_decompte_pas_les_fleches
	ld		a,1									; on désign les rubis par le chiffre 1 ... c'est son chiffre
	ld		(type_objet),a						; et c'est à présent le type d'objet "1" donc rubis
	ld		hl,compteur_rubi					; on localise l'adresse du compteur de rubis
	ld		a,l									;
	ld		(selection_compteur),a
	ld		a,h
	ld		(selection_compteur+1),a
	call	calcul_decompteur_objet				; on a fait le décompte.
on_decompte_pas_les_fleches
	call	asic_on
	
	
	LD		a,1									; on met le flag_fire2 à 1 pour être sur de ne pas revenir ici 
	LD		(flag_fire2),a						; pendant que la fleche fait son boulot
	ld		(flag_premort),a
	LD		a,#C3								; on active l'event fleche
	LD		(event_fleche),a
	LD		hl,fleche
	LD		(event_fleche+1),hl	
	ld		a,4										; permet de savoir quelle est la dernière arme utilisée pour déterminer
	ld		(flag_type_arme_utilise),a				; quel type de point de vie décompter aux labels pre-mort monstre
	
	ld		a,(direction_en_cours)
	cp		a,1
	jp		z,init_fleche_a_gauche
	cp 		a,2
	jp		z,init_fleche_a_droite
	cp		a,3
	jp		z,init_fleche_en_haut
	cp		a,4
	jp		z,init_fleche_en_bas
	RET
	
init_fleche_a_gauche
	ld		(direction_fleche_en_cours),a
	ld		hl,LINK_FLECHE_G							; adresse de l'épée 1 dans la ROM
	ld		(FLECHE_SPR),hl							; envoyé dans une variable générale
	LD		hl,(SPRH0_X)
	ld		de,-8
	add		hl,de
	ld		(SPRH3_X),hl
	ld		hl,(SPRH0_Y)
	ld		(SPRH3_Y),hl
	RET
init_fleche_a_droite
	ld		(direction_fleche_en_cours),a
	ld		hl,LINK_FLECHE_D						; adresse de l'épée 1 dans la ROM
	ld		(FLECHE_SPR),hl							; envoyé dans une variable générale
	LD		hl,(SPRH0_X)
	ld		de,8
	add		hl,de
	ld		(SPRH3_X),hl
	ld		hl,(SPRH0_Y)
	ld		(SPRH3_Y),hl
	ret
init_fleche_en_haut
	ld		(direction_fleche_en_cours),a
	ld		hl,LINK_FLECHE_H						; adresse de l'épée 1 dans la ROM
	ld		(FLECHE_SPR),hl							; envoyé dans une variable générale
	LD		hl,(SPRH0_Y)
	ld		de,-5
	add		hl,de
	ld		(SPRH3_Y),hl
	ld		hl,(SPRH0_X)
	ld		(SPRH3_X),hl
	ret
init_fleche_en_bas
	ld		(direction_fleche_en_cours),a
	ld		hl,LINK_FLECHE_B						; adresse de l'épée 1 dans la ROM
	ld		(FLECHE_SPR),hl							; envoyé dans une variable générale
	LD		hl,(SPRH0_Y)
	ld		de,5
	add		hl,de
	ld		(SPRH3_Y),hl
	ld		hl,(SPRH0_X)
	ld		(SPRH3_X),hl
	ret
	
	
	
	
	
	
	
	
	
	
	
fire2_init_bombe_ROM

	ld		a,(nbr_bombe)
	cp		a,0
	jp		z,retour_fire2
	dec		a
	ld		(nbr_bombe),a
	ld		a,3
	ld		(type_objet),a
	ld		hl,compteur_bombe
	ld		a,l
	ld		(selection_compteur),a
	ld		a,h
	ld		(selection_compteur+1),a
	call	calcul_decompteur_objet
	call	asic_on
	
	LD		a,1				
	LD		(flag_fire2),a							; on met le flag_fire1 à 1
	
	LD		a,#C3
	LD		(event_bombe),a
	LD		hl,bombe
	LD		(event_bombe+1),hl		
	ld		a,5										; permet de savoir quelle est la dernière arme utilisée pour déterminer
	ld		(flag_type_arme_utilise),a				; quel type de point de vie décompter aux labels pre-mort monstre
	ld		a,(direction_en_cours)
	cp		a,1
	jp		z,init_bombe_a_gauche
	cp 		a,2
	jp		z,init_bombe_a_droite
	cp		a,3
	jp		z,init_bombe_en_haut
	cp		a,4
	jp		z,init_bombe_en_bas
	JP		retour_fire2
	
init_bombe_a_gauche
	
	;ld		hl,BOMBE_SPR							; adresse de la bombe dans la ROM
	
	LD		hl,(SPRH0_X)
	ld		de,-31
	add		hl,de
	ld		(SPRH3_X),hl
	ld		hl,(SPRH0_Y)
	ld		(SPRH3_Y),hl
	Call	collision_bombe_gauche
	JP		retour_fire2
init_bombe_a_droite
	
	;ld		hl,BOMBE_SPR						; adresse de l'épée 1 dans la ROM
	
	LD		hl,(SPRH0_X)
	ld		de,31
	add		hl,de
	ld		(SPRH3_X),hl
	ld		hl,(SPRH0_Y)
	ld		(SPRH3_Y),hl
	Call	collision_bombe_droite
	JP		retour_fire2
init_bombe_en_haut
	
	;ld		hl,BOMBE_SPR						; adresse de l'épée 1 dans la ROM
	
	LD		hl,(SPRH0_Y)
	ld		de,-15
	add		hl,de
	ld		(SPRH3_Y),hl
	ld		hl,(SPRH0_X)
	ld		(SPRH3_X),hl
	Call	collision_bombe_haut
	JP		retour_fire2
init_bombe_en_bas
	
	;ld		hl,BOMBE_SPR						; adresse de l'épée 1 dans la ROM
	
	LD		hl,(SPRH0_Y)
	ld		de,15
	add		hl,de
	ld		(SPRH3_Y),hl
	ld		hl,(SPRH0_X)
	ld		(SPRH3_X),hl
	Call	collision_bombe_bas
	JP		retour_fire2
	
	
	
	
	
	
	
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////   FEUUUUUUUUUUU  !!! ////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
fire2_init_feu_ROM
	LD	a,1				
	LD	(flag_fire2),a							; on met le flag_fire1 à 1
	ld	a,5									; permet de savoir quelle est la dernière arme utilisée pour déterminer
	ld	(flag_type_arme_utilise),a				; quel type de point de vie décompter aux labels pre-mort monstre
	ld (compteur_anim_feu),a
	
	ld	a,32
	ld (compteur_distanceX),a
	ld	a,16
	ld (compteur_distanceY),a
	
	LD	a,#C3
	LD	(event_feu),a
	LD	hl,feu
	LD	(event_feu+1),hl	
	
	ld		a,(direction_en_cours)
	cp		a,1
	jp		z,init_feu_a_gauche
	cp 		a,2
	jp		z,init_feu_a_droite
	cp		a,3
	jp		z,init_feu_en_haut
	cp		a,4
	jp		z,init_feu_en_bas
	RET
	
init_feu_a_gauche
	ld		(direction_feu_en_cours),a
	ld		hl,FLAMME_G						; adresse de l'épée 1 dans la ROM
	ld		(FEU_SPR),hl							; envoyé dans une variable générale
	LD		hl,(SPRH0_X)
	ld		de,-15
	add		hl,de
	ld		(SPRH3_X),hl
	ld		hl,(SPRH0_Y)
	ld		(SPRH3_Y),hl
	Call	collision_bombe_gauche
	RET
init_feu_a_droite
	ld		(direction_feu_en_cours),a
	ld		hl,FLAMME_G						; adresse de l'épée 1 dans la ROM
	ld		(feu_SPR),hl							; envoyé dans une variable générale
	LD		hl,(SPRH0_X)
	ld		de,15
	add		hl,de
	ld		(SPRH3_X),hl
	ld		hl,(SPRH0_Y)
	ld		(SPRH3_Y),hl
	Call	collision_bombe_droite
	RET
init_feu_en_haut
	ld		(direction_feu_en_cours),a
	ld		hl,FLAMME_G						; adresse de l'épée 1 dans la ROM
	ld		(feu_SPR),hl							; envoyé dans une variable générale
	LD		hl,(SPRH0_Y)
	ld		de,-7
	add		hl,de
	ld		(SPRH3_Y),hl
	ld		hl,(SPRH0_X)
	ld		(SPRH3_X),hl
	Call	collision_bombe_haut
	RET
init_feu_en_bas
	ld		(direction_feu_en_cours),a
	ld		hl,FLAMME_G						; adresse de l'épée 1 dans la ROM
	ld		(feu_SPR),hl							; envoyé dans une variable générale
	LD		hl,(SPRH0_Y)
	ld		de,7
	add		hl,de
	ld		(SPRH3_Y),hl
	ld		hl,(SPRH0_X)
	ld		(SPRH3_X),hl
	Call	collision_bombe_bas
	RET
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////   PARCHEMIN          ////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
fire2_init_parchemin_ROM
	ld		a,(flag_boutique)
	or		a
	JP		z,retour_fire2
	ld		a,(flag_parchemin)
	or		a
	jp		z,retour_fire2
	ld		a,(No_PIECE)
	cp		a,04
	call	z,deblocage_boutique_piece_29
	cp		a,51
	call	z,deblocage_boutique_piece_29
	cp		a,102
	call	z,deblocage_boutique_piece_29
	cp		a,77
	call	z,deblocage_boutique_piece_29
	cp		a,88
	call	z,deblocage_boutique_piece_29
	cp		a,126
	call	z,deblocage_boutique_piece_29
	cp		a,29
	call	z,deblocage_boutique_piece_29
	ld		a,0
	ld		(flag_fiole_bleu),a
	ld		(flag_fiole_rouge),a
	JP		retour_fire2
	
fire2_init_fiole_bleu_ROM
	ld		a,(flag_fiole_bleu)
	or		a
	JP		z,retour_fire2
	ld		a,(nbr_vies)
	ld		b,a
	ld		a,(nbr_vies_max)
	sbc		a,b
	cp		a,0
	jp		z,retour_fire2	
	xor		a
	ld		(flag_fiole_bleu),a
	ld		a,(nbr_vies_max)
	ld		(nbr_vies),a
	ld		h,0
	ld		l,a
	SRL H:RR L
	ld		b,l
	ld		ix,Table_adresse_ecran
	ld		e,(ix)
	ld		d,(ix+1)
	ld		hl,COEUR_ROUGE_HUD
	ld		(adr_memoire_coeur),hl
boucle_full_vie
	push	bc
	call	affichage_du_coeur
	inc		ix:inc ix
	ld		e,(ix)
	ld		d,(ix+1)
	ld		(adr_ecran_affiche_coeur),de
	pop		bc
	djnz	boucle_full_vie
	ld		a,1
	ld		(flag_vie_parite),a
	xor		a
	ld		(flag_fiole_rouge),a
	ld		a,(flag_fiole_rouge_gratuite)
	or		a
	jp		nz,retour_fire2
	ld		a,1
	ld		(flag_parchemin),a
	JP		retour_fire2
	
	
	
	
	
fire2_init_fiole_rouge_ROM
	ld		a,(flag_fiole_rouge)
	or		a
	JP		z,retour_fire2
	ld		a,(nbr_vies)
	ld		b,a
	ld		a,(nbr_vies_max)
	sbc		a,b
	cp		a,0
	jp		z,retour_fire2	
	xor		a
	ld		(flag_fiole_rouge),a
	ld		a,(nbr_vies_max)
	ld		(nbr_vies),a
	ld		h,0
	ld		l,a
	SRL H:RR L
	ld		b,l
	ld		ix,Table_adresse_ecran
	ld		e,(ix)
	ld		d,(ix+1)
	ld		hl,COEUR_ROUGE_HUD
	ld		(adr_memoire_coeur),hl
boucle_full_vie2
	push	bc
	call	affichage_du_coeur
	inc		ix:inc ix
	ld		e,(ix)
	ld		d,(ix+1)
	ld		(adr_ecran_affiche_coeur),de
	pop		bc
	djnz	boucle_full_vie2
	
	xor		a
	ld		(flag_parchemin),a
	ld		a,1
	ld		(flag_fiole_bleu),a
	ld		(flag_vie_parite),a
	JP		retour_fire2



init_petite_fee_ROM
	ld		a,(nbr_vies)
	ld		b,a
	ld		a,(nbr_vies_max)
	sbc		a,b
	cp		a,0
	RET		Z

	ld		a,(nbr_vies_max)
	ld		(nbr_vies),a
	ld		h,0
	ld		l,a
	SRL H:RR L
	ld		b,l
	ld		ix,Table_adresse_ecran
	ld		e,(ix)
	ld		d,(ix+1)
	ld		hl,COEUR_ROUGE_HUD
	ld		(adr_memoire_coeur),hl
boucle_full_vie3
	push	bc
	call	affichage_du_coeur
	inc		ix:inc ix
	ld		e,(ix)
	ld		d,(ix+1)
	ld		(adr_ecran_affiche_coeur),de
	pop		bc
	djnz	boucle_full_vie3	
	ld		a,1
	ld		(flag_vie_parite),a
	ld		a,3
	ld		(flag_etape_du_monstre1),a
	xor		a
	ld		(flag_contact_fee),a
	ret


	
	

	
	