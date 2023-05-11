PIC EQU 20H
PIO EQU 30H
TIMER EQU 10H
N_CLK EQU 11

ORG 44
    IP_CLK DW RUT_CLK

ORG 1000H
    CODIGO DB "ana"
    FIN DB ?

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

    INI_PIC:PUSH AX
            MOV AL, 0FDH
            OUT PIC+1, AL
            MOV AL, N_CLK
            OUT PIC+5 , AL
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

    RUT_CLK:PUSH AX
        PLL:IN AL, PIO
            AND AL, 1
            JNZ PLL
            MOV AL, [BX]
            OUT PIO+1, AL
            CALL PLS
            MOV AL, 0
            OUT TIMER, AL
            MOV AL, 20H
            OUT PIC, AL
            INC BX
            DEC CL
            POP AX
            IRET

ORG 2000H
    CLI
    CALL INI_PIC
    CALL INI_PIO
    MOV AL, 0
    OUT TIMER, AL
    MOV AL, 1
    OUT TIMER+1, AL
    MOV BX, OFFSET CODIGO
    MOV CL, OFFSET FIN - OFFSET CODIGO
    STI
LZO:CMP CL, 0
    JNZ LZO
    INT 0
    END