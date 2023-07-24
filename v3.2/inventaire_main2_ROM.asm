inventaire_sauvegarde
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
	xor a
	ld	(flag_flammes),a
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////// SAUVEGARDE DU CONTENU DES SPRITES HARD /////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
	call  	c4_off
	call 	asic_on
	ld		hl,#4000
	ld		de,MEM_TAMPON_SPRH		; prevoir maxi #1000 octet
	ld		bc,#1000
	LDIR
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////// SAUVEGARDE DES FLAGS ZOOM DES SPRITES HARDS ////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
	ld		hl,FLAGS_ZOOM
	ld		de,MEM_TAMPON_FLAGS_ZOOM
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////// SAUVEGARDE DES COORDONNEES DES SPRITES HARD ////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////	
	ld		hl,#6000
	ld		de,MEM_TAMPON_COORDONNEES_SPRH
	ld		b,16
boucle_mem_tampon
	push 	bc
	LDI
	LDI	
	LDI
	LDI
	inc		l
	inc		l
	inc		l
	inc		l
	pop		bc
	djnz	boucle_mem_tampon
	
; /////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////// ON EFFACE TOUT  //////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
EFFACE_SPRITES_HARD_ZOOM
	ld		hl,SPRH0_ZOOM
	xor		a 
	ld		b,16
ZOOM_OFF_0a15_inv
	push	bc
	ld		(hl),a
	ld		a,l
	add		a,#08
	ld		l,a
	pop		bc
	djnz	ZOOM_OFF_0a15_inv
	ret
	
	
; /////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////// AFFICHAGE DES GFX  ///////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
AFFICHE_INVENTAIRE_HYRULE
	call	asic_off
	call	C4_on
	ld		A,(No_BANK)
	PUSH	AF
	ld		A,#c0
	ld		(No_BANK),A
	LD		HL,INVENTAIRE_MAPTILE
	LD		DE,INVENTAIRE_OFFSET_ECRAN		;point de depart d'affichage sur l'ecran
	LD    	A,INVENTAIRE_HAUTEUR_TILES		;11 lignes de tiles
	call	affiche_ecran
	pop		AF
	or 		A
	ld		(No_BANK),A
	call	C4_off
	ret


; le fichier deco.bin  doit faire #1CC0 de longueur.

	
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////// RECUPERE DU CONTENU DES SPRITES HARD /////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
inventaire_sortie

	ld		hl,MEM_TAMPON_SPRH
	ld		de,#4000		; prevoir maxi #1000 octet
	ld		bc,#1000
	LDIR
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////// RECUPERATION DES COORDONNEES DES SPRITES HARD ////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////	
	ld		de,#6000
	ld		hl,MEM_TAMPON_COORDONNEES_SPRH
	ld		b,16
boucle_mem_tampon2
	push 	bc
	LDI
	LDI	
	LDI
	LDI
	inc		e
	inc		e
	inc		e
	inc		e
	pop		bc
	djnz	boucle_mem_tampon2	
	ret
	
inventaire_sortie2
	call asic_on
	
	call	EFFACE_SPRITES_HARD_ZOOM
	
; //////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////// RESTITUTION DES ZOOM DES SPRITES HARDS ////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////
	ld		de,MEM_TAMPON_FLAGS_ZOOM
	ld		hl,#6004
	ld		b,16
boucle_recup_zoom
	push	bc
	ld		a,(de)
	or		a
	call	nz,zoom_on
	ld		bc,#08
	add		hl,bc
	inc		de
	xor		a
	or		a
	pop		bc
	djnz	boucle_recup_zoom

zoom_on
ld	a,9
ld	(hl),a
ret	


test_inventaire
ld 		hl,INVENTAIRE_CURSEUR_Y
ld 		(SPRH1_Y),hl
ld 		(SPRH2_Y),hl
ld 		(SPRH3_Y),hl
ld 		(SPRH4_Y),hl
ld 		hl,INVENTAIRE_CURSEUR_Y+22
ld 		(SPRH5_Y),hl
ld 		(SPRH6_Y),hl
ld 		(SPRH7_Y),hl
ld 		(SPRH8_Y),hl
ld 		hl,INVENTAIRE_CURSEUR_X
ld 		(SPRH1_X),hl
ld 		(SPRH5_X),hl
ld 		hl,INVENTAIRE_CURSEUR_X+50
ld 		(SPRH2_X),hl
ld 		(SPRH6_X),hl
ld 		hl,INVENTAIRE_CURSEUR_X+100
ld 		(SPRH3_X),hl
ld 		(SPRH7_X),hl
ld 		hl,INVENTAIRE_CURSEUR_X+150
ld 		(SPRH4_X),hl
ld 		(SPRH8_X),hl

ld 		hl,INVENTAIRE_CURSEUR_Y+22+25
ld 		(SPRH9_Y),hl
ld 		(SPRH10_Y),hl
ld 		(SPRH11_Y),hl
ld 		(SPRH12_Y),hl
ld 		(SPRH13_Y),hl
ld 		(SPRH14_Y),hl
ld		hl,207
ld 		(SPRH9_X),hl
ld		hl,INVENTAIRE_CURSEUR_X+30
ld 		(SPRH10_X),hl
ld		hl,INVENTAIRE_CURSEUR_X+65
ld 		(SPRH11_X),hl
ld		hl,INVENTAIRE_CURSEUR_X+100
ld 		(SPRH12_X),hl
ld		hl,INVENTAIRE_CURSEUR_X+140
ld 		(SPRH13_X),hl
ld		hl,INVENTAIRE_CURSEUR_X+170
ld 		(SPRH14_X),hl

ld		hl,444
ld		(SPRH15_X),hl
ld		hl,160
ld		(SPRH15_Y),hl

ld		hl,444
ld		(SPRH15_X),hl
ld		hl,160
ld		(SPRH15_Y),hl

xor		a
ld		(SPRH15_ZOOM),a
;ld		(flag_sprh15),a
ret


invent_fire2_ROM
ld	a,(selection_curseur)
cp	1			; si on appuye sur fire avec l'objet 4 (parchemin)
jp	z,selection_objet_1	; alors on selectionne et affiche et valide l'objet 4
cp	2			; si on appuye sur fire avec l'objet 4 (parchemin)
jp	z,selection_objet_2	; alors on selectionne et affiche et valide l'objet 4
cp	3			; si on appuye sur fire avec l'objet 4 (parchemin)
jp	z,selection_objet_3	; alors on selectionne et affiche et valide l'objet 4
cp	4			; si on appuye sur fire avec l'objet 4 (parchemin)
jp	z,selection_objet_4	; alors on selectionne et affiche et valide l'objet 4
cp	5			; si on appuye sur fire avec l'objet 4 (parchemin)
jp	z,selection_objet_5	; alors on selectionne et affiche et valide l'objet 4
cp	6			; si on appuye sur fire avec l'objet 4 (parchemin)
jp	z,selection_objet_6	; alors on selectionne et affiche et valide l'objet 4
cp	7			; si on appuye sur fire avec l'objet 4 (parchemin)
jp	z,selection_objet_7	; alors on selectionne et affiche et valide l'objet 4
cp	8			; si on appuye sur fire avec l'objet 4 (parchemin)
jp	z,selection_objet_8	; alors on selectionne et affiche et valide l'objet 4
jp	boucle_inventaire_retour

selection_objet_1
	ld		a,(flag_rien)
	or		a
	jp		z,boucle_inventaire
	xor		a
	ld		(objet_hud_fire2),a
	call	affiche_rien_hud
	
	jp		boucle_inventaire_retour

selection_objet_2
	ld		a,(flag_bombe)
	or		a
	jp		z,boucle_inventaire
	ld		a,1
	ld		(objet_hud_fire2),a
	call	affiche_bombe_hud
	jp		boucle_inventaire_retour

selection_objet_3
	ld		a,(flag_arc_et_fleche)
	or		a
	jp		z,test_selection_objet_32
	ld		a,2
	ld		(objet_hud_fire2),a
	call	affiche_fleche_hud
	jp		boucle_inventaire_retour
test_selection_objet_32
	ld		a,(flag_arc)
	or		a
	jp		z,boucle_inventaire
	jp		boucle_inventaire_retour

selection_objet_4
	ld		a,(flag_bougie)
	or		a
	jp		z,boucle_inventaire
	ld		a,3
	ld		(objet_hud_fire2),a
	call	affiche_bougie_hud
	jp		boucle_inventaire_retour

selection_objet_5
	ld		a,(flag_flute)
	or		a
	jp		z,boucle_inventaire
	ld		a,10
	ld		(objet_hud_fire2),a
	call	affiche_flute_hud
	
	jp		boucle_inventaire_retour

selection_objet_6
ld	a,(flag_viande)
or		a
jp	z,boucle_inventaire
ld	a,6
ld	(objet_hud_fire2),a
call	affiche_viande_hud
jp	boucle_inventaire_retour

SELECTION_OBJET_7
	ld		a,(flag_parchemin)
	or		a
	jp		z,test_selection_objet_72
	ld		a,7
	ld		(objet_hud_fire2),a
	call	affiche_parchemin_hud
	jp		boucle_inventaire_retour
test_selection_objet_72
	ld		a,(flag_fiole_bleu)
	or		a
	jp		z,test_selection_objet_73
	ld		a,8
	ld		(objet_hud_fire2),a
	call	affiche_fiole_bleu_hud
	jp		boucle_inventaire_retour
test_selection_objet_73
	ld		a,(flag_fiole_rouge)
	or		a
	jp		z,boucle_inventaire
	ld		a,9
	ld		(objet_hud_fire2),a
	call	affiche_fiole_rouge_hud
	jp		boucle_inventaire_retour

selection_objet_8
;ld	a,(flag_parchemin)
;cp	0
;jp	z,boucle_inventaire
;ld	a,8
;ld	(objet_hud_fire2),a
;call	affiche_parchemin_hud

jp	boucle_inventaire_retour


affiche_rien_hud_ROM
	call	c4_on				; on choisit D'ECRIRE  dans la RAM C4
	ld		hl,RIEN_SPR_HUD
	ld		(sprite_a_lire),hl
	call	parametre_sprite_HUD_F2
	ret


affiche_flute_hud_ROM
	call	c4_on				; on choisit D'ECRIRE  dans la RAM C4
	ld		hl,FLUTE_SPR_HUD
	ld		(sprite_a_lire),hl
	call	parametre_sprite_HUD_F2
	ret

affiche_bombe_hud_ROM
	call	c4_on				; on choisit D'ECRIRE  dans la RAM C4
	ld		hl,BOMBE_SPR_HUD
	ld		(sprite_a_lire),hl
	call	parametre_sprite_HUD_F2
	ret
affiche_fleche_hud_ROM
	call	c4_on					; on choisit D'ECRIRE  dans la RAM C4
	ld		hl,FLECHE_SPR_HUD
	ld		(sprite_a_lire),hl
	call	parametre_sprite_HUD_F2
	ret
affiche_bougie_hud_ROM
	call	c4_on					; on choisit D'ECRIRE  dans la RAM C4
	ld		hl,BOUGIE_SPR_HUD
	ld		(sprite_a_lire),hl
	call	parametre_sprite_HUD_F2
	ret	
affiche_parchemin_hud_ROM
	call	c4_on					; on choisit D'ECRIRE  dans la RAM C4
	ld		hl,PARCHEMIN_SPR_HUD
	ld		(sprite_a_lire),hl
	call	parametre_sprite_HUD_F2
	ret	
affiche_fiole_bleu_hud_ROM
	call	c4_on					; on choisit D'ECRIRE  dans la RAM C4
	ld		hl,FIOLE_BLEU_SPR_HUD
	ld		(sprite_a_lire),hl
	call	parametre_sprite_HUD_F2
	ret	
affiche_fiole_rouge_hud_ROM
	call	c4_on					; on choisit D'ECRIRE  dans la RAM C4
	ld		hl,FIOLE_ROUGE_SPR_HUD
	ld		(sprite_a_lire),hl
	call	parametre_sprite_HUD_F2
	ret	
affiche_epee_01_hud_ROM
	call	c4_on					; on choisit D'ECRIRE  dans la RAM C4
	ld		hl,EPEE_EN_BOIS_HUD
	ld		(sprite_a_lire),hl
	call	parametre_sprite_HUD_F1
	ret	
affiche_epee_02_hud_ROM
	call	c4_on					; on choisit D'ECRIRE  dans la RAM C4
	ld		hl,EPEE_EN_ACIER_HUD
	ld		(sprite_a_lire),hl
	call	parametre_sprite_HUD_F1
	ret
affiche_epee_03_hud_ROM
	call	c4_on					; on choisit D'ECRIRE  dans la RAM C4
	ld		hl,EPEE_MASTER_SWORD_HUD
	ld		(sprite_a_lire),hl
	call	parametre_sprite_HUD_F1
	ret	
affiche_viande_hud_ROM
	call	c4_on					; on choisit D'ECRIRE  dans la RAM C4
	ld		hl,VIANDE_HUD
	ld		(sprite_a_lire),hl
	call	parametre_sprite_HUD_F2
	ret	


parametre_sprite_HUD_F1
	ld		de,HUD_F1_SPR
	ld		(emplacement),de
	ld		a,16
	ld		(hauteur_de_sprite),a
	ld		bc,#0004
	ld		(longueur_de_sprite),bc
ret


parametre_sprite_HUD_F2
	ld		de,HUD_F2_SPR
	ld		(emplacement),de
	ld		a,16
	ld		(hauteur_de_sprite),a
	ld		bc,#0004
	ld		(longueur_de_sprite),bc
ret




; *****************************************************************************************************************
; ********************************************* ROUTINE BETE D'AFFICHAGE DE SPRITE DANS LE HUD ********************
; *****************************************************************************************************************

affichage_de_sprite_hud
	LD 		HL,(sprite_a_lire)	; on met SPRH0_ADR dans HL (emplacement du sprite)
	LD 		DE,(emplacement)	; on met #C000 dans DE (la ou on va afficher le sprite)
	LD 		a,(hauteur_de_sprite)
	ld 		b,a
BOUCLE_SPRITE_HUD
	PUSH 	BC
	LD 		BC,(longueur_de_sprite)
	PUSH 	DE
	LDIR
	POP 	DE
	CALL 	LIGNEINF_c000
	POP 	BC
	DJNZ 	BOUCLE_SPRITE_HUD
	call	rom_on
	RET
