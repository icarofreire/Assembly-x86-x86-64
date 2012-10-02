section .data
ir dd 0

section .text
    global _start

;****************************************************
;* Um simples desenho colorido na placa de vídeo VGA.
;****************************************************

%macro modo_grafico 0                                          
	mov ax,13h                                              
	int 10h                                                                                                         
%endmacro

%macro FIMmodo_grafico 0
    mov ax,4C00h;sair para o dos                                           
	int 20h; Fim do prog                                                                                                        
%endmacro

%macro modo_texto 0 ;Volta p/ modo texto 80x25.
	mov ax,3                                                
    int 10h                                                 
%endmacro

%macro tecla 0
	sub ah,ah ;Espera uma tecla;                   
    int 16h
%endmacro         

%macro pixel 3 ;(X,Y,COR)                                                                         
   mov   ah, 0Ch 
   mov   al, %3 ;Cor
   mov   cx, %1 ;X
   mov   dx, %2 ;Y  
   mov   bx, 1h 
   int   10h                                      
%endmacro 

%macro PutPixel_2 3 ;(X,Y,COR)                                                                         
   mov   ax, 0A000h 
   mov   es, ax 
   mov   bx, %1  
   mov   dx, %2  
   mov   di, bx 
   mov   bx, dx 
   shl   dx, 8 
   shl   bx, 6  
   add   dx, bx  
   add   di, dx 
   mov   al, %3  
   stosb                                    
%endmacro


_start:

	modo_grafico
	pixel 50,130,4
	

dec dword[ir]
pintar1:
	inc dword[ir]
	inc dx 
	int 10h
    inc cx
	int 10h 
	cmp dword[ir], 50
	jle pintar1
	
pixel  102,182,84 

mov dword[ir], 0
pintar2:
	inc dword[ir]
	dec dx
	int 10h
	cmp dword[ir], 140
	jle pintar2

mov dword[ir], 0
pintar3:
	inc dword[ir]
	inc dx 
	int 10h
    inc cx
	int 10h 
	cmp dword[ir], 50
	jle pintar3                       
      
pixel 102,182,14;

mov dword[ir], 0
pintar4:
	inc dword[ir]
	dec dx 
	int 10h
    inc cx
	int 10h 
	cmp dword[ir], 50
	jle pintar4

mov dword[ir], 0
pintar5:
	inc dword[ir]
	dec dx
	int 10h
	cmp dword[ir], 37
	jle pintar5

pixel 102,42,32

mov dword[ir], 0
pintar6:
	inc dword[ir]
	inc dx 
	int 10h
    dec cx
	int 10h 
	cmp dword[ir], 52
	jle pintar6

	add dx, 15
	int 10h	
	add dx, 1
	int 10h	
  
    tecla                                                     
    modo_texto           
    FIMmodo_grafico                                                                                                    
       
end
