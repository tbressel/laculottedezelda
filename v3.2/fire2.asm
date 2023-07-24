fire2
	ld		a,(flag_gameover_init)
	cp		5
	jp		z,on_recommence_le_jeu
	LD		a,(flag_fire2)							; on test le flag_fire1
	or		a										; pour vérifier si link n'fleche pas déjà
	JP 		nz,retour_fire2							; si l'fleche est en cours, on initialise rien
													; si a=0 on initialise l'fleche
	ld		a,(objet_hud_fire2)							; on identifie l'objet no X qui est dans le hud fire2
	cp		1
	jr		z,init_fire2_bombe
	cp		2
	jr		z,init_fire2_fleche
	cp		3
	jr		z,init_fire2_feu
	CP		6
	Jp		Z,init_fire2_viande
	CP		7
	Jr		Z,init_fire2_parchemin
	cp		8
	jr		z,init_fire2_fiole_bleu	
	cp		9
	jr		z,init_fire2_fiole_rouge	
	cp		10
	jr		z,init_fire2_flute
	cp		0
	jp		z,retour_test_de_touches
						
init_fire2_fleche
	ld		a,(nbr_rubi)						; si y'a plus de rubi alors y'a plus de flèches
	cp		a,0
	JP		z,retour_fire2						; on est venant en JP .... on repart en JP
une_fleche_en_moins
	dec		a									; s'il reste des rubi on en enleve 1
	ld		(nbr_rubi),a						; et on sauvegarde le nouveau stock de rubis
	ld		a,2
	ld		(BankROM),a	
	call	rom_on_bank_prog
	call	fire2_init_fleche_ROM
	call	rom_off
	jp		retour_test_de_touches

; ************************************************************************
; ************************************************************************
; ************************************************************************
; ************************************************************************
; ************************************************************************
	
init_fire2_bombe
	call	code_bank2_on
	call	rom_on
	jp		fire2_init_bombe_ROM

	
	
	; *****************************************************************************
	; *****************************************************************************
	; *****************************************************************************
	; *****************************************************************************
	
init_fire2_feu
	ld		a,2
	ld		(BankROM),a	
	call	rom_on_bank_prog
	CALL	fire2_init_feu_ROM
	call	rom_off
	jp		retour_test_de_touches

	; *****************************************************************************
	; *****************************************************************************
	; *****************************************************************************
	; *****************************************************************************
	
init_fire2_parchemin
	call	code_bank2_on
	call	rom_on
	jp		fire2_init_parchemin_ROM

	

	; *****************************************************************************
	; *****************************************************************************
	; *****************************************************************************
	; *****************************************************************************
	
init_fire2_fiole_bleu
	call	code_bank2_on
	call	rom_on
	jp		fire2_init_fiole_bleu_ROM


; *****************************************************************************
	; *****************************************************************************
	; *****************************************************************************
	; *****************************************************************************

init_fire2_fiole_rouge
	call	code_bank2_on
	call	rom_on
	jp		fire2_init_fiole_rouge_ROM
	
; *****************************************************************************
	; *****************************************************************************
	; *****************************************************************************
	; *****************************************************************************

init_petite_fee
	call	code_bank2_on
	call	rom_on
	call	init_petite_fee_ROM
	call	rom_off
	call 	code_bankx_off
	RET
; *****************************************************************************
	; *****************************************************************************
	; *****************************************************************************
	; *****************************************************************************
init_fire2_flute

	call	link_joue_de_la_flute
	ld		a,8							; sélèction de la banque contenant
	ld		(BankROM),a						; les tiles des différents donjons
	call	rom_on_bank_prog
	call	init_fire2_flute_ROM
	call	rom_off
	call	clavier_off
	JP		retour_fire2

; *****************************************************************************
; *****************************************************************************
; *****************************************************************************
; *****************************************************************************

init_fire2_viande
	ld		a,8							; sélèction de la banque contenant
	ld		(BankROM),a						; les tiles des différents donjons
	call	rom_on_bank_prog
	call	fire2_init_viande_ROM
	call	rom_off
	JP		retour_fire2




	
	