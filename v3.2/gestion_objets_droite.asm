objet_droite_on
ld		a,#CD
ld		(event_objet_droite),a
ld		hl,affiche_objet_droite
ld		(event_objet_droite+1),hl
ret


EFFACE_OBJET_DROITE
	ld		a,(type_objet_droite)		; on récupère le no d'identification de l'objet à droite en provenance d'une boutique 
	cp		a,objet_fleche				; OBJET 1
	jp		z,efface_fleche				; si c'est bien l'objet flache on l'efface
	
	cp		a,objet_bougie
	jp		z,efface_bougie
	
	cp		a,objet_fiole_rouge
	jp		z,efface_fiole_rouge
	
	cp		a,objet_rubi_bleu_3
	jp		z,efface_rubi_bleu_3
	
	cp		a,objet_rubi_bleu86_3
	jp		z,efface_rubi_bleu86_3
	
	cp		a,objet_viande
	jp		z,efface_boutique_viande
	
	cp		a,objet_pang
	jp		z,efface_pang


	ret
	
		; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////


efface_pang
; on verifie que l'on a assez de rubi pour acheter un bouclier
	ld		a,tarif_pang					; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_droite   ; si le nombre de rubi est negatif alors on efface l'venement
; on a ssuffisement de rubi alors on continu
; on verifie que l'on a un arc
	ld		a,1							;
	ld		(flag_pang),a				; on indique que la flèche est active
	ld		(flag_game),a
	ld		a,objet_pang				
	ld		de,SPRH_PANG_ADR
	
	ld		hl,flag_objet_droite		; on met l'adresse du flag de l'objet droite dans hl
	ld		(hl),a
	ld		(SPRH_JEU_ADR),de
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_droite
	call	link_porte_objet3
	ret	
	
			; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////

efface_fleche
; on verifie que l'on a assez de rubi pour acheter des fleches
	ld		a,tarif_fleche					; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_droite   ; si le nombre de rubi est negatif alors on efface l'venement
; on a ssuffisement de rubi alors on continu
; on verifie que l'on a un arc
	ld		a,(flag_arc)
	or		a
	RET		Z								; si on a pas d'arc on ne peut pas acheter de flêche
								
	ld		a,1							;
	ld		(flag_fleche),a				; on indique que la flèche est active
	ld		(flag_arc_et_fleche),a
	ld		hl,flag_objet_droite		; on met l'adresse du flag de l'objet droite dans hl
	ld		a,objet_fleche				
	ld		(hl),a
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_droite
	call	link_porte_objet3
	ret	
	
efface_bougie
; on verifie que l'on a assez de rubi pour acheter des fleches
	ld		a,tarif_bougie					; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_droite   ; si le nombre de rubi est negatif alors on efface l'venement
; on a ssuffisement de rubi alors on continu
	ld		a,1							;
	ld		(flag_bougie),a				; on indique que la flèche est active
	ld		hl,flag_objet_droite		; on met l'adresse du flag de l'objet droite dans hl
	ld		a,objet_bougie				
	ld		(hl),a
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_droite
	call	link_porte_objet3
	ret		
	
efface_fiole_rouge
	ld		a,(NO_PIECE)
	cp		a,7
	jp		z,fiole_rouge_gratuite_07
	cp		a,61
	jp		z,fiole_rouge_gratuite_61
	cp		a,73
	jp		z,fiole_rouge_gratuite_73
	cp		a,91
	jp		z,fiole_rouge_gratuite_91
	cp		a,225
	jp		z,fiole_rouge_chez_link

	; on verifie que l'on a assez de rubi pour acheter un bouclier
	ld		a,tarif_fiole_rouge		; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_droite   ; si le nombre de rubi est negatif alors on efface l'venement	
	ld		a,1								;
	ld		(flag_fiole_rouge),a			; on indique que la flèche est active
	xor		a
	ld		(flag_parchemin),a
	ld		(flag_fiole_bleu),a
	ld		hl,flag_objet_droite			; on met l'adresse du flag de l'objet droite dans hl
	ld		a,objet_fiole_rouge				
	ld		(hl),a
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_droite
	call	link_porte_objet3
	ret	
fiole_rouge_chez_link
ld		a,1								;
	ld		(flag_fiole_rouge),a			; on indique que la flèche est active
	xor		a
	ld		(flag_parchemin),a
	ld		(flag_fiole_bleu),a
	ld		hl,flag_objet_droite			; on met l'adresse du flag de l'objet droite dans hl
	ld		a,objet_fiole_rouge				
	ld		(hl),a
	call	routine_efface_objet_droite
	ret

fiole_rouge_gratuite_07
ld		a,1
ld		(flag_fiole_rouge_gratuite_07),a
jp		fiole_rouge_gratuite_suite
fiole_rouge_gratuite_61
ld		a,1
ld		(flag_fiole_rouge_gratuite_61),a
jp		fiole_rouge_gratuite_suite
fiole_rouge_gratuite_73	
ld		a,1
ld		(flag_fiole_rouge_gratuite_73),a
jp		fiole_rouge_gratuite_suite
fiole_rouge_gratuite_91
ld		a,1
ld		(flag_fiole_rouge_gratuite_91),a
jp		fiole_rouge_gratuite_suite

fiole_rouge_gratuite_suite
	ld		a,1								;
	ld		(flag_fiole_rouge),a			; on indique que la flèche est active
	ld		(flag_fiole_rouge_gratuite),a
	xor		a
	ld		(flag_parchemin),a
	ld		(flag_fiole_bleu),a
	ld		hl,flag_objet_droite			; on met l'adresse du flag de l'objet droite dans hl
	ld		a,objet_fiole_rouge				
	ld		(hl),a
	call	routine_efface_objet_droite
	call	routine_efface_objet_gauche
	call	link_porte_objet3
	ret
efface_rubi_bleu_3
	; on verifie que l'on a assez de rubi pour acheter un bouclier
	ld		a,tarif_rubi_bleu_3			; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_droite   ; si le nombre de rubi est negatif alors on efface l'venement	
	ld		a,1								;
	ld		(flag_rubi_bleu_3),a			; on indique que la flèche est active
	ld		hl,flag_objet_droite			; on met l'adresse du flag de l'objet droite dans hl
	ld		a,objet_rubi_bleu_3				
	ld		(hl),a
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_droite
	call	link_porte_objet3
	call	scenario_rubi_bleu_3_boutique_36
	ret	
efface_rubi_bleu86_3
	; on verifie que l'on a assez de rubi pour acheter un bouclier
	ld		a,tarif_rubi_bleu86_3			; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_droite   ; si le nombre de rubi est negatif alors on efface l'venement	
	ld		a,1								;
	ld		(flag_rubi_bleu86_3),a			; on indique que la flèche est active
	ld		hl,flag_objet_droite			; on met l'adresse du flag de l'objet droite dans hl
	ld		a,objet_rubi_bleu86_3				
	ld		(hl),a
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_droite
	call	link_porte_objet3
	call	scenario_rubi_bleu_3_boutique_86
	ret	
efface_boutique_viande
	ld		(type_objet),a
	; on verifie que l'on a assez de rubi pour acheter des clés
	ld		a,tarif_viande				; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_droite   ; si le nombre de rubi est negatif alors on efface l'venement
		
	; on a suffisement de rubi alors on continu
	ld		a,1
	ld		(flag_viande),a
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_droite
	call	link_porte_objet3
	ret		; chaque achat de bombe, ajoute 4 bombe sur un mamimum de 8

routine_efface_objet_droite	
	call	asic_on
	xor		a
	LD		(SPRH12_ZOOM),a
	ld		(flag_monstre_zora),a			; qui correspond au flag zoom du sprite 11
routine_efface_event_droite
	xor		a
	ld 		(event_objet_droite),a
	ld 		(event_objet_droite+1),a
	ld 		(event_objet_droite+2),a
	ret
