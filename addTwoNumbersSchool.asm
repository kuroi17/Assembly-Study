section .data
    num1 db 2
    num2 db 3
    msg db "The sum is: ", 0
    newline db 10, 0

    section .bss
    result resb 4

    section .text
    global _start

_start:
mov eax, [num1]
add eax, [num2]
add eax, '0'
mov [result], al

mov eax, 4
mov ebx, 1
mov ecx, msg
mov edx, 13
int 0x80

mov eax, 4
mov ebx, 1
mov ecx, result
mov edx, 1
int 0x80

mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 0x80

mov eax, 1
xor ebx, ebx
int 0x80
; This program adds two single-digit numbers (2 and 3) and prints the result.
