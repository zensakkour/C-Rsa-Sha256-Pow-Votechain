CC ?= gcc
AR ?= ar

CFLAGS ?= -O2
CFLAGS += -std=gnu11 -Wall -Wextra -Wpedantic
CPPFLAGS += -I..

ifeq ($(OS),Windows_NT)
RM := C:/msys64/usr/bin/rm.exe -f
else
RM := rm -f
endif

SRC := $(wildcard *.c)
OBJ := $(SRC:.c=.o)
LIB := libblockchain.a

.PHONY: all clean

all: $(LIB)

$(LIB): $(OBJ)
	$(AR) rcs $@ $^

%.o: %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

clean:
	$(RM) $(OBJ) $(LIB)
