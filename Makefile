VIM ?= vim
VINT ?= python3 test/vint/bin/vint

all: test

test: vint vader

vader:
	$(VIM) -Nu test/.vimrc -c 'Vader! test/*'

vint:
	$(VINT) plugin

.PHONY: all test vader vint
