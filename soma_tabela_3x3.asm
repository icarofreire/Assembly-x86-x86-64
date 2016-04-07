section .data
N: db 0,0x0A
P: db 0x0A,0x0A
E: db 0x20,0x20

saida db "saida.txt",0,0x0A

section .bss
 MAXBUF equ 100000
 arquivo_1 resb MAXBUF

section .text
 global _start


%macro criar 1;(mem arquivo)
 mov rax, 85
 mov rdi, %1
 mov rsi, 448
 syscall

 mov rax, 2
 mov rdi, %1
 mov rsi, 000002q
 mov rdx, 0666
 syscall
 mov [rsp-555], rax
%endmacro

%macro escrever 2;(mem texto, tam)
 mov rax, 1
 mov rdi, [rsp-555]
 mov rsi, %1
 mov rdx, %2
 syscall
%endmacro

%macro prox_linha 0
 mov rax, 1
 mov rdi, [rsp-555]
 mov rsi, P
 mov rdx, 2
 syscall
%endmacro

%macro fechar 0
 mov rax, 3
 mov rdi, [rsp-555]
 syscall
%endmacro

%macro escrever_n 2;(reg/immed)
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

 mov r12, 0
 mov rcx, r10
 ___%1:
  dec r8
  mov rax, [rsp+r8]

  pushf
  cmp rax, 0
  jne exibir_nz_%1
  jmp fim_exibir_nz_%1
 exibir_nz_%1:

  add rax, '0'
  mov [arquivo_1+r12], rax
  inc r12

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
 escrever arquivo_1, r12
%endmacro

%macro end 0
 mov rax, 60
 mov rdi, 0
 syscall
%endmacro


_start:

  push 0
  push 97
  push 56
  push 69
  push 0
  push 71
  push 84
  push 43
  push 0

  ;*************
  ; 0 | 97 | 56
  ;*************
  ; 69 | 0 | 71
  ;*************
  ; 84 | 43 | 0
  ;*************

  mov rax, 0;(Y)
laco:
  inc rax
  movq xmm0, rax

 tm:
   movq xmm1, [rsp+40]
   movq xmm2, [rsp+24]
   addpd xmm1, xmm2
   mov r8, rax ;(Y)
   movq xmm2, r8
   addpd xmm1, xmm2

 s1:
   movq xmm2, [rsp+56]
   movq xmm3, [rsp+48]
   addpd xmm2, xmm3

 s2:
   movq xmm3, [rsp+48]
   movq xmm4, [rsp+24]
   addpd xmm3, xmm4

 d1:
   movq r8, xmm2
   movq r9, xmm1
   cmp r9, r8
   jg maior_d1
   jmp d1_
 maior_d1:
   sub r9, r8
   mov r8, r9
   jmp fim_d1
 d1_:
   sub r8, r9
 fim_d1:
   mov qword[rsp+256], r8
   movq r10, xmm2
   add r8, r10
   movq xmm4, r8

 d2:
   movq r8, xmm3
   movq r9, xmm1
   cmp r9, r8
   jg maior_d2
   jmp d2_
 maior_d2:
   sub r9, r8
   mov r8, r9
   jmp fim_d2
 d2_:
   sub r8, r9
 fim_d2:
   mov qword[rsp+264], r8
   movq r10, xmm3
   add r8, r10
   movq xmm5, r8

   mov r11, qword[rsp+256]
   add r11, qword[rsp+264]
   add r11, rax


   cmp qword[rsp+256], 0
   jnz d1_nz
   jmp __f
 d1_nz:
   cmp qword[rsp+264], 0
   jnz d2_nz
   jmp __f
 d2_nz:
   movq r8, xmm4
   movq r9, xmm1
   cmp r8, r9
   je ig1
   jmp __f
 ig1:
   movq r8, xmm5
   movq r9, xmm1
   cmp r8, r9
   je ig2
   jmp __f
 ig2:
   movq r8, xmm4
   cmp r8, r11
   je ig3
   jmp __f
 ig3:
   xor rcx, rcx
   criar saida

   mov r8, qword[rsp+256]
   escrever_n 1, r8
   escrever E, 2

   mov r8, qword[rsp+56]
   escrever_n 2, r8
   escrever E, 2

   mov r8, qword[rsp+48]
   escrever_n 3, r8
   escrever E, 2

   prox_linha

   mov r8, qword[rsp+40]
   escrever_n 4, r8
   escrever E, 2

   movq r8, xmm0
   escrever_n 5, r8
   escrever E, 2

   mov r8, qword[rsp+24]
   escrever_n 6, r8
   escrever E, 2

   prox_linha

   mov r8, qword[rsp+16]
   escrever_n 7, r8
   escrever E, 2

   mov r8, qword[rsp+8]
   escrever_n 8, r8
   escrever E, 2

   mov r8, qword[rsp+264]
   escrever_n 9, r8

   fechar
 __f:

  movq rax, xmm0
  cmp rax, 0
  jnz dif
  jmp ff
 dif:
   cmp rax, 1000
   jl laco
 ff:


end
