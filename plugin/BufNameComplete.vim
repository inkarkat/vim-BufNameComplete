" BufNameComplete.vim: Insert mode completion of filenames loaded in Vim.
"
" DEPENDENCIES:
"   - Requires Vim 7.0 or higher.
"   - BufNameComplete.vim autoload script
"
" Copyright: (C) 2012-2016 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.01.002	12-Apr-2016	Add visual mode mapping to select the used base.
"   1.00.001	16-Nov-2012	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_BufNameComplete') || (v:version < 700)
    finish
endif
let g:loaded_BufNameComplete = 1

"- mappings --------------------------------------------------------------------

inoremap <silent> <expr> <Plug>(BufNameComplete) BufNameComplete#Expr()
nnoremap <silent> <expr> <SID>(BufNameComplete) BufNameComplete#Selected()
" Note: Must leave selection first; cannot do that inside the expression mapping
" because the visual selection marks haven't been set there yet.
vnoremap <silent> <script> <Plug>(BufNameComplete) <C-\><C-n><SID>(BufNameComplete)
if ! hasmapto('<Plug>(BufNameComplete)', 'i')
    imap <C-x>f <Plug>(BufNameComplete)
endif
if ! hasmapto('<Plug>(BufNameComplete)', 'v')
    vmap <C-x>f <Plug>(BufNameComplete)
endif

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
