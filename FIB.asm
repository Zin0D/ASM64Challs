global _start
extern printf, scanf

; Fib in Assembly, tried to do some tricks and Tips, i love ASM -Zin

;%d to accept input of integers.
;%ld to  accept input of long integers
;%lld to accept input of long long integers
;%f to accept input of real number.
;%c to accept input of character types.
;%s to accept input of a string.


section .data
	message db "Zin0D's World, Please Input FN Iterrations.", 0x0a
	outFormat db "%lld", 0x0a, 0x00 
	read db "%d", 0x00
	message2 db "Finished Calculations.", 0x0a ;21

section .bss
	userInput resb 1 ;Needs to be modified to allow higher Ints than 256.	

section .text
_start:
	call msg
	call input
	call initFib
	call loopFib
	call Exiting
	ret
	
msg:
	mov rax, 1 ;Syscall No 1 for Write
	mov rdi, 1
	mov rsi, message
	mov rdx,  44 ;Def the 44 Bytes Buffer to read from
	syscall
	ret
	
input:
	push rcx ;Align Stack
	mov rdi, read
	mov rsi, userInput
	call scanf
	pop rcx

initFib:
	xor rax, rax
	xor rbx, rbx
	xor rcx, rcx 
	inc rbx
	ret

printFib:
	push rax 
	push rbx 
	mov rdi, outFormat
	mov rsi, rbx  
	call printf  
	pop rbx 
	pop rax 
	ret 

loopFib:
	inc rcx
	push rcx
	push rcx
	call printFib
	add rax, rbx 
	xchg rax, rbx
	pop rcx
	pop rcx
	cmp rcx, [userInput] ; We want to compare the Value, not the Pointer xD
	jl loopFib
	ret 

Exiting:
	mov rax, 1 
	mov rdi, 1
	mov rsi, message2
	mov rdx, 21 
	syscall
	
	mov rax, 60
	mov rdi, 0
	syscall ;Exit da Programm
       