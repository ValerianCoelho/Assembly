section .data
    userMsg db 'Enter a digit : '
    lenUserMsg equ $-userMsg

    dispMsg db 'The number you entered is : '
    lenDispMsg equ $-dispMsg

    newline db '', 13, 10
    lennewline equ $-newline

section .bss
    num resb 5

section .text
    global _start

_start:
    ;Displaying the Message 'Enter a digit : '
    mov eax, 4
    mov ebx, 1
    mov ecx, userMsg
    mov edx, lenUserMsg
    int 80h

    ;Accepting the digit
    mov eax, 3
    mov ebx, 2
    mov ecx, num
    mov edx, 5
    int 80h

    ;Displaying the Message 'The number you entered is : '
    mov eax, 4
    mov ebx, 1
    mov ecx, dispMsg
    mov edx, lenDispMsg
    int 80h

    ;Displaying the number
    mov eax, 4
    mov ebx, 1
    mov ecx, num
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
