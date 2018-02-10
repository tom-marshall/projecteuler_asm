1:
	yasm -f elf64 -g dwarf2 -l problem1.lst problem1.asm && ld problem1.o -o problem1

2:
	yasm -f elf64 -g dwarf2 -l problem2.lst problem2.asm && ld problem2.o -o problem2

3:
	yasm -f elf64 -g dwarf2 -l problem3.lst problem3.asm && ld problem3.o -o problem3

clean:
	rm *.o *.lst ex1 ex2 ex3
