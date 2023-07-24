

table_init_link
	;	typedeperso,ZOOM,bankROM,spawnX,(X),spawnY,(Y),sprite anim1, sprite anim2
	dw	LINK1_SPR,#1D,SPRH0_ADR,160,150,#0909,160,150,#0000
	
table_type_link
	dw	LINK_G1,LINK_G2,LINK_D1,LINK_D2,LINK_B1,LINK_B2,LINK_H1,LINK_H2					; (1) link n°1 avec bouclier de base. Ligne de lecture
	DW	LINK_ATTACK_G,LINK_ATTACK_D,LINK_ATTACK_B,LINK_ATTACK_H							; (2) link n°1 en position d'attaque. Ligne de lecture
	dw	LINK2_G1,LINK2_G2,LINK2_D1,LINK2_D2,LINK2_B1,LINK2_B2,LINK2_H1,LINK2_H2			; +24 (3) link n°2 avec un bouclier bleu. Ligne lue et copié vers (1)
	dw	LINK3_G1,LINK3_G2,LINK3_D1,LINK3_D2,LINK3_B1,LINK3_B2,LINK3_H1,LINK3_H2			; +40 (4) link n°3 nage dans l'océan. Ligne lue et copié vers (1)
	dw	LINK_G1,LINK_G2,LINK_D1,LINK_D2,LINK_B1,LINK_B2,LINK_H1,LINK_H2					; +56 (5) ligne de sauvegarde du link mis à jour
	DW	LINK_ATTACK_G,LINK_ATTACK_D,LINK_ATTACK_B,LINK_ATTACK_H							; (6) ligne de sauvegarde du link en position d'attaque
	dw	LINK4_G1,LINK4_G2,LINK4_D1,LINK4_D2,LINK4_B1,LINK4_B2,LINK4_H1,LINK4_H2			; +80 (7) link n°4 nu chez zelda. Ligne lue et copié vers (1)
	DW	LINK4_G1,LINK4_D1,LINK4_B1,LINK4_H1												; (8) link n°4 bite au vent ! Ligne lue et copié vers (2)
	
	
table_type_arme
	dw	LINK_EPEE_G,LINK_EPEE_D,LINK_EPEE_B,LINK_EPEE_H				; epée normal en bois
	dw	LINK_FUCK_G,LINK_FUCK_D,LINK_FUCK_B,LINK_FUCK_H				; bite
	dw	LINK_EPEE_G2,LINK_EPEE_D2,LINK_EPEE_B2,LINK_EPEE_H2			; épée en acier
	dw	LINK_EPEE_G3,LINK_EPEE_D3,LINK_EPEE_B3,LINK_EPEE_H3			; sword master
	
Link_Update
	LD		a,(bankROM_link1)						; on recupère le no de Bank de Link
	LD		(bankROM),a								; on l'envoie dans une variable générale 
	call	rom_on									 ;çà sélèctionne la ROM où se trouve Link.
	LD		hl,(LINK_ADR)							
	LD		(SPRH0_ANIM_1),hl
	LD		hl,(SPRH0_ANIM_1)
	LD		de,(SPRH_ADR)
	LD		bc,#200
	LDIR
	call	rom_off
	ret

	