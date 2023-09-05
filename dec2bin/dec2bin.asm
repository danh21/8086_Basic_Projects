;dec , int "d" -> bin and print 'E' (even) or 'O' (odd)
.model small                                                 
.data 
    msg1 db 10,13, "Enter the decimal number: $"
    msg2 db 10,13, "The binary value is: $" 
    msg3 db 10,13, "This number is: $"



.code     
main proc
    mov ax, @data 
    mov ds, ax   
    mov bp, 10  
    mov cx, 0               


    
Input:
    mov ah, 9           ; show msg
    lea dx, msg1       
    int 21h 
    mov ax, 0 
      
handleInput: 
    mov si, ax          ; store
    mul bp              ; x10
    mov di, ax            
    
    cmp bl, 4           ; max 4 digits
    je Convert          
    
    mov ah, 1           ; input
    int 21h            
    
    cmp al, 'd'         ; interrupt
    je Convert            
                              
    sub ax, 130h        ; handle input
    add ax, di     
               
    inc bl             
    
    jmp handleInput    



Convert: 
    mov bp, 2           
    
    mov ah, 9           ; show msg
    lea dx, msg2      
    int 21h             
    
    mov ax, si          ; assign 
    
    call handleResult


    
;Classification:
    mov ah, 9           ; show msg
    lea dx, msg3      
    int 21h      
    
    mov ax, si          ; assign           
    mov dx, 0           ; /2 to check even or odd
    div bp                    
    
    cmp dx, 0
    je Even 
    
Odd:      
    mov dl,'O'    
    mov ah, 2
    int 21h
    jmp Exit 
    
Even:   
    mov dl,'E'  
    mov ah, 2
    int 21h   


        
Exit:
    mov ah, 0
    int 21h 


    
handleResult: 
    inc cl              ; create the number of loops 
    
    mov dx, 0              
    div bp
    push dx             ; save remainder into stack to show result        
    
    cmp ax, 0
    jne handleResult
    
showResult:             
    pop dx
    add dl, 30h     
    
    mov ah, 2
    int 21h       
    
    loop showResult    
            
    ret                    