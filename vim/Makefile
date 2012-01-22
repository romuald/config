SHELL = /bin/sh

defaut:
	@echo make install: copy git files to ~/ directory
	@echo make sync: copy ~/ files to git directory


install:
	cp -a vimrc ~/.vimrc
	cp -a gvimrc ~/gvimrc
	
	mkdir -p ~/.vim/
	cp -ra vim/* ~/.vim/

sync:
	cp ~/.vimrc vimrc
	cp ~/.gvimrc gvimrc
	cp -ra ~/.vim/* vim/
