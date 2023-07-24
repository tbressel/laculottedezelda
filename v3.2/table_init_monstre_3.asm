table_init_monstre_3
	;	regle pour les monstres 3 :  - les Octoock 2 ne laisse que des rubis, les octoock 1 AUCUN du tout.
	;   							 - les Leever 1  ne laisse AUCUN du tout, les leever2 donne tous des rubis.
	; 								 - Les Moblin 1 ne laisse ien du tout, les Moblin 2 laisse des rubis
	;								 - Les Tektite ne laisse AUCUN du tout
	; 								 - Les peahat ne laisse jamais AUCUN
	;								 - Les Ghini donne tous des rubis
	;								 - Les Lynel 1 ne donne jamais des rubis, Les Lynel 2 donne tous des rubis
	dw	0,0,0,0,0,0,0,0						; piece 0
	dw	0,0,0,0,0,0,0,0						; piece 1
	dw	TEKTITE1_ROM,ROM28,SPRH7_ADR,NIVEAU1,160,176,ZOOM1,RUBI_1			; piece 2
	dw	PEAHAT_ROM,ROM28,SPRH7_ADR,INVINCIBLE,320,112,ZOOM1,AUCUN			; piece 3
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,448,208,ZOOM1,RUBI_1			; piece 4
	dw	TEKTITE2_ROM,ROM28,SPRH7_ADR,NIVEAU1,096,176,ZOOM1,RUBI_1			; piece 5
	dw	TEKTITE2_ROM,ROM28,SPRH7_ADR,NIVEAU1,256,176,ZOOM1,CHAMPI_POURRIT_10			; piece 6
	dw	LEEVER1_ROM,ROM28,SPRH7_ADR,NIVEAU2,256,128,ZOOM1,RUBI_1				; piece 7
	dw	LEEVER1_ROM,ROM28,SPRH7_ADR,NIVEAU2,256,128,ZOOM1,RUBI_1				; piece 08
	dw	OCTOROK2_ROM,ROM26,SPRH7_ADR,NIVEAU1,416,144,ZOOM1,RUBI_1			; piece 09
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,256,144,ZOOM1,CHAMPI_POURRIT_10			; piece 10
	dw	0,0,0,0,0,0,0,0						; piece 11
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,192,144,ZOOM1,RUBI_1			; piece 12
	dw	MOBLIN1_ROM,ROM26,SPRH7_ADR,NIVEAU2,448,160,ZOOM1,RUBI_1			; piece 13
	dw	MOBLIN1_ROM,ROM26,SPRH7_ADR,NIVEAU2,448,144,ZOOM1,RUBI_1			; piece 14
	dw	MOBLIN2_ROM,ROM26,SPRH7_ADR,NIVEAU2,384,208,ZOOM1,RUBI_1			; piece 15			
	dw	MOBLIN2_ROM,ROM26,SPRH7_ADR,NIVEAU2,384,208,ZOOM1,CHAMPI_POURRIT_10			; piece 16
	dw	MOBLIN2_ROM,ROM26,SPRH7_ADR,NIVEAU2,416,160,ZOOM1,RUBI_1			; piece 17
	dw	MOBLIN1_ROM,ROM26,SPRH7_ADR,NIVEAU2,384,160,ZOOM1,BOMBE_3				; piece 18
	dw	MOBLIN1_ROM,ROM26,SPRH7_ADR,NIVEAU2,160,96,ZOOM1,AUCUN				; piece 19
	dw	MOBLIN2_ROM,ROM26,SPRH7_ADR,NIVEAU2,96,192,ZOOM1,CHAMPI_POURRIT_10				; piece 20
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,224,176,ZOOM1,RUBI_1			; piece 21
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,384,192,ZOOM1,RUBI_1			; piece 22
	dw	PEAHAT_ROM,ROM28,SPRH7_ADR,INVINCIBLE,160,176,ZOOM1,AUCUN			; piece 23
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,384,192,ZOOM1,BOMBE_3				; piece 24
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,192,176,ZOOM1,AUCUN				; piece 25
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,192,160,ZOOM1,CHAMPI_POURRIT_10				; piece 26
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,320,208,ZOOM1,AUCUN				; piece 27
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,064,192,ZOOM1,BOMBE_3				; piece 28
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,224,160,ZOOM1,AUCUN				; piece 29
	dw	MOBLIN1_ROM,ROM26,SPRH7_ADR,NIVEAU2,288,192,ZOOM1,AUCUN	 			; piece 30
	dw	MOBLIN2_ROM,ROM26,SPRH7_ADR,NIVEAU2,480,128,ZOOM1,AUCUN				; piece 31
	dw	MOBLIN2_ROM,ROM26,SPRH7_ADR,NIVEAU2,384,112,ZOOM1,BOMBE_3				; piece 32
	dw	0,0,0,0,0,0,0,0	
	dw	MOBLIN2_ROM,ROM26,SPRH7_ADR,NIVEAU2,224,112,ZOOM1,AUCUN				; piece 34
	dw	MOBLIN2_ROM,ROM26,SPRH7_ADR,NIVEAU2,160,176,ZOOM1,AUCUN				; piece 35
	dw	PEAHAT_ROM,ROM28,SPRH7_ADR,INVINCIBLE,160,144,ZOOM1,BOMBE_3				; piece 36
	dw	MOBLIN2_ROM,ROM26,SPRH7_ADR,NIVEAU2,320,192,ZOOM1,AUCUN				; piece 37
	dw	MOBLIN1_ROM,ROM26,SPRH7_ADR,NIVEAU2,384,112,ZOOM1,CHAMPI_POURRIT_10				; piece 38
	dw	MOBLIN2_ROM,ROM26,SPRH7_ADR,NIVEAU2,096,192,ZOOM1,RUBI_1			; piece 39
	dw	0,0,0,0,0,0,0,0							; piece 40
	dw	MOBLIN2_ROM,ROM26,SPRH7_ADR,NIVEAU2,256,144,ZOOM1,AUCUN				; piece 41
	dw	0,0,0,0,0,0,0,0		
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,192,144,ZOOM1,BOMBE_3				; piece 43
	dw	0,0,0,0,0,0,0,0								; piece 44
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,192,144,ZOOM1,AUCUN				; piece 45
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,256,144,ZOOM1,AUCUN				; piece 46
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,448,112,ZOOM1,AUCUN				; piece 47
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,96,224,ZOOM1,AUCUN				; piece 48
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,160,176,ZOOM1,CHAMPI_POURRIT_10			; piece 49
	dw	TEKTITE2_ROM,ROM28,SPRH7_ADR,NIVEAU1,224,176,ZOOM1,RUBI_1			; piece 50
	dw	MOBLIN1_ROM,ROM26,SPRH7_ADR,NIVEAU2,128,208,ZOOM1,BOMBE_3				; piece 51
	dw	MOBLIN2_ROM,ROM26,SPRH7_ADR,NIVEAU2,096,192,ZOOM1,RUBI_1			; piece 52
	dw	OCTOROK2_ROM,ROM26,SPRH7_ADR,NIVEAU1,064,144,ZOOM1,RUBI_1			; piece 53
	dw	MOBLIN2_ROM,ROM26,SPRH7_ADR,NIVEAU2,384,176,ZOOM1,CHAMPI_POURRIT_10				; piece 54
	dw	OCTOROK2_ROM,ROM26,SPRH7_ADR,NIVEAU1,224,176,ZOOM1,RUBI_1			; piece 55
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,160,176,ZOOM1,AUCUN				; piece 56
	dw	0,0,0,0,0,0,0,0	
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,224,176,ZOOM1,AUCUN				; piece 58
	dw	OCTOROK2_ROM,ROM26,SPRH7_ADR,NIVEAU1,128,176,ZOOM1,BOMBE_3			; piece 59
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,224,144,ZOOM1,AUCUN				; piece 60
	dw	TEKTITE1_ROM,ROM28,SPRH7_ADR,NIVEAU1,320,112,ZOOM1,CHAMPI_POURRIT_10			; piece 61
	dw	MOBLIN2_ROM,ROM26,SPRH7_ADR,NIVEAU2,096,192,ZOOM1,RUBI_1			; piece 62
	dw	0,0,0,0,0,0,0,0	
	dw	LEEVER1_ROM,ROM28,SPRH7_ADR,NIVEAU2,320,160,ZOOM1,RUBI_1			; piece 64
	dw	PEAHAT_ROM,ROM28,SPRH7_ADR,INVINCIBLE,160,176,ZOOM1,AUCUN				; piece 65
	dw	PEAHAT_ROM,ROM28,SPRH7_ADR,INVINCIBLE,160,176,ZOOM1,AUCUN			; piece 66
	dw	LEEVER2_ROM,ROM28,SPRH7_ADR,NIVEAU2,320,160,ZOOM1,BOMBE_3				; piece 67
	dw	PEAHAT_ROM,ROM28,SPRH7_ADR,INVINCIBLE,416,144,ZOOM1,AUCUN				; piece 68
	dw	0,0,0,0,0,0,0,0						; piece 69
	dw	PEAHAT_ROM,ROM28,SPRH7_ADR,INVINCIBLE,160,128,ZOOM1,AUCUN				; piece 70
	dw	OCTOROK1_ROM,ROM26,SPRH7_ADR,NIVEAU1,256,160,ZOOM1,AUCUN				; piece 71
	dw	0,0,0,0,0,0,0,0						; piece 72
	dw	0,0,0,0,0,0,0,0						; piece 73
	dw	0,0,0,0,0,0,0,0						; piece 74
	dw	0,0,0,0,0,0,0,0						; piece 75
	dw	LEEVER2_ROM,ROM28,SPRH7_ADR,NIVEAU2,224,160,ZOOM1,AUCUN					; piece 76
	dw	PEAHAT_ROM,ROM28,SPRH7_ADR,INVINCIBLE,160,128,ZOOM1,AUCUN					; piece 77
	dw	0,0,0,0,0,0,0,0						; piece 78
	dw	0,0,0,0,0,0,0,0						; piece 79
	dw	0,0,0,0,0,0,0,0						; piece 80
	dw	TEKTITE1_ROM,ROM28,SPRH7_ADR,NIVEAU1,288,176,ZOOM1,RUBI_11			; piece 81
	dw	0,0,0,0,0,0,0,0							; piece 82
	dw	0,0,0,0,0,0,0,0							; piece 83
	dw	PEAHAT_ROM,ROM28,SPRH7_ADR,INVINCIBLE,160,128,ZOOM1,AUCUN					; piece 84
	dw	TEKTITE1_ROM,ROM28,SPRH7_ADR,NIVEAU1,384,144,ZOOM1,AUCUN
	dw	PEAHAT_ROM,ROM28,SPRH7_ADR,INVINCIBLE,288,192,ZOOM1,AUCUN					; piece 86
	dw	0,0,0,0,0,0,0,0							; piece 87
	dw	TEKTITE1_ROM,ROM28,SPRH7_ADR,NIVEAU1,192,144,ZOOM1,BOMBE_3
	dw	TEKTITE1_ROM,ROM28,SPRH7_ADR,NIVEAU1,256,144,ZOOM1,RUBI_1
	dw	0,0,0,0,0,0,0,0							; piece 90
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	LYNEL2_ROM,ROM27,SPRH7_ADR,NIVEAU4,224,128,ZOOM1,AUCUN
	dw	LYNEL1_ROM,ROM27,SPRH7_ADR,NIVEAU4,320,160,ZOOM1,AUCUN			; piece 94
	dw	GHINI_ROM,ROM28,SPRH7_ADR,NIVEAU3,416,128,ZOOM1,RUBI_1				; piece 95
	dw	GHINI_ROM,ROM28,SPRH7_ADR,NIVEAU3,096,096,ZOOM1,RUBI_1				; piece 96
	dw	GHINI_ROM,ROM28,SPRH7_ADR,NIVEAU3,416,128,ZOOM1,CHAMPI_POURRIT_10				; piece 97
	dw	GHINI_ROM,ROM28,SPRH7_ADR,NIVEAU3,096,096,ZOOM1,RUBI_1				; piece 98
	dw	GHINI_ROM,ROM28,SPRH7_ADR,NIVEAU3,416,128,ZOOM1,RUBI_1				; piece 99
	dw	GHINI_ROM,ROM28,SPRH7_ADR,NIVEAU3,096,096,ZOOM1,CHAMPI_POURRIT_10				; piece 100
	dw	LYNEL2_ROM,ROM27,SPRH7_ADR,NIVEAU4,128,192,ZOOM1,AUCUN
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	LYNEL1_ROM,ROM27,SPRH7_ADR,NIVEAU4,160,208,ZOOM1,AUCUN
	dw	0,0,0,0,0,0,0,0												; piece 105
	dw	PEAHAT_ROM,ROM28,SPRH7_ADR,INVINCIBLE,384,192,ZOOM1,AUCUN			; piece 106
	dw	0,0,0,0,0,0,0,0												; piece 107
	dw	0,0,0,0,0,0,0,0												; piece 108
	dw	PEAHAT_ROM,ROM28,SPRH7_ADR,INVINCIBLE,384,192,ZOOM1,AUCUN			; piece 109
	dw	LYNEL1_ROM,ROM27,SPRH7_ADR,NIVEAU4,160,160,ZOOM1,AUCUN			; piece 110
	dw	LYNEL2_ROM,ROM27,SPRH7_ADR,NIVEAU4,128,160,ZOOM1,BOMBE_3
	dw	LYNEL2_ROM,ROM27,SPRH7_ADR,NIVEAU4,192,176,ZOOM1,AUCUN			; piece 112
	dw	LYNEL1_ROM,ROM27,SPRH7_ADR,NIVEAU4,320,176,ZOOM1,CHAMPI_POURRIT_10
	dw	LYNEL1_ROM,ROM27,SPRH7_ADR,NIVEAU4,384,160,ZOOM1,AUCUN
	dw	0,0,0,0,0,0,0,0												; piece 115
	dw	LYNEL1_ROM,ROM27,SPRH7_ADR,NIVEAU4,160,112,ZOOM1,BOMBE_3			; piece 116
	dw	LYNEL1_ROM,ROM27,SPRH7_ADR,NIVEAU4,416,160,ZOOM1,AUCUN
	dw	0,0,0,0,0,0,0,0												; piece 118
	dw	LYNEL1_ROM,ROM27,SPRH7_ADR,NIVEAU4,352,176,ZOOM1,AUCUN
	dw	0,0,0,0,0,0,0,0												; piece 120
	dw	0,0,0,0,0,0,0,0												; piece 121
	dw	0,0,0,0,0,0,0,0												; piece 122
	dw	0,0,0,0,0,0,0,0												; piece 123
	dw	LYNEL1_ROM,ROM27,SPRH7_ADR,NIVEAU4,064,160,ZOOM1,CHAMPI_POURRIT_10			; piece 124
	dw	LYNEL2_ROM,ROM27,SPRH7_ADR,NIVEAU4,032,144,ZOOM1,BOMBE_3			; piece 125
	dw	LYNEL2_ROM,ROM27,SPRH7_ADR,NIVEAU4,064,160,ZOOM1,AUCUN			; piece 126
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////// DONJON 1 /////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	dw	0,0,0,0,0,0,0,0
	dw	KEESES_ROM,ROM28,SPRH7_ADR,NIVEAU1,096,192,ZOOM1,AUCUN						; piece 130
	dw	WALLMASTER_ROM,ROM28,SPRH7_ADR,NIVEAU1,256,144,ZOOM1,CLE_4				; piece 131
	dw	WALLMASTER_ROM,ROM28,SPRH7_ADR,NIVEAU1,288,112,ZOOM1,RUBI_1				; piece 132
	dw	WALLMASTER_ROM,ROM28,SPRH7_ADR,NIVEAU1,288,144,ZOOM1,RUBI_1				; piece 133
	dw	KEESES_ROM,ROM28,SPRH7_ADR,NIVEAU1,096,128,ZOOM1,AUCUN					; piece 134
	dw	KEESES_ROM,ROM28,SPRH7_ADR,NIVEAU1,256,144,ZOOM1,AUCUN					; piece 135
	dw	GEL_ROM,ROM28,SPRH7_ADR,NIVEAU1,256,144,ZOOM1,AUCUN							; piece 136
	dw	GEL_ROM,ROM28,SPRH7_ADR,NIVEAU1,384,144,ZOOM1,AUCUN							; piece 137
	dw	0,0,0,0,0,0,0,0
	dw	GORIYA1_ROM,ROM27,SPRH7_ADR,NIVEAU2,160,176,ZOOM1,AUCUN						; piece 139
	dw	WALLMASTER_ROM,ROM28,SPRH7_ADR,NIVEAU1,320,176,ZOOM1,AUCUN					; piece 140
	dw	GORIYA1_ROM,ROM27,SPRH7_ADR,NIVEAU2,160,176,ZOOM1,AUCUN						; piece 141
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	KEESES_ROM,ROM28,SPRH7_ADR,NIVEAU1,288,160,ZOOM1,AUCUN					; piece 146 (CAVE)
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; ////////////////////////////////////////////////////// DONJON 2 /////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	dw	0,0,0,0,0,0,0,0										; piece 147
	dw	ROPE1_ROM,ROM28,SPRH7_ADR,NIVEAU2,128,144,ZOOM1,AUCUN
	dw	ROPE1_ROM,ROM28,SPRH7_ADR,NIVEAU2,320,112,ZOOM1,AUCUN
	dw	GEL_ROM,ROM28,SPRH7_ADR,NIVEAU2,128,144,ZOOM1,CLE_4										; piece 150
	dw	ROPE1_ROM,ROM28,SPRH7_ADR,NIVEAU2,160,176,ZOOM1,AUCUN
	dw	ROPE1_ROM,ROM28,SPRH7_ADR,NIVEAU2,160,144,ZOOM1,CLE_4
	dw	GORIYA1_ROM,ROM27,SPRH7_ADR,NIVEAU3,320,144,ZOOM1,AUCUN
	dw	ROPE1_ROM,ROM28,SPRH7_ADR,NIVEAU2,416,160,ZOOM1,CLE_4
	dw	GORIYA2_ROM,ROM27,SPRH7_ADR,NIVEAU4,320,176,ZOOM1,AUCUN	
	dw	KEESES_ROM,ROM28,SPRH7_ADR,NIVEAU2,416,112,ZOOM1,AUCUN
	dw	GEL_ROM,ROM28,SPRH7_ADR,NIVEAU2,288,144,ZOOM1,RUBI_1
	dw	0,0,0,0,0,0,0,0										; piece 158
	dw	ROPE1_ROM,ROM28,SPRH7_ADR,NIVEAU2,288,144,ZOOM1,CLE_4
	dw	0,0,0,0,0,0,0,0										; piece 160
	dw	ROPE1_ROM,ROM28,SPRH7_ADR,NIVEAU2,096,192,ZOOM1,AUCUN
	dw	GORIYA1_ROM,ROM27,SPRH7_ADR,NIVEAU3,160,176,ZOOM1,CLE_4
	dw	0,0,0,0,0,0,0,0		
	dw	0,0,0,0,0,0,0,0										; piece 164
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////// DONJON 3 ////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	dw	0,0,0,0,0,0,0,0															; piece 165
	dw	ZOL_ROM,ROM28,SPRH7_ADR,NIVEAU3,160,144,ZOOM1,RUBI_1
	dw	ZOL_ROM,ROM28,SPRH7_ADR,NIVEAU3,256,160,ZOOM1,RUBI_1
	dw	DARKNUT1_ROM,ROM27,SPRH7_ADR,NIVEAU4,320,192,ZOOM1,BOMBE_3						; piece 168
	dw	KEESES_ROM,ROM28,SPRH7_ADR,NIVEAU3,160,144,ZOOM1,MONTRE_5
	dw	DARKNUT1_ROM,ROM27,SPRH7_ADR,NIVEAU4,320,112,ZOOM1,MONTRE_5										; piece 170
	dw	DARKNUT1_ROM,ROM27,SPRH7_ADR,NIVEAU4,160,208,ZOOM1,BOMBE_3
	dw	KEESES_ROM,ROM28,SPRH7_ADR,NIVEAU3,160,208,ZOOM1,AUCUN
	dw	KEESES_ROM,ROM28,SPRH7_ADR,NIVEAU3,320,176,ZOOM1,MONTRE_5
	dw	KEESES_ROM,ROM28,SPRH7_ADR,NIVEAU3,384,128,ZOOM1,AUCUN
	dw	ZOL_ROM,ROM28,SPRH7_ADR,NIVEAU3,128,208,ZOOM1,BOMBE_3									; piece 175
	dw	KEESES_ROM,ROM28,SPRH7_ADR,NIVEAU3,064,112,ZOOM1,AUCUN						; piece 176
	dw	0,0,0,0,0,0,0,0
	dw	KEESES_ROM,ROM28,SPRH7_ADR,NIVEAU3,192,176,ZOOM1,AUCUN
	dw	KEESES_ROM,ROM28,SPRH7_ADR,NIVEAU3,160,208,ZOOM1,AUCUN						; piece 179
	dw	DARKNUT1_ROM,ROM27,SPRH7_ADR,NIVEAU4,288,176,ZOOM1,BOMBE_3										; piece 180
	dw	KEESES_ROM,ROM28,SPRH7_ADR,NIVEAU3,320,144,ZOOM1,AUCUN
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////// DONJON 4 ////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
	dw	0,0,0,0,0,0,0,0														; piece 184
	dw	KEESES_ROM,ROM28,SPRH7_ADR,NIVEAU3,096,192,ZOOM1,AUCUN	
	dw	VIRE_ROM,ROM28,SPRH7_ADR,NIVEAU4,384,112,ZOOM1,0
	dw	VIRE_ROM,ROM28,SPRH7_ADR,NIVEAU4,256,176,ZOOM1,0
	dw	KEESES_ROM,ROM28,SPRH7_ADR,NIVEAU3,192,128,ZOOM1,AUCUN
	dw	VIRE_ROM,ROM28,SPRH7_ADR,NIVEAU4,224,144,ZOOM1,0
	dw	ZOLNOIR_ROM,ROM28,SPRH7_ADR,NIVEAU5,160,176,ZOOM1,AUCUN					; piece 190
	dw	VIRE_ROM,ROM28,SPRH7_ADR,NIVEAU4,288,176,ZOOM1,0
	dw	VIRE_ROM,ROM28,SPRH7_ADR,NIVEAU4,320,144,ZOOM1,0
	dw	LIKELIKE_ROM,ROM28,SPRH7_ADR,NIVEAU5,384,128,ZOOM1,0						; piece 193
	dw	KEESES_ROM,ROM28,SPRH7_ADR,NIVEAU3,256,176,ZOOM1,AUCUN
	dw	ZOLNOIR_ROM,ROM28,SPRH7_ADR,NIVEAU5,192,176,ZOOM1,0
	dw	VIRE_ROM,ROM28,SPRH7_ADR,NIVEAU4,160,176,ZOOM1,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	KEESES_ROM,ROM28,SPRH7_ADR,NIVEAU3,192,128,ZOOM1,AUCUN
	dw	0,0,0,0,0,0,0,0										; piece 200
	dw	ELECTRO_ROM,ROM28,SPRH7_ADR,INVINCIBLE,192,128,ZOOM1,AUCUN
	dw	VIRE_ROM,ROM28,SPRH7_ADR,NIVEAU4,160,176,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////// OCEAN  ////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
	
	
	
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	FISH_VERT_ROM,ROM28,SPRH7_ADR,#0101,160,112,ZOOM1,0						; piece 26
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0										; piece 210
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0	
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0										; piece 220
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	LEEVER2_ROM,ROM28,SPRH7_ADR,#0101,448,112,ZOOM1,0		; piece 222
	dw	TEKTITE1_ROM,ROM28,SPRH7_ADR,#0101,128,128,ZOOM1,0		; piece 223
	dw	PEAHAT_ROM,ROM28,SPRH7_ADR,#0101,448,112,ZOOM2,0		; piece  224
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	FISH_BLEU_ROM,ROM28,SPRH7_ADR,#0101,224,192,ZOOM1,0										; piece 230
	dw	LEEVER2_ROM,ROM28,SPRH7_ADR,#0101,160,208,ZOOM1,0			; piece 231
	dw	LEEVER2_ROM,ROM28,SPRH7_ADR,#0101,064,112,ZOOM1,0			; piece 232
	dw	FISH_VERT_ROM,ROM28,SPRH7_ADR,#0101,224,112,ZOOM1,0			; piece 233
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	FISH_VERT_ROM,ROM28,SPRH7_ADR,#0101,176,224,ZOOM2,0						; piece 235
	dw	FISH_ROUGE_ROM,ROM28,SPRH7_ADR,#0101,320,192,ZOOM1,0						; piece 236
	dw	FISH_BLEU_ROM,ROM28,SPRH7_ADR,#0101,160,208,ZOOM1,RUBI_1				; piece 237
	dw	FISH_VERT_ROM,ROM28,SPRH7_ADR,#0101,160,224,ZOOM1,RUBI_1				; piece 238
	dw	FISH_ROUGE_ROM,ROM28,SPRH7_ADR,#0101,320,176,ZOOM2,0					; piece 239
	dw	FISH_VERT_ROM,ROM28,SPRH7_ADR,#0101,160,160,ZOOM1,0										; piece 240
	dw	FISH_BLEU_ROM,ROM28,SPRH7_ADR,#0101,160,208,ZOOM2,RUBI_1				; piece 241
	dw	FISH_VERT_ROM,ROM28,SPRH7_ADR,#0101,160,208,ZOOM1,RUBI_1
	dw	FISH_ROUGE_ROM,ROM28,SPRH7_ADR,#0101,160,192,ZOOM1,0						; piece 243
	dw	FISH_VERT_ROM,ROM28,SPRH7_ADR,#0101,064,208,ZOOM1,RUBI_1
	dw	FISH_VERT_ROM,ROM28,SPRH7_ADR,#0101,320,176,ZOOM1,RUBI_1
	dw	FISH_VERT_ROM,ROM28,SPRH7_ADR,#0101,160,128,ZOOM1,RUBI_1
	dw	FISH_VERT_ROM,ROM28,SPRH7_ADR,#0101,192,112,ZOOM1,RUBI_1
	dw	FISH_VERT_ROM,ROM28,SPRH7_ADR,#0101,320,144,ZOOM1,RUBI_1
	dw	FISH_VERT_ROM,ROM28,SPRH7_ADR,#0101,128,240,ZOOM1,RUBI_1
	dw	TEKTITE2_ROM,ROM28,SPRH7_ADR,#0101,416,144,ZOOM1,0										; piece 250
	dw	FISH_ROUGE_ROM,ROM28,SPRH7_ADR,#0101,032,096,ZOOM1,0
	dw	TEKTITE2_ROM,ROM28,SPRH7_ADR,#0101,384,176,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	FISH_VERT_ROM,ROM28,SPRH7_ADR,#0101,416,176,ZOOM1,CLE_4
	dw	FISH_VERT_ROM,ROM28,SPRH7_ADR,#0101,032,208,ZOOM1,RUBI_1
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0										; piece 260
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	FISH_VERT_ROM,ROM28,SPRH7_ADR,#0101,160,112,ZOOM1,0						; piece 26
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0	
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0										; piece 270
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0	
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,NIVEAU2,0,0,ZOOM1,0
	dw	0,ROM26,SPRH7_ADR,NIVEAU2,0,0,ZOOM1,0										; piece 280
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0															; piece 290
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,#FFFF															; piece 300
	read"constantes_equ.asm"
