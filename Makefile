CC ?= gcc
AR ?= ar

VALGRIND ?= 0
PERFORMANCETESTS ?= 0

export CC AR VALGRIND PERFORMANCETESTS

EXTERNAL_LIBS ?= -lssl -lcrypto
export EXTERNAL_LIBS

ROOT_MAKEFILE := $(abspath $(lastword $(MAKEFILE_LIST)))
D_ROOT := $(patsubst %/,%,$(dir $(ROOT_MAKEFILE)))
D_LIB := $(D_ROOT)/lib
D_TEST := $(D_ROOT)/test

SUBDIRS := $(D_LIB) $(D_TEST)

.PHONY: all clean lib test-bin test help

all: lib test-bin

lib:
	$(MAKE) -C $(D_LIB)

test-bin:
	$(MAKE) -C $(D_TEST)

test: all
	$(MAKE) -C $(D_TEST) run

clean:
	$(MAKE) -C $(D_LIB) clean
	$(MAKE) -C $(D_TEST) clean

help:
	@echo "Targets:"
	@echo "  make           Build library and test binaries"
	@echo "  make test      Build and run all tests"
	@echo "  make clean     Remove build artifacts"
	@echo "Variables:"
	@echo "  VALGRIND=1         Run tests under valgrind"
	@echo "  PERFORMANCETESTS=1 Enable performance tests in perf.c"
