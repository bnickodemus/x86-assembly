section  .text
global atoi;

; atoi function: convert ASCII character string to integer number
;
; eax is pointer to ASCII buffer to convert
; ebx is length of buffer (number of digits)
;
; return value (integer dword) stored in eax
	
atoi:

	cmp  ebx,2 				; compare 2 to length of buffer + NL
	je _len1					; if equal jump to _len1
	jg _len2					; if greater then jump to _len2

_len1:
	mov cl, byte [eax]			; put eax into cl
	sub byte cl, '0'				; convert to ASCII, input is stored in eax
	mov eax, 0 				; zero out eax
	mov al, cl					; put cl into eax
ret

_len2:

	mov ch, byte [eax]			; put eax into ch
	sub  ch , '0'						; convert to ASCII

	; (input(0) * 10) + input(1)*1)  
	mov edx,eax					; mov eax into edx 
	mov eax, 10					; eax = 10 
	mul ch							; multiply ch and al

	mov cl, byte [edx+1]			; put edx + offset into cl
	sub byte cl, '0'					; convert to ASCII

	add al,cl						; add two inputs
	
ret
		 	

