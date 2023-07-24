bombe
	ld		a,(une_bombe_est_en_cours)
	or		a
	Jr		NZ,update_bombe
affiche_bombe
	ld		a,50
	ld		(compteur_bombe_en_cours),a
	LD		a,25						; on recupère le no de Bank objet
	LD		(bankROM),a								; on l'envoie dans une variable générale 
	Call 	rom_on
	LD		hl,BOMBE_SPR
	ld		de,SPRH3_ADR
	LD		bc,#100
	LDIR
	call 	rom_off
	LD		a,9
	LD 		(SPRH3_ZOOM),a
	ld		a,1
	ld		(flag_sprh3),a
	ld		(une_bombe_est_en_cours),a
	jp		retour_bombe	
update_bombe
	LD		a,26						; on recupère le no de Bank objet
	LD		(bankROM),a	
	ld		a,(compteur_bombe_en_cours)
	dec		a
	ld		(compteur_bombe_en_cours),a
	cp		a,48
	jr		z,inc_bombe_phase_1
	cp		a,15
	jr		z,inc_bombe_phase_2
	cp		a,12
	jr		z,inc_bombe_phase_3
	cp		a,9
	jr		z,inc_bombe_phase_4
	cp		a,6
	jp		z,inc_bombe_phase_5
	cp		a,3
	jp		z,inc_bombe_phase_6
inc_bombe_phase_1
	
	JP 		retour_bombe
inc_bombe_phase_2
	;LD 		BC,#BC02:OUT (C),C			; on pousse l'ecran vers la droite pour le recentrer
	;LD 		BC,#BD00+41:OUT (C),C	
	;LD 		BC,#BC07:OUT (C),C			; on decale l'ecran vers le haut 
	;LD 		BC,#BD00+34:OUT (C),C
	
	
	
	CALL	rom_on
	LD		hl,BORNdeAD_ROM_SPR+#200
	LD		de,SPRH3_ADR
	LD		bc,#100
	LDIR
	ld		a,14
	ld		(SPRH3_ZOOM),a
	call	rom_off
	ld 		a,2	 ;Sound effect number (>=1)
    ld 		c,2 ;channel (0-2)
    ld 		b,0 ;Inverted volume (0-16)
	call 	PLY_AKG_PlaySoundEffect
	JP 		retour_bombe
	
inc_bombe_phase_3
	;LD 		BC,#BC02:OUT (C),C			; on pousse l'ecran vers la droite pour le recentrer
	;LD 		BC,#BD00+43:OUT (C),C	
	;LD 		BC,#BC07:OUT (C),C			; on decale l'ecran vers le haut 
	;LD 		BC,#BD00+36:OUT (C),C	
	
	
	
	CALL	rom_on
	LD		hl,BORNdeAD_ROM_SPR+#100
	LD		de,SPRH3_ADR
	LD		bc,#100
	LDIR
	call	rom_off
	
	JP 		retour_bombe
inc_bombe_phase_4
	;LD 		BC,#BC02:OUT (C),C			; on pousse l'ecran vers la droite pour le recentrer
	;LD 		BC,#BD00+41:OUT (C),C	
	;LD 		BC,#BC07:OUT (C),C			; on decale l'ecran vers le haut 
	;LD 		BC,#BD00+34:OUT (C),C
	
	
	CALL	rom_on
	LD		hl,BORNdeAD_ROM_SPR
	LD		de,SPRH3_ADR
	LD		bc,#100
	LDIR
	call	rom_off	
	;ld 		c,2   ;Channel (0-2)
    ;call 	PLY_AKG_StopSoundEffectFromChannel
	
	JP 		retour_bombe
inc_bombe_phase_5
	;LD 		BC,#BC02:OUT (C),C			; on pousse l'ecran vers la droite pour le recentrer
	;LD 		BC,#BD00+40:OUT (C),C	
	;LD 		BC,#BC07:OUT (C),C			; on decale l'ecran vers le haut 
	;LD 		BC,#BD00+33:OUT (C),C	
	
	
	CALL	rom_on
	LD		hl,BORNdeAD_ROM_SPR+#100
	LD		de,SPRH3_ADR
	LD		bc,#100
	LDIR
	call	rom_off
	
	JP 		retour_bombe
inc_bombe_phase_6
	;LD 		BC,#BC02:OUT (C),C			; on pousse l'ecran vers la droite pour le recentrer
	;LD 		BC,#BD00+42:OUT (C),C	
	;LD 		BC,#BC07:OUT (C),C			; on decale l'ecran vers le haut 
	;LD 		BC,#BD00+35:OUT (C),C	
	
	
	CALL	rom_on
	LD		hl,BORNdeAD_ROM_SPR+#200
	LD		de,SPRH3_ADR
	LD		bc,#100
	LDIR
	call	rom_off
	ld 		a,2	 ;Sound effect number (>=1)
	ld 		c,2 ;channel (0-2)
    ld 		b,0 ;Inverted volume (0-16)
    call 	PLY_AKG_PlaySoundEffect
		
	Jr		fin_bombe
fin_bombe
	LD		a,8						; on recupère le no de Bank objet
	LD		(bankROM),a	
	CALL	rom_on_bank_prog
	JP		fin_bombe_ROM
retour_grotte
	call	rom_off
	jp		retour_bombe

test_bombe_dodongo
ld		a,(flag_boss_donjon)					; on test pour voir si on est dans une salle avec un boss dodongo VIVANTS
or		a										; et si y'en a pas
ret 	z										; on retourne lire la suite du code
LD		a,(une_bombe_est_en_cours)				; ... sinon on etterit ici pour savoir si on est en train de lâcher une bombe ou pas
or		a										; et si on est pas en train d'en larguer une ....
RET	Z										; on continu de lire le code et donc de bouger Dodongo
ld		a,1
ld		(flag_stop_monstres),a
call	flag_hyrule_on
call	collision_bombe_dodongo
ret


