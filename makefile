phony: 4

clean:
	rm *.o *.lst problem1 problem2 problem3


1:
	yasm -f elf64 -g dwarf2 -l problem1.lst problem1.asm
	ld problem1.o -o problem1


2:
	yasm -f elf64 -g dwarf2 -l problem2.lst problem2.asm
	ld problem2.o -o problem2


3:
	yasm -f elf64 -g dwarf2 -l problem3.lst problem3.asm
	ld problem3.o -o problem3

4:
	yasm -f elf64 -g dwarf2 -l problem4.lst problem4.asm
	gcc problem4.o -o problem4

5:
	yasm -f elf64 -g dwarf2 -l problem5.lst problem5.asm
	gcc problem5.o -o problem5

