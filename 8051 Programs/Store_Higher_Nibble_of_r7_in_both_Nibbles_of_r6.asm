mov A, r7     ; Copy the content of R7 into the accumulator (A)
anl A, #0F0h  ; Apply a bitmask to the accumulator to extract the higher nibble (4 most significant bits) and set the lower nibble to zero
mov r6, A     ; Move the extracted higher nibble from the accumulator into R6
swap A        ; Swap the upper and lower nibbles of the accumulator
orl A, r6     ; Perform a logical OR operation between the swapped nibbles in the accumulator and the content of R6 This effectively duplicates the higher nibble of R7 into both nibbles of the accumulator
mov r6, A     ; Move the duplicated higher nibble from the accumulator back into R6
