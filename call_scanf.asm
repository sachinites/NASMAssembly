; Steps to compile this program
; This program uses scanf.c file and invoke get_int fn from it

; nasm -f elf call_scanf.asm
; gcc -c scanf.c -o scanf.o
; ld scanf.o call_scanf.o -lc -I /lib/ld-linux.so.2 -o exe


; C standard functions which we will going to
; call from this assembly code

extern get_int  ; user defeined function
extern printf   ; standard C function
extern exit     ; standard C function

%define SYS_WRITE   4   ;   constants to be used
%define SYS_READ    3
%define SYS_EXIT    1

%define STD_OUT_FD  1
%define STD_IN_FD   0


section .data
msg1:   db 'Value entered is %d', 10, 0


section .bss            ; all uninitialized memory will go here

section .text

global _start
    
    _start:
    call get_int
    
    ; printf(<format>, <parameters>)

    mov ebx, eax    ;   store input value
    push eax
    push msg1
    call printf
        
    push 0  ;   arg of exit
    call exit
