; -------------> NOTES PERSO
; rasm creation_cartouche.asm  -sw
; -sw  exporte les label
; -sq exporte les equ
; -sa  exporte TOUT !


; ////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////

; Ce fichier sert simplement à créer un fichier CPR

; ////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////

ON  EQU 1
OFF EQU 0

macro Asic switch
	if {switch}
	ld 		bc,#7FB8
	out 	(c),c
	else
	ld 		bc,#7FA0
	out 	(c),c
	endif
mend


buildcpr    ; indique que l'on veut construire une cartouche
bank 0      ; initialisation commence toujours en BANK 0
org 0       ; le tout premier code commence toujours à l'adresse 0
di          ; on désactive les INT au cas ou on reset soft
Asic OFF    ; dans le cas où l'on reboot le soft avec l'Asic ON
jr rom_init ; saut par dessus les interruptions et certaines données

; séquence pour délocker l'ASIC
unlockdata defb #ff,#00,#ff,#77,#b3,#51,#a8,#d4,#62,#39,#9c,#46,#2b,#15,#8a,#cd,#ee
; valeurs pour tous les registres du CRTC
crtcdata   defb #3f, 48, 50, #8e, 38, 0, 34, 35, #00, #07, #00,#00,#20,#00,#00,#DD

; au cas où nous aurions besoin d'une interruption à l'initialisation, on doit interrompre le vecteur à #38
	org 	#38
;ei
	ret

;****************** ROM INIT ***************

rom_init

;********************* MANDATORY TO EXECUTE WITH A C4CPC ***************
	im 		1 					; don't know why but C4CPC corrupt interruption mode!
;***
	ld 		bc,#7FC0 			; default memory conf
	out 	(c),c
	ld 		sp,0     			; raz 64K with stack
	ld 		bc,4
	ld 		hl,0
	.raz
	repeat 	32
	push 	hl
	rend
	djnz .raz
	dec 	c
	jr 		nz,.raz
;**************************** END OF MANDATORY CODE ********************


;; unlock ASIC so we can access ASIC registers (Kevin Thacker)
AsicUnlock
	ld 		b,#bc
	ld 		hl,unlockdata
	ld 		e,17
	.loop
	inc 	b
	outi
	dec 	e
	jr 		nz,.loop

CrtcSettings
	ld 			c,0
	ld 			e,16
	.loop
	out 		(c),c
	ld 			a,(hl)
	inc 		hl
	inc 		b
	out 		(c),a
	dec 		b
	inc 		c
	dec 		e
	jr 			nz,.loop


; R12 selectionne et Ecran en #c000
	LD BC,#BC0C:OUT (C),C
	LD BC,#BD00+%00110000:OUT (C),C


Asic On

; all colors to black and sprites disabled (DO NOT USE LDIR with a real CPC except if you like the red color ;)
AsicRazParam
	ld 		hl,#6000
	ld 		hl,#6400
	ld 		b,128
	xor 	a
.loop
	ld 		(hl),a
	ld 		(de),a
	inc 	l
	inc 	e
	djnz 	.loop

; init du PPI

ld bc,#f782                     ; setup initial PPI port directions
out (c),c
ld bc,#f400                     ; set initial PPI port A (AY)
out (c),c
ld b,#f6                        ; set initial PPI port C (AY direction)
out (c),c
ld bc,#EF7F                     ; firmware printer init d0->d6=1
out (c),c

; initialisation de la pile !!!
ld	sp,#bbfe
asic off
; nettoyage bank C4
LD 		BC,#7FC4:OUT (c),c		; on sélèctionne la bank C4
call	routine_de_raz_bank
; nettoyage bank C5
LD 		BC,#7FC5:OUT (c),c		; on sélèctionne la bank C5
call 	routine_de_raz_bank
; nettoyage bank C6
LD 		BC,#7FC6:OUT (c),c		; on sélèctionne la bank C6
call	routine_de_raz_bank
; nettoyage bank C7
LD 		BC,#7FC7:OUT (c),c		; on sélèctionne la bank C7
call	routine_de_raz_bank

LD 		BC,#7FC0:OUT (c),c	

jp start_screen

; on formatte l'écran
LD 		BC,#BC01:OUT (C),C						; position du border #28
LD 		BC,#BD00+#28:OUT (C),C	
LD 		BC,#BC02:OUT (C),C						; position de la HBL #2E
LD 		BC,#BD00+#2E:OUT (C),C	
LD 		BC,#BC07:OUT (C),C						; position de la HBL #19
LD 		BC,#BD00+#1E:OUT (C),C	
LD 		BC,#BC06:OUT (C),C						; position verticale du border	#1E
LD 		BC,#BD00+#19:OUT (C),C		

; on copie la fonte depuis la bank 31 
	LD 		BC,#DF1F+#80:OUT (C),C				; on choisit DE LIRE la ROM 31 (#1F)
	LD		BC,#7F00+%10000000:OUT (C),C 		; connexion de la ROM supérieure et de la ROM inférieure et écran en mode 0.
	LD 		BC,#7FC0:OUT (c),c					; on choisit D'ECRIRE  dans la RAM centrale
	ld		hl,#D000							; adresse de lecture
	ld		de,#80A0							; adresse de destination (ecriture)
	ld		bc,#1C00							; longueur des donnée que l'on coit copier
	LDIR
; on copie le texte du scenario	
	LD 		BC,#DF10+#80:OUT (C),C				; on choisit DE LIRE la ROM 6 (#06)
	LD		BC,#7F00+%10000000:OUT (C),C 		; connexion de la ROM supérieure et de la ROM inférieure et écran en mode 0.
	LD 		BC,#7FC0:OUT (c),c					; on choisit D'ECRIRE  dans la RAM centrale
	ld		hl,#E350							; lecture
	ld		de,#A000							; ecriture
	ld		bc,#1000							; longueur
	LDIR
	
Asic ON
; copie de la palette CPC+ (logé en bank 19) specialement pour le screen
	LD 		BC,#DF05+#80:OUT (C),C				; on choisit DE LIRE la ROM 6 (#06)
	LD		BC,#7F00+%10000000:OUT (C),C 		; connexion de la ROM supérieure et de la ROM inférieure et écran en mode 0.
	LD 		BC,#7FC0:OUT (c),c					; on choisit D'ECRIRE  dans la RAM centrale
	ld		hl,#C000							; lecture
	ld		de,#6400							; ecriture
	ld		bc,#20								; longueur
	LDIR
ASIC OFF

jp saute_mouton


fondu_des_couleurs
			ld	hl,Adresse_pallette_screen		; emplacement RAM de la pallette ecran 
			ld	de,#6400						; emplacement ASIC de la pallette ecran NOIRE !
			ld b,32								; longueur de la pallette
		boucle_fadein
				push bc
			fade_in_du_rouge	
				ld	a,(hl)								; on lit l'octet rouge/bleu
				ld	c,a
				AND %11110000
				cp	0									; est ce qu'il est à zéros ?
				jp	z,fade_in_du_bleu					; si oui alors on s'occupe de la couleur verte
				or	c
				ld	b,#10								; sinon on va s'occuper du rouge
				sub	a,b									; on lui enlève 1
				ld	(hl),a								; et on la sauvegarde
				ld	a,(de)								; on recupère l'octet rouge/bleu de l'ASIC
				add	a,b									; on augmente le rouge seulement
				ld	(de),a								; et on stock le rouge
			fade_in_du_bleu	
				ld	a,(hl)								; on lit l'octet rouge/bleu
				ld	c,a
				AND %00001111
				cp	0									; est ce qu'il est à zéros ?
				jp	z,fade_in_du_vert						; si oui alors on s'occupe de la couleur verte
				or	c
				dec	a								; sinon on va s'occuper du bleu on lui enlève 1
				ld	(hl),a								; et on la sauvegarde
				ld	a,(de)								; on recupère l'octet rouge/bleu de l'ASIC
				inc	a								; on augmente le rouge seulement
				ld	(de),a								; et on stock le bleu	
			fade_in_du_vert	
				inc	hl
				inc	de		
				ld	a,(hl)								; on lit l'octet vert
				cp	0									; est ce qu'il est à zéros ?
				jp	z,fade_in_encre_suivante			; si oui alors on s'occupe de l'encre suivante
				dec	a								; sinon on va s'occuper du vert on lui enlève 1
				ld	(hl),a								; et on la sauvegarde
				ld	a,(de)								; on recupère l'octet vert de l'ASIC
				inc	a								; on augmente le rouge seulement
				ld	(de),a								; et on stock le vert	
				fade_in_encre_suivante
				inc	hl
				inc	de
				pop bc
				djnz boucle_fadein
				ret



temporisation_du_du_fondu
ld	b,255
boucle_tempo
push BC
NOP

pop BC
djnz boucle_tempo
ret

routine_de_raz_bank
Xor 	a						; on va copier des zéros
ld 		hl,#4000				; on pointe en #4000
ld 		e,l						
ld 		d,h						; on cible la même adresse de destination mais ...
inc 	de						; ... l'octet suivant plutôt
ld 		(hl),a					; on ecrit zéro dans l'octet ciblé par l'adresse HL
LD 		BC,#4000				; longueur d'une bank
ldir							; on copie zéro de l'adresse HL dans l'octet suivant ciblé par DE
ret


saute_mouton

;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
variables_scroll			equ		#8000
offset_ecran				equ		variables_scroll
valeur_de_scroll			equ		variables_scroll+1
compteur_de_ligne			equ		variables_scroll+2
decalage_crtc				equ		variables_scroll+3
pointeur_lettre_scenario	equ		variables_scroll+4
pointeur_adresse_de_fonte	equ		variables_scroll+6
adr_de_la_lettre			equ		variables_scroll+8
pointeur_adr_ecran			equ		variables_scroll+10
decalage					equ		variables_scroll+12
ADRESSE_DE_FONTE			equ		variables_scroll+14
SCENARIO						equ		#A000
adresse_de_la_fonte_dans_la_ram  	equ  #80A0
ADRESSE_ECRAN_DEPART				equ  #FF80    ;#C730
fire1_cyle					equ		#9000

;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;///////////// INITIALISATION ////////////////
	LD	HL,SCENARIO
	ld	(pointeur_lettre_scenario),hl
	ld	hl,ADRESSE_DE_FONTE
	ld	(pointeur_adresse_de_fonte),hl	
	ld	hl,ADRESSE_ECRAN_DEPART
	ld	(pointeur_adr_ecran),hl
	ld	a,#30
	ld	(offset_ecran),a
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
	call	calcule_adr_lettre_dans_la_fonte
	call	on_affiche_une_ligne
Boucle_principale
	LD    B,#F5
frame2 
	IN    A,(C)
	RRA
	JR    NC,frame2
	
	resterla
		CALL	routine_clavier1
		BIT		4,A
		JP 		Z,start_screen
		BIT		5,A
		jp		z,resterla
		call	on_scroll_vers_le_haut
		CALL	retard_video
		call	calcule_adr_lettre_dans_la_fonte
		call	on_affiche_une_ligne
	jp Boucle_principale
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
calcule_adr_lettre_dans_la_fonte
	ld		a,(compteur_de_ligne)
	cp		0
	jp		z,on_calcule
	cp		16				; monbre de ligne pour a fonte
	jp		z,on_reinit_le_calcule
	inc		a
	ld		(compteur_de_ligne),a
	ret
	on_reinit_le_calcule
		xor		a
		ld		(compteur_de_ligne),a
		ld		hl,0
		ld		(decalage),hl
		ld		de,ADRESSE_DE_FONTE
		ld		(pointeur_adresse_de_fonte),de
		on_calcule
			inc		a
			ld		(compteur_de_ligne),a
			ld		b,20
			boucle_debut_20_lettres
				push	bc
				ld		HL,(pointeur_lettre_scenario)	; adresse de la lettre pointe du scenario
				LD 		A,(HL)			; on recupere son octet indique par la lettre dans DFEM
				cp		#24
				jp		z,start_screen
				SUB 	32			; on commence par A, donc 32 caractere en moins 
				LD 		L,A		; donc met le resultat de cet octet dans L
				LD 		H,0           	; on met 0 dans H (car H ne doit pas etre vide)
				ADD 	HL,HL        	; 40 + 40 = 80  ca fait x2
				ADD 	HL,HL        	; 80 + 80 = 160  ca fait x4
				ADD 	HL,HL        	; 160 + 160 = 320  ca fait x8
				ADD 	HL,HL        	; 320 + 320 = 640  ca fait x16
				ADD 	HL,HL        	; 640 + 640 = 1280  ca fait x32
				ADD 	HL,HL        	; 1280 + 1280 = 2560 ca fait x64
				LD 		BC,adresse_de_la_fonte_dans_la_ram
				ADD 	HL,BC        	;on additionne pour avoir l'adresse de la lettre a afficher.
				ld		(adr_de_la_lettre),HL		; on sauvegarde l'adresse de la lettre
				ld		hl,adr_de_la_lettre
				ld		de,(pointeur_adresse_de_fonte)	; on recupere le pointeur d'adresse de fonte
				LDI					; on recopie dans le tableau de fonte
				LDI	
				ld		(pointeur_adresse_de_fonte),de	; et on suavegarde l'eplacement du pointeur pour la prochaine fois
				ld		hl,(pointeur_lettre_scenario)	; on recupere l'adesse du pointeur
				inc		hl				; on passe a la lettre suivante
				ld		(pointeur_lettre_scenario),hl	; on sauvegarde le nouveau pointeur.
				pop		bc
				djnz	boucle_debut_20_lettres
				RET
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
on_affiche_une_ligne

	ld	ix,ADRESSE_DE_FONTE		; l'adresse du tableau de fonte
	ld	de,(pointeur_adr_ecran)		; je recupere l'adresse ecran de depart
	
	ld	b,20				; nombre de lettre par ligne
boucle_ligne_de_20_lettre
	push	bc
	ld	a,(ix)		; on prends l'octet contenu dans ix
	ld	l,a		; on le met dans L
	ld	a,(ix+1)	; on prends l'octet suivant
	ld	h,a		; on le met dans H

	ld	bc,(decalage)	; decalage de la premier ligne=0. Mais les autres de 4,8,16 etc ...
	add	hl,bc
	
	LDI			; on copie 4 octet a l'adresse DE qui s'increente
	LDI
	LDI
	LDI			; je sais que ca deborde ici, au dela de FFFF mais j'ai pas trouve de solution
	
  	inc	ix		; on deplace le pointe d'adresse du tableau
	inc	ix
	pop	bc
	djnz	boucle_ligne_de_20_lettre
	ld    	bc,(decalage)
    	ld    	hl,4
    	add    	hl,bc
    	ld    	(decalage),hl
	call	calcul_ligne_suivante
    	RET

calcul_ligne_suivante
	ld    de,(pointeur_adr_ecran)
	ld    hl,#800
	add    hl,de
	ld    (pointeur_adr_ecran),hl
	ret    nc
	LD     BC,#C050            ; valeur de ligne inférieur pour un ecran de 16 tiles de large
	ADD    HL,BC
	res	   3,h	
	ld    (pointeur_adr_ecran),hl
	RET
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////	
on_scroll_vers_le_haut
	ld	a,(valeur_de_scroll)			; on recupere le valeur du scroll a la ligne
	ld	b,16					; tous les 16 octets on scroll d'une ligne
	add	a,b					; si jamais ca depasse 
	res	7,a
	cp	0
	call	z,on_decale_le_crtc
	ld	(valeur_de_scroll),a
	ret
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
retard_video
	ld 	bc,#7fb8:out 	(c),c			; on connect l'ASIC
	ld	a,(valeur_de_scroll)
	ld	(#6804),a				; on l'envoie 
	ld 	bc,#7fa0 : out (c),c
	ret

;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
;/////////////////////////////////////////////
on_decale_le_crtc
	LD 	BC,#BC00+12
	OUT (C),C
	ld 	b,#BD
	ld 	a,(offset_ecran)
	ld 	c,a
	OUT (C),C

	LD 	BC,#BC00+13
	OUT (C),C
	ld 	B,#BD
	call	calcule_decalage 
	LD 	BC,#BC00+13
	OUT (C),C
	ld 	B,#BD	
	ld 	C,A
	OUT (C),C
	xor	a
	ld	(valeur_de_scroll),a	
	ret
calcule_decalage
	ld	a,(decalage_crtc)
	ld	d,40
	add	a,d
	call 	c,debordement
	ld	(decalage_crtc),a
	ret
debordement
	push	af
	ld	a,(offset_ecran)
	inc	a
	cp	#34
	call	z,reset_offset
	ld	(offset_ecran),a
	LD 	BC,#BC00+12:OUT (C),C
	ld 	b,#BD
	ld 	a,(offset_ecran)
	ld 	c,a
	OUT 	(C),C
	pop	af
	ret
reset_offset
	ld	a,#30
	ret



start_screen


Call extinction_des_couleurs


	; R12 selectionne et Ecran en #c000
	LD BC,#BC0C:OUT (C),C:LD BC,#BD00+%00110000:OUT (C),C
	
	; on repositionne de CRTC au bon endroit
	LD 	BC,#BC00+12:OUT (C),C
	ld 	BC,#BD30 : OUT (C),C

	LD 	BC,#BC00+13 : OUT (C),C
	ld 	BC,#BD00: OUT (C),C
	
	Asic ON
	xor a
	ld	(#6804),a	

	Asic OFF
	

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////// SCREEN INTRODUCTION ////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; on formatte l'écran  pour l'overscan
	LD 		BC,#BC01:OUT (C),C						; position du border
	LD 		BC,#BD00+#30:OUT (C),C	
	LD 		BC,#BC02:OUT (C),C						; position de la HBL
	LD 		BC,#BD00+#32:OUT (C),C	
	LD 		BC,#BC07:OUT (C),C						; position de la HBL
	LD 		BC,#BD00+#23:OUT (C),C	
	LD 		BC,#BC06:OUT (C),C						; position verticale du border	
	LD 		BC,#BD00+#22:OUT (C),C	


; copie des fichiers GO1 et GO2 en  pour l'overscan
	LD 		BC,#DF06+#80:OUT (C),C				; on choisit DE LIRE la ROM 7 (#07)
	LD		BC,#7F00+%10000000:OUT (C),C 		; connexion de la ROM supérieure et de la ROM inférieure et écran en mode 0.
	LD 		BC,#7FC0:OUT (c),c					; on choisit D'ECRIRE  dans la RAM centrale
	
	ld		hl,#c000							; lecture dans la bank ROM
	ld		de,#c000							; ecriture dans le bank RAM #4000
	ld		bc,#4000							; longueur
	LDIR

	LD 		BC,#DF07+#80:OUT (C),C				; on choisit DE LIRE la ROM 8 (#08)
	LD		BC,#7F00+%10000000:OUT (C),C 		; connexion de la ROM supérieure et de la ROM inférieure et écran en mode 0.
	LD 		BC,#7FC0:OUT (c),c					; on choisit D'ECRIRE  dans la RAM centrale
	
	ld		hl,#c000							; lecture dans la bank ROM
	ld		de,#4000							; ecriture dans le bank RAM (oui c'est chelou elles ont la même adresse)
	ld		bc,#4000							; longueur
	LDIR
	

	LD 		BC,#BC0C:OUT (C),C      				;R12 selectionne
	LD 		BC,#BD10:OUT (C),C 						;Ecran en #4000
	
; rupture ligne 167 normalement mais avec iDRAW2 y'a une bannière a virer en bas de l'ecran
	Asic ON
	ld		a,167:ld (#6801),a					; ligne de 2eme split
	ld		a,#10:ld (#6802),a					; registre 12
	
	LD 		BC,#BC0C:OUT (C),C      			; R12 selectionne
	LD 		BC,#BD30:OUT (C),C 					; Ecran en #c000
	Asic off



Adresse_pallette_screen		equ	#8070
Asic ON
; copie de la palette CPC+ (logé en bank 19) specialement pour le screen
	LD 		BC,#DF05+#80:OUT (C),C				; on choisit DE LIRE la ROM 6 (#06)
	LD		BC,#7F00+%10000000:OUT (C),C 		; connexion de la ROM supérieure et de la ROM inférieure et écran en mode 0.
	LD 		BC,#7FC0:OUT (c),c					; on choisit D'ECRIRE  dans la RAM centrale
	ld		hl,#C000							; lecture
	ld		de,Adresse_pallette_screen							; ecriture
	ld		bc,#20								; longueur
	LDIR
	
FADEIN
ld	B,155
boucle_nbr_de_tour_fadein
push BC
	LD      B,#F5
frame3  	
	IN      A,(C)
	RRA
	JR 		NC,frame3
call temporisation_du_du_fondu
call temporisation_du_du_fondu
call temporisation_du_du_fondu
call fondu_des_couleurs
call temporisation_du_du_fondu
call temporisation_du_du_fondu
call temporisation_du_du_fondu
pop BC
djnz boucle_nbr_de_tour_fadein

	
	
	
ASIC OFF
	
; ****************************************************************************************************************
; ****************************************************************************************************************
; ****************************************************************************************************************
Asic ON
; copie de la palette CPC+ (logé en bank 19) specialement pour le screen
	LD 		BC,#DF1A+#80:OUT (C),C				; on choisit DE LIRE la ROM 31 (#1F)
	LD		BC,#7F00+%10000000:OUT (C),C 		; connexion de la ROM supérieure et de la ROM inférieure et écran en mode 0.
	LD 		BC,#7FC0:OUT (c),c					; on choisit D'ECRIRE  dans la RAM centrale
	ld		hl,#C000							; lecture
	ld		de,#4000							; ecriture
	ld		bc,#1000								; longueur
	LDIR
ASIC OFF


; ****************************************************************************************************************
; ******************************************  BOUCLE PRINCIPALE **************************************************
; ****************************************************************************************************************
boucle_screen
	LD      B,#F5
frame  	
	IN      A,(C)
	RRA
	JR 		NC,frame
	
call	afficher_fire1	

jp boucle_screen



routine_clavier1
	LD		BC,#F40E:OUT (C),c
	LD		BC,#F6C0:OUT (C),C
	LD		BC,#F600:OUT (C),C
	LD		BC,#F792:OUT (C),C
	LD		BC,#F649:OUT (C),C
	LD		B,#F4:IN A,(C)
	LD		BC,#F782:OUT (C),C
	LD		BC,#F600:OUT (C),C
	RET


DEPART_FIRE1_X		EQU		#0128
DEPART_FIRE1_Y		EQU		#00D0


afficher_fire1
	Asic ON
	ld		a,(fire1_cyle)
	inc		a
	ld		(fire1_cyle),a
	cp		a,1
	jr		z,fire1_etape1
	cp		a,2
	jr		z,fire1_etape2
	cp		a,3
	jr		z,fire1_etape3
	cp		a,10
	jr		z,fire1_etape4
	cp		a,11
	jr		z,fire1_etape5
	cp		a,12
	jp		z,fire1_etape6
	cp		a,13
	jp		z,fire1_etape7
	cp		a,14
	jp		z,fire1_etape8
	cp		a,50
	jp		z,fire1_etape9
	cp		a,100
	jp		z,fire1_etape10
	CALL	routine_clavier1
	BIT		4,A
	JP 		Z,start_scenario

fire1_etape1
	LD 		BC,#DF05+#80:OUT (C),C				; on choisit DE LIRE la ROM 19 (#13)
	LD		BC,#7F00+%10000000:OUT (C),C 		; connexion Upper ROM et Lower ROM (et écran en mode 0.)
	LD 		BC,#7FC0:OUT (c),c					; Mode C0 : on choisit D'ECRIRE  dans la RAM centrale

	ld		hl,#D060							; lecture
	ld		de,#6422							; ecriture
	ld		bc,#1D								; longueur
	LDIR
	RET
fire1_etape2	
	LD 		BC,#DF05+#80:OUT (C),C				; on choisit DE LIRE la ROM 05 (#1F)
	LD		BC,#7F00+%10000000:OUT (C),C 		; connexion de la ROM supérieure et de la ROM inférieure et écran en mode 0.
	LD 		BC,#7FC0:OUT (c),c					; on choisit D'ECRIRE  dans la RAM centrale
	ld		hl,#C060
	ld		de,#4000
	ld		bc,#600
	LDIR
	RET
fire1_etape3
	ld	hl,DEPART_FIRE1_X
	ld	de,DEPART_FIRE1_Y
	ld	(#6000),hl
	ld	(#6002),de
	ld	a,9
	ld	(#6004),a
	ret
fire1_etape4
	ld	hl,DEPART_FIRE1_X+32
	ld	de,DEPART_FIRE1_Y
	ld	(#6008),hl
	ld	(#600A),de
	ld	a,9
	ld	(#600C),a
	ret
fire1_etape5
	ld	hl,DEPART_FIRE1_X+64
	ld	de,DEPART_FIRE1_Y
	ld	(#6010),hl
	ld	(#6012),de
	ld	a,9
	ld	(#6014),a
	ret
fire1_etape6
	ld	hl,DEPART_FIRE1_X+96
	ld	de,DEPART_FIRE1_Y
	ld	(#6018),hl
	ld	(#601A),de
	ld	a,9
	ld	(#601C),a
	ret
fire1_etape7
	ld	hl,DEPART_FIRE1_X+128
	ld	de,DEPART_FIRE1_Y
	ld	(#6020),hl
	ld	(#6022),de
	ld	a,9
	ld	(#6024),a
	ret
fire1_etape8
	ld	hl,DEPART_FIRE1_X+160
	ld	de,DEPART_FIRE1_Y
	ld	(#6028),hl
	ld	(#602A),de
	ld	a,9
	ld	(#602C),a
	ret
fire1_etape9
	xor	a
	ld	(#6004),a
	ld	(#600C),a
	ld	(#6014),a
	ld	(#601C),a
	ld	(#6024),a
	ld	(#602C),a
	CALL	routine_clavier1
	BIT		4,A
	JP 		Z,start_scenario
	ret
fire1_etape10
	ld	a,9
	ld	(#6004),a
	ld	(#600C),a
	ld	(#6014),a
	ld	(#601C),a
	ld	(#6024),a
	ld	(#602C),a
	ld	a,15
	ld		(fire1_cyle),a
	CALL	routine_clavier1
	BIT		4,A
	JP 		Z,start_scenario
	ret



;*****************************************

reinit_pallette2
	ld	a,0
	ld	l,a
	ld	b,100
attente
	push	bc
	nop
	pop bc
	djnz attente
	ret

;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////
start_scenario

xor	a
	ld	(#6004),a
	ld	(#600C),a
	ld	(#6014),a
	ld	(#601C),a
	ld	(#6024),a
	ld	(#602C),a


	
;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////


ASIC ON
ld	a,0:ld (#600C),a 
ld	a,0:ld (#6004),a 



Call extinction_des_couleurs

REDEMARRAGE_DU_JEU


initialisation_bank
ASIC OFF
Xor a
ld hl,#0000
ld e,l
ld d,h
inc de
ld (hl),a
LD BC,#4000
ldir

Xor a
ld hl,#4000
ld e,l
ld d,h
inc de
ld (hl),a
LD BC,#4000
ldir

LD		hl,#8500
ld		de,#4600
ld		bc,#76F
LDIR

ld 	a,0
ld	(#8000),a 
ld	(#8002),a 

ld	hl,#8000
ld	de,#c000
ld  bc,#4000
LDIR
	ld 		bc,#7fB8:out (c),c
	ld		a,0:ld (#6801),a
	ld		hl,#0030:ld		(#6802),hl
	ld		hl,#0030: ld		(#6803),hl
	ld 		bc,#7fa0:out (c),c


; /////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////	

; initialisation de la pile !!!
ld	sp,#2BFF

Asic OFF

; end

Xor a
ld hl,#8000
ld e,l
ld d,h
inc de
ld (hl),a
LD BC,#4000
ldir


; ************************************************************************************************
; *****************************   INSTALLATION DES ROMS EN RAM  *********************************
; ************************************************************************************************

; Tiles de Murs et du Sol
	LD 		BC,#DF17+#80:OUT (C),C					; on choisit DE LIRE la ROM 23 (#17)
	LD 		BC,#7F00+%10000000:OUT (C),C 		; connexion de la ROM supérieure et de la ROM inférieure et écran en mode 0.
	LD 		BC,#7FC4:OUT (c),c					; on choisit D'ECRIRE  dans la RAM C4
	ld		hl,#c000							; lecture
	ld		de,#4000							; ecriture
	ld		bc,#4000							; longueur
	LDIR

; Tiles de 8 octets de large pour la fonte des boutique
	LD 		BC,#DF0F+#80:OUT (C),C				; on choisit DE LIRE la ROM 15 (#0F)
	LD 		BC,#7F00+%10000000:OUT (C),C 		; connexion de la ROM supérieure et de la ROM inférieure et écran en mode 0.
	LD 		BC,#7FC4:OUT (c),c					; on choisit D'ECRIRE  dans la RAM C4
	ld		hl,#D400							; lecture
	ld		de,#56C0							; ecriture (anciennement #5400)
	ld		bc,#05B0							; longueur
	LDIR
; Tiles de  coeur
	LD 		BC,#7FC4:OUT (c),c					; on choisit D'ECRIRE  dans la RAM C4
	ld		hl,#D9B0							; lecture
	ld		de,#5100							; ecriture   (anciennement #5C70)
	ld		bc,#0060							; longueur    8 ligne de haut  4 octets de large (60 en tout). 
	LDIR
				


; Maptiles de la map principale (part 1)
	LD 		BC,#DF16+#80:OUT (C),C					; on choisit DE LIRE la ROM 22 (#16)
	LD 		BC,#7F00+%10000000:OUT (C),C 		; connexion de la ROM supérieure et de la ROM inférieure et écran en mode 0.
	LD 		BC,#7FC6:OUT (c),c					; on choisit D'ECRIRE  dans la RAM C5

	ld		hl,#c000							; lecture
	ld		de,#4000							; ecriture
	ld		bc,#4000							; longueur
	LDIR

; Maptiles de la map principale (part 2)
	LD 		BC,#DF15+#80:OUT (C),C					; on choisit DE LIRE la ROM 21 (#15)
	LD		BC,#7F00+%10000000:OUT (C),C 		; connexion de la ROM supérieure et de la ROM inférieure et écran en mode 0.
	LD 		BC,#7FC7:OUT (c),c					; on choisit D'ECRIRE  dans la RAM C6

	ld		hl,#c000							; lecture
	ld		de,#4000							; ecriture
	ld		bc,#4000							; longueur
	LDIR

; Maptiles de la map principale (part 3)
	LD 		BC,#DF14+#80:OUT (C),C					; on choisit DE LIRE la ROM 20 (#14)
	LD		BC,#7F00+%10000000:OUT (C),C 		; connexion de la ROM supérieure et de la ROM inférieure et écran en mode 0.
	LD 		BC,#7FC5:OUT (c),c					; on choisit D'ECRIRE  dans la RAM C5

	ld		hl,#c000							; lecture
	ld		de,#4000							; ecriture
	ld		bc,#3DA0							; longueur. Ne pas aller au dela de #3E00 car à partir de cette adresse là
												; je stock des flag pour le gameover
	LDIR
	


; Programme principale
	LD 		BC,#DF01+#80:OUT (C),C				; on choisit DE LIRE la ROM 01 (#01)
	LD 		BC,#7FC0:OUT (c),c					; on choisit D'ECRIRE  dans la RAM central
	LD		BC,#7F00+%10000000:OUT (C),C 		; connexion Upper ROM et Lower ROM (et écran en mode 0.)
	ld		hl,#c000							; lecture
	ld		de,#8000							; ecriture
	ld		bc,#4000							; longueur
	LDIR
	
	
Asic ON
; Copie pallette "hyrule"
	LD 		BC,#DF13+#80:OUT (C),C				; on choisit DE LIRE la ROM 19 (#13)
	LD		BC,#7F00+%10000000:OUT (C),C 		; connexion Upper ROM et Lower ROM (et écran en mode 0.)
	LD 		BC,#7FC0:OUT (c),c					; Mode C0 : on choisit D'ECRIRE  dans la RAM centrale


	
; Copie pallette sprite hard
	ld		hl,#C0C0							; lecture
	ld		de,#6422							; ecriture
	ld		bc,#1D								; longueur
	LDIR
	Asic OFF

JP		#8000


extinction_des_couleurs	
ASIC ON
		ld		hl,#6400			; l'emplacement de ma pallette dans l'ASIC
		ld		b,#30				; la longueur d'une pallette
fade_out_RVB_boucle_general
		push	bc
			LD      B,#F5
frame4  	
	IN      A,(C)
	RRA
	JR 		NC,frame4
		call	fade_out_RVB_de_chaque_encre
		call temporisation_du_du_fondu
		pop		bc
		djnz	fade_out_RVB_boucle_general
		RET

fade_out_RVB_de_chaque_encre	
		ld		hl,#6400			; l'emplacement de ma pallette dans l'ASIC
		ld		b,#20				; la longueur d'une pallette
fade_out_RVB_boucle
		push	bc
	fade_out_du_rouge	
		ld		a,(hl)				; on met dans a, la valeur du rouge et bleu
		AND %11110000
		or		a
		jr		z,fade_out_du_bleu
		ld		b,16				; tout les 16, les bits 4 à 7 décremente de 1
		sub		a,b					; on a diminué de rouge
		ld		(hl),a			; on renvoye dans la pelette la valeur modifiée
	fade_out_du_bleu
		ld		a,(hl)				; on met dans a, la valeur du rouge et bleu
		AND %00001111
		or		a
		jr		z,fade_out_du_vert
		dec		a					; les bits 0 à 3 décremente de 1  on a diminué le bleu
		ld		(hl),a			; on renvoye dans la pelette la valeur modifiée
	fade_out_du_vert	
		inc		hl					; on se positionne sur l'adresse de l'octet pour le vert
		ld		a,(hl)				; on met dans a, la valeur du vert
		or		a
		jr		z,encre_suivante
		dec		a					; les bits 0 à 3 décremente de 1 on a diminué le vert
		ld		(hl),a			; on renvoye dans la pelette la valeur modifiée
	encre_suivante
		inc		hl
		pop		bc
djnz fade_out_RVB_boucle
RET


; *****************************************************************************************************************
; *****************************************************************************************************************
; *****************************************************************************************************************
; *************************************** ENVOIE DES FICHIERS VERS ROMs *******************************************
; *****************************************************************************************************************
; *****************************************************************************************************************
; *****************************************************************************************************************
bank 1
	include"main.asm"
;bank 2
	;(programme)

bank 3
	ORG #011C
	include"PlayerAkg.asm"						; #073F de longueur
	

;bank 4
	;(musique)

bank 5
	incbin"contenu_creation_cartouche/graphismes_du_jeu/screen.kit"		; fichier palette CPC+ pour le Screen d'introduction
	incbin"contenu_creation_cartouche/graphismes_du_jeu/gameover.kit"		; fichier palette CPC+ pour le Screen d'introduction
	incbin"contenu_creation_cartouche/graphismes_du_jeu/fin.kit"
	incbin"contenu_creation_cartouche/sprites_hard/fire12.spr"			; #C060
	incbin"contenu_creation_cartouche/pallettes/fire12.bin"				; #D060

bank 6
	incbin"contenu_creation_cartouche/graphismes_du_jeu/screen.go1"
bank 7
	incbin"contenu_creation_cartouche/graphismes_du_jeu/screen.go2"
;bank 8
	;(programme)

;bank 9 (programme)

bank 10
	incbin"contenu_creation_cartouche/graphismes_du_jeu/gameover.scr"

bank 11
	incbin"contenu_creation_cartouche/graphismes_du_jeu/gameover.scr"
;bank 12  (programme)
	



bank 13
	incbin"contenu_creation_cartouche/graphismes_du_jeu/ocean_sol.bin"				; longueur de #1e00
	incbin"contenu_creation_cartouche/graphismes_du_jeu/ocean_mur.bin"				; longueur de #20C0  (à confirmer)


bank 14
	incbin"contenu_creation_cartouche/graphismes_du_jeu/map_donjon0.bin"				; fichier map du donjon 1  longeur #0420  (1 tile)  22 x 48
	incbin"contenu_creation_cartouche/graphismes_du_jeu/map_donjon1.bin"				; fichier map du donjon 1  longeur #0420  (1 tile)  22 x 48
	incbin"contenu_creation_cartouche/graphismes_du_jeu/map_hyrule.bin"				; 
	incbin"contenu_creation_cartouche/graphismes_du_jeu/map_donjon2.bin"				; fichier map du donjon 1  longeur #0420  (1 tile)  22 x 48
	incbin"contenu_creation_cartouche/graphismes_du_jeu/map_donjon3.bin"				; fichier map du donjon 1  longeur #0420  (1 tile)  22 x 48
	incbin"contenu_creation_cartouche/graphismes_du_jeu/map_donjon4.bin"				; fichier map du donjon 1  longeur #0420  (1 tile)  22 x 48

bank 15
	incbin"contenu_creation_cartouche/graphismes_du_jeu/hud.bin"
	; commence en #C000  longueur de #1400. Encodé comme tile 16 lignes par 4 octet de large en horizontal.
	;attention ImpDRAW place 3 octets de tag à la fin du fichier, qu'il faut enlever à chaque fois	
	;incbin"contenu_creation_cartouche/graphismes_du_jeu/boutique_font.bin"			; commence en #D400 longuer de #5B0. Colonne de 1 octet
	
	incbin"contenu_creation_cartouche/graphismes_du_jeu/fontebdc.bin"
	incbin"contenu_creation_cartouche/graphismes_du_jeu/3coeurs3.bin"				;commence en #D9B0 longeur #0050. 4 octet de large par 6 lignes de haut longeur #0048 dans font catcher

bank 16
	incbin"contenu_creation_cartouche/tables/table_init_monstre_7.prg"		; commence en #C000 fini en #D2CF  longueur de #12D0
	incbin"contenu_creation_cartouche/tables/table_init_grottes.prg"			; commence en #D2D0 fini en #E59F  longueur de #12D0
	;incbin"contenu_creation_cartouche/tables/scenario.prg"					; commence en #E350 
	
	;incbin"contenu_creation_cartouche/tables/scenarioEN.prg"

bank 17
	incbin"contenu_creation_cartouche/tables/table_init_monstre_4.prg"		; commence en #C000 fini en #D2CF  longueur de #12D0
	incbin"contenu_creation_cartouche/tables/table_init_monstre_5.prg"		; commence en #D2D0 fini en #E59F  longueur de #12D0
	incbin"contenu_creation_cartouche/tables/table_init_monstre_6.prg"		; commence en #E5A0 fini en #F870 longueur de #12D0
	
bank 18
	incbin"contenu_creation_cartouche/tables/table_init_monstre_1.prg"		; commence en #C000 fini en #D2CF  longueur de #12D0
	incbin"contenu_creation_cartouche/tables/table_init_monstre_2.prg"		; commence en #D2D0 fini en #E59F  longueur de #12D0
	incbin"contenu_creation_cartouche/tables/table_init_monstre_3.prg"		; commence en #E5A0 fini en #F870 longueur de #12D0

	
bank 19											; Pallette CPC+ de longeur #20 (ASIC #6400) DEBUT - FIN
	incbin"contenu_creation_cartouche/pallettes/pallette_hyrule.kit"	; #C000 - #C01F
	incbin"contenu_creation_cartouche/pallettes/pallette_hud.kit"		; #C020 - #C03F 
	incbin"contenu_creation_cartouche/pallettes/pallette_donjon.kit"	; #C040	- #C05F
	incbin"contenu_creation_cartouche/pallettes/pallette_ocean.kit"		; #C060 - #C07F
	incbin"contenu_creation_cartouche/pallettes/pallette_maison.kit"	; #C080 - #C09F
	incbin"contenu_creation_cartouche/pallettes/gameover.kit"			; #C0A0 - #C0BF
	incbin"contenu_creation_cartouche/pallettes/pallette_sprh.kit"		; #C0C0 - #C0DF
	incbin"contenu_creation_cartouche/pallettes/pallette_screen.kit"   	; #C0E0 - #C0FF
											; Palette sprites HARD longeur #1D (ASIC #6422)
	

bank 20						; map des tiles pour les pièces 163 à 255
	incbin"contenu_creation_cartouche/maptiles/maptile3.prg"					; fichier 10ko - tiles MODE0 L=#04 H=16
		
bank 21						; map des tiles pour les pièces 85 à 162
	incbin"contenu_creation_cartouche/maptiles/maptile2.prg"					; fichier 10ko - tiles MODE0 L=#04 H=16
	
bank 22						; map des tiles pour les pièces 1 à 84
	incbin"contenu_creation_cartouche/maptiles/maptile1.prg"					; fichier 16ko - tiles MODE0 L=#04 H=16

bank 23
	incbin"contenu_creation_cartouche/graphismes_du_jeu/hyrule_sol.bin"			; longueur de #1e00
	incbin"contenu_creation_cartouche/graphismes_du_jeu/hyrule_mur.imp"			; longueur de #20C0
		
bank 24
	incbin"contenu_creation_cartouche/graphismes_du_jeu/donjons_sol.bin"		; longueur de #1CC0  (115 tiles)
	incbin"contenu_creation_cartouche/graphismes_du_jeu/donjons_mur.bin"		; longeur de #20c0	(131 tiles)
	
	
bank 25
	incbin"contenu_creation_cartouche/sprites_hard/objets1.spr"		
	incbin"contenu_creation_cartouche/sprites_hard/objets2.spr"
	incbin"contenu_creation_cartouche/sprites_hard/tirs1.spr"
	

bank 26					
	incbin"contenu_creation_cartouche/sprites_hard/perso1.spr"			; début : #C000	
	incbin"contenu_creation_cartouche/sprites_hard/borndead.spr"		; début : #D000  (Sprites d'animations des naissance et mort des monstres)
	incbin"contenu_creation_cartouche/sprites_hard/monstre1.spr"		; octorock 1 & 2
	incbin"contenu_creation_cartouche/sprites_hard/monstre3.spr"		; Moblins 1 et 2

bank 27
	incbin"contenu_creation_cartouche/sprites_hard/monstre4.spr"		; Lynel 1 et 2
	incbin"contenu_creation_cartouche/sprites_hard/monstre7.spr"		; Gorya 1 & 2
	incbin"contenu_creation_cartouche/sprites_hard/monstre6.spr"		; Darknut 1 & 2
	incbin"contenu_creation_cartouche/sprites_hard/mario.spr"			; Mario
bank 28
	incbin"contenu_creation_cartouche/sprites_hard/monstre8.spr"		; Vire, Like like, Bulle
	incbin"contenu_creation_cartouche/sprites_hard/monstre5.spr"		; Rope et les flying fish
	incbin"contenu_creation_cartouche/sprites_hard/monstre2.spr"		; sprite contenant 2 animations chacun Tektite, Peahat, Chauve souris
	incbin"contenu_creation_cartouche/sprites_hard/monstre9.spr"		; Zola, fantome, fée, wall-master, poire
	
bank 29
	incbin"contenu_creation_cartouche/sprites_hard/link0.spr"			; link de depard, 12 perso + 4 epée en bois
	incbin"contenu_creation_cartouche/sprites_hard/link1.spr"			; 4 épée metal, 4 flèche en bois, 8 link qui nage 
	incbin"contenu_creation_cartouche/sprites_hard/link2.spr"			; link dans différentes positions
	incbin"contenu_creation_cartouche/sprites_hard/armes.spr"
	
bank 30
	incbin"contenu_creation_cartouche/sprites_hard/bosses1.spr"
	incbin"contenu_creation_cartouche/sprites_hard/bosses2.spr"
	incbin"contenu_creation_cartouche/sprites_hard/bosses3.spr"
	incbin"contenu_creation_cartouche/sprites_hard/bosses4.spr"
	
bank 31
	incbin"contenu_creation_cartouche/sprites_hard/bosses4b.spr"
	incbin"contenu_creation_cartouche/graphismes_du_jeu/scenario_fonte.imp"
	
		; il reste 4 fichier de sprite hard de boss à créer
		
		
	

