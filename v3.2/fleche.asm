
fleche
	ld		a,(une_fleche_est_en_cours)
	or		a
	JR		NZ,update_fleche
affiche_fleche
	
	ld		a,29
	ld		(bankROM),a
	Call 	rom_on
	LD		hl,(FLECHE_SPR)
	ld		de,SPRH3_ADR
	LD		bc,#100
	LDIR
	call 	rom_off
	LD		a,9
	LD 		(SPRH3_ZOOM),a
	ld		a,1
	ld		(une_fleche_est_en_cours),a
	ld		(flag_sprh3),a
	jp		retour_fleche
update_fleche
	LD		a,8
	LD		(bankROM),a
	call	rom_on_bank_prog
	call	update_fleche_ROM			; que la fleche soit en cours d'update ou qu'elle est juste éteinte, on arrive là
	call	rom_off						; on coupe la rom 8
	JP 		retour_fleche				; on retourne là d'ou l'on vient.
	
fin_fleche
	xor		a							; si on arrive là c'est que la fleche à touché le bord de l'écran
	LD		(event_fleche),a			; donc plus besoin de la faire avancer, alors on peut
	LD		(event_fleche+1),a			; effacer l'evenement de la boucle, pour ne plus revenir ici
	LD		(event_fleche+2),a			; la prochaine fois.
	LD		(SPRH3_ZOOM),a				; hop on éteinds le sprite
	ld		(flag_fire2),a				; on rétablie le flag du bouton Fire 2, à nouveau utilisable
	ld		(une_fleche_est_en_cours),a	; la fleche ne circule plus
	ld		(flag_sprh3),a				; on indique qu'il est étainds 
	RET									; on revient là où l'on était 
