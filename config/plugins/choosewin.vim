
" ChooseWin
" ---------

let g:choosewin_label = 'SDFGHJKLZXCVBNM'  " Window labels

let g:choosewin_overlay_enable     = 1     " Use overlay feature
let g:choosewin_blink_on_land      = 0     " Don't blink on landing
let g:choosewin_statusline_replace = 0     " Don't replace statusline
let g:choosewin_tabline_replace    = 0     " Don't replace tabline

let g:choosewin_color_overlay = {
	\ 'gui': [ 'DodgerBlue3', 'DodgerBlue3' ],
	\ 'cterm': [ 2, 248 ]
	\ }

let g:choosewin_color_overlay_current = {
	\ 'gui': [ 'firebrick1', 'firebrick1' ],
	\ 'cterm': [ 60, 235 ]
	\ }

" vim: set ts=2 sw=2 tw=80 noet :
