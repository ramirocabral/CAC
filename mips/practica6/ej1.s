.data
    texto:      .asciiz     "....." ; El mensaje a mostrar
    CONTROL:    .word32     0x10000
    DATA:       .word32     0x10008
.text
        lwu     $s6, CONTROL(r0)    ;$s6 = dirección de CONTROL
        lwu     $s7, DATA(r0)       ;$s7 = dirección de DATA

        daddi   $t1, $0, 0          ;desplazamiento en texto
        daddi   $t2, $0, 5          ;dimension de texto
        daddi   $t0, $t0, 9         ;t0 = 9 para leer

loop:   sd      $t0, 0($s6)         ;mandar a CONTROL la señal de leer
        lbu     $t3, 0($s7)          ;guardar valor de registro DATA
        sb      $t3, texto($t1)     ;guardar caracter
        daddi   $t1, $t1, 1         ;incrementar desplazamiento
        daddi   $t2, $t2, -1        ;decrementar dimension
        bnez    $t2, loop

        daddi   $t0, $0, 6          ;$t0 = 6 -> función 6: limpiar pantalla alfanumérica
        sd      $t0, 0($s6)         ;CONTROL recibe 6 y limpia la pantalla
        
        daddi   $t0, $0, texto
        sd      $t0, 0($s7)

        daddi   $t0, $0, 4          ;$t0 = 4 -> función 4: salida de una cadena ASCII
        sd      $t0, 0($s6)         ;CONTROL recibe 4 y produce la salida del mensaje
        halt