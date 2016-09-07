set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'mileszs/ack.vim'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-cucumber'
Plugin 'ajf/puppet-vim'
Plugin 'pthrasher/conqueterm-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'scrooloose/nerdtree'
Plugin 'pallymore/vim-ruby-conque'
Plugin 'Keithbsmiley/rspec.vim'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-endwise'
Plugin 'scrooloose/syntastic'
Plugin 'mattn/gist-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'juvenn/mustache.vim'
Plugin 'tpope/vim-commentary'
Plugin 'mattn/webapi-vim'
Plugin 'ap/vim-css-color'
Plugin 'mattn/emmet-vim'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'groenewege/vim-less'
Plugin 'vim-scripts/stata.vim'
Plugin 'slim-template/vim-slim'
Plugin 'digitaltoad/vim-jade'
Plugin 'elzr/vim-json'
Plugin 'kchmck/vim-coffee-script'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-haml'
Plugin 'pangloss/vim-javascript'
Plugin 'briancollins/vim-jst'
Plugin 'mxw/vim-jsx'
Plugin 'gcorne/vim-sass-lint'

set number
syntax on
set autoread " Automatically reload changes if detected
set ruler
set encoding=utf8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*/node_modules/*,*/bower_components/*

" Status bar
set laststatus=2

" Vim-css-color configuration
let g:cssColorVimDoNotMessMyUpdatetime = 1

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" Commentary
map \\ gc
map \\\ gcc

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Key mappings for spec-finders
" Cmd-Shift-R for RSpec
nmap <silent> <D-R> :call RunRspecCurrentFileConque()<CR>
" Cmd-Shift-L for RSpec Current Line
nmap <silent> <D-L> :call RunRspecCurrentLineConque()<CR>
" ,Cmd-R for Last conque command
nmap <silent> ,<D-R> :call RunLastConqueCommand()<CR>

" default font-size to 20
set guifont=Source\ Code\ Pro:h14

" CTags
map <Leader>rt :!/usr/local/bin/ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

if !exists("*s:setupWrapping")
  function s:setupWrapping()
    set wrap
    set wrapmargin=2
    set textwidth=72
  endfunction
endif

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,Guardfile}    set ft=ruby
"
" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupWrapping()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=json
au BufRead,BufNewFile *.txt call s:setupWrapping()

" Mustache configuration
au BufNewFile,BufRead *.mustache        setf mustache

" Yaml Configuration
au BufRead,BufNewFile *.{yml,yaml} set foldmethod=indent

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Enable syntastic syntax checking
let g:syntastic_enable_signs = 1
let g:syntastic_quiet_messages = {'level' : ''}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_mode_map={ 'mode': 'active',
                     \ 'active_filetypes': [],
                     \ 'passive_filetypes': ['html'] }
" let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_sass_checkers=["sass_lint"]
let g:syntastic_scss_checkers=["sass_lint"]
let g:syntastic_javascript_checkers = ['standard', 'eslint']
let g:syntastic_json_checkers = ['jsonlint']

" use ag in ack.vim for faster search
let g:ackprg = 'ag --nogroup --nocolor --column'

" Use modeline overrides
set modeline
set modelines=10

set cursorline

" Default color scheme
color railscasts

" Show (partial) command in the status line
set showcmd

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" Patter ignore when use the completion in search file
set wig=*.o,*.obj,*~,#*#,*.pyc,*.tar*,*.avi,*.ogg,*.mp3

" No save backup by .swp
set nowb
set noswapfile
set noar

" Delete all whitespace in end of line
autocmd BufWritePre * :%s/\s\+$//e

" Autocomplete Fabricator gem
autocmd User Rails Rnavcommand fabricator spec/fabricators -suffix=_fabricator.rb -default=model()

" Autocomplete Fabricator gem
autocmd User Rails Rnavcommand decorator app/decorators -suffix=_decorator.rb -default=model()

" Disalble folding
" set foldmethod=syntax
set nofoldenable

let g:Powerline_symbols = 'fancy'
set t_Co=256

let Tlist_Auto_Update = 'true'
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'

"spell check when writing commit logs
autocmd filetype svn,*commit* set spell

let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .sass-cache
      \ --ignore .node_modules
      \ --ignore .bower_components
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.sass-cache$\|node_modules$\|bower_components$',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
  \ }
