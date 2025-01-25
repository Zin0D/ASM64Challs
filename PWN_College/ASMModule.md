#Some ASM Challs sol i had in my notes saved :P
- Most of them are easy enough to pass, but i still decided to upload some Solutions i had saved somewhere.

##Check if number is odd or even without cond jumps:
0x400000:	and   	rdi, 1
0x400004:	xor   	rdi, 1
0x400008:	and   	rax, rdi

##Memory Read and Write
mov rax, [0x404000]

0x400000:	mov   	[0x404000], rax

##Memory-increment
mov r9, [0x404000]  
add [0x40400], qword ptr 0x1337                
mov rax, [0x404000] 
mov rax, r9

##byte-access
mov rax, 0
mov al, [0x40400]

##memory-size-access
