.model small
.stack 100h
.data 
msg1 db 'Enter word to guess$'
msg2 db 'Enter guess$'
msg3 db 'You have lost,guess again you have tries:$'
msg4 db 'You have won$'
tries db '2' 
incorrect db 0
outlength dw 0 
length dw 0
guessarr db 10 dup(?)
arr db 10 dup(?) 
arr2 db 10 dup(?)
rand dw 0
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov dx, offset msg1
    mov ah,9
    int 21h
    
    mov si ,offset arr 
    mov bx ,offset arr2
    input:
    mov ah,1
    int 21h
    cmp al,13
    je enter
    mov [si],al 
    mov [bx],al
    inc si 
    inc bx
    inc dx
    jmp input
    
    enter:
    mov outlength,dx  
    dec dx
    mov length,dx
    random:
    xor ax,ax
    int 1ah
    mov al,dl
    
    xor dx,dx
    mov bx,25
    div bx
    
    cmp ax,length  
    ja random
    mov rand,ax
    
    mov si,length
    mov dl,arr[si]
    mov si,rand
    mov al,arr[si]
    mov si,length
    mov arr[si],al
    mov si,rand
    mov arr[si],dl
    
    dec length
    cmp length,0
    ja random
    
    mov ah,0
    int 10h
    
    mov si,offset arr
    mov cx,outlength
    output:
    mov dl,[si]
    mov ah,2
    int 21h
    inc si
    loop output
    
    again:
    mov incorrect,0
    
    mov dl,10
    mov ah,2
    int 21h
    
    mov dl,13
    mov ah,2
    int 21h
    
    mov dx, offset msg2
    mov ah,9
    int 21h
    
    mov dl,10
    mov ah,2
    int 21h
    
    mov dl,13
    mov ah,2
    int 21h
    
    mov cx,outlength  
    mov si,offset guessarr
    guessinput:
    mov ah,1
    int 21h 
    mov [si],al
    inc si
    loop guessinput
    
    mov cx,outlength  
    mov si,offset guessarr
    mov di,offset arr2
    check:  
    mov dl,[di]
    cmp [si],dl
    je equal
    mov incorrect,1
    equal:
    inc si 
    inc di
    loop check  
    
    mov dl,10
    mov ah,2
    int 21h
    
    mov dl,13
    mov ah,2
    int 21h
    
    cmp incorrect,0
    je won 
    
    mov dx, offset msg3
    mov ah,9
    int 21h 
    
    mov dl, tries
    mov ah,2
    int 21h
     
    dec tries
    cmp tries,47
    ja again 
    
    cmp tries,47
    je over
    
    won:
    mov dx, offset msg4
    mov ah,9
    int 21h
     
    over: 
    mov ah,4ch
    int 21h
    