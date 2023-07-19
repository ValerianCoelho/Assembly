section .data
    inputMsg db 'Enter 7 elements in the array : '
    lenInputMsg equ $-inputMsg
    
    outputMsg db 'The elements are : '
    lenOutputMsg equ $-outputMsg
    
    space db ' '
    lenSpace equ $-space
    
section .bss
    array resb 7
    whitespace resb 1
    
%macro read 2
    pusha
    mov eax, 3
    mov ebx, 0
    mov ecx, %1
    mov edx, %2
    int 80h
    popa
%endmacro

%macro write 2
    pusha
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
    popa
%endmacro
    
section .text
    global _start
    
_start:
    write inputMsg, lenInputMsg
    mov ecx, 7
    mov edi, array
    
    input:
        read edi, 1
        read whitespace, 1
        inc edi
        loop input
        
    mov ecx, 7
    mov esi, array
    
    output:
        write esi, 1
        write space, lenSpace
        inc esi
        loop output
        
    mov eax, 1
    int 80h