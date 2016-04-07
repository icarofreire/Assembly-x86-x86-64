section .data
N: db 0,0x0A
P: db 0x0A,0x0A

ARQUIVO_1 db "A.txt",0,0x0A
ARQUIVO_2 db "B.txt",0,0x0A

saida db "saida.txt",0,0x0A
arquivos_iguais db "Arquivos Iguais.",0x0A
tam_ig equ $-arquivos_iguais

msgA db "Arquivo A:",0x0A,0x0A
tam_msgA equ $-msgA
msgB db "Arquivo B:",0x0A,0x0A
tam_msgB equ $-msgB
erro db "Arquivos não encontrado.",0x0A,0x0A
tam_erro equ $-erro

section .bss
 MAXBUF equ 100000
 arquivo_1 resb MAXBUF
 A resb MAXBUF
 err_a resb 20
 arquivo_2 resb MAXBUF
 B resb MAXBUF
 err_b resb 20

section .text
 global _start


%macro ler_arquivos 0
 mov rax, 2
 mov rdi, ARQUIVO_1
 mov rsi, 000000q
 mov rdx, 00400q
 syscall

 mov r9, rax
 mov [rsp-450], r9
 mov rax, 0
 mov rdi, 4
 mov rsi, arquivo_1
 mov rdx, MAXBUF
 syscall

 mov rax, 3
 mov rdi, r9
 syscall

 mov rax, 2
 mov rdi, ARQUIVO_2
 mov rsi, 000000q
 mov rdx, 00400q
 syscall

 mov r9, rax
 mov [rsp-460], r9
 mov rax, 0
 mov rdi, 4
 mov rsi, arquivo_2
 mov rdx, MAXBUF
 syscall

 mov rax, 3
 mov rdi, r9
 syscall
%endmacro

%macro criar_escr_fec 3
 mov rax, 85
 mov rdi, %1
 mov rsi, 448
 syscall

 mov rax, 2
 mov rdi, %1
 mov rsi, 000002q
 mov rdx, 0666
 syscall
 mov r9, rax

 mov rax, 1
 mov rdi, r9
 mov rsi, %2
 mov rdx, %3
 syscall

 mov rax, 3
 mov rdi, r9
 syscall
%endmacro

%macro criar 1
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

%macro escrever 2
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

%macro end 0
 mov rax, 60
 mov rdi, 0
 syscall
%endmacro

_start:

  ler_arquivos
  cmp qword[rsp-450], -1
  js NAO_ENCONTRADO
  cmp qword[rsp-460], -1
  js NAO_ENCONTRADO
  criar saida

  xor r8, r8
  xor r12, r12
  xor r13, r13
  mov rcx, MAXBUF
 anali:
  dec rcx
  mov sil, byte[arquivo_1+r8]
  mov dil, byte[arquivo_2+r8]
  cmp sil, 0x20
  jne prox_lin_a
  jmp fim_tab_a
 prox_lin_a:
  cmp sil, 0x0A
  jne tab_a
  jmp fim_tab_a
 tab_a:
  cmp sil, 0x09
  je fim_tab_a
  mov byte[A+r12], sil
  inc r12
 fim_tab_a:
  inc r8

  cmp dil, 0x20
  jne prox_lin_b
  jmp fim_tab_b
 prox_lin_b:
  cmp dil, 0x0A
  jne tab_b
  jmp fim_tab_b
 tab_b:
  cmp dil, 0x09
  je fim_tab_b
  mov byte[B+r13], dil
  inc r13
 fim_tab_b:
  xor sil, 0x04
  jz fim
  xor dil, 0x04
  jz fim
  jmp _fim
  fim:
   xor rcx, rcx
  _fim:

  cmp rcx, 0
  jnz anali


  mov qword[rsp-257], 0
  xor r8, r8
  mov rcx, MAXBUF
 veri:
  dec rcx
  mov sil, byte[A+r8]
  mov dil, byte[B+r8]
  cmp dil, sil
  jne diferente
  jmp _diferente
 diferente:
  xor rcx, rcx
  mov qword[rsp-257], r8
  inc qword[rsp-257]


  mov qword[rsp-270], 20
  mov rcx, qword[rsp-270]
  mov r10, 0
  sub r8, rcx
  inc r8
  reto:
   mov sil, byte[A+r8]
   mov dil, byte[B+r8]
   mov byte[err_a+r10], sil
   mov byte[err_b+r10], dil
   inc r10
   inc r8
  loopnz reto

  mov r8, qword[rsp-257]
  mov rcx, qword[rsp-270]
  diant:
   mov sil, byte[A+r8]
   mov dil, byte[B+r8]
   mov byte[err_a+r10], sil
   mov byte[err_b+r10], dil
   inc r10
   inc r8
  loopnz diant


  mov r8, qword[rsp-270]
  add r8, r8
  escrever msgA, tam_msgA
  escrever err_a, r8

  prox_linha
  prox_linha

  escrever msgB, tam_msgB
  escrever err_b, r8

 _diferente:
  inc r8
  cmp rcx, 0
  jnz veri

  xor qword[rsp-257], 0
  jnz nigual
  criar_escr_fec saida, arquivos_iguais, tam_ig
 nigual:
  fechar
  jmp fim_NAO_ENCONTRADO


  NAO_ENCONTRADO:
    criar_escr_fec saida, erro, tam_erro
  fim_NAO_ENCONTRADO:

end
