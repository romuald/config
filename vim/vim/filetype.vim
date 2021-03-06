if exists("did_load_filetypes")
	finish
endif

augroup filetypedetect
	" html.fr
	au! BufRead,BufNewFile *.html.??	setfiletype html

	" ollld plugin
	au! BufRead mozex.textarea.*		setfiletype twiki

	au! BufRead,BufNewFile *.json		setfiletype javascript
	au! BufRead,BufNewFile *.todo		setfiletype todo
	au! BufRead,BufNewFile *.rhtml		setfiletype eruby
	au! BufRead,BufNewFile *.tt			setfiletype tt2

	" gandi specific
	au! BufRead *-{prod,test}-transactions* setfiletype regsockd
augroup END

" Closetag for some types only
au Filetype html,xhtml,xml,xsl,php,rhtml,tt2,htmldjango source ~/.vim/ftplugin/html/closetag.vim
au Filetype html,xhtml,xml,xsl,php,rhtml,tt2,htmldjango set et
au Filetype html,xhtml,xml,xsl,php,rhtml,tt2,htmldjango colorscheme lucius
