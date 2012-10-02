section .data
numero db "%d",0x0a,00
ProdutoEscalar db "Produto Escalar: ",00

vetor_1 dd 5,6,8,9,4,00
vetor_2 dd 9,8,5,4,7,00
tamanho dd 5
produto_escalar dd 0

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
		; * Mostra o produto escalar de dois vetores.
		
		mov eax, 0
		mov dword[esp-100], eax
		loop_vetor:
			mov dword[esp-104], eax
			mov eax, dword[esp-100]
			mov eax, dword[vetor_1+eax]
			mov dword[esp+108], eax
			mov eax,dword[esp+108];->a
			mov eax, dword[esp-100]
			mov eax, dword[vetor_2+eax]
			mov dword[esp+112], eax
			mov eax,dword[esp+112];->b
			jmp multiplica	
			f__:
			mov eax, dword[esp-104]
			add dword[esp-100], 4
			inc eax
			cmp eax, dword[tamanho]
			jl loop_vetor
			jmp fim_multiplica
			

		multiplica:
			mov edi, dword[esp+108]
			mov dword[esp-200], edi
			mov edi, dword[esp+112]
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
			;mostra edi
			add dword[produto_escalar], edi
			jmp f__
		fim_multiplica:		
				
		mostra_s ProdutoEscalar
		mostra dword[produto_escalar]
	
end
