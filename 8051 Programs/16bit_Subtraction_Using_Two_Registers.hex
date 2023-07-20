; Clear the Carry flag to ensure there is no carry from previous operations
clr c

; Subtract the value of R6 from the value of R4 and store the result in the accumulator (A)
mov A, r4
sub A, r6

; Store the result of the subtraction (lower byte) in memory location 20h
mov 20h, A

; Subtract the value of R7 from the value of R5 and store the result in the accumulator (A)
mov A, r5
sub A, r7

; Store the result of the subtraction (higher byte) in memory location 21h
mov 21h, A