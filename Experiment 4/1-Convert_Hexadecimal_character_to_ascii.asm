section .data
    hex dw 34h
    
section .bss
    ascii resb 2
    
section .text
    global _start
    
_start:
    mov bl, [hex]
    mov cl, 2 ; they are two bytes, so count = 2
    mov edi, ascii ; initialize edi, with memory address of variable ascii
    
    next_digit:
        rol bl, 4 ; rotating 4 MSB's to 4 LSB's
        mov al, bl ; creating copy
        and al, 0Fh ; erasing 4 MSB's
        cmp al, 09h ; check if al > 9, if true it means the num is in hexadecimal form (ah, bh, ch, etc)
        jbe skip_add 
        add al, 07h
        
        skip_add:
            add al, 30h ; Add 30h to convert the digit to its corresponding ASCII character
            mov [edi], al ; move ascii char to ascii variable location
            inc edi ; increment edi by one byte
            loop next_digit
            
    ; Display the decimal number
    mov eax, 4
    mov ebx, 1
    mov ecx, ascii
    mov edx, 2
    int 80h
    
    mov eax, 1
    int 80h