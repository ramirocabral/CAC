.data
    msj:    .asciiz     "Ingrese un numero: "
    msj2:   .asciiz     "FATAL ERROR:El caracter no es un digito"

    CONTROL:    .word32     0x10000
    DATA:       .word32     0x10008

.code
        lwu     $s6, CONTROL($0)        ;cargamos la direccion de CONTROL
        lwu     $s7, DATA($0)           ;cargamos la direccion de DATA
        jal     ingreso
        dadd    $s0, $0, $v0
        jal     ingreso
        dadd    $s1, $0, $v0
        beqz    $s0, end
        beqz    $s1, end
        dadd    $a0, $0, $s0
        dadd    $a1, $0, $s1
        jal     res
end:    halt

ingreso: daddi  $t0, $0, msj
        sd      $t0, 0($s7)         ;escribir en DATA
        daddi   $t0, $0, 4          ;señal de escribir
        sd      $t0, 0($s6)         ;mandar 4 a CONTROL
        daddi   $t0, $0, 9          ;señal de leer
        sd      $t0, 0($s6)     
        lbu     $v0, 0($s7)         ;leer dato de DATA
        slti    $t1, $v0, 48        ;comparar si es menor a 48
        bne     $t1, $0, error      ;si es menor a 48, error
        slti    $t1, $v0, 58        ;comparar si es mayor a 58
        beqz    $t1, error          ;si es mayor a 58, error
        j fin
error:  daddi   $t0, $0, msj2       ;direccion de msj2
        sd      $t0, 0($s7)         ;escribir en DATA
        daddi   $t0, $0, 4          ;señal de escribir
        sd      $t0, 0($s6)         ;mandar 4 a CONTROL
        daddi   $v0, $0, 0          ;retornamos 0 si el char no es valido
fin:    jr      $ra


res:    daddi   $a0, $a0, -48
        daddi   $a1, $a1, -48
        dadd    $t0, $a0, $a1
        sd      $t0, 0($s7)
        daddi   $t0, $0, 2
        sd      $t0, 0($s6)
        jr      $ra