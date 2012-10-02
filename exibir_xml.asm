section .data

arquivo_xml db "simple.xml",0,0x0A

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

		;Exibindo todos os dados de um arquivo xml.
		
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
		xor r9, r9
		mov rcx, MAXBUF
		laco:
			dec rcx
			inc r9
			cmp byte[arquivo+r9], 0x2F
			je retornar_0
			jmp dif
		retornar_0:
			mov qword[rsp-187], 0
			mov r13, 520
			dec r9
		retornar:
			inc qword[rsp-187]
			dec r9
			mov qword[rsp+254], r9
			mov bl, byte[arquivo+r9]
			mov byte[rsp+r13], bl
			inc r13
			cmp bl, 0x3E
			jne retornar
		
			add r9, qword[rsp-187]
			inc r9
			mov qword[rsp-187], 0
			dec r13
		conv:
			dec r13
			inc r14
			mov bl, byte[rsp+r13]
			mov byte[texto+r14], bl
			cmp r13, 519
			jnz conv
			inc r14
			mov byte[texto+r14], 0x0A		
			jmp laco
		dif:
		cmp rcx, 0
		jnz laco
		
		echo_s texto, MAXBUF
		
end

