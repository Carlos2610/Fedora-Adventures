ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;
                              3 ;;
                              4 
                     000A     5 max_entities == 10
                     0007     6 entity_size == 7
                              7 
   4000 07                    8 _num_entities:: .db 7
   4001                       9 _entity_array:: .ds max_entities * entity_size
   4047 01 40                10 _last_elem_ptr:: .dw _entity_array
                             11 
   4049                      12 getEntityInArray::
   4049 DD 21 01 40   [14]   13     ld ix, #_entity_array
   404D C9            [10]   14     ret
                             15 
   404E                      16 getNumEntities::
   404E 3A 00 40      [13]   17     ld a, (_num_entities)
   4051 C9            [10]   18     ret
                             19 
   4052                      20 create_entity::
   4052 ED 5B 47 40   [20]   21     ld de, (_last_elem_ptr)
   4056 01 07 00      [10]   22     ld bc, #entity_size
   4059 ED B0         [21]   23     ldir
                             24 
   405B 3A 00 40      [13]   25     ld a, (_num_entities)
   405E 3C            [ 4]   26     inc a 
   405F 32 00 40      [13]   27     ld (_num_entities), a 
                             28     
   4062 2A 47 40      [16]   29     ld hl, (_last_elem_ptr)
   4065 01 07 00      [10]   30     ld bc, #entity_size
   4068 09            [11]   31     add hl, bc
   4069 22 47 40      [16]   32     ld (_last_elem_ptr), hl
                             33 
   406C C9            [10]   34     ret
                             35     
