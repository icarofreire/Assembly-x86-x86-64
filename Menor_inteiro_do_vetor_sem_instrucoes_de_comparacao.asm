section .data
numero db "[%d]",0x0a,00
numero_espaco db "%d ",00
pula_linha db "",00
temp dd 99999
i dd -1

vetor_1 dd 742,93,186,85,99
tam_1 dd 5

vetor_2 dd 68,268,77,49,94,39,56,87,320,66
tam_2 dd 10


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

%macro mostra_n_espaco 1
    pusha
	mov esi, numero_espaco
	push %1
	push esi
	call printf
	pop esi
	pop %1
	popa
%endmacro

%macro mostra_string 1
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

	; * Menor número inteiro do vetor sem o uso de instruções de com­para­ção de dados.
	; *  ==, !=, >, <, >=, <=
	
		mov esi, vetor_1
	inicio:
		dec dword[tam_1]
	loop1:
		inc dword[i]
		mov eax, dword[i]
		mov eax, dword[esi+eax*4]
		
		mostra_n_espaco eax
		
		push dword[i]
		mov edx, dword[esp]
		pop ecx
		xor ecx, ecx
		xor edx, dword[tam_1]
		jnz loop1
		inc dword[tam_1]
		mov dword[i], -1
		
		mostra_string pula_linha
	
		dec dword[tam_1]
	loop:
		inc dword[i]
		mov eax, dword[i]
		mov eax, dword[esi+eax*4]
				
			sub dword[temp], eax		
			js neg
			push eax
			xor eax, eax
			jz f0
		
	neg:
			add eax, dword[temp]
			jmp n_f0
	f0:
			pop eax
	n_f0:
			mov dword[temp], eax
			
		push dword[i]
		mov edx, dword[esp]
		pop ecx
		xor ecx, ecx
		xor edx, dword[tam_1]
		jnz loop
					
		mostra dword[temp]
		mostra_string pula_linha
		
		dec dword[tam_2]
		js fim
		inc dword[tam_2]
		
		mov eax, tam_2
		mov edx, dword[eax]
		mov dword[tam_1], edx
		xor [eax], edx
		mov dword[i], -1
		mov esi, vetor_2
		jmp inicio
	fim:


end
