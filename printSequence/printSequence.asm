; input x in <0-9> 
; if (x>=5) -> print x->0
; else -> print x->9
.model small           
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
    mov dl, al      ; show result
    mov ah, 2       
 
 
 
; compare to 5    
    cmp al, 35h     
    jge greaterEq_5
    
lessThan5:    
    int 21h        
    
    inc dl          ; x++    
    
    cmp dl, 39h     ; x <= 9
    jle lessThan5
    jmp Input
      
greaterEq_5:    
    int 21h       
    
    dec dl          ; n--     
    
    cmp dl,30h      ; n >= 0
    jge greaterEq_5  
    jmp Input


    
Exit:
    mov ah, 0
    int 21h