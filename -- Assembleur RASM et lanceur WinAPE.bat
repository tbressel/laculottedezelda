c:
cd C:\Users\Zisquier\Documents\Projets\Amstrad\2020_la-culotte-de-zelda-6128Plus\v3.2\
rasm contenu_creation_cartouche/maptiles/map.asm -ob contenu_creation_cartouche/maptiles/maptile1.prg
rasm contenu_creation_cartouche/maptiles/map2.asm -ob contenu_creation_cartouche/maptiles/maptile2.prg
rasm contenu_creation_cartouche/maptiles/map3.asm -ob contenu_creation_cartouche/maptiles/maptile3.prg
rasm table_init_monstre_1.asm -ob contenu_creation_cartouche/tables/table_init_monstre_1.prg
rasm table_init_monstre_2.asm -ob contenu_creation_cartouche/tables/table_init_monstre_2.prg
rasm table_init_monstre_3.asm -ob contenu_creation_cartouche/tables/table_init_monstre_3.prg
rasm table_init_monstre_4.asm -ob contenu_creation_cartouche/tables/table_init_monstre_4.prg
rasm table_init_monstre_5.asm -ob contenu_creation_cartouche/tables/table_init_monstre_5.prg
rasm table_init_monstre_6.asm -ob contenu_creation_cartouche/tables/table_init_monstre_6.prg
rasm table_init_monstre_7.asm -ob contenu_creation_cartouche/tables/table_init_monstre_7.prg
rasm table_init_grottes.asm -ob contenu_creation_cartouche/tables/table_init_grottes.prg
rasm creation_cartouche.asm  -sw -sq

C:\Users\Zisquier\Documents\Projets\Amstrad\WinAPE20B2\WinApe.exe /sym:rasmoutput.sym rasmoutput.cpr
cmd