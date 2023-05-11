PIO EQU 30H
PIC EQU 20H
N_F10 EQU 10

ORG 40
    IP_F10 DW RUT_F10

ORG 3000H

INI_PIC:PUSH AX
        MOV AL, 0FEH
        OUT PIC+1, AL
        MOV AL, N_F10
        OUT PIC+4, AL
        POP AX
        RET

INI_PIO:PUSH AX
        MOV AL, 0
        OUT PIO+3, AL
        OUT PIO+1, AL
        POP AX
        RET

;RECIBE POR CL EL PARAMETRO
ROTARIZ:ADD DL, DL
        JNC SEG
        INC DL
SEG:    DEC CL
        JNZ ROTARIZ
        RET

ROTARDE:MOV CL, 7
        CALL ROTARIZ
        RET

RUT_F10:CALL ROTARDE
        MOV AL, DL
        OUT PIO+1, AL
        MOV AL, 20H
        OUT PIC, AL
        IRET

ORG 2000H
    CLI
    CALL INI_PIO
    CALL INI_PIC
    MOV DL, 1
    STI
LZO:JMP LZO
    INT 0 
    END
