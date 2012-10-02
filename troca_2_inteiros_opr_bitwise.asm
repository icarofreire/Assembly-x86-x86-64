section .data
numero db "%d",0x0a,00
antes db "Antes: ",00
depois db "Depois: ",00
mens_x db "x = ",00
mens_y db "y = ",00
nova_linha db "",00
x dd 547
y dd 952

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
		
		;Troca de 2 inteiros utilizando operações de bitwise.
	
		mostra_s antes
		mostra_s mens_x
		mostra dword[x]
		mostra_s nova_linha
		mostra_s mens_y
		mostra dword[y]
		mostra_s nova_linha
		mostra_s nova_linha
		
		troca:
			mov eax, dword[x]
			xor eax, dword[y]
			xor dword[y], eax
			xor eax, dword[y] 
			mov dword[x], eax
			xor eax, eax
		
		mostra_s depois
		mostra_s mens_x
		mostra dword[x]
		mostra_s nova_linha
		mostra_s mens_y
		mostra dword[y]
			
end
