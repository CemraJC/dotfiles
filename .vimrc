" Some good defaults
filetype indent plugin on       " Handle different file types
syntax on                       " Turn syntax highlighting on by default
set nocompatible
set background=dark
set encoding=utf-8 nobomb
set ttyfast
set showmode                    " Show the current mode (Insert, Visual - etc)
set showcmd                     " Show partial commands as you type them
set wildmenu
set title                       " Set filename as the window title
set hidden                      " Allow buffers to be hidden when not viewing them (allows for bufferline)
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set backspace=indent,eol,start  " Make that backspace key work the way it should
set number                      " Always show line numbers
set ruler                       " Show the cursor position all the time

" Fix the annoying mode-switch delay that would otherwise happen because Esc
" is apparently a command leader in visual mode.
set timeoutlen=1000
set ttimeoutlen=10

" Centralization of vim-related files
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif

set list                    " Show them invisible Characters
set listchars=tab:>.,trail:·
set cursorline              " Highlight the current line we're on
set scrolloff=6             " Scrollthrough when reaching a horizontal border to the window
set nostartofline           " Stops the cursor from resetting to the start of the line when paging

" Visual mode mapping for multi-cursor emulation
vnoremap . :normal .<cr>

" Indentation settings
set autoindent
set expandtab
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4


" Commands to run for specific file types, in order of scope
if has('autocmd')
    autocmd FileType c,cpp,java,php,ruby,python,javascript,html,csv,xml,ahk,json autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
    autocmd FileType text setlocal filetype=markdown " I like the syntax highlighting
    autocmd FileType markdown setlocal textwidth=80
    autocmd FileType make setlocal tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
    autocmd FileType html setlocal tabstop=2 shiftwidth=2 | set listchars-=tab:>
endif

" Other WINDOWS specific settings
set noshowmatch                 " Never, ever do this - it's sooo annoying!
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows

" Opening a file quickly (wouldn't think it was hard, would you?)
command! -bang -nargs=* E :call E(<q-bang>, <q-args>)

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
set incsearch
set ignorecase
set smartcase
    " set hlsearch  " This is a bit annoying.
    " nnoremap <leader>c <Esc>:nohlsearch<CR>

" Spell check toggler
nnoremap <F6> :setlocal spell! spelllang=en_us<CR>
" Quick tabbing
nnoremap <S-Tab> :bn<CR>
" Open a padded newline (useful for neatness)
nnoremap <Leader>o o<Esc>kO<Esc>ji

" Long-line wrap jumping
nnoremap j gj
nnoremap k gk


" Mostly just Vundle stuff for plugins
" REQUIRED
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
if &t_Co >= 256
    colorscheme ubaryd
endif
" END REQUIRED

" Custom plugins
set shell=/bin/bash
Plugin 'rhysd/committia.vim'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'KabbAmine/vCoolor.vim'
    let g:vcoolor_custom_picker = '~/.vim/bundle/vCoolor.vim/pickers/win32/cpicker.exe '
    let g:vcoolor_map = '<Leader>CC'
    let g:vcool_ins_rgb_map = '<Leader>CR'
    let g:vcool_ins_hsl_map = '<Leader>CH'
    let g:vcool_ins_rgba_map = '<Leader>CA'
Plugin 'low-ghost/nerdtree-fugitive'
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
    let g:airline#extensions#tabline#buffer_idx_mode = 1
    nmap <leader>1 <Plug>AirlineSelectTab1
    nmap <leader>2 <Plug>AirlineSelectTab2
    nmap <leader>3 <Plug>AirlineSelectTab3
    nmap <leader>4 <Plug>AirlineSelectTab4
    nmap <leader>5 <Plug>AirlineSelectTab5
    nmap <leader>6 <Plug>AirlineSelectTab6
    nmap <leader>7 <Plug>AirlineSelectTab7
    nmap <leader>8 <Plug>AirlineSelectTab8
    nmap <leader>9 <Plug>AirlineSelectTab9
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-obsession'
    " let sessionoptions = "blank,buffers,curdir,folds,globals,help,options,resize,tabpages,winpos,winsize"
    nnoremap <Leader>] <Esc>:Obsession ~/.vim/session.vim<CR>
Plugin 'vim-airline/vim-airline-themes'
Plugin 'unblevable/quick-scope'
Plugin 'ervandew/supertab'
    let g:SuperTabMappingForward = '<nul>'
    let g:SuperTabMappingBackward = '<s-tab>'
    let g:SuperTabSetDefaultCompletionType = 'context'
    let g:SuperTabClosePreviewOnPopupClose = 1
Plugin 'kshenoy/vim-signature'
Plugin 'tomtom/tcomment_vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'junegunn/vim-easy-align'
Plugin 'Townk/vim-autoclose'
Plugin 'mattn/emmet-vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
    let g:vim_markdown_folding_disabled = 1
Plugin 'mbbill/undotree'
    set history=1000
    set undolevels=1000
    nnoremap <leader>u <Esc>:UndotreeToggle<CR>
    if has("persistent_undo")
        set undodir=~/.vim/undo/
        set undofile
    endif

call vundle#end()
filetype plugin indent on
