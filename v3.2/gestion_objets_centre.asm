objet_centre_on
	ld		a,#CD
	ld		(event_objet_centre),a
	ld		hl,affiche_objet_centre
	ld		(event_objet_centre+1),hl
	ret


EFFACE_OBJET_CENTRE
	ld		a,(type_objet_centre)		; on récupère le type d'objé saisié dans une boutique de provenance
	cp		a,epee_en_bois				; OBJET 10
	jp		z,efface_epee_01
	cp		a,objet_coeur				; OBJET 2
	jp		z,efface_coeur
	cp		a,epee_en_acier				; OBJET 16
	jp		z,efface_epee_02
	cp		a,epee_master_sword				; OBJET 16
	jp		z,efface_epee_03
	cp		a,objet_bombe				; objet 3 si ce sont des bombes
	jp		z,calcule_boutique_bombe
	cp		a,objet_cle					; objet 4 si ce sont des bombes
	jp		z,calcule_boutique_cle
	cp		a,objet_parchemin			; OBJET 7
	jp		z,efface_parchemin
	cp		a,objet_rubi_vert
	jp		z,efface_rubi_vert
	cp		a,objet_baton
	jp		z,efface_baton
	cp		a,objet_rubi_bleu_2
	jp		z,efface_rubi_bleu_2
	cp		a,objet_rubi_bleu86_2
	jp		z,efface_rubi_bleu86_2
	cp		a,objet_bague				
	jp		z,calcule_boutique_bague
	cp		a,objet_bague_rouge				
	jp		z,calcule_boutique_bague_rouge
	cp		a,objet_rubi_bleu26
	jp		z,efface_rubi_bleu26
	cp		a,objet_cle_donjon			; objet 5
	jp		z,calcule_cle_donjon
	cp		a,objet_boussole			; objet 6
	jp		z,efface_boussole
	cp		a,objet_carte			; objet 9
	jp		z,efface_carte
	cp		a,objet_arc			; objet 28
	jp		z,efface_arc
	cp		a,objet_receptacle_coeur			; OBJET 8
	jp		z,efface_receptacle_coeur_donjon
	cp		a,objet_radeau		; OBJET 8
	jp		z,efface_radeau
	cp		a,objet_echelle		; OBJET 8
	jp		z,efface_echelle	
	cp		a,objet_porte_donjon_1
	jp		z,efface_porte_donjon_1
	cp		a,objet_porte_donjon_2
	jp		z,efface_porte_donjon_2
	
	cp		a,objet_trifoce_donjon_1
	jp		z,ajoute_trifoce_donjon_1
	cp		a,objet_trifoce_donjon_2
	jp		z,ajoute_trifoce_donjon_2
	cp		a,objet_trifoce_donjon_3
	jp		z,ajoute_trifoce_donjon_3
	cp		a,objet_trifoce_donjon_4
	jp		z,ajoute_trifoce_donjon_4
	
	cp		a,objet_teleportation
	jp		z,on_se_teleporte
	ret
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

on_se_teleporte
	call	asic_off
	call	c0_on
	call	on_se_teleporte_CO
	call	asic_on
	call	routine_efface_objet_centre
	ret

	

calcule_cle_donjon
	ld		a,4
	ld		(type_objet),a
	ld		a,(nbr_cle)						; je recupère le nombre de cle actuelle
	cp		maximum_de_cle					; si j'en ai déjà 8 je suis au maximum possible
	jr		z,nbr_cle_max_atteint			; donc on met tout à 8

; mais si on est genre à 3 clé
	ld		a,(nbr_cle)						; je recupère le nombre de clée actuelle
	ld		b,1
	add		a,b								; j'ai 4 clée
	ld		(nbr_cle),a						; et on met 4 en la variable
	ld		hl,compteur_cle+2		
	ld		(hl),a
	call	affiche_compteur
	call	routine_efface_objet_centre
	ret		
nbr_cle_max_atteint
	ld		a,maximum_de_cle
	ld		(nbr_cle),a
	ld		hl,compteur_cle+2
	ld		(hl),a
	call	affiche_compteur
	call	routine_efface_objet_centre
	call	link_porte_objet
	ret


	
	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////

efface_receptacle_coeur_donjon
	ld		hl,(flag_objet_centre)			; on met l'adresse du flag de l'objet droite dans hl
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
boucle_ajout_receptacle_donjon
	push	bc
	call	affichage_du_coeur
	inc		ix:inc ix
	ld		e,(ix)
	ld		d,(ix+1)
	ld		(adr_ecran_affiche_coeur),de
	pop		bc
	djnz	boucle_ajout_receptacle_donjon
	ld		a,1
	ld		(flag_vie_parite),a
	call	routine_efface_objet_centre
	call	link_porte_objet
	ret	
	
	
	
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
efface_epee_01
	ld		a,1
	ld		(flag_epee_01),a
	ld		a,(type_objet_centre)		; si l'objet au centre est le no 10 donc l'épée en bois
	ld		(objet_hud_fire1),a			; alors on suave son numéo d'idientification pour le hud du fire 1
	ld		hl,flag_objet_centre		; on met l'adresse du flag de l'objet centre dans hl
	ld		a,epee_en_bois				; et l'identrifiant de l'objet epée en bois
	ld		(hl),a						; et on l'écrit 
	ld		de,puissance_epee_en_bois
	ld		(puissance_epee),de
	call	affiche_epee_01_hud	
	call	routine_efface_objet_centre
	call	link_porte_objet
	ret
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

efface_baton
	ld		a,(flag_triforce_3)
	or		a
	ret		Z
	ld		a,1
	ld		(flag_baton),a
	call	routine_efface_objet_centre
	call	link_porte_objet
	call	efface_porte_donjon_4	
	ret
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
efface_porte_donjon_1
	ld		a,1
	ld		(flag_porte_donjon_1),a
	ld		(flag_cle_donjon),a
	call	routine_efface_objet_centre
	xor 	a
	LD		(event_objet_hyrule_centre),a
	LD		(event_objet_hyrule_centre+1),a
	LD		(event_objet_hyrule_centre+2),a
	call	asic_off
	call	c6_on
	LD		HL,#786D		
	ld		a,072						; je choisit la tile 072 (porte fermé que l'on peut franchir)
	ld		(HL),a						
	call	c6_off
	call	asic_on
	call	link_porte_objet
	ret
efface_porte_donjon_2
	ld		a,1
	ld		(flag_porte_donjon_2),a
	ld		(flag_cle_donjon),a
	call	routine_efface_objet_centre
	xor 	a
	LD		(event_objet_hyrule_centre),a
	LD		(event_objet_hyrule_centre+1),a
	LD		(event_objet_hyrule_centre+2),a
	call	asic_off
	call	c6_on
	LD		HL,#6f55		
	ld		a,072						; je choisit la tile 072 (porte fermé que l'on peut franchir)
	ld		(HL),a						
	call	c6_off
	call	asic_on
	call	link_porte_objet
	ret
efface_porte_donjon_4
	ld		a,1
	ld		(flag_porte_donjon_4),a
	ld		(flag_cle_donjon),a
	xor 	a
	LD		(event_objet_hyrule_centre),a
	LD		(event_objet_hyrule_centre+1),a
	LD		(event_objet_hyrule_centre+2),a
	call	asic_off
	call	c7_on
	LD		HL,#5043		
	ld		a,072						; je choisit la tile 072 (porte fermé que l'on peut franchir)
	ld		(HL),a
	inc		hl
	ld		(HL),a
	call	c7_off
	call	asic_on
	ret
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ajoute_trifoce_donjon_1
	ld		a,1
	ld		(flag_triforce_1),a
	call	ajoute_triforce_1_inventaire
	call	routine_efface_objet_centre
	call 	link_porte_objet2
	ret
ajoute_trifoce_donjon_2
	ld		a,1
	ld		(flag_triforce_2),a
	call	ajoute_triforce_2_inventaire
	call	routine_efface_objet_centre
	call 	link_porte_objet2
	ret	
ajoute_trifoce_donjon_3
	ld		a,1
	ld		(flag_triforce_3),a
	call	ajoute_triforce_3_inventaire
	call	routine_efface_objet_centre
	call 	link_porte_objet2
	ret	
ajoute_trifoce_donjon_4
	ld		a,1
	ld		(flag_triforce_4),a
	call	ajoute_triforce_4_inventaire
	call	routine_efface_objet_centre
	call 	link_porte_objet2
	ret	
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
efface_epee_02
	ld		hl,0
	LD		a,(nbr_vies_max)			; on recupère le nombre de vies maxi
	ld		l,a
	ld		de,epee_en_acier_niveau		; b sera le minimum acceptable pour obtenir l'épée mais pour avoir le flag C il faut un nombre negatif
	sbc	hl,de						; donc on prendra 9.  8-9= negatif
	jp		C,routine_efface_event_centre   ; si le nombre de vie est negatif alors on efface l'venement
	ld		a,1
	ld		(flag_epee_02),a
	ld		de,puissance_epee_acier
	ld		(puissance_epee),de
	ld		a,(type_objet_centre)		; si l'objet au centre est le no 10 donc l'épée en bois
	ld		(objet_hud_fire1),a			; alors on suave son numéo d'idientification pour le hud du fire 1
	ld		hl,flag_objet_centre		; on met l'adresse du flag de l'objet centre dans hl
	ld		a,epee_en_acier				; et l'identrifiant de l'objet epée en bois
	ld		(hl),a						; et on l'écrit 
	ld		hl,Table_type_arme+16
	ld		de,Table_type_arme
	ld		bc,8
	LDIR
	call	routine_efface_objet_centre
	call	affiche_epee_02_hud
	call	link_porte_objet
	ret
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
efface_epee_03
	ld		hl,0
	LD		a,(nbr_vies_max)			; on recupère le nombre de vies maxi
	ld		l,a
	ld		de,epee_master_sword_niveau		; b sera le minimum acceptable pour obtenir l'épée mais pour avoir le flag C il faut un nombre negatif
	sbc	hl,de						; donc on prendra 9.  8-9= negatif
	jp		C,routine_efface_event_centre   ; si le nombre de vie est negatif alors on efface l'venement
	ld		a,1
	ld		(flag_epee_03),a
	ld		de,puissance_master_sword
	ld		(puissance_epee),de
	ld		a,(type_objet_centre)		; si l'objet au centre est le no 10 donc l'épée en bois
	ld		(objet_hud_fire1),a			; alors on suave son numéo d'idientification pour le hud du fire 1
	ld		hl,flag_objet_centre		; on met l'adresse du flag de l'objet centre dans hl
	ld		a,epee_master_sword				; et l'identrifiant de l'objet epée en bois
	ld		(hl),a						; et on l'écrit 
	ld		hl,Table_type_arme+24
	ld		de,Table_type_arme
	ld		bc,8
	LDIR
	call	routine_efface_objet_centre
	call	affiche_epee_03_hud
	call	link_porte_objet
	ret
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
efface_parchemin
	ld		a,1
	ld		(flag_parchemin),a
	ld		hl,flag_objet_centre		; on met l'adresse du flag de l'objet centre dans hl
	ld		a,objet_parchemin				; et l'identrifiant de l'objet epée en bois
	ld		(hl),a						; et on l'écrit 
	call	routine_efface_objet_centre
	call	link_porte_objet	
	ret
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

efface_boussole
	ld		a,(flag_no_donjon)
	cp		a,1
	jp		z,boussole_donjon_1_on
	cp		a,2
	jp		z,boussole_donjon_2_on
	cp		a,3
	jp		z,boussole_donjon_3_on
	cp		a,4
	jp		z,boussole_donjon_4_on
boussole_donjon_1_on
	ld		a,1
	ld		(flag_boussole_donjon_1),a
	call	affiche_boussole
	call	routine_efface_objet_centre
	call	link_porte_objet
	ret
boussole_donjon_2_on
	ld		a,1
	ld		(flag_boussole_donjon_2),a
	call	affiche_boussole
	call	routine_efface_objet_centre
	call	link_porte_objet
	ret
boussole_donjon_3_on
	ld		a,1
	ld		(flag_boussole_donjon_3),a
	call	affiche_boussole
	call	routine_efface_objet_centre
	call	link_porte_objet
	ret
boussole_donjon_4_on
	ld		a,1
	ld		(flag_boussole_donjon_4),a
	call	affiche_boussole
	call	routine_efface_objet_centre
	call	link_porte_objet
	ret

test_affiche_boussole
	ld		a,(flag_no_donjon)
	cp		a,1
	jp		z,test_boussole_1
	cp		a,2
	jp		z,test_boussole_2
	cp		a,3
	jp		z,test_boussole_3
	cp		a,4
	jp		z,test_boussole_4
	ret
test_boussole_1
	ld		a,(flag_boussole_donjon_1)
	cp		a,1
	jp		z,affiche_boussole
	ret
test_boussole_2
	ld		a,(flag_boussole_donjon_2)
	cp		a,1
	jp		z,affiche_boussole
	ret
test_boussole_3
	ld		a,(flag_boussole_donjon_3)
	cp		a,1
	jp		z,affiche_boussole
	ret
test_boussole_4
	ld		a,(flag_boussole_donjon_4)
	cp		a,1
	jp		z,affiche_boussole
	ret

	
affiche_boussole
	ld		hl,(boussole_de_ce_donjon_adr)
	ld		a,PIXEL_JAUNE		
	ld		(hl),a									; on efface le pixel contenu a l'adresse hl
	ld		d,#08
	ld		a,h				
	add		a,d
	ld		h,a	
	ld		a,PIXEL_JAUNE
	ld		(hl),a
	ret
	
	
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

efface_carte
	ld		a,(flag_no_donjon)
	cp		a,1
	jp		z,map_donjon_1_on
	cp		a,2
	jp		z,map_donjon_2_on
	cp		a,3
	jp		z,map_donjon_3_on
	cp		a,4
	jp		z,map_donjon_4_on

map_donjon_1_on
	ld		a,1
	ld		(flag_carte_donjon1),a
	ld		(flag_ok_affiche_carte),a
	ld		(flag_carte_de_ce_donjon),a
	ld		hl,MAP_DONJON_1
	ld		(map_a_lire),hl
	ld		a,PIXEL_BLEU
	ld		(couleur_fond_gps),a
	ld		(couleur_fond2_gps),a
	call	routine_efface_objet_centre
	call	link_porte_objet
	CALL 	on_affiche_la_putain_de_carte
	ret
map_donjon_2_on
	ld		a,1
	ld		(flag_carte_donjon2),a
	ld		(flag_ok_affiche_carte),a
	ld		(flag_carte_de_ce_donjon),a
	ld		hl,MAP_DONJON_2
	ld		(map_a_lire),hl
	ld		a,PIXEL_BLEU
	ld		(couleur_fond_gps),a
	ld		(couleur_fond2_gps),a
	call	routine_efface_objet_centre
	call	link_porte_objet
	CALL 	on_affiche_la_putain_de_carte
	ret
map_donjon_3_on
	ld		a,1
	ld		(flag_carte_donjon3),a
	ld		(flag_ok_affiche_carte),a
	ld		(flag_carte_de_ce_donjon),a
	ld		hl,MAP_DONJON_3
	ld		(map_a_lire),hl
	ld		a,PIXEL_BLEU
	ld		(couleur_fond_gps),a
	ld		(couleur_fond2_gps),a
	call	routine_efface_objet_centre
	call	link_porte_objet
	CALL 	on_affiche_la_putain_de_carte
	ret
map_donjon_4_on
	ld		a,1
	ld		(flag_carte_donjon4),a
	ld		(flag_ok_affiche_carte),a
	ld		(flag_carte_de_ce_donjon),a
	ld		hl,MAP_DONJON_4
	ld		(map_a_lire),hl
	ld		a,PIXEL_BLEU
	ld		(couleur_fond_gps),a
	ld		(couleur_fond2_gps),a
	call	routine_efface_objet_centre
	call	link_porte_objet
	CALL 	on_affiche_la_putain_de_carte
	ret

; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

efface_arc
	ld		a,1
	ld		(flag_arc),a
	ld		a,(flag_fleche)
	or		a
	jr		nz,arc_suite
	call	routine_efface_objet_centre
	call	link_porte_objet
	ret
arc_suite
	ld		a,1
	ld		(flag_arc_et_fleche),a
	call	routine_efface_objet_centre
	call	link_porte_objet
	ret
	
	
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
efface_radeau
	ld		a,1
	ld		(flag_radeau),a
	ld		(on_peut_utiliser_le_radeau),a
		call	routine_efface_objet_centre
		call	link_porte_objet

ret

; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
efface_echelle
	ld		a,1
	ld		(flag_echelle),a
	call	routine_efface_objet_centre
	call	link_porte_objet

ret



; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
calcule_boutique_bombe
	ld		(type_objet),a
	; on verifie que l'on a assez de rubi pour acheter des bombes
	ld		a,tarif_bombe					; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_centre   ; si le nombre de rubi est negatif alors on efface l'venement
		
	; on a ssuffisement de rubi alors on continu
	ld		a,1
	ld		(flag_bombe),a
	ld		hl,(nbr_bombe)					; je recupère le nombre de bombes actuelle
	ld		a,l								; je met dans a
	cp		maximum_de_bombe								; si j'en ai déjà 8 je suis au maximum possible
	jp		z,nbr_bombe_max_atteint			; donc on met tout à 8
	
	; on est pas aumaximum donc on continue
	ld		hl,(nbr_bombe)					; je recupère le nombre de bombes actuelle
	ld		b,l								; mais si j'en ai genre, 5. je met 5 dans b
	ld		a,4								; j'en ajoute 4 à la fois
	add		a,b								; çà me fait 9
	ld		e,a								; je met #0005 dans DE
	ld		d,0
	ld		hl,maximum_de_bombe							; je met #08 (nbr de bombe max) dans hl
	SBC		hl,de							; si 9-8   donc negatif et donc flag C
	jp		C,nbr_bombe_max_atteint			; alors on est au maximum
	
											; mais si on est à 3 bombe
	ld		hl,(nbr_bombe)					; je recupère le nombre de bombes actuelle
	ld		a,l								; je met 3 dans a
	ld		b,4
	add		a,b								; j'ai genre 7 bombe
	ld		(nbr_bombe),a
	ld		hl,compteur_bombe+2
	ld		(hl),a
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_centre
	call	link_porte_objet
	ret		; chaque achat de bombe, ajoute 4 bombe sur un mamimum de 8
nbr_bombe_max_atteint
	ld		a,maximum_de_bombe
	ld		(nbr_bombe),a
	ld		hl,compteur_bombe+2
	ld		(hl),a
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_centre
	call	link_porte_objet
	ret
	
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

calcule_boutique_cle
	ld		(type_objet),a
	; on verifie que l'on a assez de rubi pour acheter des clés
	ld		a,tarif_cle					; on recupere le tarif d'une cle
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_centre   ; si le nombre de rubi est negatif alors on efface l'venement
		
	; on a suffisement de rubi alors on continu
	ld		a,1
	ld		(flag_cle),a
	call	decompte_des_rubis
	ld		a,4
	call	compteur_objet
	call	affiche_compteur
	call	routine_efface_objet_centre
	call	link_porte_objet
	ret		; chaque achat de bombe, ajoute 4 bombe sur un mamimum de 8
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

efface_rubi_bleu_2
	; on verifie que l'on a assez de rubi pour acheter un bouclier
	ld		a,tarif_rubi_bleu_2			; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_centre   ; si le nombre de rubi est negatif alors on efface l'venement	
	ld		a,1								;
	ld		(flag_rubi_bleu_2),a			; on indique que la flèche est active
	ld		hl,flag_objet_centre			; on met l'adresse du flag de l'objet droite dans hl
	ld		a,objet_rubi_bleu_2				
	ld		(hl),a
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_centre
	call	link_porte_objet
	call	scenario_rubi_bleu_2_boutique_36
	ret
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

efface_rubi_bleu86_2
	; on verifie que l'on a assez de rubi pour acheter un bouclier
	ld		a,tarif_rubi_bleu86_2			; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_centre   ; si le nombre de rubi est negatif alors on efface l'venement	
	ld		a,1								;
	ld		(flag_rubi_bleu86_2),a			; on indique que la flèche est active
	ld		hl,flag_objet_centre			; on met l'adresse du flag de l'objet droite dans hl
	ld		a,objet_rubi_bleu86_2				
	ld		(hl),a
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_centre
	call	link_porte_objet
	call	scenario_rubi_bleu_2_boutique_86
	ret
	
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

calcule_boutique_bague
	ld		(type_objet),a
	; on verifie que l'on a assez de rubi pour acheter des clés
	ld		a,tarif_bague				; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_centre   ; si le nombre de rubi est negatif alors on efface l'venement
		
	; on a suffisement de rubi alors on continu
	ld		a,1
	ld		(flag_bague),a
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_centre
	call	link_porte_objet
on_ouvre_le_passage_invisible
	call	asic_off
	call	c7_on
	LD		HL,#40DB		
	ld		a,roche_marron_passage						; je choisit la tile 001
	ld		(HL),a						; et  l'écrit à l'adresse
	LD		HL,#40EB		
	ld		a,roche_marron_passage						; je choisit la tile 001
	ld		(HL),a						; et  l'écrit à l'adresse
on_ouvre_les_passages_de_teleportation
	call	asic_off
	call	c6_on
	LD		HL,#4363		
	ld		a,2						; je choisit la tile 001
	ld		(HL),a
	call	c7_on	
	LD		HL,#5102		
	ld		a,11									; je choisit la tile 001
	ld		(HL),a	
	call	c7_off
	call	asic_on
	ret

calcule_boutique_bague_rouge
	ld		a,1
	ld		(flag_bague2),a
	call	routine_efface_objet_centre
	call	link_porte_objet
	call	asic_off
	call	c6_on
	LD		HL,#5dE7		
	ld		a,075						; je choisit la tile 016
	ld		(HL),a						; et  l'écrit à l'adresse
	LD		HL,#5df7		
	ld		a,075						; je choisit la tile 016
	ld		(HL),a						; et  l'écrit à l'adresse
	LD		HL,#5e07		
	ld		a,074						; je choisit la tile 016
	ld		(HL),a						; et  l'écrit à l'adresse
	call	c6_off
	call	asic_on
	ret

; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

efface_rubi_bleu26
	ld		hl,(flag_objet_centre)			; on met l'adresse du flag de l'objet droite dans hl
	ld		a,1				
	ld		(hl),a
; on verifie qu'on dépasse pas 255
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	ld		de,(gain_rubi_bleu26)				; et le gain de rubi
	add		hl,de							; on les additionnes
	ld		(nbr_rubi),hl					; on les auvegarde
	ex		hl,de							
	ld		hl,255							; mais il faut vérifier qu'on dépasse pas 255
	sbc		hl,de							; le nbr de 254-nbr de rubi doit être positif
	jp		C,on_est_au_maximum_de_rubis   ; si le nombre de rubi est negatif alors on efface l'venement	
	ex		hl,de
	ld		(nbr_rubi),hl
	ld		a,l
	call	print_decimal_byte
	call	affiche_compteur
	call	routine_efface_objet_centre
	call	link_porte_objet
	ret
	
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
efface_rubi_vert
; on verifie qu'on dépasse pas 255
	ld		hl,255							; on les additionnes
	ld		(nbr_rubi),hl					; on les auvegarde
	ld		hl,compteur_rubi
	ld		a,2
	ld		(hl),a
	ld		hl,compteur_rubi+1
	ld		a,5
	ld		(hl),a
	ld		hl,compteur_rubi+2
	ld		(hl),a
	call	affiche_compteur
	call	routine_efface_objet_centre
	call	link_porte_objet
	RET
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

efface_coeur
	ld		(type_objet),a
	; on verifie que l'on a assez de rubi pour acheter un coeur
	ld		a,tarif_coeur					; on recupere le tarif d'une bombe
	ld		(tarif_objet),a
	ld		e,a								; 
	ld		d,0								; on stock dans DE = 20
	ld		hl,(nbr_rubi)					; on recupere le nbr de rubi en stock
	sbc		hl,de
	jp		C,routine_efface_event_centre   ; si le nombre de rubi est negatif alors on efface l'venement
		
	; on a ssuffisement de rubi alors on continu
	ld		a,1
	ld		(flag_coeur),a
	ld		a,(nbr_vies)
	ld		b,a
	ld		a,(nbr_vies_max)
	sbc		a,b
	cp		a,0
	jp		z,on_zappe_la_vie_en_plus
	ld		a,(nbr_vies)
	inc		a
	ld		(nbr_vies),a
	ld		a,1
	ld		(flag_ajoute_vie),a
	call	affiche_vies
	
on_zappe_la_vie_en_plus
	call	decompte_des_rubis
	call	affiche_compteur
	call	routine_efface_objet_centre
	call	link_porte_objet
	ret		; chaque achat de bombe, ajoute 4 bombe sur un mamimum de 8


;////////////////////////////////////////////////////////////////////////////////////////////////
on_est_au_maximum_de_rubis
	ld		hl,255
	ld		(nbr_rubi),hl
	ld		a,l
	call	print_decimal_byte
	call	affiche_compteur
	call	routine_efface_objet_centre
	ret
	
; ///////////////////////////////////////////////////////////////////////////////////////////////////////

routine_efface_objet_centre
	call	asic_on
	xor		a
	LD		(SPRH11_ZOOM),a
	ld		(flag_monstre7),a			; qui correspond au flag zoom du sprite 11
routine_efface_event_centre
	xor		a
	ld 		(event_objet_centre),a
	ld 		(event_objet_centre+1),a
	ld 		(event_objet_centre+2),a
	
	ld		a,2
	ld		(etape_objet_spawn_donjon),a
	ret
	
	
; ///////////////////////////////////////////////////////////////////////////////////////////////////////

decompte_des_rubis
	ld		a,(flag_boutique)			; suite à un bug où les rubis étaient décomptés pendant 
	or		a							; un déplacement aléatoir dans la map, je place ce flag ici
	ret		z							; la routine sera renvoyé si on est pas dans une boutique
	ld		hl,(nbr_rubi)
	ld		a,(tarif_objet)
	ld		d,0							
	ld		e,a							; je met a dans d
	SBC		HL,DE						; le resultat en hexa est dans HL
	ld		(nbr_rubi),hl
	ld		a,l
; ***********************************************************************************************************
; ***********************************************************************************************************

print_decimal_byte
	LD		E,3
	ld 		b,100                   ;divisor to obtain 100's digit value
	call 	print_decimal_digit   ;display digit
	push	af
	ld		l,c
	ld		h,0
	ld		(chiffre_des_centaines),hl
	ld		a,l
	ld		(compteur_rubi),a
	pop		af
	ld 		b,10                    ;divisor to obtain 10's digit value
	call 	print_decimal_digit   ;display digit
	push	af
	ld		l,c
	ld		h,0
	ld		(chiffre_des_dizaine),hl
	ld		a,l
	ld		(compteur_rubi+1),a
	pop		af
	ld 		b,1                     ;divisor to obtain 1's digit value
print_decimal_digit
	ld 		c,0                     ;zeroise result 
decimal_divide 
	sub 	b                      ;subtract divisor
	jr 		c,display_decimal_digit ;if dividend is less than divisor, the division
 	inc 	c                      ;increment digit value
	jr 		decimal_divide
display_decimal_digit 
	add 	a,b                   ;add divisor because dividend was negative,
	push 	af
	ld 		a,c                    ;get digit value
	dec		e
	ld		a,e
	cp		a,0
	jp		z,finducalc
	pop 	af
	ret
finducalc
	pop		af
	ld		l,c
	ld		h,0
	ld		(chiffre_des_unitees),hl
	ld		a,l
	ld		(compteur_rubi+2),a
	

; ***********************************************************************************************************
; ***********************************************************************************************************

retour_fin_decompte	
	ld		a,(type_objet)
	push	af
	ld		a,1
	ld		(type_objet),a
	call	affiche_compteur
	pop		af
	ld		(type_objet),a	
	ret
	
ajoute_triforce_1_inventaire

	ld		hl,INVENTAIRE_MAPTILE+18
	ld		a,17
	ld		(hl),a
	inc		a
	inc		l 
	ld		(hl),a
	ret
ajoute_triforce_2_inventaire
	ld		hl,INVENTAIRE_MAPTILE+33
	ld		a,35
	ld		(hl),a
	inc		a
	inc		l 
	ld		(hl),a
	inc		a
	inc		l 
	ld		(hl),a
	inc		a
	inc		l 
	ld		(hl),a
	ret
ajoute_triforce_3_inventaire
	ld		hl,INVENTAIRE_MAPTILE+48
	ld		a,28
	ld		(hl),a
	inc		a
	inc		l 
	ld		(hl),a
		inc		a
	inc		l 
	ld		(hl),a
	ret
ajoute_triforce_4_inventaire
	ld		hl,INVENTAIRE_MAPTILE+51
	ld		a,31
	ld		(hl),a
	inc		a
	inc		l 
	ld		(hl),a
		inc		a
	inc		l 
	ld		(hl),a
	ret

rubi_noir_rom
	ld		hl,(nbr_rubi)					; on récupère de le nombre de rubis en stock
	ld		de,-50							; on en enleve 50
	add		hl,de							
	jr		z,on_affiche_la_sentance		; resultat est de zero pile
	jr		nc,nike_tous_les_rubis			; resultat negatif
	ex		de,hl
	jr		on_affiche_la_sentance
nike_tous_les_rubis
	ld		hl,0
	ld		(nbr_rubi),hl
	ex		de,hl
	jr		on_affiche_la_sentance
	
rubi_bleu_rom
	ld		de,(nbr_rubi)					; on récupère de le nombre de rubis en stock
	ld		hl,nbr_rubi_bleu_rammasse
	add		hl,de
	ex		hl,de
	ld		(nbr_rubi),de					; et on le stock
	ld		hl,255							; on vérifie que le nombre ne dépasse pas 255 rubis
	sbc		hl,de							; 255-256=flag C       255-255 ou inférieur on continu
	jp		c,nombre_de_rubi_max_rom			; on va aller bloquer le nombre de rubis à 255 si çà dépasse et si le flag C est mis.
on_affiche_la_sentance
	ld		(nbr_rubi),de
	ld		de,(nbr_rubi)
	ld		a,e
	call	print_decimal_byte
	call	affiche_compteur
	ret

nombre_de_rubi_max_rom
	ld		hl,255
	ld		(nbr_rubi),hl
	ld		a,2
	ld		(compteur_rubi),a
	ld		a,5
	ld		(compteur_rubi+1),a
	ld		(compteur_rubi+2),a
	ld		hl,compteur_rubi
	ld		(selection_compteur),hl
	call	affiche_compteur
	ret
	
	
