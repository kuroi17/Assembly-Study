global main
extern printf

section .data
    fmt db "Result = %d", 10, 0  ; printf format with newline
    num1 dq 5
    num2 dq 7

section .text
main:
    mov rax, [num1]
    add rax, [num2]
    mov rsi, rax      ; 1st argument to printf
    lea rdi, [fmt]    ; format string
    xor rax, rax      ; rax = 0 (printf requirement)
    call printf
    xor rax, rax
    ret
; This program adds two numbers (5 and 7) and prints the result using printf.
