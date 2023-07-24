AFFICHE_PIECE_ROM	
	call	C4_on
	LD		HL,(PIECE_ACTUELLE)
	LD		DE,OFFSET						;point de depart d'affichage sur l'ecran
	LD    	A,nbr_de_ligne_de_tiles			;11 lignes de tiles
	
	
	
	
AFFICHE_ECRAN
	PUSH	AF 
	LD		A,nbr_de_tiles                     ;on sauvegarde au cas ou, on sait jamais pour les routines futures.
	LD		B,A	                  				;nombre de tiles 16
LIGNE_TILE
	PUSH	BC                      ;on le sauvegarde pour le cas ou les sous-routines s'en serviraient.
	PUSH	HL
	PUSH	DE  
									;on sauvegarde nos registres car ils vont etre modifies
	CALL 	CALCUL_TILE       		;ici on calcul l'adresse du TILE dans la RAM 
									;HL contient l'adresse du tile a afficher
	call	c4_on
	CALL 	AFFICHE_TILE            ;on affiche le premier TILE
	POP  	DE
	POP 	HL                  	;on recupere nos registres
	INC 	HL                      ;si notre table fait moins de 256 octet un INC L suffira
	INC   	DE
	INC 	DE
	INC   	DE
	INC 	DE                  	;4 octets de large pour notre TILE donc 4xINC
	POP   	BC
	DJNZ  	LIGNE_TILE
	EX    	HL,DE                   ;on echange le contenu de HL et DE
	LD    	BC,64
	ADD  	HL,BC                   ;on ajoute 80
	EX    	HL,DE                   ;on remet les valeurs dans les bons registres
	POP  	AF                      ;on recupere le nombre de lignes
	DEC  	A                       ;on decremente
	OR    	A                       ;equivalent d'un CP 0 mais en plus rapide 
					;Un OR A pour modifier Z quand A=0)
	JP     	NZ,AFFICHE_ECRAN        ;si c'est pas =0 alors on boucle.
	call	c4_off
	call	c0_on
	RET
CALCUL_TILE
								; malgrés le fait que les banks soient sécurisées dans gestion_interruption.asm
	LD		A,(No_BANK)				; si cette dernière survient sur cette partie du programme, certaines tiles 
	cp		a,#c5					; provenant d'autre bank pourraient occasionnellement apparaitre dans la map
	call	z,C5_on
	cp		a,#c6					; depuis plus de soucis de tile.
	call	z,C6_on
	cp 		a,#c7
	call	z,C7_on
	
	LD 	A,(HL) 
								;l'adresse de HL qui contient 1 octet est mis dans A (le numero ASCII de "H" donc #48 en hexa ou 72 en dec)
	LD 	L,A		 				; donc met le resultat dans L
	LD 	H,0           			;on met 0 dans H (car H ne doit pas etre vide)
	ADD 	HL,HL        		; 40 + 40 = 80  ca fait x2
	ADD 	HL,HL        		; 80 + 80 = 160  ca fait x4
	ADD 	HL,HL        		; 160 + 160 = 320  ca fait x8
	ADD 	HL,HL        		; 320 + 320 = 640  ca fait x16
	ADD 	HL,HL        		; 640 + 640 = 1280  ca fait x32
	ADD 	HL,HL        		; 1280 + 1280 = 2560 ca fait x64
	LD 		BC,TILE_ADR    		;on met #4000 dans BC qui correspond a l'adresse de nos tiles ->dans la RAM<-
	ADD 	HL,BC        		;on additionne pour avoir l'adresse de la tile ->dans la RAM<-
	call	c0_on
	RET
AFFICHE_TILE
	call	c4_on
	LD		A,nbr_de_tiles                     ;on sauvegarde au cas ou, on sait jamais pour les routines futures.
	LD		B,A		 	; les tiles font 16 lignes sur une longueur BC
BOUCLE_TILE
	PUSH 	BC		 	; ... pour mettre ca dans la pile (registre 16 bits obligatoir)
	LD 		BC,#04	 		; largeur d'une lettre de 4 octets (mode 1, 8 pxl font 4 octets)
	PUSH 	DE		 	; on sauve DE avant que le LDIR le modifie ...
	LDIR		 		; il incremente HL et DE (HL = #4A01   DE = C001 BC = 00)
	POP 	DE		 	; on recupere notre DE de la pile
	CALL 	LIGNEINF_c000
	POP 	BC		 	; nouvelle ligne calcule, on recupere notre compteur ...
	DJNZ 	BOUCLE_TILE
	RET
