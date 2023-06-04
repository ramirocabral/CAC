.data
    str:        .asciiz     "****"
    clave:      .asciiz     "copa"

    msj:        .asciiz     "Buenos dias ingrese su clave por favor: "
    msj1:       .asciiz     "Bienvenide"
    msj2:       .asciiz     "ERROR...ELIMINANDO SISTEMA DE ARCHIVOS"

    CONTROL:    .word32     0x10000
    DATA:       .word32     0x10008

.code
        lwu     $s6, CONTROL($0)
        lwu     $s7, DATA($0)


lazo:   jal     clavee
        daddi    $a0, $0, str           ;?
        daddi    $a1, $0, clave
        jal     comp
        dadd    $a0, $0,  $v0
        jal     resp
        bnez    $v0, lazo

        halt



clavee: daddi   $t0, $0, msj
        sd      $t0, 0($s7)
        daddi   $t0, $0, 4
        sd      $t0, 0($s6)
        daddi   $t0, $0, 9          ;señal de leer caracter
        daddi   $t8, $0, 0          ;desplazamiento
        daddi   $t9, $0, 4          ;cantidad de caracteres

loop:   sd      $t0, 0($s6)
        lbu     $t1, 0($s7)
        sb      $t1, str($t8)
        daddi   $t8, $t8, 1
        daddi   $t9, $t9, -1
        bnez    $t9, loop
        ;string cargado
        jr      $ra


;reciclada
;a0:dir de str1
;a1:dir de str2
comp:   daddi   $v0, r0, 0
        daddi   $t3, r0, 1
lzo:    lbu      $t1, 0($a0)
        lbu      $t2, 0($a1)
        bne     $t1, $t2, dif
        beqz    $t1, fin
        daddi   $t3, $t3, 1
        daddi   $a0, $a0, 1     
        daddi   $a1, $a1, 1     
        j       lzo
dif:    dadd    $v0, r0, $t3 
fin:    jr      $ra


resp:   bnez    $a0, error
        daddi   $t0, $0, msj1
        j       imp
error:  daddi   $t0, $0, msj2
imp:    sd      $t0, 0($s7)
        daddi   $t0, $0, 4
        sd      $t0, 0($s6)
        jr      $ra