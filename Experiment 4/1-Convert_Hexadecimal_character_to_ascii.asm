section .data
    ecnt dw 34h

section .bss
    dis_buffer resb 2

section .text
    global _start

_start:
    mov bx, word[ecnt]
    mov ecx, 2
    mov edi, dis_buffer

    Dup:
        rol bl, 4
        mov al, bl
        and al, 0Fh
        cmp al, 09h
        jbe Next
        add al, 07h

    Next:
        add al, 30h
        mov [edi], al
        inc edi
        loop Dup
    
    mov eax, 4
    mov ebx, 1
    mov ecx, dis_buffer
    mov edx, 2
    int 80h

    mov eax, 1
    int 80h
