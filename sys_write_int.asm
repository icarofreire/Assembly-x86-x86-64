section .data
N: db 0,0x0A

section .text	
	global _start

%macro echo 1;(reg/immed)
	push rax
	push rdx
	push rdi
	push rsi
	mov rdx, %1
	mov [N], rdx
	add byte[N], '0'
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, N
	mov	rdx, 1
	syscall
	pop rax
	pop rdx
	pop rdi
	pop rsi
%endmacro

%macro end 0
	mov	rax, 60
	mov	rdi, 0
	syscall 
%endmacro


_start:
	
	;Exibindo um valor inteiro atravez da captura de seus algarismos, para a arquitetura x86-64. 
	;fazendo uso da system call "sys_write" do Linux.
	
	push rax
	push rdx
	push rcx
	push rsi
	push r8
	push r9
	push r10
	
	mov rax, 1984165 ; <= Número para exibir.
	
	mov r8, 260
	mov r9, r8
	mov r10, 0
	mov rcx, 10
	_div_:
		xor rdx, rdx
		mov rsi, 10
		div rsi
		mov [rsp-124], rax
		cmp rdx, 0
		jnz resto_nz
		xor rcx, rcx
		jmp fim_resto_nz
		resto_nz:
		     mov [rsp+r8], rdx  
		     inc r8
		     inc r10
			 mov rax, [rsp-124]
		fim_resto_nz:
	loopnz _div_
	
	mov rcx, r10
	exibir_traz_p_frente:
		dec r8
		mov rax, [rsp+r8]
		echo rax
	loopnz exibir_traz_p_frente
	
	pop r10
	pop r9
	pop r8
	pop rsi
	pop rcx
	pop rdx
	pop rax
	
end


