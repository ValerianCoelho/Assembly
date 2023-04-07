section .data
    inputMsg db 'Enter a lowercase alphabet : '
    inputMsgLen equ $-inputMsg
    
    errorMsg db 'The Character entered is neither uppercase nor lowercase', 13, 10
    lenErrorMsg equ $-errorMsg
    
    invalidMsg db 'The Character entered is not lowercase', 13, 10
    lenInvalidMsg equ $-invalidMsg
    
    newline db '', 13, 10
    lenNewline equ $-newline

section .bss
    lowercase resb 2
    uppercase resb 2

section .text
    global _start

_start:
    ;Displaying Message 'Enter a lowercase alphabet : '
    mov eax, 4
    mov ebx, 1
    mov ecx, inputMsg
    mov edx, inputMsgLen
    int 80h

    ;Accepting character
    mov eax, 3
    mov ebx, 0
    mov ecx, lowercase
    mov edx, 1
    int 80h

    mov eax, [lowercase]
    
    ;If the ascii code of the entered character is less than 65, then input is erroneus
    cmp eax, 'A'
    jb error
    
    ;If the ascii code of the entered character is greater than 122, then input is erroneus
    cmp eax, 'z'
    ja error
    
    ;If the ascii code of the entered character is below (90+1), then the entered character is uppercase; hence invalid
    cmp eax, 'Z'
    jb invalid
    
    call lowToUpper
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, lenNewline
    int 80h
    
    jmp exit

    lowToUpper:
        ;Converting lowercase to uppercase
        sub eax, 32
        mov [uppercase], eax

        mov eax, 4
        mov ebx, 1
        mov ecx, uppercase
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
        ;Displaying Message 'The Character entered is not lowercase'
        mov eax, 4
        mov ebx, 1
        mov ecx, invalidMsg
        mov edx, lenInvalidMsg
        int 80h
        jmp exit
        
    exit:
        mov eax, 1
        int 80h
