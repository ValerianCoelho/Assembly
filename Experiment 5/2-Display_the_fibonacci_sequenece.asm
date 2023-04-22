section .data
    msg db "Enter the value of n: "
    msgLen equ $ - msg

    space db " "
    spaceLen equ $ - space

section .bss
    ; Define variables to hold two 5-byte integers
    num1 resw 5
    num2 resw 5

    ; Define a variable to hold a single byte value for n
    n resb 1

    ; Define a temporary variable to hold a 2-byte value
    temp resw 2

    ; Define a buffer to hold the ASCII representation of a hexadecimal value
    dis_buffer resb 2

%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro read 2
    mov eax, 3
    mov ebx, 0
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro fibo 1
    mov eax, 0     ; First number in Fibonacci sequence
    mov ebx, 1     ; Second number in Fibonacci sequence
    mov ecx, [%1]  ; The number n

back:
    ; Storing the value of eax in edx to perform the addition
    mov edx, eax
    ; Adding the previous two elements
    add edx, ebx
    ; Storing the value of eax in temp to print it
    mov [temp], eax
    ; Pushing all the values to the stack so that we can print the temp value
    pusha
    ; The value from temp will be converted from hexadecimal to ASCII and stored in dis_buffer
    JMP hexadecimal_to_ascii

done:
    ; Displaying the element of the Fibonacci sequence on the console
    write dis_buffer, 2
    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, spaceLen
    int 80h
    popa
    ; Updating the value of eax to ebx
    mov eax, ebx
    ; Updating the value of ebx to edx
    mov ebx, edx
    dec ecx
    jnz back
%endmacro

section .text
global _start

_start:
    write msg, msgLen
    read num1, 2
    CALL ascii_to_hexadecimal_to_ascii
    mov [num1], ebx
    fibo num1
    mov eax, 1
    int 80h

; This function converts a two-digit ASCII string to its corresponding hexadecimal value 
; and stores it in another buffer in hexadecimal format.

ascii_to_hexadecimal_to_ascii:
    ; Set up the source and destination pointers
    mov esi, num1
    mov edi, num2
    
    ; Set up a loop counter and two working registers to zero
    mov ecx, 02h
    xor eax, eax
    xor ebx, ebx

up:
    ; Shift the content of BL by 4 bits to the left
    rol bl, 04h
    
    ; Load the next ASCII character from the source buffer
    mov al, [esi]
    
    ; Check if the character is between '0' and '9'
    cmp al, 39h
    jbe skipe
    
    ; If it's not, subtract 7 to get the value of 'A' to 'F'
    sub al, 07h

skipe:
    ; Subtract 30h to get the hexadecimal value of the character
    sub al, 30h
    
    ; Add the value to the working register BL
    add bl, al
    
    ; Store the value of BL in the destination buffer
    mov [edi], bl
    
    ; Increment the source and destination pointers
    inc esi
    inc edi
    
    ; Decrement the loop counter
    loop up
    
    ; Return to the calling function
    ret


hexadecimal_to_ascii:
    ; Move the value stored in temp into bx
    mov bx, word[temp]

    ; Set the counter to 2 and the destination index to the start of dis_buffer
    mov ecx, 2
    mov edi, dis_buffer

DUP:
    ROL bl, 4
    mov al, bl
    AND al, 0Fh
    CMP al, 09h
    JBE NEXT
    add al, 07h
NEXT:
    ADD al, 30h
    mov [edi], al
    INC edi
    ; Decrement the counter and loop if it is greater than 0
    LOOP DUP
    ; Jump to the end of the function
    JMP done


