#!/usr/bin/python3

""" EXTRACT SHELLCODE OF AN ELF BINARY"""

import sys
from pwn import *

context(os="linux", arch="amd64", log_level="error")

file = ELF(sys.argv[1])
shellcode = file.section(".text")
print(shellcode.hex())      