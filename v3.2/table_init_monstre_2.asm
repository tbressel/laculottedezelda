table_init_monstre_2
	; 	#0000=AUCUN    #0001=RUBI_1
	;	regle pour les monstres 2 :  - les Octoock 2 ne laisse que des rubis, les octoock 1 AUCUN du tout.
	;   							 - les Leever  ne laisse AUCUN du tout.
	; 								 - Les Moblin 1 ne laisse ien du tout, les Moblin 2 laisse des 11BOMBEs
	;								 - Les Tektite ne laisse AUCUN du tout
	; 								 - Les peahat ne laisse jamais AUCUN
	;								 - Les Ghini donne tous des rubis
	;								 - Les Lynel 1 ne donne jamais des rubis, Les Lynel 2 donne tous des rubis
	;	TYPE DE MONSTRE,n°Bank,SPRH DESTINATION,nbr coup #épée#fleche,pop en X,pop en Y,ZOOM,Zora (1=oui) et no de l'objet laissé
	dw	0,0,0,0,0,0,0,0						; piece 0
	dw	0,0,0,0,0,0,0,0						; piece 1
	dw	TEKTITE1_ROM,ROM28,SPRH6_ADR,NIVEAU1,160,144,ZOOM1,RUBI_11			; piece 02
	dw	PEAHAT_ROM,ROM28,SPRH6_ADR,INVINCIBLE,224,144,ZOOM1,AUCUN			; piece 03
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,320,112,ZOOM1,RUBI_1			; piece 04	
	dw	TEKTITE2_ROM,ROM28,SPRH6_ADR,NIVEAU1,288,128,ZOOM1,RUBI_11			; piece 05	
	dw	TEKTITE2_ROM,ROM28,SPRH6_ADR,NIVEAU1,256,144,ZOOM1,RUBI_11			; piece 06
	dw	LEEVER1_ROM,ROM28,SPRH6_ADR,NIVEAU2,320,160,ZOOM1,AUCUN				; piece 07
	dw	LEEVER1_ROM,ROM28,SPRH6_ADR,NIVEAU2,320,160,ZOOM1,AUCUN				; piece 08
	dw	OCTOROK2_ROM,ROM26,SPRH6_ADR,NIVEAU1,224,128,ZOOM1,MONTRE_5			; piece 09
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,320,144,ZOOM1,RUBI_1			; piece 10
	dw	0,0,0,0,0,0,0,0						; piece 11 (POISSON)
	dw	OCTOROK2_ROM,ROM26,SPRH6_ADR,NIVEAU1,160,112,ZOOM1,BOMBE_3			; piece 12
	dw	MOBLIN1_ROM,ROM26,SPRH6_ADR,NIVEAU2,224,192,ZOOM1,RUBI_1			; piece 13
	dw	MOBLIN1_ROM,ROM26,SPRH6_ADR,NIVEAU2,96,192,ZOOM1,RUBI_1			; piece 14
	dw	MOBLIN2_ROM,ROM26,SPRH6_ADR,NIVEAU2,96,112,ZOOM1,RUBI_1			; piece 15
	dw	MOBLIN2_ROM,ROM26,SPRH6_ADR,NIVEAU2,96,208,ZOOM1,BOMBE_3			; piece 16
	dw	MOBLIN2_ROM,ROM26,SPRH6_ADR,NIVEAU2,384,192,ZOOM1,RUBI_1			; piece 17
	dw	MOBLIN1_ROM,ROM26,SPRH6_ADR,NIVEAU2,352,112,ZOOM1,RUBI_1			; piece 18
	dw	OCTOROK2_ROM,ROM26,SPRH6_ADR,NIVEAU1,416,112,ZOOM1,BOMBE_3			; piece 19
	dw	MOBLIN1_ROM,ROM26,SPRH6_ADR,NIVEAU2,384,192,ZOOM1,RUBI_1			; piece 20
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,224,144,ZOOM1,RUBI_1			; piece 21
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,256,144,ZOOM1,RUBI_1			; piece 22
	dw	PEAHAT_ROM,ROM28,SPRH6_ADR,INVINCIBLE,160,144,ZOOM1,AUCUN			; piece 23
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,320,176,ZOOM1,RUBI_1			; piece 24
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,192,112,ZOOM1,RUBI_1			; piece 25
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,160,176,ZOOM1,BOMBE_3			; piece 26
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,064,160,ZOOM1,RUBI_1			; piece 27
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,064,160,ZOOM1,RUBI_1			; piece 28
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,160,160,ZOOM1,RUBI_1			; piece 29
	dw	OCTOROK2_ROM,ROM26,SPRH6_ADR,NIVEAU1,224,160,ZOOM1,BOMBE_3			; piece 30
	dw	MOBLIN2_ROM,ROM26,SPRH6_ADR,NIVEAU2,224,208,ZOOM1,BOMBE_3			; piece 31
	dw	MOBLIN2_ROM,ROM26,SPRH6_ADR,NIVEAU2,320,112,ZOOM1,RUBI_1			; piece 32
	dw	0,0,0,0,0,0,0,0	
	dw	MOBLIN2_ROM,ROM26,SPRH6_ADR,NIVEAU2,32,160,ZOOM1,RUBI_1			; piece 34
	dw	MOBLIN2_ROM,ROM26,SPRH6_ADR,NIVEAU2,32,160,ZOOM1,RUBI_1			; piece 35
	dw	PEAHAT_ROM,ROM28,SPRH6_ADR,INVINCIBLE,096,192,ZOOM1,RUBI_1			; piece 36
	dw	MOBLIN2_ROM,ROM26,SPRH6_ADR,NIVEAU2,096,144,ZOOM1,BOMBE_3			; piece 37
	dw	MOBLIN2_ROM,ROM26,SPRH6_ADR,NIVEAU2,320,224,ZOOM1,RUBI_1				; piece 38
	dw	MOBLIN2_ROM,ROM26,SPRH6_ADR,NIVEAU2,064,166,ZOOM1,BOMBE_3			; piece 39
	dw	0,0,0,0,0,0,0,0							; piece 40
	dw	MOBLIN1_ROM,ROM26,SPRH6_ADR,NIVEAU2,320,144,ZOOM1,AUCUN				; piece 41
	dw	0,0,0,0,0,0,0,0		
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,96,128,ZOOM1,RUBI_1			; piece 43
	dw	0,0,0,0,0,0,0,0												; piece 44 (POISSON)
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,96,128,ZOOM1,RUBI_1			; piece 45
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,256,176,ZOOM1,RUBI_1			; piece 46
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,192,176,ZOOM1,RUBI_1			; piece 47
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,128,144,ZOOM1,RUBI_1			; piece 48
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,192,144,ZOOM1,RUBI_1			; piece 49
	dw	TEKTITE2_ROM,ROM28,SPRH6_ADR,NIVEAU1,160,208,ZOOM1,AUCUN				; piece 50
	dw	MOBLIN1_ROM,ROM26,SPRH6_ADR,NIVEAU2,096,192,ZOOM1,RUBI_1  			; piece 51
	dw	MOBLIN2_ROM,ROM26,SPRH6_ADR,NIVEAU2,384,128,ZOOM1,RUBI_1			; piece 52
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,160,192,ZOOM1,RUBI_1			; piece 53
	dw	MOBLIN2_ROM,ROM26,SPRH6_ADR,NIVEAU2,384,144,ZOOM1,BOMBE_3			; piece 54
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,160,176,ZOOM1,RUBI_1			; piece 55
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,160,176,ZOOM1,RUBI_1			; piece 56
	dw	0,0,0,0,0,0,0,0	
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,064,160,ZOOM1,RUBI_1			; piece 58
	dw	OCTOROK2_ROM,ROM26,SPRH6_ADR,NIVEAU1,224,160,ZOOM1,BOMBE_3			; piece 59
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,096,192,ZOOM1,RUBI_1			; piece 60
	dw	TEKTITE1_ROM,ROM28,SPRH6_ADR,NIVEAU1,064,160,ZOOM1,RUBI_11			; piece 61
	dw	MOBLIN2_ROM,ROM26,SPRH6_ADR,NIVEAU2,384,128,ZOOM1,RUBI_1			; piece 62
	dw	0,0,0,0,0,0,0,0	
	dw	LEEVER1_ROM,ROM28,SPRH6_ADR,NIVEAU2,128,192,ZOOM1,RUBI_1			; piece 64				
	dw	PEAHAT_ROM,ROM28,SPRH6_ADR,INVINCIBLE,064,160,ZOOM1,AUCUN				; piece 65
	dw	PEAHAT_ROM,ROM28,SPRH6_ADR,INVINCIBLE,064,160,ZOOM1,AUCUN		; piece 66
	dw	LEEVER2_ROM,ROM28,SPRH6_ADR,NIVEAU2,192,160,ZOOM1,AUCUN				; piece 67
	dw	PEAHAT_ROM,ROM28,SPRH6_ADR,INVINCIBLE,224,144,ZOOM1,AUCUN				; piece 68
	dw	LEEVER1_ROM,ROM28,SPRH6_ADR,NIVEAU2,384,160,ZOOM1,AUCUN				; piece 69
	dw	PEAHAT_ROM,ROM28,SPRH6_ADR,INVINCIBLE,096,112,ZOOM1,AUCUN				; piece 70
	dw	OCTOROK1_ROM,ROM26,SPRH6_ADR,NIVEAU1,288,144,ZOOM1,RUBI_1			; piece 71
	dw	LEEVER2_ROM,ROM28,SPRH6_ADR,NIVEAU2,096,176,ZOOM1,AUCUN				; piece 72
	dw	0,0,0,0,0,0,0,0						; piece 73
	dw	0,0,0,0,0,0,0,0						; piece 74
	dw	0,0,0,0,0,0,0,0						; piece 75
	dw	LEEVER2_ROM,ROM28,SPRH6_ADR,NIVEAU2,256,176,ZOOM1,RUBI_1			; piece 76					
	dw	PEAHAT_ROM,ROM28,SPRH6_ADR,INVINCIBLE,096,112,ZOOM1,AUCUN				; piece 77
	dw	0,0,0,0,0,0,0,0						; piece 78
	dw	0,0,0,0,0,0,0,0						; piece 79
	dw	0,0,0,0,0,0,0,0						; piece 80 	
	dw	TEKTITE1_ROM,ROM28,SPRH6_ADR,NIVEAU1,384,160,ZOOM1,RUBI_11			; piece 81
	dw	0,0,0,0,0,0,0,0							; piece 82
	dw	0,0,0,0,0,0,0,0							; piece 83
	dw	PEAHAT_ROM,ROM28,SPRH6_ADR,INVINCIBLE,096,112,ZOOM1,AUCUN					; piece 84
	dw	TEKTITE1_ROM,ROM28,SPRH6_ADR,NIVEAU1,416,208,ZOOM1,AUCUN
	dw	PEAHAT_ROM,ROM28,SPRH6_ADR,INVINCIBLE,288,160,ZOOM1,AUCUN						; piece 86
	dw	0,0,0,0,0,0,0,0							; piece 87
	dw	TEKTITE1_ROM,ROM28,SPRH6_ADR,NIVEAU1,160,128,ZOOM1,AUCUN
	dw	TEKTITE1_ROM,ROM28,SPRH6_ADR,NIVEAU1,256,144,ZOOM1,RUBI_11
	dw	0,0,0,0,0,0,0,0							; piece 90
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	LYNEL1_ROM,ROM27,SPRH6_ADR,NIVEAU4,128,208,ZOOM1,AUCUN		; piece 93
	dw	LYNEL1_ROM,ROM27,SPRH6_ADR,NIVEAU4,160,192,ZOOM1,AUCUN			; piece 94
	dw	GHINI_ROM,ROM28,SPRH6_ADR,NIVEAU3,320,192,ZOOM1,RUBI_1			; piece 95
	dw	GHINI_ROM,ROM28,SPRH6_ADR,NIVEAU3,416,208,ZOOM1,RUBI_1				; piece 96
	dw	GHINI_ROM,ROM28,SPRH6_ADR,NIVEAU3,320,192,ZOOM1,RUBI_1				; piece 97
	dw	GHINI_ROM,ROM28,SPRH6_ADR,NIVEAU3,416,208,ZOOM1,RUBI_1				; piece 98
	dw	GHINI_ROM,ROM28,SPRH6_ADR,NIVEAU3,320,192,ZOOM1,RUBI_1				; piece 99
	dw	GHINI_ROM,ROM28,SPRH6_ADR,NIVEAU3,416,208,ZOOM1,RUBI_1				; piece 100
	dw	PEAHAT_ROM,ROM28,SPRH6_ADR,INVINCIBLE,384,192,zOOM1,AUCUN
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	LYNEL1_ROM,ROM27,SPRH6_ADR,NIVEAU4,096,144,ZOOM1,AUCUN
	dw	0,0,0,0,0,0,0,0												; piece 105
	dw	PEAHAT_ROM,ROM28,SPRH6_ADR,INVINCIBLE,160,108,ZOOM1,AUCUN			; piece 106
	dw	0,0,0,0,0,0,0,0												; piece 107
	dw	0,0,0,0,0,0,0,0												; piece 108
	dw	PEAHAT_ROM,ROM28,SPRH6_ADR,INVINCIBLE,160,108,ZOOM1,AUCUN			; piece 109
	dw	LYNEL1_ROM,ROM27,SPRH6_ADR,NIVEAU4,160,112,ZOOM1,AUCUN			; piece 110
	dw	LYNEL1_ROM,ROM27,SPRH6_ADR,NIVEAU4,096,144,ZOOM1,AUCUN
	dw	LYNEL2_ROM,ROM27,SPRH6_ADR,NIVEAU4,128,176,ZOOM1,RUBI_11			; piece 112
	dw	LYNEL1_ROM,ROM27,SPRH6_ADR,NIVEAU4,352,144,ZOOM1,AUCUN
	dw	LYNEL1_ROM,ROM27,SPRH6_ADR,NIVEAU4,064,160,ZOOM1,AUCUN
	dw	0,0,0,0,0,0,0,0												; piece 115
	dw	LYNEL1_ROM,ROM27,SPRH6_ADR,NIVEAU4,160,112,ZOOM1,AUCUN		; piece 116
	dw	PEAHAT_ROM,ROM28,SPRH6_ADR,INVINCIBLE,160,108,ZOOM1,AUCUN			; piece 117
	dw	0,0,0,0,0,0,0,0												; piece 118
	dw	PEAHAT_ROM,ROM28,SPRH6_ADR,INVINCIBLE,160,108,ZOOM1,AUCUN
	dw	0,0,0,0,0,0,0,0												; piece 120
	dw	0,0,0,0,0,0,0,0												; piece 121
	dw	0,0,0,0,0,0,0,0												; piece 122
	dw	0,0,0,0,0,0,0,0												; piece 123
	dw	PEAHAT_ROM,ROM28,SPRH6_ADR,INVINCIBLE,160,108,ZOOM1,AUCUN			; piece 124 
	dw	LYNEL1_ROM,ROM27,SPRH6_ADR,NIVEAU4,192,192,ZOOM1,AUCUN			; piece 125
	dw	LYNEL2_ROM,ROM27,SPRH6_ADR,NIVEAU4,064,160,ZOOM1,BOMBE_3			; piece 126
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
	dw	0,0,0,0,0,0,0,0	
	dw	KEESES_ROM,ROM28,SPRH6_ADR,NIVEAU1,160,160,ZOOM1,AUCUN					; piece 130
	dw	WALLMASTER_ROM,ROM28,SPRH6_ADR,NIVEAU1,256,176,ZOOM1,AUCUN				; piece 131
	dw	WALLMASTER_ROM,ROM28,SPRH6_ADR,NIVEAU1,288,144,ZOOM1,AUCUN				; piece 132
	dw	WALLMASTER_ROM,ROM28,SPRH6_ADR,NIVEAU1,384,128,ZOOM1,RUBI_1			; piece 133
	dw	KEESES_ROM,ROM28,SPRH6_ADR,NIVEAU1,230,208,ZOOM1,AUCUN				; piece 134
	dw	KEESES_ROM,ROM28,SPRH6_ADR,NIVEAU1,160,208,ZOOM1,AUCUN				; piece 135
	dw	GEL_ROM,ROM28,SPRH6_ADR,NIVEAU1,160,208,ZOOM1,AUCUN					; piece 136
	dw	GEL_ROM,ROM28,SPRH6_ADR,NIVEAU1,160,112,ZOOM1,AUCUN					; piece 137
	dw	0,0,0,0,0,0,0,0	
	dw	GORIYA1_ROM,ROM27,SPRH6_ADR,NIVEAU2,192,144,ZOOM1,AUCUN				; piece 139
	dw	WALLMASTER_ROM,ROM28,SPRH6_ADR,NIVEAU1,256,160,ZOOM1,AUCUN			; piece 140
	dw	GORIYA1_ROM,ROM27,SPRH6_ADR,NIVEAU2,192,144,ZOOM1,AUCUN				; piece 141
	dw	0,0,0,0,0,0,0,0	
	dw	0,0,0,0,0,0,0,0	
	dw	0,0,0,0,0,0,0,0	
	dw	0,0,0,0,0,0,0,0	
	dw	KEESES_ROM,ROM28,SPRH6_ADR,NIVEAU1,288,192,ZOOM1,AUCUN				; piece 146 (CAVE)
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////// DONJON 2 ////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
	dw	0,0,0,0,0,0,0,0										; piece 147
	dw	ROPE1_ROM,ROM28,SPRH6_ADR,NIVEAU2,160,208,ZOOM1,RUBI_1								; piece 148
	dw	ROPE1_ROM,ROM28,SPRH6_ADR,NIVEAU2,288,144,ZOOM1,RUBI_1
	dw	GEL_ROM,ROM28,SPRH6_ADR,NIVEAU2,160,128,ZOOM1,RUBI_1										; piece 150
	dw	ROPE1_ROM,ROM28,SPRH6_ADR,NIVEAU2,128,192,ZOOM1,RUBI_1
	dw	ROPE1_ROM,ROM28,SPRH6_ADR,NIVEAU2,128,192,ZOOM1,RUBI_1
	dw	GORIYA1_ROM,ROM27,SPRH6_ADR,NIVEAU3,352,112,ZOOM1,RUBI_1
	dw	ROPE1_ROM,ROM28,SPRH6_ADR,NIVEAU2,384,192,ZOOM1,RUBI_1
	dw	GORIYA2_ROM,ROM27,SPRH6_ADR,NIVEAU4,320,144,ZOOM1,RUBI_1									; piece 155	
	dw	KEESES_ROM,ROM28,SPRH6_ADR,NIVEAU2,064,208,ZOOM1,AUCUN
	dw	GEL_ROM,ROM28,SPRH6_ADR,NIVEAU2,320,112,ZOOM1,RUBI_1
	dw	0,0,0,0,0,0,0,0										; piece 158
	dw	ROPE1_ROM,ROM28,SPRH6_ADR,NIVEAU2,320,112,ZOOM1,RUBI_1
	dw	0,0,0,0,0,0,0,0										; piece 160
	dw	ROPE1_ROM,ROM28,SPRH6_ADR,NIVEAU2,096,160,ZOOM1,RUBI_1
	dw	GORIYA1_ROM,ROM27,SPRH6_ADR,NIVEAU3,192,144,ZOOM1,RUBI_1
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
	dw	ZOL_ROM,ROM28,SPRH6_ADR,NIVEAU3,160,176,ZOOM1,RUBI_1						; piece 166
	dw	ZOL_ROM,ROM28,SPRH6_ADR,NIVEAU3,320,176,ZOOM1,RUBI_1						; piece 167
	dw	DARKNUT1_ROM,ROM27,SPRH6_ADR,NIVEAU4,320,112,ZOOM1,RUBI_1					; piece 168
	dw	KEESES_ROM,ROM28,SPRH6_ADR,NIVEAU3,096,192,ZOOM1,AUCUN						; piece 169
	dw	DARKNUT1_ROM,ROM27,SPRH6_ADR,NIVEAU4,196,128,ZOOM1,RUBI_1					; piece 170
	dw	DARKNUT1_ROM,ROM27,SPRH6_ADR,NIVEAU4,096,192,ZOOM1,RUBI_1					; piece 171
	dw	KEESES_ROM,ROM28,SPRH6_ADR,NIVEAU3,128,128,ZOOM1,AUCUN						; piece 172
	dw	KEESES_ROM,ROM28,SPRH6_ADR,NIVEAU3,384,128,ZOOM1,AUCUN						; piece 173
	dw	KEESES_ROM,ROM28,SPRH6_ADR,NIVEAU3,160,208,ZOOM1,AUCUN						; piece 174
	dw	ZOL_ROM,ROM28,SPRH6_ADR,NIVEAU3,256,176,ZOOM1,RUBI_1						; piece 175
	dw	ZOL_ROM,ROM28,SPRH6_ADR,NIVEAU3,320,192,ZOOM1,RUBI_1						; piece 176
	dw	0,0,0,0,0,0,0,0
	dw	KEESES_ROM,ROM28,SPRH6_ADR,NIVEAU3,192,144,ZOOM1,AUCUN
	dw	KEESES_ROM,ROM28,SPRH6_ADR,NIVEAU3,384,128,ZOOM1,AUCUN
	dw	DARKNUT1_ROM,ROM27,SPRH6_ADR,NIVEAU4,192,176,ZOOM1,RUBI_1					; piece 180
	dw	ZOL_ROM,ROM28,SPRH6_ADR,NIVEAU3,160,208,ZOOM1,RUBI_1
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
	dw	KEESES_ROM,ROM28,SPRH6_ADR,NIVEAU3,064,160,ZOOM1,AUCUN	
	dw	VIRE_ROM,ROM28,SPRH6_ADR,NIVEAU4,160,112,ZOOM1,0
	dw	VIRE_ROM,ROM28,SPRH6_ADR,NIVEAU4,256,144,ZOOM1,0
	dw	KEESES_ROM,ROM28,SPRH6_ADR,NIVEAU3,160,112,ZOOM1,AUCUN
	dw	VIRE_ROM,ROM28,SPRH6_ADR,NIVEAU4,160,144,ZOOM1,0
	dw	ZOLNOIR_ROM,ROM28,SPRH6_ADR,NIVEAU5,320,112,ZOOM1,0					; piece 190
	dw	VIRE_ROM,ROM28,SPRH6_ADR,NIVEAU4,160,176,ZOOM1,0
	dw	VIRE_ROM,ROM28,SPRH6_ADR,NIVEAU4,384,192,ZOOM1,0
	dw	ZOLNOIR_ROM,ROM28,SPRH6_ADR,NIVEAU5,416,160,ZOOM1,0					; piece 193
	dw	KEESES_ROM,ROM28,SPRH6_ADR,NIVEAU3,160,176,ZOOM1,AUCUN
	dw	ZOLNOIR_ROM,ROM28,SPRH6_ADR,NIVEAU5,352,112,ZOOM1,0
	dw	VIRE_ROM,ROM28,SPRH6_ADR,NIVEAU4,320,112,ZOOM1,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	KEESES_ROM,ROM28,SPRH6_ADR,NIVEAU3,160,112,ZOOM1,AUCUN
	dw	0,0,0,0,0,0,0,0												; piece 200
	dw	ELECTRO_ROM,ROM28,SPRH6_ADR,INVINCIBLE,160,112,ZOOM1,AUCUN
	dw	VIRE_ROM,ROM28,SPRH6_ADR,NIVEAU4,320,112,ZOOM1,0
	dw	0,ROM30,SPRH6_ADR,#0308,352,144,ZOOM1,0					; BOSS
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0

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




	
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	FISH_VERT_ROM,ROM28,SPRH6_ADR,#0101,160,112,ZOOM1,#0001						; piece 26
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	FISH_VERT_ROM,ROM28,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0										; piece 210
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0	
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0										; piece 220
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	TEKTITE1_ROM,ROM28,SPRH6_ADR,#0101,320,128,ZOOM1,0			; piece  222
	dw	TEKTITE1_ROM,ROM28,SPRH6_ADR,#0101,096,192,ZOOM1,0			; piece 223
	dw	PEAHAT_ROM,ROM28,SPRH6_ADR,#0101,032,208,ZOOM2,0			; piece 224
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	FISH_BLEU_ROM,ROM28,SPRH6_ADR,#0101,128,224,ZOOM1,0										; piece 230
	dw	LEEVER1_ROM,ROM28,SPRH6_ADR,#0101,128,176,ZOOM1,0				; piece 231
	dw	LEEVER1_ROM,ROM28,SPRH6_ADR,#0101,448,112,ZOOM1,0				; piece 232
	dw	FISH_ROUGE_ROM,ROM28,SPRH6_ADR,#0101,352,176,ZOOM1,0			; piece 233
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	FISH_VERT_ROM,ROM28,SPRH6_ADR,#0101,160,112,ZOOM1,0							; piece 235
	dw	FISH_VERT_ROM,ROM28,SPRH6_ADR,#0101,160,208,ZOOM1,0						; piece 236
	dw	FISH_BLEU_ROM,ROM28,SPRH6_ADR,#0101,448,128,ZOOM1,RUBI_1				; piece 237
	dw	FISH_BLEU_ROM,ROM28,SPRH6_ADR,#0101,448,128,ZOOM1,RUBI_1				; piece 238
	dw	FISH_VERT_ROM,ROM28,SPRH6_ADR,#0101,160,160,ZOOM1,0						; piece 239
	dw	FISH_VERT_ROM,ROM28,SPRH6_ADR,#0101,064,144,ZOOM2,0										; piece 240
	dw	FISH_ROUGE_ROM,ROM28,SPRH6_ADR,#0101,160,112,ZOOM2,0						; piece 241
	dw	FISH_VERT_ROM,ROM28,SPRH6_ADR,#0101,448,128,ZOOM1,VIANDE_6
	dw	TEKTITE2_ROM,ROM28,SPRH6_ADR,#0101,448,192,ZOOM1,BOMBE_3					; piece 243
	dw	FISH_VERT_ROM,ROM28,SPRH6_ADR,#0101,192,128,ZOOM1,CLE_4
	dw	FISH_VERT_ROM,ROM28,SPRH6_ADR,#0101,064,176,ZOOM1,RUBI_1
	dw	FISH_VERT_ROM,ROM28,SPRH6_ADR,#0101,064,160,ZOOM1,RUBI_1
	dw	FISH_VERT_ROM,ROM28,SPRH6_ADR,#0101,064,208,ZOOM1,RUBI_1
	dw	FISH_VERT_ROM,ROM28,SPRH6_ADR,#0101,256,080,ZOOM1,RUBI_1
	dw	FISH_VERT_ROM,ROM28,SPRH6_ADR,#0101,064,160,ZOOM1,RUBI_1
	dw	TEKTITE2_ROM,ROM28,SPRH6_ADR,#0101,288,112,ZOOM1,0										; piece 250
	dw	TEKTITE2_ROM,ROM28,SPRH6_ADR,#0101,384,224,ZOOM1,0
	dw	TEKTITE2_ROM,ROM28,SPRH6_ADR,#0101,448,128,ZOOM1,BOMBE_3
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	FISH_VERT_ROM,ROM28,SPRH6_ADR,#0101,416,208,ZOOM1,CLE_4
	dw	FISH_VERT_ROM,ROM28,SPRH6_ADR,#0101,416,96,ZOOM1,RUBI_1
	; //////////////////////////////////////////////////////////////////////////////////////////////////////////
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0										; piece 260
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	FISH_VERT_ROM,ROM28,SPRH6_ADR,#0101,160,112,ZOOM1,0						; piece 26
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0	
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0										; piece 270
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0	
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH6_ADR,#0101,0,0,ZOOM1,0										; piece 280
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
