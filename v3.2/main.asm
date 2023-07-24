ORG #8000
	DI											; on désactive aussitôt les interruptions
	XOR		A
	LD		(flag_rom),a
	LD 		BC,#DF00+#80:OUT (C),C				; Sélèction de la rom 0
	LD 		BC,#7F00+%10001100:OUT (C),C 		; déconnexion de la ROM supérieure ET inférieure ET écran en mode 0.
	
; /////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////// NETTOYAGE DE LA RAM BANK 0 /////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////

	Xor 	a									; on met 0 dans A
	ld 		hl,#0000							; début à effacer en #0FFF
	ld 		e,l									
	ld 		d,h									
	inc 	de									; on incremente de 1 l'adresse à effacer
	ld 		(hl),a								; et on met 0 dans l'octet de l'adresse 
	LD 		BC,#4000							; sur une longueur de #3000
	ldir	

; /////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////// ON INITIALISE LA PREMIERE INTERRUPTION  ///////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
	ld 		a,#c3			; on met en un JP en #38
	ld 		(#38),a
	call 	int76			; on lance la premiere interruption
	
	
; /////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////// COPIE EN RAM DU PLAYER ///////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////// ET INITIALISATION MUSIQUE ET SFX ///////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
COPIE_RAM_ZIK
	ld		a,3								; sélèction de la banque contenant
	ld		(BankROM),a						; le player pour la musique et les sfx
	call	rom_on
	ld		hl,#C000
	ld		de,PLAYER_ADR_RAM				; adresse de départ du player en RAM 
	ld		bc,LONGUEUR_PLAYER						 
	ldir
	ld		a,4								; sélèction de la banque contenant
	ld		(BankROM),a						; les fichiers d'initialisation du player
	call	rom_on
	ld		hl,#C000
	ld		de,MUSIC_ADR_RAM						; adresse de départ des fichier d'init
	ld		bc,LONGUEUR_MUSIC
	ldir
	PLY_AKG_MANAGE_SOUND_EFFECTS = 1
	ld 		hl,SoundEffects         		; adresse des sfx
	call 	PLY_AKG_InitSoundEffects
	ld 		hl,Music         				; Initialisation
	xor		a
	ld		(save_musique_retour),a 
	call 	PLY_AKG_Init
; /////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////// COPIE DES TILES DU HUD EN RAM ///////////////////////////////////
; /////////////////////////////////////// (MEMOIRE TAMPON) /////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
COPIE_RAM_TILES
	ld		a,15
	ld		(BankROM),a
	call	rom_on
	ld		hl,#C000							; lecture
	ld		de,MEM_TAMPON_HUD					; ecriture
	ld		bc,#1400							; longueur
	LDIR
	ld		a,2							
	ld		(BankROM),a						
	call	rom_on
	CALL 	AFFICHE_HUD
	call	affiche_compteur
	call 	music_on
; /////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////// COPIE PROGRAMME MAIN3 EN RAM ///////////////////////////////////
; /////////////////////////////////////// (BANK 0 #1000) /////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
COPIE_RAM_CODE2
	di
	ld		a,9									; sélèction de la banque contenant
	ld		(BankROM),a							; le player pour la musique et les sfx
	Call	rom_on
	ld		hl,#C000
	ld		de,CODE_PROGRAMME_2					; adresse de départ du player en RAM 
	ld		bc,#2000						 
	ldir
	call	C0_on
	ld		a,12									; sélèction de la banque contenant
	ld		(BankROM),a							; le player pour la musique et les sfx
	Call	rom_on
	ld		hl,#C000
	ld		de,CODE_PROGRAMME_3					; adresse de départ du player en RAM 
	ld		bc,#2000						 
	ldir
	ei
; /////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////// COPIE DES PALLETTES EN RAM   ///////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
	ld		a,19									; sélèction de la banque contenant
	ld		(BankROM),a							; le player pour la musique et les sfx
	Call	rom_on
	call	asic_on
	ld		hl,#c000							; lecture
	ld		de,MEM_TAMPON_PALETTE				; ecriture
	ld		bc,LONGEUR_DES_PALLETTES			; longueur
	LDIR

	
; /////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////// INITIALISATION DU JEU   //////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
	ld		a,8							; sélèction de la banque contenant
	ld		(BankROM),a							; le player pour la musique et les sfx
	Call	rom_on_bank_prog
	call	Initialisation_du_jeu_ROM
; /////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////// CHANGEMENT DE PIECE   ////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
NOUVELLE_PIECE
	call	code_bank2_on
	call	rom_on
	CALL	NETTOYAGE_SPRITES_HARD
	call	rom_off
	call	code_bankx_off
	call	asic_off							; et on coupe les banks ROM
	CALL	AFFICHE_PIECE							; la routine affiche en #c000 	
	call	asic_on
	call	DESACTIVATION_EVENTS
	CALL	AFFICHAGE_LINK
	CALL	ACTIVATION_EVENTS
	call 	rom_off		
	call	asic_on

; ///////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////
; ****************************** BOUCLE PRINCIPALE - DEBUT **************************************
; ///////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////
MAIN_BOUCLE
 LD    B,#F5    ;adresse du port B du PPI
	FRAME0    IN    A,(C)     ;On récupère l'octet contenu sur le port dans A
    RRA              ;On fait une rotation afin de récupérer le bit 0 dans le flag carry
    JR    NC,FRAME0  ;tant que le flag carry n'est pas à 1 on boucle au label frm
	
event_compteur_attaque			DS	3,0
event_compteur_tirer			DS	3,0
event_link						ds	3,0
event_testclavier
	CALL	test_du_clavier
event_gameover					DS	3,0	

event_bombe_dodongo				DS	3,0
		retour_bombe_dodongo
event_passage_spawn_donjon		ds	3,0
		retour_passage_donjon
event_flammes					ds	3,0				; actif quand on est dans une "boutique"
		retour_flammes
event_texte						ds	3,0
		retour_texte
event_Link_Update				ds	3,0

event_objet_gauche				ds	3,0
event_objet_centre				ds	3,0
event_objet_hyrule_centre		ds	3,0
event_objet_droite				ds	3,0
event_objet_spawn_donjon		ds	3,0
		retour_objet
event_bouledefeu				ds	3,0
		retour_bouledefeu
event_boss_3_boules_de_feu		ds	3,0
		retour_3_boules_de_feu
event_boss_3_boules_de_feu2		ds	3,0
		retour_3_boules_de_feu2
event_recul_du_montre			ds	3,0
event_monstre1					DS	3,0
event_monstre2					DS	3,0	
event_monstre3					DS	3,0
event_monstre4					DS	3,0
event_monstre5					DS	3,0	
event_monstre6					DS	3,0
event_monstre7					DS	3,0
event_poisson_zora				DS	3,0
event_attente					ds	3,0

event_testtouche
	JP		test_de_touches
		retour_test_de_touches
			retour_fire1
			retour_fire2
			retour_direction
event_attaque					DS	3,0
		retour_attaque

event_fleche					DS	3,0				; actif quand une flêche est en cours
		retour_fleche
event_feu						DS	3,0				; actif quand une flêche est en cours
		retour_feu

event_bombe						DS	3,0
		retour_bombe
		
event_bosses_donjon				ds	3,0
		retour_boss_donjon
event_objets_donjon			DS	3,0	
		retour_objet_donjon
event_objets_hyrule			DS	3,0	
		retour_objet_hyrule

JP 	MAIN_BOUCLE

; ///////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////
; ****************************** BOUCLE PRINCIPALE - FIN **************************************
; ///////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////





; ///////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////// SOUS ROUTINE (test de la vbl)  ////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////
TEST_VBL
 LD    B,#F5    ;adresse du port B du PPI
	frm    IN    A,(C)     ;On récupère l'octet contenu sur le port dans A
    RRA              ;On fait une rotation afin de récupérer le bit 0 dans le flag carry
    JR    NC,FRM  ;tant que le flag carry n'est pas à 1 on boucle au label frm
RET
; ///////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////// SOUS ROUTINE (test du clavier)  ////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////
test_du_clavier
	LD		a,(flag_naissance_en_cours)			; test si on est dans une naissance en cours
	or		a
	RET		NZ
	LD		BC,#F40E:OUT (C),c
	LD		BC,#F6C0:OUT (C),C
	LD		BC,#F600:OUT (C),C
	LD		BC,#F792:OUT (C),C				; on place le port A en sortie (#92)
	LD		BC,#F649:OUT (C),C				; test la ligne 9 avec #F6 + %0100 1001 (#49)
	LD		B,#F4:IN A,(C)
	LD		BC,#F782:OUT (C),C				; on place le port A en entrée (#82)
	LD		BC,#F600:OUT (C),C
	ld		(resultat_test_de_touche),a
	RET
; ///////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////// SOUS ROUTINE (test de touches)  ////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////
test_de_touches
		ld		a,(flag_fire1)
		or		a
		JR		NZ,retour_test_de_touches
		ld		a,(flag_naissance_en_cours)
		OR		a
		jr		nz,retour_test_de_touches
		ld		a,(une_bombe_est_en_cours)
		or		a
		Jr		NZ,retour_test_de_touches
		ld		a,(resultat_test_de_touche)
				BIT		4,A
fire1_jpz		JP 		Z,fire1
		
				BIT		5,A
fire2_jpz		JP 		Z,fire2

				BIT		7,A
del_jpz			JP 		Z,inventaire
		
haut_test		BIT		0,A
haut_jpz		JP 		z,haut
		
bas_test		BIT		1,A
bas_jpz		    JP 		z,bas
droite_test		BIT		3,A
droite_jpz		JP 		z,droite
gauche_test		BIT		2,A
gauche_jpz		JP 		z,gauche
		JP		retour_test_de_touches
selection	ds		1,0



; ///////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////// Fichiers inclus  ///////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////

	
read"table_init_monstres.asm"
read"link.asm"
read"monstre2.asm"
read"monstre3.asm"
read"monstre4.asm"
read"monstre5.asm"
read"monstre6.asm"
read"monstre7.asm"
read"poisson_zora.asm"
read"collisions_decors.asm"
read"collisions_bombe_et_decors.asm"
read"collisions.asm"
read"affiche_pieces_et_hud.asm"
read"affiche_boutique.asm"
read"affiche_passage.asm"
read"affiche_grotte.asm"
read"affiche_vies_hud.asm"
read"hud.asm"
read"inventaire.asm"
read"changement_de_piece.asm"
read"fire1.asm"
read"fire2.asm"
read"fleche.asm"
read"bombe.asm"
read"feu.asm"
read"gestion_des_interruptions.asm"
read"interrupteurs.asm"
read"constantes_equ.asm"
read"variables.asm"	
read"table_monstres.asm"
read"table_init_link.asm"
read"link_flute.asm"
read"gameover.asm"



bank 2
include"main2.asm"
bank 8
include"main4.asm"
bank 4
        ; La configuration n'est pas obligatoire, mais elle permet
        ; de réduire la taille du binaire produit (ici 1.6K au lieu de 1.8K)
		ORG MUSIC_ADR_RAM
        ;include"musique_hyrule_donjons_marchands_playerconfig.asm" 
		include"musique_hyrule_playerconfig.asm"
        ; Soundtrack exporté
		include "sfx_playerconfig.asm"   ; Optional.
music_fin			; #50D de longueur

bank 9
ORG CODE_PROGRAMME_2
include"main3.asm"

bank 12
ORG CODE_PROGRAMME_3
;include"main5.asm"
include"main5_EN.asm"










