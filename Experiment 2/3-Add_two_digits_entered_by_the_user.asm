section .data
    msg1 db 'Enter the First Number : '
    len1 equ $ - msg1

    msg2 db 'Enter the second Number : '
    len2 equ $ - msg2

    msg3 db 'Result : '
    len3 equ $ - msg3

    newline db '',13, 10
    lennewline equ $-newline

section .bss
    num1 resb 5
    num2 resb 5
    result resb 5

section .text
    global _start

_start:
    ;'Enter the First Number : '
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 80h

    ;Reading the Fist number
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 5
    int 80h

    ;'Enter the Second Number : '
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 80h

    ;Reading the second Number
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 5
    int 80h

    ;--------------ADDITION-------------
    mov eax, [num1]
    sub eax, '0'

    mov ebx, [num2]
    sub eax, '0'

    ;adding num1 and num2 and storing the result in eax
    add eax, ebx
    add eax, '0'

    ;Moving the result in variable 'result'
    mov [result], eax

    ;'Result : '
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, len3
    int 80h

    ;Dislaying the result
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 5
    int 80h

    ;Dislaying a new line
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, lennewline
    int 80h

    mov eax, 1
    int 80h
