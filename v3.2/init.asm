ON  EQU 1
OFF EQU 0

macro Asic switch
if {switch}
ld bc,#7FB8
out (c),c
else
ld bc,#7FA0
out (c),c
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

; au cas où nous aurions besoin d'une interruption à l'initialisation, on doit interromprele vector à #38
org #38
;ei
ret

;****************** ROM INIT ***************

rom_init

;********************* MANDATORY TO EXECUTE WITH A C4CPC ***************
im 1 					; don't know why but C4CPC corrupt interruption mode!
;***
ld bc,#7FC0 			; default memory conf
out (c),c
ld sp,0     			; raz 64K with stack
ld bc,4
ld hl,0
.raz
repeat 32
push hl
rend
djnz .raz
dec c
jr nz,.raz
;**************************** END OF MANDATORY CODE ********************


;; unlock ASIC so we can access ASIC registers (Kevin Thacker)
AsicUnlock
ld b,#bc
ld hl,unlockdata
ld e,17
.loop
inc b
outi
dec e
jr nz,.loop

CrtcSettings
ld c,0
ld e,16
.loop
out (c),c
ld a,(hl)
inc hl
inc b
out (c),a
dec b
inc c
dec e
jr nz,.loop


	; R12 selectionne et Ecran en #c000
	LD BC,#BC0C:OUT (C),C:LD BC,#BD00+%00110000:OUT (C),C


Asic On

; all colors to black and sprites disabled (DO NOT USE LDIR with a real CPC except if you like the red color ;)
AsicRazParam
ld hl,#6000
ld hl,#6400
ld b,128
xor a
.loop
ld (hl),a
ld (de),a
inc l
inc e
djnz .loop

; init du PPI

ld bc,#f782                     ;; setup initial PPI port directions
out (c),c
ld bc,#f400                     ;; set initial PPI port A (AY)
out (c),c
ld b,#f6                        ;; set initial PPI port C (AY direction)
out (c),c
ld bc,#EF7F                     ; firmware printer init d0->d6=1
out (c),c

; initialisation de la pile !!!
ld	sp,#Bffe
Asic OFF

; end



; ************************************************************************************************
; *****************************   INSTALLATION  DES ROMS EN RAM  *********************************
; ************************************************************************************************
; Copie des fichiers encres sprites Hard
	ld 		bc,#7fB8:out (c),c
	LD 		BC,#DF13+#80:OUT (C),C				; on choisit DE LIRE la ROM 19 (#13)
	LD		BC,#7F00+%10000000:OUT (C),C 		; connexion de la ROM supérieure et de la ROM inférieure et écran en mode 0.
	LD 		BC,#7FC0:OUT (c),c					; on choisit D'ECRIRE  dans la RAM centrale
	
	ld		hl,#c000							; lecture
	ld		de,#6422							; ecriture
	ld		bc,#1d								; longueur
	LDIR
; Copie des fichiers pallette cpc+
	ld		hl,#C01E							; lecture
	ld		de,#6400							; ecriture
	ld		bc,#20								; longueur
	LDIR
	
	
; Sprites Hard  (set 1,2 & 3)
	LD 		BC,#DF1F+#80:OUT (C),C				; on choisit DE LIRE la ROM 31 (#1F)
	LD		BC,#7F00+%10000000:OUT (C),C 		; connexion de la ROM supérieure et de la ROM inférieure et écran en mode 0.
	LD 		BC,#7FC0:OUT (c),c					; on choisit D'ECRIRE  dans la RAM centrale
	
	ld		hl,#c000							; lecture en ROM
	ld		de,#9000							; ecriture en RAM
	ld		bc,#1000							; longueur
	LDIR
	
	ld		hl,#D000							; lecture en ROM
	ld		de,#9600							; ecriture en RAM
	ld		bc,#1000								; longueur
	LDIR
	

	ld 		bc,#7fA0:out (c),c



; Programme principale
	LD 		BC,#7FC0:OUT (c),c					; on choisit D'ECRIRE  dans la RAM central
	LD 		BC,#DF01+#80:OUT (C),C				; on choisit DE LIRE la ROM 01 (#01)
	LD		BC,#7F00+%10000000:OUT (C),C 		; connexion de la ROM supérieure et de la ROM inférieure et écran en mode 0.


	ld		hl,#c000							; lecture
	ld		de,#8000							; ecriture
	ld		bc,#1000							; longueur
	LDIR
	JP		#8000



; *********************************************************************************************
; *************************************** PROGRAMME *******************************************
; *********************************************************************************************

bank 1
	incbin"rasmoutput.bin"
	
bank 19
	incbin"sprite.kit"		; fichier palette pour les sprites HARD	(ASIC #6422) longueur de #1D
							; commence en #c000
	incbin"palplus.kit"		; fichier palette pour la palette CPC+  (ASIC #6400) longueur de #1F
							; commence en #C01E

bank 31						; Sprites HARD
	incbin"borndead.spr"		; Link (haut bas gauche droite et attaques haut gauche droite)
	incbin"monstres.spr"		; Link (attaque bas)  reste 13 emplacements libres





