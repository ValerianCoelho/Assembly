section .data
    evenMsg db 'The number is even', 13, 10
    lenEvenMsg equ $-evenMsg
    
    oddMsg db 'The number is odd', 13, 10
    lenOddMsg equ $-oddMsg
    
section .text
    global _start
    
_start:
    mov eax, 24 ;The number to be tested is stored in eax
    ror eax, 1 ;carry flag is set to the bit rolled out
    
    jc odd ;carry flag is checked
    
    mov eax, 4
    mov ebx, 1
    mov ecx, evenMsg
    mov edx, lenEvenMsg
    int 80h
    
    jmp exit
    
    odd:
        mov eax, 4
        mov ebx, 1
        mov ecx, oddMsg
        mov edx, lenOddMsg
        int 80h
        
        jmp exit
    
    exit:
        mov eax, 1
        int 80h