.model small        ; input x in <0-9> -> n times number x ?  
.data 
    msg1 db 10,13, "Enter the number: $"
    msg2 db 10,13, "Result is: $" 
  
  
    
.code
main proc
    mov ax, @data
    mov ds, ax 



Input:
    mov ah, 9       ; show msg
    lea dx, msg1    
    int 21h             
    
    mov ah, 1       ; save input <hex> into al reg
    int 21h           
     
    cmp al, 1bh     ; esc to exit program
    je Exit         
          
    cmp al, 30h     ; enter input again if input is not in range of 0-9
    jb Input        
    cmp al, 39h
    ja Input        
    
    mov ah, 0       ; save num            
    push ax          
    
    mov ah, 9       ; show msg
    lea dx, msg2    
    int 21h           
    
    pop ax          ; get num    
    mov cx, ax      ; create the number of loops
    sub cl, 30h
 
 
          
Show:        
    mov dl, al      
    mov ah, 2
    int 21h             
    loop Show
    jmp Input    
 
 
 
Exit:
    mov ah, 0
    int 21h