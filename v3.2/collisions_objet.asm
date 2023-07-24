test_collisions_items

collision_objet_X1
	LD			hl,(SPRH0_X)					; à partir du coin haut-gauche de link
	LD			de,objet_link_X1							
	add		hl,de							; 31 pixels plus loin on est sur le coin haut-droite
	LD			de,(SPRH_X)						; à partir du coin haut-gauche du monstre
	SBC		hl,de
	RET		C								; si hl>=de le flag C est à zero
collision_objet_X2
	LD			hl,(SPRH_X)						; à partir du coin haut-gauche du monstre
	LD			de,objet_link_X2						
	add		hl,de							; 31 pixels plus loin on est sur le coin haut_droite
	LD			de,(SPRH0_X)					; à partir du coin haut-gauche de link
	SBC		hl,de
	RET		C
collision_objet_Y1
	LD			hl,(SPRH0_Y)					; à partir du coin haut-gauche de link
	LD			de,objet_link_Y1
	add		hl,de							; 15 pixels plus loin (sinon Golem va me faire un caca nerveu si j'écrit 16) 
											; on est sur le coin haut-droite
	LD			de,(SPRH_Y)						; à partir du coin haut-gauche du monstre
	SBC		hl,de
	RET 		C								; si hl>=de le flag C est à zero
collision_objet_Y2
	LD		hl,(SPRH_Y)						; à partir du coin haut-gauche de link
	LD		de,objet_link_Y2
	add		hl,de							; 15 pixels plus loin (sinon Golem va me faire un caca nerveu si j'écrit 16) 
											; on est sur le coin haut-droite
	LD		de,(SPRH0_Y)					; à partir du coin haut-gauche du monstre
	SBC		hl,de
	Jr 		NC,Link_ramasse					; si hl>=de le flag C est à zero
	RET
	
Link_ramasse
	ld 		a,4	 ;Sound effect number (>=1)
    ld 		c,2 ;channel (0-2)
    ld 		b,0 ;Inverted volume (0-16)
    call 	PLY_AKG_PlaySoundEffect
	ld 		a,(identification_monstre_en_cours)
	ld 		hl,table_items_efface
	add 	a, a       ; index x 2     
	ld 		e, a 
	ld 		d, 0
	add 	hl, de 
	ld 		a, (hl)
	inc 	hl 
	ld 		h, (hl)
	ld 		l, a 
	jp 		(hl)         			; ce sont tes routines pre_mort_monstre, qui se termine par un ret

table_items_efface
dw	0,efface_event_monstre_1,efface_event_monstre_2,efface_event_monstre_3,efface_event_monstre_4,efface_event_monstre_5,efface_event_monstre_6,efface_event_monstre_7,efface_objet_gauche,efface_objet_centre,efface_objet_droite,mort_definitive_du_poisson
	ret
	
	
	
	
	