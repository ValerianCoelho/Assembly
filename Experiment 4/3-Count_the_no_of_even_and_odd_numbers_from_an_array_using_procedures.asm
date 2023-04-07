section	.data
    array db 12, 27, 31, 45, 56, 61, 72, 89, 95, 98

    evenMsg db 'Even Numbers Count : '
    lenEvenMsg equ $ - evenMsg

    oddMsg db	'Odd Numbers Count : '
    lenOddMsg equ $ - oddMsg

    newline db '', 13, 10
    lennewline equ $-newline

section .bss
    evenNo resb 1
    oddNo resb 1

section	.text
	global _start

_start:                  
        mov cl, 0 ;cl will hold the count of odd numbers, and the count of even numbers will be calculated by subtracting cl from the size of the array
        mov dl, 10 ;dl stores the size of the array, dl will be decremented after every iteration
        mov esi, array ;esi will point to the address of the elements of the array

 		call next
        
        mov al, 10 ;10 is the size of the array
        sub al, cl ;No_of_even_nos = size_of_array - No_of_odd_nos
        add al, '0'
        mov [evenNo], al
        add cl, '0'
   		mov [oddNo], cl
        
        ;Displaying Message 'Odd Numbers Count : '
        mov eax, 4
        mov ebx, 1
        mov ecx, oddMsg
        mov edx, lenOddMsg
        int 80h
        
        ;Displaying the count of odd numbers
        mov eax, 4
        mov ebx, 1
        mov ecx, oddNo
        mov edx, 1
        int 80h
        
        ;Displaying a new line
        mov eax, 4
        mov ebx, 1
        mov ecx, newline
        mov edx, lennewline
        int 80h
        
        ;Displaying Message 'Even Numbers Count : '
        mov eax, 4
        mov ebx, 1
        mov ecx, evenMsg
        mov edx, lenEvenMsg
        int 80h
        
        ;Displaying the count of even numbers
        mov eax, 4
        mov ebx, 1
        mov ecx, evenNo
        mov edx, 1
        int 80h
        
        mov eax, 1
        int 80h
        
    next : 
        mov al, [esi]
        inc esi
        dec dl

        rcr al, 1
        jc odd ;If the LSB is 1; then number is odd
        
        jnz next ;Jump next if value of dl is not zero
        ret
        
    odd: 
        inc cl
        jnz next ;Jump next if value of dl is not zero
        ret