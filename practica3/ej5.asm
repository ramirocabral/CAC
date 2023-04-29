PIO EQU 30H

ORG 1000H

CAR DB ?
NUM_CAR DB 5

;SUBRUTINA DE INICIALIZACION; 
ORG 3000H

IMP:MOV AL, 1
    OUT PIO+2, AL
    MOV AL, 0
    OUT PIO+3, AL
    IN AL, PIO 
    AND AL, 0FDH        ;ponemos bit strobe en 0
    OUT PIO, AL
RET 

STR_EN0:IN AL, PIO      ;strobe en 0
        OR AL, 2
        OUT PIO, AL
RET

SRT_EN1:IN AL, PIO      ;strobe en 1
        AND AL, 0FDH
        OUT PIO, AL
RET


ORG 2000H
    PUSH AX
    CALL IMP
    POP AX
    MOV BX, OFFSET CAR
    MOV CL, NUM_CAR
LZO:INT 6
PLL:IN AL, PIO
    AND AL, 1
    JNZ PLL
    MOV AL, [BX]
    OUT PIO+1, AL
    PUSH AX
    CALL STR_EN0
    CALL SRT_EN1
    POP AX
    DEC CL
    JNZ LZO
    INT 0
    END