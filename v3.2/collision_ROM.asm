; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; //////////////////////////////////////////////// COLLISION MONSTRES /////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
COLLISION_ROM
		or a
	collision_X1
		LD		hl,(SPRH0_X)					; à partir du coin haut-gauche de link
		LD		de,link_monstres_X1
		add		hl,de							; 31 pixels plus loin on est sur le coin haut-droite
		LD		de,(SPRH_X)						; à partir du coin haut-gauche du monstre
		SBC		hl,de
		RET		C								; si hl>=de le flag C est à zero
	collision_X2
		LD		hl,(SPRH_X)						; à partir du coin haut-gauche du monstre
		LD		de,link_monstres_X2
		add		hl,de							; 31 pixels plus loin on est sur le coin haut_droite
		LD		de,(SPRH0_X)					; à partir du coin haut-gauche de link
		SBC		hl,de
		RET		C
	collision_Y1
		LD		hl,(SPRH0_Y)					; à partir du coin haut-gauche de link
		LD		de,link_monstres_Y1
		add		hl,de							; 15 pixels plus loin (sinon Golem va me faire un caca nerveu si j'écrit 16) 
											; on est sur le coin haut-droite
		LD		de,(SPRH_Y)						; à partir du coin haut-gauche du monstre
		SBC		hl,de
		RET 	C								; si hl>=de le flag C est à zero
	collision_Y2
		LD		hl,(SPRH_Y)						; à partir du coin haut-gauche de link
		LD		de,link_monstres_Y2
		add		hl,de							; 15 pixels plus loin (sinon Golem va me faire un caca nerveu si j'écrit 16) 
											; on est sur le coin haut-droite
		LD		de,(SPRH0_Y)					; à partir du coin haut-gauche du monstre
		SBC		hl,de
		JP 		NC,Link_touche					; si hl>=de le flag C est à zero
		RET
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
COLLISION_EPEE_ROM
	collision_X1_epee
		LD		hl,(SPRH2_X)					; à partir du coin haut-gauche de link
		LD		de,epee_monstres_X1
		add		hl,de							; 32 pixels plus loin on est sur le coin haut-droite
		LD		de,(SPRH_X)						; à partir du coin haut-gauche du monstre
		SBC		hl,de
											; si HL>=DE le flag C est à zero
		RET		C								; si hl>=de le flag C est à zero
	collision_X2_epee
		LD		hl,(SPRH_X)						; à partir du coin haut-gauche du monstre
		LD		de,epee_monstres_X2
		add		hl,de							; 31 pixels plus loin on est sur le coin haut_droite
		LD		de,(SPRH2_X)					; à partir du coin haut-gauche de link
		SBC		hl,de
		RET		C
	collision_Y1_epee
		LD		hl,(SPRH2_Y)					; à partir du coin haut-gauche de link
		LD		de,epee_monstres_Y1
		add		hl,de							; 15 pixels plus loin (sinon Golem va me faire un caca nerveu si j'écrit 16) 
											; on est sur le coin haut-droite
		LD		de,(SPRH_Y)						; à partir du coin haut-gauche du monstre
		SBC		hl,de
											; si HL>=DE le flag C est à zero
		RET	 	C								; si hl>=de le flag C est à zero
	collision_Y2_epee
		LD		hl,(SPRH_Y)						; à partir du coin haut-gauche de link
		LD		de,epee_monstres_Y2
		add		hl,de							; 15 pixels plus loin (sinon Golem va me faire un caca nerveu si j'écrit 16) 
											; on est sur le coin haut-droite
		LD		de,(SPRH2_Y)					; à partir du coin haut-gauche du monstre
		SBC		hl,de
		jp 		NC,Link_tue						; si hl>=de le flag C est à zero
		ld 		c,2   ;Channel (0-2)
		call 	PLY_AKG_StopSoundEffectFromChannel
		RET
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
COLLISION_FLECHE_ROM
	collision_X1_fleche
		LD		hl,(SPRH3_X)					; à partir du coin haut-gauche de link
		LD		de,30
		add		hl,de							; 32 pixels plus loin on est sur le coin haut-droite
		LD		de,(SPRH_X)						; à partir du coin haut-gauche du monstre
		SBC		hl,de
											; si HL>=DE le flag C est à zero
		RET		C								; si hl>=de le flag C est à zero
	collision_X2_fleche
		LD		hl,(SPRH_X)						; à partir du coin haut-gauche du monstre
		LD		de,30
		add		hl,de							; 31 pixels plus loin on est sur le coin haut_droite
		LD		de,(SPRH3_X)					; à partir du coin haut-gauche de link
		SBC		hl,de
		RET		C
	collision_Y1_fleche
		LD		hl,(SPRH3_Y)					; à partir du coin haut-gauche de link
		LD		de,14
		add		hl,de							; 15 pixels plus loin (sinon Golem va me faire un caca nerveu si j'écrit 16) 
											; on est sur le coin haut-droite
		LD		de,(SPRH_Y)						; à partir du coin haut-gauche du monstre
		SBC		hl,de
											; si HL>=DE le flag C est à zero
		RET	 	C								; si hl>=de le flag C est à zero
	collision_Y2_fleche
		LD		hl,(SPRH_Y)						; à partir du coin haut-gauche de link
		LD		de,14
		add		hl,de							; 15 pixels plus loin (sinon Golem va me faire un caca nerveu si j'écrit 16) 
											; on est sur le coin haut-droite
		LD		de,(SPRH3_Y)					; à partir du coin haut-gauche du monstre
		SBC		hl,de
		jp 		NC,Link_tue						; si hl>=de le flag C est à zero
		ld 		c,2   ;Channel (0-2)
		call 	PLY_AKG_StopSoundEffectFromChannel
		RET
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
COLLISION_BOULEDEFEU_ROM
collision_X1_bouledefeu
	LD		hl,(SPRH0_X)					; à partir du coin haut-gauche de link
	LD		de,30
	add		hl,de							; 32 pixels plus loin on est sur le coin haut-droite
	LD		de,(SPRH13_X)					; à partir du coin haut-gauche du monstre
	SBC		hl,de
	RET		C								; si hl>=de le flag C est à zero
collision_X2_bouledefeu
	LD		hl,(SPRH13_X)					; à partir du coin haut-gauche du monstre
	LD		de,30
	add		hl,de							; 31 pixels plus loin on est sur le coin haut_droite
	LD		de,(SPRH0_X)					; à partir du coin haut-gauche de link
	SBC		hl,de
	RET		C
collision_Y1_bouledefeu
	LD		hl,(SPRH0_Y)					; à partir du coin haut-gauche de link
	LD		de,14
	add		hl,de							; 15 pixels plus loin (sinon Golem va me faire un caca nerveu si j'écrit 16) 
											; on est sur le coin haut-droite
	LD		de,(SPRH13_Y)					; à partir du coin haut-gauche du monstre
	SBC		hl,de
											; si HL>=DE le flag C est à zero
	RET	 	C								; si hl>=de le flag C est à zero
collision_Y2_bouledefeu
	LD		hl,(SPRH13_Y)					; à partir du coin haut-gauche de link
	LD		de,14
	add		hl,de							; 15 pixels plus loin (sinon Golem va me faire un caca nerveu si j'écrit 16) 
											; on est sur le coin haut-droite
	LD		de,(SPRH0_Y)					; à partir du coin haut-gauche du monstre
	SBC		hl,de
	jp 		NC,link_touche					; si hl>=de le flag C est à zero
	RET
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
COLLISION_BOMBE_DODONGO_ROM
	collision_X1_bombe_dodongo
		LD		hl,(SPRH3_X)					; à partir du coin haut-gauche de link
		LD		de,30
		add		hl,de							; 32 pixels plus loin on est sur le coin haut-droite
		LD		de,(SPRH_X)						; à partir du coin haut-gauche du monstre
		SBC		hl,de
											; si HL>=DE le flag C est à zero
		RET		C								; si hl>=de le flag C est à zero
	collision_X2_bombe_dodongo
		LD		hl,(SPRH_X)						; à partir du coin haut-gauche du monstre
		LD		de,30
		add		hl,de							; 31 pixels plus loin on est sur le coin haut_droite
		LD		de,(SPRH3_X)					; à partir du coin haut-gauche de link
		SBC		hl,de
		RET		C
	collision_Y1_bombe_dodongo
		LD		hl,(SPRH3_Y)					; à partir du coin haut-gauche de link
		LD		de,14
		add		hl,de							; 15 pixels plus loin (sinon Golem va me faire un caca nerveu si j'écrit 16) 
											; on est sur le coin haut-droite
		LD		de,(SPRH_Y)						; à partir du coin haut-gauche du monstre
		SBC		hl,de
											; si HL>=DE le flag C est à zero
		RET	 	C								; si hl>=de le flag C est à zero
	collision_Y2_bombe_dodongo
		LD		hl,(SPRH_Y)						; à partir du coin haut-gauche de link
		LD		de,14
		add		hl,de							; 15 pixels plus loin (sinon Golem va me faire un caca nerveu si j'écrit 16) 
											; on est sur le coin haut-droite
		LD		de,(SPRH3_Y)					; à partir du coin haut-gauche du monstre
		SBC		hl,de
		jp 		NC,Link_tue						; si hl>=de le flag C est à zero
		ld 		c,2   ;Channel (0-2)
		call 	PLY_AKG_StopSoundEffectFromChannel
		RET





	









