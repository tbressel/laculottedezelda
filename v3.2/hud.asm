AFFICHE_HUD
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	AFFICHE_HUD_ROM
	call	rom_off
	RET

TABLE_HUD_M1
	DB	00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15
	DB	16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
	DB	32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47
	DB	48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63
	DB	64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79

; ***********************************************************************************
; ***********************************************************************************
; ******************************* MISE A ZERO DES COMPTEUR DU HUD ********************
; ***********************************************************************************
; ***********************************************************************************
	
compteur_mise_a_zero
	xor		a	;reinitialise le tableau du compteur d'objet
	ld		b,3			;il y a 3 lignes dans le tableau
	ld		ix,COMPTEUR_OBJET_HUD		; .... son adresse
boucle_compteur
	push	bc
	ld		(ix),a			; 1er octet de la ligne
	ld		(ix+1),a		; 2eme octet de la ligne
	ld		(ix+2),a		; 3eme octet de la ligne
	inc		ix			
	inc		ix
	inc		ix			; on passe a la ligne suivante
	pop 	bc
	djnz 	boucle_compteur
	ld		a,1			; 1 designe le compteur des rubi
	ld		(type_objet),a
	call 	affiche_compteur
	ld		a,4			; 2 designe le compteur des cle
	ld		(type_objet),a
	call 	affiche_compteur
	ld		a,3			; 3 designe le compteur des bombes
	ld		(type_objet),a
	call 	affiche_compteur
	ret

; ***********************************************************************************
; ***********************************************************************************
; ************************ AFFICHAGE DES CHIFFRE DU COMPTEUR  *********************
; ***********************************************************************************
; ***********************************************************************************
affiche_compteur
	call	asic_off
	ld		a,(type_objet)
	cp		1
	jr		z,nbr_rubi_hud
	cp		4
	jr		z,nbr_cle_hud
	cp		3
	jr		z,nbr_bombe_hud
nbr_rubi_hud
	call	C4_on
	LD		DE,TEXTE_NBR_RUBI
	ld		(DEPART_DU_TEXTE),DE
	ld 		hl,compteur_rubi
	ld		b,3
	call	boucle_objet_hud
	ld		a,(type_objet)
	or		a
	jr		z,nbr_cle_hud
	call	c0_on
	ret
nbr_cle_hud
	call	C4_on
	LD		DE,TEXTE_NBR_CLE			; adresse a l'ecran du depart du compteur cle
	ld		(DEPART_DU_TEXTE),DE
	ld 		hl,compteur_cle		; adresse du depart du compteur cle en ram
	ld		b,3					; initialisation du nombre de chiffre a afficher
	call	boucle_objet_hud	; on entre dans la boucle djnz
	ld		a,(type_objet)
	or		a
	jr		z,nbr_bombe_hud
	call	c0_on
	ret
nbr_bombe_hud
	call	C4_on
	LD		DE,TEXTE_NBR_BOMBES
	ld		(DEPART_DU_TEXTE),DE
	ld 		hl,compteur_bombe
	ld		b,3
	call	boucle_objet_hud
	call	C0_on
	ret

	
	
boucle_objet_hud
	push 	bc
	push	hl
	ld		a,(hl)
	ld		l,a
	ld		h,0
	ADD 	HL,HL				; on multiplie par 2	
	ADD 	HL,HL				; on multiplie par 4
	ADD 	HL,HL				; on multiplie par 8
	ADD 	HL,HL				; on multiplie par 16 (la longueur d'une lettre dans la ram)
	ld		bc,FONTE_CHIFFRE
	add		hl,bc				; hl contient l'adresse de depart du chiffre a afficher
	push 	de
	call	affiche_colonnes2
	pop		de
	inc		e
	inc 	e
	pop 	hl
	inc		hl
	pop 	bc
	djnz	boucle_objet_hud
	ret



; ***********************************************************************************
; ***********************************************************************************
; ************************ COMPTEUR D'objet  *********************
; ***********************************************************************************
; ***********************************************************************************

compteur_objet
	ld		a,(type_objet)
	or		a
	ret		z
	cp		a,1							; objet 1 correspond à un rubi jaune
	jr		z,ajout_nbr_rubi_jaune
	cp		a,2
	jp		z,ajout_nbr_coeur
	cp		a,3							; objet 1 correspond à un rubi jaune
	jr		z,ajout_nbr_bombe
	cp		a,4						; objet 1 correspond à un rubi jaune
	jr		z,ajout_nbr_cle
	cp		a,5						; objet 1 correspond à un rubi jaune
	jp		z,stop_les_ennemis
	cp		a,6					; objet 1 correspond à un rubi jaune
	jp		z,rend_invincible_et_gros
	cp		a,7
	jp		z,champi_rouge_vitesse
	cp		a,8
	jp		z,champi_vert_vitesse

	cp		a,10
	jp		z,champi_pourrit_vitesse
	cp		a,11							; objet 1 correspond à un rubi jaune
	jr		z,ajout_nbr_rubi_bleu
	cp		12
	jp		z,ajout_nbr_rubi_noir
	cp		13
	jp		z,ajout_nbr_rubi_vert
	cp		a,objet_porte_donjon_3
	jp		z,efface_porte_donjon_3
	ret			
ajout_nbr_rubi_bleu
	LD		a,2
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	rubi_bleu_rom
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	RET
								; on ajoute 1 rubis
	
ajout_nbr_rubi_jaune
	ld		de,(nbr_rubi)					; on récupère de le nombre de rubis en stock
	inc		de								; on ajoute 1 rubis
	ld		(nbr_rubi),de					; et on le stock
	ld		hl,255							; on vérifie que le nombre ne dépasse pas 255 rubis
	sbc		hl,de							; 255-256=flag C       255-255 ou inférieur on continu
	jp		c,nombre_de_rubi_max			; on va aller bloquer le nombre de rubis à 255 si çà dépasse et si le flag C est mis.
	ld		hl,compteur_rubi				; on prends l'adresse du compteur de rubis
	ld		(selection_compteur),hl			; et on le stock pour désigner quel compteur sera à modifier dans le hud
	call	calcul_compteur_objet			; et on appelle le compteur d'objet.
	ret
ajout_nbr_cle
	ld		a,(nbr_cle)
	cp		maximum_de_cle
	RET		Z
	inc		a
	ld		(nbr_cle),a
	ld		hl,compteur_cle
	ld		(selection_compteur),hl
	call	calcul_compteur_objet
	ret
ajout_nbr_bombe
	ld		hl,(nbr_bombe)
	ld		a,l
	cp		a,maximum_de_bombe
	ret		z
	inc		hl
	ld		(nbr_bombe),hl
	ld		hl,compteur_bombe
	ld		(selection_compteur),hl
	call	calcul_compteur_objet
	ld		a,1
	ld		(flag_bombe),a
	ret	
ajout_nbr_coeur
	or		a
	ld		a,(nbr_vies)
	ld		e,a
	ld		d,0
	ld		a,(nbr_vies_max)
	ld		l,a
	ld		h,0
	SBC		HL,DE
	ret		z
	ld		a,(nbr_vies)
	inc		a
	ld		(nbr_vies),a
	ret	
stop_les_ennemis
	ld		a,1
	ld		(flag_stop_monstres),a
	RET
rend_invincible_et_gros
	ld		a,1
	ld		(flag_viande),a
	RET
champi_rouge_vitesse
	call	champi_rouge
	ret
champi_vert_vitesse
	call	champi_vert
	ret
champi_pourrit_vitesse
	call	champi_pourrit
	ret

efface_porte_donjon_3
	ld		a,1
	ld		(flag_porte_donjon_3),a
	ld		(flag_cle_donjon),a
	call	asic_off
	call	c6_on
	LD		HL,#58AA		
	ld		a,072						; je choisit la tile 072 (porte fermé que l'on peut franchir)
	ld		(HL),a						
	call	c6_off
	call	asic_on
	call	link_porte_objet3
	ret
	
ajout_nbr_rubi_noir
xor	a
ld	(flag_fleche_illimite),a
	LD		a,2
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	rubi_noir_rom
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	RET
	
ajout_nbr_rubi_vert
	ld		a,1
	ld		(flag_rubi_vert),a
	ld	(flag_fleche_illimite),a
	RET

	
	
calcul_compteur_objet
	ld		hl,(selection_compteur)
	inc		hl:inc hl
	ld		a,(hl)					; on récupère le chiffre des unitées
	cp		a,9						; s'il est égale à 9
	jp		z,incremente_chiffre_dizaines	;alors on incrémente les dizaines .... et ....
	inc		a
	ld		(hl),a
	call	affiche_compteur
	ret
incremente_chiffre_dizaines
	xor		a						; ... et .... on remet les unitée a 0
	ld		(hl),a					; on écrit 
	ld		hl,(selection_compteur)
	inc		hl						; puis on recupere le chiffre des dizaines
	ld		a,(hl)					; 
	cp		a,9						; s'il est aussi égal 9
	jr		z,incremente_chiffre_centaines		; alors on incrémente les centaines ... et ...
	inc		a						; on l'incremente
	ld		(hl),a					; on l'écrit
	call	affiche_compteur
	ret
incremente_chiffre_centaines
	xor		a					; et  ... on remet les dizaines a 0
	ld		(hl),a					; on l'écrit
	ld		hl,(selection_compteur)		; on recupere le chiffre des centaines
	ld		a,(hl)					; 
	cp		a,9						; s'il est égale à 9 on arrete 
	call	z,incremente_que_dalle	
	inc		a						; on l'incremente
	ld		(hl),a					; on l'écrit
	call	affiche_compteur
	ret
incremente_que_dalle
	ld		(hl),a
	call	affiche_compteur
	ret
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
calcul_decompteur_objet	
	ld		hl,(selection_compteur)
	inc		hl:inc hl
	ld		a,(hl)					; on récupère le chiffre des unitées
	cp		a,0						; s'il est égale à 0
	jr		z,decremente_chiffre_dizaines	;alors on incrémente les dizaines .... et ....
	dec		a
	ld		(hl),a
	call	affiche_compteur
	ret
decremente_chiffre_dizaines
	ld		a,9						; ... et .... on remet les unitée a 9
	ld		(hl),a					; on écrit 
	ld		hl,(selection_compteur)
	inc		hl						; puis on recupere le chiffre des dizaines
	ld		a,(hl)					; 
	cp		a,0						; s'il est aussi égal 0
	jr		z,decremente_chiffre_centaines		; alors on incrémente les centaines ... et ...
	dec		a						; on l'incremente
	ld		(hl),a					; on l'écrit
	call	affiche_compteur
	ret
decremente_chiffre_centaines
	ld		a,9						; et  ... on remet les dizaines a 9
	ld		(hl),a					; on l'écrit
	ld		hl,(selection_compteur)		; on recupere le chiffre des centaines
	ld		a,(hl)					; 
	cp		a,0						; s'il est égale à 0 on arrete 
	jr		z,decremente_que_dalle	
	dec		a						; on l'incremente
	ld		(hl),a					; on l'écrit
	call	affiche_compteur
	ret
decremente_que_dalle
	ld		(hl),a
	call	affiche_compteur
	ret
nombre_de_rubi_max
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
affiche_colonnes2
	ld		de,(DEPART_DU_TEXTE)
	push 	de
	CALL 	colonne2
	POP 	DE
	INC 	DE
	PUSH 	DE
	CALL 	colonne2
	POP 	DE
	INC 	DE
	ld		(DEPART_DU_TEXTE),DE
	RET
colonne2
	LD 		B,8		 ; les lettres font 16 lignes sur une longueur BC
boucle_colonne2
	PUSH 	BC		 ; ... pour mettre ca dans la pile (registre 16 bits obligatoir)
	LD 		BC,#01	 ; largeur d'une lettre de 4 octets (mode 1, 16 pxl font 4 octets)
	PUSH 	DE		 ; on sauve DE avant que le LDIR le modifie ...
	LDIR		 ; il incremente HL et DE (HL = #4A01   DE = C001 BC = 00)
	POP 	DE		 ; on recupere notre DE de la pile
	CALL 	LIGNEINF_c000	 ; ligne inferieur
	POP 	BC		 ; nouvelle ligne calcule, on recupere notre compteur ...
	DJNZ 	boucle_colonne2
	RET	
	
	
	
