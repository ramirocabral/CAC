; ORG 1000H
; ORG 2000H


; MOV AL, 5
; MOV BL, 10
; MOV CL, 0

; CMP AL, BL 

; JNS ELSE
; MOV CL, AL
; JMP FIN

; ELSE: MOV CL, BL
; FIN: HLT

; END


;A

      ORG 2000H
      MOV AL, 0FFH
      MOV BL, 0F0H
      MOV CL, 0
      CMP AL, BL
      JZ IF
      JNC ELSE
IF:   MOV CL, AL
      JMP FIN
ELSE: MOV CL, BL
FIN:  HLT
      END