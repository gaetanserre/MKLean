EXE = .lake/build/bin/mklean

all:
	lake build

install:
	cp $(EXE) /usr/local/bin

clean:
	rm -rf .lake
