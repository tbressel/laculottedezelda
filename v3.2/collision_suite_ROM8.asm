; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

on_fait_reculer_le_monstre_ROM8
			ld		a,1
			ld		(flag_recul_en_cours),a
			ld		a,(direction_du_recul)
			cp		a,1
			jp		z,recul_gauche_du_monstre
			cp		a,2
			jp		z,recul_droite_du_monstre
			cp		a,3
			jp		z,recul_haut_du_monstre
			cp		a,4
			jp		z,recul_bas_du_monstre
		
			RET
			
			
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	recul_gauche_du_monstre
			ld		a,(compteur_de_recul)
			dec		a
			ld		(compteur_de_recul),a
			cp		a,0
			jp		z,fin_du_recul
				ld		hl,(SPRH_X_recul)					; on recupère les coordonnées X du sprite qui vient d'être touché
				dec		hl							; on recul d'un pixel
				dec		hl							; on recul d'un pixel
				dec		hl							; on recul d'un pixel
				dec		hl							; on recul d'un pixel
				
				ld		(SPRH_X),hl					; on stock la nouvelle valeur
				ld		(SPRH_X_recul),hl
				call calcul_du_reculX
				
			collision_recul_gauche
					LD		HL,(SPRH_X)			; je prends X du sprite 0 (par defaut gauche)
					LD		DE,0				; j'additionne 8 pixels 
					ADD		HL,DE				; pour laisser un bout de tete
					LD		(collision_spr0_posx),HL	; je stock X

					ld		hl,(sprh_y_recul)
					LD		(SPRH_Y),hl			; je prends Y du sprite 0 (par defaut haut)
					LD		DE,12				; je TEST LE MILEU DU SPRITEdonnes (1 pixel = 1 coordonnee)
					ADD		HL,DE				; pour tester le bas du sprite
					LD		(collision_spr0_posy),HL	; je stock Y	
					CALL	 COLLISIONS_ROM8
					or		a
					ld		B,114
					ld		A,(ntile_spr0)	
					SBC		A,B
					JP		NC,on_retablit_calcul_gauche
					
				; test de la collision avec le bord gauche de l'écran
					ld		hl,(SPRH_X_recul)							; on récupere les coordonnée Y de Link
					OR		A										; on remet les flag à zero
					LD		DE,#0016								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
					SBC		HL,DE									
					JP		C,on_retablit_calcul_gauche							; egale à zéro on va vers le bas	
					ret
			on_retablit_calcul_gauche
				ld		hl,(SPRH_X_recul)					; on recupère les coordonnées X du sprite qui vient d'être touché
				INC		hl							; on recul d'un pixel
				INC		hl							; on recul d'un pixel
				INC		hl							; on recul d'un pixel
				INC		hl							; on recul d'un pixel
				
				ld		(SPRH_X),hl					; on stock la nouvelle valeur
				ld		(SPRH_X_recul),hl
				call calcul_du_reculX
				
				JP	changement_direction
				
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				
				
	recul_droite_du_monstre
			ld		a,(compteur_de_recul)
			dec		a
			ld		(compteur_de_recul),a
			cp		a,0
			jp		z,fin_du_recul
				ld		hl,(SPRH_X_recul)					; on recupère les coordonnées X du sprite qui vient d'être touché
				inc		hl							; on recul d'un pixel
				inc		hl							; on recul d'un pixel
				inc		hl							; on recul d'un pixel
				inc		hl							; on recul d'un pixel
				
				
				ld		(SPRH_X),hl					; on stock la nouvelle valeur
				ld		(SPRH_X_recul),hl
				call calcul_du_reculX
		collision_recul_droite
				LD	HL,(SPRH_X)			; je prends X du sprite 0 (par defaut gauche)
LD	DE,31				; j'additionne 48 pixels
ADD	HL,DE				; pour me situer a droite
LD	(collision_spr0_posx),HL	; je stock X

ld		hl,(sprh_y_recul)
					LD		(SPRH_Y),hl			; je prends Y du sprite 0 (par defaut haut)
LD	DE,12				; j'additionne 8 pixels 
ADD	HL,DE				; pour laisser un bout de tete
LD	(collision_spr0_posy),HL	; je stock Y
					CALL	 COLLISIONS_ROM8
					or		a
					ld		B,114
					ld		A,(ntile_spr0)	
					SBC		A,B
					JP		NC,on_retablit_calcul_droite
					
				; test de la collision avec le bord droite de l'écran
	ld		de,	(SPRH_X_recul)							 ;on récupere les coordonnée Y de Link
	OR		A										 ;on remet les flag à zero
	LD		hl,#01d0								 ;on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC	HL,DE									
	JP		C,on_retablit_calcul_droite						;	 egale à zéro on va vers le bas
				ret
				on_retablit_calcul_droite
				ld		hl,(SPRH_X_recul)					; on recupère les coordonnées X du sprite qui vient d'être touché
				DEC		hl							; on recul d'un pixel
				DEC		hl							; on recul d'un pixel
				dEC		hl							; on recul d'un pixel
				DEC		hl							; on recul d'un pixel
				
				ld		(SPRH_X),hl					; on stock la nouvelle valeur
				ld		(SPRH_X_recul),hl
				call calcul_du_reculX
				
				JP	changement_direction
	
	
	
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	recul_haut_du_monstre
			ld		a,(compteur_de_recul)
			dec		a
			ld		(compteur_de_recul),a
			cp		a,0
			jp		z,fin_du_recul
				ld		hl,(SPRH_Y_recul)					; on recupère les coordonnées X du sprite qui vient d'être touché
				dec		hl							; on recul d'un pixel
				dec		hl							; on recul d'un pixel
				dec		hl							; on recul d'un pixel
				
				
				ld		(SPRH_Y),hl					; on stock la nouvelle valeur
				ld		(SPRH_Y_recul),hl
				call calcul_du_reculY
		collision_recul_haut
LD	HL,(SPRH_Y)			; je prends Y du sprite 0 (par defaut haut)
LD	DE,0				; j'additionne 8 pixels 
ADD	HL,DE				; pour laisser un bout de tete
LD	(collision_spr0_posy),HL	; je stock Y 

ld	hl,(sprh_x_recul)
LD	(SPRH_X),hl			; je prends X du sprite 0 (par defaut gauche)
LD	DE,15				; j'additionne 8 pixels 
ADD	HL,DE				; pour rentrer un peu dans le decors
LD	(collision_spr0_posx),HL	; je stock X
					CALL	 COLLISIONS_ROM8
					or		a
					ld		B,114
					ld		A,(ntile_spr0)	
					SBC		A,B
					JP		NC,on_retablit_calcul_haut
					
		; test de la collision avec le bord haut de l'écran
	ld		hl,	(SPRH_Y_recul)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		DE,#005A							; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE
	JP		C,on_retablit_calcul_haut							; egale à zéro on va vers le bas
			
				ret
				
				on_retablit_calcul_haut
				ld		hl,(SPRH_Y_recul)					; on recupère les coordonnées X du sprite qui vient d'être touché
				INC		hl							; on recul d'un pixel
				INC		hl							; on recul d'un pixel
				INC		hl							; on recul d'un pixel
				
				ld		(SPRH_Y),hl					; on stock la nouvelle valeur
				ld		(SPRH_Y_recul),hl
				call calcul_du_reculY
				
				JP	changement_direction
	
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	recul_bas_du_monstre
			ld		a,(compteur_de_recul)
			dec		a
			ld		(compteur_de_recul),a
			cp		a,0
			jp		z,fin_du_recul
				ld		hl,(SPRH_Y_recul)					; on recupère les coordonnées X du sprite qui vient d'être touché
				inc		hl							; on recul d'un pixel
				inc		hl							; on recul d'un pixel
				inc		hl							; on recul d'un pixel
				
				
				ld		(SPRH_Y),hl					; on stock la nouvelle valeur
				ld		(SPRH_Y_recul),hl
				call calcul_du_reculY
		collision_recul_bas
LD	HL,(SPRH_Y)			; je prends Y du sprite 0 (par defaut haut)
LD	DE,15				; j'additionne 8 pixels 
ADD	HL,DE				; pour laisser un bout de tete
LD	(collision_spr0_posy),HL	; je stock Y 


ld	hl,(sprh_x_recul)
LD	(SPRH_X),hl			; je prends X du sprite 0 (par defaut gauche)
LD	DE,8				; j'additionne 8 pixels 
ADD	HL,DE				; pour rentrer un peu dans le decors
LD	(collision_spr0_posx),HL	; je stock X
					CALL	 COLLISIONS_ROM8
					or		a
					ld		B,114
					ld		A,(ntile_spr0)	
					SBC		A,B
					JP		NC,on_retablit_calcul_bas
					
; test de la collision avec le bord bas de l'écran
	ld		de,(SPRH_Y_recul)							; on récupere les coordonnée Y de Link
	OR		A										; on remet les flag à zero
	LD		hl,#00EB								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	SBC		HL,DE									
	JP		C,on_retablit_calcul_bas							; egale à zéro on va vers le bas

				ret
		on_retablit_calcul_bas
				ld		hl,(SPRH_Y_recul)					; on recupère les coordonnées X du sprite qui vient d'être touché
				DEC		hl							; on recul d'un pixel
				DEC		hl							; on recul d'un pixel
				DEC		hl							; on recul d'un pixel
				
				ld		(SPRH_Y),hl					; on stock la nouvelle valeur
				ld		(SPRH_Y_recul),hl
				call calcul_du_reculY
				
				JP	changement_direction
	