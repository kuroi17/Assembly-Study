global main
section .data
    msg db "Hello, World!", 0Ah   ; message with newline

section .text
    global _start

_start:
    mov rax, 1        ; sys_write
    mov rdi, 1        ; stdout
    mov rsi, msg
    mov rdx, 14       ; length of message
    syscall

    mov rax, 60       ; sys_exit
    xor rdi, rdi
    syscall

