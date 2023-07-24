gameover
	ld		a,(flag_gameover_init)
	cp		a,0
	jp		z,init_gameover
	cp		a,1
	jp		z,animation_link_gameover
	cp		a,2
	jp		Z,affiche_screen_gameover
	cp		a,3
	jp		Z,end_gameover
	cp		a,4
	jp		z,Zelda_fini
	cp		a,5
	jp		z,attente_fire_1_ou_2
	
	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////         INIT GAME OVER        ///////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////	
init_gameover
	ld		a,1
	ld		(flag_gameover_init),a
	ld		(etape_gameover),a
	
	ld		a,3
	ld		(compteur_gameover),a
	ld		a,5
	ld		(nbr_tour_complet),a
	ld		a,40
	ld		(attendu_fondue_pallette),a
	call	code_bank2_on
	call	rom_on
	call	asic_on
	CALL	NETTOYAGE_SPRITES_HARD
	call	rom_off
	call	DESACTIVATION_EVENTS
	call	asic_on
	ld		a,29
	ld		(bankROM),a
	call	rom_on
	ld		hl,LINK1_SPR
	ld		de,MEM_TAMPON_SPRH
	ld		bc,#800
	LDIR
	call	rom_off
	ld		a,14
	ld		(SPRH0_ZOOM),a
on_met_tout_a_zero	
	; autre désactivations d'events non présent dans le DESACTIVATION_EVENTS
	ld		a,8
	ld		(bankROM),a
	call	rom_on_bank_prog
	call	on_met_tout_a_zero_ROM
	call	rom_off
	RET


; /////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////         ANIMATION DE LINK        ///////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////	
animation_link_gameover	
	ld		a,8
	ld		(bankROM),a
	call	rom_on_bank_prog
	call	animation_link_gameover_ROM
	call	rom_off
	ret

init_screen_gameover
	ld 		hl,Music         				;Initialisation
	ld		a,3
	call 	PLY_AKG_Init
	ld		a,(flag_zelda_RIP)
	cp		a,1
	jp		z,init_screen_fin
	call	extinction_des_couleurs_Game_Over
	ld		a,10
	ld		(bankROM),a
	call	rom_on
	ld		hl,#c000
	ld		de,#c000
	ld		bc,#4000
	ldir
	call	rom_off
	jp		positionnenment_de_ecran

init_screen_fin
	call	on_met_tout_a_zero
	ld		a,5
	ld		(bankROM),a
	call	rom_on
	call	asic_on
	ld		hl,#c040							; lecture
	ld		de,#6400							; ecriture
	ld		bc,#20								; longueur
	LDIR
	ld		a,11
	ld		(bankROM),a
	call	rom_on
	ld		hl,#c000
	ld		de,#c000
	ld		bc,#4000
	ldir
	call	rom_off
positionnenment_de_ecran
	LD 		BC,#BC01:OUT (C),C			; rognage du bord droit de 16 caracteres (32 octets)
	LD 		BC,#BD00+40:OUT (C),C	
	LD 		BC,#BC02:OUT (C),C			; on pousse l'ecran vers la droite pour le recentrer
	LD 		BC,#BD00+46:OUT (C),C	
	LD 		BC,#BC07:OUT (C),C			; on decale l'ecran vers le haut 
	LD 		BC,#BD00+30:OUT (C),C	
	LD 		BC,#BC06:OUT (C),C			; on agrandit l'ecran vers le bas	
	LD 		BC,#BD00+25:OUT (C),C
	ld		a,2
	ld		(flag_gameover_init),a
	ret
	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////         AFFICHE LES COULEURS     ///////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////	
affiche_screen_gameover
	ld		a,3
	ld		(flag_gameover_init),a
	ld		hl,PALETTE_GAMEOVER
	ld		(type_de_palette),hl
	ld		(type_de_palette2),hl
	ret	
	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////         CONTROLE DES TOUCHES     ///////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////	
end_gameover
	;call	NETTOYAGE_SPRITES_HARD
	ld		a,5
	ld		(bankROM),a
	call	rom_on
	ld		hl,#C060
	ld		de,#4000
	ld		bc,#1000
	LDIR
	ld		hl,#D060							; lecture
	ld		de,#6422							; ecriture
	ld		bc,#1D								; longueur
	LDIR
	call	rom_off
	
	
	call	test_de_touche_on
	call	del_off
	xor		a
	ld 		b,18
	ld		hl,haut_jpz
boucle_efface_direction	
	push 	bc
	ld		(hl),a
	inc		hl
	pop 	bc
	djnz	boucle_efface_direction
	ld		a,5
	ld		(flag_gameover_init),a
	ret	



attente_fire_1_ou_2
	ld		a,8
	ld		(bankROM),a
	call	rom_on
	call	attente_fire_1_ou_2_ROM8
	call	rom_off
	ret

on_continu_le_jeu
	call	pallette_off
	call	c5_on
	call	asic_off
	ld		a,2
	ld		hl,MEM_TAMPON_ETAT_GAMEOVER					; indique si il y a eu un game over
	ld		(hl),a
	LD		hl,FLAG_GAMEOVER
	LD		de,MEM_TAMPON_GAMEOVER
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
	LDI:LDI
	CALL	c0_on
	call	asic_on
	call	NETTOYAGE_SPRITES_HARD2
	jr		on_zap_recommencer_le_jeu
on_recommence_le_jeu
	call	NETTOYAGE_SPRITES_HARD2
	call	pallette_off
	call	c5_on
	xor		a
	ld		hl,MEM_TAMPON_ETAT_GAMEOVER					; indique si il y a eu un game over
	ld		(hl),a
	
	ld		hl,0
	ld		de,MEM_TAMPON_GAMEOVER
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
	LDI:LDI:LDI:LDI
	LDI:LDI
	
	on_zap_recommencer_le_jeu
	
	DI
	LD		BC,#7F00+%10000000:OUT (C),C 		; connexion de la ROM supérieure et de la ROM inférieure et écran en mode 0.
	LD 		BC,#7FC0:OUT (c),c					; on choisit D'ECRIRE  dans la RAM centrale
	JP		REDEMARRAGE_DU_JEU




	