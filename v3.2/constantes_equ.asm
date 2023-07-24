
; ________________________________________
;            REGLAGE DU GAMEPLAY
; ________________________________________

		; ______ réglages des armes de link
		puissance_epee_en_bois				equ	1
		puissance_epee_acier				equ	2
		puissance_master_sword				equ	4
		puissance_bite_de_link				equ	1
		puissance_fleche					equ	1

		; ______ accesses aux differentes épée
		epee_en_acier_niveau				equ	12		; equivalent à 6 coeurs
		epee_master_sword_niveau			equ	20		; equivalent à 10 coeurs
		
		; ______ limitation du nombres d'objets
		maximum_de_cle						equ	8
		maximum_de_bombe					equ	8
		nbr_rubi_bleu_rammasse				equ	15
		
		; ______  réglage du timing
		temps_sans_attaquer					equ	10
		temps_sans_tirer					equ	25
		nbr_cycle_attente_monstre			equ	#1E

		; ______ invulnerabilité de link
		nombre_de_piece_en_invincible		equ	5


		; ______ points de vies des ennemis
		NIVEAU1			equ	#0201			; ennemis tuable en 2 coup d'épée en bois, 1 coup epée en acier et 1 fleche
		NIVEAU2			equ	#0401			; ennemis tuable en 4 coups d'épée en bois, 2 coups épée en acier et 1 fleche
		NIVEAU3			equ	#0602			; ennemis tuable en 6 coups d'épée en bois, 3 coups épée en acier et 2 fleches
		NIVEAU4			equ	#0A03			; ennemis tuable en 10 coup d'épée en bois, 5 coups épée en avier et 3 fleches
		NIVEAU5			equ	#FF05			; ennemis invincible avec l'épée mais  fleche pour les tuer
		INVINCIBLE		equ	#FFFF			; ennemis invincible	
		NIVEAU_BOSS_1	equ	#FF0F			; invicible à l'épée, il faut 15 flêches
		NIVEAU_BOSS_2	equ	#FF06			; invicible à l'épée, il faut 6 bombes



; ____________________________________________
;           REGLAGE DES ANIMATIONS
; ____________________________________________

		; ______ reaction des ennemis
		longueur_recul_monstre				equ	15

		; ______ flammes animées dans les boutiques
		cycle_total_animation_flammes		equ		4
		cycle_animation_flammes_etape1		equ		2			; doit être à mis à la moitée
		cycle_animation_flammes_etape2		equ		1			; paramètre à ne pas toucher car 1 cycle avant la réinit

		; ______ flammes animées ingame
		cycle_total_animation_du_feu		equ		5
		cycle_animation_feu_etape1			equ		4			; doit être à mis à la moitée
		cycle_animation_feu_etape2			equ		2			; paramètre à ne pas toucher car 1 cycle avant la réinit

		; ______ limite de la zone ecran des ensuite	
		limite_bord_droit_monstres			equ		#01d0
		limite_bord_gauche_monstres			equ		#0016
		limite_bord_bas_monstre				equ		#00EB
		limite_bord_haut_monstre			equ		#005A

; ____________________________________________
;           tarifs  des objets
; ____________________________________________
tarif_bombe				equ		20		: tarif_fleche			equ		80		: tarif_coeur				equ		10
tarif_bouclier			equ		100		: tarif_bouclier2		equ		150		: tarif_bouclier3			equ		60
tarif_bougie			equ		60		: tarif_cle				equ		50		: tarif_fiole_rouge		 	equ		68
tarif_fiole_bleu		equ		40		: tarif_rubi_bleu_1		equ		10		: tarif_rubi_bleu_2			equ		30
tarif_rubi_bleu_3		equ		50		: tarif_rubi_bleu86_1	equ		10		: gain_rubi_bleu86_1		equ		30
tarif_rubi_bleu26		equ		0		: tarif_bague			equ		150		: tarif_viande			    equ		60
tarif_rubi_bleu86_2		equ		10		: tarif_rubi_bleu86_3	equ		10		: tarif_flute				equ		110
tarif_sci				equ		255		: tarif_pang			equ		255		

; ____________________________________________
;           identification objet  
; ____________________________________________
objet_fleche			equ		1	: objet_coeur				equ		2	: objet_bombe				equ		3
objet_cle				equ		4	: objet_cle_donjon			equ		5	: objet_boussole			equ		6
objet_parchemin			equ		7 	: objet_receptacle_coeur	equ		8 	: objet_carte				equ		9
epee_en_bois			equ		10	: objet_bouclier			equ		11	: objet_bouclier2			equ		12
objet_bougie			equ		13	: objet_fiole_rouge			equ		14	: objet_fiole_bleu			equ		15
epee_en_acier			equ		16	: objet_rubi_bleu_1			equ		17	: objet_rubi_bleu_2			equ		18
objet_rubi_bleu_3		equ		19	: objet_rubi_bleu86_1		equ		20	: objet_rubi_bleu86_2		equ		21	
objet_rubi_bleu86_3		equ		22	: objet_bague				equ		23	: objet_viande				equ		24
objet_rubi_bleu26		equ		25	: objet_bouclier3			equ		26	: epee_master_sword			equ		27
objet_arc				equ		28	: objet_radeau				equ		29	: objet_porte_donjon_1		equ		30
objet_porte_donjon_2	equ		31	: objet_porte_donjon_3		equ		32	: objet_porte_donjon_4		equ		33
objet_bague_rouge		equ		34	: objet_trifoce_donjon_1	equ		35	: objet_trifoce_donjon_2	equ		36
objet_trifoce_donjon_3	equ		37	: objet_flute				equ		38	: objet_trifoce_donjon_4	equ		39
objet_rubi_vert			equ		40	: objet_baton				equ		41	: objet_sci					equ		42
objet_pang				equ		43	: objet_teleportation		equ		44	: objet_echelle				equ		45
objet_noexit					equ		46			
god			equ		47

; _________________________________________________________________________________________________
;   BANK C0 - Palette / Musique / Programme
; _________________________________________________________________________________________________
MEM_TAMPON_PALETTE				equ	#003B			; #00E0 de long    #003B
		LONGEUR_DES_PALLETTES	equ	#00E0
			PALETTE_HYRULE		equ MEM_TAMPON_PALETTE		; chaque pallette prends #20 octets de long
			PALETTE_HUD			equ MEM_TAMPON_PALETTE+#0020
			PALETTE_DONJON		equ MEM_TAMPON_PALETTE+#0040
			PALETTE_OCEAN		equ MEM_TAMPON_PALETTE+#0060
			PALETTE_MAISON		equ MEM_TAMPON_PALETTE+#0080
			PALETTE_GAMEOVER	equ MEM_TAMPON_PALETTE+#00A0	; se termine en #00C0	
			PALETTE_NOIR		equ	#5000						; pour le moment en mémoire y'a que des zero
; _________________________________________________________________________________________________
PLAYER_ADR_RAM				EQU	#011C		; adresse à reporter manuellement dans creation_cartouche.asm
		LONGUEUR_PLAYER		equ	#084C
MUSIC_ADR_RAM				EQU #0980		; toutes les musiques du jeu
		LONGUEUR_MUSIC		equ	#0B3F
	
	MUSIC_HYRULE			equ	0
	MUSIC_DONJON			equ	1
	MUSIC_BOUTIQUE			equ	2
	MUSIC_ITEM				equ	4
	MUSIC_SECRET			equ	5
	MUSIC_OCEAN				equ 6
	MUSIC_FLUTE				equ	7
; _________________________________________________________________________________________________
CODE_PROGRAMME_2			equ	#14B0
		LONGUEUR_PROG2		equ	#175F		; se termine en #2BFA
		
CODE_PROGRAMME_3			equ	#5500
		LONGUEUR_PROG3		equ	#2A00		; se termine en #2BFA
; _________________________________________________________________________________________________

HUD_ADR						EQU	#2000		; adresse du hud en mémoire tampon
											; il est ensuite aussitôt écasé par la copie en mémoire du pogramme 2
; _________________________________________________________________________________________________
												
MEM_TAMPON_HUD			equ #2BFF		
MEM_TAMPON_BOSS			equ	#2BFF
MEM_TAMPON_SPRH			equ	#2FFF
MEM_TAMPON_TEXTE		equ	#2FFF
MEM_TAMPON_GAMEOVER		equ	#7E00
MEM_TAMPON_ETAT_GAMEOVER		equ	#7F00
; _________________________________________________________________________________________________

BankROM_objets			equ	25

; _________________________________________________________________________________________________
;   PARAMETRE INVENTAIRE
; _________________________________________________________________________________________________
INVENTAIRE_OFFSET_ECRAN			equ	#C400
INVENTAIRE_HAUTEUR_TILES		equ	5
SAUVEGARDE_DU_FOND_ADR			equ #4000
SAUVEGARDE_DU_FOND_NBR_TILES	equ 80
LARGEUR_ECRAN					equ	64						; 4 octets de large par tile x 16 tiles
INVENTAIRE_CURSEUR_X			equ	212
INVENTAIRE_CURSEUR_Y			equ	141



; ___________________________________
;          BANK C4 - HYRULE
; ___________________________________


TILE_ADR							equ		#4000
tile_escalier_donjon1_adr			equ 	TILE_ADR+#0240		; #4240
tile_grotte_haute_donjon_adr		equ		TILE_ADR+#1340      ; #5340
tile_grotte_basse_donjon_adr		equ		TILE_ADR+#1300 		; #5300
tile_grotte_gauche_donjon_adr		equ		TILE_ADR+#400
tile_grotte_droite_donjon_adr  		equ		TILE_ADR+#3c0 	   
tile_grotte_hyrule_adr				equ 	#4040

tile_grotte_adr						equ 	#4040
tile_escalier_vert_adr				equ 	#4200


tile_entree_arbre_sable					equ		034				; /////////////////// !!!!!!!!!!!!!!!!!!!!!!!!!!!! ///////////////
test_tile_entree_arbre_sable			equ		232				; //////////     =    DONJON --> TILE GROTTE HAUT         ////////
tile_arbre_sable_hyrule_adr				equ 	#4880			; /////////////////// !!!!!!!!!!!!!!!!!!!!!!!!!!!! ///////////////

tile_entree_arbre_herbe					equ		063				; /////////////////// !!!!!!!!!!!!!!!!!!!!!!!!!!!! ///////////////
test_tile_entree_arbre_herbe			equ		233				; //////////     =    DONJON --> TILE GROTTE BAS         ////////
tile_arbre_herbe_hyrule_adr				equ 	#4FC0			; /////////////////// !!!!!!!!!!!!!!!!!!!!!!!!!!!! ///////////////

test_tile_entree_arbre_marron			equ		234				; //////////     =    DONJON --> TILE GROTTE GAUCHE      ////////
test_tile_grotte_roche_marron			equ		235				; //////////     =    DONJON --> TILE GROTTE DROITE      ////////


roche_neige								equ		239
roche_marron							equ		240				

	
roche_marron_passage					equ		016
roche_marron_teleportation 				equ		066
roche_marron_vert						equ		241




RIEN_SPR_HUD			equ		#5380
EPEE_MASTER_SWORD_HUD	equ		#53C0
VIANDE_HUD				equ		#5400
HUD_ITEMS				equ 	#5440
EPEE_EN_BOIS_HUD		equ		HUD_ITEMS
FLUTE_SPR_HUD			equ		#5480
BOUGIE_SPR_HUD			equ		HUD_ITEMS+#00C0  	;#5240
FLECHE_SPR_HUD			equ		HUD_ITEMS+#0100  	;#5280
FIOLE_BLEU_SPR_HUD		equ		HUD_ITEMS+#0140		;#52C0
FIOLE_ROUGE_SPR_HUD		equ		HUD_ITEMS+#0180		;#5300
BOMBE_SPR_HUD			equ		HUD_ITEMS+#0200		;#5380
PARCHEMIN_SPR_HUD		equ		HUD_ITEMS+#0240		;#53C0
EPEE_EN_ACIER_HUD		equ		#5600 	
FONTE_TEXTE				equ 	#56c0
FONTE_CHIFFRE			equ 	FONTE_TEXTE+#100
COEURS_VIE_ADR_RAM		equ		#5100
COEUR_ROUGE_HUD			equ		COEURS_VIE_ADR_RAM
DEMIS_COEUR_HUD			equ		COEURS_VIE_ADR_RAM+#20   ; #5C8C
COEUR_BLANC_HUD			equ		COEURS_VIE_ADR_RAM+#40   ; #5Ca8
TILES_SECRETES_ADR		equ		#7A00




; ________________________________________
;            Bank C3 - ECRAN
; ________________________________________
OFFSET					equ		#C280
HYRULE_GPS_PIECE01		equ		#C209				; injecté dans la variable (gps)

DONJON_GPS_PIECE01		equ		#C209
TRIFORCE_GPS_DONJON1	equ		#c192		; -#77

DONJON_GPS_PIECE02		equ		#C209
TRIFORCE_GPS_DONJON2	equ		#e109		; -#77

DONJON_GPS_PIECE03		equ		#C20F
TRIFORCE_GPS_DONJON3	equ		#c192		; -#77

DONJON_GPS_PIECE04		equ		#C209
TRIFORCE_GPS_DONJON4	equ		#E10F		; -#77

GROTTE_DONJON_HAUT		equ		#C31E
GROTTE_DONJON_BAS		equ		#C71E
GROTTE_DONJON_GAUCHE	equ		#C504
GROTTE_DONJON_DROITE	equ		#C538

OCEAN_GPS_DEPART		equ		#C1C2

PIXEL_ROUGE				equ		#0f			; ok
PIXEL_BLEU				equ		#C0			; ok
PIXEL_GRIS				equ 	#CC         ; OK
PIXEL_NOIR				equ 	#00			; OK
PIXEL_JAUNE				equ 	#3C			; OK
PIXEL_VERT				equ		#3F			; OK
PIXEL_MARRON_HAUT		equ 	#67
PIXEL_MARRON_BAS		equ	 	#9B
PIXEL_ORANGE			equ		#F3			; position de link dans les donjons
		

; ________________________________________
;                SPRITE HARD ASIC
; ________________________________________
; ////////////////////////////////////////////////   Adresses  //////////////////////////////////////
SPRH0_ADR		EQU	#4000:SPRH1_ADR		EQU	#4100:SPRH2_ADR		EQU	#4200
SPRH3_ADR		EQU	#4300:SPRH4_ADR		EQU	#4400:SPRH5_ADR		EQU	#4500
SPRH6_ADR		EQU	#4600:SPRH7_ADR		EQU	#4700:SPRH8_ADR		EQU	#4800
SPRH9_ADR		EQU	#4900:SPRH10_ADR		EQU	#4A00:SPRH11_ADR		EQU	#4B00
SPRH12_ADR		EQU	#4C00:SPRH13_ADR		EQU	#4D00:SPRH14_ADR		EQU	#4E00
SPRH15_ADR		EQU	#4F00
; ////////////////////////////////////////////////   Zoom  /////////////////////////////////////////
SPRH0_ZOOM		EQU	#6004:SPRH1_ZOOM		EQU	#600c
SPRH2_ZOOM		EQU	#6014:SPRH3_ZOOM		EQU	#601c
SPRH4_ZOOM		EQU	#6024:SPRH5_ZOOM		EQU	#602c
SPRH6_ZOOM		EQU	#6034:SPRH7_ZOOM		EQU	#603c
SPRH8_ZOOM		EQU	#6044:SPRH9_ZOOM		EQU	#604c
SPRH10_ZOOM		EQU	#6054:SPRH11_ZOOM		EQU	#605c
SPRH12_ZOOM		EQU	#6064:SPRH13_ZOOM		EQU	#606c
SPRH14_ZOOM		EQU	#6074:SPRH15_ZOOM		EQU	#607c
ZOOM1			equ	#0909:ZOOM2				equ #0E0E
ZOOM_normal		equ	#09
ZOOM_gros		equ	#0E

; ////////////////////////////////////////////   Coordonnées  /////////////////////////////////////////
SPRH0_X			EQU	#6000:SPRH0_Y			EQU	#6002
SPRH1_X			EQU	#6008:SPRH1_Y			EQU	#600A
SPRH2_X			EQU	#6010:SPRH2_Y			EQU	#6012
SPRH3_X			EQU	#6018:SPRH3_Y			EQU	#601A
SPRH4_X			EQU	#6020:SPRH4_Y			EQU	#6022
SPRH5_X			EQU	#6028:SPRH5_Y			EQU	#602A
SPRH6_X			EQU	#6030:SPRH6_Y			EQU	#6032
SPRH7_X			EQU	#6038:SPRH7_Y			EQU	#603A
SPRH8_X			EQU	#6040:SPRH8_Y			EQU	#6042
SPRH9_X			EQU	#6048:SPRH9_Y			EQU	#604A
SPRH10_X		EQU	#6050:SPRH10_Y			EQU	#6052
SPRH11_X		EQU	#6058:SPRH11_Y			EQU	#605A
SPRH12_X		EQU	#6060:SPRH12_Y			EQU	#6062
SPRH13_X		EQU	#6068:SPRH13_Y			EQU	#606A
SPRH14_X		EQU	#6070:SPRH14_Y			EQU	#6072
SPRH15_X		EQU	#6078:SPRH15_Y			EQU	#607A
SPRH0_X_Y_ZOOM	EQU	#6000:SPRH1_X_Y_ZOOM	EQU	#6008
SPRH5_X_Y_ZOOM	EQU	#6028:SPRH6_X_Y_ZOOM	EQU	#6030
SPRH7_X_Y_ZOOM	EQU	#6038:SPRH8_X_Y_ZOOM	EQU	#6040
SPRH9_X_Y_ZOOM	EQU	#6048:SPRH10_X_Y_ZOOM	EQU	#6050
SPRH11_X_Y_ZOOM	EQU	#6058:SPRH12_X_Y_ZOOM	EQU	#6060



DEPART_FIRE1_XGO		equ		#0E0
DEPART_FIRE1_YGO		equ		110
DEPART_FIRE1B_XGO		equ		#150
DEPART_FIRE1B_YGO		equ		140

; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////// COLLISIONS  ////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////

; entre link et les monstres
link_monstres_X1		equ	20			; 31 par défault
link_monstres_X2		equ	20			; 31 par défault
link_monstres_Y1		equ	10			; 15 par défault
link_monstres_Y2		equ	10			; 15 par défault

; entre l'épée et les monstres
epee_monstres_X1		equ	27			; 27 par défault
epee_monstres_X2		equ	27			; 27 par défault
epee_monstres_Y1		equ	11			; 11 par défault
epee_monstres_Y2		equ	11			; 11 par défault

; entre les objets et links
objet_link_X1		equ	10			; 8 par défault
objet_link_X2		equ	10			; 8 par défault
objet_link_Y1		equ	6			; 4 par défault
objet_link_Y2		equ	6			; 4 par défault



; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////// SPRITES HARD DES MONSTRES -  ROM  ////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////

; ////////////////////////////////////   Mort & Naissances  //////////////////////////////////////
BORNDEAD_ROM_SPR	equ #D000
BORN1_SPR			equ BORNDEAD_ROM_SPR:BORN2_SPR				equ BORNDEAD_ROM_SPR+#100
BORN3_SPR			equ BORNDEAD_ROM_SPR+#200:DEAD1_SPR			equ BORNDEAD_ROM_SPR+#300
DEAD2_SPR			equ BORNDEAD_ROM_SPR+#400:DEAD3_SPR			equ BORNDEAD_ROM_SPR+#500
BORN4_SPR			equ BORNDEAD_ROM_SPR+#600:BORN5_SPR			equ BORNDEAD_ROM_SPR+#700



; ////////////////////////////////////   Octorock 1 & 2 //////////////////////////////////////
OCTOROK1_ROM		equ	#E000
OCTOROK1_H1			equ OCTOROK1_ROM:OCTOROK1_H2			equ OCTOROK1_ROM+#100
OCTOROK1_B1			equ OCTOROK1_ROM+#200:OCTOROK1_B2		equ OCTOROK1_ROM+#300
OCTOROK1_G1			equ OCTOROK1_ROM+#400:OCTOROK1_G2		equ OCTOROK1_ROM+#500
OCTOROK1_D1			equ OCTOROK1_ROM+#600:OCTOROK1_D2		equ OCTOROK1_ROM+#700
OCTOROK2_ROM		equ	#E800
OCTOROK2_H1			equ OCTOROK2_ROM:OCTOROK2_H2			equ OCTOROK2_ROM+#100
OCTOROK2_B1			equ OCTOROK2_ROM+#200:OCTOROK2_B2		equ OCTOROK2_ROM+#300
OCTOROK2_G1			equ OCTOROK2_ROM+#400:OCTOROK2_G2		equ OCTOROK2_ROM+#500
OCTOROK2_D1			equ OCTOROK2_ROM+#600:OCTOROK2_D2		equ OCTOROK2_ROM+#700

; ////////////////////////////////////   Moblin 1 & 2 //////////////////////////////////////
MOBLIN1_ROM		equ	#F000
MOBLIN1_H1		equ MOBLIN1_ROM:MOBLIN1_H2			equ MOBLIN1_ROM+#100:
MOBLIN1_B1		equ MOBLIN1_ROM+#200:MOBLIN1_B2		equ MOBLIN1_ROM+#300
MOBLIN1_G1		equ MOBLIN1_ROM+#400:MOBLIN1_G2		equ MOBLIN1_ROM+#500
MOBLIN1_D1		equ MOBLIN1_ROM+#600:MOBLIN1_D2		equ MOBLIN1_ROM+#700
MOBLIN2_ROM		equ	#F800
MOBLIN2_H1		equ MOBLIN2_ROM:MOBLIN2_H2			equ MOBLIN2_ROM+#100
MOBLIN2_B1		equ MOBLIN2_ROM+#200:MOBLIN2_B2		equ MOBLIN2_ROM+#300
MOBLIN2_G1		equ MOBLIN2_ROM+#400:MOBLIN2_G2		equ MOBLIN2_ROM+#500
MOBLIN2_D1		equ MOBLIN2_ROM+#600:MOBLIN2_D2		equ MOBLIN2_ROM+#700


; ////////////////////////////////////   Lynel 1 & 2 //////////////////////////////////////
LYNEL1_ROM		equ	#C000
LYNEL1_H1		equ LYNEL1_ROM:LYNEL1_H2		equ LYNEL1_ROM+#100
LYNEL1_B1		equ LYNEL1_ROM+#200:LYNEL1_B2		equ LYNEL1_ROM+#300
LYNEL1_G1		equ LYNEL1_ROM+#400:LYNEL1_G2		equ LYNEL1_ROM+#500
LYNEL1_D1		equ LYNEL1_ROM+#600:LYNEL1_D2		equ LYNEL1_ROM+#700
LYNEL2_ROM		equ	#C800
LYNEL2_H1		equ LYNEL1_ROM:LYNEL2_H2		equ LYNEL1_ROM+#100
LYNEL2_B1		equ LYNEL1_ROM+#200:LYNEL2_B2		equ LYNEL1_ROM+#300
LYNEL2_G1		equ LYNEL1_ROM+#400:LYNEL2_G2		equ LYNEL1_ROM+#500
LYNEL2_D1		equ LYNEL1_ROM+#600:LYNEL2_D2		equ LYNEL1_ROM+#700


; ////////////////////////////////////   Tektite //////////////////////////////////////
TEKTITE1_ROM		equ	#E000
TEKTITE2_ROM		equ	#E200

; ////////////////////////////////////   Wall Master //////////////////////////////////////
WALLMASTER_ROM		equ	#F600

; ////////////////////////////////////   Leever //////////////////////////////////////
LEEVER2_ROM		equ	#E800
LEEVER1_ROM		equ	#EA00

; ////////////////////////////////////   Peahat  //////////////////////////////////////
PEAHAT_ROM		equ	#E400

; ////////////////////////////////////   Ghini  //////////////////////////////////////
GHINI_ROM		equ	#EE00

; ////////////////////////////////////   Keeses  //////////////////////////////////////
KEESES_ROM		equ	#E600
; ////////////////////////////////////   Electro  //////////////////////////////////////
ELECTRO_ROM		equ	#C800

; ////////////////////////////////////   Like Like  //////////////////////////////////////
LIKELIKE_ROM		equ	#C400


; /////////////////////////////// La fée clochette /////////////////////////////////
PETITE_FEE_ROM		equ	#F400


; ////////////////////////////////////   GEL  //////////////////////////////////////
GEL_ROM		equ	#FA00
ZOL_ROM		equ	#F800
ZOLNOIR_ROM		equ	#FC00
; ////////////////////////////////////   Poisson Zora  //////////////////////////////////////
ZORA_ROM			equ #EC00
BOULEDEFEU_SPR		EQU	#E000

; ////////////////////////////////////   Darknut //////////////////////////////////////
DARKNUT1_ROM	equ	#E000
DARKNUT1_H1		equ	DARKNUT1_ROM:DARKNUT1_H2		equ	DARKNUT1_ROM+#100
DARKNUT1_B1		equ	DARKNUT1_ROM+#200:DARKNUT1_B2		equ	DARKNUT1_ROM+#300
DARKNUT1_G1		equ	DARKNUT1_ROM+#400:DARKNUT1_G2		equ	DARKNUT1_ROM+#500
DARKNUT1_D1		equ	DARKNUT1_ROM+#600:DARKNUT1_D2		equ	DARKNUT1_ROM+#700

DARKNUT2_ROM	equ	#E800
DARKNUT2_H1		equ	DARKNUT2_ROM:DARKNUT2_H2		equ	DARKNUT2_ROM+#100
DARKNUT2_B1		equ	DARKNUT2_ROM+#200:DARKNUT2_B2		equ	DARKNUT2_ROM+#300
DARKNUT2_G1		equ	DARKNUT2_ROM+#400:DARKNUT2_G2		equ	DARKNUT2_ROM+#500
DARKNUT2_D1		equ	DARKNUT2_ROM+#600:DARKNUT2_D2		equ	DARKNUT2_ROM+#700

; ////////////////////////////////////   Goriya  //////////////////////////////////////
GORIYA1_ROM		equ	#D000
GORIYA1_H1		equ	GORIYA1_ROM:GORIYA1_H2		equ	GORIYA1_ROM+#100
GORIYA1_B2		equ	GORIYA1_ROM+#300:GORIYA1_B1		equ	GORIYA1_ROM+#200
GORIYA1_G1		equ	GORIYA1_ROM+#400:GORIYA1_G2		equ	GORIYA1_ROM+#500
GORIYA1_D1		equ	GORIYA1_ROM+#600:GORIYA1_D2		equ	GORIYA1_ROM+#700

GORIYA2_ROM		equ	#D800
GORIYA2_H1		equ	GORIYA2_ROM:GORIYA2_H2		equ	GORIYA2_ROM+#100
GORIYA2_B2		equ	GORIYA2_ROM+#300:GORIYA2_B1		equ	GORIYA2_ROM+#200
GORIYA2_G1		equ	GORIYA2_ROM+#400:GORIYA2_G2		equ	GORIYA2_ROM+#500
GORIYA2_D1		equ	GORIYA2_ROM+#600:GORIYA2_D2		equ	GORIYA2_ROM+#700


; ////////////////////////////////////   Mario  //////////////////////////////////////
MARIO_ROM		equ	#F000
MARIO_H1		equ	MARIO_ROM:MARIO_H2		equ	MARIO_ROM+#100
MARIO_B2		equ	MARIO_ROM+#300:MARIO_B1		equ	MARIO_ROM+#200
MARIO_G1		equ	MARIO_ROM+#400:MARIO_G2		equ	MARIO_ROM+#500
MARIO_D1		equ	MARIO_ROM+#600:MARIO_D2		equ	MARIO_ROM+#700

; ////////////////////////////////////   Zelda  //////////////////////////////////////
ZELDA_ROM		equ	#F800
ZELDA_H1		equ	ZELDA_ROM:ZELDA_H2		equ	ZELDA_ROM+#100
ZELDA_B2		equ	ZELDA_ROM+#300:ZELDA_B1		equ	ZELDA_ROM+#200
ZELDA_G1		equ	ZELDA_ROM+#400:ZELDA_G2		equ	ZELDA_ROM+#500
ZELDA_D1		equ	ZELDA_ROM+#600:ZELDA_D2		equ	ZELDA_ROM+#700

; ////////////////////////////////////   Goriya  //////////////////////////////////////
ROPE1_ROM		equ	#D000
ROPE1_G1		equ	ROPE1_ROM			:	ROPE1_G2		equ	ROPE1_ROM+#100
ROPE1_D2		equ	ROPE1_ROM+#300		: 	ROPE1_D1		equ	ROPE1_ROM+#200

; ////////////////////////////////////   Flying Fish  //////////////////////////////////////
FISH_ROUGE_ROM		equ	#D400
FISH_ROUGE_G1		equ	FISH_ROUGE_ROM			:	FISH_ROUGE_G2		equ	FISH_ROUGE_ROM+#100
FISH_ROUGE_D2		equ	FISH_ROUGE_ROM+#300		: 	FISH_ROUGE_D1		equ	FISH_ROUGE_ROM+#200

FISH_VERT_ROM		equ	#D800
FISH_VERT_G1		equ	FISH_VERT_ROM			:	FISH_VERT_G2		equ	FISH_VERT_ROM+#100
FISH_VERT_D2		equ	FISH_VERT_ROM+#300		: 	FISH_VERT_D1		equ	FISH_VERT_ROM+#200

FISH_BLEU_ROM		equ	#DC00
FISH_BLEU_G1		equ	FISH_BLEU_ROM			:	FISH_BLEU_G2		equ	FISH_BLEU_ROM+#100
FISH_BLEU_D2		equ	FISH_BLEU_ROM+#300		: 	FISH_BLEU_D1		equ	FISH_BLEU_ROM+#200

; ////////////////////////////////////   Goriya  //////////////////////////////////////
VIRE_ROM		equ #C000
VIRE_H1			equ VIRE_ROM			:	VIRE_H2			equ VIRE_ROM+#100
VIRE_B1			equ VIRE_ROM+#200 		:	VIRE_B2			equ VIRE_ROM+#300


; ////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////// BOSS DONJON 1 ////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////
BOSS1_ROM		equ	#C000

BOSS1_RAM		equ	MEM_TAMPON_BOSS
BOSS1_HG1		equ	BOSS1_RAM+#100
BOSS1_HG2		equ	BOSS1_RAM+#200
BOSS1_HD1		equ	BOSS1_RAM+#300
BOSS1_HD2		equ	BOSS1_RAM+#400
BOSS1_BG1		equ	BOSS1_RAM+#500
BOSS1_BG2		equ	BOSS1_RAM+#600
BOSS1_BD1		equ	BOSS1_RAM+#700
BOSS1_BD2		equ	BOSS1_RAM+#800


; ////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////// BOSS DONJON 2 ////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////
BOSS2_ROM		equ	#D000

BOSS2_RAM		equ	MEM_TAMPON_BOSS
BOSS2_H1		equ	BOSS2_RAM
BOSS2_H2		equ	BOSS2_RAM+#100
BOSS2_B1		equ	BOSS2_RAM+#200
BOSS2_B2		equ	BOSS2_RAM+#300
BOSS2_G1A		equ	BOSS2_RAM+#400
BOSS2_G1B		equ	BOSS2_RAM+#500
BOSS2_G2A		equ	BOSS2_RAM+#600
BOSS2_G2B		equ	BOSS2_RAM+#700
BOSS2_D1A		equ	BOSS2_RAM+#800
BOSS2_D1B		equ	BOSS2_RAM+#900
BOSS2_D2A		equ	BOSS2_RAM+#A00
BOSS2_D2B		equ	BOSS2_RAM+#B00
BOSS2_G3A		equ	BOSS2_RAM+#C00
BOSS2_G3B		equ	BOSS2_RAM+#D00
BOSS2_D3A		equ	BOSS2_RAM+#E00
BOSS2_D3B		equ	BOSS2_RAM+#F00
BOSS2_B3		equ	BOSS2_RAM+#1000
BOSS2_H3		equ	BOSS2_RAM+#1100


; ////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////// BOSS DONJON 3 ////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////
BOSS3_ROM		equ	#E000

BOSS3_RAM		equ	MEM_TAMPON_BOSS
BOSS3_H1		equ	BOSS3_RAM+#100
BOSS3_H2		equ	BOSS3_RAM+#200
BOSS3_B1		equ	BOSS3_RAM+#300
BOSS3_B2		equ	BOSS3_RAM+#400
BOSS3_G1		equ	BOSS3_RAM+#500
BOSS3_G2		equ	BOSS3_RAM+#600
BOSS3_D1		equ	BOSS3_RAM+#700
BOSS3_D2		equ	BOSS3_RAM+#800

; ////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////// BOSS DONJON 4 ////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////
BOSS4_ROM_30		equ	#F000
BOSS4_ROM_31		equ	#C000
; shémas de la disposition des sprites pour l'animation
		;  QUEUE_1  .  QUEUE_2
		;  CORPS_1  .  CORPS_2
		;  PIEDS_1  .  PIEDS_2
B4_Q_GAUCHE_1 		equ		BOSS4_ROM_30
B4_Q_DROITE_1 		equ		BOSS4_ROM_30+#100
B4_Q_GAUCHE_2 		equ		BOSS4_ROM_30+#200
B4_Q_DROITE_2		equ		BOSS4_ROM_30+#300
B4_Q_GAUCHE_3 		equ		BOSS4_ROM_30+#400
B4_Q_DROITE_3 		equ		BOSS4_ROM_30+#500

B4_C_GAUCHE_1 		equ		BOSS4_ROM_30+#600
B4_C_DROITE_1 		equ		BOSS4_ROM_30+#700
B4_C_GAUCHE_2 		equ		BOSS4_ROM_30+#800
B4_C_DROITE_2		equ		BOSS4_ROM_30+#900
B4_C_GAUCHE_3 		equ		BOSS4_ROM_30+#A00
B4_C_DROITE_3 		equ		BOSS4_ROM_30+#B00

B4_P_GAUCHE_1 		equ		BOSS4_ROM_30+#C00
B4_P_DROITE_1 		equ		BOSS4_ROM_30+#D00
B4_P_GAUCHE_2 		equ		BOSS4_ROM_30+#E00
B4_P_DROITE_2		equ		BOSS4_ROM_30+#F00

B4_P_GAUCHE_3 		equ		BOSS4_ROM_31
B4_P_DROITE_3 		equ		BOSS4_ROM_31+#100

B4_TETE_ROUGE		equ		BOSS4_ROM_31+#200
B4_TETE_BLEUE		equ		BOSS4_ROM_31+#300

B4_COUP_GAUCHE_HAUT		equ		BOSS4_ROM_31+#300
B4_COUP_GAUCHE_MILIEU	equ		BOSS4_ROM_31+#400
B4_COUP_GAUCHE_BAS		equ		BOSS4_ROM_31+#500

B4_COUP_DROITE_HAUT		equ		BOSS4_ROM_31+#600
B4_COUP_DROITE_MILIEU	equ		BOSS4_ROM_31+#700
B4_COUP_DROITE_BAS		equ		BOSS4_ROM_31+#800

BOSS4_RAM		equ	MEM_TAMPON_BOSS
B4R_Q_GAUCHE_1 		equ		BOSS4_RAM
B4R_Q_DROITE_1 		equ		BOSS4_RAM+#100
B4R_Q_GAUCHE_2 		equ		BOSS4_RAM+#200
B4R_Q_DROITE_2		equ		BOSS4_RAM+#300
B4R_Q_GAUCHE_3 		equ		BOSS4_RAM+#400
B4R_Q_DROITE_3 		equ		BOSS4_RAM+#500

B4R_C_GAUCHE_1 		equ		BOSS4_RAM+#600
B4R_C_DROITE_1 		equ		BOSS4_RAM+#700
B4R_C_GAUCHE_2 		equ		BOSS4_RAM+#800
B4R_C_DROITE_2		equ		BOSS4_RAM+#900
B4R_C_GAUCHE_3 		equ		BOSS4_RAM+#A00
B4R_C_DROITE_3 		equ		BOSS4_RAM+#B00

B4R_P_GAUCHE_1 		equ		BOSS4_RAM+#C00
B4R_P_DROITE_1 		equ		BOSS4_RAM+#D00
B4R_P_GAUCHE_2 		equ		BOSS4_RAM+#E00
B4R_P_DROITE_2		equ		BOSS4_RAM+#F00

B4R_P_GAUCHE_3 		equ		BOSS4_RAM+#1000
B4R_P_DROITE_3 		equ		BOSS4_RAM+#1100

B4R_TETE_ROUGE		equ		BOSS4_RAM+#1200
B4R_TETE_BLEUE		equ		BOSS4_RAM+#1300

B4R_COUP_GAUCHE_HAUT		equ		BOSS4_RAM+#1300
B4R_COUP_GAUCHE_MILIEU	equ		BOSS4_RAM+#1400
B4R_COUP_GAUCHE_BAS		equ		BOSS4_RAM+#1500

B4R_COUP_DROITE_HAUT		equ		BOSS4_RAM+#1600
B4R_COUP_DROITE_MILIEU	equ		BOSS4_RAM+#1700
B4R_COUP_DROITE_BAS		equ		BOSS4_RAM+#1800

DEPART_ANIM1			equ		BOSS4_RAM
DEPART_ANIM2			equ		BOSS4_RAM+#200
DEPART_ANIM3			equ		BOSS4_RAM+#400
; ////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////// MAP DONJONS ////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////
MAP_DONJONS  	equ		#C000
MAP_DONJON_0  	equ		MAP_DONJONS
MAP_DONJON_1  	equ		MAP_DONJONS+#0420
MAP_HYRULE  	equ		MAP_DONJONS+#0840
MAP_DONJON_2 	equ		MAP_DONJONS+#0C60
MAP_DONJON_3 	equ		MAP_DONJONS+#1080
MAP_DONJON_4 	equ		MAP_DONJONS+#14A0


; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////// CARTOUCHE -  ROM BANK  //////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////
ROM26			equ	#001A
ROM27			equ	#001B
ROM28			equ	#001C
ROM29			equ	#001D			;link
ROM30			EQU	#001E			; boss 1

RUBI_ET_ZOLA			equ #0101
ZOLA_1					equ	#0100
AUCUN					equ	#0000
RUBI_1					equ	#0001
COEUR_2					equ	#0002
BOMBE_3 				equ	#0003
CLE_4					equ	#0004
MONTRE_5				equ	#0005
VIANDE_6				equ	#0006
CHAMPI_ROUGE_7			equ #0007
CHAMPI_VERT_8			equ #0008
CHAMPI_POURRIT_10		equ #000A
RUBI_11					equ	#000B
RUBI_12					equ	#000C
RUBI_13					equ	#000D

; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////// SPRITES HARD LINK & ITEMS -  ROM  ////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////


LINK1_RAM_ADR		equ	MEM_TAMPON_SPRH
LINK_G1_adr			equ LINK1_RAM_ADR		:   LINK_G2_adr		equ LINK1_RAM_ADR+#100
LINK_D1_adr			equ LINK1_RAM_ADR+#200  :  LINK_D2_adr		equ LINK1_RAM_ADR+#300
LINK_B1_adr			equ LINK1_RAM_ADR+#400  :  LINK_B2_adr		equ LINK1_RAM_ADR+#500
LINK_H1_adr			equ LINK1_RAM_ADR+#600  :  LINK_H2_adr		equ LINK1_RAM_ADR+#700

; ////////////////////////////////////   Link 1   //////////////////////////////////////
LINK1_SPR		equ	#C000
LINK_G1			equ LINK1_SPR:LINK_G2			equ LINK1_SPR+#100
LINK_D1			equ LINK1_SPR+#200:LINK_D2		equ LINK1_SPR+#300
LINK_B1			equ LINK1_SPR+#400:LINK_B2		equ LINK1_SPR+#500
LINK_H1			equ LINK1_SPR+#600:LINK_H2		equ LINK1_SPR+#700

LINK_ATTACK_SPR		equ	#C800:LINK_ITEM						equ LINK1_SPR+#800
LINK_ATTACK_G		equ LINK_ATTACK_SPR:LINK_ATTACK_D		equ LINK_ATTACK_SPR+#100
LINK_ATTACK_B		equ LINK_ATTACK_SPR+#200:LINK_ATTACK_H	equ LINK_ATTACK_SPR+#300

; ////////////////////////////////////    Link 2  //////////////////////////////////////
LINK2_SPR		equ	#CC00
LINK2_G1		equ LINK2_SPR:LINK2_G2			equ LINK2_SPR+#100
LINK2_D1		equ LINK2_SPR+#200:LINK2_D2		equ LINK2_SPR+#300
LINK2_B1		equ LINK2_SPR+#400:LINK2_B2		equ LINK2_SPR+#500
LINK2_H1		equ LINK2_SPR+#600:LINK2_H2		equ LINK2_SPR+#700

; ////////////////////////////////////    Link 3 (nage)  ////////////////////////////////
LINK3_SPR		equ	#D400
LINK3_G1		equ LINK3_SPR:LINK3_G2			equ LINK3_SPR+#100
LINK3_D1		equ LINK3_SPR+#200:LINK3_D2		equ LINK3_SPR+#300
LINK3_B1		equ LINK3_SPR+#400:LINK3_B2		equ LINK3_SPR+#500
LINK3_H1		equ LINK3_SPR+#600:LINK3_H2		equ LINK3_SPR+#700



LINK_POSE_FACE		equ	#DD00
LINK_POSE_FACE2		equ	LINK_POSE_FACE+#100
LINK_POSE_FUTE		equ	LINK_POSE_FACE+#200


; ////////////////////////////////////    Link 4 (nu)  ////////////////////////////////
LINK4_SPR		equ	#E000
LINK4_G1		equ LINK4_SPR
LINK4_G2		equ LINK4_SPR+#100
LINK4_D1		equ LINK4_SPR+#200
LINK4_D2		equ LINK4_SPR+#300
LINK4_B1		equ LINK4_SPR+#400
LINK4_B2		equ LINK4_SPR+#500
LINK4_H1		equ LINK4_SPR+#600
LINK4_H2		equ LINK4_SPR+#700

; ////////////////////////////////////    Link 4 (baise)  ////////////////////////////////
LINK_FUCK_SPR		equ	#EC00
LINK_FUCK_G		equ LINK_FUCK_SPR
LINK_FUCK_D		equ LINK_FUCK_SPR+#100
LINK_FUCK_B		equ LINK_FUCK_SPR+#200
LINK_FUCK_H		equ LINK_FUCK_SPR+#300

; ////////////////////////////////////   amres & objets  //////////////////////////////////////
SPRH_OBJETS_ADR			EQU	#C000
SPRH_CURSEUR_ADR		EQU	SPRH_OBJETS_ADR
SPRH_BRACELET_ADR		EQU	SPRH_OBJETS_ADR+#100
SPRH_BOUSSOLE_ADR		EQU	SPRH_OBJETS_ADR+#200
SPRH_BOUCLIER_ADR		EQU	SPRH_OBJETS_ADR+#300
SPRH_CLE_ADR			EQU	SPRH_OBJETS_ADR+#400
SPRH_BOUGIE_ADR			EQU SPRH_OBJETS_ADR+#500
SPRH_BOMBE_ADR			EQU	SPRH_OBJETS_ADR+#600:BOMBE_SPR				equ	#C600
SPRH_FLECHE_ADR			EQU	SPRH_OBJETS_ADR+#700
SPRH_RUBIJ_ADR			EQU SPRH_OBJETS_ADR+#800
SPRH_RUBIB_ADR			EQU SPRH_OBJETS_ADR+#900
SPRH_EPEE2_ADR			EQU	SPRH_OBJETS_ADR+#a00
SPRH_PARCHEMIN_ADR		EQU	SPRH_OBJETS_ADR+#b00
SPRH_FIOLE_BLEU_ADR		EQU	SPRH_OBJETS_ADR+#c00
SPRH_FIOLE_ROUGE_ADR	EQU	SPRH_OBJETS_ADR+#d00
SPRH_FLAMEG_ADR			EQU	SPRH_OBJETS_ADR+#e00
SPRH_FLAMED_ADR			EQU	SPRH_OBJETS_ADR+#f00
SPRH_MONTRE_ADR			EQU	SPRH_OBJETS_ADR+#1000
SPRH_ARC_ADR			EQU	SPRH_OBJETS_ADR+#1100
SPRH_RADEAU_ADR			EQU	SPRH_OBJETS_ADR+#1200
SPRH_ECHELLE_ADR		EQU	SPRH_OBJETS_ADR+#1300
SPRH_CLE_DONJON_ADR		EQU SPRH_OBJETS_ADR+#1400
SPRH_MASTERSWORD_ADR	EQU	SPRH_OBJETS_ADR+#1500
SPRH_BATON_ADR			EQU SPRH_OBJETS_ADR+#1600
SPRH_BAGUE_ADR			EQU	SPRH_OBJETS_ADR+#1700
SPRH_BAGUE_ROUGE_ADR	EQU SPRH_OBJETS_ADR+#1800
SPRH_FLUTE_ADR			EQU SPRH_OBJETS_ADR+#1900
SPRH_COEUR_ADR			EQU SPRH_OBJETS_ADR+#1A00
SPRH_COEUR2_ADR			EQU SPRH_OBJETS_ADR+#1B00
SPRH_VIANDE_ADR			EQU SPRH_OBJETS_ADR+#1C00
SPRH_EPEE1_ADR			EQU SPRH_OBJETS_ADR+#1d00
SPRH_BOUCLIER2_ADR		EQU	SPRH_OBJETS_ADR+#1e00
SPRH_EPEE3_ADR			equ	SPRH_OBJETS_ADR+#1500
SPRH_RIEN				equ	SPRH_OBJETS_ADR+#1F00

SPRH_SCI_ADR			equ	SPRH_OBJETS_ADR+#2100	
SPRH_PANG_ADR			equ SPRH_OBJETS_ADR+#2200
SPRH_TINTIN_ADR			equ SPRH_OBJETS_ADR+#2300
SPRH_NOEXIT_ADR			equ SPRH_OBJETS_ADR+#2400
SPRH_RUBBER_ADR			equ SPRH_OBJETS_ADR+#2500	

SPRH_RUBIN_ADR			equ SPRH_OBJETS_ADR+#2600
SPRH_RUBIV_ADR			EQU SPRH_OBJETS_ADR+#2700
SPRH_SHOOE_ADR			EQU SPRH_OBJETS_ADR+#2800

FLAMME_G				equ #CE00
FLAMME_D				equ #CF00

LINK_EPEE1_SPR			equ #F000
LINK_EPEE_G				equ LINK_EPEE1_SPR:LINK_EPEE_D				equ LINK_EPEE1_SPR+#100
LINK_EPEE_B				equ LINK_EPEE1_SPR+#200:LINK_EPEE_H			equ LINK_EPEE1_SPR+#300

LINK_FLECHE1_SPR		equ #F800
LINK_FLECHE_G			equ LINK_FLECHE1_SPR:LINK_FLECHE_D			equ LINK_FLECHE1_SPR+#100
LINK_FLECHE_B			equ LINK_FLECHE1_SPR+#200:LINK_FLECHE_H		equ LINK_FLECHE1_SPR+#300

LINK_EPEE2_SPR			equ #F400
LINK_EPEE_G2			equ LINK_EPEE2_SPR
LINK_EPEE_D2			equ LINK_EPEE2_SPR+#100
LINK_EPEE_B2			equ LINK_EPEE2_SPR+#200
LINK_EPEE_H2			equ LINK_EPEE2_SPR+#300

LINK_EPEE3_SPR			equ #FC00
LINK_EPEE_G3			equ LINK_EPEE3_SPR
LINK_EPEE_D3			equ LINK_EPEE3_SPR+#100
LINK_EPEE_B3			equ LINK_EPEE3_SPR+#200
LINK_EPEE_H3			equ LINK_EPEE3_SPR+#300

; ////////////////////////////////////   PEROS  //////////////////////////////////////

SPRH_PECOR_ADR			equ	#c000
SPRH_VIEILLE_ADR		equ	#C100
SPRH_VIEUX_ADR			equ	#C200
SPRH_ZELDA1_ADR			equ	#C300
SPRH_CHAMPI_ROUGE_ADR	equ	#C400
SPRH_ZELDA2_ADR			equ #C500
SPRH_GOOMBA_ADR			equ #C600
SPRH_TODD1_ADR			equ #C700
SPRH_SARIA_ADR			equ #C800
SPRH_CHAMPI_VERT_ADR	equ	#C900
SPRH_CHAMPI_POURRIT_ADR	equ	#CA00
SPRH_TODD2_ADR			equ #CB00
MARIO_NU				equ	#CC00
PETIT_TODD_1_ADR		equ	#CD00
PETIT_TODD_2_ADR		equ	#CE00
PETIT_TODD_3_ADR		equ	#CF00


; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////////////////// ADRESSEs  ////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////

nbr_de_ligne_de_tiles	EQU	11
nbr_de_tiles			equ 16
link_en_haut_X_cave		equ  96
link_en_haut_Y_cave		equ	 80

; *************************** GESTION DES PIECES   *********************************
PIECE01			EQU	#4000
PIECE03			EQU	#4184
PIECE04			EQU	#4246
PIECE05			EQU	#4308
PIECE06			EQU	#43CA
PIECE26			EQU	#52F2
PIECE50			equ #6522
PIECE53			equ	#6768
PIECE33			EQU	#5840
PIECE12			EQU #4856
PIECE63			equ #6efc
PIECE75			equ #7814
PIECE78			equ #7A5A
PIECE80			equ #7BDE
PIECE93			equ #4856
PIECE101		equ #4e66
PIECE104		equ #50AC
BOUTIQUE		EQU	#40C2
MAISON			equ	#7CA0
DONJON_1_129	EQU #65E4
DONJON_2_147	EQU #7388
DONJON_3_165	EQU #4246
DONJON_4_184	EQU #50AC
OCEAN_221		equ	#621A


droite		equ		1
gauche		equ		2
haut		equ		3
bas			equ		4





; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////// ADRESSES SPRITE HUD  ////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////




HUD_F1_SPR			equ	#C11B	
HUD_F2_SPR			equ	#C124	
TEXTE_LIGNE1		EQU	#db89
TEXTE_LIGNE2		EQU	#dbC8
TARIFS				EQU	#FD8f
TEXTE_LIGNE3		EQU	#d289
TEXTE_LIGNE4		EQU	#D2CB
TEXTE_LIGNE5		EQU	#D314
MAP_ECRAN_ADR		equ	#C0C1

TEXTE_NBR_RUBI		equ	#CA1D
TEXTE_NBR_CLE		equ	#CA38
TEXTE_NBR_BOMBES	equ	#CA2B


; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////// PARAMETRE POUR LES SFX  ////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////////////////////////////////////////////////////////////////

PLY_AKG_MANAGE_SOUND_EFFECTS = 1
