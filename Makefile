PIP ?= pip3
VIM ?= vim
VINT ?= vint

.PHONY: all
all: install lint test

.PHONY: install
install:
	git submodule update --init
	$(PIP) install vim-vint==0.3.21

.PHONY: lint
lint:
	$(VINT) plugin

.PHONY: test
test:
	cd test && $(VIM) -NEsu vimrc                                      -c 'Vader! symlink.vader'
	cd test && $(VIM) -NEsu vimrc -R                                   -c 'Vader! symlink.vader'
	cd test && $(VIM) -NEsu vimrc -o fixture/foo.link fixture/bar.link -c 'Vader! symlink-split-horizontal.vader'
	cd test && $(VIM) -NEsu vimrc -O fixture/foo.link fixture/bar.link -c 'Vader! symlink-split-vertical.vader'
	cd test && $(VIM) -NEsu vimrc -d fixture/foo.link fixture/bar.link -c 'Vader! symlink-split-vertical.vader'
