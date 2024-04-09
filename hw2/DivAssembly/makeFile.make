sfile = divAssembly.s
exe = divAssembly.out

divAssembly.out: divAssembly.o
	ld -m elf_i386 -o $(exe) divAssembly.o
divAssembly.o: $(sfile)
	as --32 --gstabs -o divAssembly.o $(sfile)
	
clean:
	rm -fr $(exe) divAssembly.o
