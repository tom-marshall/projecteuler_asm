;
; Problem 3: Largest prime factor
;
; The prime factors of 13195 are 5, 7, 13 and 29.
;
; What is the largest prime factor of the number 600851475143?
;
; whoaaaa, modulooooooo :P


section .data
    num:   dq   600851475143        ; number to test
    lcfp:  dq   0                   ; largest prime result

section .text
global _start


_start:
    xor eax, eax        ; rax is used for the multiplication
    xor ecx, ecx        ; rcx will hold the square root

    mov rbx, [num]      ; store our number for comparison in registers


.loop:
    inc rcx             ; step to the next number to test
    mov rax, rcx

    imul rax            ; square the number for testing
    cmp rax, rbx        ; and test

    jl .loop            ; if less, test the next higher number

    nop                 ; nothing to see here...


;; Square root is stored in rcx


    mov r8, rcx         ; store the square root in r8 so we can count up to it
    mov rcx, 1          ; clear rx to count up

.primeloop
    mov rax, rbx
    xor edx, edx

    inc rcx
    div rcx

    test rdx, rdx
    cmovz rbx, rax 

    cmp rbx, 1
    je .end

    cmp rcx, r8
    jl .primeloop

.end
    mov [lcfp], rcx

    nop

