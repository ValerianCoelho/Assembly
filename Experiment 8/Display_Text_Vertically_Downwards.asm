section .data
    string db 'Hello World'
    lenString equ $-string
    
    newline db '', 13, 10
    lenNewline equ $-newline
    
section .bss 
    char resb 1
    
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
    mov eax, string
    mov ecx, lenString
    
    display:
        mov [char], eax
        write [char], 1
        write newline, lenNewline
        add eax, 1
        loop display
    
    mov eax, 1
    int 80h
    
    