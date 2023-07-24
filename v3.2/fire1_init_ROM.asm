fire1_init_ROM
	call	fire1_off
	ld		a,#CD
	ld		(event_compteur_attaque),a
	ld		hl,compteur_attaque
	ld		(event_compteur_attaque+1),hl
	LD		a,1				
	LD		(flag_fire1),a							; on met le flag_fire1 à 1
	ld		(flag_premort),a
	LD		a,Cycle_epee			
	LD		(compteur_attaque_epee),a				; on initialise le compteur de boucle qui gardera l'épée visible.
	LD		a,#C3
	LD		(event_attaque),a
	LD		hl,attaque
	LD		(event_attaque+1),hl	
	ld		a,1									; permet de savoir quelle est la dernière arme utilisée pour déterminer
	ld		(flag_type_arme_utilise),a				; quel type de point de vie décompter aux labels pre-mort monstre	
	ld		a,(direction_en_cours)
	cp		a,1
	jp		z,init_attaque_a_gauche
	cp 		a,2
	jp		z,init_attaque_a_droite
	cp		a,3
	jp		z,init_attaque_en_haut
	cp		a,4
	jp		z,init_attaque_en_bas
	JP		retour_fire1
	
init_attaque_a_gauche
	ld		bc,(decalage_epee_gauche)
	ld		hl,(Table_type_link+16)						; adresse de départ de link attack dans la ROM 
	LD		(LINK_ADR),hl							; que l'on envoie dans l'adresse générale
	ld		hl,(Table_type_arme)							; adresse de l'épée 1 dans la ROM
	ld		(EPEE_SPR),hl							; envoyé dans une variable générale
	LD		hl,(SPRH0_X)
	ld		de,-31
	add		hl,de
	add		hl,bc
	ld		(SPRH2_X),hl
	ld		hl,(SPRH0_Y)
	ld		(SPRH2_Y),hl
	ld		hl,fin_attaque_a_gauche
	ld		(direction_retablit),hl
	JP		retour_fire1
init_attaque_a_droite
ld		bc,(decalage_epee_droite)
	ld		hl,(Table_type_link+18)						; adresse de départ de link attack dans la ROM 
	LD		(LINK_ADR),hl							; que l'on envoie dans l'adresse générale
	ld		hl,(Table_type_arme+2)						; adresse de l'épée 1 dans la ROM
	ld		(EPEE_SPR),hl							; envoyé dans une variable générale
	
	LD		hl,(SPRH0_X)
	ld		de,31
	add		hl,de
	add		hl,bc
	ld		(SPRH2_X),hl
	ld		hl,(SPRH0_Y)
	ld		(SPRH2_Y),hl
	
	ld		hl,fin_attaque_a_droite
	ld		(direction_retablit),hl
	JP		retour_fire1
init_attaque_en_haut
ld		bc,(decalage_epee_haut)
	ld		hl,(Table_type_link+22)						; adresse de départ de link attack dans la ROM 
	LD		(LINK_ADR),hl							; que l'on envoie dans l'adresse générale
	ld		hl,(Table_type_arme+6)						; adresse de l'épée 1 dans la ROM
	ld		(EPEE_SPR),hl							; envoyé dans une variable générale
	
	LD		hl,(SPRH0_Y)
	ld		de,-15
	add		hl,de
	add		hl,bc
	ld		(SPRH2_Y),hl
	ld		hl,(SPRH0_X)
	ld		(SPRH2_X),hl
	
	ld		hl,fin_attaque_en_haut
	ld		(direction_retablit),hl
	JP		retour_fire1
init_attaque_en_bas
ld		bc,(decalage_epee_bas)
	ld		hl,(Table_type_link+20)						; adresse de départ de link attack dans la ROM 
	LD		(LINK_ADR),hl							; que l'on envoie dans l'adresse générale
	ld		hl,(Table_type_arme+4)						; adresse de l'épée 1 dans la ROM
	ld		(EPEE_SPR),hl							; envoyé dans une variable générale
	
	LD		hl,(SPRH0_Y)
	ld		de,15
	add		hl,de
	add		hl,bc
	ld		(SPRH2_Y),hl
	ld		hl,(SPRH0_X)
	ld		(SPRH2_X),hl
	
	ld		hl,fin_attaque_en_bas
	ld		(direction_retablit),hl
	JP		retour_fire1
	
