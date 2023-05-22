%macro write 2
    mov   eax, 4
    mov   ebx, 1
    mov   ecx, %1
    mov   edx, %2
    int   80h
%endmacro

%macro read 2
    mov eax, 3
    mov ebx, 0
    mov ecx, %1  
    mov edx, %2
    int 80h    
%endmacro

section .data
    msg1 db 'Enter the element to be searched: ',     
    len1 equ $-msg1            
 
    msg2 db 'Element Found at index :'     
    len2 equ $-msg2
    
    msg3 db 'Element Not Found :  '     
    len3 equ $-msg3
 
    newline db 13, 10
    newlineLen equ $-newline
    
    array db 63H, 21H, 57H, 23H, 67H, 81H, 15H
    
section .bss
    digit_1 resb 2
    digit_2 resb 2
    key resb 2
    count resb 2

section .text
    global _start

_start:
    write msg1,len1
    read digit_1, 2
    read digit_2,1
    xor eax,eax
    xor ebx,ebx
    xor ecx,ecx
    call convert
    mov [key], ebx
    mov dx,0        
    linear:
        mov al, [key]
        mov esi, array
        mov cx, 07H  
        up:
            mov bl,[esi]
            cmp al, bl
            jz fo
            inc esi
            inc dx
            dec cx
            jnz up
        write msg3,len3
        jmp exit
fo:
    add dx,'0'
    mov [count],dx
    write msg2,len2
    write count,2
exit:      
    write newline, newlineLen
    mov eax,1                
    int 80h
convert :
    mov esi ,digit_1
    mov edi ,digit_2
    mov cl ,02h
    xor eax,eax
    xor ebx,ebx
    next_digit: 
        rol bl,04h
        mov al,[esi]
        cmp al,39h
        jbe skip_sub
        sub al,07h
        skip_sub :
            sub al,30h
            add bl,al
            mov [edi],bl
            inc esi
            inc edi
            loop next_digit
            ret
