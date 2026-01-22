; ============================================================
; PROGRAM: Transpose of an N x N Matrix
; ============================================================

global main
extern printf
extern scanf
extern exit

section .data
    prompt_n    db "Enter matrix size N: ", 0
    prompt_m    db "Enter matrix elements:", 10, 0

    fmt_int     db "%d", 0
    fmt_print   db "%d ", 0
    fmt_nl      db 10, 0

section .bss
    n       resd 1
    mat     resd 100        ; max 10x10
    trans   resd 100

section .text

main:
    ; printf("Enter matrix size N: ");
    push prompt_n
    call printf
    add esp, 4

    ; scanf("%d", &n);
    push n
    push fmt_int
    call scanf
    add esp, 8

    ; printf("Enter matrix elements:\n");
    push prompt_m
    call printf
    add esp, 4

    ; Read matrix elements
    xor ecx, ecx            ; index = 0
.read_matrix:
    mov eax, [n]
    imul eax, eax           ; n*n
    cmp ecx, eax
    jge .transpose

    lea eax, [mat + ecx*4]
    push eax
    push fmt_int
    call scanf
    add esp, 8

    inc ecx
    jmp .read_matrix

.transpose:
    xor esi, esi            ; i = 0

.outer:
    mov eax, [n]
    cmp esi, eax
    jge .print_result

    xor edi, edi            ; j = 0
.inner:
    mov eax, [n]
    cmp edi, eax
    jge .next_row

    ; trans[j][i] = mat[i][j]
    mov eax, esi
    imul eax, [n]
    add eax, edi
    mov ebx, [mat + eax*4]

    mov eax, edi
    imul eax, [n]
    add eax, esi
    mov [trans + eax*4], ebx

    inc edi
    jmp .inner

.next_row:
    inc esi
    jmp .outer

.print_result:
    xor esi, esi

.print_outer:
    mov eax, [n]
    cmp esi, eax
    jge .exit

    xor edi, edi
.print_inner:
    mov eax, [n]
    cmp edi, eax
    jge .newline

    mov eax, esi
    imul eax, [n]
    add eax, edi
    push dword [trans + eax*4]
    push fmt_print
    call printf
    add esp, 8

    inc edi
    jmp .print_inner

.newline:
    push fmt_nl
    call printf
    add esp, 4

    inc esi
    jmp .print_outer

.exit:
    push 0
    call exit
