mov dptr, #0FF00h ; Load the address 0xFF00h into the Data Pointer (DPTR) register
movx A, @dptr     ; Move the data from the external memory location pointed by DPTR into the accumulator (A) register
mov r0, 0FFh      ; Save the content of the accumulator (A) into the R0 register as a temporary storage
mov 0FFh, A       ; Write the value 0xFF from the accumulator (A) into the external memory location 0xFFh
mov A, r0         ; Retrieve the previously saved value from R0 and move it into the accumulator (A)
movx @dptr, A     ; Move the data in the accumulator (A) back to the external memory location pointed by DPTR
