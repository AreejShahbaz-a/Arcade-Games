.model small
.data    
msg1 db 'Player 1, please enter a number between 0-9!$' 
number db 0   
msg2 db 'Player 2, guess the number!$'
msg3 db 'Incorrect! You have tries:$'
msg4 db 'Player 1s number is higher$'   
msg5 db 'Player 1s number is lower$'  
msg6 db 'You have lost!$'   
msg7 db 'You have won!$'
tries db '2'
.code 
main proc
    mov ax,@data
    mov ds,ax
    
    mov dx,offset msg1
    mov ah,9 
    int 21h
    
    mov ah,1
    int 21h
    
    mov number,al 
    
    mov ah,0
    int 10h
    
    mov cx,3
    chances: 
    
    mov dx,offset msg2 
    mov ah,9
    int 21h    
    
    mov ah,1
    int 21h 
    
    mov bl,al
     
    mov dl,10
    mov ah,2
    int 21h
    
    mov dl,13
    mov ah,2
    int 21h  
    
    cmp number,bl
    je equal
     
    mov dx,offset msg3
    mov ah,9 
    int 21h 
    
    mov dl,tries
    mov ah,2
    int 21h  
    
    dec tries 
    
    mov dl,10
    mov ah,2
    int 21h
    
    mov dl,13
    mov ah,2
    int 21h  
    
    cmp tries,47
    je lost
     
    cmp number,bl
    jb lower
     
    mov dx,offset msg4
    mov ah,9  
    int 21h  
    jmp again
            
    lower: 
    mov dx,offset msg5
    mov ah,9 
    int 21h 
    
    again:
    mov dl,10
    mov ah,2
    int 21h
    
    mov dl,13
    mov ah,2
    int 21h 
    
    loop chances
    
    lost: 
    mov dx,offset msg6
    mov ah,9 
    int 21h 
    
    mov ah,4ch
    int 21h
    
    equal:
    mov dx,offset msg7
    mov ah,9
    int 21h
    
    mov ah,4ch
    int 21h  
    
main endp
end main