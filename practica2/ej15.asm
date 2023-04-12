TIMER EQU 10H
PIC EQU 20H
EOI EQU 20H
N_CLK EQU 11
N_F10 EQU 10
;11111110 FEH
;11111100 FCH

ORG 40
    IP_F10 DW RUT_F10

ORG 44

    IP_CLK DW RUT_CLK

ORG 1000H

    N DB ?

ORG 3000H

RUT_CLK: PUSH AX        ;--------TIMER---------
    INT 7               ; imprimimos N
    DEC N
    CMP N, 30H         ; si es 0, devolvemos 0feh en DH
    JNZ FIN
    MOV DH, 0FFH
FIN:MOV AL, 0
    OUT TIMER, AL
    MOV AL, EOI
    OUT PIC, AL      ; termina la interrupcion
    POP AX 
    IRET


RUT_F10: PUSH AX     ;-----------F10------------
    MOV AL, 0FDH     ; habilitamos las interrupciones del timer
    OUT PIC+1, AL
    MOV AL, EOI 
    OUT PIC, AL      ; informamos el fin de la interrupcion
    POP AX 
    IRET

ORG 2000H

    CLI
    MOV AL, 0FEH  ; 11111110 habilitamos f10
    OUT PIC+1, AL ; PIC: registro IMR
    MOV AL, N_CLK
    OUT PIC+5, AL ; PIC: registro INT1
    MOV AL, N_F10
    OUT PIC+4, AL ; PIC: registro INT0
    MOV AL, 1
    OUT TIMER+1, AL ; TIMER: registro COMP
    MOV AL, 0
    OUT TIMER, AL ; TIMER: registro CONT
    MOV BX, OFFSET N
    INT 6         ; LEEMOS EL NUMERO
    MOV AL, 1
    MOV DH, 0
    STI
LAZ:CMP DH, 0FFH   ; si termino el conteo
    JNZ LAZ
    HLT
END