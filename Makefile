PIP ?= pip3
VIM ?= vim
VINT ?= vint

all: install

install:
	$(PIP) install vim-vint==0.3.21

test: vint vader

vint:
	$(VINT) plugin

vader:
	cd test && $(VIM) -NEsu vimrc                                      -c 'Vader! symlink.vader'
	cd test && $(VIM) -NEsu vimrc -R                                   -c 'Vader! symlink.vader'
	cd test && $(VIM) -NEsu vimrc -o fixture/foo.link fixture/bar.link -c 'Vader! symlink-split-horizontal.vader'
	cd test && $(VIM) -NEsu vimrc -O fixture/foo.link fixture/bar.link -c 'Vader! symlink-split-vertical.vader'
	cd test && $(VIM) -NEsu vimrc -d fixture/foo.link fixture/bar.link -c 'Vader! symlink-split-vertical.vader'

.PHONY: all install test vint vader
