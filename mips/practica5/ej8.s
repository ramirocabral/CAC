.data
        str1:   .asciiz    "anashe12"
        str2:   .asciiz    "anashe12"

.code
        daddi   $a0, r0, str1
        daddi   $a1, r0, str2
        jal     comp
        halt


;a0:dir de str1
;a1:dir de str2

comp:   daddi   $v0, r0, -1
        daddi   $t3, r0, 1
loop:   lbu      $t1, 0($a0)
        lbu      $t2, 0($a1)
        bne     $t1, $t2, dif
        beqz    $t1, fin
        daddi   $t3, $t3, 1
        daddi   $a0, $a0, 1     
        daddi   $a1, $a1, 1     
        j       loop
dif:    dadd    $v0, r0, $t3 
fin:    jr      $ra

