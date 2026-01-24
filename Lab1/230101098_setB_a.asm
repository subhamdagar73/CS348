; ===================================================================
; PROGRAM: Graph Connectivity Checker using DFS
; QUESTION: Set B - Question 1
; ===================================================================

section .data
    prompt_n    db "Enter number of vertices: "
    prompt_n_l  equ $ - prompt_n

    prompt_m    db "Enter adjacency matrix:", 10
    prompt_m_l  equ $ - prompt_m

    msg_conn    db "Graph is CONNECTED", 10
    msg_conn_l  equ $ - msg_conn

    msg_not     db "Graph is NOT CONNECTED", 10
    msg_not_l   equ $ - msg_not

section .bss
    n           resd 1
    adj         resd 100
    visited     resb 10
    buf         resb 4

section .text
    global main

; Recursive DFS function to traverse graph
; Parameters: eax = current vertex
dfs:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi

    mov esi, eax
    mov byte [visited + esi], 1

    xor ecx, ecx

.loop:
    mov edx, [n]
    cmp ecx, edx
    jge .done

    ; Calculate adjacency matrix index
    mov eax, esi
    imul eax, [n]
    add eax, ecx
    mov ebx, [adj + eax*4]

    ; Check if edge exists and vertex not visited
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

main:
    ; Read number of vertices from user
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_n
    mov edx, prompt_n_l
    int 0x80

    ; Get vertex count input
    mov eax, 3
    mov ebx, 0
    mov ecx, buf
    mov edx, 4
    int 0x80

    ; Convert ASCII digit to integer
    movzx eax, byte [buf]
    sub eax, '0'
    mov [n], eax

    ; Prompt for adjacency matrix input
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_m
    mov edx, prompt_m_l
    int 0x80

    ; Read adjacency matrix elements
    xor edi, edi

.read_matrix:
    mov eax, 3
    mov ebx, 0
    mov ecx, buf
    mov edx, 1
    int 0x80

    test eax, eax
    jz .matrix_done

    movzx eax, byte [buf]

    ; Skip whitespace
    cmp al, ' '
    je .read_matrix
    cmp al, 10
    je .read_matrix
    cmp al, 13
    je .read_matrix

    ; Store matrix element
    sub eax, '0'
    mov [adj + edi*4], eax
    inc edi

    ; Check if matrix is complete
    mov ecx, [n]
    imul ecx, ecx
    cmp edi, ecx
    jl .read_matrix

.matrix_done:
    ; Clear visited array
    mov ecx, 10
    mov edi, visited
    xor eax, eax
    rep stosb

    ; Start DFS from vertex 0
    xor eax, eax
    call dfs

    ; Verify all vertices were visited
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
    ; Print connected message
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_conn
    mov edx, msg_conn_l
    int 0x80
    jmp .exit

.not_connected:
    ; Print not connected message
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_not
    mov edx, msg_not_l
    int 0x80

.exit:
    ; Terminate program
    mov eax, 1
    xor ebx, ebx
    int 0x80
