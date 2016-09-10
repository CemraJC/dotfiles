" Some good defaults
filetype indent plugin on   " Handle different file types
set nocompatible                " vi compatible is LAME
set mouse=a                     " Hardly would use this, but is good for reading
set background=dark             " Use colours that work well on a dark background (Console is usually black)
set encoding=utf-8 nobomb
set ttyfast
set showmode                    " show the current mode
set showcmd
set hidden
set wildmenu
set title                       " Set filename as the window title

" Fix the annoying mode-switch delay
set timeoutlen=1000
set ttimeoutlen=10

" Centralization of vim-related files
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif

syntax on                   " turn syntax highlighting on by default
set list                    " Show them invisible Characters
set listchars=tab:>.,trail:·
set cursorline              " Highlight the current line we're on        
set nostartofline           " Stops the cursor from resetting to the start of the line when paging

" Visual mode mapping for multi-cursor emulation
vnoremap . :normal .<cr>

" Indentation settings
set smartindent
set autoindent
set expandtab
set cindent                     " set auto-indenting on for programming
set tabstop=4
set softtabstop=4
set shiftwidth=4
set scrolloff=6                 " Scrollthrough when reaching a horizontal border to the window

" Commands to run for specific file types, in order of scope
if has('autocmd')
    autocmd VimEnter * silent! Obsession ~/.vim/
    autocmd FileType c,cpp,java,php,ruby,python,javascript,html,csv,xml,ahk,json autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
    autocmd FileType text setlocal filetype=markdown " I like the syntax highlighting
    autocmd FileType markdown setlocal textwidth=80
    autocmd FileType make setlocal tabstop = 8 shiftwidth=8 softtabstop=0 noexpandtab
    autocmd FileType html setlocal tabstop = 2 shiftwidth=2 | set listchars-=tab:>
endif
" imap <C-Return> <CR><CR><C-o>k<Tab>

" Other WINDOWS specific settings
set noshowmatch                 " Never, ever do this - it's sooo annoying!
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set backspace=indent,eol,start  " make that backspace key work the way it should
set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows

" Opening a file quickly (wouldn't think it was hard, would you?)
command! -bang -nargs=* E :call E(<q-bang>, <q-args>)
" Lazy shifting to save keystrokes when using Ex mode
nnoremap ; :

function! E(bang, filename)
    let filename = a:filename
    " Strip quotes (if there are any)
    if stridx(filename, "'") == 0
        let filename = strpart(a:filename, 1, strlen(a:filename) - 2)
    endif
    :exe "e".a:bang." ". fnameescape(filename)
endfu

" Trim trailing whitespace on save
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Search settings
" set hlsearch  " This is a bit annoying.
" nnoremap <leader>c <Esc>:nohlsearch<CR>
set incsearch
set ignorecase
set smartcase

" CUSTOM SHORTCUTS
nnoremap <F6> :setlocal spell! spelllang=en_us<CR>
nnoremap <S-Tab> :bn<CR>
nnoremap <Leader>o o<Esc>kO<Esc>ji
" Set Line numbers and relativenumber
set number          " Always show line numbers
" set relativenumber        " Numbers relative to cursor
set ruler                       " show the cursor position all the time

"
" Mostly just Vundle stuff for plugins
"
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
if &t_Co >= 256
    colorscheme ubaryd
endif

" Custom plugins
set shell=/bin/bash
Plugin 'ctrlpvim/ctrlp.vim'
    set wildignore+=*node_modules/*
    set wildignore+=*.git/*
    let g:ctrlp_show_hidden = 1
    let g:ctrlp_max_files = 5000
    let g:ctrlp_max_depth = 5
    let g:ctrlp_working_path_mode = 'r'
Plugin 'jiangmiao/auto-pairs'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdtree'
    noremap <C-K><C-B> :NERDTreeToggle<CR>
    let NERDTreeShowHidden = 1
    let NERDTreeChDirMode = 2
    let NERDTreeWinSize = 42
    let NERDTreeMinimalUI = 1
    let NERDTreeShowBookmarks = 1
    let NERDTreeShowLineNumbers = 1
    " let NERDTreeBookmarksFile = '~/.vim/'
Plugin 'vim-airline/vim-airline'
    let g:airline_left_sep = '|'
    let g:airline_right_sep = '|'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#fnamemod = ':t'
    let g:airline#extensions#tabline#show_tab_nr = 1
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-obsession'
    " let sessionoptions = "blank,buffers,curdir,folds,globals,help,options,resize,tabpages,winpos,winsize"
Plugin 'vim-airline/vim-airline-themes'
Plugin 'JamshedVesuna/vim-markdown-preview'
    let vim_markdown_preview_hotkey = '<leader>m'
Plugin 'unblevable/quick-scope'
Plugin 'ervandew/supertab'
    let g:SuperTabMappingForward = '<nul>'
    let g:SuperTabMappingBackward = '<s-tab>'
    let g:SuperTabSetDefaultCompletionType = 'context'
    let g:SuperTabClosePreviewOnPopupClose = 1
Plugin 'kshenoy/vim-signature'
Plugin 'suan/vim-instant-markdown'
Plugin 'tomtom/tcomment_vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'junegunn/vim-easy-align'
Plugin 'Townk/vim-autoclose'
Plugin 'mattn/emmet-vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'mbbill/undotree'
    set history=1000
    set undolevels=1000
    nnoremap <leader>u <Esc>:UndotreeToggle<CR>
    if has("persistent_undo")
        set undodir=~/.vim/undo/
        set undofile
    endif

call vundle#end()            " required
filetype plugin indent on    " required
