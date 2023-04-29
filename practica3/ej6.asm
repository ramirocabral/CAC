PIO EQU 30H
PIC EQU 20H
N_F10 EQU 10


ORG 40
    IP_F10 DW RUT_F10

ORG 1000H

CAR DB ?

ORG 3000H

RUT_F10:PUSH AX
        MOV DH, 1       ;avisamos que se interrumpio
        MOV AL, 20H
        OUT PIC, AL
        POP AX
        IRET

INI_PIO:MOV AL, 1
        OUT PIO+2, AL
        MOV AL, 0
        OUT PIO+3, AL
        IN AL, PIO
        AND AL, 0FDH ;nos aseguramos que strobe este en 0
        OUT PIO, AL
        RET

INI_PIC:MOV AL,0FEH
        OUT PIC+1, AL
        MOV AL, N_F10
        OUT PIC+4, AL
        RET

STR_EN0:IN AL, PIO
        OR AL, 2
        OUT PIO, AL
        RET

STR_EN1:IN AL, PIO
        AND AL, 0FDH
        OUT PIO, AL
        RET

ORG 2000H

    CALL INI_PIO
    CALL INI_PIC
    MOV BX, OFFSET CAR
    MOV CL, 0       ;cantidad de caracteres a imprimir
    MOV DH, 0       ;indica si se interrumpio
LZO:CMP DH, 0
    JNZ IMP
    INT 6
    INC BX
    INC CL
    JMP LZO
IMP:MOV BX, OFFSET CAR
PLL:IN AL, PIO
    AND AL, 1
    JNZ PLL
    MOV AL, [BX]
    OUT PIO+1, AL
    CALL STR_EN0
    CALL STR_EN1
    INC BX
    DEC CL
    JNZ PLL
END