.data
    peso:   .double     69
    altura: .double     1.420
    imc:    .double     123     ;peso/altura^2
    estado: .word       0
    infra:  .double     18.5
    normal: .double     25
    gordo:  .double     30
.code
        l.d     f1, peso(r0)
        l.d     f2, altura(r0)
        l.d     f5, infra(r0)
        mul.d   f2, f2, f2
        div.d   f3, f1, f2
        s.d     f3, imc(r0)
        c.le.d  f3, f5
        bc1f    seguir 
        daddi   r1, r0, 1
        j       fin
seguir: l.d     f5, normal(r0)
        c.le.d  f3, f5
        bc1f    seguir2
        daddi   r1, r0, 2
        j fin
seguir2: l.d     f5, gordo(r0)
        c.le.d  f3, f5
        bc1f    seguir3
        daddi   r1, r0, 3
        j fin
seguir3: daddi   r1, r0, 4
fin:    sd      r1, estado(r0)
        halt