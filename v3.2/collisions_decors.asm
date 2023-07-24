; ********************* Calcule de la ligne de tile sur laquelle se trouve le perso *****************


collision_gauche
; *************************************** SPRITE 0 *****************************************
LD	HL,(SPRH_X)			; je prends X du sprite 0 (par defaut gauche)
LD	DE,0				; j'additionne 8 pixels 
ADD	HL,DE				; pour laisser un bout de tete
LD	(collision_spr0_posx),HL	; je stock X

LD	HL,(SPRH_Y)			; je prends Y du sprite 0 (par defaut haut)
LD	DE,12				; je TEST LE MILEU DU SPRITEdonnes (1 pixel = 1 coordonnee)
ADD	HL,DE				; pour tester le bas du sprite
LD	(collision_spr0_posy),HL	; je stock Y	

JR COLLISIONS


collision_droite
; *************************************** SPRITE 0 *****************************************
LD	HL,(SPRH_X)			; je prends X du sprite 0 (par defaut gauche)
LD	DE,31				; j'additionne 48 pixels
ADD	HL,DE				; pour me situer a droite
LD	(collision_spr0_posx),HL	; je stock X

LD	HL,(SPRH_Y)			; je prends Y du sprite 0 (par defaut haut)
LD	DE,12				; j'additionne 8 pixels 
ADD	HL,DE				; pour laisser un bout de tete
LD	(collision_spr0_posy),HL	; je stock Y

JR COLLISIONS


collision_haut
; *************************************** SPRITE 0 (gauche) *****************************************
LD	HL,(SPRH_Y)			; je prends Y du sprite 0 (par defaut haut)
LD	DE,0				; j'additionne 8 pixels 
ADD	HL,DE				; pour laisser un bout de tete
LD	(collision_spr0_posy),HL	; je stock Y 

LD	HL,(SPRH_X)			; je prends X du sprite 0 (par defaut gauche)
LD	DE,15				; j'additionne 8 pixels 
ADD	HL,DE				; pour rentrer un peu dans le decors
LD	(collision_spr0_posx),HL	; je stock X

JR COLLISIONS

collision_bas
; *************************************** SPRITE 0 (gauche) *****************************************
LD	HL,(SPRH_Y)			; je prends Y du sprite 0 (par defaut haut)
LD	DE,15				; j'additionne 8 pixels 
ADD	HL,DE				; pour laisser un bout de tete
LD	(collision_spr0_posy),HL	; je stock Y 

LD	HL,(SPRH_X)			; je prends X du sprite 0 (par defaut gauche)
LD	DE,8				; j'additionne 8 pixels 
ADD	HL,DE				; pour rentrer un peu dans le decors
LD	(collision_spr0_posx),HL	; je stock X

JR COLLISIONS



; ***************************** CALCULE DE LA TILE SUR LAQUELLE  **************************************
; ********************************** SE TROUVE SPRITE 0 ET 1 *********************************************
COLLISIONS
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	COLLISIONS_ROM8
	ld		a,(flag_boss_donjon)
	or		a
	ret	nz
	call	rom_off
	ret

	
	
