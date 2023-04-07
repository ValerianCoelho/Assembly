section	.data
    array db 1, 2, 3, -4, -5, 6, 7, -8 ,9 ,10

    posMsg db 'Positive Numbers Count : '
    lenPosMsg equ $ - posMsg

    negMsg db	'Negative Numbers Count : '
    lenNegMsg equ $ - negMsg

    newline db '', 13, 10
    lennewline equ $-newline

section .bss
    posNo resb 1
    negNo resb 1

section	.text
	global _start

_start:                  
        mov cl, 0 ;cl will hold the count of negative numbers, and the count of positive numbers will be calculated by subtracting cl from the size of the array
        mov dl, 10 ;dl stores the size of the array, dl will be decremented after every iteration
        mov esi, array ;esi will point to the address of the elements of the array

 		call next
        
        mov al, 10 ;10 is the size of the array
        sub al, cl ;No_of_positive_nos = size_of_array - No_of_negative_nos
        add al, '0'
        mov [posNo], al
        add cl, '0'
   		mov [negNo], cl
        
        ;Displaying Message 'Negative Numbers Count : '
        mov eax, 4
        mov ebx, 1
        mov ecx, negMsg
        mov edx, lenNegMsg
        int 80h
        
        ;Displaying the count of negative numbers
        mov eax, 4
        mov ebx, 1
        mov ecx, negNo
        mov edx, 1
        int 80h
        
        ;Displaying a new line
        mov eax, 4
        mov ebx, 1
        mov ecx, newline
        mov edx, lennewline
        int 80h
        
        ;Displaying Message 'Positive Numbers Count : '
        mov eax, 4
        mov ebx, 1
        mov ecx, posMsg
        mov edx, lenPosMsg
        int 80h
        
        ;Displaying the count of positive numbers
        mov eax, 4
        mov ebx, 1
        mov ecx, posNo
        mov edx, 1
        int 80h
        
        mov eax, 1
        int 80h
        
    next : 
        mov al, [esi]
        inc esi
        dec dl

        rcl al, 1
        jc negative ;If the MSB is 1; then number is negative
        
        jnz next ;Jump next if value of dl is not zero
        ret
        
    negative : 
        inc cl
        jnz next ;Jump next if value of dl is not zero
        ret