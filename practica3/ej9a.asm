HAND EQU 40H
N_HND EQU 12

ORG 1000H

    MSJ DB ?

ORG 3000H

INI_HND:PUSH AX         ;inicializamos el handshake
        IN AL, HAND+1
        AND AL, 127
        OUT HAND+1, AL
        POP AX
        RET

CARGAR: PUSH CX         ;leemos los 5 caracteres
LOOP:   INT 6
        INC BX
        DEC CL
        JNZ LOOP
        POP CX
        RET

ORG 2000H

    MOV BX, OFFSET MSJ
    MOV CL, 5
    CALL CARGAR
    DEC BX
PLL:IN AL, HAND+1
    AND AL, 1
    JNZ PLL
    MOV AL, [BX]
    OUT HAND, AL
    DEC BX
    DEC CL
    JNZ PLL

    MOV BX, OFFSET MSJ
    MOV CL, 5
PL2:IN AL, HAND+1
    AND AL, 1
    JNZ PL2
    MOV AL, [BX]
    OUT HAND, AL
    INC BX
    DEC CL
    JNZ PL2
    INT 0
    END