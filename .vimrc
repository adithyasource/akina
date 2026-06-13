set guicursor=i:block
set shiftwidth=2
set expandtab
set nobackup
set nowritebackup
set noswapfile
set undofile
set nohlsearch
set incsearch
set scrolloff=10
set notermguicolors
set ignorecase
set smartcase
set nowrap
set clipboard+=unnamedplus

nnoremap <C-e> :Explore<CR>
nnoremap <C-s> :w<CR>
vnoremap J :m '>+1<CR>gv-gv
vnoremap K :m '<-2<CR>gv-gv
vnoremap D <Del>
xnoremap p "_dP
nnoremap <C-j> 5j
vnoremap <C-j> 5j
nnoremap <C-k> 5k
vnoremap <C-k> 5k
nnoremap d "_d
vnoremap d "_d

function! OSC52Yank() abort
  let l:text = join(v:event.regcontents, "\n")
  let l:b64 = system('base64 | tr -d "\n"', l:text)
  call writefile(["\e]52;c;" . l:b64 . "\x07"], "/dev/tty", "b")
endfunction

augroup OSC52
  autocmd!
  autocmd TextYankPost * if v:event.operator ==# 'y' | call OSC52Yank() | endif
augroup END
