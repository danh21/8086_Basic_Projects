;bin (max 16bit), int "b" -> dec
.model small                                                 
.data 
    msg1 db 10,13, "Enter the binary number: $"
    msg2 db 10,13, "The decimal value is: $"



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
      
handleInput: 
    inc dl              ; input enough 16 bits ?
    cmp dl, 11h         
    je Convert    
    
    mov ah, 1           ; input value
    int 21h             
    
    cmp al, 'b'         ; interrupt
    je Convert          
       
    sub ax, 130h        ; handle input
    shl bx, 1             
    or bx, ax          
     
    jmp handleInput
 
 
                               
Convert:        
    mov ah, 9           ; show msg
    lea dx, msg2      
    int 21h     
    
    mov ax, bx          ; assign
    call handleResult

 
        
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