; ********************* Calcule de la ligne de tile sur laquelle se trouve la bombe *****************


collision_bombe_gauche
; *************************************** SPRITE 0 *****************************************
LD	HL,(SPRH3_X)					; je prends X du sprite 0 (par defaut gauche)
LD	DE,8							; j'additionne 8 pixels 
ADD	HL,DE							; pour laisser un bout de tete
LD	(collision_spr3_posx),HL		; je stock X

LD	HL,(SPRH3_Y)					; je prends Y du sprite 0 (par defaut haut)
LD	DE,15							; je TEST LE MILEU DU SPRITEdonnes (1 pixel = 1 coordonnee)
ADD	HL,DE							; pour tester le bas du sprite
LD	(collision_spr3_posy),HL		; je stock Y	

ld		a,(flag_donjon)
or		a
Jp 		Z,COLLISIONS_BOMBE
LD		hl,#107D						; design une tile de grotte donjon haut gauche (10) et droite (124)
ld		(no_tile_a_ecrire2),hl			; utilisé dans hyrule
ld		hl,tile_grotte_gauche_donjon_adr
ld 		(tile_a_ecrire2),hl

Jr COLLISIONS_BOMBE


collision_bombe_droite
; *************************************** SPRITE 0 *****************************************
LD	HL,(SPRH3_X)			; je prends X du sprite 0 (par defaut gauche)
LD	DE,30				; j'additionne 48 pixels
ADD	HL,DE				; pour me situer a droite
LD	(collision_spr3_posx),HL	; je stock X

LD	HL,(SPRH3_Y)			; je prends Y du sprite 0 (par defaut haut)
LD	DE,15				; j'additionne 8 pixels 
ADD	HL,DE				; pour laisser un bout de tete
LD	(collision_spr3_posy),HL	; je stock Y

ld		a,(flag_donjon)
or		a
Jr 		Z,COLLISIONS_BOMBE
LD		hl,#0F00						; design une tile de grotte donjon haut gauche (11) et droite (12)
ld		(no_tile_a_ecrire2),hl			; utilisé dans hyrule
ld		hl,tile_grotte_droite_donjon_adr
ld 		(tile_a_ecrire2),hl


JR COLLISIONS_BOMBE


collision_bombe_haut
; *************************************** SPRITE 0 (gauche) *****************************************
LD	HL,(SPRH3_Y)			; je prends Y du sprite 0 (par defaut haut)
LD	DE,0				; j'additionne 8 pixels 
ADD	HL,DE				; pour laisser un bout de tete
LD	(collision_spr3_posy),HL	; je stock Y 

LD	HL,(SPRH3_X)			; je prends X du sprite 0 (par defaut gauche)
LD	DE,15				; j'additionne 8 pixels 
ADD	HL,DE				; pour rentrer un peu dans le decors
LD	(collision_spr3_posx),HL	; je stock X

ld		a,(flag_donjon)
or		a
Jr 		Z,COLLISIONS_BOMBE
LD		hl,#0C0B						; design une tile de grotte donjon haut gauche (11) et droite (12)
ld		(no_tile_a_ecrire2),hl			; utilisé dans hyrule
ld		hl,tile_grotte_haute_donjon_adr
ld 		(tile_a_ecrire2),hl
JR 		COLLISIONS_BOMBE



collision_bombe_bas
; *************************************** SPRITE 0 (gauche) *****************************************
LD	HL,(SPRH3_Y)			; je prends Y du sprite 0 (par defaut haut)
LD	DE,15				; j'additionne 8 pixels 
ADD	HL,DE				; pour laisser un bout de tete
LD	(collision_spr3_posy),HL	; je stock Y 

LD	HL,(SPRH3_X)			; je prends X du sprite 0 (par defaut gauche)
LD	DE,8				; j'additionne 8 pixels 
ADD	HL,DE				; pour rentrer un peu dans le decors
LD	(collision_spr3_posx),HL	; je stock X

ld		a,(flag_donjon)
or		a
JP 		Z,COLLISIONS_BOMBE
LD		hl,#0E0D						; design une tile de grotte donjon haut gauche (13) et droite (14)
ld		(no_tile_a_ecrire2),hl			; utilisé dans hyrule
ld		hl,tile_grotte_basse_donjon_adr
ld 		(tile_a_ecrire2),hl
JR COLLISIONS_BOMBE



; ***************************** CALCULE DE LA TILE SUR LAQUELLE  **************************************
; ********************************** SE TROUVE SPRITE 0 ET 1 *********************************************
COLLISIONS_BOMBE
LD	H,0
LD	L,0
LD	HL,(collision_spr3_posy)	; exemple si le SPRITE 0 est teste sur la ligne Y=116 (#74)
SRL H:RR L				; disive par 2
SRL H:RR L				; divise par 4
SRL H:RR L				; divise par 8
SRL H:RR L				; divise par 16
				
; dans l'exemple on obtient 8, on est quelques part dans la 8eme ligne de maptile
		;MAIS on a un hud qui prend deja l'equivalent de 80 tiles soit 5 lignes de haut
	; Il faut les soustraires pour corresponde au ligne de la map tile
;ld d,0
;LD	DE,5
;SBC	HL,DE		; on est en fait au début de la 3eme ligne de la tile map


; Il faut se placer maintenant au debut de ces lignes.
; on multiplie  16 pixel (hauteur) par 8 pour le sprite 0
; pour tomber sur la 1ere tile de la 8eme ligne.
; ***************  Multiplication par 16 (A x 16)


; calcule de a x 16 pour le SPRITE 0 (a=5)
					
ADD HL,HL				; on multiplie par 2	
ADD HL,HL				; on multiplie par 4
ADD HL,HL				; on multiplie par 8
ADD HL,HL				; on multiplie par 16
				; le resulatat est dans HL 129 (#81)
				; on est au debut de la 8eme ligne

			; HL contient l'adresse de la 48eme (#30) tile de la maptile en cours


					; c'est a dire le debut de la 3eme ligne
LD (ligne_tile_spr3_posY),HL		; on la sauvegarde l'adresse dans HL



; ****************************************** CALCULE DE LA TILE DES SPRITE 0 ET 1 DANS LE SENS X *************************

; calcule pour le sprite 0 positionne en ligne 130 (#82) 
					
LD	H,0
LD	HL,(collision_spr3_posx)	; on doit diviser A exemple pour HL=130
SRL H:RR L				; disive par 2
SRL H:RR L				; divise par 4
SRL H:RR L				; divise par 8
SRL H:RR L				; divise par 16
SRL H:RR L				; divise par 32
; on obtient 4. 4 tiles plus loin que la tile  de poxY on tombe sur la 5eme tile
LD	DE,(ligne_tile_spr3_posY)

ADD	HL,DE				; on additionne la tiles 120 avec celle trouve donc 6.
					; On est sur la 126eme tile (#7E) de la maptile en cours
					
LD	(ligne_tile_spr3_posX),HL



LD	HL,(PIECE_ACTUELLE)	; on charge dans HL l'adresse de la piece en cours (1ere tile deja calcule)
LD	DE,(ligne_tile_spr3_posX)
ADD	HL,DE			; on additionne à l'adresse du départ de la 1ere tile, la longueur de la tile à lire
ld	bc,#50
SBC	HL,BC


LD	(tile_a_lire_spr3),HL	; HL contient l'adresse de la tile a lire


; ***********************************************************************
; ****************************************** Lire le numero de la tile

call asic_off
	LD		A,(No_BANK)
	CP		a,#C6
	call	z,C6_on
	CP		a,#C7
	call	z,C7_on
	CP		a,#C5
	call	z,C5_on

;sprite 0
	ld	HL,(tile_a_lire_spr3)
	LD	A,(HL)  		; on lit dans A l'octet contenu a l'adresse HL
	LD	(ntile_spr3),A

call	c0_on	; on remet en C0
call asic_on

RET

	
				
				
