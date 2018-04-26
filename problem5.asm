;
; Exercise 4
;
; 2520 is the smallest number that can be divided by each of the numbers from 1
; to 10 without any remainder.
;
; What is the smallest positive number that is evenly divisible by all of the
; numbers from 1 to 20?
;
; Note that this isn't optimized at all and an optimizing compiler will destroy
; this in terms of performance. e.g., up to 17 digits takes just under 2 seconds
; with this program, whereas an otimized C program takes 1/4 that amount of time
; at just under 500ms.
;


%define RANGETO 17

%macro test_and_store 1
    xor edx, edx
    mov rax, rbx
    mov ecx, %1
    div ecx
    xor eax, eax
    test dl, dl
    cmovz ax, r10w
    mov [factor+ecx], al
%endmacro

%macro test_and_store_comp 3
    mov al, factor[%1]
    and al,  factor[%2]
    mov factor[%3], al
%endmacro


section .bss
    factor   resb   RANGETO + 1

section .text
    extern printf
    global main


; Registers:
;   rbx: current number being tested

main:
    push rbp
    mov rbp, rsp

    ;mov ebx, RANGETO+1      ; start from
    mov ebx, 2520
    ;mov ebx, 232792560
    mov eax, ebx
    ; mov ecx, 3              ; start at first test after 2

    mov r10w, 1

.loop
    bt bx, 0                ; test 2
    setnc factor[2]

    test_and_store 3
    test_and_store 4
    test_and_store 5
    test_and_store 7
    test_and_store 8
    test_and_store 9
    test_and_store 11
    test_and_store 12
    test_and_store 13
    test_and_store 16
    test_and_store 17
    test_and_store 19
    test_and_store 20


    ; composite numbers based on previous tests
.composites:
    test_and_store_comp 2, 3, 6     ; 6 = 2 | 3
    test_and_store_comp 2, 5, 10    ; 10 = 2 | 5
    test_and_store_comp 2, 7, 14    ; 14 = 2 | 7
    test_and_store_comp 3, 5, 15    ; 15 = 3 | 5
    test_and_store_comp 2, 9, 18    ; 18 = 2 | 9

    ; test factor array for completed value
    ;mov edx, RANGETO

    mov edx, 2
    xor r8d, r8d

.counterloop:
    add r8b, byte [factor+rdx]
    inc rdx
    cmp rdx, RANGETO
    jle .counterloop

    cmp r8b, RANGETO - 1
    je .done

    ;jl .loop
    mov cl, 3              ; start at first test after 2
    inc rbx
    jmp .loop

.done:
    section .rodata
    .donemsg db "Yay! %llu is the number!", 10, 0
    section .text

    lea rdi, [.donemsg]
    mov rsi, rbx
    xor eax, eax
    call printf

    leave
    ret

