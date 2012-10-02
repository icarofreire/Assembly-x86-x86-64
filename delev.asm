section .data

section .text
    global _start

;***********************************
;* Progrmaçäo da placa de vídeo VGA.
;* Uma mensagem colorida na memória de vídeo da placa VGA para DOS x86-32.
;* Uma pequena homenagem a dois amigos. ;)
;***********************************

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
   mov   ax, 0A000h 
   mov   es, ax 
   mov   bx, %1;X  
   mov   dx, %2;Y  
   mov   di, bx 
   mov   bx, dx 
   shl   dx, 8 
   shl   bx, 6  
   add   dx, bx  
   add   di, dx 
   mov   al, %3;Cor  
   stosb
   dec di;;                                
%endmacro

%macro lh 4;(X1, X2, Y, COR)
    mov ax, 0A000h
    mov es, ax
    mov ax, %1
    mov bx, %3
    mov cx, %2
    sub cx, ax 
    mov di, ax 
    mov dx, bx 
    shl bx, 8  
    shl dx, 6 
    add dx, bx 
    add di, dx 
    mov al, %4 
    rep stosb 
%endmacro

%macro lv 5;(Y1, Y2, X, COR,LABEL)
   mov   ax, 0A000h      
   mov   es, ax 
   mov   ax, %1     
   shl   ax, 6   
   mov   di, ax  
   shl   ax, 2    
   add   di, ax  
   add   di, %3    
   mov   cx, %2   
   mov   al, %4    
   sub   cx, %1  
   %5:
   mov   [es:di], al 
   add   di, 320   
   dec   cx  
   jnz   %5  
%endmacro

%macro cima 0 
	sub di, 320
    mov [es:di], al
%endmacro

%macro cima_d_dir 0 
	sub di, 320
    inc di
    mov [es:di], al
%endmacro

%macro cima_d_esq 0 
	sub di, 320
    dec di
    mov [es:di], al
%endmacro

%macro baixo 0 
	add di, 320
    mov [es:di], al
%endmacro

%macro baixo_d_dir 0 
	add di, 320
    inc di
    mov [es:di], al
%endmacro

%macro baixo_d_esq 0 
	add di, 320
    dec di
    mov [es:di], al
%endmacro

%macro direita 0 
    inc di
    mov [es:di], al
%endmacro

%macro esquerda 0 
    dec di
    mov [es:di], al
%endmacro

%macro rep1 3;(n,proc,label)
	mov cx, %1
	%3:
	%2
	dec cx
	jnz %3
%endmacro 

%macro rep2 4;(n,proc,proc,label)
	mov cx, %1
	%4:
	%2
	%3
	dec cx
	jnz %4
%endmacro                 

_start:

	modo_grafico

	pixel 80,50,9
	rep1 15,baixo,dd1
	pixel 81,50,9
	rep1 3,direita,dd2
	rep2 5,direita,baixo_d_dir,dd3
	rep1 6,baixo,dd4
	rep2 4,esquerda,baixo_d_esq,dd5
	rep1 5,esquerda,dd6
	
	add di, 20
	pixel 110,50,10
	rep1 12,baixo,dd7
	rep2 2,direita,baixo_d_dir,dd8
	rep1 3,direita,dd9
	rep2 2,direita,cima_d_dir,dd10
	rep1 12,cima,dd11
	
	add di, 20
	pixel 140,50,14
	rep1 15,baixo,dd12
	pixel 140,50,14
	rep1 3,direita,dd13
	rep2 5,direita,baixo_d_dir,dd14
	rep1 6,baixo,dd15
	rep2 4,esquerda,baixo_d_esq,dd16
	rep1 5,esquerda,dd17
	
	add di, 20
	pixel 170,50,13
	rep1 15,baixo,dd18
	pixel 170,50,13
	rep1 3,direita,dd19
	rep2 5,direita,baixo_d_dir,dd20
	rep1 6,baixo,dd21
	rep2 4,esquerda,baixo_d_esq,dd22
	rep1 5,esquerda,dd123
	
	add di, 20
	pixel 200,50,11
	rep1 12,baixo,dd24
	rep2 2,direita,baixo_d_dir,dd25
	rep1 3,direita,dd26
	rep2 2,direita,cima_d_dir,dd27
	rep1 12,cima,dd28
	
	;---E---
	pixel 140,100,4
	rep1 5,direita,dd29
	rep1 2,cima,dd30
	rep2 3,cima,cima_d_esq,dd31
	rep1 5,esquerda,dd32
	rep2 3,baixo,baixo_d_esq,dd33
	rep1 5,baixo,dd34
	rep2 3,baixo,baixo_d_dir,dd35
	rep1 7,direita,dd36
    ;---E---
        
    pixel 110,130,9
    rep1 20,baixo,dd37
    rep1 10,direita,dd38
    rep1 3,cima,dd39
    
    add di, 10
    pixel 130,130,9
    rep1 10,direita,dd40
    pixel 130,130,9
    rep1 10,baixo,dd41
    rep1 5,direita,dd42
    pixel 130,140,9
    rep1 10,baixo,dd43
    rep1 10,direita,dd44
    
    add di, 10
    pixel 150,130,9
    rep1 20,baixo,dd45
    rep1 10,direita,dd46
    rep1 20,cima,dd47
    rep1 10,esquerda,dd48
    
    pixel 200,170,4
    rep1 5,direita,dd49
	rep1 2,cima,dd50
	rep2 3,cima,cima_d_esq,dd51
	rep1 5,esquerda,dd52
	rep2 3,baixo,baixo_d_esq,dd53
	rep1 5,baixo,dd54
	rep2 3,baixo,baixo_d_dir,dd55
	rep1 7,direita,dd56
	
	add di, 10
	pixel 220,178,4
	rep2 8,cima,cima_d_esq,dd57
	pixel 220,178,4
	rep2 12,cima,cima_d_dir,dd58
	
	add di, 10
	pixel 240,170,4
    rep1 5,direita,dd59
	rep1 2,cima,dd60
	rep2 3,cima,cima_d_esq,dd61
	rep1 5,esquerda,dd62
	rep2 3,baixo,baixo_d_esq,dd63
	rep1 5,baixo,dd64
	rep2 3,baixo,baixo_d_dir,dd65
	rep1 7,direita,dd66
	
	add di, 10
	pixel 256,160,4
	rep1 22,baixo,dd67
	pixel 256,160,4
	rep1 5,direita,dd68
	rep2 5,direita,baixo_d_dir,dd69
	rep1 4,baixo,dd70
	rep2 7,esquerda,baixo_d_esq,dd71
	dec di
	dec di
	rep2 10,direita,baixo_d_dir,dd72
    
    tecla                                                     
    modo_texto           
    FIMmodo_grafico                                                                                                    
       
end
