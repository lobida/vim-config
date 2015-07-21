" tagbar
autocmd VimEnter * nested :TagbarOpen
" VimFiler
autocmd VimEnter * VimFiler -buffer-name=explorer -split -simple -winwidth=40 -toggle -project -no-quit
" aws
let g:AWSVimValidate = 1
" org
let g:org_todo_keywords = ['TODO', 'INPROCESS', 'PENDING', 'RESOLVED', 'DONE', 'CANCELED']
" Editing mappings
map 0 ^
nmap ;  ;
nmap ,  , 
let maplocalleader = "\\"
" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

inoremap <M-f> <C-o>e<Right>
vnoremap <M-f> <C-o>e<Right>
cnoremap <M-f> <C-o>e<Right>
inoremap <M-b> <S-Left>
vnoremap <M-b> <S-Left>
cnoremap <M-b> <S-Left>
noremap! <M-d> <C-O>dw

" Buffer Mapping
nnoremap <silent>[b :bprevious<CR>
nnoremap <silent>]b :bnext<CR>
nnoremap <silent>[B :bfirst<CR>
nnoremap <silent>]B :blast<CR>
nnoremap <silent>[1 :1b<CR>

set wrap
