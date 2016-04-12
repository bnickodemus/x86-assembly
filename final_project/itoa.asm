section .text
global itoa;

; eax is integer to be converted to ASCII
; ebx is number of digits in integer
; ecx is output buffer to fill with ASCII characters
; e.g., integer 40320 gets converted to ASCII '40320'

itoa:

	add ecx, ebx				; adds offset to output buffer
	mov ebx, 10				; ebx = 10

_loop:
	xor edx, edx				; clear edx before dividing			
	div ebx						; eax is divided by 10
	add dl, '0'					; convert to ASCII
	dec ecx					; move to previous index
	mov [ecx], dl				; copy char into output buffer
	test eax, eax				; compare eax to 0 
	jnz _loop					; if eax != 0 _loop 			
ret



				