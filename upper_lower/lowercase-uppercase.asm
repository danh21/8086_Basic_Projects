.model small            ; lowercase <-> toUpper
.data 
    msg1 db 10,13, "Enter the character: $"
    msg2 db 10,13, "Lowercase character: $"
    msg3 db 10,13, "Uppercase character: $" 
 
 
    
.code
main proc
    mov ax, @data
    mov ds, ax 
 
 
    
Input:
    mov ah, 9
    lea dx, msg1        ; show msg    
    int 21h
        
    mov ah, 1           ; input char
    int 21h             
    
    cmp al, 1bh         ; esc to exit program
    je Exit
    
    push ax

    cmp al, 61h         ; c < 'a'
    jb cmpToA  
           
    cmp al, 7ah         ; c <= 'z'
    jbe toUpper
    jmp Input   
    
cmpToA:
    cmp al, 41h         ; c < 'A'    
    jb Input 
                  
    cmp al, 5ah         ; c > 'Z'
    ja Input


 
toLower:  
    mov ah, 9           ; show msg
    lea dx, msg2     
    int 21h
    
    pop ax               
    add al, 20h         ; upper -> lower   
    
    mov dl, al       
    mov ah, 2           ; show result
    int 21h         
    
    jmp Input


    
toUpper: 
    mov ah, 9           ; show msg
    lea dx, msg3    
    int 21h  
    
    pop ax              
    sub al, 20h         ; upper -> lower 
    
    mov dl, al  
    mov ah,2            ; show result
    int 21h   
    
    jmp Input 
 
 
    
Exit:
    mov ah, 0
    int 21h                