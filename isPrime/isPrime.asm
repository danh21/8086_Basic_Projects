.model small        ; input <0-9> -> prime number ?  
.data 
    msg1 db 10,13, "Enter the number: $"
    msg2 db 10,13, "This number is a prime number $" 
    msg3 db 10,13, "This number is not a prime number $" 
      
      
      
.code
main proc
    mov ax, @data
    mov ds, ax
    mov bp, 1   
    
    
    
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
    
    mov bl, al      ; compare to 1 
    sub bx, 30h            
    cmp bx, bp      
    jna isNotPrime  ; x <= 1  
    mov cx, bx      ; x > 1 -> create the number of loops        
 
 
 
Division: 
    mov ax, bx      ; bx is original number  
    div cl          ; divisor is in <bx -> 1>   
    
    cmp ah, 0       ; compare remainder to 0
    je Count       
    
resetRemainder:    
    mov ah, 0       
    loop Division   



Classification:
    cmp dl, 2       ; compare count to 2
    jne isNotPrime 
              
isPrime:
    mov ah, 9
    lea dx, msg2      
    int 21h 
    jmp Input
        
isNotPrime:
    mov ah, 9
    lea dx, msg3      
    int 21h 
    jmp Input
 
 
    
Count:
    inc dl          ; count++
    jmp resetRemainder
    
    
    
Exit:
    mov ah, 0
    int 21h 