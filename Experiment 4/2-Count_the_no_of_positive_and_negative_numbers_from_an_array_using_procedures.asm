section .data
    array db 1, 2, -3, 4, 5
    
    posMsg db 'Positive : '
    lenPosMsg equ $-posMsg
    
    negMsg db ' and Negative : '
    lenNegMsg equ $-negMsg
    
section .bss
    positive resb 1
    negative resb 1

section .text
    global _start
    
_start:
    mov cl, 5 ; size of the array
    mov dl, 0 ; stores the no. of +ve numbers in the array
    mov esi, array ; point to address of elements of the array
    
    up:
        mov al, [esi] ; move current element to al
        inc esi ; increment array index
        rol al, 1
        jc skip ; if value in al is -ve
        add dl, 1 ; if value in al is +ve
        skip: 
            loop up
    
    mov al, 5 ; size of array
    sub al, dl ; Neg numbers = Size of array - Pos numbers
    add al, '0'
    add dl, '0'
        
    mov [positive], dl
    mov [negative], al
    
    mov eax, 4
    mov ebx, 1
    mov ecx, posMsg
    mov edx, lenPosMsg
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, positive
    mov edx, 1
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, negMsg
    mov edx, lenNegMsg
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, negative
    mov edx, 1
    int 80h
    
    mov eax, 1
    int 80h