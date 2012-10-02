section .data
message db  "passou",0x0a
string  db  "%s",0x0a
caracter  db  "%c",0x0a
numero  db  "%d",0x0a


i dd 0
tam dd 0
pi dd 0
temp dd 0

section .text
    global _start
    extern printf

%macro echo 1
        push %1
        push numero
        call printf
        add esp, 4 
%endmacro

%macro echo_s 1
        push %1
        push string
        call printf
        add esp, 4 
%endmacro

%macro echo_c 1
        push %1
        push caracter
        call printf
        add esp, 4 
%endmacro

%macro end 0
      xor eax, eax
      xor ebx, ebx
      mov eax, 1
      mov ebx, 0
      int 0x80 
%endmacro

_start:

		;tolower

		push 'P'
		push 'A'
		push 'R'
		push 'K'
		push 'O'
		push 'U'
		push 'R'
		push 'A'
		push 'J'
		push 'U'
		;jmp so_mostrar
		
		mov dword[tam], 10;tamanho da string na pilha
		mov eax, 4
		mul dword[tam]
		mov dword[pi], eax; pi = 4*tam
		mov ecx, 0
		for:
			inc ecx
			sub dword[pi], 4
			mov eax, dword[pi]

				mov edx, dword[esp+eax]				
				complets:
							cmp edx, 97
							jl ee
							jmp fimcomp
				ee:
							cmp edx, 122
							jl muda
							jmp fimcomp
				muda: 
							sub edx, 65
							add edx, 97
							mov [esp+eax], edx	
				fimcomp:
			
			inc eax			
			cmp ecx, [tam]
			jb for
			;--------------------------------------------
 

		so_mostrar:
		xor eax, eax
		ir:
			mov eax, dword[temp]
			mov edx, dword[esp+eax]
			jmp fim_muda_caixa_alta_para_baixa
			
		muda_caixa_alta_para_baixa:
					sub edx, 65
					add edx, 97
					mov [esp+eax], edx
		fim_muda_caixa_alta_para_baixa:

			echo_c dword[esp+eax]
			
			add dword[temp], 4
			add esp, 4
			
			cmp dword[temp], 40
			jl ir
			

		
end
