# ASM Challenge Solutions
- Decided to document what im doing xd, those are the PWN College ASM Solutions.
- Elliot Alderson of the 0'sum game is the one i aspire to be.

## 1. Check if a number is odd or even without conditional jumps:

This solution checks whether a number (in register `rdi`) is odd or even without using conditional jumps.

```asm
0x400000:	and   	rdi, 1          ; Check the least significant bit
0x400004:	xor   	rdi, 1          ; Invert the result (0 becomes 1, 1 becomes 0)
0x400008:	and   	rax, rdi        ; Store the result in rax (0 for even, 1 for odd)
```

### Explanation:
- The least significant bit (LSB) of a number determines if it is odd or even.
- We `and` the number with `1` to isolate the LSB, then `xor` it to see if its either a 1 or 0
- The final `and` with `rax` keeps only the result of whether the number is odd or even.

---

## 2. Memory Read and Write

This solution reads a value from a memory address and writes it back to the same address.

```asm
mov rax, [0x404000]   ; Read the value from memory address 0x404000
0x400000:	mov   	[0x404000], rax  ; Write the value back to the same memory address
```

### Explanation:
- The value at memory address `0x404000` is loaded into `rax`, and then it is immediately written back to that same memory address.

---

## 3. Memory Increment

This solution increments the value at memory address `0x404000` by `0x1337` and restores the original value to `rax`.

```asm
mov r9, [0x404000]    ; Store the original value from memory address 0x404000 into r9
add [0x40400], qword ptr 0x1337  ; Increment the value at memory address 0x404000 by 0x1337
mov rax, [0x404000]    ; Read the incremented value into rax
mov rax, r9            ; Restore the original value into rax from r9
```

### Explanation:
- First, we store the original value of `0x404000` into `r9`.
- Then, we increment the value stored at `0x404000` by `0x1337`.
- Finally, we load the incremented value into `rax` and restore the original value back from `r9` into `rax`.

---

## 4. Byte Access

This solution demonstrates how to access a single byte from a memory address and store it in `rax`.

```asm
mov rax, 0            ; Set rax to 0
mov al, [0x40400]      ; Load the byte at memory address 0x40400 into the lower byte of rax (al)
```

### Explanation:
- The value at memory address `0x40400` is loaded into the lower byte of the `rax` register (`al`).

---

## 5. Memory Size Access

This solution shows how to access data at a specified memory address, considering different data sizes (e.g., byte, word, dword, qword).

```asm
0x400000:	mov   	rax, 0
0x400007:	mov   	rbx, 0
0x40000e:	mov   	rcx, 0
0x400015:	mov   	rdx, 0
0x40001c:	mov   	al, byte ptr [0x404000]
0x400023:	mov   	bx, word ptr [0x404000]
0x40002b:	mov   	ecx, dword ptr [0x404000]
0x400032:	mov   	rdx, qword ptr [0x404000]
```

### Explanation:
- Depending on the data size, you can use `byte ptr`, `word ptr`, `dword ptr`, or `qword ptr` to specify the size of the memory operand you are working with.

---

## 6. Little-endian-write

In this section, we perform memory writes in little-endian format using x86-64 assembly instructions.

```asm
0x400000:	mov   	rax, 0x00001337         
0x400007:	mov   	dword ptr [rdi], eax   

0x400009:	mov  	rax, 0xdeadbeef       
0x400013:	mov   	dword ptr [rdi + 4], eax 

0x400016:	mov 	rax, 0x0000c0ffee0000       
0x400020:	mov   	qword ptr [rsi], rax   

Instructions are REVERSED: c0ffee
```

### Explanation:
- Data is stored in `memory in reverse order depending on the system's endianness`. In little-endian systems, the least significant byte is stored first, while in big-endian systems, the most significant byte comes first.
As a result, to correctly load data into memory, we may need to `manually reverse` the byte order depending on the system's endianness.
The `mov instruction does not perform any byte order reversal by itself`. It simply moves data as it is, which means we have to handle the reversal manually when necessary.

---

## 7. Memory-sum 

This Solution shows how to access parts of memory. 

```asm
0x400000:	mov   	r8, qword ptr [rdi]
0x400003:	mov   	r9, qword ptr [rdi + 8]
0x400007:	add   	r9, r8
0x40000a:	mov   	qword ptr [rsi], r9
```

### Explanation:
- We can use so called `OFFSETS` , to write to a specific part in memory.

---

## 8. Stack-Subtraction 

Popping and Pushing :P 

```asm
0x400000:	xor   	rax, rax
0x400003:	pop   	rax
0x400004:	sub   	rax, rdi
0x400007:	push  	rax
```

### Explanation:
- Pushing and Popping are `OPERANDS` used to add or remove Values from the Stack
- Using `PUSH`, we can add a value ontop of the Stack, (RSP+8)
- Using `POP` , we shorten the Stack by removing a value from it, and saving it in the mentioned Register.

---

## 9. Swap-Stack-Values

This Solution demonstrates how to `exchange Values` using the Stack.

```asm
0x400000:	push  	rdi
0x400001:	push  	rsi
0x400002:	pop   	rdi
0x400003:	pop   	rsi
```

### Explanation:
- As stated in `9.` we can add and remove values from the Stack and store them in the specified registers.
- Therefore we can also `exchange Values` between other Registers using the Stack.

---

## 10. Average-Stack-Values

This Section shows how to `take values stored on the stack`, and work with them.
In this case, `we addeded all of the Values` and then divided them by the amount of Defrences.

```asm
0x400000:	mov   	r9, qword ptr [rsp]
0x400004:	mov   	r8, qword ptr [rsp + 8]
0x400009:	add   	r9, r8
0x40000c:	mov   	r8, qword ptr [rsp + 0x10]
0x400011:	add   	r9, r8
0x400014:	mov   	r8, qword ptr [rsp + 0x18]
0x400019:	add   	r9, r8

0x40001c:	mov   	rdi, 0
0x400023:	mov   	rax, r9
0x400026:	mov   	rcx, 4
0x40002d:	div   	rcx
0x400030:	push  	rax
```

### Explanation:
- Since the` RSP points to a value` stored on the Stack, we can defrence it and `access` the `values on the Stack`, such as other Adresses or Values.
- `Therefore we can also interact with the values`.
- In this case, adding them all together and dividing them by the amount of QWORDS stored on the stack, provided the Solution.

---

## 11. Absoloute-Jump 

Solution to the Abosloute jump.

```asm
xor rax, rax
mov rax, 0x403000
jmp rax
```

### Explanation:
- JMP instructions are by default `Absolute`

---

## 12. relative-jump

This Section demonstrates how `relative postions (OFFSETS)` look like
in action.
Also demonstrates how to use the .rept tag, to `repeat an instruction`
`n amount of times`.

```asm
_start:
jmp oof

.rept 81
nop
.endr


oof:
mov rax, 0x1
```

### Explanation:
- Each instruction is `stored in memory`, therefore each instruction has an `adress pointing to it`.
  We can use this to determine `OFFSETS`, which will help in `creating Exploits` later on.

--- 

## 13. Jump-Trampoline

This Section is similar to `.12` and demonstrates how Instructions are fed into memory.
And How the offset can be used to determine the lenght from `BASE` to Instruction.

```asm
_start:
jmp oof

.rept 81
nop
.endr

oof:
pop rdi
xor rax, rax
mov rax, 0x403000
jmp rax
```

### Explanation:
- Solution that demonstrates, like in `.12` how `Instructions are stored`
  At the Offset `BASE+81` , the oof section's instructions begin.

---

## 14. Conditional-Jump

This Section is a bit `tougher` and basically `implements the if, if - else, else logic` in assembly:

Given Code:
```C 
if [x] is 0x7f454c46:
    y = [x+4] + [x+8] + [x+12]
else if [x] is 0x00005A4D:
    y = [x+4] - [x+8] - [x+12]
else:
    y = [x+4] * [x+8] * [x+12]
```
`Self written code`

```asm
_start:
xor rax, rax 
mov r8d, 0x7f454c46
cmp r8d, [rdi]
je _loompa

mov r8d, 0x00005A4D
cmp r8d, [rdi]
je _lucker

movsx eax, dword ptr [rdi+4]
imul eax, dword ptr [rdi+8]
imul eax, dword ptr [rdi+12]
jmp _exit

_loompa:
movsx eax, dword ptr [rdi+4]
add eax, dword ptr [rdi+8]
add eax, dword ptr [rdi+12]
jmp _exit

_lucker:
movsx eax, dword ptr [rdi+4]
sub eax, dword ptr [rdi+8]
sub eax, dword ptr [rdi+12]
jmp _exit

_exit:
```

### Explanation: 

This implementation demonstrates the use of conditional statements `(if, if else, else)` in Assembly language.
It leverages techniques such as `fallthrough` and `conditional` jumps to manage control flow efficiently. 
The challenge specifically involves working with `signed values`, making it necessary to account for both positive and negative conditions within the control flow logic.

---

## 15. Indirect-Jump

Using CMPS to determine when to JMP.

```asm
_start:
cmp rdi, 3
ja _default

_iSee:
lea rax, [rsi + rdi * 8] 
jmp [rax]

_default:
lea rax, [rsi + 4 * 8]
jmp [rax]
```
### Explanation:
`CMPS` compare Values and can be used to create an `If, Else logic`, or a `switch-case logic`
Knowing this, we can implement all kinds of Boolean Logic, the Code above demonstrates this, using `Switch` Statements.

---

## BREAK. HowToFUckUP

Reading a Chall wrong caused me to do something completely different.
Although what i did can also be considered a Challenge so i decided to incl it in here:

```C
average = 0
i = 0
while x[i] < 0xff:
  average += x[i]
  i += 1
average /= i
```

```asm
.intel_syntax noprefix
.global _start

_start:
cmp rdi, 0
je _exit

mov r9, 0
mov rax, 0

loop:
add r9b, byte ptr [rdi + rax * 1]
inc rax
cmp byte ptr [rdi + rax * 1], 0xff
jl loop
jmp _fin

_exit:
mov rax, 0

_fin:
mov rcx, rax
mov rax, r9
div rcx
```

### Explanation:
I wrote the C Code above in ASM to `try replicate the Logic`.

---

## 16. Average-loop

Looping untill a Condition is hit.

```asm
start:
mov r9, 0
xor rax, rax
mov rax, qword ptr [rdi]

_loop:
inc r9
add rax, qword ptr [rdi+r9*8]
cmp r9, rsi
jle _loop

xor rdi, rdi   
mov rdi, rsi
div rdi
```

### Explanation:
We want to `loop and set a break condition`.
We use the `cmp` instruction as a type of checker, that subtracts 2 values from each other.
The `result is stored in a $Variable which allows us, to access its content and control jmp instructions` 

---

## 17. Count-non-zero

For each ADDRESSSPACE, we count if Data is available, if 0x00, then exit.

```ASM
_start:
mov rax,0
mov r9b, byte ptr [rdi + rbx]
cmp r9b, 0
je _exit

_loop:
inc rax
mov r9b, byte ptr [rdi + rbx]
cmp r9b, 0
jne _loop


_exit:
```

### Explanation:
We can look into an `ADRESS Space` by moving an `amount of n lenght of said space into a register.`
For example, moving into al, byte ptr [SomeRegister]
Like this we can `evaluate`, we can use that to do actions such as `Check if data is available`.

---

## Conclusion

A really good module to get the basics down :P
More Content to read is listed on PWNCollege to deepen da knowlledge.