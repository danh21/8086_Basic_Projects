.model small                                                 
.data 
    msg1 db 10,13, "Enter the exponent: $"
    msg2 db 10,13, "Result is: $"



.code     
main proc
    mov ax, @data 
    mov ds, ax   
    mov bp, 10          ; const



Input:
    mov ah, 9           ; show msg
    lea dx, msg1       
    int 21h         
    
    mov ah, 1           ; input exponent
    int 21h             
    
    cmp al, 1bh         ; esc to exit program
    je Exit                 
    
    cmp al, 30h         ; enter input again if input is not in range of 0-9
    jb False        
    cmp al, 39h
    ja False 
    jmp True
  
  
    
False:    
    mov dl, 'F'         ; print 'F' 
    mov ah, 2     
    int 21h         
    jmp Input 
     
     
         
True:
    sub al, 30h         ; get exponent
    mov cl, al           
        
    mov dl, 'T'         ; print 'T'         
    mov ah, 2           
    int 21h         
    
    mov ah, 9           ; show msg
    lea dx, msg2       
    int 21h          
    
    mov ax, 1           ; calculate power of 2
    rol ax, cl              
    
    mov cl, 0           ; reset to handle result
    call handleResult
    jmp Input
 
 
 
Exit:
    mov ah, 0
    int 21h 
  
  
  
handleResult: 
    inc cl              ; create the number of loops 
    
    mov dx, 0           ; ax / 10   
    div bp                     
    push dx             ; save remainder into stack to show result 
        
    cmp ax, 0           ; check processing is done ?
    jne handleResult
              
              
              
showResult:             
    pop dx              ; pop data to show
    add dl, 30h   
     
    mov ah, 2           ; show result
    int 21h      
    loop showResult            
    ret         