ORG 1000H

NUM Db 4
ROT DB 4


ORG 3000h

MUL:     MOV DL, 0
         CMP CL, 0
         JZ VOLVER
         MOV AH, 7   ; AH= CANTIDAD DE ROTACIONES A LA IZQ EQUIVALENTES A 1 A LA DERECHA
 LAZO:   ADD DL, CL
         DEC AH
         JNZ LAZO
VOLVER:  MOV CL,DL
         RET



ROTARDER: CALL MUL
          CALL ROTARIZQ
          RET

ROTARIZQ:CMP AL, 255
         JZ Fin
         CMP AL, 0
         JZ Fin
    For: ADD AL, AL
         JNC SEGUIR
         INC AL
SEGUIR:  DEC CL
         JNZ For
    Fin: RET
       

          
ORG 2000H

MOV AL, NUM
MOV CL, ROT   ; CL = CANTIDAD DE ROTACIONES A LA DERECHA
CALL ROTARDER
MOV NUM, AL
HLT

END


