section .data
numero db "%d",0x0a,00
x dd 140
y dd 40

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

	;MIN(x,y) -> Menor inteiro utilizando operações de bitwise.
	min:
	    
		mov eax, dword[x]
		mov edx, dword[y]
		xor eax, edx
		cmp dword[x], edx
		jl me0
		jmp ma0
		
	me0:
			push dword[y]
			mov dword[y], -1
			mov edx, dword[y]
			and eax, edx
			pop edx
			xor edx, eax
			mov eax, edx
			xor edx, edx
			jmp f0
	ma0:
			push dword[y]
			mov dword[y], 0
			mov edx, dword[y]
			and eax, edx
			pop edx
			xor edx, eax
			mov eax, edx
			xor edx, edx
			jmp f0
	f0:
	
	mostra eax
	
	    			
end
