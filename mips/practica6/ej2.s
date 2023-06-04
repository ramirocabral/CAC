.data
    msj:    .asciiz     "Ingrese un numero: "
    msj2:   .asciiz     "FATAL ERROR:El caracter no es un digito"

    str0:   .asciiz     "CERO"
    str1:   .asciiz     "UNO"
    str2:   .asciiz     "DOS"
    str3:   .asciiz     "TRES"
    str4:   .asciiz     "CUATRO"
    str5:   .asciiz     "CINCO"
    str6:   .asciiz     "SEIS"
    str7:   .asciiz     "SIETE"
    str8:   .asciiz     "OCHO"
    str9:   .asciiz     "NUEVE"

    CONTROL: .word32    0x10000
    DATA:    .word32    0X10008

.code
    lwu     $s6, CONTROL($0)
    lwu     $s7, DATA($0)
    jal     ingreso
    beqz    $v0, end
    dadd    $a0, $0, $v0
    jal     muestra
end: halt
    nop


;al pedo lei un caracter
ingreso: daddi  $t0, $0, msj
        sd      $t0, 0($s7)         ;escribir en DATA
        daddi   $t0, $0, 4          ;señal de escribir
        sd      $t0, 0($s6)         ;mandar 4 a CONTROL
        daddi   $t0, $0, 9          ;señal de leer
        sd      $t0, 0($s6)     
        lbu     $v0, 0($s7)         ;leer dato de DATA
        slti    $t1, $v0, 48        ;comparar si es menor a 48
        bne     $t1, $0, error      ;si es menor a 48, error
        slti    $t1, $v0, 58        ;comparar si es mayor a 58
        beqz    $t1, error          ;si es mayor a 58, error
        j fin
error:  daddi   $t0, $0, msj2       ;direccion de msj2
        sd      $t0, 0($s7)         ;escribir en DATA
        daddi   $t0, $0, 4          ;señal de escribir
        sd      $t0, 0($s6)         ;mandar 4 a CONTROL
        daddi   $v0, $0, 0          ;retornamos 0 si el char no es valido
fin:    jr      $ra

muestra: daddi  $a0, $a0, -48       ;pasamos a entero
        daddi   $t1, $0, 8
        dmulu   $a0, $a0, $t1       ;multiplicamos por 8
        daddi   $t0, $a0, str0      ;no me acuerdo como hacerlo mejor
        sd      $t0, 0($s7)         ;escribir en DATA   
        daddi   $t0, $0, 4          ;señal de escribir
        sd      $t0, 0($s6)         ;mandar 4 a CONTROL
        jr      $ra