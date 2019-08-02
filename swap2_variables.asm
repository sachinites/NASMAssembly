section .data
C equ 15                   ; C is a contant
var1: db 12                ; NASM needs a colon after labels unlike MASM

section .bss
var2: resb 1               ; NASM doesn't have '?'. Use RESB to allocate space
; in BSS section. RESB 1 allocates 1 byte of space

section .code
global _start
_start:

mov byte [var2], C         ; C doesn't need brackets because it was defined with EQU
;     and is a constant (immediate) value.
;     NASM can't determine the size of a constant
;     nor does it know the size of data at var2
;     so the BYTE directive is used on the memory operand.

; swap var1 and var2

mov al, [var1]             ; Getting data from var1 - brackets needed
mov bl, [var2]             ; Getting data from var2 - brackets needed
mov [var2], al             ; Changing value at var2 - brackets needed
mov [var1], bl             ; Changing value at var1 - brackets needed

; now print the swapped values
mov eax, 4  ;   4 = sys_write, But sys_wrte dont print integers, it print strings, so do not expect any output on screen
mov ebx, 1  ;   1 - std out FD
mov ecx, var1              ; No brackets because we want the address of var1
mov edx, 1                 ; Print 1 byte
int 80h                    ; interrupt the kernel to invoke system call stored in eax

mov eax, 4  ;   4 = sys_write
mov ebx, 1  ;   1 - std out FD
mov ecx, var2              ; No brackets because we want the address of var1

mov edx, 1                 ; Print 1 byte
int 80h

; exit the program
mov eax, 1  ; 1 = sys_exit
mov ebx, 0
int 80h
