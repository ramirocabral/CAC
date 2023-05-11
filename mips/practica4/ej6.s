.data
    A: .word 80
    B: .word 80
    C: .word 80
    D: .word 0
.code
        daddi   r8, r0, 0               ;resultado r8
        daddi   r7, r0, 0
        lw      r1, A(r0)
        lw      r2, B(r0)
        lw      r3, C(r0)
        bne     r1, r2, next
        nop
        daddi   r7, r0, 2               ;muevo 2 a r7
        dadd    r8, r8, r7              ;sumo r7 a r8
        daddi   r7, r7, -1              ;resto a r7
next:   bne     r1, r3, next2
        nop
        dadd    r8, r8, r7
        daddi   r7, r7, -1
next2:  bne     r2, r3, fin
        nop
        dadd    r8, r8, r7
        daddi   r7, r7, -1
fin:    sw      r8, D(r0)
        nop
        halt