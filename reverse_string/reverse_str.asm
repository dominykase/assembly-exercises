section .data
    newLine db 10
    prompt db "Enter a string:",10
    promptLen equ $-prompt
    prompt2 db "Your string reversed:",10
    prompt2Len equ $-prompt2

section .bss
    buffer resb 64

section .text
    global _start

_start:
; print prompt
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, promptLen
    syscall
; read input
    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 64
    syscall
; print prompt2
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt2
    mov rdx, prompt2Len
    syscall
; traverse the list to its end (and find its length)
    mov rbx, buffer
    xor rcx, rcx
    mov rcx, 0

length_loop:
    cmp byte [rbx], 0
    je end_length_loop
    inc rbx
    inc rcx
    jmp length_loop

end_length_loop:
    dec rbx
    dec rcx
    cmp byte [rbx], 10
    je skip_newline
    jmp reverse_string_loop

skip_newline:
    dec rbx

; traverse list from the end to the beginning and print each character
reverse_string_loop:
    cmp rcx, 0
    jle end_reverse_string_loop

    push rcx

    ; print character
    mov rax, 1
    mov rdi, 1
    mov rsi, rbx
    mov rdx, 1
    syscall

    dec rbx
    pop rcx
    dec rcx
    jmp reverse_string_loop

end_reverse_string_loop:
    ; print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newLine 
    mov rdx, 1
    syscall

; end program
    mov rax, 60
    mov rdi, 0
    syscall
