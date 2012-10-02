section .data
N: db 0,0x0A

arquivo_xml db "cd_catalog.xml",0,0x0A
TAG db "ARTIST",00
tam equ $-TAG
titulo db "Exibindo o conteúdo das tags ",00
tamt equ $-titulo
P db 0x0A, 0x0A

section .bss
	MAXBUF equ 100000
	arquivo resb MAXBUF
	texto resb MAXBUF

section .text	
	global _start

%macro echo_s 2
	mov	rsi, %1
	mov	rax, 1
	mov	rdi, 1
	mov	rdx, %2
	syscall
%endmacro

%macro end 0
	mov	rax, 60
	mov	rdi, 0
	syscall 
%endmacro

_start:
		;Exibindo todos os conteúdos de uma tag específica do um arquivo xml.
		
		echo_s titulo, tamt
		echo_s TAG, tam
		echo_s P, 2
		
		xor r10, r10
		mov r11, 165
		mov rcx, tam
		passar:
			mov dl, byte[TAG+r10]
			mov byte[rsp+r11], dl
			inc r10
			inc r11
		loopnz passar
		
		mov rax, 2
		mov rdi, arquivo_xml   
		mov rsi, 000000q	;O_RDONLY(somente leitura)    
		mov rdx, 00400q		;S_IRUSR(permissão de usuário para ler)
		syscall
		
		mov rax, 0
		mov rdi, 4
		mov rsi, arquivo_xml
		mov rdx, MAXBUF
		syscall
		
		xor r11, r11
		xor r14, r14
		mov rcx, MAXBUF
		xor r9, r9
		mov qword[rsp+254], r9
		laco:
			inc r9
			cmp byte[arquivo+r9], 0x3C
			je letra2
			jmp fim_parar_laco
		letra2:
			mov r12, 164;(165-1)
			xor r13, r13
		anali:
			inc r13
			inc r12
			inc r9
			mov bl, byte[arquivo+r9]
			cmp bl, byte[rsp+r12]
			je anali
			
			cmp r13, tam
			je parar_laco
			jmp fim_parar_laco
		parar_laco:
			dec r11
		ler_cont:
			inc r14
			inc r9
			mov qword[rsp+254], r9
			mov bl, byte[arquivo+r9]
			mov byte[texto+r14], bl
			cmp bl, 0x3C
			jne ler_cont
				
			mov byte[texto+r14], 0x0A				
			jmp laco
		fim_parar_laco:
		loopnz laco
		
		cmp qword[rsp+254], 0
		jz nao
			echo_s texto, MAXBUF
		nao:
		
end

