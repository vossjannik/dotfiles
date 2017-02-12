" --------------------
" VIMRC by Jannik Voss
" --------------------

" for practicing
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" pathogen runtime injection and help indexing
filetype off  " force reloading *after* pathogen loaded
call pathogen#infect()

" basic setup
set autoread        " automatic reload when file is changed by another programm
set nocompatible    " enter the new century (disable compatibility with VI)
set encoding=utf8
syntax enable       " enable syntax processing
filetype indent on  " load filetype-specific indent files
set showmatch       " highlight matching [{()}]
set lazyredraw      " redraw only when we need to
set noerrorbells    " disable beeping
set guifont=Source\ Code\ Pro\ 13
set cursorline

" line numbers
set number relativenumber            " enable hybrid line numbers by default
function! NumberToggle()
    if (&relativenumber == 1)
        set number norelativenumber  " enable absolute line numbers
    else
        set number relativenumber    "enable hybrid line numbers
    endif
endfunc


" leader key mappings
let mapleader=" "         " remap <Leader> to <Space> as backslashes are too
                          " painfull to type on a german keyboard
let maplocalleader="\\"   " set localleader to backslash
    " save session. can be reopened by running 'vim -S' in the console
nnoremap <leader>S :mksession!<cr>
    " save any changes to the current file
nnoremap <leader>s :update<cr>
    " search current word using double space
nnoremap <leader><Space> *<cr>
    " leader + move for moving between splits
nnoremap <leader>j :wincmd j<cr>
nnoremap <leader>h :wincmd h<cr>
nnoremap <leader>k :wincmd k<cr>
noremap <leader>l :wincmd l<cr>
    " toggle line-number mode
nnoremap <localleader>n :call NumberToggle()<cr>

" basic key mappings
    " jump to matching pairs easily
nnoremap <Tab> %
    " make makros easier to use. qq to record->q to stop recording->Q to apply
nnoremap Q @q
    " toggle NERDTree with Ctrl+n
map <C-m> :NERDTreeToggle<cr>
map <C-n> :NERDTreeFind<cr>
    " map command t
map <C-t> :CommandT<cr>

" remove trailing whitespace on save
function! <SID>StripTrailingWhitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l,c)
endfunc


    " strip trailing whitespace on save
autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespace()
    " open NERDTree when no file was specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    " close vim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" search settings
set incsearch  " search incrementally as characters are entered
set hlsearch   " highlight matches

" tabs, spaces and indentation
set tabstop=4        " number of visual spaces per tab
set softtabstop=4    " number of spaces when editing
set expandtab        " tabs are spaces
set autoindent       " always set autoindenting on
set copyindent       " copy previous indentation on autoindenting
set shiftwidth=4     " number of spaces indented when calling >

" make backups less annoying
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,./  " a bunch of better locations for the backups
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,./
set writebackup
set noswapfile

" color scheme
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif
let &colorcolumn=join(range(81,999),",")
hi CursorLineNr term=bold ctermfg=11 gui=bold guifg=White

" syntastic configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

" command-t configuration
set wildignore+=node_modules/**

