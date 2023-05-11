.data
    tabla:   .word 1,2,3,4,5,6,7,8,9
    elem:    .word 9 
    X:       .word 4
    CANT:    .word 69
    res:     .word 420
.code
        daddi   r5, r0, 0
        daddi   r2, r0, 0           ;posicion en la tabla
        ld      r3, elem(r0)        ;cantidad de elementos
        ld      r9, X(r0)           ;numero a comparar
loop:   ld      r1, tabla(r2)       ;direccion de la tabla
        dadd    r5, r5, r1          ;1 si X es menor que r1
        sd      r1, res(r2)
        daddi   r2, r2, 8           ;siguiente direccion
        daddi   r3, r3, -1          
        bnez    r3, loop            ;si la cantidad no es 0
        sd      r5, CANT(r0)
        halt