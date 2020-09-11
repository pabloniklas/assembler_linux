;
; https://en.wikibooks.org/wiki/X86_Assembly/Other_Instructions
;
; $ nasm -felf -g rdtsc.asm -l rdtsc.lst
; $ gcc -m32 -o rdtsc rdtsc.o
; $ ./rdtsc
;

global main

extern printf

section .data
    align 4
    a:  dd 10.0
    b:  dd 5.0
    c:  dd 2.0

    fmtStr: db "Salida ==> edx:eax = %llu edx = %d eax = %d", 0x0A, 0

section .bss
    align 4
    cycleLow:   resd 1
    cycleHigh:  resd 1
    result:     resd 1

section .text
    main:           ; Se define main porque linkeamos con gcc.

;
;   op  dst,  src
;
    xor eax, eax  ; reset del registro eax.
    cpuid ; Returns processor identification and feature information to the EAX, EBX, ECX, and EDX registers, according to the input value entered initially in the EAX register.
    rdtsc ; determine how many CPU ticks took place since the processor was reset.
    mov [cycleLow], eax
    mov [cycleHigh], edx

    ;
    ; Do some work before measurements
    ;
    fld dword [a] ; fld Pushes the source operand onto the FPU register stack.
    fld dword [c]
    fmulp   st1 ; Multiplies the destination and source operands and stores the product in the destination location.
    fmulp   st1
    fld dword [b]
    fld dword [b]
    fmulp   st1
    faddp   st1 ; Adds the destination and source operands and stores the sum in the destination location.
    fsqrt   ; Computes the square root of the source value in the ST(0) register and stores the result in ST(0).
    fstp    dword [result]
    ;
    ; Done work
    ;

    cpuid
    rdtsc
    ;
    ; break points so we can examine the values
    ; before we alter the data in edx:eax and
    ; before we print out the results.
    ;
break1:
    sub eax, [cycleLow]
    sbb edx, [cycleHigh]
break2:
    push    eax
    push    edx
    push    edx
    push    eax
    push    dword fmtStr
    call    printf
    add esp, 20     ; Pop stack 5 times 4 bytes

    ;
    ; Call exit(3) syscall
    ;   void exit(int status)
    ;
    mov ebx, 0      ; Arg one: the status
    mov eax, 1      ; Syscall number:
    int     0x80
