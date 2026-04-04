CC ?= gcc

CFLAGS ?= -O2
CFLAGS += -std=gnu11 -Wall -Wextra -Wpedantic
CPPFLAGS += -I..
LDLIBS += -L../lib -lblockchain
LDLIBS += $(EXTERNAL_LIBS)

VALGRIND ?= 0
PERFORMANCETESTS ?= 0

ifeq ($(OS),Windows_NT)
RM := C:/msys64/usr/bin/rm.exe -f
EXE_EXT := .exe
else
RM := rm -f
EXE_EXT :=
endif

TEST_SOURCES := $(wildcard *.c)
TEST_BASENAMES := $(patsubst %.c,%,$(TEST_SOURCES))
TEST_TARGETS := $(addsuffix $(EXE_EXT),$(TEST_BASENAMES))

ifeq ($(VALGRIND),1)
RUNNER := valgrind --leak-check=full --show-leak-kinds=all
else
RUNNER :=
endif

.PHONY: all clean run alltests

all: $(TEST_TARGETS)

%$(EXE_EXT): %.c ../lib/libblockchain.a
	$(CC) $(CPPFLAGS) $(CFLAGS) -DPERFORMANCETESTS=$(PERFORMANCETESTS) $< -o $@ $(LDLIBS)

run: $(TEST_TARGETS:%=run-%)

run-%: %
	@echo "==> $<"
	$(RUNNER) ./$<

alltests: run

clean:
	$(RM) $(TEST_TARGETS) *.o plotfastexp1.txt
