PIC EQU 20H
HAND EQU 40H
N_HND EQU 12

ORG 48
    IP_HND DW RUT_HND

ORG 1000H

    MSJ DB ?

ORG 3000H

RUT_HND:CMP CL, 5       ;ineficiente?
        JZ INV
        JS INV
        MOV AL,[BX]
        OUT HAND, AL
        INC BX
        DEC CL
        JMP FIN
INV:    DEC BX          ;numero invertido
        MOV AL, [BX]
        OUT HAND, AL
        DEC CL
        CMP CL, 0       ;si es el ultimo caracter enmascaramos
        JNZ FIN
        MOV AL, 0FFH
        OUT PIC+1, AL
FIN:    MOV AL, 20H
        OUT PIC, AL
        IRET


INI_PIC:PUSH AX         ;iniciamos el PIC
        MOV AL, 0FBH
        OUT PIC+1,AL
        MOV AL, N_HND
        OUT PIC+6, AL
        POP AX
        RET

INI_HND:PUSH AX         ;iniciamos el HANDSHAKE
        IN AL, HAND+1
        OR AL, 128
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
    CLI
    CALL INI_PIC
    CALL INI_HND
    MOV CL, 5
    MOV BX, OFFSET MSJ
    CALL CARGAR
    MOV CL, 10
    MOV BX, OFFSET MSJ
    STI
LZO:CMP CL, 0
    JNZ LZO
    INT 0
    END
