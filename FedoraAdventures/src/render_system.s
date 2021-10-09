.include "cpct_functions.h.s"
.include "entity_manager.h.s"

;;.globl cpct_getScreenPtr_asm
;;.globl cpct_drawSolidBox_asm
;;.globl entity_size

rendersys_init::
    ret


;;parametros de entrada:
;; ix -> puntero a la primera entidad
;; a-> numero de entitdades para renderizar
rendersys_update::

    _renderloop:
    ;;Al usar push guardamos el valor de af en la pila
    ;;para que no se pierda el valor
    ;;ya que será el contador de las entidades que tendremos
    ;;que renderizar
    push af

    ld de, #0XC000
    ;;el registro ix permite desplazarse tantos bytes como el numero que se le indica
    ;;a partir de el valor que se le da
    ;;ix será la direccion de memoria donde empiece los datos de la entidad
    ;;como en c queremos la coordenada x, y hemos declarado 
    ;;que nuestras entidades tiene la coordenada x la primera ponemos 0
    ld c, 0(ix)
    ld b, 1(ix)
    call cpct_getScreenPtr_asm

    ex de, hl
    ld a, 6(ix)
    ld b, 3(ix) 
    ld c, 2(ix)

    call cpct_drawSolidBox_asm
    pop af
    dec a
    ret z

    ld bc, #entity_size
    add ix, bc
    jr _renderloop