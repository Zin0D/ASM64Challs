global _start

section .text
_start:
    mov rax,0xa284ee5c7cde4bd7
    push   rax
    mov rax,0x935add110510849a
    push   rax
    mov rax,0x10b29a9dab697500
    push   rax
    mov rax,0x200ce3eb0d96459a
    push   rax
    mov rax,0xe64c30e305108462
    push   rax
    mov rax,0x69cd355c7c3e0c51
    push   rax
    mov rax,0x65659a2584a185d6
    push   rax
    mov rax,0x69ff00506c6c5000
    push   rax
    mov rax,0x3127e434aa505681
    push   rax
    mov rax,0x6af2a5571e69ff48
    push   rax
    mov rax,0x6d179aaff20709e6
    push   rax
    mov rax,0x9ae3f152315bf1c9
    push   rax
    mov rax,0x373ab4bb0900179a
    push   rax
    mov rax,0x69751244059aa2a3
    push   rax
    mov rbx,0x2144d2144d2144d2 ;

    ;START OF MY CODE
    xor r9, r9

GOOFY:
    mov r10, rbx
    xor [rsp], rbx ;xor with the key;
    mov rbx, r10
    mov rax, 1
    mov rdi, 1
    mov rsi, [rsp]
    mov rdx, 8 ;8 bytes to read.
    syscall
    lea rsp, [rsp + 8]
    inc r9
    cmp r9, 14
    jnz GOOFY

EXIT:
    xor rax, rax
    xor rdi, rdi
    mov al, 60
    mov dil, 60
    syscall


;14 shellcodes to be xored, we can also use loop. 112 bytes

;extracted shellcode, placed in reverse order (SWITCHED TOP W BOTTOM, to retrieve correct shellcode)

;Reversed Order of the Content (In the Challenge, running given Shellcode is enough)
;but in reality, when pushing, the last to go in, is the first to go out.
;meaning u switch positions, when pushing a string , the Order of the Positions get switched, last to first
;first to last, with this keep in mind, that if this was a real challenge.
;the presented block below would be the correct shellcode

;83c03c4831ff0f05
;b21e0f054831c048
;31f64889e64831d2
;014831ff40b70148
;c708e2f74831c0b0
;4889e748311f4883
;44214831c980c104
;48bbd244214d14d2
;10633620e7711253
;4bb677435348bb9a
;4c5348bbbf264d34
;bba723467c7ab51b
;167e66af44215348
;4831c05048bbe671

;u can always rearange the contents, if u dont know the arragment.
;First becomes last, and positions swap, u should get the arragement pretty easily, smile.

;For Solving the Challenge therefore, input this string into !Shellcoding.py as the second Argument
;'4831c05048bbe671167e66af44215348bba723467c7ab51b4c5348bbbf264d344bb677435348bb9a10633620e771125348bbd244214d14d244214831c980c1044889e748311f4883c708e2f74831c0b0014831ff40b7014831f64889e64831d2b21e0f054831c04883c03c4831ff0f05'

