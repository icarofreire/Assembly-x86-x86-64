section .data
numero db "%d",0x0a,00
mensagem1 db "Positivo: ",00
mensagem2 db "Negativo: ",00

inteiro dd 5786
i dd 2

section .text
    global _start
    extern printf, puts

%macro mostra 1
    pusha
	mov esi, numero
	push %1
	push esi
	call printf
	pop esi
	pop %1
	popa
%endmacro

%macro mostra_s 1
	pusha
	mov esi, %1
	push esi
	call puts
	pop esi
	popa
%endmacro

%macro end 0
	xor eax, eax
	xor ebx, ebx
	mov eax, 1
	mov ebx, 0
	int 0x80 
%endmacro

_start:
	
	; * Determina se um número inteiro é positivo ou negativo;
	; * convertendo o sinal do número, e verificando novamente.

	inicio:
		mov eax, dword[inteiro]
		shr eax, 31
		xor eax, 1
		jnz positivo
		jmp negativo
		
	positivo:
		mostra_s mensagem1
		mostra dword[inteiro]
		neg dword[inteiro]
		dec dword[i]
		jnz inicio
		jmp fim
		
	negativo:
		mostra_s mensagem2
		mostra dword[inteiro]
		neg dword[inteiro]
		dec dword[i]
		jnz positivo		
	
	fim:	
		
end
