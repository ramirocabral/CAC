ORG 1000H

PALABRA DB "AGUANTE BOCA"
FINAL  DB ?
TABLA DB "AEIOUaeiou"


ORG 3000h

ES_VOCAL: CMP CH,[BX]  ; bx = dir de caracter de TABLA
          JZ FIN
          INC BX        ; PASAMOS A LA SIG VOCAL
          DEC DL        ; DL = CANTIDAD DE VOCALES (10)
          JNS ES_VOCAL
          MOV AL, 00H
          RET
          
FIN:      MOV AL, 0FFH
          RET
          
VOCALES:  MOV CH, [BX]   ; CH = CARACTER A ANALIZAR
          MOV DL, 10
          PUSH BX
          MOV BX, OFFSET TABLA
          CALL ES_VOCAL
          POP BX
          CMP AL, 0FFH     ;si es vocal
          JNZ SEGUIR
          INC AH           ; si era vocal, sumamos uno a ah
SEGUIR:   INC BX           ; pasamos a la siguiente letra de la palabvra
          DEC DH           ;restamos una letra de la palabra
          JNS VOCALES
          RET
          
ORG 2000H

MOV DH, OFFSET FINAL - OFFSET PALABRA ; LONGITUD DE LA PALABRA
MOV BX, OFFSET PALABRA
CALL VOCALES


; AH CANTIDAD DE VOCALES
; AL SI UN CARACTER ES VOCAL O NO
;DH CANTIDAD DE CARACTERES DE LA STRING
Fin: HLT

END


