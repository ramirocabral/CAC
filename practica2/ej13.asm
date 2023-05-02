TIMER EQU 10H
PIC EQU 20H
EOI EQU 20H
N_CLK EQU 10

ORG 40

    IP_CLK DW RUT_CLK

ORG 1000H

    MIN DB 30H
    MIN2 DB 39H
    SEG DB 35H
    SEG2 DB 32H
    SEP DB "  "

ORG 3000H

    RUT_CLK: PUSH AX
    INC SEG2        
    CMP SEG2, 3AH           ; si llegaron a 10 segundos, se suma a las decenas
    JNZ RST       
    MOV SEG2, 30H           ; se ponen las unidades en 0
    INC SEG
    CMP SEG, 36H            ; si se llegaron a 60 seg, se pone las decenas en 0 (las unidades ya son 0)
    JNZ RST
    MOV SEG, 30H        
    INC MIN2
    CMP MIN2, 3AH           ; si se llegaron a 10 min, se suma a las decenas
    JNZ RST
    MOV MIN2, 30H           ; se ponen las unidades en 0
    INC MIN
    CMP MIN, 36H            ; si se llegaron a 60 min, se pone las decenas en 0 (las unidades ya son 0)
    JNZ RST
    MOV MIN, 30H
RST:CMP SEG2, 30H           ;cada 10 segundos
    JNZ FIN 
    INT 7                   ;imprimimos todo
FIN:MOV AL, 0
    OUT TIMER, AL
    MOV AL, EOI
    OUT PIC, AL             ;termina la interrupcion
    POP AX 
    IRET

ORG 2000H

    CLI
    MOV AL, 0FDH
    OUT PIC+1, AL           ;PIC: registro IMR
    MOV AL, N_CLK
    OUT PIC+5, AL ; PIC: registro INT1
    MOV AL, 1
    OUT TIMER+1, AL ; TIMER: registro COMP
    MOV AL, 0
    OUT TIMER, AL ; TIMER: registro CONT
    MOV BX, OFFSET MIN
    MOV AL, 6
    STI
    LAZO: JMP LAZO

END