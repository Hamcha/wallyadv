all:
	moonc *.moon */*.moon

clean:
	rm *.lua */*.lua

run:
	dosbox WALLY.EXE