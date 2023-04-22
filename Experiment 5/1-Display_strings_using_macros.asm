%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .data
    msg1 db "Name: Valerian", 10, 13
    len1 equ $-msg1

    msg2 db "Surname: Coelho", 10, 13
    len2 equ $-msg2

    msg3 db "Age: 19", 10, 13
    len3 equ $-msg3

section .text
    global _start

_start:
    write msg1, len1
    write msg2, len2
    write msg3, len3
    mov eax,1
    int 80h