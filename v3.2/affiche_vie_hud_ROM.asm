affiche_vies_ROM
	ld		a,(flag_ajoute_vie)		; on test si on ajoute une vie ou pas
	or		a						; à 1 on ajoute, si à zero alors on enleve
	jp		nz,ajoute_vie_hud
	or		a
	jp		z,enleve_vie_hud
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////     ON ENLEVE UNE VIE        /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
enleve_vie_hud
	ld		a,(flag_vie_parite)			; si le flag est à 1 alors on est sur 	
	or		a						; une vie impaire, donc un demis coeur
	jp		nz,calcule_vie_impaire		
	or		a
	jp		z,calcule_vie_paire

; /////////////////////////////////////////////////////////////////////////////////////////////////
calcule_vie_impaire
	ld		a,(nbr_vies)				; j'arrive ici avec une vie en moins 
	ld		hl,Table_adresse_ecran		; on cible la table des adresse ecran
	ld		b,a							; j'utilise les vies comme compteur, pour pointer au bon endroit de la table
boucle_vie_calcule
	push	bc	
	inc		hl	
	pop		bc
	djnz	boucle_vie_calcule
	ld		(pointeur_table_vie),hl			; l'adresse du depart de ma 6eme vie est dans hl
	ld		a,(hl)							; on lit l'octet conteneu à l'adress hl de la table
	ld		d,a								; on l'envoie dans D
	dec		hl							
	ld		a,(hl)							; on lit l'octet conteneu à l'adress hl de la table
	ld		e,a								; on l'envoie dans E
	ld		(adr_ecran_affiche_coeur),de	; on stock
	ld		hl,Table_adresse_coeurs
	inc		hl:inc hl
	ld		a,(hl)							; on lit l'octet conteneu à l'adress hl de la table
	ld		e,a								; on l'envoie dans D
	inc		hl							
	ld		a,(hl)							; on lit l'octet conteneu à l'adress hl de la table
	ld		d,a								; on l'envoie dans E
	ld		(adr_memoire_coeur),de	; on stock
	ex		hl,de	
	call	affichage_du_coeur
	xor		a								; au prochain compte ou décompte, le nombre de
	ld		(flag_vie_parite),a				; vie sera formecement paire
	ret
; /////////////////////////////////////////////////////////////////////////////////////////////////
calcule_vie_paire	
	ld		a,(nbr_vies)				; j'arrive ici avec une vie en moins 
	cp		a,0
	jp		z,saut
	ld		hl,Table_adresse_ecran		; on cible la table des adresse ecran
	ld		b,a							; j'utilise les vies comme compteur, pour pointer au bon endroit de la table
boucle_vie_calcule2
	push	bc	
	inc		hl	
	pop		bc
	djnz	boucle_vie_calcule2
	ld		(pointeur_table_vie),hl			; l'adresse du depart de ma 6eme vie est dans hl
	ld		a,(hl)							; on lit l'octet conteneu à l'adress hl de la table
	ld		e,a								; on l'envoie dans D
	inc		hl							
	ld		a,(hl)							; on lit l'octet conteneu à l'adress hl de la table
	ld		d,a								; on l'envoie dans E
	ld		(adr_ecran_affiche_coeur),de	; on stock
	ld		hl,Table_adresse_coeurs
	inc		hl:inc hl:inc hl:inc hl
	ld		a,(hl)							; on lit l'octet conteneu à l'adress hl de la table
	ld		e,a								; on l'envoie dans D
	inc		hl							
	ld		a,(hl)							; on lit l'octet conteneu à l'adress hl de la table
	ld		d,a								; on l'envoie dans E
	ex		de,hl
	ld		(adr_memoire_coeur),hl
	call	affichage_du_coeur
	ld		a,1
	ld		(flag_vie_parite),a
	ret
saut
	ld		hl,Table_adresse_ecran		; on cible la table des adresse ecran
	ld		a,1
	jp		boucle_vie_calcule2
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////     ON AJOUTE UNE VIE        /////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////

ajoute_vie_hud
	jp		test_vie_maximum
retour_test_de_vie_maximum
	ld		a,(flag_vie_parite)			; si le flag est à 1 alors on est sur 	
	or		a							; une vie impaire, donc un demis coeur
	jp		nz,calcule_vie_impaire2		
	or		a
	jp		z,calcule_vie_paire2
; /////////////////////////////////////////////////////////////////////////////////////////////////
calcule_vie_paire2	
	ld		a,(nbr_vies)				; j'arrive ici avec une vie en moins 
	ld		hl,Table_adresse_ecran		; on cible la table des adresse ecran
	ld		b,a							; j'utilise les vies comme compteur, pour pointer au bon endroit de la table
boucle_vie_calcule22
	push	bc	
	inc		hl	
	pop		bc
	djnz	boucle_vie_calcule22
	dec		hl								; on décrémente hl pour revenir au bon endroit							
	ld		(pointeur_table_vie),hl			; l'adresse du depart de ma 6eme vie est dans hl
	ld		a,(hl)							; on lit l'octet conteneu à l'adress hl de la table
	ld		d,a								; on l'envoie dans D
	dec		hl							
	ld		a,(hl)							; on lit l'octet conteneu à l'adress hl de la table
	ld		e,a								; on l'envoie dans E
	ld		(adr_ecran_affiche_coeur),de	; on stock
	ld		hl,Table_adresse_coeurs
	ld		a,(hl)							; on lit l'octet conteneu à l'adress hl de la table
	ld		e,a								; on l'envoie dans D
	inc		hl							
	ld		a,(hl)							; on lit l'octet conteneu à l'adress hl de la table
	ld		d,a								; on l'envoie dans E
	ex		de,hl
	ld		(adr_memoire_coeur),hl
	call	affichage_du_coeur
	ld		a,1
	ld		(flag_vie_parite),a
	xor		a
	ld		(flag_ajoute_vie),a
	ret	
calcule_vie_impaire2
	ld		a,(nbr_vies)				; j'arrive ici avec une vie en moins 
	ld		hl,Table_adresse_ecran		; on cible la table des adresse ecran
	ld		b,a							; j'utilise les vies comme compteur, pour pointer au bon endroit de la table
boucle_vie_calcule222
	push	bc	
	inc		hl	
	pop		bc
	djnz	boucle_vie_calcule222
	dec		hl								; on décrémente hl pour revenir au bon endroit							
	ld		(pointeur_table_vie),hl			; l'adresse du depart de ma 6eme vie est dans hl
	ld		a,(hl)							; on lit l'octet conteneu à l'adress hl de la table
	ld		e,a								; on l'envoie dans D
	inc		hl							
	ld		a,(hl)							; on lit l'octet conteneu à l'adress hl de la table
	ld		d,a								; on l'envoie dans E
	ld		(adr_ecran_affiche_coeur),de	; on stock
	ld		hl,Table_adresse_coeurs
	inc		hl:inc	hl
	ld		a,(hl)							; on lit l'octet conteneu à l'adress hl de la table
	ld		e,a								; on l'envoie dans D
	inc		hl							
	ld		a,(hl)							; on lit l'octet conteneu à l'adress hl de la table
	ld		d,a								; on l'envoie dans E
	ex		de,hl
	ld		(adr_memoire_coeur),hl
	call	affichage_du_coeur
	xor		a
	ld		(flag_vie_parite),a
	ld		(flag_ajoute_vie),a
	ret	
	

test_vie_maximum
	or		a
	ld		a,(nbr_vies)
	ld		e,a
	ld		d,0
	ld		a,(nbr_vies_max)
	ld		l,a
	ld		h,0
	SBC		HL,DE
	jp		z,on_est_au_maximum
	jp		retour_test_de_vie_maximum
on_est_au_maximum
	xor		a
	ld		(flag_ajoute_vie),a
	ld		(flag_vie_parite),a
	jp		retour_test_de_vie_maximum

affichage_du_coeur
	call	asic_off
	call	c4_on
	ld		de,(adr_ecran_affiche_coeur)
	ld		hl,(adr_memoire_coeur)
	ld		b,8
boucle_affiche_coeur
	PUSH 	BC
	LD 		BC,4
	PUSH 	DE
	LDIR
	POP 	DE
	CALL 	LIGNEINF_c000
	POP 	BC
	djnz boucle_affiche_coeur
	call	c4_off
	call	asic_on
	ret


Table_adresse_ecran						; adresse de destination à l'écran
DW		#C0ED,#C0F1,#C0F5,#C0F9
DW		#C12D,#c131,#c135,#c139
DW		#C16D,#C171,#C175,#C179


Table_adresse_coeurs
DW		COEUR_ROUGE_HUD,DEMIS_COEUR_HUD,COEUR_BLANC_HUD

