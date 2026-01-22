; ============================================================
; PROGRAM: Graph Connectivity Checker using DFS
; ============================================================

global main
extern printf
extern scanf
extern exit

section .data
    prompt_n    db "Enter number of vertices: ", 0
    prompt_m    db "Enter adjacency matrix:", 10, 0

    scan_int    db "%d", 0

    msg_conn    db "Graph is CONNECTED", 10, 0
    msg_not     db "Graph is NOT CONNECTED", 10, 0

section .bss
    n           resd 1
    adj         resd 100        ; max 10x10
    visited     resb 10

section .text

; ------------------------------------------------------------
; dfs(int vertex)
; eax = vertex
; ------------------------------------------------------------
dfs:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi

    mov esi, eax
    mov byte [visited + esi], 1

    xor ecx, ecx               ; for each vertex

.loop:
    mov edx, [n]
    cmp ecx, edx
    jge .done

    ; adj[esi][ecx]
    mov eax, esi
    imul eax, [n]
    add eax, ecx
    mov ebx, [adj + eax*4]

    cmp ebx, 1
    jne .next

    cmp byte [visited + ecx], 1
    je .next

    push ecx
    mov eax, ecx
    call dfs
    pop ecx

.next:
    inc ecx
    jmp .loop

.done:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop ebp
    ret

; ------------------------------------------------------------
; main()
; ------------------------------------------------------------
main:
    ; printf("Enter number of vertices: ");
    push prompt_n
    call printf
    add esp, 4

    ; scanf("%d", &n);
    push n
    push scan_int
    call scanf
    add esp, 8

    ; printf("Enter adjacency matrix:\n");
    push prompt_m
    call printf
    add esp, 4

    ; Read adjacency matrix
    xor ecx, ecx                ; index

.read_matrix:
    mov eax, [n]
    imul eax, eax               ; n*n
    cmp ecx, eax
    jge .matrix_done

    push adj
    lea eax, [adj + ecx*4]
    push eax
    push scan_int
    call scanf
    add esp, 8

    inc ecx
    jmp .read_matrix

.matrix_done:
    ; Clear visited array
    xor eax, eax
    mov ecx, 10
    mov edi, visited
    rep stosb

    ; DFS from vertex 0
    xor eax, eax
    call dfs

    ; Check if all visited
    xor ecx, ecx

.check_loop:
    mov edx, [n]
    cmp ecx, edx
    jge .connected

    cmp byte [visited + ecx], 1
    jne .not_connected

    inc ecx
    jmp .check_loop

.connected:
    push msg_conn
    call printf
    add esp, 4
    jmp .exit

.not_connected:
    push msg_not
    call printf
    add esp, 4

.exit:
    push 0
    call exit
