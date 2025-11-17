section .text
    global _start

_start:

    ; Print msg1
    mov ecx, msg1
    mov edx, len1
    call print_msg

    ; Print msg2
    mov ecx, msg2
    mov edx, len2
    call print_msg

    ; Print msg3
    mov ecx, msg3
    mov edx, len3
    call print_msg

    ; Exit program
    mov eax, 1       ; sys_exit
    xor ebx, ebx     ; exit code 0
    int 80h

print_msg:
    mov eax, 4       ; sys_write
    mov ebx, 1       ; stdout
    int 80h
    ret


section .data
    msg1 db "Welcome to Assembly Programming!", 0Ah
    len1 equ $ - msg1

    msg2 db "Assembly Programming is fun!", 0Ah
    len2 equ $ - msg2

    msg3 db "You're an Assembly Programming genius!", 0Ah
    len3 equ $ - msg3
