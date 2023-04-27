section .data
    msg1 db "Enter the number of elements :  "
    lenMsg1 equ $ - msg1
    
    msg2 db "Enter the elements in the array : "
    lenMsg2 equ $ - msg2
    
    msg3 db "The Elements are : "
    lenMsg3 equ $ - msg3

    space db " "
    lenSpace equ $ - space
    
    newline db 13, 10
    lenNewline equ $ - newline

section .bss
    array resb 7
    arraySize resb 1
    whitespace resb 1

%macro write 2
    pusha
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
    popa
%endmacro

%macro read 2
    pusha
    mov eax, 3
    mov ebx, 0
    mov ecx, %1
    mov edx, %2
    int 80h
    popa
%endmacro


section .text
    global _start:
    
_start:
    write msg2, lenMsg2
    mov ecx, 7
    mov edi, array
    
    input:
    	read edi, 1
    	read whitespace, 1
    	inc edi
    	dec ecx
    	jnz input
    	
    write msg3, lenMsg3
    mov ecx, 7
    mov esi, array
    
    output:
    	write esi, 1
    	write space, lenSpace
    	inc esi
    	dec ecx
    	jnz output
    
    mov eax, 1
    int 80h
