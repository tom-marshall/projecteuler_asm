;
; Problem 4
;
; A palindromic number reads the same both ways. The largest palindrome made
; from the product of two 2-digit numbers is 9009 = 91 × 99.
;
; Find the largest palindrome made from the product of two 3-digit numbers.
;

section .data


section .rodata
    largestfmt   db   "Largest pair: %d, %d", 10, 0


section .text
    global main
    extern printf

; Registers
;
; r12: current first number
; r13: current second number
; r14: largest of first numbers
; r15: largest of second numbers

main:
    mov r12, 5000

.outerloop:
    dec r12
    jz .done

    mov r13, r12

.innerloop:
    mov rdi, r12            ; first param is outer loop index
    mov rsi, r13            ; second param is outer loop index
    call is_palindromic

    test eax, eax           ; rax = 1 if it's a palindrome
    jz .nextit              ; if not, next iteration

    cmp r12d, r15d          ; test current outer index with largest inner
    jl .done                ; exit (this is an optimization)

    cmp r13d, r15d          ; test current inner index with largets inner
    jle .nextit             ; if greater than...

    mov r14d, r12d          ; then record the current outer
    mov r15d, r13d          ; and current inner as largest pair

.nextit:
    dec r13d                ; dec inner loop index
    jz .outerloop           ; jump to outer loop if inner is done

    jmp .innerloop          ; jump to inner loop

.done:
    lea rdi, [largestfmt]   ; larget pair format message
    mov rsi, r14            ; first of largest pair
    mov rdx, r15            ; second of largest pair
    xor eax, eax            ; no xmm registers used
    call printf             ; print it

    ret                     ;return


is_palindromic:
    sub rsp, 16

    mov rax, rdi            ; multiply our input numbers
    mul rsi                 ;
    ; imul rax, rdi, rsi

    mov ebx, 10             ; number to divide by
    xor ecx, ecx            ; loop counter

.loop1:                     ; stores all digits into memory starting at rsp
    xor edx, edx            ; clear edx for divide
    div eax, ebx            ; divide input by 10 to find modulus

    mov byte [rsp+rcx], dl  ; store this digit into stack pointer + rcx offset

    inc ecx                 ; increment count of total digits
    test eax, eax           ; test if we've completed all division
    jnz .loop1              ; if not, then loop back

    dec ecx                 ; counter for loop is 1 more than we need
    mov ebx, ecx            ; ebx is total number of digits, taken from ecx

    mov rdx, rcx            ; rdx is halfway point of array
    shr rdx, 1              ;   (i.e. n/2)

.loop2:                     ; checks digits for is palindrome
    mov r8, rsp             ; start at rsp
    add r8, rcx             ; move to last digit
    movzx r8, byte [r8]     ; store byte

    mov r9, rsp             ; start at rsp
    add r9, rbx             ; go to last digit - ecx
    sub r9, rcx
    movzx r9, byte [r9]     ; store byte

    cmp r8, r9
    jnz .notpalin

    dec rcx
    cmp rcx, rdx
    jnz .loop2

    mov rax, 1              ; we have made it here if we have a palindrome
    jmp .done

.notpalin:
    xor eax, eax

.done:
    add rsp, 16

    ret

