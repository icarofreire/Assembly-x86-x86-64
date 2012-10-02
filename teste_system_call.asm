section .data
message db  "passou",0x0a
string  db  "%s",0x0a
caracter  db  "%c",0x0a
numero  db  "%d",0x0a

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
        add esp, 8 
%endmacro

%macro end 0
      xor eax, eax
      xor ebx, ebx
      mov eax, 1
      mov ebx, 0
      int 0x80 
%endmacro

%macro mostra 1;(Registrador)
	mov %1, %1
	mov esi, numero
	push %1
	push esi
	call printf
	pop esi
	pop %1
%endmacro

%macro mostra_i 1;(Imediato)
	push eax
	mov eax, %1
	mov esi, numero
	push eax
	push esi
	call printf
	pop esi
	pop eax
%endmacro

_start:
			;Teste do uso consecutivo da System Call
			mov eax, 2011
			mostra eax
			inc eax
			mostra eax
			
		
end
