ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .include "cpct_functions.h.s"
                              1 ;;funciones de cpctelera
                              2 
                              3 .globl cpct_disableFirmware_asm
                              4 .globl cpct_getScreenPtr_asm
                              5 .globl cpct_drawSolidBox_asm
                              6 
                              7 ;;constantes
                              8 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              2 .include "entity_manager.h.s"
                              1 ;;archivo de cabecera para hacer include de las funciones
                              2 ;;
                              3 ;;FUNCIONES PUBLICAS
                              4 .globl getEntityInArray
                              5 .globl getNumEntities
                              6 .globl create_entity
                              7 
                              8 ;;CONSTANTES
                              9 .globl entity_size
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              3 
                              4 ;;.globl cpct_getScreenPtr_asm
                              5 ;;.globl cpct_drawSolidBox_asm
                              6 ;;.globl entity_size
                              7 
   408B                       8 rendersys_init::
   408B C9            [10]    9     ret
                             10 
                             11 
                             12 ;;parametros de entrada:
                             13 ;; ix -> puntero a la primera entidad
                             14 ;; a-> numero de entitdades para renderizar
   408C                      15 rendersys_update::
                             16 
   408C                      17     _renderloop:
                             18     ;;Al usar push guardamos el valor de af en la pila
                             19     ;;para que no se pierda el valor
                             20     ;;ya que será el contador de las entidades que tendremos
                             21     ;;que renderizar
   408C F5            [11]   22     push af
                             23 
   408D 11 00 C0      [10]   24     ld de, #0XC000
                             25     ;;el registro ix permite desplazarse tantos bytes como el numero que se le indica
                             26     ;;a partir de el valor que se le da
                             27     ;;ix será la direccion de memoria donde empiece los datos de la entidad
                             28     ;;como en c queremos la coordenada x, y hemos declarado 
                             29     ;;que nuestras entidades tiene la coordenada x la primera ponemos 0
   4090 DD 4E 00      [19]   30     ld c, 0(ix)
   4093 DD 46 01      [19]   31     ld b, 1(ix)
   4096 CD 63 41      [17]   32     call cpct_getScreenPtr_asm
                             33 
   4099 EB            [ 4]   34     ex de, hl
   409A DD 7E 06      [19]   35     ld a, 6(ix)
   409D DD 46 03      [19]   36     ld b, 3(ix) 
   40A0 DD 4E 02      [19]   37     ld c, 2(ix)
                             38 
   40A3 CD C0 40      [17]   39     call cpct_drawSolidBox_asm
   40A6 F1            [10]   40     pop af
   40A7 3D            [ 4]   41     dec a
   40A8 C8            [11]   42     ret z
                             43 
   40A9 01 07 00      [10]   44     ld bc, #entity_size
   40AC DD 09         [15]   45     add ix, bc
   40AE 18 DC         [12]   46     jr _renderloop
