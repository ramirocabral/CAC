-----------------------------------------------1-----------------------------------------------


ORG 1000H
NUM0 DB 0CAH
NUM1 DB 0
NUM2 DW ?
NUM3 DW 0ABCDH
NUM4 DW ?
ORG 2000H
MOV BL, NUM0
MOV BH, 0FFH
MOV CH, BL
MOV AX, BX
MOV NUM1, AL
MOV NUM2, 1234H
MOV BX, OFFSET NUM3
MOV DL, [BX]
MOV AX, [BX]
MOV BX, 1006H
MOV WORD PTR [BX], 1006H
HLT
END

1 - MOV BL, NUM0 - direccionamiento directo de memoria - BL = CAh

2- MOV BH, 0FFH - direccionamiento inmediato - BH = FFh

3 - MOV CH, BL -  direccionamiento directo de registro - CH = Cah

4 - MOV AX, BX - direccionamiento directo de registro - AX = FFCAh

5 - MOV NUM1, AL - direccionamiento directo de registro - NUM1 = CAh

6 - MOV NUM2, 1234h - direccionamiento inmediato - NUM2 = 1234h

7 - MOV BX, OFFSET NUM3 - direccionamiento directo de memoria - BX = 1004h

8 - MOV DL, [BX] - direccionamiento indirecto con registro - DL = ABCDh

9 - MOV AX, [BX] - direccionamiento indirecto con registro - AX = ABCDh

10 - MOV BX, 1006h - direccionamiento inmediato - BX = 1006h

11- MOV [BX], 1006H - direccionamiento inmediato - [BX] (DIR 1006h) = 1006h






