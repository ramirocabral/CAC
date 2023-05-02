PIO EQU 30H

ORG 1000H

    CADENA DB "asdASDxFGhj1"
    FINAL DB ?

ORG 3000H

    INI_PIO:PUSH AX
            MOV AL, 1
            OUT PIO+2, AL
            MOV AL, 0
            OUT PIO+3, AL
            IN AL, PIO
            AND AL, 0FDH
            OUT PIO, AL
            POP AX
            RET

        PLS:PUSH AX
            IN AL, PIO
            OR AL, 2
            OUT PIO, AL
            IN AL, PIO
            AND AL, 0FDH
            OUT PIO, AL
            POP AX
            RET

SELECCIONAR:MOV DL, 0
            CMP BYTE PTR [BX], 41H
            JS FIN
            CMP BYTE PTR [BX], 5BH
            JNS FIN
            MOV DL, 1
        FIN:RET

ORG 2000H

    CALL INI_PIO
    MOV BX, OFFSET CADENA
    MOV CL, OFFSET FINAL - OFFSET CADENA
LZO:CALL SELECCIONAR
    CMP DL, 0
    JZ SEG
PLL:IN AL, PIO
    AND AL, 1
    JNZ PLL
    MOV AL, [BX]
    OUT PIO+1, AL
    CALL PLS
SEG:INC BX
    DEC CL
    JNZ LZO

    INT 0 
    END