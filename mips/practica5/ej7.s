.data
        M:      .word       5
        tabla:  .word       1,2,3,4,5,6,7,8,9
        cant:   .word       9

.code
        ld      $a0, M(r0)
        daddi   $a1, r0, tabla
        ld      $a2, cant(r0)
        jal     asd
        halt

;a0=.M
;a1:tabla
;a2:cantidad de elementos
asd:    daddi   $v0, r0, 0
loop:   ld      $s1, 0($a1)      ;cargamos el valor de la tabla
        slt     $t0, $a0, $s1        ;comparamos
        dadd    $v0, $v0, $t0
        daddi   $a1, $a1, 8          ;avanzamos de posicion
        daddi   $a2, $a2, -1
        bnez    $a2, loop
fin:    jr      $ra