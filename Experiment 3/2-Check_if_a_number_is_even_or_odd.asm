section .data
    evenmsg db 'The number is even', 13, 10
    lenevenmsg equ $-evenmsg

    oddmsg db 'The number is odd', 13, 10
    lenoddmsg equ $-oddmsg

section .text
    global _start

_start:
    ;The number to be tested is stored in eax
    mov eax, 24
    and eax, 1

    jz even

    mov eax, 4
    mov ebx, 1
    mov ecx, oddmsg
    mov edx, lenoddmsg
    int 80h

    jmp exit

    even:
        mov eax, 4
        mov ebx, 1
        mov ecx, evenmsg
        mov edx, lenevenmsg
        int 80h

    exit:
        mov eax, 1
        int 80h