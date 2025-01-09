#!/usr/bin/python3

import pwn
import sys

shellcode = sys.argv[1]

""" Being able to run a ShellCode on a Machine is powerfull """
""" EXTRACT ShellCode:
    file.section(".text").hex()
"""
x = input("INPUT 1 for EXECUTING SHELLCODE, 2 ")
match x:
    case "1":
        pwn.context(os="Linux", arch="amd64", log_level="error")
        pwn.run_shellcode(pwn.unhex(shellcode)).interactive() 
    case "2":
        print("%d bytes - Found NULL byte" % len(shellcode)) if [i for i in shellcode if i == 0] else print("%d bytes - No NULL bytes" % len(shellcode))

""" IMPORTANT THING FOR SHELLCODING """
""" Does not contain variables
    Does not refer to direct memory addresses
    Does not contain any NULL bytes 00
""" 
    