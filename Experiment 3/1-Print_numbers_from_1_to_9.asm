section .bss
    num resb 5

section .data
    newline db '', 13, 10
    lenNewline equ $-newline

section .text
    global _start

_start:
    mov ecx, 9
    mov eax, '1'

    up:
    ;Storing the values of eax in a variable and ecx on the stack
    mov [num], eax
    push ecx

    ;Printing the value stored in num
    mov eax, 4
    mov ebx, 1
    mov ecx, num
    mov edx, 1
    int 80h

    ;Retrieving the values back from num and stack
    mov eax, [num]
    pop ecx

    ;Incrementing the value by 1
    sub eax, '0'
    inc eax
    add eax, '0'
    loop up

    ;Printing newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, lenNewline
    int 80h
    
    mov eax, 1
    int 80h