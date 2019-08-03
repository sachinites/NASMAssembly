section .data
    num1: dw    99
    num2: dw    99
    msg1: db 'num1 is greater than num2', 0ah, 0
    msg1len equ $ - msg1
    msg2: db 'num2 is greater than num1', 0ah, 0
    msg2len equ $ - msg2
    msg3: db 'num1 is equal to num2', 0ah, 0
    msg3len equ $ - msg3

%define SYS_WRITE   4   ;   constants to be used
%define SYS_READ    3
%define SYS_EXIT    1

%define STD_OUT_FD  1
%define STD_IN_FD   0

section .bss            ; all uninitialized memory will go here

section .text

global _start
    
    _start:
        mov ax, [num1]
        CMP ax, [num2]
        ; A very good description about Jump instruction is here
        ; https://www.tutorialspoint.com/assembly_programming/assembly_conditions.htm
        JB NUM1_LESS_THAN_NUM2  ;   jump if below
        JE NUM1_EQUAL_NUM2      ;   jump if equal
        JMP NUM2_LESS_THAN_NUM1 ;   Unconditional Jump

    NUM1_LESS_THAN_NUM2:
        mov eax, SYS_WRITE
        mov ebx, STD_OUT_FD
        mov ecx, msg2
        mov edx, msg2len
        int 80h
        JMP exit

    NUM1_EQUAL_NUM2:
        mov eax, SYS_WRITE
        mov ebx, STD_OUT_FD
        mov ecx, msg3
        mov edx, msg3len
        int 80h
        JMP exit

    NUM2_LESS_THAN_NUM1:
        mov eax, SYS_WRITE
        mov ebx, STD_OUT_FD
        mov ecx, msg1
        mov edx, msg1len
        int 80h
        
    exit:
        mov eax, SYS_EXIT
        mov ebx, 0
        int 80h
