
" Goyo
" ----

" s:goyo_enter() "{{{
" Disable visual candy in Goyo mode
function! s:goyo_enter()
	" Disable statusline and tabs
	TinyLine!
	ToxidTab!

	if has('gui_running')
		" Gui fullscreen
		set fullscreen
		set background=light
		set linespace=7
	elseif exists('$TMUX')
		" Hide tmux status
		silent !tmux set status off
	endif
	" Disable ZoomWin
	delcommand ZoomWin
	delcommand <Plug>ZoomWin

	" Activate Limelight
	Limelight
endfunction

" }}}
" s:goyo_leave() "{{{
" Enable visuals when leaving Goyo mode
function! s:goyo_leave()
	" Restore color mods
	execute 'source' fnameescape(expand('$VIMPATH/config/colors.vim'))

	" Enable statusline and tabs
	TinyLine
	ToxidTab

	if has('gui_running')
		" Gui exit fullscreen
		set nofullscreen
		set background=dark
		set linespace=0
	elseif exists('$TMUX')
		" Show tmux status
		silent !tmux set status on
	endif

	" Enable ZoomWin
	command! ZoomWin call ZoomWin()
	command! <Plug>ZoomWin call ZoomWin()

	" De-activate Limelight
	Limelight!
endfunction
" }}}

" Goyo Commands {{{
autocmd! User GoyoEnter
autocmd! User GoyoLeave
autocmd  User GoyoEnter nested call <SID>goyo_enter()
autocmd  User GoyoLeave nested call <SID>goyo_leave()
" }}}

" vim: set ts=2 sw=2 tw=80 noet :
