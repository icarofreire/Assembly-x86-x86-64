section .data
message db  "passou",0x0a
string  db  "%s",0x0a
caracter  db  "%c",0x0a
numero  db  "%d",0x0a


vetor dd 15, 7, 10, 7, 7, 7, 4, 4, 7, 2
tam dd 10; tamanho do vetor
soma dd 0; soma do vetor
media_aritmetica dd 0; media aritmetica do vetor
indice dd 0; indice da media aritmetica

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

		;media aritmetica
		xor eax, eax 
		soma_vetor:
					;echo dword[vetor+eax*4]
					xor esi, esi
					mov esi, dword[vetor+eax*4] 
					add dword[soma], esi 	
					inc eax
					cmp eax, dword[tam]
					jl soma_vetor
					xor esi, esi
					mov eax, esi
					
					;echo dword[soma];soma do vetor
					
		xor ecx, ecx			
		solve:
					inc dword[indice]
					xor esi, esi
					mov esi, dword[vetor+ecx*4] 
					
					mov eax, esi
					mul dword[tam]
					cmp eax, dword[soma]
					mov dword[media_aritmetica], eax
					je solved
					xor eax, eax
					mov dword[media_aritmetica], eax
					  	
					inc ecx
					cmp ecx, dword[tam]
					jl solve
		
		solved:	
					;echo dword[indice]
					
					 
					;soma = soma do vetor
					;indice = indice da media aritmetica
					;media_aritmetica = a media aritmetica do vetor

					
		
end
