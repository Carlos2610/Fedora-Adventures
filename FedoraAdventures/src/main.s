.include "cpctelera.h.s"
.include "render_system.h.s"
.include "entity_manager.h.s"
.include "cpct_functions.h.s"


.area _DATA
.area _CODE

;;Las entidades tienen 7 atributos, cordenada x,y, ancho y alto,
;;velocidad x e y, y color
;;aqui estan puestas las caracteristicas del player

;;.globl cpct_disableFirmware_asm
;;.globl rendersys_init
;;.globl create_entity
;;.globl getEntityInArray
;;.globl getNumEntities
;;.globl rendersys_update

player: .db 20, 20, 2, 8, 1, 1, 0xFF

;;
;; MAIN function. This is the entry point of the application.
;;    _main:: global symbol is required for correctly compiling and linking
;;
_main::
   
   call cpct_disableFirmware_asm

   call rendersys_init

   ld hl, #player
   call create_entity
   ;; Loop forever
loop:
      call getEntityInArray
      call getNumEntities
      call rendersys_update
   jr    loop