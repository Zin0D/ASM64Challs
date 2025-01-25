# ASM Challenge Solutions

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
; Example: Access a value at 0x404000 with appropriate size (qword, dword, etc.)
```

### Explanation:
- Depending on the data size, you can use `byte ptr`, `word ptr`, `dword ptr`, or `qword ptr` to specify the size of the memory operand you are working with.

---

## Conclusion

Still aint finished with the Module, so no Conclusion yet :P