section .data
numero db "%d",0x0a,00
A dd 45
B dd 3

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

%macro end 0
	xor eax, eax
	xor ebx, ebx
	mov eax, 1
	mov ebx, 0
	int 0x80 
%endmacro

_start:
		; * Multiplicação  de dois números inteiros A e B utilizando operações de bitwise.
		; * O resoltado da multiplicação é passado para o registrador edi.
		multiplica:
			mov edi, dword[A]
			mov dword[esp-200], edi
			mov edi, dword[B]
			mov dword[esp-204], edi
			and edi, 0
		prilaco:
			mov dword[esp-212], edi
			mov edi, dword[esp-204]
			mov dword[esp-208], edi
			mov edi, dword[esp-212]
			and dword[esp-208], 1
			jz esquerda_e_direita
			js esquerda_e_direita
			add edi, dword[esp-200]
		esquerda_e_direita:
			shl dword[esp-200], 1
			shr dword[esp-204], 1
			jnz prilaco
			and dword[esp-200], 0
			and dword[esp-204], 0
			and dword[esp-208], 0
			and dword[esp-212], 0
				
			mostra edi
	
end
