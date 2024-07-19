; Tic Tac Toe Game

; Directives

INCLUDE "emu8086.inc"
.MODEL large
.STACK 100h

; Data Section

.DATA
   
   ; Strings for making 3 x 3 box 
    
   space db 32,"$"
   newline db  0ah,0dh,"$"
   strline db " | $"
   line db 0ah,0dh,"-----------",0ah,0dh,32,"$"
   
   ; Array to write "O" and "X" in the box
   
   arr db 32 , 32, 32
       db 32 , 32, 32
       db 32 , 32, 32
   
   ; Title of the Game
       
   tictac db "---------------------------",0ah,0dh,
         db "|      Tic Tac Toe        |",0ah,0dh,
         db "---------------------------",0ah,0dh,0ah,0dh
         db "Player1 : O    Player2 : X ",0ah,0dh,0ah,0dh,"$"
   
   ; Strings for players turn
   
   play1 db 0ah,0dh,0ah,0dh,"Player 1 turn : ",0ah,0dh,0ah,0dh,"$"
   play2 db 0ah,0dh,0ah,0dh,"Player 2 turn : ",0ah,0dh,0ah,0dh,"$"
   
   ; Strings for inputting the rows and colomn
   
   enterrow db 0ah,0dh,"Enter the row : ","$"
   entercol db 0ah,0dh,"Enter the column : ","$"
   
   ;Strings for the Winner
   
   play1win db 0ah,0dh,0ah,0dh,"Player 1 is Winner.","$"
   play2win db 0ah,0dh,0ah,0dh,"Player 2 is Winner.","$"
   drawn db 0ah,0dh,"Game is Drawn.",0ah,0dh,"$"
   
   ; Defining variables to use in the code
        
   turn db 1
   endgame db 0
   chr db 79
   
   rows db 0
   cols db 0
   
   num dw ?
   
   ; Code Section 
.CODE

; Main Procedure

MAIN PROC 
    mov ax,@data
    mov ds,ax
    
    call tictactoe 
    mov si,offset arr
    mov cx,9
    
    ; Loop to run the game
    
    loop1:

       mov al,turn
       cmp al,1
       je callplayer1
            call player2
            jmp done
       
       callplayer1:
       call player1
       
       done:
       call map
       
       lea dx,enterrow
       mov ah,09
       int 21h
       
       mov ah,1
       int 21h
       sub al,48
       mov rows,al
       
       lea dx,entercol
       mov ah,09
       int 21h
       
       mov ah,1
       int 21h 
       sub al,48
       mov cols,al
       
       mov al,turn
       cmp al,0
       je  elsepart 
            mov si,offset arr
            mov bl,3
            mov al,rows
            sub al,1
            mul bl
            mov bh,cols
            sub bh,1
            
            add  al,bh
            mov bh,0
            mov bl,al
            mov [si+bx],'X'
            
            jmp ok
            
       elsepart:
            mov si,offset arr
            mov bl,3
            mov al,rows
            sub al,1
            mul bl
            mov bh,cols
            sub bh,1
            
            add  al,bh
            mov bh,0
            mov bl,al
            mov [si+bx],'O'
            
       ok:
       
       ; Calling check function for the winner
       
       call CHECK
       
       mov al,endgame
       cmp al,1
       je break
       
       loop loop1
       
       break:
       
       mov al,endgame
       cmp al,0
       jne return
            mov dx,offset drawn
            mov ah,09h
            int 21h
       return:    
     
    mov ah,4ch
    int 21h
    MAIN ENDP
    
    ; Procedure to check the winner
    
    CHECK PROC
          mov ax,@data
          mov ds,ax 
          
          mov si,offset arr
          mov cx,3
          mov bx,0
          
          row:
            mov num,bx
            
            mov al,chr
            cmp al,[si+bx]
            je next1
            jmp startloop
             
            next1:
            inc bx
            cmp al,[si+bx]
            je next2
            jmp startloop
            
            next2:
            inc bx
            cmp al,[si+bx]
            jne startloop
             call winner
            
            
            startloop:
            mov bx,num
            add bx,3
            
            loop  row 
            
          mov si,offset arr
          mov cx,3
          mov bx,0
          
          col:
            
            mov num,bx
            
            mov al,chr
            cmp al,[si+bx]
            je nextc1
            jmp startloopcol
             
            nextc1:
            add bx,3
            cmp al,[si+bx]
            je nextc2
            jmp startloopcol
            
            nextc2:
            add bx,3
            cmp al,[si+bx]
            jne startloopcol
             call winner
            
            startloopcol:
            mov bx,num
            inc bx
            loop  col
            
            mov si,offset arr
            
            mov al,chr
            cmp al,[si]
            je nextd1
            jmp endd
            
            nextd1:
            cmp al,[si+4]
            je nextd2
            jmp endd
            
            nextd2:
            cmp al,[si+8]
            jne endd
            call winner
            
            endd:
            
            mov si,offset arr
            
            mov al,chr
            cmp al,[si+2]
            je nexts1
            jmp enddd
            
            nexts1:
            cmp al,[si+4]
            je nexts2
            jmp enddd
            
            nexts2:
            cmp al,[si+6]
            jne enddd
            call winner
            
            enddd:
            
    ret
    CHECK endp
    
    ; Winner Procedure
    
    winner proc
         mov ax,@data
         mov ds,ax
        
         mov al,chr
         cmp al,79
         jne else
            lea dx,play1win
            mov ah,09
            int 21h
            mov endgame,1
            ret
          else:
            lea dx, play2win
            mov ah,09
            int 21h
            mov endgame,1
    ret
    winner endp
    
    ; Procedure for making the title
    
    tictactoe proc
        mov ax,@data
        mov ds,ax
        
        mov dx,offset tictac
        mov ah,09
        int 21h
    
    ret
    tictactoe endp
    
    ; Procedure for calculation players turn
    
    player1 proc  
        mov ax,@data
        mov ds,ax 
        
        lea dx,play1
        mov ah,09
        int 21h 
        
        mov chr,79
        mov turn,0
       
    ret
    player1 endp 
    
    ; Procedure for calculation players turn
    
    player2 proc  
        mov ax,@data
        mov ds,ax 
        
        lea dx,play2
        mov ah,09
        int 21h 
        
        mov chr,88
        mov turn,1
       
    ret
    player2 endp 
    
    ; Procedure for making the 3x3 box and show elements
    
    map proc
        mov ax,@data
        mov ds,ax
        mov si,offset arr
        
        lea dx,space
        mov ah,09
        int 21h
        
        mov dx,[si]
        mov ah,02h
        int 21h
        
        lea dx,strline
        mov ah,09
        int 21h
         
        mov dx,[si+1]
        mov ah,02h
        int 21h
        
        lea dx,strline
        mov ah,09
        int 21h 
        
        mov dx,[si+2]
        mov ah,02h
        int 21h
        
        lea dx,line
        mov ah,09
        int 21h
        
         mov dx,[si+3]
        mov ah,02h
        int 21h
        
        lea dx,strline
        mov ah,09
        int 21h
         
        mov dx,[si+4]
        mov ah,02h
        int 21h
        
        lea dx,strline
        mov ah,09
        int 21h 
        
        mov dx,[si+5]
        mov ah,02h
        int 21h 
        
        lea dx,line
        mov ah,09
        int 21h
        
        mov dx,[si+6]
        mov ah,02h
        int 21h
        
        lea dx,strline
        mov ah,09
        int 21h
         
        mov dx,[si+7]
        mov ah,02h
        int 21h
        
        lea dx,strline
        mov ah,09
        int 21h 
        
        mov dx,[si+8]
        mov ah,02h
        int 21h 
        
        lea dx,newline
        mov ah,09
        int 21h
    ret
    map endp
end main
ret



