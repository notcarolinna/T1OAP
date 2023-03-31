section .data
    prompt db "Programa Ackermann", 0
    input_prompt db "Digite os parâmetros m e n para calcular A(m, n) ou -1 para abortar a execução", 0
    result_prompt db "A(%d, %d) = %d", 10, 0
    neg_error db "Erro: número negativo digitado", 10, 0
    m db 0
    n db 0

section .text
    extern printf
    global _start

_start:
    ; Imprime a mensagem inicial
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, 19
    syscall

input_loop:
    ; Imprime a mensagem de entrada
    mov rax, 1
    mov rdi, 1
    mov rsi, input_prompt
    mov rdx, 72
    syscall

    ; Lê o valor de m
    mov rax, 0
    mov rdi, 0
    mov rsi, m
    mov rdx, 2
    syscall

    ; Verifica se m é negativo
    cmp byte [m], '-'
    jne .input_n

    ; Sai do loop se o usuário digitou -1
    cmp byte [m + 1], '1'
    jne .end

    ; Termina o programa se o usuário digitou um número negativo diferente de -1
    mov rax, 1
    mov rdi, 1
    mov rsi, neg_error
    mov rdx, 30
    syscall
    jmp input_loop

.input_n:
    ; Lê o valor de n
    mov rax, 0
    mov rdi, 0
    mov rsi, n
    mov rdx, 2
    syscall

    ; Converte os valores de m e n para inteiros
    mov rax, 0
    mov rbx, 10
    mov rcx, m
    .convert_m:
        cmp byte [rcx], 0
        je .convert_n
        imul rax, rbx
        movzx edx, byte [rcx]
        sub edx, 48
        add rax, rdx
        inc rcx
        jmp .convert_m

    mov rdx, 0
    mov rcx, n
    .convert_n:
        cmp byte [rcx], 0
        je .call_ackermann
        imul rdx, rbx
        movzx eax, byte [rcx]
        sub eax, 48
        add rdx, rax
        inc rcx
        jmp .convert_n

.call_ackermann:
    ; Chama a função ackermann
    push rdx
    push rax
    call ackermann
    add rsp, 8

    ; Converte o resultado para uma string
    mov rax, rax
    push rax
    push rdx
    push rdi
    mov rdi, result_prompt
    mov rsi, rsp
    mov rax, 0
    call printf
    add rsp, 24

    ; Volta para o início do loop
    jmp input_loop

.end:
    ; Termina o programa
    mov rax, 60
    xor rdi, rdi
    syscall

; Função ackermann(m, n)
ackermann:
push rbp
mov rbp, rsp

; Cria espaço na pilha para as variáveis locais
sub rsp, 16

; Salva os valores de m e n na pilha
mov [rbp - 4], rdi
mov [rbp - 8], rsi

; Verifica se m é zero
cmp rdi, 0
jne .check_n

; Retorna n + 1 se m é zero
mov rax, rsi
add rax, 1
jmp .exit

.check_n:
; Verifica se n é zero
cmp rsi, 0
jne .recursive_call

; Chama a função ackermann(m - 1, 1) se n é zero
mov rsi, 1
dec rdi
call ackermann
jmp .exit

.recursive_call:
; Chama a função ackermann(m - 1, ackermann(m, n - 1))
push rsi
dec rsi
call ackermann
mov rsi, rax
pop rsi
dec rdi
call ackermann

.exit:
; Restaura o valor do ponteiro de pilha e retorna o resultado
mov rsp, rbp
pop rbp
ret
