
section .bss
    SIZE: equ 80;        declare const size
    input: resb SIZE;    reserve SIZE bytes as void * buffer
    
section .data
    i: db 0x00;          iterator variable
    len: db 0x00;        length
    count: db 0x00;	 number of times the charcter appears init to 1
    prev: db 0x00;	 previous variable
    current: db 0x00;    current variable
    NL: db 10;		 new line charcter (ASCII 10)

section .text
    global    _start

_start:
    inc byte [count];              to account for 1st character

; make system call to get input from user
    mov eax, 3;             read is system call #3
    mov ebx, 0;             fd 0 for stdin
    mov ecx, input;   	    address to void * buffer
    mov edx, SIZE;     	    num bytes to read
    int 0x80;               make system call

    mov [len], byte al;     store number of bytes read    
    mov [i], byte 0;        set variable i to 0

; set previous term = index 0 
    mov eax, 0;		    clears out eax
    mov al, byte [input];   move first byte into aL register
    mov byte [prev], al;    set the previous term to index 0 
    inc byte [i];           i = 1
    
_loop:
    mov eax, input;            32-bit address of input
    add al, byte [i];          32-bit address of input[i]
    mov bl, byte [eax];        defreference byte at input[i]
    mov cl, byte [prev];       mov prev into temp register
    cmp bl, cl;                compare byte to previous term  
    je _inc;                   jump to inc if equal                 

_switch_char:	
    ; print prev
    mov eax, 4;                 sys call #4 write
    mov ebx, 1;                 stdout 
    mov ecx, prev;              address of output
    mov edx, 1;                 write 1 byte
    int 0x80;                   make sys call

    ; print counter
    mov eax, 4;                  sys call #4 write
    mov ebx, 1;                  stdout
    add [count], byte '0';       convert decimal counter to ASCII
    mov ecx, count;              address of output array
    mov edx, 1;                  write 1 byte
    int 0x80;                    make sys call
   
    mov byte [count], 1;         sets count to 1 (1 to account for 1st char)
    
    mov eax, 0;        zero out eax
    mov ebx, 0;        zero out ebx
    mov eax, input;            32-bit address of input
    add al, byte [i];          32-bit address of input[i]
    mov bl, byte [eax];        defreference byte at input[i]
    mov byte [prev], bl;       mov char into prev

_finish:
    inc byte [i];         32-bit address of input 
    mov al, byte [len];   moves len into temp register
    cmp byte [i], al;     compare i to length-1
    jb _loop;             jump if i < al to _loop
    jmp _exit;            jump to exit (loop is done)

_inc: 
    inc byte [count];          inc number of chars  
    jmp _finish;               jumps back up to finish 

_exit:
; write a newline
    mov eax, 4;          syscall write
    mov ebx, 1;          stdout
    mov ecx, NL;         new line char
    mov edx, 1;          write 1 byte
    int 0x80;            sys call
    
; make sys call to exit
    mov eax, 1;          kernel service #1
    mov ebx, 0;          set exit value to 0 (success)
    int 0x80;            sys call exit   


