# ASM Challenge Solutions
- Decided to document what im doing xd, those are the PWN College ASM Solutions. 

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

## 9. Average-Stack-Values

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

## Conclusion

Still aint finished with the Module, so no Conclusion yet :P