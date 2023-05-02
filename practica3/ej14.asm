PIC EQU 20H
DMAC EQU 50H
N_DMA EQU 13

ORG 52
    IP_DMA DW RUT_DMA

ORG 1000H

    MSJ DB "FACULTAD DE"
    DB "INFORMATICA"

    FIN DB ?

    NCHAR DB ?                  ;almacenamos la cantidad de char

ORG 1500H

    COPIA DB ?

ORG 3000H

INI_PIC:PUSH AX
        MOV AL, N_DMA
        OUT PIC+7, AL
        MOV AL, 11110111B       ;hablitamos la INT 3
        OUT PIC+1, AL
        POP AX
        RET

RUT_DMA:MOV AL, 0FFH
        OUT PIC+1, AL           ;inhabilita todas las interrupciones
        MOV BX, OFFSET COPIA
        MOV AL, NCHAR           ;cant de caracteres
        INT 7
        MOV AL, 20H
        OUT PIC, AL
        IRET

ORG 2000H
    CLI
    CALL INI_PIC
    ;config de DMAC
    MOV AX, OFFSET MSJ          ;direccion fuente
    OUT DMAC, AL
    MOV AL, AH
    OUT DMA+1, AL
    MOV AX, OFFSET FIN - OFFSET MSJ;cantidad de bytes a mover
    OUT DMA+2,AL
    MOV AL, AH
    OUT DMA+3, AL
    MOV AX, OFFSET COPIA        ;direccion destino
    OUT DMA+4, AL
    MOV AL, AH
    OUT DMA+5, AL
    MOV AL, 00001010B
    OUT DMA+6, AL
    STI
    MOV BX, OFFSET MSJ
    MOV AL, OFFSET FIN-OFFSET MSJ
    MOV NCHAR, AL
    INT 7
    MOV AL, 7                   ;00000111, inicio de transferencia
    OUT DMA+7, AL
LZO:JMP LZO
    INT 0
    END