.data
    negro:      .word32     0x00000000
    blanco:     .word32     0x00FFFFFF

    CONTROL:    .word32     0x10000
    DATA:       .word32     0x10008

    cero:       .byte       0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,0,1,1,1,0,0
    uno:        .byte       0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,1,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0
    dos:        .byte       0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,1,0,0,1,0,0,0,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0
    tres:       .byte       0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,1,1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0
    cuatro:     .byte       0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,1,1,1,1,1,1,1,1,1,0,0,1,1,0,0,1,0,0,1,1,0,0,0,1,1,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0
    cinco:      .byte       0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1,1,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,1,1,1,1,1,0,0,1,1,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0
    seis:       .byte       0,0,0,0,0,0,0,0,1,1,1,1,0,0,1,1,0,0,1,1,0,1,1,0,0,1,1,0,1,1,1,1,1,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0
    siete:      .byte       0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,1,1,0,0,1,1,0,1,1,1,1,1,1,0,0,0,0,0,0,0
    ocho:       .byte       0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,0,1,1,1,0,0
    nueve:      .byte       0,0,1,1,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,1,1,1,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0

;       funciona __S

.code
        lwu     $s6, CONTROL($0)
        lwu     $s7, DATA($0)
        daddi   $t0, $0, 8
        sd      $t0, 0($s6)
        ld      $t0, 0($s7)     ;guardamos el valor leido
        daddi   $t9, $0, 64     ;desplazamiento
        dmul    $t0, $t0, $t9   ;multiplicamos por 64
        daddi   $t1, $0, cero
        dadd    $t2, $t1, $t0   ;sumamos el valor leido con la direccion de cero


        lwu     $t8, blanco($0)
        lwu     $t9, negro($0)

        daddi   $s0, $0, 0        
        daddi   $s1, $0, 9      ;contador filas
        
        daddi   $v0, $0, 5      ;señal de actualizar pixel

;t2 dir inicial
filas:  sb      $s0, 4($s7)     ;guardamos coordenada y
        daddi   $s3, $0, 7      ;contador de columnas
        daddi   $s4, $0, 0      ;valor de x

            col:    sb      $s4, 5($s7) ;guardamos coordenada x
                    lbu     $t3, 0($t2) ;guardamos 0 o 1
                    beqz    $t3, blc    ;si es blanco o negro
                    sw      $t9, 0($s7)
                    j seguir
            blc:    sw      $t8, 0($s7)
            seguir: sd      $v0, 0($s6)
                    daddi   $t2, $t2, 1 ;avanzamos de posicion
                    daddi   $s4, $s4, 1 ;incrementamos coordenada x
                    daddi   $s3, $s3, -1;decrementamos contador para no pasarnos
                    bnez    $s3, col

        daddi   $s0, $s0, 1         ;incrementamos valor de y
        daddi   $s1, $s1, -1        ;decrementamos contador de filas
        bnez    $s1, filas

        halt