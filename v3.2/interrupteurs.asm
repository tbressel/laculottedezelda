; ************************************************************************************
; *****************************  ASIC ON OU OFF **************************************
; ************************************************************************************
asic_on
	DI
	LD		a,1
	LD		(flag_asic),a
	;LD 	bc,#7fB8
	;out 	(c),c
	ld 		bc,#7Fb8
    ld 		a,#c0
    out 	(c),a     ; reset Bank
	out (c),c
    EI
	ret
asic_off
	DI
	xor		a
	LD		(flag_asic),a
	LD 		bc,#7fA0:out (c),c
	EI
	ret

code_bank2_on
DI
	;ld		a,(bankrom)							; On recupère le numero de la dernière bank utilisé
	;ld		(bankrom_save),a					; et on la sauvegarde 
	;ld		a,(flag_rom)						; On recupere l'état de la derniere bank connecté
	;ld		(flag_rom_save),a					; et on la sauve aussi
	
	
	
	
	ld		a,2
	ld		(bankrom),a
EI
	ret
code_bankx_off
DI
	;ld		a,(bankrom_save)
	;ld		(bankrom),a
	;ld		a,(flag_rom_save)
	;ld		(flag_rom),a
EI
	ret
rom_on_bank_prog
DI	
	LD		a,1
	LD		(flag_rom),a						; si une interruptio arrive mon flag est a jour
	LD		a,(bankROM)							; si riejn de tout çà, alors on récupère la derniere bank utilisé
	LD 		BC,#DF00+#80						
	add		a,c									; et on additione çà a la sélèction de bank pour tomber dessus
	LD		c,a
	
	OUT 	(C),C				
	LD		BC,#7F00+%10000100:OUT (C),C 		; connexion de la ROM supérieure et écran en mode 0.
	LD 		BC,#7FC0:OUT (c),c					; Mode C0 : on choisit D'ECRIRE  dans la RAM centrale
EI
	RET



C0_on
DI
	ld		a,1
	ld		(flag_C0),a
	xor		a
	ld		(flag_C4),a
	ld		(flag_C5),a
	ld		(flag_C6),a
	ld		(flag_C7),a

	LD 		BC,#7FC0:OUT (C),c
EI	
	ret

C4_on
DI
	ld		a,1
	ld		(flag_C4),a
	LD 		BC,#7FC4:OUT (C),c
	xor		a
	ld		(flag_C0),a
	ld		(flag_C5),a
	ld		(flag_C6),a
	ld		(flag_C7),a
EI
	ret
C4_off
	xor		a
	ld		(flag_C4),a
	;LD 		BC,#7FC0:OUT (c),c	
	ret
C5_on
DI
	ld		a,1
	ld		(flag_C5),a
	LD 		BC,#7FC5:OUT (C),c
	xor		a
	ld		(flag_C4),a
	ld		(flag_C0),a
	ld		(flag_C6),a
	ld		(flag_C7),a
EI
	ret
C5_off
	xor		a
	ld		(flag_C5),a
	;LD 		BC,#7FC0:OUT (c),c	
	ret
C6_on
DI
	ld		a,1
	ld		(flag_C6),a
	LD 		BC,#7FC6:OUT (C),c
	xor		a
	ld		(flag_C4),a
	ld		(flag_C5),a
	ld		(flag_C0),a
	ld		(flag_C7),a
EI
	ret
C6_off
	xor		a
	ld		(flag_C6),a
	;LD 		BC,#7FC0:OUT (c),c	
	ret
C7_on
DI
	ld		a,1
	ld		(flag_C7),a
	LD 		BC,#7FC7:OUT (C),c
	xor		a
	ld		(flag_C4),a
	ld		(flag_C5),a
	ld		(flag_C6),a
	ld		(flag_C0),a
	EI
	ret
C7_off
	xor		a
	ld		(flag_C7),a
	;LD 		BC,#7FC0:OUT (c),c	
	ret
del_on
	ld 		a,#ca
	ld 		(del_jpz),a
	ld 		hl,inventaire
	ld 		(del_jpz+1),hl
	ret
del_off
	xor 	a	
	ld 		(del_jpz),a
	ld 		(del_jpz+1),a
	ld 		(del_jpz+2),a
	ret
fire1_on
	ld 		a,#ca
	ld 		(fire1_jpz),a
	ld 		hl,fire1
	ld 		(fire1_jpz+1),hl
	call	reinit_compteur_sans_attaquer
	ret
fire1_off
	xor 	a	
	ld 		(fire1_jpz),a
	ld 		(fire1_jpz+1),a
	ld 		(fire1_jpz+2),a
	ret
fire2_on
	ld 		a,#ca
	ld 		(fire2_jpz),a
	ld 		hl,fire2
	ld 		(fire2_jpz+1),hl
	call	reinit_compteur_sans_tirer
	ret
fire2_off
	xor 	a	
	ld 		(fire2_jpz),a
	ld 		(fire2_jpz+1),a
	ld 		(fire2_jpz+2),a
	ret
music_on
	ld 		a,#cd
	ld 		(event_musique),a
	ld 		hl,PLY_AKG_Play
	ld 		(event_musique+1),hl
	ret
reinit_compteur_sans_attaquer
	xor		a
	ld		(event_compteur_attaque),a
	ld		(event_compteur_attaque+1),a
	ld		(event_compteur_attaque+2),a
	ld		(compteur_sans_attaquer),a
	ret
reinit_compteur_sans_tirer
	xor		a
	ld		(event_compteur_tirer),a
	ld		(event_compteur_tirer+1),a
	ld		(event_compteur_tirer+2),a
	ld		(compteur_sans_tirer),a
ret
;music_off
;	ld 		a,#cd
;	ld 		(event_musique),a
;	ld 		hl,PLY_AKG_Stop
;	ld 		(event_musique+1),hl
;	ret

rom_on
DI
	LD		a,1
	LD		(flag_rom),a	; si une interruptio arrive mon flag est a jour
		
	LD		a,(flag_naissance_en_cours)			; test si on est dans une naissance en cours
	OR		A
	CALL	NZ,bank_naissance_monstres			; si c'ets le cas on va dans la bank_naissance_monstres
	LD		a,(flag_mort_en_cours)				; test si le monstre est en train de crever
	OR		A
	CALL	NZ,bank_naissance_monstres			; on va aussi dans la bank naissance qui contient aussi les sprite de la mort
	LD		a,(bankROM)							; si rien de tout çà, alors on récupère la derniere bank utilisé

	LD 		BC,#DF00+#80						
	add		a,c									; et on additione çà a la sélèction de bank pour tomber dessus
	LD		c,a
	OUT 	(C),C				
	LD		BC,#7F00+%10000100:OUT (C),C 		; connexion de la ROM supérieure et écran en mode 0.
	LD 		BC,#7FC0:OUT (c),c					; Mode C0 : on choisit D'ECRIRE  dans la RAM centrale
EI
	RET
rom_off
DI
	XOR		A
	LD		(flag_rom),a

	LD 		BC,#DF00+#80:OUT (C),C				; Sélèction de la rom 0
	LD 		BC,#7F00+%10001100:OUT (C),C 		; déconnexion de la ROM supérieure ET inférieure ET écran en mode 0.
EI
	RET
pallette_off
	call 	asic_on	
	Xor 	a									; on met 0 dans A
	ld 		hl,#6400							; début à effacer en #63FF
	ld 		e,l									
	ld 		d,h									
	inc 	de									; on incremente de 1 l'adresse à effacer
	ld 		(hl),a								; et on met 0 dans l'octet de l'adresse 
	LD 		BC,#20								; sur une longueur de #1F
	ldir						
	RET
pallette_on
	call 		asic_on	
	ld			hl,(type_de_palette)
	ld			de,#6400						
	ld			bc,#20						 
	ldir
	ret

test_de_touche_on
		ld		a,#C3
		ld		(event_testtouche),a
		ld		hl,test_de_touches
		ld		(event_testtouche+1),hl
		RET
test_de_touche_off
		xor		a
		ld		(event_testtouche),a
		ld		(event_testtouche+1),a
		ld		(event_testtouche+2),a
		RET




				