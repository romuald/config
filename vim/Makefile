SHELL = /bin/sh

defaut:
	@echo make install: copy git files to ~/ directory
	@echo make sync: copy ~/ files to git directory


install:
	cp -a vimrc ~/.vimrc
	
	mkdir -p ~/.vim/
	cp -ra vim/* ~/.vim/

sync:
	cp ~/.vimrc vimrc
	cp -ra ~/.vim/* vim/
