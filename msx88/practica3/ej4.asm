PIO EQU 30H
ORG 1000H
MSJ DB "CONCEPTOS DE "
DB "ARQUITECTURA DE "
DB "COMPUTADORAS"
FIN DB ?

ORG 2000H

    MOV AL, 1           ;configuramos bits strobe y busy
    OUT PIO+2, AL       ;PUERTO CA
    MOV AL, 0           ;puerto cb todo en salida
    OUT PIO+3, AL
    IN AL, PIO          ;nos aseguramos que el strobe este en 0
    AND AL, 0FDH
    OUT PIO, AL         ;FIN INICIALIZACION
    MOV BX, OFFSET MSJ
    MOV CL, OFFSET FIN-OFFSET MSJ
PLL:IN AL, PIO
    AND AL, 1
    JNZ PLL             ;si el bit busy esta en 1
    MOV AL, [BX]
    OUT PIO+1, AL       ;puerto PB, salida
    IN AL, PIO          ;PULSO 'STROBE'
    OR AL, 2            ;ponemos el strobe en 1
    OUT PIO, AL
    IN AL, PIO
    AND AL, 0FDH        ;ponemos el strobe en 0
    OUT PIO, AL         
    INC BX
    DEC CL
    JNZ PLL

    INT 0
    END