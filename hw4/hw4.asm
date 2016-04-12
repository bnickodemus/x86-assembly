section .data
	x: dd 0x00000000					; x=0
	y: dd 0x00000000					; y=0
	z: dd 0x00000000					; z=0
	a: dd 0x00000000					; a=0
section .text
	global	_start
_start:
	nop
	mov [x], dword 0x00000002		; x=2

	mov eax, [x]						; eax=2
	mov ebx, 4							; ebx=4
	add eax, ebx						; eax=6
	mov [y], dword eax				; y=6
	mov ecx, [y]						; ecx=6
	
	mov eax, [x]						; eax=2
	mov ebx, 1							; ebx=1
	add eax, ebx						; eax=3
	neg eax							; eax=-3
	mov ebx, [y]						; ebx=6
	add eax, ebx						; eax=3
	mov [z], dword eax				; z=3

	mov ecx, [x]						; ecx=2
	mov edx, [z]						; edx=3
	add ecx, edx						; ecx=5
	mov eax, [y]						; eax=6
	mov ebx, 2							; ebx=2
	mov edx, 0							; clear edx
	div ebx								; eax=3   

	mov ebx, ecx						; ebx=5
	mul ebx							; eax=15 (x+z) * (y/2)

	mov ecx, eax						; ecx=15
	mov eax, [z]						; eax=3
	mov ebx, [z]						; ebx=3
	mul ebx							; eax=9    
	 add eax, ecx 						; eax=24 (15+9) 
	mov [a], dword eax				; a=24
	mov ecx, 24						; ecx=24
	
	mov eax, [a]						; eax=24
	mov ebx, [z]						; ebx=3
	add eax, ebx						; eax=27
	mov [x], dword eax				; x=27

	mov eax, [x]						; eax=27
	mov ebx, [y]						; ebx=6
	mov ecx, [z]						; ecx=3
	mov edx, [a]						; edx=24

	nop
	
	
	
	