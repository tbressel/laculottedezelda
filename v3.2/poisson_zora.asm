POISSON_ZORA
	ld		a,(flag_stop_monstres)
	or		a
	RET		NZ

	ld	a,1
	ld	(flag_zora),a
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	POISSON_ZORA_ROM
	call	rom_off	
	
etapes_de_zora
	LD		a,28									; numero de ROM où se trouve le poisson
	LD		(bankROM),a
	LD		hl,SPRH12_ADR							; Sprite Hard ASIC de destination
	LD		(SPRH_ADR),hl
	ld		hl,(ZORA_en_X)
	ld		(SPRH12_X),hl							; X predefinit à changer si le poisson bouge
	ld		(SPRH_X),hl
	ld		hl,(ZORA_en_Y)
	ld		(SPRH12_Y),hl
	ld		(SPRH_Y),hl	
	LD		a,(flag_etape_du_poisson)				; A=0 il na pas encore poppé
	CP		a,1
	JP		z,NAISSANCE_ZORA						; A=1 intit termine, naissance debut ou en cours
	CP		a,2
	JP		z,update_poisson						; poisson affiche, pret a envoyé une boule de feu
	CP		a,3
	JP		z,MORT_poisson							; pas vraiment mort mais plonge dans l'eau
	cp		a,4
	jp		z,EFFACE_poisson						; là il disparait sous l'eau
	cp		a,5
	jp		z,mort_definitive_ou_objet						; là il s'est pris une fleche
	cp		a,6
	jp		z,recompense_poisson
	
INITIALISATION_ZORA
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	INITIALISATION_ZORA_ROM
	call	rom_off	
	call 	NAISSANCE_ZORA
	ret
AFFICHE_ZORA
	ld		a,1
	ld		(flag_monstre_zora),a
	LD		a,2
	LD		(flag_etape_du_poisson),a
	ld		a,28
	LD		(bankROM),a
	call	rom_on
	LD		hl,ZORA_ROM+#100
	LD		de,SPRH12_ADR
	LD		bc,#100
	LDIR
	call	rom_off
	LD		a,9
	LD		(SPRH12_ZOOM),a
	RET

; ************************************************************************************
; *****************************  NAISSANCE DES MONSTRES  *****************************
; ************************************************************************************


NAISSANCE_ZORA
	LD		a,(compteur_naissance_poisson)
	dec		a									; il est a 15
	LD		(compteur_naissance_poisson),a		; on le sauvegarde pour le prochain tour
	CP		a,0									; on verifie si il est a zero ou pas
	JP		Z,affiche_zora						; si il est a zero la naissance est terminee
	CP		A,cycle_naissance_1_zora				
	Jr		Z,naissance_poisson_phase_1
	CP		A,cycle_naissance_2_zora				
	Jr		Z,naissance_poisson_phase_2
	CP		A,cycle_naissance_3_zora				
	Jr		Z,naissance_poisson_phase_1
	CP		A,cycle_naissance_4_zora				
	Jr		Z,naissance_poisson_phase_2
	CP		A,cycle_naissance_5_zora				
	Jr		Z,naissance_poisson_phase_1
	CP		A,cycle_naissance_6_zora				
	Jr		Z,naissance_poisson_phase_2
	CP		A,cycle_naissance_7_zora				
	Jr		Z,naissance_poisson_phase_3
	RET	

naissance_poisson_phase_1
	LD		a,1
	LD		(flag_naissance_en_cours),a
	CALL	rom_on
	LD		hl,BORN4_SPR							; adresse du sprite dans la ROM
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	call	rom_off
	xor a
	LD		(flag_naissance_en_cours),a
	RET
naissance_poisson_phase_2
	LD		a,1
	LD		(flag_naissance_en_cours),a
	CALL	rom_on
	LD		hl,BORN5_SPR
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	call	rom_off
	xor		a
	LD		(flag_naissance_en_cours),a
	RET
naissance_poisson_phase_3
	LD		a,1
	LD		(flag_naissance_en_cours),a
	CALL	rom_on
	LD		a,28							; si riejn de tout çà, alors on récupère la derniere bank utilisé
	LD 		BC,#DF00+#80						
	add		a,c									; et on additione çà a la sélèction de bank pour tomber dessus
	LD		c,a
	OUT 	(C),C				
	LD		hl,ZORA_ROM
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	call	rom_off
	xor		a
	LD		(flag_naissance_en_cours),a
	RET
	
	
	
; ************************************************************************************
; **********************************  MORT DES MONSTRES*******************************
; ************************************************************************************	
update_poisson
ld		a,8
ld 		(identification_monstre_en_cours),a
call 	collision_fleche

LD		a,(compteur_poisson)					; on recupere le compteur qui est a xx
dec		a	
cp		a,15
CALL	Z,active_bouledefeu
							; il est a xx-1
LD		(compteur_poisson),a					; on le sauvegarde pour le prochain tour
RET		NZ

RET


	
active_bouledefeu
	ld		a,1
	ld		(flag_bouledefeu),a
	LD		a,#C3
	LD		(event_bouledefeu),a
	LD		hl,boule_de_feu
	LD		(event_bouledefeu+1),hl
	ld		(direction_bouledefeu_en_cours),a
	jr		init_bouledefeu
	RET
	
init_bouledefeu	
	LD		hl,(SPRH12_X)
	ld		(SPRH13_X),hl
	ld		hl,(SPRH12_Y)
	ld		(SPRH13_Y),hl
	RET


; ************************************************************************************
; **********************************  MORT DES MONSTRES*******************************
; ************************************************************************************

	
MORT_poisson
	LD		a,3
	LD		(flag_etape_du_poisson),a
	LD		a,(compteur_mort_poisson)
	dec		a								; il est a 15
	LD		(compteur_mort_poisson),a		; on le sauvegarde pour le prochain tour
	CP		a,0									; on verifie si il est a zero ou pas
	Jr		Z,efface_poisson					; si il est a zero la naissance est terminee
	CP		A,cycle_mort_1_zora				
	Jr		Z,mort_poisson_phase_1
	CP		A,cycle_mort_2_zora				
	Jr		Z,mort_poisson_phase_2
	CP		A,cycle_mort_3_zora				
	Jp		Z,mort_poisson_phase_3
	CP		A,cycle_mort_4_zora				
	Jr		Z,mort_poisson_phase_2
	CP		A,cycle_mort_5_zora				
	Jr		Z,mort_poisson_phase_3
	CP		A,cycle_mort_6_zora				
	Jr		Z,mort_poisson_phase_2
	CP		A,cycle_mort_7_zora				
	Jr		Z,mort_poisson_phase_3
	RET
EFFACE_poisson
	LD		a,4				
	LD		(flag_etape_du_poisson),a	
	ld		a,(compteur_poisson_absent)
	dec		a
	ld		(compteur_poisson_absent),a
	cp		a,0
	Jr		z,reinit_zora
	xor 	a
	LD		(SPRH12_ZOOM),a
	ld		(flag_monstre_zora),a
	ret
reinit_zora
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	reinit_zora_ROM8
	call	rom_off	
	ret


mort_poisson_phase_1
	LD		a,1
	LD		(flag_mort_en_cours),a
	LD		a,(bankROM_link1)
	LD		(bankROM),a
	CALL	rom_on
	LD		a,28					; si riejn de tout çà, alors on récupère la derniere bank utilisé
	LD 		BC,#DF00+#80						
	add		a,c						; et on additione çà a la sélèction de bank pour tomber dessus
	LD		c,a
	OUT 	(C),C
	LD		hl,ZORA_ROM
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	call	rom_off
	xor 	a
	LD		(flag_mort_en_cours),a
	RET
mort_poisson_phase_2
	LD		a,1
	LD		(flag_mort_en_cours),a
	LD		a,(bankROM_link1)
	LD		(bankROM),a
	CALL	rom_on
	LD		hl,BORN5_SPR
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	call	rom_off
	xor a
	LD		(flag_mort_en_cours),a
	RET
mort_poisson_phase_3
	LD		a,1
	LD		(flag_mort_en_cours),a
	LD		a,(bankROM_link1)
	LD		(bankROM),a
	CALL	rom_on
	LD		hl,BORN4_SPR
	LD		de,(SPRH_ADR)
	LD		bc,#100
	LDIR
	xor 	a
	LD		(flag_mort_en_cours),a
	RET
mort_definitive_ou_objet
	LD		a,5
	LD		(flag_etape_du_poisson),a
	xor 	a
	LD		(compteur_poisson),a
	LD		a,(compteur_mort_definitive)
	dec		a								; il est a 15
	LD		(compteur_mort_definitive),a		; on le sauvegarde pour le prochain tour
	CP		a,0									; on verifie si il est a zero ou pas
	Jr		Z,recompense_poisson					; si il est a zero la naissance est terminee
	CP		A,cycle_mort_1				
	JP		Z,mort_monstre_phase_1
	CP		A,cycle_mort_2				
	JP		Z,mort_monstre_phase_2
	CP		A,cycle_mort_3				
	JP		Z,mort_monstre_phase_3
	RET
recompense_poisson
	ld		a,11
	ld		(identification_monstre_en_cours),a
	LD		a,(flag_etape_du_poisson)
	cp		a,6
	call	test_collisions_items
	RET		Z
	
	ld		a,(No_PIECE)
	cp		a,81
	jr		nz,mort_definitive_du_poisson
	ld		a,(flag_triforce_2)
	cp		a,1
	jr		nz,mort_definitive_du_poisson
	ld		a,objet_porte_donjon_3
	ld		(type_objet_laisse),a
	call	affiche_objet
	ld		a,6
	ld		(flag_etape_du_poisson),a
	ret
mort_definitive_du_poisson
	ld		a,(No_PIECE)
	cp		a,81
	jr		nz,pas_d_objet_poisson
	ld		a,(flag_triforce_2)
	cp		a,1
	jr		nz,pas_d_objet_poisson
	ld		a,objet_porte_donjon_3
	ld		(type_objet),a
	call	compteur_objet
	jr		y_a_objet_poisson
pas_d_objet_poisson
	call	asic_on
	xor		a
	LD		(SPRH12_ZOOM),a
	jr		y_a_objet_poisson
y_a_objet_poisson
	call	asic_on
	xor		a
	LD		(event_poisson_zora),a
	LD		(event_poisson_zora+1),a
	LD		(event_poisson_zora+2),a
	ld		(flag_monstre_zora),a
;	ld 		c,2   ;Channel (0-2)
 ;   call 	PLY_AKG_StopSoundEffectFromChannel
	
	ret


	
	