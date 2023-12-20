section .data
    newLine db 10

section .bss
    numberBuffer resb 32

section .text
    global _start

_start:
    mov rax, 42
    mov rbx, numberBuffer
    call print_positive_32bit_integer

; end program
    mov rax, 60
    mov rdi, 0
    syscall

; rax - number to print, rbx - numberBuffer variable
print_positive_32bit_integer:    
    push rax
    mov rcx, 0
    call find_positive_32bit_integer_length
    
    inc rcx
    add rbx, rcx
    mov byte [rbx], 0
    dec rbx

    pop rax
    push rcx
    mov rcx, rax

    cmp rcx, 0
    je write_number_done_zero

    write_number_loop:
    cmp rcx, 0
    jle write_number_done
    
    mov rax, rcx
    mov r8, 10
    div r8
    add rdx, '0'
    mov byte [rbx], dl
    dec rbx
    xor rdx, rdx

    mov rcx, rax
    jmp write_number_loop

    write_number_done_zero:
    mov byte [rbx], '0'

    write_number_done:

    mov rax, 1
    mov rdi, 1
    mov rsi, numberBuffer
    pop rdx
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, newLine
    mov rdx, 1
    syscall

    ret

; rax - number to find length of
find_positive_32bit_integer_length:
    cmp rax, 0
    je find_integer_length_done_zero

    find_interger_length_loop:
    xor rdx, rdx
    cmp rax, 0
    jle find_integer_length_done
    
    mov r8, 10
    div r8
    inc rcx

    jmp find_interger_length_loop

    find_integer_length_done_zero:
    inc rcx

    find_integer_length_done:
    ret
