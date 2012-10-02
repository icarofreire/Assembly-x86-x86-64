section .data
nome db "Dir "
diretorio db "/home/icaro/Desktop/CPP"

section .text
    global _start
    extern puts, opendir, readdir, closedir

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
		;Listando arquivos e pastas de um diretório.
		;------------------------------------------
		
	mostra_s nome
			push diretorio
			call opendir
			mov ebx, eax
			cmp eax, 0
			je nullo
			jmp ler_dir
        
	exibir_arquivos:
			mov eax, [esp+28]
			add eax,11
			mostra_s eax
        
	ler_dir:
			mov [esp], ebx
			call readdir 
			mov [esp+28],eax 
			cmp dword [esp+28],0 
			jne exibir_arquivos
			
    fechar_dir:
			mov [esp], ebx
			call closedir
        
	nullo:
        mov eax, 0			
	
end
