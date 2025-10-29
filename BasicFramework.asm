section .data
msg1 db 'Please enter the first number: ', 0
msg1_len equ $-msg1

msg2 db 'Please enter the second number: ', 0
msg2_len equ $-msg2

msg3 db 'The sum num is: ', 0
msg3_len equ $-msg3

msg4 db 'The dif num is: ', 0
msg4_len equ $-msg4

msg5 db 'The mul num is: ', 0
msg5_len equ $-msg5

msg6 db 'The div num is: ', 0
msg6_len equ $-msg6

newline db 10, 0

section .bss
input1 resb 255
input2 resb 255

section .text
global _start

_start:
     ; ---- print msg1 ----
    mov rax, 1          ; sys_write
    mov rdi, 1          ; STDOUT
    mov rsi, msg1
    mov rdx, msg1_len         ; length of msg1
    syscall

    ; ---- read first input ----
    mov rax, 0          ; sys_read
    mov rdi, 0          ; STDIN
    mov rsi, input1
    mov rdx, 255
    syscall

    ; ---- print newline ----
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; ---- print msg2 ----
    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, msg2_len        ; length of msg2
    syscall

    ; ---- read second input ----
    mov rax, 0
    mov rdi, 0
    mov rsi, input2
    mov rdx, 255
    syscall

    ; ---- print newline ----
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; ---- print first number ----
    mov rax, 1
    mov rdi, 1
    mov rsi, msg3
    mov rdx, msg3_len
    syscall

    ; find length of first input
    mov rcx, input1
    xor rdx, rdx
print_len_loop1:
    cmp byte [rcx+rdx], 10
    je print_len_done1
    inc rdx
    cmp rdx, 255
    je print_len_done1
    jmp print_len_loop1
print_len_done1:
    mov rax, 1
    mov rdi, 1
    mov rsi, input1
    syscall

    ; ---- print newline ----
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; ---- print second number ----
    mov rax, 1
    mov rdi, 1
    mov rsi, msg4
    mov rdx, msg4_len
    syscall

    ; find length of second input
    mov rcx, input2
    xor rdx, rdx
print_len_loop2:
    cmp byte [rcx+rdx], 10
    je print_len_done2
    inc rdx
    cmp rdx, 255
    je print_len_done2
    jmp print_len_loop2
print_len_done2:
    mov rax, 1
    mov rdi, 1
    mov rsi, input2
    syscall

    ; ---- print newline ----
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

     ; ---- print third number ----
    mov rax, 1
    mov rdi, 1
    mov rsi, msg5
    mov rdx, msg5_len
    syscall

    ; ---- print newline ----
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

     ; ---- print fourth number ----
    mov rax, 1
    mov rdi, 1
    mov rsi, msg6
    mov rdx, msg6_len
    syscall

    ; ---- print newline ----
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; ---- exit ----
    mov rax, 60         ; sys_exit
    xor rdi, rdi
    syscall
