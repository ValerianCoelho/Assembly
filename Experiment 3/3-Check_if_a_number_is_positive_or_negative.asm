section .data
    negmsg db 'The number is negative', 13, 10
    lennegmsg equ $-negmsg

    posmsg db 'The number is positive', 13, 10
    lenposmsg equ $-posmsg

section .text
    global _start

_start:
    mov eax, 24 ;The number to be tested is stored in eax
    rol eax, 1 ;carry flag is set to the bit rolled out

    jc negative ;carry flag is checked

    mov eax, 4
    mov ebx, 1
    mov ecx, posmsg
    mov edx, lenposmsg
    int 80h

    jmp exit

    negative:
        mov eax, 4
        mov ebx, 1
        mov ecx, negmsg
        mov edx, lennegmsg
        int 80h

    exit:
        mov eax, 1
        int 80h