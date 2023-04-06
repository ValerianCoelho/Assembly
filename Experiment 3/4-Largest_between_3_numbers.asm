section .data
    greaterMsg db ' is the Largest', 13, 10
    lenGreaterMsg equ $-greaterMsg

section .bss
    value resb 5

section .text
    global _start

_start:
    mov eax, 1
    mov ebx, 5
    mov ecx, 3

    cmp eax, ebx
    jg first_and_third

    cmp ebx, ecx
    jg second

    jmp third

    first_and_third:
        cmp eax, ecx
        jg first

        jmp third

    first:
        add eax, '0'
        mov [value], eax
        jmp exit

    second:
        add ebx, '0'
        mov [value], ebx
        jmp exit

    third:
        add ecx, '0'
        mov [value], ecx
        jmp exit

    exit:
        ;Displaying the Largest Number
        mov eax, 4
        mov ebx, 1
        mov ecx, value
        mov edx, 5
        int 80h

        ;Dislaying the Message ' is the Largest'
        mov eax, 4
        mov ebx, 1
        mov ecx, greaterMsg
        mov edx, lenGreaterMsg
        int 80h

        mov eax, 1
        int 80h