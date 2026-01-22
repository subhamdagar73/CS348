; ============================================================
; PROGRAM: Binary Palindrome Checker
; ============================================================

global main
extern printf
extern scanf
extern exit

section .data
    prompt          db "Enter a decimal number: ", 0
    scan_fmt        db "%d", 0

    pal_msg         db "Binary is a palindrome", 10, 0
    not_pal_msg     db "Binary is NOT a palindrome", 10, 0

section .bss
    num     resd 1

section .text

main:
    ; printf("Enter a decimal number: ");
    push prompt
    call printf
    add esp, 4

    ; scanf("%d", &num);
    push num
    push scan_fmt
    call scanf
    add esp, 8

    ; eax = num
    mov eax, [num]
    mov ebx, eax        ; save original
    xor ecx, ecx        ; reversed binary accumulator

reverse_loop:
    test eax, eax
    jz compare

    shl ecx, 1
    mov edx, eax
    and edx, 1
    or ecx, edx
    shr eax, 1
    jmp reverse_loop

compare:
    cmp ebx, ecx
    jne not_palindrome

palindrome:
    push pal_msg
    call printf
    add esp, 4
    jmp done

not_palindrome:
    push not_pal_msg
    call printf
    add esp, 4

done:
    push 0
    call exit
