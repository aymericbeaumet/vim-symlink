VIM ?= vim
VINT ?= python3 test/vint/bin/vint

all: test

test: vint vader

vader:
	cd test && $(VIM) -NEsu vimrc                                      -c 'Vader! symlink.vader'
	cd test && $(VIM) -NEsu vimrc -R                                   -c 'Vader! symlink.vader'
	cd test && $(VIM) -NEsu vimrc -o fixture/foo.link fixture/bar.link -c 'Vader! symlink-split-horizontal.vader'
	cd test && $(VIM) -NEsu vimrc -O fixture/foo.link fixture/bar.link -c 'Vader! symlink-split-vertical.vader'
	cd test && $(VIM) -NEsu vimrc -d fixture/foo.link fixture/bar.link -c 'Vader! symlink-split-vertical.vader'

vint:
	$(VINT) plugin

.PHONY: all test vader vint
