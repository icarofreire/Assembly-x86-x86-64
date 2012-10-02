section .data
numero db "%d",0x0a,00
x dd 280
y dd 360
temp dd 0

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
	
	;A Diferença absoluta de 2 inteiros utilizando operações de bitwise. 
	
	min:
		mov eax, dword[x]
		mov edx, dword[y]
		xor eax, edx
		cmp dword[x], edx
		jl me0_min
		jmp ma0_min
		
	me0_min:
			push dword[y]
			mov dword[y], -1
			mov edx, dword[y]
			and eax, edx
			pop edx
			mov dword[y],edx
			xor edx, eax
			mov eax, edx
			jmp f0_min
	ma0_min:
			push dword[y]
			mov dword[y], 0
			mov edx, dword[y]
			and eax, edx
			pop edx
			mov dword[y],edx
			xor edx, eax
			mov eax, edx
			jmp f0_min
	f0_min:
    mov dword[temp], eax
    
	max:
		mov eax, dword[x]
		mov edx, dword[y]
		xor eax, edx
		cmp dword[x], edx
		jl me0_max
		jmp ma0_max
		
	me0_max:
			push dword[y]
			mov dword[y], -1
			mov edx, dword[y]
			and eax, edx
			pop edx
			xor dword[x], eax
			mov eax, dword[x]
			xor edx, edx
			jmp f0_max
	ma0_max:
			push dword[y]
			mov dword[y], 0
			mov edx, dword[y]
			and eax, edx
			pop edx
			xor dword[x], eax
			mov eax, dword[x]
			xor edx, edx
			jmp f0_max
	f0_max:
	sub eax, dword[temp]
	
	mostra eax
			
end
