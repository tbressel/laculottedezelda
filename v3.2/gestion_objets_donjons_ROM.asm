; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////// OBJET DU DONJON 1 ////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////

objet_donjon_1_ROM
	;ld		a,(flag_boss4_RIP)
	;cp		a,1
	;ret		Z
	;or		a
	ld		a,(No_PIECE)
	cp		a,130
	JP		z,event_objet_cle
	cp		a,133
	JP		z,event_objet_cle
	cp		a,135
	JP		z,event_objet_boussole
	cp		a,136
	JP		z,event_objet_carte
	cp		a,138
	JP		z,event_indice1_on
	cp		a,139
	JP		z,event_objet_cle

	cp		a,141
	JP		z,event_objet_cle
	cp		a,142
	JP		z,event_passage_ouvert
	cp		a,146
	JP		z,event_objet_arc
	cp		a,144
	JP		z,event_boss1
	cp		a,145
	JP		z,event_triforce_boss1
retour_event_objet
	RET		
event_objet_cle
	ld		a,(attente_naissance_des_monstres)
	dec	a
	cp		a,0
	ld		(attente_naissance_des_monstres),a
	RET	NZ					; RET si pas égal à 0
	
	ld		a,5
	ld		(type_objet_centre),a
	ld		hl,SPRH_CLE_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	RET
event_objet_boussole
	ld		a,(attente_naissance_des_monstres)
	dec		a
	ld		(attente_naissance_des_monstres),a
	cp		a,0
	RET		NZ	
	
	ld		a,6
	ld		(type_objet_centre),a
	ld		hl,SPRH_BOUSSOLE_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	ret
event_objet_carte
	ld		a,(attente_naissance_des_monstres)
	dec		a
	ld		(attente_naissance_des_monstres),a
	cp		a,0
	RET		NZ
	LD		a,(flag_carte_donjon1)
	cp		1
	RET		Z
	ld		a,objet_carte
	ld		(type_objet_centre),a
	ld		hl,SPRH_PARCHEMIN_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	ret
	
event_passage_ouvert
ld		a,(attente_naissance_des_monstres)
	dec		a
	ld		(attente_naissance_des_monstres),a
	cp		a,0
	RET		NZ	
	
	call	test_flag_monstres2
	ret
event_objet_arc
	ld		a,(attente_naissance_des_monstres)
	dec		a
	ld		(attente_naissance_des_monstres),a
	cp		a,0
	RET		NZ	
	
	ld		a,objet_arc
	ld		(type_objet_centre),a
	ld		hl,SPRH_ARC_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	RET
event_boss1
	ld		a,(flag_boss1_RIP)
	cp		a,1
	JP		z,affiche_recompense
	ld		a,#CD
	ld		(event_bosses_donjon),a
	ld		hl,boss_donjon_1
	LD		(event_bosses_donjon+1),hl
	ld		a,8
	ld		(type_objet_centre),a
	ld		hl,flag_receptacle_coeur_donjon1
	ld		(flag_objet_centre),hl
	RET
event_triforce_boss1
	ld		a,(flag_triforce_1)
	cp		a,1
	ret		z
	ld		a,objet_trifoce_donjon_1
	ld		(type_objet_centre),a
	ld		hl,SPRH_BRACELET_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	RET
event_indice1_on
	call	init_indice_donjon1234
	ld		hl,TEXTE_BOUTIQUE_138_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	ret




; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////// OBJET DU DONJON 2 ////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////

objet_donjon_2_ROM
	;ld		a,(flag_boss4_RIP)
	;or		a
	;ret		NZ
	;or		a
	ld		a,(No_PIECE)
	cp		a,148
	JP	z,event_objet_cle2
	cp		a,151
	JP	z,event_objet_cle2
	cp		a,150
	JP	z,event_objet_boussole2
	cp		a,154
	JP	z,event_objet_carte2
	cp		a,157
	JP	z,event_objet_cle2
	cp		a,159
	JP	z,event_objet_cle2
	cp		a,158
	jp	z,event_indice2_on
	cp		a,156
	JP	z,event_objet_cle2
	cp		a,163
	JP	z,event_boss2
	cp	a,164
	JP	z,event_triforce_boss2
retour_event_objet2
	RET		
event_objet_cle2
	ld		a,(attente_naissance_des_monstres)
	dec	a
	cp		a,0
	ld		(attente_naissance_des_monstres),a
	RET	NZ					; RET si pas égal à 0
	
	ld		a,5
	ld		(type_objet_centre),a
	ld		hl,SPRH_CLE_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	RET
event_objet_boussole2
	ld		a,(attente_naissance_des_monstres)
	dec		a
	ld		(attente_naissance_des_monstres),a
	cp		a,0
	RET		NZ	
	
	ld		a,6
	ld		(type_objet_centre),a
	ld		hl,SPRH_BOUSSOLE_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	ret
event_objet_carte2
	ld		a,(attente_naissance_des_monstres)
	dec		a
	ld		(attente_naissance_des_monstres),a
	cp		a,0
	RET		NZ
	LD		a,(flag_carte_donjon2)
	or		a
	RET		NZ
	ld		a,objet_carte
	ld		(type_objet_centre),a
	ld		hl,SPRH_PARCHEMIN_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	ret
	event_indice2_on
		call	init_indice_donjon1234
	ld		hl,TEXTE_BOUTIQUE_158_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	ret
event_boss2
	ld		a,(flag_boss2_RIP)
	OR		A
	JP		nz,affiche_recompense2
	ld		a,#CD
	ld		(event_bosses_donjon),a
	ld		hl,(boss_donjon_label)
	LD		(event_bosses_donjon+1),hl
	ld		a,8
	ld		(type_objet_centre),a
	ld		hl,flag_receptacle_coeur_donjon2
	ld		(flag_objet_centre),hl
	ld		a,1
	ld		(flag_boss_donjon),a
	RET
event_triforce_boss2
	ld		a,(flag_triforce_2)
	or		a
	ret		nz
	ld		a,objet_trifoce_donjon_2
	ld		(type_objet_centre),a
	ld		hl,SPRH_BRACELET_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	RET

; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////// OBJET DU DONJON 3 ////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
objet_donjon_3_ROM
	;ld		a,(flag_boss4_RIP)
	;or		a
	;ret		NZ
	;or		a
	ld		a,(No_PIECE)
	cp		a,166
	JP		z,event_objet_cle3
	cp		a,167
	JP		z,event_objet_cle3
	cp		a,169
	JP		z,event_objet_boussole3
	cp		a,178
	JP		z,event_objet_cle3
	cp		a,179
	JP		z,event_objet_carte3
	cp		a,170
	JP		z,event_objet_cle3
	cp		a,171
	JP		z,event_passage_ouvert3
	cp		a,172
	JP		z,event_objet_radeau
	cp		a,175
	JP		z,event_objet_cle3
	cp		a,177
	jp		z,event_indice3_on
	cp		a,178
	JP		z,event_objet_cle3
	cp		a,182
	JP		z,event_boss3
	cp		a,183
	JP		z,event_triforce_boss3
retour_event_objet3
	RET		
event_objet_cle3
	ld		a,(attente_naissance_des_monstres)
	dec		a
	cp		a,0
	ld		(attente_naissance_des_monstres),a
	RET		NZ					; RET si pas égal à 0
	ld		a,5
	ld		(type_objet_centre),a
	ld		hl,SPRH_CLE_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	RET
event_objet_boussole3
	ld		a,(attente_naissance_des_monstres)
	dec		a
	ld		(attente_naissance_des_monstres),a
	cp		a,0
	RET		NZ	
	ld		a,6
	ld		(type_objet_centre),a
	ld		hl,SPRH_BOUSSOLE_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	ret
event_objet_carte3
	ld		a,(attente_naissance_des_monstres)
	dec		a
	ld		(attente_naissance_des_monstres),a
	cp		a,0
	RET		NZ
	LD		a,(flag_carte_donjon3)
	or		a
	RET		NZ
	ld		a,objet_carte
	ld		(type_objet_centre),a
	ld		hl,SPRH_PARCHEMIN_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	ret
event_passage_ouvert3
ld		a,(attente_naissance_des_monstres)
	dec		a
	ld		(attente_naissance_des_monstres),a
	cp		a,0
	RET		NZ	
	
	call	test_flag_monstres2
	ret
event_objet_radeau
	ld		a,(attente_naissance_des_monstres)
	dec		a
	ld		(attente_naissance_des_monstres),a
	cp		a,0
	RET		NZ	
	
	ld		a,objet_radeau
	ld		(type_objet_centre),a
	ld		hl,SPRH_RADEAU_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	RET
event_indice3_on
		call	init_indice_donjon1234
	ld		hl,TEXTE_BOUTIQUE_177_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	ret
	
event_boss3
	ld		a,(flag_boss3_RIP)
	cp		a,1
	JP		z,affiche_recompense3
	ld		a,#CD
	ld		(event_bosses_donjon),a
	ld		hl,(boss_donjon_label)
	LD		(event_bosses_donjon+1),hl
	ld		a,8
	ld		(type_objet_centre),a
	ld		hl,flag_receptacle_coeur_donjon3
	ld		(flag_objet_centre),hl
	ld		a,1
	ld		(flag_boss_donjon),a
	ret
event_triforce_boss3
	ld		a,(flag_triforce_3)
	cp		a,1
	ret		z
	ld		a,objet_trifoce_donjon_3
	ld		(type_objet_centre),a
	ld		hl,SPRH_BRACELET_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	RET
	
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; ////////////////////////////////////////// OBJET DU DONJON 4 ////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////////////////////////////////
objet_donjon_4_ROM

	ld		a,(No_PIECE)
	cp		a,185
	JP		z,event_objet_cle4
	cp		a,186
	JP		z,event_objet_cle4
	cp		a,189
	JP		z,event_objet_cle4
	cp		a,190
	JP		z,event_objet_cle4
	cp		a,187
	JP		z,event_objet_boussole4
	cp		a,193
	JP		z,event_passage_ouvert4
	cp		a,194
	JP		z,event_objet_echelle
	cp		a,195
	JP		z,event_objet_carte4
	cp		a,198
	jp		z,event_indice4_on
	cp		a,199
	JP		z,event_objet_cle4
	cp		a,203
	JP		z,event_boss4
	cp		a,204
	JP		z,event_triforce_boss4
	
retour_event_objet4
	RET		
event_objet_cle4
	ld		a,(attente_naissance_des_monstres)
	dec		a
	cp		a,0
	ld		(attente_naissance_des_monstres),a
	RET		NZ					; RET si pas égal à 0
	ld		a,5
	ld		(type_objet_centre),a
	ld		hl,SPRH_CLE_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	RET
event_objet_boussole4
	ld		a,(attente_naissance_des_monstres)
	dec		a
	ld		(attente_naissance_des_monstres),a
	cp		a,0
	RET		NZ	
	ld		a,6
	ld		(type_objet_centre),a
	ld		hl,SPRH_BOUSSOLE_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	ret
event_objet_carte4
	ld		a,(attente_naissance_des_monstres)
	dec		a
	ld		(attente_naissance_des_monstres),a
	cp		a,0
	RET		NZ
	LD		a,(flag_carte_donjon4)
	cp		1
	RET		Z
	ld		a,objet_carte
	ld		(type_objet_centre),a
	ld		hl,SPRH_PARCHEMIN_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	ret
event_passage_ouvert4
	ld		a,(attente_naissance_des_monstres)
	dec		a
	ld		(attente_naissance_des_monstres),a
	cp		a,0
	RET		NZ	
	
	call	test_flag_monstres2
	ret
event_objet_echelle
	ld		a,(attente_naissance_des_monstres)
	dec		a
	ld		(attente_naissance_des_monstres),a
	cp		a,0
	RET		NZ	
	
	ld		a,objet_echelle
	ld		(type_objet_centre),a
	ld		hl,SPRH_ECHELLE_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	RET
event_indice4_on
	call	init_indice_donjon1234
	ld		hl,TEXTE_BOUTIQUE_198_ligne1
	ld		de,MEM_TAMPON_TEXTE
	ld		bc,69
	LDIR
	ret
	
event_boss4
	ld		a,(flag_boss4_RIP)
	cp		a,1
	JP		z,affiche_recompense4
	ld		a,#CD
	ld		(event_bosses_donjon),a
	ld		hl,(boss_donjon_label)
	LD		(event_bosses_donjon+1),hl
	ld		a,8
	ld		(type_objet_centre),a
	ld		hl,flag_receptacle_coeur_donjon4
	ld		(flag_objet_centre),hl
	ld		a,1
	ld		(flag_boss_donjon),a
	RET
event_triforce_boss4
	ld		a,(flag_triforce_4)
	cp		a,1
	ret		z
	ld		a,objet_trifoce_donjon_4
	ld		(type_objet_centre),a
	ld		hl,SPRH_BRACELET_ADR
	ld		(OBJET_AUTRE_ADR),hl
	call	test_flag_monstres
	RET


	