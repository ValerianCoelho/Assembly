%macro write 2
    pusha
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
    popa
%endmacro

Section .data
    string db 'Hello World'
    strlen equ $ - string

    newline db '', 13, 10
    newlineLen equ $ - newline

Section .bss
    num resb 1

Section .text
    global _start

_start:
    mov eax, string
    mov ecx, strlen
    up:
        mov [num], eax
        add eax, 1
        write [num], 1
        write newline, newlineLen
        loop up
    exit:
        mov eax,1
        int 80H
