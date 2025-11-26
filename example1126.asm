; ============================================
; FULL FIXED VERSION (NO REMOVALS, SAME ORDER)
; ============================================

section .data

vall:       dd 10000h
val2:       dd 48880h
val3:       dd 0
finalVal:   dd 0

msg:        db "Result (hex): 0x", 0
newline:    db 10, 0

section .bss
buffer:     resb 8        ; 8 hex digits

section .text
global _start

_start:

    ; Compute vall + val2 - val3
    mov eax, [vall]
    add eax, [val2]
    sub eax, [val3]
    mov [finalVal], eax

    ; Convert to hex string (8 hex digits)
    mov ebx, eax
    mov ecx, 8
    mov edi, buffer

convert_loop:
    mov eax, ebx
    and eax, 0x0F

    cmp eax, 9
    jle digit

    add eax, 55
    jmp store

digit:
    add eax, 48

store:
    mov [edi + ecx - 1], al
    shr ebx, 4

    loop convert_loop


; ==================================
; Print message: Result:
; ==================================
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 17
    int 80h

; ==================================
; Print the hex result
; ==================================
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 8
    int 80h

; ==================================
; Print newline
; ==================================
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

; ==================================
; Exit
; ==================================
    mov eax, 1
    mov ebx, 0
    int 80h
