section .data
greet:  db  'Hello', 0ah, 'what is your name ?', 0ah, 0 ;   Hello\nwhat is your name ?\n\0
greetL:  equ $-greet    ; length of the greet msg above
askcolormsg:    db 'what is your fav color ? ', 0ah, 0; ; what is your fav color ? \n\0
askcolormsglen: equ $-askcolormsg   ; length of the askcolormsg above

%define SYS_WRITE   4   ;   constants to be used
%define SYS_READ    3
%define SYS_EXIT    1

%define STD_OUT_FD  1
%define STD_IN_FD   0

section .bss            ; all uninitialized memory will go here
name: resb  32
color : resb 32


section .text
global _start
    
    _start:

    greeting:
        mov eax, SYS_WRITE
        mov ebx, STD_OUT_FD
        mov ecx, greet
        mov edx, greetL
        int 80h

    getname:
        mov eax, SYS_READ
        mov ebx, STD_IN_FD
        mov ecx, name
        mov edx, 32
        int 80h

    askcolor:
        mov eax, SYS_WRITE
        mov ebx, STD_OUT_FD
        mov ecx, askcolormsg
        mov edx, askcolormsglen
        int 80h

        mov eax, SYS_READ
        mov ebx, STD_IN_FD
        mov ecx, color
        mov edx, 32
        int 80h

    output :
        mov eax, SYS_WRITE
        mov ebx, STD_OUT_FD
        mov ecx, name
        mov edx, 32
        int 80h

        mov eax, SYS_WRITE
        mov ebx, STD_OUT_FD
        mov ecx, color
        mov edx, 32
        int 80h

    exit:
        mov eax, SYS_EXIT
        mov ebx, 0
        int 80h
