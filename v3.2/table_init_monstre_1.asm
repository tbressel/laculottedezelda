table_init_monstre_1
	; 	#0000=AUCUN    #0001=RUBI_1
	;	TYPE DE MONSTRE,n°Bank,SPRH DESTINATION,nbr coup #épée#fleche,pop en X,pop en Y,ZOOM,Zora (1=oui) et no de l'objet laissé
	; 	le nombre de coup d'épée est a designer en focntion du nombre de cycle d'affichage de l'épee à l'écran donc  1 coup = 10 cycle
	;   #1E = 30
	dw	0,0,0,0,0,0,0,0							; piece 0
	dw	0,0,0,0,0,0,0,0									; piece 1
	dw	TEKTITE1_ROM,ROM28,SPRH5_ADR,NIVEAU1,096,128,ZOOM1,RUBI_1		; piece 02
	dw	PEAHAT_ROM,ROM28,SPRH5_ADR,INVINCIBLE,064,160,ZOOM1,ZOLA_1		; piece 03
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,112,112,ZOOM1,RUBI_1		; piece 04
	dw	TEKTITE2_ROM,ROM28,SPRH5_ADR,NIVEAU1,256,144,ZOOM1,RUBI_1		; piece 05	
	dw	TEKTITE2_ROM,ROM28,SPRH5_ADR,NIVEAU1,160,128,ZOOM1,RUBI_1		; piece 06
	dw	LEEVER1_ROM,ROM28,SPRH5_ADR,NIVEAU2,096,160,ZOOM1,RUBI_ET_ZOLA		; piece 07
	dw	LEEVER1_ROM,ROM28,SPRH5_ADR,NIVEAU2,096,160,ZOOM1,RUBI_ET_ZOLA		; piece 08
	dw	OCTOROK2_ROM,ROM26,SPRH5_ADR,NIVEAU1,384,112,ZOOM1,ZOLA_1		; piece 09
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,416,160,ZOOM1,RUBI_ET_ZOLA		; piece 10
	dw	OCTOROK2_ROM,ROM26,SPRH5_ADR,NIVEAU1,160,112,ZOOM1,ZOLA_1		; piece 11
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,096,128,ZOOM1,RUBI_ET_ZOLA		; piece 12
	dw	MOBLIN1_ROM,ROM26,SPRH5_ADR,NIVEAU2,128,144,ZOOM1,AUCUN		; piece 13
	dw	MOBLIN1_ROM,ROM26,SPRH5_ADR,NIVEAU2,96,112,ZOOM1,AUCUN		; piece 14
	dw	MOBLIN2_ROM,ROM26,SPRH5_ADR,NIVEAU2,96,208,ZOOM1,RUBI_1		; piece 15
	dw	MOBLIN2_ROM,ROM26,SPRH5_ADR,NIVEAU2,64,112,ZOOM1,AUCUN		; piece 16
	dw	MOBLIN2_ROM,ROM26,SPRH5_ADR,NIVEAU2,160,112,ZOOM1,AUCUN		; piece 17
	dw	MOBLIN1_ROM,ROM26,SPRH5_ADR,NIVEAU2,096,144,ZOOM1,AUCUN		; piece 18
	dw	OCTOROK2_ROM,ROM26,SPRH5_ADR,NIVEAU1,416,224,ZOOM1,AUCUN		; piece 19
	dw	MOBLIN1_ROM,ROM26,SPRH5_ADR,NIVEAU2,96,112,ZOOM1,AUCUN		; piece 20
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,160,144,ZOOM1,RUBI_ET_ZOLA		; piece 21
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,160,208,ZOOM1,RUBI_ET_ZOLA		; piece 22
	dw	PEAHAT_ROM,ROM28,SPRH5_ADR,INVINCIBLE,064,160,ZOOM1,ZOLA_1		; piece 23
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,160,112,ZOOM1,RUBI_ET_ZOLA		; piece 24
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,448,112,ZOOM1,AUCUN		; piece 25
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,160,112,ZOOM1,RUBI_1		; piece 26
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,320,112,ZOOM1,RUBI_1		; piece 27
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,96,128,ZOOM1,RUBI_ET_ZOLA		; piece 28
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,96,128,ZOOM1,AUCUN		; piece 29
	dw	OCTOROK2_ROM,ROM26,SPRH5_ADR,NIVEAU1,160,192,ZOOM1,AUCUN		; piece 30
	dw	MOBLIN2_ROM,ROM26,SPRH5_ADR,NIVEAU2,192,208,ZOOM1,AUCUN		; piece 31
	dw	MOBLIN2_ROM,ROM26,SPRH5_ADR,NIVEAU2,32,112,ZOOM1,AUCUN		; piece 32
	dw  TEKTITE1_ROM,ROM28,SPRH5_ADR,NIVEAU1,288,192,ZOOM1,AUCUN		; piece 33
	dw	MOBLIN2_ROM,ROM26,SPRH5_ADR,NIVEAU2,64,208,ZOOM1,RUBI_1		; piece 34
	dw	MOBLIN2_ROM,ROM26,SPRH5_ADR,NIVEAU2,32,112,ZOOM1,RUBI_1		; piece 35
	dw	PEAHAT_ROM,ROM28,SPRH5_ADR,INVINCIBLE,096,128,ZOOM1,AUCUN		; piece 36
	dw	MOBLIN2_ROM,ROM26,SPRH5_ADR,NIVEAU2,384,144,ZOOM1,RUBI_1		; piece 37
	dw	MOBLIN2_ROM,ROM26,SPRH5_ADR,NIVEAU2,384,208,ZOOM1,AUCUN		; piece 38
	dw	MOBLIN2_ROM,ROM26,SPRH5_ADR,NIVEAU2,096,128,ZOOM1,AUCUN		; piece 39
	dw	MOBLIN1_ROM,ROM26,SPRH5_ADR,NIVEAU2,160,112,ZOOM1,AUCUN		; piece 40
	dw	MOBLIN1_ROM,ROM26,SPRH5_ADR,NIVEAU2,384,128,ZOOM1,AUCUN		; piece 41
	dw	PETITE_FEE_ROM,ROM28,SPRH5_ADR,NIVEAU1,160,208,ZOOM1,AUCUN		; piece 42		
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,160,112,ZOOM1,RUBI_1		; piece 43
	dw	0,0,0,0,0,0,0,0										
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,160,112,ZOOM1,RUBI_1		; piece 45
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,160,208,ZOOM1,RUBI_1		; piece 46
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,064,176,ZOOM1,RUBI_1		; piece 47
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,192,112,ZOOM1,RUBI_1		; piece 48
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,096,128,ZOOM1,RUBI_1		; piece 49
	dw	TEKTITE2_ROM,ROM28,SPRH5_ADR,NIVEAU1,160,112,ZOOM1,RUBI_1		; piece 50
	dw	MOBLIN1_ROM,ROM26,SPRH5_ADR,NIVEAU2,064,176,ZOOM1,AUCUN		; piece 51
	dw	MOBLIN2_ROM,ROM26,SPRH5_ADR,NIVEAU2,096,128,ZOOM1,AUCUN		; piece 52
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,096,112,ZOOM1,AUCUN		; piece 53
	dw	MOBLIN2_ROM,ROM26,SPRH5_ADR,NIVEAU2,384,112,ZOOM1,RUBI_1		; piece 54
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,256,096,ZOOM1,RUBI_ET_ZOLA		; piece 55
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,160,192,ZOOM1,AUCUN		; piece 56
	dw	OCTOROK2_ROM,ROM26,SPRH5_ADR,NIVEAU1,096,192,ZOOM1,ZOLA_1		; piece 57
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,096,128,ZOOM1,RUBI_ET_ZOLA		; piece 58
	dw	OCTOROK2_ROM,ROM26,SPRH5_ADR,NIVEAU1,128,176,ZOOM1,ZOLA_1		; piece 59
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,064,160,ZOOM1,RUBI_ET_ZOLA		; piece 60
	dw	TEKTITE1_ROM,ROM28,SPRH5_ADR,NIVEAU1,128,112,ZOOM1,AUCUN		; piece 61
	dw	MOBLIN2_ROM,ROM26,SPRH5_ADR,NIVEAU2,096,128,ZOOM1,AUCUN		; piece 62
	dw	OCTOROK2_ROM,ROM26,SPRH5_ADR,NIVEAU1,128,128,ZOOM1,AUCUN		; piece 63
	dw	LEEVER1_ROM,ROM28,SPRH5_ADR,NIVEAU2,064,144,ZOOM1,AUCUN		; piece 64
	dw	PEAHAT_ROM,ROM28,SPRH5_ADR,INVINCIBLE,096,192,ZOOM1,AUCUN		; piece 65	
	dw	PETITE_FEE_ROM,ROM28,SPRH5_ADR,NIVEAU1,384,112,ZOOM1,AUCUN		;piece 66
	dw	LEEVER2_ROM,ROM28,SPRH5_ADR,NIVEAU2,128,112,ZOOM1,AUCUN		; piece 67
	dw	PEAHAT_ROM,ROM28,SPRH5_ADR,INVINCIBLE,160,176,ZOOM1,AUCUN		; piece 68
	dw	LEEVER1_ROM,ROM28,SPRH5_ADR,NIVEAU2,128,160,ZOOM1,RUBI_1		; piece 69
	dw	PEAHAT_ROM,ROM28,SPRH5_ADR,INVINCIBLE,064,160,ZOOM1,ZOLA_1		; piece 70
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,384,128,ZOOM1,RUBI_ET_ZOLA		; piece 71
	dw	LEEVER2_ROM,ROM28,SPRH5_ADR,NIVEAU2,256,128,ZOOM1,ZOLA_1		; piece 72
	dw	0,0,0,0,0,0,0,ZOLA_1						; piece 73 (POISSON)
	dw	0,0,0,0,0,0,0,ZOLA_1						; piece 74 (POISSON)
	dw	OCTOROK1_ROM,ROM26,SPRH5_ADR,NIVEAU1,320,208,ZOOM1,RUBI_1		; piece 75
	dw	LEEVER2_ROM,ROM28,SPRH5_ADR,NIVEAU2,256,208,ZOOM1,ZOLA_1		; piece 76
	dw	PEAHAT_ROM,ROM28,SPRH5_ADR,INVINCIBLE,064,144,ZOOM1,AUCUN		; piece 77
	dw	0,0,0,0,0,0,0,ZOLA_1						; piece 78 (POISSON)	
	dw	0,0,0,0,0,0,0,ZOLA_1						; piece 79 (POISSON)	
	dw	0,0,0,0,0,0,0,ZOLA_1						; piece 80 (POISSON)	
	dw	TEKTITE1_ROM,ROM28,SPRH5_ADR,NIVEAU1,096,176,ZOOM1,ZOLA_1		; piece 81
	dw	0,0,0,0,0,0,0,0							; piece 82
	dw	0,0,0,0,0,0,0,0							; piece 83
	dw	PEAHAT_ROM,ROM28,SPRH5_ADR,INVINCIBLE,064,144,ZOOM1,AUCUN			; piece 84
	dw	TEKTITE1_ROM,ROM28,SPRH5_ADR,NIVEAU1,160,112,ZOOM1,AUCUN			; piece 85
	dw	PEAHAT_ROM,ROM28,SPRH5_ADR,INVINCIBLE,416,160,ZOOM1,AUCUN			; piece 86
	dw	0,0,0,0,0,0,0,0							; piece 87
	dw	TEKTITE1_ROM,ROM28,SPRH5_ADR,NIVEAU1,096,160,ZOOM1,AUCUN			; piece 88			
	dw	TEKTITE1_ROM,ROM28,SPRH5_ADR,NIVEAU1,256,144,ZOOM1,AUCUN		; piece 89
	dw	LYNEL2_ROM,ROM27,SPRH5_ADR,NIVEAU4,128,112,ZOOM1,RUBI_ET_ZOLA		; piece 90
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	LYNEL1_ROM,ROM27,SPRH5_ADR,NIVEAU4,64,176,ZOOM1,RUBI_1			; piece 93	
	dw	LYNEL1_ROM,ROM27,SPRH5_ADR,NIVEAU4,128,160,ZOOM1,AUCUN		; piece 94
	dw	GHINI_ROM,ROM28,SPRH5_ADR,NIVEAU3,320,192,ZOOM1,RUBI_1				; piece 95
	dw	GHINI_ROM,ROM28,SPRH5_ADR,NIVEAU3,320,192,ZOOM1,AUCUN				; piece 96
	dw	GHINI_ROM,ROM28,SPRH5_ADR,NIVEAU3,320,192,ZOOM1,RUBI_1				; piece 97
	dw	GHINI_ROM,ROM28,SPRH5_ADR,NIVEAU3,320,192,ZOOM1,AUCUN				; piece 98
	dw	GHINI_ROM,ROM28,SPRH5_ADR,NIVEAU3,320,192,ZOOM1,RUBI_1				; piece 99
	dw	GHINI_ROM,ROM28,SPRH5_ADR,NIVEAU3,320,192,ZOOM1,AUCUN				; piece 100
	dw	PEAHAT_ROM,ROM28,SPRH5_ADR,INVINCIBLE,416,160,ZOOM1,AUCUN		; piece 101
	dw	0,0,0,0,0,0,0,0
	dw	LYNEL1_ROM,ROM27,SPRH5_ADR,NIVEAU4,096,112,ZOOM1,AUCUN		; piece 103
	dw	LYNEL1_ROM,ROM27,SPRH5_ADR,NIVEAU4,160,128,ZOOM1,AUCUN		; piece 104
	dw	0,0,0,0,0,0,0,0												; piece 105
	dw	PEAHAT_ROM,ROM28,SPRH5_ADR,INVINCIBLE,160,112,ZOOM1,AUCUN		; piece 106
	dw	0,0,0,0,0,0,0,0												; piece 107
	dw	0,0,0,0,0,0,0,0												; piece 108
	dw	PEAHAT_ROM,ROM28,SPRH5_ADR,INVINCIBLE,160,112,ZOOM1,AUCUN		; piece 109
	dw	LYNEL1_ROM,ROM27,SPRH5_ADR,NIVEAU4,096,112,ZOOM1,RUBI_1		; piece 110
	dw	LYNEL1_ROM,ROM27,SPRH5_ADR,NIVEAU4,032,192,ZOOM1,AUCUN
	dw	LYNEL2_ROM,ROM27,SPRH5_ADR,NIVEAU4,096,192,ZOOM1,AUCUN			; piece 112
	dw	LYNEL1_ROM,ROM27,SPRH5_ADR,NIVEAU4,064,160,ZOOM1,AUCUN
	dw	LYNEL1_ROM,ROM27,SPRH5_ADR,NIVEAU4,096,192,ZOOM1,AUCUN			; piece 114
	dw	0,0,0,0,0,0,0,0												; piece 115
	dw	LYNEL1_ROM,ROM27,SPRH5_ADR,NIVEAU4,160,112,ZOOM1,RUBI_1		; piece 116
	dw	PEAHAT_ROM,ROM28,SPRH5_ADR,INVINCIBLE,096,112,ZOOM1,AUCUN			; piece 117
	dw	0,0,0,0,0,0,0,0												; piece 118
	dw	PEAHAT_ROM,ROM28,SPRH5_ADR,INVINCIBLE,096,112,ZOOM1,AUCUN		; piece 119
	dw	PETITE_FEE_ROM,ROM28,SPRH5_ADR,NIVEAU1,096,112,ZOOM1,AUCUN		; piece 120
	dw	LYNEL1_ROM,ROM27,SPRH5_ADR,NIVEAU4,256,160,ZOOM1,AUCUN			; piece 121
	dw	0,0,0,0,0,0,0,0												; piece 122
	dw	0,0,0,0,0,0,0,0												; piece 123
	dw	PEAHAT_ROM,ROM28,SPRH5_ADR,INVINCIBLE,096,112,ZOOM1,AUCUN		; piece 124
	dw	LYNEL1_ROM,ROM27,SPRH5_ADR,NIVEAU4,032,192,ZOOM1,RUBI_1			; piece 125
	dw	LYNEL1_ROM,ROM27,SPRH5_ADR,NIVEAU4,064,160,ZOOM1,AUCUN			; piece 126
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
	dw	0,0,0,0,0,0,0,0														; piece 129			
	dw	KEESES_ROM,ROM28,SPRH5_ADR,NIVEAU1,096,144,ZOOM1,AUCUN				; piece 130
	dw	WALLMASTER_ROM,ROM28,SPRH5_ADR,NIVEAU1,160,208,ZOOM1,AUCUN			; piece 131
	dw	WALLMASTER_ROM,ROM28,SPRH5_ADR,NIVEAU1,192,144,ZOOM1,AUCUN			; piece 132
	dw	WALLMASTER_ROM,ROM28,SPRH5_ADR,NIVEAU1,320,112,ZOOM1,AUCUN			; piece 133
	dw	KEESES_ROM,ROM28,SPRH5_ADR,NIVEAU1,230,112,ZOOM1,AUCUN				; piece 134
	dw	KEESES_ROM,ROM28,SPRH5_ADR,NIVEAU1,160,112,ZOOM1,AUCUN				; piece 135
	dw	GEL_ROM,ROM28,SPRH5_ADR,NIVEAU1,160,112,ZOOM1,RUBI_1					; piece 136
	dw	GEL_ROM,ROM28,SPRH5_ADR,NIVEAU1,128,128,ZOOM1,RUBI_1					; piece 137
	dw	0,0,0,0,0,0,0,0														; piece 138
	dw	GORIYA1_ROM,ROM27,SPRH5_ADR,NIVEAU2,160,112,ZOOM1,RUBI_1				; piece 139
	dw	WALLMASTER_ROM,ROM28,SPRH5_ADR,NIVEAU1,160,176,ZOOM1,AUCUN			; piece 140
	dw	GORIYA1_ROM,ROM27,SPRH5_ADR,NIVEAU2,160,112,ZOOM1,AUCUN				; piece 141
	dw	GORIYA1_ROM,ROM27,SPRH5_ADR,NIVEAU2,160,112,ZOOM1,AUCUN				; piece 142
	dw	0,0,0,0,0,0,0,0														; piece 143
	dw	0,ROM30,SPRH5_ADR,NIVEAU_BOSS_1,352,144,ZOOM1,#00ff							; piece 144 (BOSS)
	dw	0,0,0,0,0,0,0,0														; piece 145
	dw	KEESES_ROM,ROM28,SPRH5_ADR,NIVEAU1,096,176,ZOOM1,AUCUN				; piece 146 (CAVE)
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
	dw	ROPE1_ROM,ROM28,SPRH5_ADR,NIVEAU2,160,112,ZOOM1,AUCUN								; piece 148
	dw	ROPE1_ROM,ROM28,SPRH5_ADR,NIVEAU2,192,144,ZOOM1,AUCUN
	dw	GEL_ROM,ROM28,SPRH5_ADR,NIVEAU2,160,112,ZOOM1,AUCUN								; piece 150
	dw	ROPE1_ROM,ROM28,SPRH5_ADR,NIVEAU2,128,128,ZOOM1,AUCUN
	dw	ROPE1_ROM,ROM28,SPRH5_ADR,NIVEAU2,128,128,ZOOM1,AUCUN
	dw	GORIYA1_ROM,ROM27,SPRH5_ADR,NIVEAU3,160,112,ZOOM1,AUCUN
	dw	ROPE1_ROM,ROM28,SPRH5_ADR,NIVEAU2,384,128,ZOOM1,AUCUN								; piece 154
	dw	GORIYA2_ROM,ROM27,SPRH5_ADR,NIVEAU4,384,128,ZOOM1,AUCUN							; piece 155
	dw	KEESES_ROM,ROM28,SPRH5_ADR,NIVEAU2,064,112,ZOOM2,AUCUN							; piece 156
	dw	GEL_ROM,ROM28,SPRH5_ADR,NIVEAU2,384,128,ZOOM1,AUCUN
	dw	0,0,0,0,0,0,0,0										; piece 158
	dw	ROPE1_ROM,ROM28,SPRH5_ADR,NIVEAU2,384,128,ZOOM1,AUCUN								; piece 159
	dw	0,0,0,0,0,0,0,0										; piece 160
	dw	ROPE1_ROM,ROM28,SPRH5_ADR,NIVEAU2,096,128,ZOOM1,AUCUN
	dw	GORIYA1_ROM,ROM27,SPRH5_ADR,NIVEAU3,160,112,ZOOM1,AUCUN
	dw	0,ROM30,SPRH5_ADR,NIVEAU_BOSS_2,352,144,ZOOM1,#00ff									; piece 163 (BOSS)
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
	dw	ZOL_ROM,ROM28,SPRH5_ADR,NIVEAU3,096,192,ZOOM1,AUCUN							; piece 166
	dw	ZOL_ROM,ROM28,SPRH5_ADR,NIVEAU3,160,176,ZOOM1,AUCUN							; piece 167
	dw	DARKNUT1_ROM,ROM27,SPRH5_ADR,NIVEAU4,384,128,ZOOM1,AUCUN					; piece 168
	dw	KEESES_ROM,ROM28,SPRH5_ADR,NIVEAU3,096,128,ZOOM1,AUCUN						; piece 169
	dw	DARKNUT1_ROM,ROM27,SPRH5_ADR,NIVEAU4,064,160,ZOOM1,AUCUN					; piece 170
	dw	DARKNUT1_ROM,ROM27,SPRH5_ADR,NIVEAU4,096,192,ZOOM1,AUCUN					; piece 171
	dw	KEESES_ROM,ROM28,SPRH5_ADR,NIVEAU3,128,128,ZOOM1,AUCUN						; piece 172 (CAVE)
	dw	KEESES_ROM,ROM28,SPRH5_ADR,NIVEAU3,196,128,ZOOM1,AUCUN						; piece 173
	dw	KEESES_ROM,ROM28,SPRH5_ADR,NIVEAU3,160,112,ZOOM1,AUCUN						; piece 174
	dw	ZOL_ROM,ROM28,SPRH5_ADR,NIVEAU3,256,144,ZOOM1,AUCUN							; piece 175
	dw	ZOL_ROM,ROM28,SPRH5_ADR,NIVEAU3,384,128,ZOOM1,AUCUN							; piece 176
	dw	0,0,0,0,0,0,0,0
	dw	KEESES_ROM,ROM28,SPRH5_ADR,NIVEAU3,320,112,ZOOM1,AUCUN
	dw	KEESES_ROM,ROM28,SPRH5_ADR,NIVEAU3,196,128,ZOOM1,AUCUN
	dw	DARKNUT1_ROM,ROM27,SPRH5_ADR,NIVEAU4,160,208,ZOOM1,AUCUN						; piece 180
	dw	ZOL_ROM,ROM28,SPRH5_ADR,NIVEAU3,160,112,ZOOM1,AUCUN
	dw	0,ROM30,SPRH5_ADR,#0308,352,144,ZOOM1,#00ff			
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
	dw	KEESES_ROM,ROM28,SPRH5_ADR,NIVEAU3,096,128,ZOOM1,AUCUN					; piece 185
	dw	VIRE_ROM,ROM28,SPRH5_ADR,NIVEAU4,096,128,ZOOM1,0						; piece 186
	dw	VIRE_ROM,ROM28,SPRH5_ADR,NIVEAU4,160,192,ZOOM1,0						; piece 187 (boussole)
	dw	KEESES_ROM,ROM28,SPRH5_ADR,NIVEAU3,096,128,ZOOM1,AUCUN					; piece 188
	dw	VIRE_ROM,ROM28,SPRH5_ADR,NIVEAU4,064,160,ZOOM1,0
	dw	ZOLNOIR_ROM,ROM28,SPRH5_ADR,NIVEAU5,160,112,ZOOM1,0					; piece 190
	dw	VIRE_ROM,ROM28,SPRH5_ADR,NIVEAU4,160,112,ZOOM1,0
	dw	VIRE_ROM,ROM28,SPRH5_ADR,NIVEAU4,384,128,ZOOM1,0
	dw	ZOLNOIR_ROM,ROM28,SPRH5_ADR,NIVEAU5,160,128,ZOOM1,0					; piece 193
	dw	KEESES_ROM,ROM28,SPRH5_ADR,NIVEAU3,064,176,ZOOM1,AUCUN
	dw	ZOLNOIR_ROM,ROM28,SPRH5_ADR,NIVEAU5,160,112,ZOOM1,0					; piece 195
	dw	VIRE_ROM,ROM28,SPRH5_ADR,NIVEAU4,160,112,ZOOM1,0
	dw	0,0,0,0,0,0,0,0
	dw	0,0,0,0,0,0,0,0
	dw	KEESES_ROM,ROM28,SPRH5_ADR,NIVEAU3,096,128,ZOOM1,AUCUN
	dw	PETITE_FEE_ROM,ROM28,SPRH5_ADR,NIVEAU1,384,112,ZOOM1,AUCUN			; piece 200
	dw	ELECTRO_ROM,ROM28,SPRH5_ADR,INVINCIBLE,096,128,ZOOM1,AUCUN
	dw	VIRE_ROM,ROM28,SPRH5_ADR,NIVEAU4,160,112,ZOOM1,0
	dw	MARIO_ROM,ROM27,SPRH5_ADR,#1E05,416,208,ZOOM1,#0000				; BOSS MARIO
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0										; piece 204
	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////// OCEAN ////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////			
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	FISH_ROUGE_ROM,ROM28,SPRH5_ADR,#0103,160,112,ZOOM1,0						; piece 206
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0							; piece 210
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0	
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	ZELDA_ROM,ROM27,SPRH5_ADR,#9600,256,160,ZOOM1,#0009						; piece 220 (chez Zelda)
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	TEKTITE1_ROM,ROM28,SPRH5_ADR,#0101,064,112,ZOOM1,0				; piece 222
	dw	TEKTITE1_ROM,ROM28,SPRH5_ADR,#0101,192,208,ZOOM1,0				; piece 223
	dw	PEAHAT_ROM,ROM28,SPRH5_ADR,#0101,032,112,ZOOM2,0				; piece 224
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	FISH_BLEU_ROM,ROM28,SPRH5_ADR,#0101,064,208,ZOOM1,RUBI_1										; piece 230
	dw	LEEVER1_ROM,ROM28,SPRH5_ADR,#0101,064,144,ZOOM1,RUBI_1				; piece 231
	dw	LEEVER1_ROM,ROM28,SPRH5_ADR,#0101,064,160,ZOOM1,RUBI_1					; piece 232
	dw	LEEVER1_ROM,ROM28,SPRH5_ADR,#0101,064,128,ZOOM1,0					; piece 233
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	FISH_VERT_ROM,ROM28,SPRH5_ADR,#0101,032,096,ZOOM2,0							; piece 235
	dw	FISH_ROUGE_ROM,ROM28,SPRH5_ADR,NIVEAU1,064,112,ZOOM1,0					; piece 236
	dw	FISH_BLEU_ROM,ROM28,SPRH5_ADR,#0101,192,144,ZOOM1,RUBI_1				; piece 237
	dw	FISH_BLEU_ROM,ROM28,SPRH5_ADR,#0101,192,144,ZOOM2,RUBI_1				; piece 238
	dw	FISH_ROUGE_ROM,ROM28,SPRH5_ADR,#0101,032,144,ZOOM1,RUBI_1				; piece 239
	dw	FISH_ROUGE_ROM,ROM28,SPRH5_ADR,#0101,096,208,ZOOM2,0					; piece 240
	dw	FISH_VERT_ROM,ROM28,SPRH5_ADR,#0101,192,144,ZOOM2,0						; piece 241
	dw	FISH_ROUGE_ROM,ROM28,SPRH5_ADR,#0101,192,144,ZOOM1,RUBI_1
	dw	TEKTITE2_ROM,ROM28,SPRH5_ADR,#0101,128,144,ZOOM1,RUBI_1					; piece 243
	dw	FISH_ROUGE_ROM,ROM28,SPRH5_ADR,#0101,256,224,ZOOM1,CHAMPI_VERT_8
	dw	FISH_ROUGE_ROM,ROM28,SPRH5_ADR,#0101,192,192,ZOOM1,RUBI_1
	dw	FISH_ROUGE_ROM,ROM28,SPRH5_ADR,#0101,000,144,ZOOM1,RUBI_1
	dw	FISH_ROUGE_ROM,ROM28,SPRH5_ADR,#0101,096,096,ZOOM1,RUBI_1
	dw	FISH_ROUGE_ROM,ROM28,SPRH5_ADR,#0101,064,208,ZOOM1,RUBI_1
	dw	FISH_ROUGE_ROM,ROM28,SPRH5_ADR,#0101,032,128,ZOOM1,RUBI_1
	dw	TEKTITE2_ROM,ROM28,SPRH5_ADR,#0101,096,160,ZOOM1,0										; piece 250
	dw	TEKTITE2_ROM,ROM28,SPRH5_ADR,#0101,448,112,ZOOM1,0
	dw	TEKTITE2_ROM,ROM28,SPRH5_ADR,#0101,448,096,ZOOM1,RUBI_1
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	FISH_ROUGE_ROM,ROM28,SPRH5_ADR,#0101,256,224,ZOOM1,CHAMPI_POURRIT_10
	dw	FISH_ROUGE_ROM,ROM28,SPRH5_ADR,#0101,064,160,ZOOM1,#0001					
; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0										; piece 260
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	FISH_ROUGE_ROM,ROM28,SPRH5_ADR,#0103,160,112,ZOOM1,0						; piece 26
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0	
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0										; piece 270
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0	
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0
	dw	0,ROM26,SPRH5_ADR,#0101,0,0,ZOOM1,0										; piece 280
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
