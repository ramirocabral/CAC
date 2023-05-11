.data
    cant: .word 8
    datos: .word 1, 2, 3, 4, 5, 6, 7, 8
    res: .word 0
.code
        daddi r1, r0, 0     ;r1:0
        ld r2, cant(r0)     ;r2:cantidad de numeros del arreglo
loop:   ld r3, datos(r1)    ;r3:posicion en el vector
        daddi r2, r2, -1    ;decrementamos la cantidad
        dsll r3, r3, 1      ;left shift r3
        sd r3, res(r1)      ;guardamos resultado en res
        bnez r2, loop       ;si la cantidad no llego a 0 loopeamos
        daddi r1, r1, 8     ;pasamos a la siguiente posicion
        halt