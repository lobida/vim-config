
" Vim Initialization
" ------------------

" Global Mappings "{{{
" Use spacebar instead of '\' as leader. Require before loading plugins.
let g:mapleader="\<Space>"
let g:maplocalleader=","

" Release keymappings for plug-in.
nnoremap ;  <Nop>
xnoremap ;  <Nop>
nnoremap <Space> <Nop>
xnoremap <Space> <Nop>
nnoremap ,  <Nop>
xnoremap ,  <Nop>

" }}}
" Ensure cache directory "{{{
if ! isdirectory(expand($VARPATH))
	" Create missing dirs i.e. cache/{undo,backup}
	call mkdir(expand('$VARPATH/undo'), 'p')
	call mkdir(expand('$VARPATH/backup'))
endif

" }}}
" Set augroup "{{{
augroup MyAutoCmd
	autocmd!
augroup END

" }}}
" Load vault settings "{{{
if filereadable(expand('$VIMPATH/.vault.vim'))
	execute 'source' expand('$VIMPATH/.vault.vim')
endif

" }}}
" Setup NeoBundle "{{{
let s:plugins_dir = expand('$VARPATH/plugins')
let g:neobundle#types#git#default_protocol = 'git'

if has('vim_starting')
	if isdirectory($XDG_CONFIG_HOME.'/vim')
		" Respect XDG
		let $MYVIMRC='$XDG_CONFIG_HOME/vim/vimrc'
		set runtimepath=$VIMPATH,$VIM/vimfiles,$VIMRUNTIME
		set runtimepath+=$VIM/vimfiles/after,$VIMPATH/after
	endif

	" Load NeoBundle for package management
	if &runtimepath !~ '/neobundle.vim'
		if ! isdirectory(s:plugins_dir.'/neobundle.vim')
			" Clone NeoBundle if not found
			execute printf('!git clone %s://github.com/Shougo/neobundle.vim.git',
						\ (exists('$http_proxy') ? 'https' : 'git'))
						\ s:plugins_dir.'/neobundle.vim'
		endif

		execute 'set runtimepath^='.s:plugins_dir.'/neobundle.vim'
	endif
endif

" }}}
" Disable default plugins "{{{

" Disable menu.vim
if has('gui_running')
  set guioptions=Mc
endif

if ! &verbose
	" Disable GetLatestVimPlugin.vim
	let g:loaded_getscriptPlugin = 1
endif

let g:loaded_netrwPlugin = 1
let g:loaded_matchparen = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimballPlugin = 1
" }}}

" vim: set ts=2 sw=2 tw=80 noet :
