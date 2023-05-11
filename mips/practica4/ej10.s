.data
        cadena:     .asciiz     "daddy"
        car:        .asciiz     "d"
        cant:       .word       0
.code

        lbu     r3, car(r0)
        daddi   r2, r0, 0
        daddi   r5, r0, 0
loop:   lbu     r1, cadena(r2)
        beqz    r1, fin
        bne     r1, r3, seguir
        daddi   r5, r5, 1
seguir: daddi   r2, r2, 1
        j       loop
fin:    sd      r5, cant(r0)
        halt