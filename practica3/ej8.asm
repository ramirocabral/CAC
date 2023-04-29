PIC EQU 20H
HAND EQU 40H
N_HND EQU 12

ORG 48
    IP_HND DW RUT_HND

ORG 1000H

    MSJ DB "presi duka"
    FIN DB ?

ORG 3000H

RUT_HND:PUSH AX
        MOV AL, [BX]
        OUT HAND, AL        ;mandamos al puerto de datos el caracter
        INC BX              ;pasamos al siguiente caracter
        DEC CL              ;decrementamos el contador
        JNZ FIN
        MOV AL, 0FFH
        OUT PIC+1, AL       ;enmascaramos interrupciones para el ultimo caracter
FIN:    MOV AL, 20H
        OUT PIC, AL
        POP AX
        IRET


INI_PIC:PUSH AX             
        MOV AL, 0FBH        ;enmascara interrupciones
        OUT PIC+1, AL
        MOV AL, N_HND       ;direccion a int2
        OUT PIC+6, AL
        POP AX
        RET


INI_HND:PUSH AX
        IN AL, HAND+1       ;pone en 1 el bit 7 del registro de estado
        OR AL, 128
        OUT HAND+1, AL
        POP AX
        RET

ORG 2000H
    CLI                     ;deshabilita interrupciones
    MOV BX, OFFSET MSJ
    MOV CL, OFFSET FIN - OFFSET MSJ
    CALL INI_PIC
    CALL INI_HND
    STI
LZO:CMP CL, 0               ;sin enmascarar no anda!!!!!
    JNZ LZO
    IN AL, HAND+1
    AND AL, 127
    OUT HAND+1, AL
    INT 0
    END