" Vim syntax file
if version < 600
	syntax clear
endif

"syn include @xml syntax/xml.vim

"syn region xmlPart start="[CS]: <" end="$" contains=@xml
syn match Function "<[^>]*>"
syn match Comment "<[0-9][^>]*>"
syn match Keyword /<domain:name>.*<\/domain:name>/lc=13,me=e-14
syn match String "<result code=.[^1].*</result>"
syn match String "<command><[a-z]*>"

set ic
