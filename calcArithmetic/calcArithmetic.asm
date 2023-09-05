.model small                                                 
.data 
    msg1 db 10,13, "Enter the first number: $"   ; 10,13 -> /n
    msg2 db 10,13, "Enter the second number: $"  
    msg3 db 10,13, "The sum of 2 numbers: $"
    msg4 db 10,13, "The different of 2 number: $"
    msg5 db "-$"
    msg6 db 10,13, "Enter the number of digits: $" 



.code     
main proc
    mov ax, @data 
    mov ds, ax   
    mov bp, 10         ; const
    mov cx, 0



Input_numsDig:
    mov ah, 9           ; show msg
    lea dx, msg6       
    int 21h                
    
    mov ah, 1           ; input value
    int 21h
      
    cmp al, 30h         ; enter input again if input is not in range of 0-9
    jb Input_numsDig        
    cmp al, 39h
    ja Input_numsDig         
    
    cmp al, 30h         ; compare to classify
    je False        
    cmp al, 34h
    jle True    
        
False:    
    mov dl, 'F'         
    mov ah, 2     
    int 21h            
    jmp Input_numsDig     
                        
True:
    mov ah, 0           
    sub al, 30h
    mov si, ax          ; number of digits         
    mov dl, 'T'          
    mov ah, 2    
    int 21h  
          
          
          
Input_Num1:
    mov ah, 9           ; show msg
    lea dx, msg1       
    int 21h              
    
    mov cx, si          ; create the number of loops
    call handleInput        
    
    mov di, 0           ; reset
    push ax             ; store num1
         
         
         
Input_Num2:
    mov ah, 9           ; show msg
    lea dx, msg2       
    int 21h        
    
    mov cx, si          ; create the number of loops
    call handleInput    
    
    push ax             ; store num2 
        
        
        
Summation:          
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
    jmp Exit
     
signed: 
    mov ah, 9           ; show msg
    lea dx, msg5        
    int 21h     
    call getOperands    
    sub bx, ax          ; sub
    mov ax, bx          
    call handleResult   
   
   
    
Exit:
    mov ah, 0
    int 21h 
 
 
 
x10:    
    mul bp          
    mov di, ax  
         
handleInput:   
    mov ah, 1             
    int 21h   
    
    sub al, 30h 
    mov ah, 0  
           
    add ax, di
    loop x10              
    ret
      
      
      
getOperands:
    pop si              ; address of previous block code
    pop bx              ; num2
    pop ax              ; num1       
    
    push ax             ; store num1 again to calculate 
    push bx             ; store num2 again to calculate
    push si             ; store address to return previous block code   
    
    ret
       
       
                        
handleResult: 
    inc cl              ; create the number of loops 
    
    mov dx, 0              
    div bp
    push dx             ; store remainder to show result  
       
    cmp ax, 0
    jne handleResult
           
           
           
showResult:             
    pop dx
    add dl, 30h
        
    mov ah, 2
    int 21h               
    
    loop showResult    
            
    ret  