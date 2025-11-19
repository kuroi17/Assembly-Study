section .data
    decimalVal   dd 25          ; decimal integer
    hexVal       dd 0x1A        ; hexadecimal
    charA        db 'A'         ; single character
    strConst     db "Assembly Language",0Ah  ; string + newline

section .text
    global _start

_start:
    ; do nothing, just exit
    mov rax, 60   ; sys_exit
    xor rdi, rdi  ; exit code 0
    syscall
