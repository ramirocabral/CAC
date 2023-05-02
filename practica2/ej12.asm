TIMER EQU 10H
PIC EQU 20H
EOI EQU 20H
N_CLK EQU 10

ORG 40
    IP_CLK DW RUT_CLK

ORG 1000H
    SEG DB 30H          ;decenas de segundos
    SEG2 DB 30H         ;segundos
    FIN DB ?

ORG 3000H

RUT_CLK:PUSH AX
        INC SEG2
        CMP SEG2, 3AH   ;si llegaron a 10 segundos, se suma a las decenas
        JNZ RST
        MOV SEG2, 30H   
        INC SEG
        CMP SEG, 36H    ;si se llegaron a 60 seg, se pone las decenas en 0 (las unidades ya son 0)
        JNZ RST
        MOV SEG, 30H
RST:    INT 7           ;se imprime siempre seg (decenas segundos + segundos) 2 bytes 
        MOV AL, 0
        OUT TIMER, AL   ;ponemos en 0 CONT
        MOV AL, EOI
        OUT PIC, AL     ;termina la interrupcion
        POP AX 
        IRET

ORG 2000H
    CLI
    MOV AL, 0FDH
    OUT PIC+1, AL       ;PIC: registro IMR
    MOV AL, N_CLK
    OUT PIC+5, AL       ;PIC: registro INT1
    MOV AL, 1
    OUT TIMER+1, AL     ;ponemos en 1 COMP
    MOV AL, 0
    OUT TIMER, AL       ;ponemos en 0 CONT
    MOV BX, OFFSET SEG
    MOV AL, OFFSET FIN-OFFSET SEG
    STI
    LAZO: JMP LAZO
    INT 0
    END
