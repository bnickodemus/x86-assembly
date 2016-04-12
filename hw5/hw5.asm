; get input from user (stdin)
; iterate through input
; if bracket push to stack
; view next item
; pop if bracket

section .bss
    SIZE: equ 80;        declare const size
    input: resb SIZE;    reserve SIZE bytes as void * buffer
   
section .data
    i: dd 0x00;            iterator variable
    len: dd 0x00;        length
    errorMsg: db 'ERROR!!!',10;        message if brackets don't match
    errorMsgLen: equ $ - errorMsg;        length of message
    lp: db '(';            set lp = (
    rp: db ')';            set rp = )
    lsb: db '[';            set lsb = [
    rsb: db ']';            set rsb = ]
    lcb: db '{';            set lcb = {
    rcb: db '}';            set rcb = }
    stackSize: dd 0x00;		counter var, when bracket pushed to stack +1 when poped -1 
  
section .text
    global    _start

_start:
   
; make system call to get input from user
    mov eax, 3;             read is system call #3
    mov ebx, 0;             fd 0 for stdin
    mov ecx, input;    addressto void * buffer
    mov edx, SIZE;      num bytes to read
    int 0x80;                   make system call

; store the return value of read system call into len variable
    mov [len], eax;             return value in eax.  store in len variable
    mov [i], dword 0;        set variable i to 0

_loop:
    mov ecx, input;        address to void * buffer
    add ecx, [i];                add offset to base address
  
        mov ah, byte [ecx];    dereference pointer to input, store in ah
        cmp ah, byte [lp];        compare ah to see if it is a lp
        je _ploop;                         if equal, jump to _ploop
	cmp ah, byte [rp];		compares ah to see if it is a rp
	je _pploop;			if equal, jump to _pploop
	
	cmp ah, byte[lsb];		compare ah to see if it is lsb
	je _ploop;				if equal, jump to _ploop
	cmp ah, [rsb];			compares ah to see if it is a rsb
	je _pploop;			if equal, jump to _pploop
	
	cmp ah, byte[lcb];		compare ah to see if lcb
	je _ploop;				if equal, jump to _ploop
	cmp ah, [rcb];			compares ah to see if it is a rcb
	je _pploop;			if equal, jump to _pploop
	
	jmp iter;				jump to iterate
   

; if success print
print_exit:
	mov eax, 4;		write sys call #4
	mov ebx, 1;		write to stdout
	mov ecx, input;	use pointer to indicate success 
	mov edx, len;		message length
	int 0x80;			 execute system call
	jmp exit;			jump to exit label	

exit:
    mov eax,1;     use kernel sevice #1 (exit)
    mov ebx, 0;    set exit value to 0 (success)
    int 0x80;          execute exit syscall

 iter:
    inc dword [i];			increment i counter
    mov ebx, [i];             move i into ebx   
    cmp ebx, [len];        compairs ebx to length
    jne _loop;			if not equal, jump back to loop
   mov edx, 0;			mov 0 to edx  
   cmp edx, dword [stackSize];		i = len so check if counter = 0 if yes print else error
   je print_exit;					if counter=0 and i=length  we have success
   jne _errormsg;					if counter != 0, there is still a bracket left  

; display error
_errormsg:
    mov eax, 4;                              write syscall
    mov ebx, 1;                              write to std out
    mov ecx, errorMsg;            pointer to errorMsg buffer
    mov edx, errorMsgLen;    size of errorMsg
    int 0x80;                                     execute system call
    jmp exit;					jump to exit after it fails

; push lp to stack
_ploop:
    mov bh, ah;				mov ah to bh
    mov ax, 0;                              clear out register A
    mov ah, bh;				copies bh back to ah
    push ax;                                   push 16 bits to stack	
    inc dword [stackSize];	+1 to counter
    jmp iter;					jumps to iterator				 

; p pop loop, will pop lp off of stack
_pploop:
	pop ax;				pop the top 16 bits off the stack
	dec dword [stackSize]; -1 counter
	jmp iter;				increase i and see if i = length
	


    
    