affiche_vies

call	code_bank2_on
call	rom_on
call 	affiche_vies_ROM
ld		a,(flag_boutique)
or		a
RET		NZ
call	rom_off
call 	code_bankx_off
ret

