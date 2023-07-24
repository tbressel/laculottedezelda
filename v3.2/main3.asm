ORG CODE_PROGRAMME_2

gros_link_off
call	asic_on
ld		a,ZOOM_normal
ld		(SPRH_TYPE_ZOOM),a
ld		(SPRH0_ZOOM),a
ld		(SPRH1_ZOOM),a
xor		a
ld		(compteur_gros_link),a
ld		(flag_viande),a
ld		hl,0
ld		(decalage_epee_gauche),hl
ld		(decalage_epee_droite),hl
ld		(decalage_epee_haut),hl
ld		(decalage_epee_bas),hl

jp		il_se_passe_rien


sound
call PLY_AKG_Stop
ret



compteur_attaque
ld	a,(compteur_sans_attaquer)
inc	a
ld	(compteur_sans_attaquer),a
cp	a,temps_sans_attaquer
call	z,fire1_on
;call	fire2_on
ret


compteur_tirer
ld	a,(compteur_sans_tirer)
inc	a
ld	(compteur_sans_tirer),a
cp	a,temps_sans_tirer
call	z,fire2_on
;call	fire1_on
ret



read"monstre1.asm"
read"boule_de_feu.asm"
read"gestion_objets_hyrule.asm"
read"affiche_donjon.asm"
read"boss_donjon_1_RAM.asm"
read"boss_donjon_2_RAM.asm"
read"boss_donjon_3_RAM.asm"
read"boss_donjon_4_RAM.asm"
read"fin_du_jeu.asm"
read"echelle.asm"
read"collisions_objet.asm"


link_clignote
	ld		a,8
	ld		(Bankrom),a
	call	rom_on
	call	link_clignote_ROM8
	call	rom_off	
	ret


etape_gameover			ds	1,0
compteur_gameover		ds	1,0
cycle_fire1_et_2			ds	1,0

NETTOYAGE_SPRITES_HARD2
	call 	asic_on
	Xor 	a									; on met 0 dans A
	ld 		hl,#4000							; début à effacer en #0FFF
	ld 		e,l									
	ld 		d,h									
	inc 	de									; on incremente de 1 l'adresse à effacer
	ld 		(hl),a								; et on met 0 dans l'octet de l'adresse 
	LD 		BC,#1000							; sur une longueur de #3000
	ldir	
	ret


	


