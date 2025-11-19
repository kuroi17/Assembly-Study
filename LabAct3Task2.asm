section .data
result  dd 0          ; Variable to store the final result


section .text
global _start

_start:
; Load numbers
mov eax, 6
mov ebx, 3

; Compute (eax * ebx) + 10 - 4
mul ebx
add eax, 10
sub eax, 4

; Store result in memory
mov [result], eax

; Exit
mov eax, 60
xor edi, edi
syscall
