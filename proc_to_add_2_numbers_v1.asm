
    ; Check my website for free and more courses : 
    ; http://csepracticals.wixsite.com/csepracticals

; Steps to compile this program
; This program uses scanf.c file and invoke get_int fn from it

; nasm -f elf proc_to_add_2_numbers.asm
; gcc -c scanf.c -o scanf.o
; ld scanf.o proc_to_add_2_numbers.o -lc -I /lib/ld-linux.so.2 -o proc_to_add_2_numbers


; C standard functions which we will going to
; call from this assembly code

extern get_int  ; user defeined function
extern printf   ; standard C function
extern exit     ; standard C function

section .data
    var1:   dd  0
    var2:   dd  0
    format: db 'sum of numbers %d and %d = %d', 10, 0

section .bss            ; all uninitialized memory will go here

section .text

add:
    ; control transfers to subroutine 'add' now, arguments
    ; and eip are already pushed into stack memory by caller
    ; time to setup base pointer register now
    push ebp  ; STEP 4.1 Store caller's base address into stack memory of calle
    mov ebp, esp    ;   STEP 4.2 update ebp with callee's base address now
    
    ; STEP 6 : Callee executation starts from here, there is no STEP 5 in this example
    ; as there is no local variable used
    ; initialize the eax register that will store the result - the return value of this routine
    ; Remember, the return value of the subroutine are stored in eax register
    mov eax, 0         
    
    ;   Compute addition of two numbers. Note that arguments are accessed using ebp as a reference
    add eax, [ebp + 8]  

    ; STEP 7 : Procedure Return Algorithm Starts here
    ; Callee : Set the return value of the Callee in eax register 
    add eax, [ebp + 12]
    ; STEP 8 : Free stack memory occupied by local variables for routine add
    ; There are no local variables in this example 

    ; STEP 9 : restore the ebp register content to store base address of caller
    mov ebp, esp ; step 9.1
    pop ebp      ; step 9.2

    ; STEP 10 : Giving control back to Callee function is done by returing from routine
    ; 'ret' statement does the following :
    ; 1. set eip register = “Return address” saved in the callee’s stack, 
    ; 2. POP the saved “Return Address” from the stack 
    ; Remmeber, developer dont have direct access to manipulate eip register, eip rsgister
    ; is pushed and poped or updated via call and ret statements.

    ret ;   pop instruction pointer register from stack

global _start
    
    _start:
   
    ; Take two intergers as inputs from user 
    ; you dont have to understand how this input taking works, just focus
    ; on stack memory steps we have discussed in our course
    ; The below four lines stores the two integers taken as input
    ; in 4byte variables var1 and var2 
    call get_int
    mov [var1], eax
    call get_int
    mov [var2], eax

    ; STEP 1 : push first No on the stack
    push dword [var2]
    ; STEP 2 : push second number on the stack, this completes
    ; our step 1 of procedure call algorithm
    push dword [var1]

    ; STEP 3 : step 2 and 3 is performed by simply invoking a subroutine
    ; using call. Programmer do not have direct access to eip.
    ; below call perform two operations behind the scenes :
    ; 1. push eip   << push address of next instruction in caller frame into stack memory
    ; 2. move eip, <address of first instruction in caller add>
    call add

    ; Check my website for free and more courses : 
    ; http://csepracticals.wixsite.com/csepracticals

    ; we are here because we are retuened from routine 'add'. Caller resumes its execution from here
    ; when subroutine add returns
    ; STEP 11 : Caller POPs all the argument it had passed onto the stack
    pop dword [var2] 
    pop dword [var1]

    ; STEP 12 : Caller reads the retuened value from eax register and continue its logic
    push eax

    ;Printing the final result - Again dont bother how this is done, our stack memory example is finished here
    push dword [var2]
    push dword [var1]
    push format
    call printf
     
    push 0
    call exit
