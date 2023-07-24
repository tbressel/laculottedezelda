objet_gauche_on
ld		a,#CD
ld		(event_objet_gauche),a
ld		hl,affiche_objet_gauche
ld		(event_objet_gauche+1),hl
ret


EFFACE_OBJET_GAUCHE
	ld		a,(type_objet_gauche)		; on récupère le type d'objé saisié dans une boutique de provenance
	cp		a,objet_bouclier				; OBJET 11
	jp		z,efface_bouclier
	
	cp		a,objet_bouclier2				; OBJET 12
	jp		z,efface_bouclier2
	
	cp		a,objet_fiole_bleu				; OBJET 15
	jp		z,efface_fiole_bleu
	
	cp		a,objet_receptacle_coeur			; OBJET 8
	jp		z,efface_receptacle_coeur
	
	cp		a,objet_rubi_bleu_1
	jp		z,efface_rubi_bleu_1
	
	cp		a,objet_rubi_bleu86_1
	jp		z,efface_rubi_bleu86_1
	
	cp		a,objet_cle							; objet 3 si ce sont des bombes
	jp		z,calcule_boutique_cleg

	cp		a,objet_flute						; objet 3 si ce sont des bombes
	jp		z,efface_flute
	
	cp		a,objet_bombe				; objet 3 si ce sont des bombes
	jp		z,calcule_bombe_link

	cp		a,objet_sci				; objet 3 si ce sont des bombes
	jp		z,efface_sci
	
	cp		a,objet_noexit
	jp		z,efface_noexit

	ret
	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
efface_bouclier
; on verifie que l'on a assez de rubi pour acheter un bouclier
	ld		a,tarif_bouclier					; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_gauche   ; si le nombre de rubi est negatif alors on efface l'venement	
; on a ssuffisement de rubi alors on continu
	ld		a,1							;
	ld		(flag_bouclier),a				; on indique que la flèche est active
	ld		(compteur_bouclier1),a
	ld		hl,flag_objet_gauche		; on met l'adresse du flag de l'objet droite dans hl
	ld		a,objet_bouclier				
	ld		(hl),a
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_gauche
	call	link_porte_objet4
	ret	
	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////

efface_bouclier2
; on verifie que l'on a assez de rubi pour acheter un bouclier bleu
	ld		a,tarif_bouclier2				; on recupere le tarif du bouclier
	ld		(tarif_objet),a
	ld		e,a								 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc	hl,de
	jp		C,routine_efface_event_gauche   ; si le nombre de rubi est negatif alors on efface l'venement	

; on a ssuffisement de rubi alors on continu
	ld		a,1							
	ld		(flag_bouclier2),a				; on indique que la flèche est active
	ld		(compteur_bouclier2),a
	ld		hl,flag_objet_gauche			; on met l'adresse du flag de l'objet droite dans hl
	ld		a,objet_bouclier2				
	ld		(hl),a
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_gauche
	call	link_porte_objet4

; on modifie l'aspect de link	
	LD		hl,LINK2_SPR					; on met l'adresse du type de link dans une variable générale.
	LD		(LINK_ADR),hl
		
	ld		hl,Table_type_link+24			; on va allez lire la table des type de link avec bouclier bleu
	ld		de,Table_type_link				; et on la recopie sur la première ligne (1)
	ld		bc,16							; on recopie juste la position de link, les attaques sont les mêmes.
	LDIR									; pas besoin de sauvegarder l'ancien link, on y reviendra jamais.
	ret	


; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
efface_fiole_bleu
	; on verifie que l'on a assez de rubi pour acheter un bouclier
	ld		a,tarif_fiole_bleu			; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_gauche   ; si le nombre de rubi est negatif alors on efface l'venement	
	ld		a,1								;
	ld		(flag_fiole_bleu),a			; on indique que la flèche est active
	ld		a,0
	ld		(flag_parchemin),a
	ld		(flag_fiole_rouge),a
	ld		hl,flag_objet_gauche			; on met l'adresse du flag de l'objet droite dans hl
	ld		a,objet_fiole_bleu				
	ld		(hl),a
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_gauche
	call	link_porte_objet4
	ret	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////

efface_receptacle_coeur
	ld		hl,(flag_objet_gauche)			; on met l'adresse du flag de l'objet droite dans hl
	ld		a,1				
	ld		(hl),a
	ld		a,(nbr_vies_max)
	inc		a:inc a
	ld		(nbr_vies_max),a
	ld		(nbr_vies),a
	ld		h,0
	ld		l,a
	SRL H:RR L
	ld		b,l
	ld		ix,Table_adresse_ecran
	ld		e,(ix)
	ld		d,(ix+1)
	ld		(adr_ecran_affiche_coeur),de
	ld		hl,COEUR_ROUGE_HUD
	ld		(adr_memoire_coeur),hl
boucle_ajout_receptacle
	push	bc
	call	affichage_du_coeur
	inc		ix:inc ix
	ld		e,(ix)
	ld		d,(ix+1)
	ld		(adr_ecran_affiche_coeur),de
	pop		bc
	djnz	boucle_ajout_receptacle
	ld		a,1
	ld		(flag_vie_parite),a
	call	routine_efface_objet_gauche
	call	routine_efface_objet_droite
	call	link_porte_objet4
	ret	

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
efface_flute
; on verifie que l'on a assez de rubi pour acheter un bouclier
	ld		a,tarif_flute					; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_gauche   ; si le nombre de rubi est negatif alors on efface l'venement	
; on a ssuffisement de rubi alors on continu
	ld		a,1							;
	ld		(flag_flute),a				; on indique que la flèche est active
	ld		hl,flag_objet_gauche		; on met l'adresse du flag de l'objet droite dans hl
	ld		a,objet_flute				
	ld		(hl),a
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_gauche
		call	affiche_flute_hud
call	link_porte_objet4	
	ret	
	
	; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
efface_noexit
	xor		a
	ld		(tarif_objet),a
	ld		a,1							;
	ld		(flag_noexit),a				; on indique que la flèche est active
	ld		(flag_game),a
	ld		a,objet_noexit				
	ld		de,SPRH_NOEXIT_ADR
	jr		efface_le_jeu
efface_sci
; on verifie que l'on a assez de rubi pour acheter un bouclier
	ld		a,tarif_sci					; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_gauche   ; si le nombre de rubi est negatif alors on efface l'venement	
; on a ssuffisement de rubi alors on continu
	ld		a,1							;
	ld		(flag_sci),a				; on indique que la flèche est active
	ld		(flag_game),a
	ld		a,objet_sci	
	ld		de,SPRH_SCI_ADR
	
efface_le_jeu
	ld		hl,flag_objet_gauche		; on met l'adresse du flag de l'objet droite dans hl
	ld		(hl),a
	ld		(SPRH_JEU_ADR),de
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_gauche
	call	link_porte_objet4

	
	ret	

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
calcule_bombe_link
	ld		(type_objet),a
	ld		a,1
	ld		(flag_bombe),a
	ld		a,16	
	ld		(nbr_bombe),a
	ld		A,6
	ld		hl,compteur_bombe+2
	ld		(hl),a
	ld		A,1
	ld		hl,compteur_bombe+1
	ld		(hl),a
	call	affiche_compteur
	call	routine_efface_objet_gauche
	call	link_porte_objet4	
	ret		

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////

efface_rubi_bleu_1
	; on verifie que l'on a assez de rubi pour acheter un bouclier
	ld		a,tarif_rubi_bleu_1			; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_gauche   ; si le nombre de rubi est negatif alors on efface l'venement	
	ld		a,1								;
	ld		(flag_rubi_bleu_1),a			; on indique que la flèche est active
	ld		hl,flag_objet_gauche			; on met l'adresse du flag de l'objet droite dans hl
	ld		a,objet_rubi_bleu_1				
	ld		(hl),a
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_gauche
	call	link_porte_objet4	
	call	scenario_rubi_bleu_1_boutique_36
	ret	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
efface_rubi_bleu86_1
	; on verifie que l'on a assez de rubi pour acheter un bouclier
	ld			a,tarif_rubi_bleu86_1			; on recupere le tarif d'une bombe
	ld			(tarif_objet),a
	ld			e,a								; 
	ld			d,0								; on stock dans DE = 20
	ld			hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc			hl,de
	jp			C,routine_efface_event_gauche   ; si le nombre de rubi est negatif alors on efface l'venement	
	ld			a,1								;
	ld			(flag_rubi_bleu86_1),a			; on indique que la flèche est active
	ld			hl,flag_objet_gauche			; on met l'adresse du flag de l'objet droite dans hl
	ld			a,objet_rubi_bleu86_1				
	ld			(hl),a
	ld			de,gain_rubi_bleu86_1			; on recupere le tarif d'une bombe
	ld			hl,(nbr_rubi)
	add			hl,de
	ld			(nbr_rubi),hl	
	call		decompte_des_rubis
	call		affiche_compteur
	call		routine_efface_objet_gauche
	call	link_porte_objet4	
	call		scenario_rubi_bleu_1_boutique_86
	LD			A,(No_PIECE)
	cp			a,2
	jp			z,rubi_bleu_02_gagne
	cp			a,8
	jp			z,rubi_bleu_08_gagne
	cp			a,86
	jp			z,rubi_bleu_86_gagne
	cp			a,116
	jp			z,rubi_bleu_116_gagne
	cp			a,120
	jp			z,rubi_bleu_120_gagne
	
rubi_bleu_02_gagne
	ld		a,1
	ld		(flag_rubi_bleu02_gagne),a
	ret	
rubi_bleu_08_gagne
	ld		a,1
	ld		(flag_rubi_bleu08_gagne),a
	ret	
rubi_bleu_86_gagne
	ld		a,1
	ld		(flag_rubi_bleu86_gagne),a
	ret	
rubi_bleu_116_gagne
	ld		a,1
	ld		(flag_rubi_bleu116_gagne),a
	ret	
rubi_bleu_120_gagne
	ld		a,1
	ld		(flag_rubi_bleu120_gagne),a
	ret	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
calcule_boutique_cleg
	ld		(type_objet),a
	; on verifie que l'on a assez de rubi pour acheter des clés
	ld		a,tarif_cle					; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_gauche   ; si le nombre de rubi est negatif alors on efface l'venement
		
	; on a suffisement de rubi alors on continu
	ld		a,1
	ld		(flag_cle),a
	call	decompte_des_rubis
	ld		a,4
	call	compteur_objet
	call	affiche_compteur
	call	routine_efface_objet_gauche
	call	link_porte_objet4
	ret		; chaque achat de bombe, ajoute 4 bombe sur un mamimum de 8

routine_efface_objet_gauche
	call	asic_on
	xor		a
	LD		(SPRH10_ZOOM),a
	ld		(flag_monstre6),a			; qui correspond au flag zoom du sprite 11
routine_efface_event_gauche
	xor		a
	ld 		(event_objet_gauche),a
	ld 		(event_objet_gauche+1),a
	ld 		(event_objet_gauche+2),a
	ret
