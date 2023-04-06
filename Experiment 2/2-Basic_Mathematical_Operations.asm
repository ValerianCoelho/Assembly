section .data
    msg1 db 'Enter the first number : '
    len1 equ $-msg1

    msg2 db 'Enter the second Number : '
    len2 equ $-msg2

    msg3 db 'Addition : '
    len3 equ $-msg3

    msg4 db 13,10,'Subtraction : '
    len4 equ $-msg4

    msg5 db 13,10,'Multiplication : '
    len5 equ $-msg5

    msg6 db 13,10,'Division : '
    len6 equ $-msg6

    newline db '', 13, 10
    lennewline equ $-newline

section .bss
    num1 resb 5
    num2 resb 5
    res resb 5

section .text
    global _start

_start:
    ;'Enter the first number : '
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 80h

    ;Reading the first number
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 2
    int 80h

    ;'Enter the second number : '
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 80h

    ;Reading the second number
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 2
    int 80h

    ;------------------ADDITION---------------------
    ;Converting string numbers to integer numbers
    mov eax, [num1]
    sub eax, '0'

    mov ebx, [num2]
    sub ebx, '0'

    ;Adding num1 and num2 and storing result in eax
    add eax, ebx
    add eax, '0'

    ;pushing result of summation to variable res
    mov [res], eax

    ;'Addition : '
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, len3
    int 80h

    ;Displaying the result of Addition
    mov eax, 4
    mov ebx, 1
    mov ecx, res
    mov edx, 5
    int 80h

    ;------------------SUBTRACTION---------------------
    ;Converting string numbers to integer numbers
    mov eax, [num1]
    sub eax, '0'

    mov ebx, [num2]
    sub ebx, '0'

    ;Subtracting num1 and num2 and storing result in eax
    sub eax, ebx
    add eax, '0'

    ;pushing result of summation to variable res
    mov [res], eax

    ;'Subtraction : '
    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, len4
    int 80h

    ;Displaying the result of Subtraction
    mov eax, 4
    mov ebx, 1
    mov ecx, res
    mov edx, 5
    int 80h

    ;------------------MULTILICATION---------------------
    ;Converting string numbers to integer numbers
    mov al, [num1]
    sub al, '0'

    mov bl, [num2]
    sub bl, '0'

    ;Multiplying num1 and num2 and storing result in eax
    mul bl
    add al, '0'

    ;pushing result of Multiplication to variable res
    mov [res], al

    ;'Multiplication : '
    mov eax, 4
    mov ebx, 1
    mov ecx, msg5
    mov edx, len5
    int 80h

    ;Displaying the result of Multiplication
    mov eax, 4
    mov ebx, 1
    mov ecx, res
    mov edx, 5
    int 80h

    ;------------------DIVISION---------------------
    ;Converting string numbers to integer numbers
    mov al, [num1]
    sub al, '0'

    mov bl, [num2]
    sub bl, '0'

    ;Dividing num1 and num2 and storing result in eax
    div bl
    add ax, '0'

    ;pushing result of Division to variable res
    mov [res], ax 

    ;'Division : '
    mov eax, 4
    mov ebx, 1
    mov ecx, msg6
    mov edx, len6
    int 80h

    ;Displaying the result of Division
    mov eax, 4
    mov ebx, 1
    mov ecx, res
    mov edx, 5
    int 80h

    ;Displaying a new line
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, lennewline
    int 80h

    mov eax, 1
    int 80h