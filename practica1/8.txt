ORG 1000H

NUM Db 100
ROT DB 2


ORG 3000h

ROTARIZQ:CMP AL, 255
         JZ Fin
         CMP AL, 0
         JZ Fin
    For: ADD AL, AL
         JC CARRY
         DEC CL
         JNZ For
    Fin: RET
       
CARRY: ADD AL, 1
       RET
          
ORG 2000H

MOV AL, NUM
MOV CL, ROT
CALL ROTARIZQ
HLT

END


