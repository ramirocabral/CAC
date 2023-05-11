.data
        x:  .word   2
        y:  .word   3
        a:  .word   10
.code

        ld      r1, x(r0)
        ld      r2, y(r0)
        ld      r3, a(r0)

loop:   beqz    r3, fin
        daddi   r3, r3, -1
        dadd    r1, r1, r2
        j       loop
fin:    sd      r1, x(r0)
        sd      r3, a(r0)
        halt