
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////      VARIABLES       ///////////////////////////////////////
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////

; _____________________________________________
;                  flags system    
; _____________________________________________
flag_asic				ds	1,0					:  flag_asic_save			ds	1,0
flag_rom				ds	1,0					:  flag_rom_save			ds	1,0
flag_mode				ds	1,0					:  flag_mode_save			ds	1,0
flag_C4					ds	1,0					:  flag_C4_save				ds	1,0
flag_C5					ds	1,0					:  flag_C6					ds	1,0
flag_C7					ds	1,0					:  flag_C0					ds	1,0

; _____________________________________________
;                  flags du gameplay    
; _____________________________________________

flag_fire1					ds	1,0				:  	flag_fire2				ds	1,0
flag_invulnerable			ds	1,0				:  	flag_type_arme_utilise	ds	1,0
link_bouge					ds	1,0				:  	flag_stop_monstres		ds	1,0
direction_fleche_en_cours	ds	1,0				:  	une_fleche_est_en_cours	ds	1,0
compteur_bombe_en_cours		ds	1,0 			:  	une_bombe_est_en_cours	ds	1,0
direction_feu_en_cours		ds	1,0				:  	un_feu_est_en_cours		ds	1,0
compteur_anim_feu			ds	1,0				:  	compteur_anim_flammes	ds	1,0
flag_flammes				ds	1,0				:	flag_gameover_init		ds	1,0
etape_3_boule_de_feu		ds	1,0				: 	etape_3_boule_de_feu2	ds	1,0
etape_3_boule_de_feu3		ds	1,0				: 	flag_maison				ds	1,0
save_gps_hyrule				ds	2,0				: 	attendu_fondue_pallette	ds	1,0
save_musique_retour			ds	1,0				: 	flag_ocean				ds	1,0
temps_d_attente_objet		ds	1,0				: 	etape_zelda				ds	1,0
flag_zelda_RIP				ds	1,0				:	type_de_palette			ds	2,0		: type_de_palette2	ds  2,0
init_indice_donjon			ds	1,0				: 	flag_chez_zelda			ds	1,0
compteur_gros_link			ds	1,0				:	flag_premort			ds	1,0
flag_affiche_heritier		ds	1,0				:  puissance_epee			ds	2,0
monstre_a_faire_reculer		ds	1,0				:   flag_zelda				ds	1,0
recul_X_monstre				ds	2,0				:	flag_route_vers_zelda	ds	1,0
recul_Y_monstre				ds	2,0				:   flag_recul_en_cours			ds	1,0			
compteur_de_recul			ds	1,0				:	SPRH_X_recul				ds	2,0				
SPRH_Y_recul				ds	2,0				:   direction_du_recul			ds	1,0	
flag_fleche_illimite		ds	1,0				:	compteur_sans_attaquer		ds	1,0				
compteur_sans_tirer			ds	1,0				:	flag_contact_fee			ds	1,0
pointeur_ecriture_aleatoire ds  2,0				:	pointeur_objets_aleatoires	ds	2,0		
est_ce_des_kesses			ds	2,0				:   flag_switch					ds	1,0		
on_peut_utiliser_le_radeau	ds	1,0				:   nombre_de_pas				ds	1,0		
link_joue					ds	1,0				:   cycle_colorisation_link		ds	1,0
nouvelle_partie				ds	1,0




TABLEAU_MONSTRES_TOUCHES					
flag_monstre_1_touche		ds	1,0
flag_monstre_2_touche		ds	1,0
flag_monstre_3_touche		ds	1,0
flag_monstre_4_touche		ds	1,0
flag_monstre_5_touche		ds	1,0
flag_monstre_6_touche		ds	1,0
flag_monstre_7_touche		ds	1,0


vitesse_link_gauche		ds	2,0
vitesse_link_droite		ds	2,0
vitesse_link_haut		ds	2,0
vitesse_link_bas		ds	2,0
vitesse_link_X			ds	2,0
vitesse_link_Y			ds	2,0

flag_champi_rouge		ds	1,0
flag_champi_vert		ds	1,0
flag_champi_pourrit		ds	1,0



compteur_bouclier1		ds	1,0
compteur_bouclier2		ds	1,0
; _____________________________________________
;               compteurs d' objets  
; _____________________________________________
nbr_rubi				ds	2,0
nbr_cle					ds	1,0
nbr_bombe				ds	2,0
nbr_bouclier			ds	1,0
nbr_bougie				ds	1,0
nbr_fiole_bleu			ds	1,0
nbr_fiole_rouge			ds	1,0


COMPTEUR_OBJET_HUD
		compteur_rubi
				db	0,0,0
		compteur_cle
				db	0,0,0
		compteur_bombe
				db	0,0,0

; _____________________________________________
;        flags des objets  de  L'INVENTAIRE  
; _____________________________________________
FLAG_GAMEOVER
flag_bougie						ds	1,0	
flag_fleche						ds	1,0
flag_arc						ds	1,0
flag_arc_et_fleche				ds	1,0
flag_flute						ds	1,0
flag_radeau						ds	1,0
flag_echelle					ds	1,0
flag_baton						ds	1,0
flag_parchemin					ds	1,0
flag_fiole_bleu					ds	1,0					
flag_fiole_rouge				ds	1,0
flag_triforce_1					ds	1,0					
flag_triforce_2					ds	1,0				
flag_triforce_3					ds	1,0
flag_triforce_4					ds	1,0
flag_viande						ds	1,0	
flag_porte_donjon_1				ds 	1,0
flag_porte_donjon_2				ds 	1,0
flag_porte_donjon_3				ds 	1,0
flag_porte_donjon_4				ds 	1,0
flag_bague						ds	1,0	
flag_bague2						ds	1,0
flag_cle_donjon					ds	1,0	
flag_donjon1_ouvert				ds	1,0
flag_donjon2_ouvert				ds	1,0
flag_donjon3_ouvert				ds	1,0
flag_donjon4_ouvert				ds	1,0	




flag_rien				ds	1,0 : flag_sci				ds	1,0 : flag_pang				ds	1,0
flag_game				ds	1,0 : SPRH_JEU_ADR			ds	2,0 : flag_noexit				ds	1,0
flag_tintin				ds	1,0 : flag_burningrubber		ds	1,0	 : flag_wildstreet			ds	1,0	

flag_epee_01					ds	1,0
flag_epee_02					ds	1,0
flag_epee_03					ds	1,0
flag_bouclier					ds	1,0
flag_bouclier2					ds	1,0
flag_bouclier3					ds	1,0
flag_god						ds	1,0
; Objets en lien avec la santé de link
nbr_vies						ds	1,0			
nbr_vies_max					ds	1,0
flag_receptacle_coeur07			ds	1,0			: flag_fiole_rouge_gratuite_07	ds		1,0
flag_receptacle_coeur61			ds	1,0			: flag_fiole_rouge_gratuite_61	ds		1,0
flag_receptacle_coeur73			ds	1,0			: flag_fiole_rouge_gratuite_73	ds		1,0
flag_receptacle_coeur91			ds	1,0			: flag_fiole_rouge_gratuite_91	ds		1,0
flag_receptacle_coeur127		ds	1,0			: flag_fiole_rouge_gratuite_127	ds		1,0
flag_receptacle_coeur_donjon1	ds	1,0			: flag_receptacle_coeur_donjon2	ds		1,0
flag_receptacle_coeur_donjon3	ds	1,0			: flag_receptacle_coeur_donjon4	ds		1,0

flag_fiole_rouge_gratuite		ds	1,0


flag_bombe			ds	1,0	


flag_flute_ok		ds	1,0					:	flag_boussole	ds	1,0					:  flag_carte		ds	1,0
				
;flag_manette		ds	1,0					
		
			 
;flag_bracelet	ds	1,0					
flag_perso_special	ds 1,0
flag_rubi_vert		ds	1,0		


				
; _____________________________________________
;        flags des objets  dans LE JEU  
; _____________________________________________
flag_coeur					ds	1,0				:  flag_cle			ds	1,0
flag_rubi_bleu86_1			ds	1,0				: flag_rubi_bleu86_2  		ds	1,0	
flag_rubi_bleu86_3			ds	1,0				: flag_rubi_bleu86_gagne	ds	1,0	
flag_rubi_bleu02_gagne		ds	1,0				: flag_rubi_bleu08_gagne	ds	1,0		
flag_rubi_bleu116_gagne		ds	1,0				: flag_rubi_bleu120_gagne	ds	1,0		
flag_rubi_bleu_1	ds	1,0				: flag_rubi_bleu_2	  ds	1,0				: flag_rubi_bleu_3		ds	1,0
flag_rubi26			ds	1,0				: flag_rubi111		ds	1,0					: flag_rubi70			ds	1,0
flag_rubi72			ds	1,0				: flag_rubi60		ds	1,0					: flag_rubi62			ds	1,0
flag_rubi31			ds	1,0				: flag_rubi35		ds	1,0					: flag_rubi127			ds	1,0
flag_rubi19			ds	1,0				: flag_rubi54		ds	1,0					: flag_rubi39			ds	1,0
flag_rubi20			ds	1,0				: flag_rubi46		ds	1,0					: gain_rubi_bleu26		ds 	2,0			

; _____________________________________________
;        flags des CARTES des DONJONS 
; _____________________________________________
flag_donjon				ds	1,0			: flag_ok_affiche_carte		ds	1,0			: flag_carte_de_ce_donjon	ds	1,0
flag_no_donjon			ds	1,0			: objet_donjon_label		ds	2,0			: flag_objet_donjon			ds	1,0
flag_carte_donjon1		ds	1,0			: flag_carte_donjon2		ds	1,0			: flag_carte_donjon3		ds	1,0	
flag_carte_donjon4		ds	1,0			

; _____________________________________________
;              flags présence ennemis     
; _____________________________________________
flag_anim_2_sprites		ds	1,0					:  flag_anim_4_sprites		ds	1,0 
flag_peahat				ds	1,0					
flag_ghini				ds	1,0					:  flag_keeses				ds	1,0
flag_zora				ds	1,0					:  flag_bouledefeu			ds	1,0
flag_boss_donjon		ds	1,0					:  boss_donjon_label		ds	2,0
flag_boss1_RIP			ds	1,0					: 	flag_boss2_RIP			ds	1,0
flag_boss3_RIP			ds	1,0					:  flag_boss4_RIP			ds	1,0
; _____________________________________________
;             FLAGS ZOOM DES SPITES HARD 
; _____________________________________________
FLAGS_ZOOM											;			//\
flag_sprh0						ds	1,0				;		 //    \\
flag_sprh1						ds	1,0				;		//  !!  \\
flag_sprh2						ds	1,0				;	   //   !!   \\
flag_sprh3						ds	1,0				;     //    !!    \\ 
flag_sprh4						ds	1,0				;    ///////////////
flag_monstre1					ds	1,0		
flag_monstre2					ds	1,0				;		ATTENTION A
flag_monstre3					ds	1,0				;	GARDER LE MEME ODRE
flag_monstre4					ds	1,0
flag_monstre5					ds	1,0
flag_monstre6					ds	1,0
flag_monstre7					ds	1,0
flag_monstre_zora				ds	1,0
flag_sprh13						ds	1,0
flag_sprh14						ds	1,0
flag_sprh15						ds	1,0
MEM_TAMPON_FLAGS_ZOOM			ds	16,0

; __________________________________________________
;                   RADAR  GPS
; __________________________________________________

flag_radar					ds	1,0				: flag_radar_piece_special			ds	1,0
flag_calcul					ds	1,0				: gps								ds	2,0
dep_gps_gauche				ds	2,0				: dep_gps_droite					ds	2,0
dep_gps_haut_1				ds	2,0				: dep_gps_haut_2					ds	2,0
dep_gps_bas_1				ds	2,0				: dep_gps_bas_2						ds	2,0
couleur_fond_gps			ds	1,0				: couleur_link_gps					ds	1,0
couleur_fond2_gps			ds	1,0
; __________________________________________________
;                   BOUSSOLE
; __________________________________________________

boussole_de_ce_donjon_adr		ds	2,0				: flag_boussole_donjon_1			ds	1,0
flag_boussole_donjon_2			ds	1,0				: flag_boussole_donjon_3			ds	1,0
flag_boussole_donjon_4			ds	1,0				



flag_les_monstres_sont_tues		ds	1,0
objet_hud_fire1			ds	1,0
objet_hud_fire2			ds	1,0
flag_naissance_en_cours	ds	1,0
flag_mort_en_cours		ds	1,0
flag_naissance_link		ds	1,0

direction_retablit		ds	2,0

;etape_gameover			ds	1,0
;compteur_gameover		ds	1,0
;cycle_fire1_et_2			ds	1,0

flag_vie_parite			ds	1,0

nbr_tour_complet		ds	1,0
compteur_link_touche	ds	1,0
compteur_invulnerable	ds	1,0
pointeur_table_vie		ds	2,0
type_objet_laisse		ds	1,0
objet_piece_no			ds	1,0
selection_curseur		ds	1,0
resultat_test_de_touche	ds	1,0
flag_boutique			ds	1,0
flag_mario_nu			ds	1,0
attente_vers_la_fin		ds	1,0


etape_objet_spawn_donjon	ds	1,0
etape_passage_spawn_donjon	ds	1,0

flag_inventaire			ds	1,0

flag_ajoute_vie			ds	1,0
tile_cave				ds	2,0
flag_cave				ds	1,0


no_tile_a_ecrire		ds	1,0
no_tile_a_ecrire2		DS	2,0
tile_a_ecrire			ds	2,0
tile_a_ecrire2			ds	2,0
posx_spr0_cave			ds	2,0
posy_spr0_cave			ds	2,0
; ////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////  FLAGS DES OBJETS INVENTAIRE //////////////////////
; ////////////////////////////////////////////////////////////////////////////////

objet1_sous_curseur	ds	2,0
objet2_sous_curseur	ds	2,0
objet3_sous_curseur	ds	2,0
objet4_sous_curseur	ds	2,0
objet5_sous_curseur	ds	2,0
objet6_sous_curseur	ds	2,0
objet7_sous_curseur	ds	2,0
objet8_sous_curseur	ds	2,0


flag_objet_gauche	ds	2,0
flag_objet_droite	ds	2,0
flag_objet_centre	ds	2,0
; ////////////////////////////////////////////////////////////////////
; ////////////////////////////  LINK /////////////////////////////////
; ////////////////////////////////////////////////////////////////////

; ********************** Initialisations ************************

VARIABLE_INIT_LINK
TYPE_LINK_ADR					ds	2,0
bankROM_link1					ds	2,0
SPRH_LINK_ADR					ds	2,0
EPEE_SPR						ds	2,0
FLECHE_SPR						ds	2,0
SPRH0_GAMEOVER				ds	2,0
adr_ecran_demis_coeur		ds	2,0
collision_spr3_posx			ds	3,0
collision_spr3_posy			ds	3,0
ligne_tile_spr3_posY		ds	3,0
ligne_tile_spr3_posX		ds	3,0
tile_a_lire_spr3			ds	2,0
ntile_spr3					ds	1,0
nieme_tile_de_maptile		ds	2,0
resultat_piece_grottes		ds	2,0
pointeur_grottes			ds	1,0
FEU_SPR						ds	2,0
FEU_SPR_ANIM_1				ds	2,0
FEU_SPR_ANIM_2				ds	2,0
compteur_distanceX				ds	1,0
compteur_distanceY				ds	1,0
compteur_attaque_epee			ds	1,0
Cycle_epee						equ	10
pointeur_link					ds	1,0
flag_etape_link1				ds	1,0
compteur_anim_link				ds	1,0
direction_en_cours				ds	1,0
LINK_ADR						ds	2,0
LINK1_ADR						ds	2,0
compteur_poisson				ds	1,0
compteur_poisson_absent			ds	1,0
compteur_mort_definitive		ds	1,0
compteur_etape_objet_hyrule		ds	1,0
une_bouledefeu_est_en_cours		ds	1,0
une_bouledefeu_est_en_cours2	ds	1,0
direction_bouledefeu_en_cours	ds	1,0
flag_derniere_boule				ds	1,0
zora_nage						ds	1,0
SPRH_ZY							ds	2,0
SPRH_ZX							ds	2,0
map_a_lire						ds	2,0
radeau_en_cours					ds	1,0
flag_attente_inc_feu			ds	1,0
flag_porte_au_loin				ds	1,0

; ////////////////////////////////////////////////////////////////////
; ////////////////////////////  MONSTRES /////////////////////////////
; ////////////////////////////////////////////////////////////////////
resultat_piece_monstre			ds	2,0
; /////////////////////////// Initialisations ////////////////////////
; MONSTRE 1
table_init_monstre_1			equ	#C000
VARIABLE_INIT_MONSTRE_1
TYPE_MONSTRE1_ADR				ds	2,0
bankROM_monstre_1				ds	2,0
SPRH_MONSTRE1_ADR				ds	2,0
nombre_de_coups_1				ds	2,0				; poid fort pour l'épée, poid faible pour les flêches
objet_laisse_1					ds	2,0				;seule le poid faible est utilisé pour l'objet 

; MONSTRE 2
table_init_monstre_2			equ	#D2D0
VARIABLE_INIT_MONSTRE_2
TYPE_MONSTRE2_ADR				ds	2,0
bankROM_monstre_2				ds	2,0
SPRH_MONSTRE2_ADR				ds	2,0
nombre_de_coups_2				ds	2,0
objet_laisse_2					ds	2,0				;seule le poid faible est utilisé pour l'objet 

; MONSTRE 3
table_init_monstre_3			equ	#E5A0
VARIABLE_INIT_MONSTRE_3
TYPE_MONSTRE3_ADR				ds	2,0
bankROM_monstre_3				ds	2,0
SPRH_MONSTRE3_ADR				ds	2,0
nombre_de_coups_3				ds	2,0
objet_laisse_3					ds	2,0				;seule le poid faible est utilisé pour l'objet 

; MONSTRE 4
table_init_monstre_4			equ	#C000
VARIABLE_INIT_MONSTRE_4
TYPE_MONSTRE4_ADR				ds	2,0
bankROM_monstre_4				ds	2,0
SPRH_MONSTRE4_ADR				ds	2,0
nombre_de_coups_4				ds	2,0
objet_laisse_4					ds	2,0				;seule le poid faible est utilisé pour l'objet 

; MONSTRE 5
table_init_monstre_5			equ	#D2D0
VARIABLE_INIT_MONSTRE_5
TYPE_MONSTRE5_ADR				ds	2,0
bankROM_monstre_5				ds	2,0
SPRH_MONSTRE5_ADR				ds	2,0
nombre_de_coups_5				ds	2,0
objet_laisse_5					ds	2,0				;seule le poid faible est utilisé pour l'objet 

; MONSTRE 6
table_init_monstre_6			equ	#E5A0
VARIABLE_INIT_MONSTRE_6
TYPE_MONSTRE6_ADR				ds	2,0
bankROM_monstre_6				ds	2,0
SPRH_MONSTRE6_ADR				ds	2,0
nombre_de_coups_6				ds	2,0
objet_laisse_6					ds	2,0				;seule le poid faible est utilisé pour l'objet 

; MONSTRE 7
table_init_monstre_7			equ	#C000
VARIABLE_INIT_MONSTRE_7
TYPE_MONSTRE7_ADR				ds	2,0
bankROM_monstre_7				ds	2,0
SPRH_MONSTRE7_ADR				ds	2,0
nombre_de_coups_7				ds	2,0
objet_laisse_7					ds	2,0				;seule le poid faible est utilisé pour l'objet 

; MONSTRE GENERALE
VARIABLE_INIT_MONSTRE
TYPE_MONSTRE_ADR				ds	2,0
bankROM							ds	1,0
bankrom_save					ds	1,0
SPRH_ADR						ds	2,0

; POISSON ZORA
VARIABLE_INIT_POISSON
TYPE_POISSON_ADR				ds	2,0
bankROM_poisson_zora			ds	2,0
SPRH_POISSON_ADR				ds	2,0
nombre_de_coups_p				ds	1,0

; GROTTES ETC
VARIABLE_INIT_GROTTES
ZORA_X							ds	2,0
ZORA_Y							ds	2,0
GROTTES_ADR						ds	2,0
PASSAGE_ADR						ds	2,0
table_init_grottes				equ	#D2D0

ZORA_en_X						ds	2,0
ZORA_en_Y						ds	2,0
position_zora					ds	1,0

; /////////////////////////// FLAGS & POINTEURS ////////////////////////
flag_etape_du_monstre			ds	1,0
flag_etape_du_monstre1			ds	1,0
flag_etape_du_monstre2			ds	1,0
flag_etape_du_monstre3			ds	1,0
flag_etape_du_monstre4			ds	1,0
flag_etape_du_monstre5			ds	1,0
flag_etape_du_monstre6			ds	1,0
flag_etape_du_monstre7			ds	1,0
flag_etape_du_poisson			ds	1,0
flag_etape_du_boss1				ds	1,0
flag_etape_du_boss2				ds	1,0
flag_etape_du_boss3				ds	1,0

pointeur_monstres				ds	2,0
pointeur_monstres2				ds	2,0
pointeur_monstres3				ds	2,0
pointeur_monstres4				ds	2,0
pointeur_monstres5				ds	2,0
pointeur_monstres6				ds	2,0
pointeur_monstres7				ds	2,0
pointeur_poisson				ds	2,0

pointeur_direction				ds	4,0
pointeur_direction2				ds	4,0
pointeur_direction3				ds	4,0	
pointeur_direction4				ds	4,0
pointeur_direction5				ds	4,0
pointeur_direction6				ds	4,0
pointeur_direction7				ds	4,0
pointeur_direction_zora			ds	4,0
pointeur_direction_boss1		ds	4,0
pointeur_direction_boss2		ds	4,0
pointeur_direction_boss3		ds	4,0

identification_monstre_en_cours	ds	1,0
identification_monstre1			ds	1,0
identification_monstre2			ds	1,0
identification_monstre3			ds	1,0
identification_monstre4			ds	1,0
identification_monstre5			ds	1,0
identification_monstre6			ds	1,0
identification_monstre7			ds	1,0

on_bouge_monstre1_ou_pas		ds	1,0
on_bouge_monstre2_ou_pas		ds	1,0
on_bouge_monstre3_ou_pas		ds	1,0
on_bouge_monstre4_ou_pas		ds	1,0



; //////////////////////////// NAISSANCE & MORT ///////////////////////
init_naissance_boucle			equ	31
cycle_naissance_1				equ	30
cycle_naissance_2				equ	10
cycle_naissance_3				equ	5
init_naissance_boucle_zora			equ	71
cycle_naissance_1_zora				equ	70
cycle_naissance_2_zora				equ	60
cycle_naissance_3_zora				equ	50
cycle_naissance_4_zora				equ	40
cycle_naissance_5_zora				equ	30
cycle_naissance_6_zora				equ	20
cycle_naissance_7_zora				equ	10
compteur_naissance_monstre_1		ds	1,0
compteur_naissance_monstre_2		ds	1,0
compteur_naissance_monstre_3		ds	1,0
compteur_naissance_monstre_4		ds	1,0
compteur_naissance_monstre_5		ds	1,0
compteur_naissance_monstre_6		ds	1,0
compteur_naissance_monstre_7		ds	1,0
compteur_naissance_poisson			ds	1,0
attente_naissance_des_monstres		ds	1,0
init_mort_boucle				equ	16
cycle_mort_1					equ	15
cycle_mort_2					equ	10
cycle_mort_3					equ	5
init_mort_boucle_zora				equ	71
cycle_mort_1_zora					equ	70
cycle_mort_2_zora					equ	60
cycle_mort_3_zora					equ	50
cycle_mort_4_zora					equ	40
cycle_mort_5_zora					equ	30
cycle_mort_6_zora					equ	20
cycle_mort_7_zora					equ	10
compteur_mort_monstre_1			ds	1,0
compteur_mort_monstre_2			ds	1,0
compteur_mort_monstre_3			ds	1,0
compteur_mort_monstre_4			ds	1,0
compteur_mort_monstre_5			ds	1,0
compteur_mort_monstre_6			ds	1,0
compteur_mort_monstre_7			ds	1,0
compteur_mort_poisson			ds	1,0


; //////////////////////////// ANIMATIONS //////////////////////
init_anim_boucle			equ	17
cycle_anim_1				equ	16
cycle_anim_2				equ	8
compteur_anim_monstre_1			ds	1,0		; pas optimisable sinon saccade
compteur_anim_monstre_2			ds	1,0		; de l'animation	
compteur_anim_monstre_3			ds	1,0
compteur_anim_monstre_4			ds	1,0
compteur_anim_monstre_5			ds	1,0
compteur_anim_monstre_6			ds	1,0
compteur_anim_monstre_7			ds	1,0
compteur_anim_boss_3			ds	1,0
compteur_anim_boss_4			ds	1,0
; ////////////////////////////// DEPLACEMENTS /////////////////////////////
;flag_etat_du_dep			ds	1,0
;flag_etat_du_dep2			ds	1,0
;flag_etat_du_dep3			ds	1,0
;flag_etat_du_dep4			ds	1,0
;flag_etat_du_dep5			ds	1,0
;flag_etat_du_dep6			ds	1,0
;flag_etat_du_dep7			ds	1,0
;flag_etat_du_dep_boss1		ds	1,0
;flag_etat_du_dep_boss2		ds	1,0
;flag_etat_du_dep_boss3		ds	1,0


compteur_depX_monstre_1			ds	1,0
compteur_depY_monstre_1			ds	1,0
pointeur_depX_monstre_1			ds	2,0
pointeur_depY_monstre_1			ds	2,0

compteur_depX_monstre_2			ds	1,0
compteur_depY_monstre_2			ds	1,0
pointeur_depX_monstre_2			ds	2,0
pointeur_depY_monstre_2			ds	2,0

compteur_depX_monstre_3			ds	1,0
compteur_depY_monstre_3			ds	1,0
pointeur_depX_monstre_3			ds	2,0
pointeur_depY_monstre_3			ds	2,0

compteur_depX_monstre_4			ds	1,0
compteur_depY_monstre_4			ds	1,0
pointeur_depX_monstre_4			ds	2,0
pointeur_depY_monstre_4			ds	2,0

compteur_depX_monstre_5			ds	1,0
compteur_depY_monstre_5			ds	1,0
pointeur_depX_monstre_5			ds	2,0
pointeur_depY_monstre_5			ds	2,0


compteur_depX_monstre_6			ds	1,0
compteur_depY_monstre_6			ds	1,0
pointeur_depX_monstre_6			ds	2,0
pointeur_depY_monstre_6			ds	2,0

compteur_depX_monstre_7			ds	1,0
compteur_depY_monstre_7			ds	1,0
pointeur_depX_monstre_7			ds	2,0
pointeur_depY_monstre_7			ds	2,0

compteur_depX_boss_1			ds	1,0
compteur_depY_boss_1			ds	1,0
pointeur_depX_boss_1			ds	2,0
pointeur_depY_boss_1			ds	2,0
compteur_depX_boss_2			ds	1,0
compteur_depY_boss_2			ds	1,0
pointeur_depX_boss_2			ds	2,0
pointeur_depY_boss_2			ds	2,0
compteur_depX_boss_3			ds	1,0
compteur_depY_boss_3			ds	1,0
pointeur_depX_boss_3			ds	2,0
pointeur_depY_boss_3			ds	2,0


compteur_direction			ds	1,0
compteur_direction2			ds	1,0
compteur_direction3			ds	1,0
compteur_direction4			ds	1,0
compteur_direction5			ds	1,0
compteur_direction6			ds	1,0
compteur_direction7			ds	1,0
compteur_direction_boss1	ds	1,0
compteur_direction_boss2	ds	1,0
compteur_direction_boss3	ds	1,0
nbr_direction				equ	32


direction_en_cours_boss2	ds	1,0


No_DONJON				ds  1,0
No_PIECE				DS	2,0
No_PIECE_RETOUR			DS	2,0
No_BANK					ds	1,0
No_BANK_RETOUR			ds	1,0
PIECE_ACTUELLE 			db 	0,0
RETOUR_PIECE_ACTUELLE	db 0,0


RIEN					ds	2,0

; **********************************************************************************
; *************************** GESTION DES COLLISIONS   *****************************
; **********************************************************************************
COLLISION_Y	EQU	8
vitesseX 			equ 	4
vitesseY 			equ 	2
vitesseX_monstres	equ		#02
vitesseY_monstres	equ		#01

collision_spr0_posy ds 3,0
collision_spr0_posx ds 3,0
collision_spr1_posy ds 3,0
collision_spr1_posx ds 3,0
collision_spr1_posx2 ds 3,0

ligne_tile_spr0_posX	Ds	3,0
ligne_tile_spr0_posY	Ds	3,0
ligne_tile_spr1_posY	Ds	3,0
ligne_tile_spr1_posX	Ds	3,0
ligne_tile_spr1_posX2	Ds	3,0

tile_a_lire_spr0	Ds	2,0
tile_a_lire_spr1	Ds	2,0
tile_a_lire_spr1bis	Ds	2,0

ntile_spr0	ds	1,0
ntile_spr1	ds	1,0
ntile_spr1bis	ds	1,0

posx_spr0 	ds 	2,0
posy_spr0 	ds 	2,0

posx_spr0_boutique	ds	2,0
posy_spr0_boutique	ds	2,0

posx_spr0_donjon	ds	2,0
posy_spr0_donjon	ds	2,0

bord_gauche		ds  2,0
bord_droit		ds  2,0
bord_haut		ds  2,0
bord_bas		ds  2,0

link_en_haut		ds	2,0
link_en_bas			ds	2,0
link_a_droite		ds	2,0
link_a_gauche		ds	2,0

decalage_epee_gauche	ds	2,0
decalage_epee_droite	ds	2,0
decalage_epee_bas	ds	2,0
decalage_epee_haut	ds	2,0

SPRH_DESCENDENCE	ds	2,0
SPRH_DESCENDENCE_ADR	ds	2,0
SPRH_DESCENDENCE_ZOOM	ds	2,0

; ************************ Affichage ****************************

SPRH0_ANIM_1				ds	2,0
SPRH0_ANIM_2				ds	2,0
SPRH1_ANIM_1				ds	2,0
SPRH1_ANIM_2				ds	2,0
SPRH5_ANIM_1				ds	2,0
SPRH5_ANIM_2				ds	2,0
SPRH6_ANIM_1				ds	2,0
SPRH6_ANIM_2				ds	2,0
SPRH7_ANIM_1				ds	2,0
SPRH7_ANIM_2				ds	2,0
SPRH8_ANIM_1				ds	2,0
SPRH8_ANIM_2				ds	2,0
SPRH9_ANIM_1				ds	2,0
SPRH9_ANIM_2				ds	2,0
SPRH10_ANIM_1				ds	2,0
SPRH10_ANIM_2				ds	2,0
SPRH11_ANIM_1				ds	2,0
SPRH11_ANIM_2				ds	2,0




; ***********************************************************************************************
; ***************************  ADRESSES RELATIVES AUX SPRITES HARD ******************************
; ***********************************************************************************************
SPRH_X			ds	2,0
SPRH_Y			ds	2,0
SPRH_TYPE_ZOOM	ds	2,0
MEM_TAMPON_COORDONNEES_SPRH 	DS	64,0

sprite_a_lire		ds	2,0
emplacement			ds	2,0
hauteur_de_sprite	ds	1,0
longueur_de_sprite	ds	2,0

PERSO_SPR_ADR2		ds	2,0
PERSO_SPR_ADR		ds	2,0
OBJET_AUTRE_ADR		ds	2,0						; !!!!!!!!!!!!! ATTENTION !!!!!!!!!!!!!!!
OBJET_GAUCHE_ADR	ds	2,0						; !!!!!!!!!!!!!!!!    !!!!!!!!!!!!!!!!!!!
OBJET_CENTRE_ADR	ds	2,0						; !!!!!!!!!!!!!!!!!  !!!!!!!!!!!!!!!!!!!!
OBJET_DROITE_ADR	ds	2,0						; !!!!!!!  ---> CONSERVER L'ORDRE !!!!!!!

DEPART_DU_TEXTE		ds	2,0
DEPART_DU_TEXTE_1		ds	2,0
DEPART_DU_TEXTE_2		ds	2,0
DEPART_DU_TEXTE_3		ds	2,0
nombre_de_lettre	ds	1,0
nbr_de_ligne		ds	1,0
texte_boutique		ds	2,0
texte_boutique_ligne1		ds	2,0
texte_boutique_ligne2		ds	2,0
texte_boutique_ligne3		ds	2,0
flag_texte			ds	1,0
lettre_en_cours		ds	2,0
compteur_de_lettre	ds	1,0
compteur_attente_texte		ds	1,0
compteur_attente_objet	ds	1,0


etape_boss_1		ds	1,0
cycle_anim_boss_1	ds	1,0
etape_boss_2		ds	1,0
cycle_anim_boss_2	ds	1,0
etape_boss_3		ds	1,0
cycle_anim_boss_3	ds	1,0
etape_boss_4		ds	1,0
cycle_anim_boss_4	ds	1,0

type_objet				ds	1,0	
type_objet_centre		ds	1,0	
type_objet_gauche		ds	1,0
type_objet_droite		ds	1,0



selection_compteur		ds	2,0

tarif_objet				ds 1,0
adr_ecran_affiche_coeur		ds	2,0
adr_memoire_coeur			ds	2,0

chiffre_des_centaines	ds		2,0
chiffre_des_dizaine		ds		2,0
chiffre_des_unitees		ds		2,0
reste					ds		2,0	
flag_retenue			ds		1,0

	
COUT_OBJET_BOUTIQUE	
cout_bouclier
	db	1,6,0
cout_bougie
	db	0,6,0
cout_fiole_bleue
	db	0,4,0
cout_fiole_rouge
	db	0,6,8
cout_fleche
	db	0,8,0
cout_bombe
	db	0,2,0

