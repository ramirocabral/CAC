ORG 1000H

    MSJ1 DB "PRESIONE LA TECLA"
    PEDIR DB "0"
    FIN1 DB ?
    MSJ2 DB "CORRECTO"
    FIN2 DB ?
    MSJ3 DB "ERROR VUELVA A INTENTARLO"
    FIN3 DB ?
    RESUL DB ?                      ;resultado correcto o incorrecto 00H / FFH
    TECLA DB ?                      ;codigo del caracter de la tecla persionada

ORG 2500H
VER:    MOV RESUL, 00H
        MOV CL, PEDIR
        CMP TECLA, CL
        JNZ FIN
        MOV RESUL, 0FFH
FIN:    RET

ORG 3000H

MST:    CMP AL, 00H
        JZ RESUL2
        MOV BX, OFFSET MSJ2
        MOV AL, OFFSET FIN2 - OFFSET MSJ2
        INT 7
        JMP VOLVER
RESUL2: MOV BX, OFFSET MSJ3
        MOV AL, OFFSET FIN3 - OFFSET MSJ3
        INT 7
VOLVER: RET


ORG 2000H

        MOV BX, OFFSET MSJ1
        MOV AL, OFFSET FIN1 - OFFSET MSJ1
        INT 7
        MOV BX, OFFSET TECLA
        INT 6
        CALL VER
        MOV AL, RESUL
        CALL MST
        INT 0
        END