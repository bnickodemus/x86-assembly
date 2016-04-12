encoder: encoder.o
	ld -o encoder encoder.o
encoder: encoder.asm
	nasm -f elf -g -F stabs encoder.asm -l encoder.lst
decoder: decoder.o
	ld -o decoder decoder.o
decoder: decoder.asm
	nasm -f elf -g -F stabs decoder.asm -l decoder.lst
