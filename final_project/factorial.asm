section .data
i: dw 0x00						; iterator

section .text
global factorial

; factorial function calculate N! (N factorial) for input N
;
; eax holds N, the integer to factorial
; return value N! (N factorial) stored in eax

factorial:

	mov dword [i], eax		; mov eax into i		
	dec dword [i]				; i--

_loop:	
	mov ecx, 0					; clear ecx
	mov ecx, dword [i]		; mov i into ecx
	mul ecx					; eax *= ecx (aka i)
	dec dword [i]				; i--	
	
	cmp dword [i], 0  			; while i != 0
	je _finish					; jump to _finish if i = 0
	jmp _loop					; else _loop

_finish:
	;mov eax,40320			; 8! = 40320
	ret

