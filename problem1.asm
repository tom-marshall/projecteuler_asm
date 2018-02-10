;
; If we list all the natural numbers below 10 that are multiples of 3 or 5, we
; get 3, 5, 6 and 9. The sum of these multiples is 23.
;
; Find the sum of all the multiples of 3 or 5 below 1000.
;
; Registers used:
;
; r8 - first divisor to check (3)
; r9 - second divisor to check (5)
; r10 - running sum
; rcx - number to check
; rdx - temporary (for division)
;

; section .data
    ; sum  dd  0          ; holds sum of digits

section .text
global _start


_start:
    mov rcx, 999        ; finding numbers less than 1000

    mov r8, 0x03        ; r8 will be used for testing 3 divisor
    mov r9, 0x05        ; r9 will be used for testing 5 divisor
    mov r10, 0          ; r10 will be used for storing sum

.while:
    mov rax, rcx        ; move number to test

    xor edx, edx        ; zero out high byte for divide
    div r8w             ; divide

    cmp edx, 0          ; see if our remainder is 0
    jg .whileor         ; if not, test for divisor of 5

    add r10, rcx        ; add to sum
    jmp .nextit

    ; -- test for 5 --

.whileor
    xor edx, edx        ; zero out high byte for divide

    mov rax, rcx        ; move number to edx
    div r9w             ; divide

    cmp edx, 0          ; see if our remainder is 0
    jg .nextit          ; if not, go to next iteration

    add r10, rcx        ; add to sum

.nextit
    dec rcx
    jnz .while

    nop

    mov eax, 1
    mov ebx, r10d

    int 80h

