section .data
    msg1 db 'Please enter a String: ', 0 
    msg1_len equ $ - msg1

    msg2 db 'The ascii number for each letter is:', 10, 0 
    msg2_len equ $ - msg2

    space db ' ', 0
    newline db 10, 0       

section .bss
    input1 resb 255       
    numStr resb 4          

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

    xor rbx, rbx       

convert_loop:
    mov al, [input1 + rbx]   
    cmp al, 10             
    je done
    cmp al, 0
    je done

    movzx rax, al            
    mov rsi, numStr + 3     
    mov byte [rsi], 0       
    mov r10, rsi            

    mov rcx, 10             

decimal_loop:
    xor rdx, rdx            
    div rcx                
    add dl, '0'             
    dec r10                 
    mov [r10], dl           
    test rax, rax            
    jnz decimal_loop         

    ; ---- Print number ----
    mov rax, 1              
    mov rdi, 1               
    mov rsi, r10            
    mov rdx, numStr + 3      
    sub rdx, r10             
    syscall

    ; ---- Print space ----
    mov rax, 1               
    mov rdi, 1               
    mov rsi, space          
    mov rdx, 1               
    syscall

    inc rbx                  
    jmp convert_loop

done:
    ; ---- Print newline ----
    mov rax, 1      
    mov rdi, 1      
    mov rsi, newline    
    mov rdx, 1      
    syscall

    ; ---- Exit program ----
    mov rax, 60
    xor rdi, rdi
    syscall


