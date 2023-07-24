AFFICHE_HUD_ROM

LD		HL,TABLE_HUD_M1
	LD		DE,#C000					;point de depart d'affichage sur l'ecran
	LD    	A,5							;11 lignes de tiles	
AFFICHE_ECRANH
	PUSH	AF 
	LD		A,16                     ;on sauvegarde au cas ou, on sait jamais pour les routines futures.
	LD		B,A	                  				;nombre de tiles 16
LIGNE_TILEH
	PUSH	BC                      ;on le sauvegarde pour le cas ou les sous-routines s'en serviraient.
	PUSH	HL
	PUSH	DE  
									;on sauvegarde nos registres car ils vont etre modifies
	CALL 	CALCUL_TILEH      		;ici on calcul l'adresse du TILE dans la RAM 
									;HL contient l'adresse du tile a afficher
	CALL 	AFFICHE_TILEH            ;on affiche le premier TILE
	POP  	DE
	POP 	HL                  	;on recupere nos registres
	INC 	HL                      ;si notre table fait moins de 256 octet un INC L suffira
	INC   	DE
	INC 	DE
	INC   	DE
	INC 	DE                  	;4 octets de large pour notre TILE donc 4xINC
	POP   	BC
	DJNZ  	LIGNE_TILEH
	EX    	HL,DE                   ;on echange le contenu de HL et DE
	LD    	BC,64
	ADD  	HL,BC                   ;on ajoute 80
	EX    	HL,DE                   ;on remet les valeurs dans les bons registres
	POP  	AF                      ;on recupere le nombre de lignes
	DEC  	A                       ;on decremente
	OR    	A                       ;equivalent d'un CP 0 mais en plus rapide 
					;Un OR A pour modifier Z quand A=0)
	JP     	NZ,AFFICHE_ECRANH        ;si c'est pas =0 alors on boucle.
	
	RET
CALCUL_TILEH
	LD 		A,(HL) 
	
						;l'adresse de HL qui contient 1 octet est mis dans A (le numero ASCII de "H" donc #48 en hexa ou 72 en dec)
	LD 		L,A		 		; donc met le resultat dans L
	LD 		H,0           		;on met 0 dans H (car H ne doit pas etre vide)
	ADD 	HL,HL        		; 40 + 40 = 80  ca fait x2
	ADD 	HL,HL        		; 80 + 80 = 160  ca fait x4
	ADD 	HL,HL        		; 160 + 160 = 320  ca fait x8
	ADD 	HL,HL        		; 320 + 320 = 640  ca fait x16
	ADD 	HL,HL        		; 640 + 640 = 1280  ca fait x32
	ADD 	HL,HL        		; 1280 + 1280 = 2560 ca fait x64
	LD 		BC,MEM_TAMPON_HUD     		;on met #2BF0 dans BC qui correspond a l'adresse de nos tiles ->dans la RAM<-
	ADD 	HL,BC        		;on additionne pour avoir l'adresse de la tile ->dans la RAM<-
	
	RET
AFFICHE_TILEH
	LD		A,16                     ;on sauvegarde au cas ou, on sait jamais pour les routines futures.
	LD		B,A		 	; les tiles font 16 lignes sur une longueur BC
BOUCLE_TILEH
	PUSH 	BC		 	; ... pour mettre ca dans la pile (registre 16 bits obligatoir)
	LD 		BC,#04	 		; largeur d'une lettre de 4 octets (mode 1, 8 pxl font 4 octets)
	PUSH 	DE		 	; on sauve DE avant que le LDIR le modifie ...
	LDIR		 		; il incremente HL et DE (HL = #4A01   DE = C001 BC = 00)
	POP 	DE		 	; on recupere notre DE de la pile
	CALL 	LIGNEINF_c000
	POP 	BC		 	; nouvelle ligne calcule, on recupere notre compteur ...
	DJNZ 	BOUCLE_TILEH
	RET
	







