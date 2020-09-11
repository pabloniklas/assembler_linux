; nasm -f elf64 demo.asm
; ld -s -o demo demo.o
;

SECTION .data

EatMsg: db "Hola mundo." ,10
EatLen: equ $-EatMsg

SECTION .bss

SECTION .text

global _start

_start:
	nop
	mov eax, 4	; Imprimir texto
	mov ebx, 2	; Por cual FD
	mov ecx, EatMsg
	mov edx, EatLen
llamada1:
	int 80H		;Invoco kernel

	mov eax, 1	;Salgo
	mov ebx, 24 	;RC=0
llamada2:
	int 80H		;Invoco kernel
