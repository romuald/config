" ======================================================================
" $Id: tt2.vim,v 1.5 2001/12/19 15:48:03 dlc Exp $
" vim: set ts=2 sw=2:
" ======================================================================
" Language:     Template Toolkit
" Maintainer:   darren chamberlain <dlc+vim@sevenroot.org>
" Last Change:  2001/12/18
" Location:     http://sevenroot.org/vim/tt2.vim
" ======================================================================
" 
" 
" ======================================================================
" Customizable bits:
" 
" tt2_tagstyle
"   Defines what the beginning and end tags are.  The default (named
"   "default") has a start tag of "[%" and an end tag of "%]". The full
"   list of options looks like this:
"
"      Name          Start Tag   End Tag
"      ====          =========   =======
"      default       [%          %]
"      template1     [% or %%    %% or %]
"      metatext      %%          %%
"      html          <!--        -->
"      mason         <%          >
"      asp           <%          %>
"      php           <?          ?>
"      star          [*          *]
"
"   So, to use delimiters of [* and *], use the following:
"     let tt2_tagstyle="star"
"   To use PHP-style tags, use:
"     let tt2_tagstyle="php"
"   You get the idea.
"   TODO
"     What I *really* want here is to be able to specify a regex for
"     the start_tag and end_tag (in addition to the predefined styles
"     above); I am having trouble with using the contents of a variable
"     in the start and end section of the "syntax match" statement.
"
" tt2_any_case
"   Should matching for keywords be case sensitive (ANY_CASE Template param).
"
" tt2_highlight_delimiters
"   Should highlighting for delimiters be linked to Delimiter (default no).
"
" tt2_highlight_identifiers
"   Should identifiers (within [% and %]) be highlighted (default no)
"
" tt2_interpolate
"   Should variables be interpolated in non-template blocks (default no).
"   This corresponds to the Template config param INTERPOLATE.
" ======================================================================

" Clear any existing syntax stuff
syntax clear

" Set the name of the current syntax to tt2
let b:current_syntax="tt2"

" Set the filetype to tt2
set filetype=html

" Set to case sensitive, by default
" This corresponds to the ANY_CASE Template config directive
if exists("tt2_any_case")
  syntax case ignore
else
  syntax case match
endif

" Set syncing
syntax sync minlines=50 

if !exists("tt2_tagstyle")
  let tt2_tagstyle="asp"
endif

" defined everything as being within a tt2Statement section
if  tt2_tagstyle == "template1"
  " template 1 style: [\[%]% and %[%\]]
  syntax region tt2Statement start=/[\[%]%/ end=/%[%\]]/ keepend containedin=ALL contains=tt2Comment,tt2DQString,tt2SQString,tt2Delimiter,tt2Conjunctor,tt2Identifier,tt2Interpolated
elseif tt2_tagstyle == "metatext"
  syntax region tt2Statement start=/%%/ end=/%%/ keepend containedin=ALL contains=tt2Comment,tt2DQString,tt2SQString,tt2Delimiter,tt2Conjunctor,tt2Identifier,tt2Interpolated
elseif tt2_tagstyle == "html"
  syntax region tt2Statement start=/<!--/ end=/-->/ keepend containedin=ALL contains=tt2Comment,tt2DQString,tt2SQString,tt2Delimiter,tt2Conjunctor,tt2Identifier,tt2Interpolated
elseif tt2_tagstyle == "mason"
  syntax region tt2Statement start=/<%/ end=/>/ keepend containedin=ALL contains=tt2Comment,tt2DQString,tt2SQString,tt2Delimiter,tt2Conjunctor,tt2Identifier,tt2Interpolated
elseif tt2_tagstyle == "asp"
  syntax region tt2Statement start=/<%/ end=/%>/ keepend containedin=ALL contains=tt2Comment,tt2DQString,tt2SQString,tt2Delimiter,tt2Conjunctor,tt2Identifier,tt2Interpolated
elseif tt2_tagstyle == "php"
  syntax region tt2Statement start=/<\?/ end=/\?>/ keepend containedin=ALL contains=tt2Comment,tt2DQString,tt2SQString,tt2Delimiter,tt2Conjunctor,tt2Identifier,tt2Interpolated
elseif tt2_tagstyle == "star"
  syntax region tt2Statement start=/\[\*/ end=/\*\]/ keepend containedin=ALL contains=tt2Comment,tt2DQString,tt2SQString,tt2Delimiter,tt2Conjunctor,tt2Identifier,tt2Interpolated
else
  " default: [% and %]
  syntax region tt2Statement start=/\[%/ end=/%\]/ keepend containedin=ALL contains=tt2Comment,tt2DQString,tt2SQString,tt2Delimiter,tt2Conjunctor,tt2Identifier,tt2Interpolated
endif

" comments.
syntax region tt2Comment start=/#/ end=/$/ contained keepend

" interpolations in double quoted strings...
if exists("tt2_interpolate")
  syntax match tt2Interpolated /\${\{0,1\}[a-zA-Z_][a-zA-Z0-9_]*}\{0,1\}/
else
  syntax match tt2Interpolated /\${\{0,1\}[a-zA-Z_][a-zA-Z0-9_]*}\{0,1\}/ contained
endif


" strings
syntax region tt2DQString start=/"/ skip=/\\"/ end=/"/ contained contains=tt2Interpolated
syntax region tt2SQString start=/'/ skip=/\\'/ end=/'/ contained 

" delimiters
" syntax match tt2Delimiter "[{()}]" contained
" syntax match tt2Delimiter "\[[^%]" contained
" syntax match tt2Delimiter "\[$" contained
" syntax match tt2Delimiter "[^%]*\]" contained
" syntax match tt2Delimiter "\]$" contained

syntax match tt2Identifier /\<[a-zA-Z_][a-zA-Z0-9_]*\>/ contained

" Conjunctors
" These are connectors between objects and methods,
" or hash keys and values
syntax match tt2Conjunctor "=>" contained
syntax match tt2Conjunctor "->" contained
syntax match tt2Conjunctor ","  contained
syntax match tt2Conjunctor "\." contained

highlight link tt2Comment Comment
highlight link tt2SQString String
highlight link tt2DQString String
highlight link tt2Statement Statement
highlight link tt2Directive Statement
" if exists("tt2_highlight_delimiters")
  highlight link tt2Conjunctor Delimiter
  highlight link tt2Delimiter Delimiter
" endif
" if exists("tt2_highlight_identifiers")
  highlight link tt2Identifier Identifier
  highlight link tt2Interpolated Identifier
" endif

syn region oneFold start="\<BLOCK\>" end="\<END\>" containedin=tt2Statement transparent fold
syn region oneFold start="\<IF\>" end="\<END\>" containedin=tt2Statement transparent fold
syn region oneFold start="\<UNLESS\>" end="\<END\>" containedin=tt2Statement transparent fold
syn region oneFold start="\<WRAPPER\>" end="\<END\>" containedin=tt2Statement transparent fold
syn region oneFold start="\<FOR\>" end="\<END\>" containedin=tt2Statement transparent fold
syn region oneFold start="\<FOREACH\>" end="\<END\>" containedin=tt2Statement transparent fold
syn region oneFold start="\<WHILE\>" end="\<END\>" containedin=tt2Statement transparent fold
syn region oneFold start="\<SWITCH\>" end="\<END\>" containedin=tt2Statement transparent fold
syn region oneFold start="\<FILTER\>" end="\<END\>" containedin=tt2Statement transparent fold
syn region oneFold start="\<PERL\>" end="\<END\>" containedin=tt2Statement transparent fold
syn region oneFold start="\<RAWPERL\>" end="\<END\>" containedin=tt2Statement transparent fold
syn region oneFold start="\<TRY\>" end="\<END\>" containedin=tt2Statement transparent fold

