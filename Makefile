all:
	moonc *.moon */*.moon

clean:
	rm -rf bin .bin
	rm -f *.lua */*.lua
	rm -f wally.tgz

build-release: all
	mkdir .bin
	cp * .bin -R
	mv .bin ./bin
	rm -rf bin/*.moon bin/*/*.moon
	rm -f bin/Makefile
	rm -f bin/*.SWP
	rm -f bin/build-archive*

build-archive: build-release
	mv bin wally
	tar -cvzf wally.tgz wally
	zip -r wally.zip wally
	mv wally bin

run: all
	dosbox WALLY.EXE