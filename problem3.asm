;
; Problem 3: Largest prime factor
;
; The prime factors of 13195 are 5, 7, 13 and 29.
; What is the largest prime factor of the number 600851475143?
;


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

    nop                 ; for gdb


;; Square root is stored in rcx


    mov r8, rcx         ; store the square root in r8 so we can count up to it
    mov rcx, 1          ; clear rx to count up

.primeloop
    mov rax, rbx        ; reset rax from div operation
    xor edx, edx        ; clear edx for division

    inc rcx             ; text next higher number
    div rcx             ; divide

    test rdx, rdx       ; text remainder for 0
    cmovz rbx, rax      ; if remainder is 0, we found a factor,
                        ; so the product is the new test 

    cmp rbx, 1          ; if our product is 1, we're done
    je .end

    cmp rcx, r8         ; next iteration if we're not to the root of the
                        ; original number
    jl .primeloop

.end
    mov [lcfp], rcx     ; store the greatest prime factor

    nop                 ; for gdb
