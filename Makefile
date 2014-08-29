all:
	moonc *.moon */*.moon

clean:
	rm -rf bin .bin
	rm -f *.lua */*.lua

build-release: all
	mkdir .bin
	cp * .bin -R
	mv .bin bin
	rm -rf bin/*.moon bin/*/*.moon
	rm bin/Makefile
	rm bin/*.SWP

run: all
	dosbox WALLY.EXE