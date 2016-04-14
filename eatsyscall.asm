SECTION .data

EatMsg: db "::: 2016 By Pablo Niklas :::" ,10
EatLen: equ $-EatMsg

SECTION .bss

SECTION .text

global _start

_start:
	nop
	mov eax,4	; Imprimir texto
	mov ebx,1	; Por cual canal
	mov ecx,EatMsg
	mov edx,EatLen
	int 80H		;Invoco kernel

	mov eax,1	;Salgo
	mov ebx,0	;RC=0
	int 80H		;Invoco kernel
