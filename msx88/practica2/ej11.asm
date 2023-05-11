PIC EQU 20H
EOI EQU 20H
N_F10 EQU 10

ORG 40

    IP_F10 DW RUT_F10

ORG 1000H

    LETRA DB "A"

ORG 3000H

INI_PIC:PUSH AX
        MOV AL, 0FEH
        OUT PIC+1, AL   ;PIC: registro IMR
        MOV AL, N_F10
        OUT PIC+4, AL   ;PIC: registro INT0
        POP AX
        RET

ORG 2000H
    CALL INI_PIC
    CLI
    MOV DX, 0
    MOV BX, OFFSET LETRA
    STI
LAZ:CMP DH, 0FFH        ;chequeamos si hubo una interrupcion
    JZ IMP
    INC BYTE PTR [BX]
    CMP BYTE PTR [BX], 90;si llegamos a lz z, volvemos a la letra a
    JNZ LAZ
    SUB BYTE PTR [BX], 45
    JMP LAZ

IMP:MOV AL,1
    INT 7
    INT 0
    HLT

ORG 4000H

    RUT_F10: PUSH AX
    MOV DH, 0FFH        ;mandamos señal de interrupcion
    MOV AL, EOI
    OUT EOI, AL         ; PIC: registro EOI
    POP AX
    IRET
    END