;
; Playing with loops in assembler.
;

section .text
global main

main:
    mov edx,len ;message length
    mov ecx,msg ;message to write
    mov ebx,1 ;file descriptor (stdout)
    mov eax,4 ;system call number (sys_write
    int 0x80 ;call kernel

    mov ecx, 5

start_loop:

    push ecx

    mov edx,9 ;message length
    mov ecx,s2 ;message to write
    mov ebx,1 ;file descriptor (stdout)
    mov eax,4 ;system call number (sys_write)
    int 0x80 ;call kernel

    mov edx,1 ;message length
    mov ecx,nl ;message to write
    mov ebx,1 ;file descriptor (stdout)
    mov eax,4 ;system call number (sys_write)
    int 0x80 ;call kernel

    pop ecx

    loop start_loop

    mov eax,1 ;system call number (sys_exit)
    int 0x80 ;call kernel

section .data
    msg db 'Mostrando estrellas.',0xa ;a message
    len equ $ - msg
    s2 times 9 db '*'
    nl db 0xa
