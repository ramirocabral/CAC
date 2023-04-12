ORG 1000H

MSJ1 DB "ACCESO PERMITIDO"
MSJ2 DB "ACCESO DENEGADO"
CLAVE DB "DUKA"
CAR DB ?


;RUTINA QUE LEE LOS CARACTERES, GUARDA EN DH EL RESULTADO

LEE:MOV AH, 0
FOR:MOV BX, OFFSET CLAVE
    ADD BL, AH   ; ACCEDEMOS AL CARACTER
    MOV DL, [BX] ; CARACTER A COMPARAR
    MOV BX, OFFSET CAR
    INT 6
    CMP [BX], DL
    JNZ ERR
    INC AH
    CMP AH, 4
    JNZ FOR
    MOV DH, 0FFH
    JMP FIN
ERR:MOV DH, 0FEH
FIN:RET

ORG 2000H

    CALL LEE
    CMP DH, 0FFH
    JNZ ES2

    MOV AL, OFFSET MSJ2 - OFFSET MSJ1 ; IMPRIMIMOS PRIMER MENSAJE
    MOV BX, OFFSET MSJ1
    JMP IMP

ES2:MOV AL, OFFSET CLAVE - OFFSET MSJ2 ; IMPRIMIMOS SEGUNDO MENSAJE
    MOV BX, OFFSET MSJ2

IMP:INT 7
    INT 0

END