section .data
numero db "%d",0x0a,00
letra db "%c",0x0a,00

section .text
    global _start
    extern printf, puts

;-------------------------------------------
%macro mostra_numero_registrador 1;(reg)
    pusha
	mov esi, numero
	push %1
	push esi
	call printf
	pop esi
	pop %1
	popa
%endmacro

%macro mostra_numero_variavel 1;(mem)
    pusha
	mov esi, numero
	push %1
	push esi
	call printf
	pop esi
	pop %1
	popa
%endmacro

%macro mostra_numero 1;(immed)
	push eax
	mov eax, %1
	mov esi, numero
	push eax
	push esi
	call printf
	pop esi
	pop eax
%endmacro

%macro mostra_char_ASCII 1;(immed, codigo ASCII)
	pusha		
	mov eax, %1
	mov esi, letra
	push eax
	push esi
	call printf
	pop esi
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

%macro fim_do_programa 0
	xor eax, eax
	xor ebx, ebx
	mov eax, 1
	mov ebx, 0
	int 0x80 
%endmacro

%macro ler_string 0
	pusha
	mov edx, tam_string_entrada
	mov ecx, string_entrada
	mov ebx, 2
	mov eax, 3
	int 80h
	popa
%endmacro

%macro mostra_char 1;(mem)
	pusha
	mov edx, 1
	mov ecx, %1;mem
	mov ebx, 2
	mov eax, 4
	int 80h
	popa
%endmacro

%macro mostra_string_de_tamanho_n 2;(mem,tam-mem)
	pusha
	mov edx, %2;tam_mem
	mov ecx, %1;mem
	mov ebx, 2
	mov eax, 4
	int 80h
	popa
%endmacro
;-------------------------------------------

_start:

		;Alguns Procs úteis de I/O
	   			
fim_do_programa
