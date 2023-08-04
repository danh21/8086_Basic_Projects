.model small
                                           
.data 
    msg1 db 10,13, "Enter the first number: $"             ; 10,13 -> /n
    msg2 db 10,13, "Enter the second number: $"  
    msg3 db 10,13, "The sum of 2 numbers: $"
    msg4 db 10,13, "The different of 2 number: $" 
    msg5 db "-$"
    msg6 db 10,13, "The product of 2 numbers: $" 
    msg7 db 10,13, "The quotient of 2 numbers: $"
    msg8 db 10,13, "The remainder of division: $" 



.code     
main proc
    mov ax, @data 
    mov ds, ax   
    mov bp, 10  
    mov cx, 0
          
          
          
InputNum1: 
    mov ah, 9           ; show msg
    lea dx, msg1       
    int 21h   
               
    mov ah, 1           ; save input <hex> into al reg
    int 21h            
          
    cmp al, 30h         ; enter input again if input is not in range of 0-9
    jb InputNum1    
    cmp al, 39h          
    ja InputNum1  
           
    sub al, 30h         ; save num1 to calculate
    mov ah, 0            
    push ax                 
          
          
          
InputNum2:
    mov ah,9            ; show msg
    lea dx, msg2         
    int 21h     
           
    mov ah, 1           ; save input <hex> into al reg
    int 21h       
            
    cmp al, 30h         ; enter input again if input is not in range of 0-9 
    jb InputNum2     
    cmp al, 39h          
    ja InputNum2  
           
    sub al, 30h         ; save num2 to calculate
    mov ah, 0            
    push ax                  
          
          
          
Addition:          
    mov ah, 9           ; show msg
    lea dx, msg3        
    int 21h        
       
    call getOperands            
    add ax, bx          ; add  
          
    call handleResult   
           
           
           
Subtraction:          
    mov ah, 9           ; show msg
    lea dx, msg4        
    int 21h             
    
    call getOperands      
    cmp ax, bx          ; compare 2 numbers
    jb signed           ; num1 < num2
    jnb unsigned        ; num1 >= num2  
        
unsigned:    
    sub ax, bx          ; sub   
            
    call handleResult        
    jmp Multiplication   
    
signed: 
    mov ah, 9           ; show msg
    lea dx, msg5        
    int 21h      
    
    call getOperands    
    sub bx, ax          ; sub
    mov ax, bx 
             
    call handleResult 
      
      
        
Multiplication:    
    mov ah, 9           ; show msg
    lea dx, msg6       
    int 21h       
    
    call getOperands    ; mul   
    mul bl              
            
    call handleResult                 
      
      
      
Division:
    mov ah, 9           ; show msg
    lea dx, msg7       
    int 21h                
    
    call getOperands    ; div
    div bl              ; quotient
    mov bl, ah          ; remainder 
        
    call handleResult        
                     
    mov ah, 9           ; show msg
    lea dx, msg8       
    int 21h                
    
    mov ax, bx          ; get remainder
    call handleResult
       
       
       
Exit:
    mov ah, 0
    int 21h     
   
   
   
getOperands:
    pop si              ; address
    pop bx              ; num2
    pop ax              ; num1 
      
    push ax             ; save num1 into stack to calculate 
    push bx             ; save num2 into stack to calculate
    push si             ; save address to return previous block code
    ret
    
    
       
handleResult: 
    inc cl              ; create the number of loops 
    
    mov ah, 0           ; number separation
    mov dx, 0              
    div bp
    push dx             ; save number into stack to show result  
       
    cmp ax, 0           ; check done processing ?
    jne handleResult
    
    
    
showResult:             
    pop dx              ; get number to display
    add dl, 30h        
    
    mov ah, 2           ; display result
    int 21h      
    loop showResult            
    ret                 