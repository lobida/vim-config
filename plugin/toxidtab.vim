
" vim-toxidtab - Tiny tab-line for Vim
" Maintainer: Rafael Bodill <justrafi at gmail dot com>
" Version:    20150207
"-------------------------------------------------

" Disable reload {{{
if exists('g:loaded_toxidtab') && g:loaded_toxidtab
	finish
endif
let g:loaded_toxidtab = 1

" }}}
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

" Configuration {{{
" Limit display of directories in path
if ! exists('g:toxidtab_display_max_dirs')
	let g:toxidtab_display_max_dirs = 3
endif
" Limit display of characters in each directory in path
if ! exists('g:toxidtab_display_max_dir_chars')
	let g:toxidtab_display_max_dir_chars = 5
endif

" }}}
" Command {{{
command! -nargs=0 -bar -bang ToxidTab call s:toxidtab('<bang>' == '!')
" }}}

" }}}
function! s:toxidtab(disable) " {{{
	" Toggle tabs

	if a:disable
		set tabline=
	else
		let &tabline='%!toxidtab#render()'
		call s:colorscheme()
	endif
endfunction

" }}}
function! s:colorscheme() " {{{
	hi TabLineFill      ctermfg=236 guifg=#303030
	hi TabLine          ctermfg=236 ctermbg=243 guifg=#303030 guibg=#767676
	hi TabLineSel       ctermfg=241 ctermbg=234 guifg=#626262 guibg=#1C1C1C gui=NONE
	hi TabLineSelRe     ctermfg=234 ctermbg=236 guifg=#1C1C1C guibg=#303030
	hi TabLineProject   ctermfg=252 ctermbg=238 guifg=#D0D0D0 guibg=#444444
	hi TabLineProjectRe ctermfg=238 ctermbg=236 guifg=#444444 guibg=#303030
	hi TabLineA         ctermfg=235 ctermbg=234 guifg=#262626 guibg=#1C1C1C
endfunction

" }}}
function! toxidtab#render()
	" Main tabline function. Draws the whole damn tabline

	let s = '%#TabLineProject# %{toxidtab#project_name()} %#TabLineProjectRe#⮀%#TabLine#  '
	let nr = tabpagenr()
	for i in range(tabpagenr('$'))
		if i + 1 == nr
			let s .= '%#TabLineA#░'
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine# '
		endif
		" Set the tab page number (for mouse clicks)
		let s .= '%'.(i + 1).'T'
		let s .= '%{toxidtab#tab_label('.(i + 1).')} '
		if i + 1 == nr
			let s .= '%#TabLineSelRe#⮀ '
		else
			let s .= ' '
		endif
	endfor

	" After the last tab fill with TabLineFill and reset tab page nr
	let s .= '%#TabLineFill#%T'
	return s
endfunction

" }}}
function! toxidtab#project_name()
	" Finds the project name from tab current directory.
	" It tries to find the root path of a git repository.

	" Use the cached (tab scope) variable unless the current dir changed
	if ! exists('t:project_name') || ! (exists('t:project_dir') && t:project_dir == getcwd())
		" Store the current dir for caching
		let t:project_dir = getcwd()
		let t:project_name = t:project_dir
		" If no .git folder in cwd = it's not a git repo.
		" If no .git file in cwd = it's not a git submodule.
		if ! isdirectory('.git') && ! filereadable('.git')
			" Look upwards (at parents) for a file or dir named '.git':
			" First lookup for a .git file, symbolizing a git submodule
			let t:project_name = substitute(finddir('.git', '.;'), '/.git', '', '')
			if t:project_name == ''
				" Secondly, lookup for a .git folder, symbolizing a git repo
				let parent = substitute(finddir('.git', '.;'), '/.git', '', '')
			endif
			if t:project_name == ''
				let t:project_name = t:project_dir
			endif
		endif
		" Use the tail of the path (last component of the path)
		if len(t:project_name) > 1
			let t:project_name = fnamemodify(t:project_name, ':t')
		endif
	endif
  return t:project_name
endfunction

" }}}
function! toxidtab#tab_label(n)
	" Returns a specific tab's label

	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	let filepath = bufname(buflist[winnr - 1])
	if len(filepath) == 0
		let label = '[No Name]'
	else
		let pre = ''
		let project_dir = gettabvar(a:n, 'project_dir')
		if strridx(filepath, project_dir) == 0
			let filepath = strpart(filepath, len(project_dir))
			let pre .= gettabvar(a:n, 'project_name').'⮀'
		endif

		" Shorten dir names
		let short = substitute(filepath,
			\ "[^/]\\{".g:toxidtab_display_max_dir_chars."}\\zs[^/]\*\\ze/", '', 'g')
		" Decrease dir count
		let parts = split(short, '/')
		if len(parts) > g:toxidtab_display_max_dirs
			let parts = parts[-g:toxidtab_display_max_dirs-1 : ]
		endif
		let filepath = join(parts, '/')

		" Prepend the project name
		let label = pre.filepath
	endif
	return label
endfunction
" }}}

" Run-time {{{
" Enable plugin by default
ToxidTab
" }}}
"
" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}

" vim: set ts=2 sw=2 tw=80 noet :
