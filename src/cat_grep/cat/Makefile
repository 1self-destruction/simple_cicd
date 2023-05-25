CC = gcc
OS = $(shell uname -s)

CFLAGS = -c -Wall -Werror -Wextra -std=c11
LFLAGS = -lm -lrt -lpthread #linux

all: s21_cat

test:
	bash testcat.sh

s21_cat: s21_cat.o
ifeq ($(OS), Linux)
	$(CC) $(LFLAGS) s21_cat.o -o s21_cat 
else
	$(CC) s21_cat.o -o s21_cat
endif

s21_cat.o: s21_cat.c
	$(CC) $(CFLAGS) s21_cat.c -o s21_cat.o

check:
	cp ../../../materials/linters/.clang-format ./
	clang-format -n --Werror *.c *.h
	rm .clang-format

rebuild: clean all

clean:
	rm -rf *.o log* log* t_* t_* s21_cat s21_cat

