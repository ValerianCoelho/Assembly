section .data
    stars times 10 db '*'
    len equ $ -stars

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, stars
    mov edx, len
    int 80h

    mov eax, 1
    int 80h