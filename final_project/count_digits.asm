section .data
i: dd 0
array: dd 1,10,100,1000,10000, 100000,1000000, 10000000, 100000000

section .text
global count_digits;

; count_digits counts the number of digits in an integer value
; e.g., 1000 has 4 digits.
;
; eax contains integer value to count 
; return value (number of digits) stored in eax

count_digits:
	
	mov ebx, 0					; clear out ebx
	mov ecx, 0					; clear out ecx
	mov ebx, [i]				; ebx = index (aka 0)

_loop:
	inc dword [i]							; i++
	mov ebx, dword [i]					; ebx = i
	mov ecx, dword [array + ebx * 4]		; ecx = array + offset * 4
	cmp eax, ecx 							; compare # and array(i)
	jae _loop 								; if eax > ecx jmp to _loop
	
	
_loop2:
	mov eax, [i]							; store index into eax
	;mov eax,5	; 8 factorial = 40320, which has 5 digits 
	ret

