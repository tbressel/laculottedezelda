; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////           RECUPERATION DES DONNEES DE LINK           ///////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
recuperation_des_donnees
	LD		a,(bankROM_link1)
	LD		(bankROM),a
	call	asic_on
	LD		hl,(SPRH_LINK_ADR)
	LD		(SPRH_ADR),hl
	LD		hl,(SPRH0_X)
	LD		(SPRH_X),hl
	LD		hl,(SPRH0_Y)
	LD		(SPRH_Y),hl
	RET	
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////           GESTION DE LINK          /////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
LINK
	ld		a,(flag_invulnerable)
	or		a
	call	NZ,decompteur_invulnerable
	LD		a,(bankROM_link1)						; on recupère le no de Bank de Link
	LD		(bankROM),a								; on l'envoie dans une variable générale 
	LD		hl,(SPRH_LINK_ADR)						; on recupère le sprh de destination de Link lu dans la table
	LD		(SPRH_ADR),hl							; on l'envoie dans une variable générale
	LD		a,(flag_etape_link1)					; on recupère l'état de Link
	CP		a,1
	JR		z,affiche_link1							; si a=1 on l'affiche
	CP		a,2
	RET		Z										; si a=2 il est déjà affiché on retourne là d'où l'on vient
INIT_LINK1	
	LD		hl,table_init_link						; on met l'adresse de la table d'initialisation de link hl,
	LD		de,VARIABLE_INIT_LINK					; pour l'écrire dans les variables
	LDI												; Lecture de TYPE_LINK_ADR (différent état de Link)
	LDI												; TYPE_LINK_ADR+1
	LDI												; bankROM_link1 (là où sont les sprite harde de Link dans la ROM)
	LDI												
	LDI												; SPRH_LINK_ADR (là où on va envoyer dans l'ASIC)
	LDI												; SPRH_LINK_ADR+1
	LD		de,SPRH0_X_Y_ZOOM						; ensuite on ecrit à cet endroit
	LDI:LDI:LDI
	LDI:LDI:LDI
	LD		de,SPRH1_X_Y_ZOOM						; puis à cet endroit car les adresses ne se suivent pas dans l'ASIC
	LDI:LDI:LDI
	LDI:LDI:LDI
	LD		hl,(TYPE_LINK_ADR)						; on met le type de link dans une variable générale.
	LD		(LINK_ADR),hl
	LD		hl,(SPRH_LINK_ADR)						; on met l'adresse du sprite de destination dans une variable générale.
	LD		(SPRH_ADR),hl
	LD		a,1
	LD		(flag_etape_link1),a					; on met à 1 le flag, pour la prochaine étape.
	LD		a,4	
	LD		(compteur_anim_link),a					; on initialise le compteur d'animation (change tous les 4 sprites)
	RET												; RETour dans la boucle principale.
	
AFFICHE_LINK1
	call	rom_on									; çà sélèctionne la ROM où se trouve Link.
	LD		hl,(LINK_ADR)							; 
	LD		(SPRH0_ANIM_1),hl
	LD		hl,(SPRH0_ANIM_1)
	LD		de,(SPRH_ADR)
	LD		bc,#200
	LDIR
	call	rom_off
	LD		a,2
	LD		(flag_etape_link1),a
	xor		a
	LD		(direction_en_cours),a
	LD		(flag_sprh0),a
	LD		(flag_sprh1),a
	RET
	
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////           GAUCHE          /////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
allez_a_gauche	
gauche
	call 	recuperation_des_donnees
	LD		a,(direction_en_cours)
	CP		a,1							; 1 = gauche. Si on est déjà dans ce sens on recharge pas les sprite
	JR		z,continuer_gauche
	LD		a,1
	LD		(link_bouge),a
	call	rom_on
	LD		hl,(table_type_link)
	LD		(LINK_ADR),hl
	LD		(SPRH0_ANIM_1),hl
	LD		hl,(SPRH0_ANIM_1)
	LD		de,(SPRH_ADR)
	LD		bc,#200
	LDIR
	LD		a,1
	LD		(direction_en_cours),a
	call	rom_off
	xor		a
	LD		(link_bouge),a
	JP		retour_direction
continuer_gauche
		LD		hl,(SPRH0_X)				; récupération des coordonnées en X de link.
		ld		de,(vitesse_link_gauche)
		add		hl,de
		LD		(SPRH0_X),hl				; on sauve la nouvelle coordonée dans les deux
		LD		(SPRH1_X),hl				; animations de link (j'utilise 2 sprites pour link)
		ld		(SPRH_X),hl					; puis dans la variable générale.
		call 	collision_gauche
	
	ld		a,(flag_echelle)
	or		a
	jp 		z,pas_de_test_echelle_gauche
	call 	collision_gauche
	OR		A
	ld		B,142
	LD		A,(ntile_spr0)	
	SBC		A,B
	jp		z,on_affiche_echelle
	ld		a,(flag_sprh4)
	or		a
	call	nz,on_efface_echelle
	
	pas_de_test_echelle_gauche
		ld		B,114						; au delà de 114 on passe pas
		LD		A,(ntile_spr0)	
		OR		A
		SBC		A,B
		CALL	NC,stop_gauche_link			; et là on rétablit les coordonées pour plus avancer.
pas_de_test_de_collision_gauche		
		; test de la collision avec le bord gauche de l'écran
		ld		a,(flag_donjon)
		or		a
		jr		z,test_bord_gauche_hyrule
		
		ld		hl,	(SPRH_X)				; on récupere les coordonnée Y de Link
		LD		DE,(bord_gauche)			; on donne la coordonnée à partir de laquelle 
		OR		A							; on remet les flag à zero
		SBC		HL,DE						; link touche le bord bas de l'écran	
		JP		C,VERS_LA_GAUCHE_LINK		; egale à zéro on va vers le bas
		jr		saut_vers_anim_fin_gauche
	test_bord_gauche_hyrule
		ld		hl,	(SPRH_X)				; on récupere les coordonnée Y de Link
		LD		DE,(bord_gauche)			; on donne la coordonnée à partir de laquelle 
		OR		A							; on remet les flag à zero
		SBC		HL,DE						; link touche le bord bas de l'écran	
		JP		NC,VERS_LA_GAUCHE_LINK		; egale à zéro on va vers le bas
		


	saut_vers_anim_fin_gauche
		LD		a,(compteur_anim_link)		; un compteur pour déterminer pendant combien de
		dec		a							; boucle link va garder le même mouvement
		LD		(compteur_anim_link),a
		CP		a,0							; quand c'est fini Link change de mouvement.
		JP		z,reinit_anim_link			; et on jump à sa ré initialisation
		JP		retour_direction



; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////            DROITE            /////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
allez_a_droite
droite
	call 	recuperation_des_donnees
	LD		a,(direction_en_cours)
	CP		a,2						; 1 = gauche. Si on est déjà dans ce sens on recharge pas les sprite
	JP		z,continuer_droite
	LD		a,1
	LD		(link_bouge),a
	call	rom_on
	LD		hl,(table_type_link)
	LD		a,h							; 1 nop
	add		a,#02						; 2 nops
	LD		h,a							; 1 nop
	LD		(LINK_ADR),hl
	LD		(SPRH0_ANIM_1),hl
	LD		hl,(SPRH0_ANIM_1)
	LD		de,(SPRH_ADR)
	LD		bc,#200
	LDIR
	LD		a,2
	LD		(direction_en_cours),a
	call	rom_off
	xor		a
	LD		(link_bouge),a
	JP		retour_direction
continuer_droite
		LD		hl,(SPRH0_X)
		ld		de,(vitesse_link_droite)
		add		hl,de
		LD		(SPRH0_X),hl
		LD		(SPRH1_X),hl
		ld		(SPRH_X),hl
	
	ld		a,(flag_echelle)
	or		a
	jp 		z,pas_de_test_echelle_droite	
	call 	collision_droite
	OR		A
	ld		B,142
	LD		A,(ntile_spr0)	
	SBC		A,B
	jp		z,on_affiche_echelle
	ld		a,(flag_sprh4)
	or		a
	call	nz,on_efface_echelle
	pas_de_test_echelle_droite	
		call	 collision_droite
		ld		B,114
		LD		A,(ntile_spr0)
		OR		A
		SBC		A,B
		CALL	NC,stop_droite_link
	pas_de_test_de_collision_droite
		
		
		LD		A,(ntile_spr0)	
		cp		a,8										; on test si on touche une porte tile 001
		JP		Z,affiche_boutique
		ld		a,(flag_donjon)
		or		a
		jr		z,on_saut_le_test_cave
		LD		A,(ntile_spr0)	
		cp		a,9										; on test si on touche une porte tile 001
		Jr		Z,vers_la_cave_config	
		on_saut_le_test_cave
		
		
	; test de la collision avec le bord droite de l'écran
		ld			hl,(SPRH_X)								; on récupere les coordonnée Y de Link
		LD			DE,(bord_droit)							; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
		OR			A										; on remet les flag à zero
		SBC			HL,DE									
		JP			NC,VERS_LA_DROITE_LINK					; egale à zéro on va vers le bas
		LD			a,(compteur_anim_link)
		dec			a
		LD			(compteur_anim_link),a
		;CP			a,0
		JP			z,reinit_anim_link
		JP			retour_direction
	vers_la_cave_config
		ld		a,1
		ld		(flag_cave),a
		JP		VERS_LE_BAS_LINK
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////            HAUT            /////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
allez_en_haut
HAUT
	call 	recuperation_des_donnees		; comee d'habitude on récupère les valeurs de bank et coordonnées de sprite.
	LD		a,(direction_en_cours)			; on test la direction qui est en cours d'exectution
	CP		a,3								; 3 = haut. Si on est déjà dans ce sens on recharge pas les sprites
	JP		z,continuer_haut				; du coup on continue vers le haut avec les sprites actuels.
	LD		a,1								; on met le flag à 1 comme quoi link est en mouvement.
	LD		(link_bouge),a
	call	rom_on							; si on arrive là c'ets qu'on était en cours d'une autre direction 
	LD		hl,(table_type_link)			; donc on lit l'adresse de la table d'adresses des sprites de link
	LD		a,h							
	add		a,#06							; on va chercher 6 octets plus loin
	LD		h,a								; pour tomber sur l'adresse du sprite haut de link
	LD		(LINK_ADR),hl					; on la place dans une variable générale
	LD		(SPRH0_ANIM_1),hl				; et dans la 1ere animation du sprite
	LD		hl,(SPRH0_ANIM_1)
	LD		de,(SPRH_ADR)
	LD		bc,#200
	LDIR
	call	rom_off
	LD		a,3
	LD		(direction_en_cours),a			; on indique que la direction en cours est à présent vers la haut
	xor 	a								
	LD		(link_bouge),a
	JP		retour_direction
CONTINUER_HAUT
; cas particulier Zelda dans monstre 1 à la fin du jeu
	ld		a,(flag_etape_du_monstre1)					; on recupère l'état du monstre 1 (incarné par ZELDA à la fin du jeu)
	cp		a,5											; (etape defonce_cul_zelda), çà permet d'empecher la routine monstre 1
	JP		z,retour_direction							; d'être mobile, mais de rester fixe

; mise à jour de la position de Link
	LD		hl,(SPRH0_Y)								; coordonnée Y 
	ld		de,(vitesse_link_haut)						; vitesse de déplacement initialisé par les champignon
	add		hl,de
	LD		(SPRH0_Y),hl								; resulat sauvegardé
	LD		(SPRH1_Y),hl
	ld		(SPRH_Y),hl

; mise à jour de la position du radeau et de link su le radeau
	ld		a,(flag_radeau)								; a t'on le radeau de link ?
	or		a											; si le flag est toujours à zéro c'est qu'on ne l'a pas
	jr		z,on_a_pas_de_radeau						; donc on zappe toute la partie utilisé pour le radeau
			
	ld		a,(radeau_en_cours)
	or		a
	jr		z,on_ne_deplace_pas_le_radeau_haut
	inc		l
	inc		l
	inc		l
	inc		l
	inc		l
	inc		l
	ld			(SPRH3_Y),hl
	on_ne_deplace_pas_le_radeau_haut
	on_a_pas_de_radeau	
		; test de la collision avec le bord haut de l'écran
			ld		hl,(SPRH_Y)						; on récupere les coordonnée Y de Link
			LD		DE,(bord_haut)					; on donne la coordonnée à partir de laquelle link touche
			OR		A								; on remet les flag à zero
			SBC		HL,DE							; le bord haut de l'écran
			JP		C,VERS_LE_HAUT_LINK				; egale à zéro on va vers le haut

		; test de la collision avec une ile de terre
			ld		a,(flag_ocean)					; est on dans la zone océan du jeu ?
			or		a								; si oui on empêche l'utilisation du radeau
			jr		nz,pas_de_radeau_dans_l_ocean		; en zappant le test de collision de celui ci
			ld		a,(flag_ocean)					; est on dans la zone océan du jeu ?
			or		a								; si oui on empêche l'utilisation du radeau
			jr		nz,pas_de_radeau_dans_l_ocean		; en zappant le test de collision de celui ci
	; test de la collision avec le décors
	call 	collision_haut					; si on est pas dans l'océan alors on continue normalement
	LD		A,(ntile_spr0)	
	cp		a,6								; on test si on touche une porte tile 006
	CALL	Z,LINK_RADEAU					; si oui on va commencer à initialiser le radeau				
	LD		a,(radeau_en_cours)
	or		a
	Jr		nZ,pas_de_test_de_collision_haut
pas_de_radeau_dans_l_ocean

	ld		a,(flag_echelle)
	or		a
	jp 		z,pas_de_test_echelle_haut	
	call 	collision_haut
	OR		A
	ld		B,142
	LD		A,(ntile_spr0)	
	SBC		A,B
	jp		z,on_affiche_echelle
	ld		a,(flag_sprh4)
	or		a
	call	nz,on_efface_echelle
pas_de_test_echelle_haut
	call 	collision_haut
	OR		A
	ld		B,114
	LD		A,(ntile_spr0)	
	SBC		A,B
	CALL	NC,stop_haut_link
	
pas_de_test_de_collision_haut
	

	; test de la collision avec une tile passage secet ou marchand
	OR 		A
	LD		A,(ntile_spr0)	
	cp		a,1								; on test si on touche une porte tile 001
	JP		Z,affiche_boutique
	cp		a,34								; on test si on touche une porte tile 001
	JP		Z,affiche_boutique
	cp		a,63								; on test si on touche une porte tile 001
	JP		Z,affiche_boutique
	cp		a,4								; on test si on touche une porte tile 001
	JP		Z,affiche_boutique
	cp		a,5								; on test si on touche une porte tile 001
	JP		Z,affiche_boutique
	cp		a,49								; on test si on touche une porte tile 001
	JP		Z,affiche_boutique
	; test de la collision avec une tile donjon
	OR 		A
	LD		A,(ntile_spr0)	
	cp		a,071							; on test si on touche une porte tile 071 (porte fermé)
	JP		Z,entree_donjon	
	cp		a,072							; on test si on touche une porte tile 072 (porte ouverte)
	JP		Z,entree_donjon	
	; test si on est dans l'ocean ou pas
	ld		a,(flag_ocean)					; on test voir si on est dans la partie ocean du jeu
	or		a								; si on y est pas 
	jr		z,on_est_pas_dans_l_ocean		; on zappe le test de tile qui transforme link quand il monte sur une ile
	OR 		A
	LD		A,(ntile_spr0)	
	cp		a,007							; on test si on touche une tile 007 qui déclanche la sorte de l'eau
	call	Z,link_sur_terre				; et là link se transforme	
on_est_pas_dans_l_ocean	
	
	
	

	; compteur d'animation delink
	LD		a,(compteur_anim_link)
	dec		a
	LD		(compteur_anim_link),a
	;CP		a,0
	JP		z,reinit_anim_link
	JP		retour_direction
	
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////            BAS            /////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
allez_en_bas
BAS
	call 	recuperation_des_donnees
	LD		a,(direction_en_cours)
	CP		a,4										; 4 = bas. Si on est déjà dans ce sens ...
	JR		z,continuer_bas							;  on recharge pas les sprite alors on continue vers le bas
	LD		a,1										
	LD		(link_bouge),a							; le flag à 1 pour notifier que link bouge
	call	rom_on
	LD		hl,(table_type_link)					; HL = l'adresse en ROM de départ des sprites du type de link
	LD		a,h										; l'octet du poid fort de l'adresse dans A
	add		a,#04									; on additionne 4 pour être #0400 octet plus loin, 
	LD		h,a										; et pointer sur le link bas
	LD		(LINK_ADR),hl							; et on stock cette adresse 
	LD		(SPRH0_ANIM_1),hl						
	LD		hl,(SPRH0_ANIM_1)						; ... qui sert à être copier dans 2 sprites hards
	LD		de,(SPRH_ADR)							; pour avoir les 2 anim d'un coup
	LD		bc,#200
	LDIR
	LD		a,4
	LD		(direction_en_cours),a					; on met  à 4 (bas) la direction en cours
	call	rom_off
	xor 	a
	LD		(link_bouge),a
	JP		retour_direction
	
CONTINUER_BAS
	; mise à jour de la position de Link
	LD		hl,(SPRH0_Y)							; recuperation de la position actuelle Y de Link
	ld		de,(vitesse_link_bas)
	add		hl,de								; incrémenté de 2
	LD		(SPRH0_Y),hl							
	LD		(SPRH1_Y),hl							; et envoyé dans les 2 sprites d'animation pour les mettre à jour
	ld		(SPRH_Y),hl								; on envoyé également dans la variable générale de Y
	
	; mise à jour de la position du radeau et de link su le radeau
	ld		a,(flag_radeau)						; radeau ou pas radeau ?
	or		a										; si pas radeau ...
	jr		z,on_a_pas_de_radeau_2					; alors on calcule rien
	ld		a,(radeau_en_cours)						; radeau ou pas radeau ?
	or		a										; si pas radeau ...
	jr		z,on_ne_deplace_pas_le_radeau_bas		; alors on calcule rien
	inc		l										; sinon on positionne le radeau sous les pieds de Link
	inc		l
	inc		l
	inc		l
	inc		l
	inc		l
	ld		(SPRH3_Y),hl							; et on envoye les coordonnées au sprites hard du radeau
on_ne_deplace_pas_le_radeau_bas
on_a_pas_de_radeau_2
	; test de la collision avec le bord bas de l'écran
	ld		a,(flag_boutique)
	or		a
	jr		nz,on_saute_le_test_bas_hyrule
	ld		a,(flag_donjon)						
	or		a
	jp		nz,test_collision_bord_donjon
		
retour_test_collision_bord_donjon
	
	ld		hl,	(SPRH_Y)							; on récupere les coordonnée Y de Link
	LD		DE,(bord_bas)								; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	OR		A		
	SBC		HL,DE									
	JP		NC,VERS_LE_BAS_LINK							; egale à zéro on va vers le bas
on_saute_le_test_bas_hyrule

	; test de la collision avec l'eau
	call 	collision_bas							; on récupère le no de tile où se trouve link
	LD		A,(ntile_spr0)	
	cp		a,70									; on test si on touche un ponton 
	CALL	Z,LINK_RADEAU							; si oui alors on va prends le radeau
	LD		a,(radeau_en_cours)						; par conte ...
	or		a										; si un radeau est déj en cous on zap le test collision decors
	JR		NZ,pas_de_test_de_collision_bas


ld		a,(flag_echelle)
	or		a
	jp 		z,pas_de_test_echelle_bas	
	call 	collision_bas
	OR		A
	ld		B,142
	LD		A,(ntile_spr0)	
	SBC		A,B
	jp		z,on_affiche_echelle
	ld		a,(flag_sprh4)
	or		a
	call	nz,on_efface_echelle
pas_de_test_echelle_bas

	; test de la collision avec le décort
	call 	collision_bas
	ld		B,114									; toutes les tiles supérieures à 115 sont des murs
	LD		A,(ntile_spr0)							; on récupère le numéros de la tiles sur laquelle Link se trouve APRES update
	OR		A	
	SBC		A,B										
	CALL	NC,stop_bas_link						; si c'est le cas, link ne va pas plus loin
pas_de_test_de_collision_bas
	call 	collision_bas							; on test la collision avec le décort
	OR		A
	LD		A,(ntile_spr0)	
	cp		a,6										; on test si on touche une porte tile 001
	CALL	Z,link_radeau_off						; si c'est le cas, link ne va pas plus loin
	LD		A,(ntile_spr0)	
	cp		a,8									; on test si on touche une porte tile 001
	JP		Z,affiche_boutique
	ld		a,(flag_boutique)						
	or		a
	jr		nz,collision_bord_boutique

	
	radeau_bas_deja_off	
		; test si on est dans l'ocean ou pas
	ld		a,(flag_ocean)
	or		a
	jr		z,on_est_pas_dans_l_ocean2
	OR 		A
	LD		A,(ntile_spr0)	
	cp		a,073											; on test si on touche une porte tile 072
	call	Z,link_dans_l_eau	
on_est_pas_dans_l_ocean2	

	
collision_bord_boutique
	ld		a,(flag_boutique)						
	or		a
	jr		z,pas_de_test_bord_boutique
	ld		hl,	(SPRH_Y)							; on récupere les coordonnée Y de Link
	LD		DE,(bord_bas)							; on donne la coordonnée à partir de laquelle link touche le bord bas de l'écran
	OR		A										; on remet les flag à zero
	SBC		HL,DE									
	JP		NC,RETOUR_DE_BOUTIQUE							; egale à zéro on va vers le bas
pas_de_test_bord_boutique
; compteur d'animation delink
	LD		a,(compteur_anim_link)					; Link se déplace avec le même sprite toutes les X frame
	dec		a										; que l'on décrémente
	LD		(compteur_anim_link),a					; puis que l'on sauvegarde
	;CP		a,0										
	JP		z,reinit_anim_link						; si égale à zéro alors on le réinitialise
	JP		retour_direction
	


reinit_anim_link
	LD		a,4
	LD		(compteur_anim_link),a				; compteur d'animation de link fixé à 4
	LD		a,(flag_sprh0)						; on lit l'état du flag du sprite hard 0
	or		a									; s'il était à 1 ...
	JR	 	nz,sprh1_zoom_on						; bah on inverse avec le sprite hard 1
	or		a									; s'il était à 0 ...
	JR		z,sprh1_zoom_off					; c'est
	
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////           ALTERNANCE DES ZOOM SPRITES HARD  DE LINK           /////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
sprh1_zoom_on
	ld		a,(radeau_en_cours)
	or		a
	jp		nz,retour_direction
	xor 	a
	LD		(SPRH0_ZOOM),a
	LD		(flag_sprh0),a
	LD		a,(SPRH_TYPE_ZOOM)
	LD		(SPRH1_ZOOM),a
	LD		a,1
	LD		(flag_sprh1),a
	JP		retour_direction
sprh1_zoom_off
	ld		a,(radeau_en_cours)
	or		a
	jp		nz,retour_direction
	xor		a
	LD		(SPRH1_ZOOM),a
	LD		(flag_sprh1),a
	LD		a,(SPRH_TYPE_ZOOM)
	LD		(SPRH0_ZOOM),a
	LD		a,1
	LD		(flag_sprh0),a
	JP		retour_direction
	
	
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////           LINK RENCONTRE LE DECORS ET S'ARRETE           ///////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
stop_bas_link
	ld		a,(flag_donjon)
	or		a
	call	nz,test_portes_donjon

	ld		hl,(SPRH_Y)
	ld		de,(vitesse_link_Y)
	or		a
	sbc		hl,de
	call	asic_on
	ld		(SPRH0_Y),hl
	ld		(SPRH1_Y),hl
	RET
stop_gauche_link
	ld		a,(flag_donjon)
	or		a
	call	nz,test_portes_donjon
	or		a
	ld		hl,(SPRH_X)
	ld		de,(vitesse_link_X)
	add		hl,de
	call	asic_on
	ld		(SPRH0_X),hl
	ld		(SPRH1_X),hl
	RET
stop_droite_link
	ld		a,(flag_donjon)
	or		a
	call	nz,test_portes_donjon
	or		a
	ld		hl,(SPRH_X)
	ld		de,(vitesse_link_X)
	sbc		hl,de
	call	asic_on
	ld		(SPRH0_X),hl
	ld		(SPRH1_X),hl
	RET
stop_haut_link
	ld		a,(flag_donjon)
	or		a
	call	nz,test_portes_donjon
	or		a
	ld		hl,(SPRH_Y)
	ld		de,(vitesse_link_Y)
	add		hl,de
	call	asic_on
	ld		(SPRH0_Y),hl
	ld		(SPRH1_Y),hl
	RET
	
	
init_mort_link
	
	LD		a,#CD									; sinon on créer l'venement monstre 1
	LD		(event_gameover),a
	LD		hl,gameover
	LD		(event_gameover+1),hl
	JP		MAIN_BOUCLE
	


; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
LINK_RADEAU
	ld		a,(flag_radeau)							; on met le flag radeau à 1 pour pouvoir le déplcacer
	or		a
	RET	Z	; si c'est déjà le cas alors on retourne d'ou l'on vient
	ld		a,(radeau_en_cours)							; on met le flag radeau à 1 pour pouvoir le déplcacer
	or		a
	RET		NZ	; si c'est déjà le cas alors on retourne d'ou l'on vient

	; on automatise le déplacement du radeau et de link
	xor		a								; on efface le test du clavier
	ld		(event_testclavier),a			; pour automatiser avec une valeur fixe
	ld		(event_testclavier+1),a			; le trajet du radeau et de link
	ld		(event_testclavier+2),a			; pour faire une mini animation sans qu'on puisse la controler
	ld		a,(direction_en_cours)			; puis selon notre direction, 
	cp		a,4
	jr		z,test_clavier_bas				; on va vers le bas tout le temps
	ld		a,#FE							; sinon c'est qu'on va vers le haut tout le temps donc, 
	ld		(resultat_test_de_touche),a			; on affiche #FE juste après LD A,
	jr		fin_test_clavier_sens			; les auto modif terminées on fini la config propre aux deux directions
test_clavier_bas
	ld		a,#FD							; on arrive ici si on automatique vers le bas
	ld		(resultat_test_de_touche),a			; on affiche #FD juste après LD A,
fin_test_clavier_sens
	ld		a,1
	ld		(radeau_en_cours),a				; on indique que le radeau est en cours
	LD		hl,(SPRH0_X)					; on met les coordonnées de link et son radeau à jour
	ld		(SPRH3_X),hl
	ld		hl,(SPRH0_Y)
	ld		(SPRH3_Y),hl
	
	LD		a,25							; on recupère le no de Bank des objets
	LD		(bankROM),a						; on l'envoie dans une variable générale 
	Call 	rom_on
	LD		hl,SPRH_RADEAU_ADR
	ld		de,SPRH3_ADR
	LD		bc,#100
	LDIR
	call 	rom_off
	ld		a,9
	ld		(SPRH3_ZOOM),a					; on allume le sprite hard
	ld		a,1
	LD		(flag_sprh3),a					; on signale qu'il est allumé
	RET
	
	

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
link_radeau_off
	ld		a,(radeau_en_cours)
	or		a
	RET		Z
	ld		a,#CD
	ld		(event_testclavier),a
	ld		hl,test_du_clavier
	ld		(event_testclavier+1),hl
	call	asic_on
	xor		a
	ld		(radeau_en_cours),a
	ld		(SPRH3_ZOOM),a
	LD		(flag_sprh3),a
	call	asic_off
	ret
	
link_radeau_on
	call	asic_on
	ld		a,9
	ld		(SPRH3_ZOOM),a
	ld		a,1
	LD		(flag_sprh3),a
	call	asic_off
	ret

link_sur_terre
	LD		hl,LINK_H1						; on met le type de link dans une variable générale.
	LD		(LINK_ADR),hl
	ld		de,Table_type_link
	ld		hl,Table_type_link+56
	ld		bc,24	
	LDIR
	call	Link_Update
	call	fire1_on
	call	fire2_on
	ret

	
link_dans_l_eau
	LD		hl,LINK3_B1						; on met le type de link dans une variable générale.
	LD		(LINK_ADR),hl
	ld		hl,Table_type_link+40
	ld		de,Table_type_link
	ld		bc,16	
	LDIR
	call	Link_Update
	call	fire1_off
	call	fire2_off
	RET

; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////  DECOMPTEUR INVULNERABILITE  ///////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
decompteur_invulnerable
	ld		a,(compteur_invulnerable)
	dec		a
	ld		(compteur_invulnerable),a
	jp		z,reset_compteur_invulnerable
	RET
reset_compteur_invulnerable
	xor		a
	ld		(flag_invulnerable),a
	RET

	