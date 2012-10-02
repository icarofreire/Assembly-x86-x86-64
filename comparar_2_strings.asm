section .data
numero db "%d",0x0a,00
str1 db "IcaroFreire",00
str2 db "IcaroFreire",00

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
	
	;Compara 2 Strings.
	;-------------------

	xor edx, edx
	dec edx
	tam:
	    inc edx   
		cmp byte[str1+edx], 00
		jne tam
    inc edx; <= tamanho das strings
	
	mov esi, str1
	mov edi, str2
	mov ecx, edx
	cld
	rep cmpsb
	je cig
	jmp cno
	
	cig:
		mov eax, 1
		jmp ff
	cno:
		xor eax, eax		
	ff:
	
	mostra eax
	;1 caso positivo,
	;0 caso negativo.
	
end
