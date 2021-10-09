;;
;;
;;

max_entities == 10
entity_size == 7

_num_entities:: .db 7
_entity_array:: .ds max_entities * entity_size
_last_elem_ptr:: .dw _entity_array

getEntityInArray::
    ld ix, #_entity_array
    ret

getNumEntities::
    ld a, (_num_entities)
    ret

create_entity::
    ld de, (_last_elem_ptr)
    ld bc, #entity_size
    ldir

    ld a, (_num_entities)
    inc a 
    ld (_num_entities), a 
    
    ld hl, (_last_elem_ptr)
    ld bc, #entity_size
    add hl, bc
    ld (_last_elem_ptr), hl

    ret
    