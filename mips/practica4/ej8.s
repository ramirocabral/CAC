.data
    a:  .word   5
    b:  .word   5
    c:  .word   0
.code
        daddi   r3, r0, 0 
        ld      r1, a(r0)
        ld      r2, b(r0)
loop:   daddi   r2, r2, -1
        bnez    r2, loop
        dadd    r3, r3, r1
        sd      r3, c(r0)
        halt