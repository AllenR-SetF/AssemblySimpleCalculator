section .data
    msg1 db 'Please enter a String: ', 0
    msg1_len equ $ - msg1

    msg2 db 'The ascii number for each letter is:', 10, 0
    msg2_len equ $ - msg2

    space db ' ', 0
    newline db 10, 0

section .bss
    input1 resb 255        ; buffer for user input
    numStr resb 4          ; max 3 digits + null

section .text
    global _start

_start:
    ; ---- Print prompt ----
    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, msg1_len
    syscall

    ; ---- Read input ----
    mov rax, 0
    mov rdi, 0
    mov rsi, input1
    mov rdx, 255
    syscall

    ; ---- Print newline ----
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; ---- Print header ----
    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, msg2_len
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
    mov rax, 1
    mov rdi, 1
    mov rsi, r10             ; pointer to start of digits
    mov rdx, numStr + 3
    sub rdx, r10             ; length = end - start
    syscall

    ; ---- Print space ----
    mov rax, 1
    mov rdi, 1
    mov rsi, space
    mov rdx, 1
    syscall

    inc rbx                  ; next character
    jmp convert_loop

done:
    ; ---- Print final newline ----
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; ---- Exit program ----
    mov rax, 60
    xor rdi, rdi
    syscall


