section .data
    inputMsg db 'Enter an uppercase alphabet : '
    inputMsgLen equ $-inputMsg
    
    errorMsg db 'The Character entered is neither uppercase nor lowercase', 13, 10
    lenErrorMsg equ $-errorMsg
    
    invalidMsg db 'The Character entered is not uppercase', 13, 10
    lenInvalidMsg equ $-invalidMsg
    
    newline db '', 13, 10
    lenNewline equ $-newline

section .bss
    lowercase resb 2
    uppercase resb 2

section .text
    global _start

_start:
    ;Displaying Message 'Enter an uppercase alphabet : '
    mov eax, 4
    mov ebx, 1
    mov ecx, inputMsg
    mov edx, inputMsgLen
    int 80h

    ;Accepting character
    mov eax, 3
    mov ebx, 0
    mov ecx, uppercase
    mov edx, 1
    int 80h

    mov eax, [uppercase]
    
    ;If the ascii code of the entered character is less than 65, then input is erroneus
    cmp eax, 'A'
    jb error
    
    ;If the ascii code of the entered character is greater than 122, then input is erroneus
    cmp eax, 'z'
    ja error
    
    ;If the ascii code of the entered character is above (97-1), then the entered character is lowercase; hence invalid
    cmp eax, 'a'
    ja invalid
    
    call upperToLower
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, lenNewline
    int 80h
    
    jmp exit

    upperToLower:
        ;Converting uppercase to lowercase
        add eax, 32
        mov [lowercase], eax

        mov eax, 4
        mov ebx, 1
        mov ecx, lowercase
        mov edx, 1
        int 80h
        ret

    error:
        ;Displaying Message 'The Character entered is neither uppercase nor lowercase'
        mov eax, 4
        mov ebx, 1
        mov ecx, errorMsg
        mov edx, lenErrorMsg
        int 80h
        jmp exit
        
    invalid:
        ;Displaying Message 'The Character entered is not uppercase'
        mov eax, 4
        mov ebx, 1
        mov ecx, invalidMsg
        mov edx, lenInvalidMsg
        int 80h
        jmp exit
        
    exit:
        mov eax, 1
        int 80h
