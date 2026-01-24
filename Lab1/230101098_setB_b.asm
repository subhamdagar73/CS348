; ============================================================
; PROGRAM: Transpose of an N x N Matrix (Human-Optimized)
; QUESTION: Set B - Question 6
; ============================================================

global main
extern printf, scanf, exit

section .data
    prompt_n    db "Enter matrix size N (1-10): ", 0
    prompt_m    db "Enter %d elements:", 10, 0
    fmt_int     db "%d", 0
    fmt_print   db "%d ", 0
    fmt_nl      db 10, 0

section .bss
    n           resd 1
    mat         resd 100    ; Original matrix (max 10x10)
    trans       resd 100    ; Transposed result

section .text

main:
    ; --- Get Matrix Size ---
    push prompt_n
    call printf
    add esp, 4

    push n
    push fmt_int
    call scanf
    add esp, 8

    ; Validation: N must be between 1 and 10
    mov ecx, [n]
    cmp ecx, 1
    jl .exit
    cmp ecx, 10
    jg .exit

    ; --- Get Matrix Elements ---
    ; Calculate total elements (N*N) for the prompt
    mov eax, ecx
    imul eax, ecx           ; EAX = total elements
    
    push eax
    push prompt_m
    call printf
    add esp, 8

    ; Read exactly N*N elements into 'mat'
    xor ebx, ebx            ; EBX = current element index
    mov edx, [n]
    imul edx, edx           ; EDX = limit (N*N)

.read_loop:
    cmp ebx, edx
    jge .do_transpose

    lea eax, [mat + ebx*4]
    push edx                ; Save limit
    push ebx                ; Save index
    push eax
    push fmt_int
    call scanf
    add esp, 8
    pop ebx                 ; Restore index
    pop edx                 ; Restore limit
    
    inc ebx
    jmp .read_loop

    ; --- Transpose Logic ---
    ; Logic: trans[j][i] = mat[i][j]

.do_transpose:
    xor esi, esi            ; esi = i (row counter)
.outer:
    cmp esi, [n]
    jge .print_result
    
    xor edi, edi            ; edi = j (column counter)
.inner:
    cmp edi, [n]
    jge .next_row

    ; Calculate source address: mat + (i * N + j) * 4
    mov eax, esi
    imul eax, [n]
    add eax, edi
    mov ebx, [mat + eax*4]

    ; Calculate dest address: trans + (j * N + i) * 4
    mov eax, edi
    imul eax, [n]
    add eax, esi
    mov [trans + eax*4], ebx

    inc edi
    jmp .inner
.next_row:
    inc esi
    jmp .outer

    ; --- Print Result ---
.print_result:
    xor esi, esi            ; Row counter
.p_outer:
    cmp esi, [n]
    jge .exit

    xor edi, edi            ; Col counter
.p_inner:
    cmp edi, [n]
    jge .p_newline

    ; Print trans[esi][edi]
    mov eax, esi
    imul eax, [n]
    add eax, edi
    
    push dword [trans + eax*4]
    push fmt_print
    call printf
    add esp, 8

    inc edi
    jmp .p_inner
.p_newline:
    push fmt_nl
    call printf
    add esp, 4
    inc esi
    jmp .p_outer

.exit:
    push 0
    call exit
