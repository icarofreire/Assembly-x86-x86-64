section .data
numero_com_espaco db "%d",00
letra db "%c",0x0a,00
igual db " = ",00
soma db " + ",00
nova_linha db "",00


;**********Exemplo 1:**********
;;;24729471972154292197124996729198274191329781238171
;;+76554717531572172172851796346392167319783765291781 = 101284189503726464369976793075590441511113546529952
;  --------------------------------------------------------------------------------------------------------
numero1 dd '2','4','7','2','9','4','7','1','9','7','2','1','5','4','2','9','2','1','9','7','1','2','4','9','9','6','7','2','9','1','9','8','2','7','4','1','9','1','3','2','9','7','8','1','2','3','8','1','7','1',00
tam_numero1 dd 51
tam_str_numero1 equ $-numero1
numero2 dd '7','6','5','5','4','7','1','7','5','3','1','5','7','2','1','7','2','1','7','2','8','5','1','7','9','6','3','4','6','3','9','2','1','6','7','3','1','9','7','8','3','7','6','5','2','9','1','7','8','1',00
tam_numero2 dd 51
tam_str_numero2 equ $-numero2
vai_um dd 0
n_p dd 4
;******************************


;**********Exemplo 2:**********
;;;6475641729489127951
;;+2984217524957542948 = 9459859254446670899
;  -----------------------------------------
;numero1 dd '6','4','7','5','6','4','1','7','2','9','4','8','9','1','2','7','9','5','1',00
;tam_numero1 dd 20
;tam_str_numero1 equ $-numero1
;numero2 dd '2','9','8','4','2','1','7','5','2','4','9','5','7','5','4','2','9','4','8',00
;tam_numero2 dd 20
;tam_str_numero2 equ $-numero2
;vai_um dd 0
;n_p dd 4
;******************************


;**********Exemplo 3:**********
;;;942197841456924892748255275464
;;+147964879149752482281718871848 = 1090162720606677375029974147312
;  ----------------------------------------------------------------
;numero1 dd '9','4','2','1','9','7','8','4','1','4','5','6','9','2','4','8','9','2','7','4','8','2','5','5','2','7','5','4','6','4',00
;tam_numero1 dd 31
;tam_str_numero1 equ $-numero1
;numero2 dd '1','4','7','9','6','4','8','7','9','1','4','9','7','5','2','4','8','2','2','8','1','7','1','8','8','7','1','8','4','8',00
;tam_numero2 dd 31
;tam_str_numero2 equ $-numero2
;vai_um dd 0
;n_p dd 4
;******************************


section .text
    global _start
    extern printf, puts

%macro mostra_esp 1
    pusha
	mov esi, numero_com_espaco
	push %1
	push esi
	call printf
	pop esi
	pop %1
	popa
%endmacro

%macro mostra_s 1
	pusha
	mov esi, %1
	push esi
	call puts
	pop esi
	popa
%endmacro

%macro echo_s 2
	pusha
	mov edx, %2
	mov ecx, %1
	mov ebx, 2
	mov eax, 4
	int 80h
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
		
		echo_s numero1, tam_str_numero1
		mostra_s soma
		echo_s numero2, tam_str_numero2
		mostra_s igual
	    mov edi, -1
				    		
		mov ecx, 10
		mov edx, dword[tam_numero1]
		rod_string:
			dec edx					
			mov eax, dword[numero1+edx*4]
			mov ebx, dword[numero2+edx*4]	
			cmp eax, 47
			jg eta1
			jmp fim_e_digito
		eta1:
			cmp ebx, 47
			jg eta2
			jmp fim_e_digito
		eta2:
			cmp eax, 58
			jl eta3
			jmp fim_e_digito
		eta3:
			cmp ebx, 58
			jl e_digito
			jmp fim_e_digito
		e_digito:
			;mostra eax
			;mostra ebx				                 
		char_to_int:
			a_zero:
				cmp eax, 48
				je zero
			b_zero:	
				cmp ebx, 48
				je zero_b
			a_um:	
				cmp eax, 49
				je um
			b_um:	
				cmp ebx, 49
				je um_b
			a_dois:	
				cmp eax, 50
				je dois
			b_dois:	
				cmp ebx, 50
				je dois_b
			a_tres:	
				cmp eax, 51
				je tres
			b_tres:	
				cmp ebx, 51
				je tres_b
			a_quatro:	
				cmp eax, 52
				je quatro
			b_quatro:	
				cmp ebx, 52
				je quatro_b
			a_cinco:	
				cmp eax, 53
				je cinco
			b_cinco:	
				cmp ebx, 53
				je cinco_b
			a_seis:
				cmp eax, 54
				je seis
			b_seis:	
				cmp ebx, 54
				je seis_b
			a_sete:	
				cmp eax, 55
				je sete
			b_sete:	
				cmp ebx, 55
				je sete_b
			a_oito:	
				cmp eax, 56
				je oito
			b_oito:	
				cmp ebx, 56
				je oito_b
			a_nove:	
				cmp eax, 57
				je nove
			b_nove:	
				cmp ebx, 57
				je nove_b
				jmp fim_char_to_int											
			zero:
				xor eax, eax
				jmp b_zero
			um:
				mov eax, 1
				jmp b_um
			dois:
				mov eax, 2
				jmp b_dois
			tres:
				mov eax, 3
				jmp b_tres
			quatro:
				mov eax, 4
				jmp b_quatro
			cinco:
				mov eax, 5
				jmp b_cinco
			seis:
				mov eax, 6
				jmp b_seis
			sete:
				mov eax, 7
				jmp b_sete
			oito:
				mov eax, 8
				jmp b_oito
			nove:
				mov eax, 9
				jmp b_nove
			
			zero_b:
				xor ebx, ebx
				jmp a_um
			um_b:
				mov ebx, 1
				jmp a_dois
			dois_b:
				mov ebx, 2
				jmp a_tres
			tres_b:
				mov ebx, 3
				jmp a_quatro
			quatro_b:
				mov ebx, 4
				jmp a_cinco
			cinco_b:
				mov ebx, 5
				jmp a_seis
			seis_b:
				mov ebx, 6
				jmp a_sete
			sete_b:
				mov ebx, 7
				jmp a_oito
			oito_b:
				mov ebx, 8
				jmp a_nove
			nove_b:
				mov ebx, 9
											
		fim_char_to_int:
				;mostra eax
				;mostra ebx
				ini_soma:			
					add eax, dword[vai_um]
					add eax, ebx
				fim_soma:
								
					cmp eax, 9
					jg somar_algarismos	
						
					cmp eax, 9
					jle zera_vai_um
								
					jmp fim_zera_vai_um
					somar_algarismos:
							cmp edx, 0
							je fim_zera_vai_um
						
	                                                push edx
							xor edx, edx
							idiv ecx
							mov dword[vai_um], eax
							mov eax, edx
							pop edx
													
							jmp fim_zera_vai_um
							fim_somar_algarismos:
				zera_vai_um:
					mov dword[vai_um], 0
				fim_zera_vai_um:
				    		
				;mostra eax;s
				;mostra ebx
				push eax
							
		fim_e_digito:	
			cmp edx, 0
			ja rod_string
  
       mov eax, dword[tam_numero1]
       imul dword[n_p]
       sub eax, 4
       mov dword[n_p], eax
       xor eax, eax
	   mov ebp, esp	
	   mov edi, 0
	   rod_p:
	         mostra_esp dword[ebp+edi]
		 add edi, 4
		 cmp edi, dword[n_p]
		 jl rod_p
		 mostra_s nova_linha

	    			
end
