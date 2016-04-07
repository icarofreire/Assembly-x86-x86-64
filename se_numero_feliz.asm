section .data
N: db 0,0x0A
P: db 0x0A,0x0A
E: db 0x20,0x20

msg1 db "  : Número Feliz :)",0,0x0A
tam1 equ $-msg1

msg2 db "  : Número Triste :(",0,0x0A
tam2 equ $-msg2

section .bss
 MAXBUF equ 100000
 arquivo_1 resb MAXBUF

section .text
 global _start


%macro echo_s 2
 mov rsi, %1
 mov rax, 1
 mov rdi, 1
 mov rdx, %2
 syscall
%endmacro

%macro echo 1
 push rax
 push rdx
 push rdi
 push rsi
 mov rdx, %1
 mov [N], rdx
 add byte[N], '0'
 mov rax, 1
 mov rdi, 1
 mov rsi, N
 mov rdx, 1
 syscall
 pop rax
 pop rdx
 pop rdi
 pop rsi
%endmacro

%macro echo 2
 push rax
 push rdx
 push rcx
 push rsi
 push r8
 push r9
 push r10

 mov rax, %2
 mov r8, 260
 mov r9, r8
 mov r10, 0
 mov rcx, 10
 _%1:
  xor rdx, rdx
  mov rsi, 10
  div rsi
  mov [rsp-124], rax

  cmp rdx, 10
  jl __%1

  xor rcx, rcx
  jmp fim__%1
  __%1:
       mov [rsp+r8], rdx
       inc r8
       inc r10
    mov rax, [rsp-124]
  fim__%1:
 loopnz _%1

 mov rcx, r10
 ___%1:
  dec r8
  mov rax, [rsp+r8]

  pushf
  cmp rax, 0
  jne exibir_nz_%1
  jmp fim_exibir_nz_%1
 exibir_nz_%1:
  echo rax
 fim_exibir_nz_%1:
  popf

 loopnz ___%1

 pop r10
 pop r9
 pop r8
 pop rsi
 pop rcx
 pop rdx
 pop rax
%endmacro

%macro end 0
 mov rax, 60
 mov rdi, 0
 syscall
%endmacro


_start:

  ;*
  ;* Um número feliz é definido pela soma dos quadrados dos seus algarismos,
  ;* repetindo o processo de modo que o resultado seja igual a 1.
  ;* Se neste processo, a aritmetica entrar num ciclo sem fim, este número não é um número feliz.
  ;*

  mov r13, 230; <- N

 Se_numero_feliz:
  xor r12, r12
  mov r14, r13
 loop:
  cmp r12, 100
  jg infeliz
  inc r12
  mov rax, r13
  mov r8, 260
  mov r9, r8
  xor r10, r10
  xor r11, r11
  mov rcx, 10
 _QUE1:
  xor rdx, rdx
  mov rsi, 10
  div rsi
  mov [rsp-124], rax;N

  cmp rdx, 10
  jl __QUE1

  xor rcx, rcx
  jmp fim__QUE1
 __QUE1:
  mov [rsp+r8], rdx
  mov rax, rdx
  mul rax
  add r11, rax
  inc r8
  inc r10
  mov rax, [rsp-124]
 fim__QUE1:
 loopnz _QUE1

  cmp r11, 1
  jge loop1
  jmp feliz

 loop1:
  mov r13, r11
  cmp r13, 2
  jl feliz
  cmp r13, 999 ;Máximo de 4 digítos.
  jg infeliz
  jmp loop
 fim_loop1:

 feliz:
  echo 98, r14
  echo_s msg1, tam1
  jmp _fim_
 infeliz:
  echo 99, r14
  echo_s msg2, tam2
 _fim_:


end
