.data
    msjBase:    .asciiz     "Base: "
    msjExp:     .asciiz     "Exponente: "

    CONTROL:    .word32     0x10000
    DATA:       .word32     0x10008

    uno:        .double       1.0

.code
        lwu     $s6, CONTROL($0)
        lwu     $s7, DATA($0)

        daddi   $t1, $0, 8
        daddi   $t2, $0, 4
        daddi   $t0, $0, msjBase
        sd      $t0, 0($s7)
        sd      $t2, 0($s6)
        sd      $t1, 0($s6)
        l.d     f0,  0($s7)
        daddi   $t0, $0, msjExp
        sd      $t0, 0($s7)
        sd      $t2, 0($s6)
        sd      $t1, 0($s6)
        ld      $a0, 0($s7)
        jal     ptcia
        s.d     f1,  0($s7)
        daddi   $t0, $0, 3
        sd      $t0, 0($s6) 

        halt


;$a0 = exponente
ptcia:  l.d     f1, uno($0)
        beqz    $a0, fin         ;si el exponente es 0 retorna 1
loop:   mul.d   f1, f1, f0
        daddi   $a0, $a0, -1
        bnez    $a0, loop
fin:    jr      $ra