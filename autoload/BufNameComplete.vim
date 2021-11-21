" BufNameComplete.vim: Insert mode completion of filenames loaded in Vim.
"
" DEPENDENCIES:
"   - CompleteHelper/Abbreviate.vim autoload script
"
" Copyright: (C) 2012-2016 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.01.002	12-Apr-2016	Add visual mode mapping to select the used base.
"   1.00.001	16-Nov-2012	file creation
let s:save_cpo = &cpo
set cpo&vim

function! s:GetBufFilespecs()
    let l:currentBufNr = bufnr('')
    let l:bufNrs = filter(
    \   range(1, bufnr('$')),
    \   'buflisted(v:val) && v:val != l:currentBufNr && getbufvar(v:val, "buftype") !=# "nofile"'
    \)

    return filter(
    \   map(l:bufNrs, 'bufname(0 + v:val)'),
    \   '! empty(v:val)'
    \)
endfunction
function! s:MakeMatchObject( file, absoluteFilespec )
    let l:matchObject = CompleteHelper#Abbreviate#Word({'word': a:file})
    if a:file !=# a:absoluteFilespec
	let l:matchObject.menu = CompleteHelper#Abbreviate#Text(a:absoluteFilespec)
    endif
    return l:matchObject
endfunction
function! s:FindMatches( filespec, base )
    let l:ps = (exists('+shellslash') && ! &shellslash ? '\\' : '/')

    " Note: Omitted \C from pattern; let 'ignorecase' apply here.
    let l:pattern = printf('\%%(^\|%s\)\zs\V%s\.\*', l:ps, escape(a:base, '\'))

    let l:matches = []
    let l:matchCnt = 0
    while 1
	let l:match = matchstr(a:filespec, l:pattern, 0, l:matchCnt + 1)
	if empty(l:match)
	    break
	endif

	call add(l:matches, s:MakeMatchObject(l:match, a:filespec))
	let l:matchCnt += 1
    endwhile

    return l:matches
endfunction
function! BufNameComplete#BufNameComplete( findstart, base )
    if a:findstart
	if s:selectedBaseCol
	    return s:selectedBaseCol - 1    " Return byte index, not column.
	else
	    " Locate the start of the filename.
	    let l:startCol = searchpos('\f*\%#', 'bn', line('.'))[1]
	    if l:startCol == 0
		let l:startCol = col('.')
	    endif
	    return l:startCol - 1 " Return byte index, not column.
	endif
    elseif empty(a:base)
	" Show the file name and the filespec (relative to CWD) of all open
	" buffers.
	let l:bufFiles = map(s:GetBufFilespecs(), '[v:val, fnamemodify(v:val, ":p")]')
	let l:filespecMatches = map(copy(l:bufFiles), 's:MakeMatchObject(v:val[0], v:val[1])')
	let l:filenameMatches = map(l:bufFiles, 's:MakeMatchObject(fnamemodify(v:val[0], ":t"), v:val[1])')

	return l:filespecMatches + l:filenameMatches
    else
	" Find matches starting with a:base in any path component or the file
	" name.
	let l:matches = []
	for l:bufFilespec in s:GetBufFilespecs()
	    let l:matches += s:FindMatches(fnamemodify(l:bufFilespec, ':p'), a:base)
	endfor
	return l:matches
    endif
endfunction

function! BufNameComplete#Expr()
    let s:selectedBaseCol = 0
    set completefunc=BufNameComplete#BufNameComplete
    return "\<C-x>\<C-u>"
endfunction

function! BufNameComplete#Selected()
    call BufNameComplete#Expr()
    let s:selectedBaseCol = col("'<")

    return "g`>" . (col("'>") == (col('$')) ? 'a' : 'i') . "\<C-x>\<C-u>"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
