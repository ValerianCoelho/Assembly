section .data
    inputMessage db "Enter the number of terms (in hexadecimal): "
    inputMessageLen equ $ - inputMessage

    space db " "
    spaceLen equ $ - space

section .bss
    num resb 2 ; This will store the value of the number of terms
    hex_num resb 2 ; This will store each element of the fibonacci sequence
    ascii_buffer resb 2 ; This will be used to store the ascii string representation of the contents of hex_num

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

%macro fibonacci 1
    mov eax, 0 ; First number in Fibonacci sequence
    mov ebx, 1 ; Second number in Fibonacci sequence
    mov ecx, [%1] ; The number of terms

    next_term:
        mov edx, eax ; Storing the value of eax in edx to perform the addition
        add edx, ebx ; Adding the previous two elements
        mov [hex_num], eax ; Storing the value of eax in hex_num to print it
        pusha ; Pushing all the values to the stack so that we can print the hex_num value
        call convert_hex_to_ascii ; The value from hex_num will be converted from hexadecimal to ASCII and stored in ascii_buffer

        write ascii_buffer, 2 ; Displaying the element of the Fibonacci sequence on the terminal
        write space, spaceLen ; Displaying a white space
        popa

        mov eax, ebx ; Updating the value of eax to ebx
        mov ebx, edx ; Updating the value of ebx to edx
        dec ecx
        jnz next_term
%endmacro

section .text
    global _start

_start:
    write inputMessage, inputMessageLen ; Display the input message to the user.
    read num, 2 ; Read two ASCII characters from the user and store them in the 'num' variable.
    call convert_ascii_to_hex ; convert the input string to a hex value.
    mov [num], ebx ; Move the resulting hex value from the ebx(calculated in the above function) register to the 'num' variable.
    fibonacci num ; Display the fibonacci sequence up to 'num' terms
    mov eax, 1 ; Exit the program
    int 80h

convert_ascii_to_hex:
    mov esi, num ; Move the memory address of the num to the esi register.
    mov ecx, 02h ; Set the counter to 2, since we are working with 2 digit numbers
    xor eax, eax ; Clear the eax register.
    xor ebx, ebx ; Clear the ebx register.
    loop_start:
        rol bl, 04h ; Rotate the bits in the BL register left by 4 bits (i.e. one hex digit)
        mov al, [esi] ; Move the ASCII character at the current memory address to the AL register.
        cmp al, 39h ; Compare the character to the ASCII code for '9'.
        jbe skip_sub ; If it's less than or equal to '9', skip the subtraction step.
        sub al, 07h ; If the character is 'A'-'F', subtract 7 to convert it to a hex digit.
        skip_sub:
            sub al, 30h ; Subtract 30h to convert the character to its corresponding hex value
            add bl, al ; Add the resulting hex value to the BL register.
            inc esi ; Move to the next character in the input string (num).
            loop loop_start ; Decrement the counter and repeat the loop until we've processed both characters.
            ret ; Return to the calling function


convert_hex_to_ascii:
    mov bl, [hex_num] ; Move the value stored at hex_num to the BL register.
    mov cl, 2 ; Set the counter to 2, since we are working with 2 digit numbers
    mov edi, ascii_buffer ; Move the memory address of the output buffer to the EDI register.
    next_digit:
        rol bl, 4 ; Rotate the bits in the BL register left by 4 bits (i.e. one hex digit)
        mov al, bl ; Move the contents of bl to al
        and al, 0Fh ; Mask the upper 4 bits of the AL register to isolate the current digit.
        cmp al, 09h ; Compare the digit to the value 09h.
        jbe skip_add ; If it's less than or equal to 09h, skip the addition step.
        add al, 07h ; If the digit is greater than 09h, add 07h to convert it to an ASCII character in the range 'A'-'F'.
        skip_add:
            add al, 30h ; Add 30h to convert the digit to its corresponding ASCII character
            mov [edi], al ; Move the resulting ASCII character to the current position in the output buffer.
            inc edi ; Move to the next position in the output buffer.
            loop next_digit ; Decrement the counter and repeat the loop until we've processed both characters.
            ret ; Return to the calling function