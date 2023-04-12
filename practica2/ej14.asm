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

    SEG DB 30H
    SEG2 DB 30H

ORG 3000H

RUT_CLK: PUSH AX        ;--------TIMER---------
    INC SEG2
    CMP SEG2, 3AH    ; si llegaron a 10 segundos, se suma a las decenas
    JNZ IMP
    MOV SEG2, 30H    ; se ponen las unidades en 0
    INC SEG
IMP:INT 7            ; AL = 2
    CMP SEG, 33H     ; si se llegaron a 30 seg, reseteamos el timer
    JNZ FIN
    MOV SEG, 30H
    MOV SEG2, 30H
    MOV AL, 0FEH     ; desabilitamos las interrupciones del timer
    OUT PIC+1, AL
FIN:MOV AL, 0
    OUT TIMER, AL
    MOV AL, EOI
    OUT PIC, AL      ; termina la interrupcion
    POP AX 
    IRET


RUT_F10: PUSH AX     ;-----------F10------------
    IN AL, PIC+1     ; interrupciones del IMR
    CMP AL, 0FCH     ; si esta habilitado el timer
    JZ DST
    MOV AL, 0FCH     ; habilitamos las interrupciones del timer
    OUT PIC+1, AL
    JMP DUK      
DST:MOV AL, 0FEH     ; desabilitamos las interrupciones del timer
    OUT PIC+1, AL
DUK:MOV AL, EOI
    OUT PIC, AL
    POP AX
    IRET

ORG 2000H

    CLI
    MOV AL, 0FEH
    OUT PIC+1, AL ; PIC: registro IMR
    MOV AL, N_CLK
    OUT PIC+5, AL ; PIC: registro INT1
    MOV AL, N_F10
    OUT PIC+4, AL ; PIC: registro INT0
    MOV AL, 1
    OUT TIMER+1, AL ; TIMER: registro COMP
    MOV AL, 0
    OUT TIMER, AL ; TIMER: registro CONT
    MOV BX, OFFSET SEG
    MOV AL, 2
    STI
    LAZO: JMP LAZO
END