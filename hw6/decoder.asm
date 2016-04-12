

section .bss
    SIZE: equ 80;        declare const size
    input: resb SIZE;    reserve SIZE bytes as void * buffer
 
section .data
    i: db 0x00;          iterator variable
    j: db 0x00;          inner iterator variable
    len: db 0x00;        length
    current: db 0x00;    current variable
    NL: db 10;         new line charcter (ASCII 10)

section .text
    global    _start

_start:

; make system call to get input from user
    mov eax, 3;             read is system call #3
    mov ebx, 0;             fd 0 for stdin
    mov ecx, input;           address to void * buffer
    mov edx, SIZE;             num bytes to read
    int 0x80;               make system call

    mov [len], byte al;     store number of bytes read  
 
_loop:
    mov eax, input;            32-bit address of input
    add al, byte [i];          32-bit address of input[i]
    mov bl, byte [eax];        defreference byte at input[i]
   
    cmp bl, [NL];       compare bl to newline
    je _exit;            if NL jump to exit

    mov byte [current], bl;    store current index into current variable
    inc byte [i];              inc i to look at next char
    mov eax, input;            32-bit address of input
    add al, byte [i];          32-bit address of input[i]
    mov bl, byte [eax];        defreference byte at input[i]
    mov byte [j], bl;          j = some odd number index
    sub [j], byte '0';         convert to ascii
    jmp _innerLoop;            fall into _innerLoop

_innerLoop:
    ; print current
    mov eax, 4;                 sys call #4 write
    mov ebx, 1;                 stdout
    mov ecx, current;           address of output
    mov edx, 1;                 write 1 byte
    int 0x80;                   make sys call

    dec byte [j];     dec j
    mov eax, 0;    clear out a register
    mov al, byte [j];     number
    cmp al, 0;    compare al to 0
    je _inc;         if j==0
    jmp _innerLoop;    if j != 0    
    
_inc:
   inc byte [i];      i++
    mov al, byte [len];       move j into temp register
    cmp byte [i], al;      compare i to length
    jb _loop;            i < len jump to loop
    jmp _exit;         i == length
 
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



