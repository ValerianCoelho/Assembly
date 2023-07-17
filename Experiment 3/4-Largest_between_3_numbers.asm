section .data
    msg db ' is the Largest'
    lenMsg equ $-msg
    
section .bss
    num resb 1
    
section .text
    global _start
    
_start:
    mov eax, 7
    mov ebx, 5
    mov ecx, 3
    
    cmp eax, ebx ; (ebx - eax), if result is -ve SF is set
    jg first_and_third ; Jumps if SF flag is set
    
    cmp ebx, ecx
    jg second
    
    jmp third
    
    first_and_third:
        cmp eax, ecx
        jg first
        
        jmp third
        
    first:
        add eax, '0'
        mov [num], eax
        jmp exit
        
    second:
        add ebx, '0'
        mov [num], ebx
        jmp exit
        
    third:
        add ecx, '0'
        mov [num], ecx
        jmp exit
        
    exit:
        ; Displaying the number
        mov eax, 4
        mov ebx, 1
        mov ecx, num
        mov edx, 1
        int 80h
        
        ; Displaying the Message
        mov eax, 4
        mov ebx, 1
        mov ecx, msg
        mov edx, lenMsg
        int 80h
        
        mov eax, 1
        int 80h
        