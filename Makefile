VIM ?= vim
NVIM ?= nvim
VINT ?= vint

.PHONY: all
all: lint test

.PHONY: lint
lint:
	$(VINT) plugin

.PHONY: test
test: test-vim test-nvim

.PHONY: test-vim
test-vim:
	cd test && $(VIM) -NEsu vimrc                                      -c 'Vader! symlink.vader'
	cd test && $(VIM) -NEsu vimrc -R                                   -c 'Vader! symlink.vader'
	cd test && $(VIM) -NEsu vimrc -o fixture/foo.link fixture/bar.link -c 'Vader! symlink-split-horizontal.vader'
	cd test && $(VIM) -NEsu vimrc -O fixture/foo.link fixture/bar.link -c 'Vader! symlink-split-vertical.vader'
	cd test && $(VIM) -NEsu vimrc -d fixture/foo.link fixture/bar.link -c 'Vader! symlink-split-vertical.vader'
	cd test && $(VIM) -NEsu vimrc                                      -c 'Vader! symlink-edge-cases.vader'

.PHONY: test-nvim
test-nvim:
	cd test && $(NVIM) --headless -N -u vimrc                                      -c 'Vader! symlink.vader'
	cd test && $(NVIM) --headless -N -u vimrc -R                                   -c 'Vader! symlink.vader'
	cd test && $(NVIM) --headless -N -u vimrc -o fixture/foo.link fixture/bar.link -c 'Vader! symlink-split-horizontal.vader'
	cd test && $(NVIM) --headless -N -u vimrc -O fixture/foo.link fixture/bar.link -c 'Vader! symlink-split-vertical.vader'
	cd test && $(NVIM) --headless -N -u vimrc -d fixture/foo.link fixture/bar.link -c 'Vader! symlink-split-vertical.vader'
	cd test && $(NVIM) --headless -N -u vimrc                                      -c 'Vader! symlink-edge-cases.vader'
