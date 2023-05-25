CC = gcc
OS = $(shell uname -s)

CFLAGS = -c -Wall -Werror -Wextra
LFLAGS = -lm -lrt -lpthread

all: s21_grep

test:
	bash testgrep.sh

s21_grep: s21_grep.o
ifeq ($(OS), Linux)
	$(CC) $(LFLAGS) s21_grep.o -o s21_grep 
else
	$(CC) s21_grep.o -o s21_grep
endif

s21_grep.o: s21_grep.c
	$(CC) $(CFLAGS) s21_grep.c -o s21_grep.o

rebuild:
	clean all

check:
	cp ../../../materials/linters/.clang-format ./
	clang-format -n --Werror *.c *.h
	rm .clang-format
clean:
	rm -rf *.o *.txt log_* s21_grep

.PHONY: all test clean
