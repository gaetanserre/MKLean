CC = g++
CFLAGS = -std=c++20
SRC = src
EXE = mklean

all:
	$(CC) $(SRC)/main.cc $(CFLAGS) -o $(EXE)

install:
	cp $(EXE) /usr/local/bin

clean:
	rm -rf $(EXE)