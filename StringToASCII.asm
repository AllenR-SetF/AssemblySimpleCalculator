section .data
    msg1 db 'Please enter a String: ', 0 ; Define some Strings(0- nunll terminator)
    msg1_len equ $ - msg1

    msg2 db 'The ascii number for each letter is:', 10, 0 ; Define some Strings (10 - ASCII value) (0- nunll terminator)
    msg2_len equ $ - msg2

    space db ' ', 0s OS the System Function ; Define some Strings (0- nunll terminator)
    newline db 10, 0        ; Define some Strings (10 - ASCII value) (0- nunll terminator)

section .bss
    input1 resb 255        ; buffer for user input
    numStr resb 4          ; max 3 digits + null

section .text
    global _start

_start:
    ; ---- Print prompt ----
    mov rax, 1      ; System function (output)
    mov rdi, 1      ; Tells OS the System Function 
    mov rsi, msg1   ; Points to the msg1
    mov rdx, msg1_len ; Length of msg1
    syscall

    ; ---- Read input ----
    mov rax, 0      ; System Function (input)
    mov rdi, 0      ; Tells OS the System Function
    mov rsi, input1 ; Points to the input1
    mov rdx, 255    ; Length of input
    syscall

    ; ---- Print newline ----
    mov rax, 1      ; System function (output)
    mov rdi, 1      ; Tells OS the System Function 
    mov rsi, newline    ; Points to the newline
    mov rdx, 1      ; Length of message
    syscall

    ; ---- Print header ----
    mov rax, 1      ; System function (output)
    mov rdi, 1      ; Tell
    mov rsi, msg2   ; Points to the msg2
    mov rdx, msg2_len    ; Length of msg2
    syscall

    xor rbx, rbx        ; index = 0

convert_loop:
    mov al, [input1 + rbx]   ; load next char
    cmp al, 10               ; stop at newline
    je done
    cmp al, 0
    je done

    movzx rax, al            ; ASCII value in RAX
    mov rsi, numStr + 3      ; end of buffer
    mov byte [rsi], 0        ; null terminator
    mov r10, rsi             ; pointer for digits

    mov rcx, 10              ; divisor

decimal_loop:
    xor rdx, rdx             ; clear remainder
    div rcx                  ; RAX / 10
    add dl, '0'              ; convert remainder to ASCII
    dec r10                  ; move to previous character
    mov [r10], dl            ; store ASCII digit
    test rax, rax            ; if quotient != 0
    jnz decimal_loop         ; continue loop

    ; ---- Print number ----
    mov rax, 1               ; System function (output)
    mov rdi, 1               ; Tells OS the System Function 
    mov rsi, r10             ; pointer to start of digits
    mov rdx, numStr + 3      ; length of numStr + 3
    sub rdx, r10             ; length = end - start
    syscall

    ; ---- Print space ----
    mov rax, 1               ; System function (output)
    mov rdi, 1               ; Tells OS the System Function
    mov rsi, space           ; pointer to the space
    mov rdx, 1               ; Length of space
    syscall

    inc rbx                  ; next character
    jmp convert_loop

done:
    ; ---- Print newline ----
    mov rax, 1      ; System function (output)
    mov rdi, 1      ; Tells OS the System Function 
    mov rsi, newline    ; Points to the newline
    mov rdx, 1      ; Length of message
    syscall

    ; ---- Exit program ----
    mov rax, 60
    xor rdi, rdi
    syscall


