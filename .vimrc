
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
"


call plug#begin('~/.vin/plugged')
Plug 'preservim/NERDTree'

Plug 'sirver/ultisnips'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

Plug 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_view_method='skim'
    let g:vimtex_quickfix_mode=0

Plug 'KeitaNakamura/tex-conceal.vim'
     "Changed to 2 for markdown possibly needs changing back to 1.
    set conceallevel=1
    let g:tex_conceal='abdmg'
    hi Conceal ctermbg=none

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
    let g:vim_markdown_conceal = 1
    let g:vim_markdown_math = 1
Plug 'ueaner/molokai'

Plug 'vim-airline/vim-airline'
    let g:airline#extensions#whitespace#enabled = 0
Plug 'vifm/vifm.vim'

Plug 'junegunn/fzf'
Plug 'junegunn/fzfvim'
Plug 'michal-h21/vim-zettel'

setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

call plug#end()

if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

set relativenumber

set textwidth=100
set wrap
set nocompatible
filetype plugin on
syntax on

colo molokai

hi! Normal ctermbg=NONE guibg=NONE 
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

hi clear Conceal

" This is supposed to make it work with colemak:
" The main magic is done by the following langmap setting.  Not only does it
" make Colemak's "hnei" work like QWERTY's "hjkl", but it also covers mappings
" like "gj", "zj", etc.
"
" THE ONLY CAVEAT IS THAT MOST MACROS WILL BE BROKEN!  Until this bug is fixed
" in Vim, it is recommended to record a macro with an empty langmap.
"
" The t-f-j rotation is enabled by default but can be disabled using:
"let g:colemak_basics_rotate_t_f_j = 0
if get(g:, 'colemak_basics_rotate_t_f_j', 1)
  set langmap=nN;jJ,eE;kK,iI;lL,kK;nN,uU;iI,lL;uU,fF;eE,tT;fF,jJ;tT
else
  set langmap=nN;jJ,eE;kK,iI;lL,kK;nN,uU;iI,lL;uU,jJ;eE
endif

" Do not apply the langmap to characters resulting from a mapping.
set nolangremap

" Now, we only need to add few remappings not covered by langmap.  Note that
" the langmap setting does not apply to "CTRL + <KEY>", but fortunately, these
" mappings either have semantics different from those without "CTRL" or may be
" disregarded as there are better alternatives covered by langmap (like
" "CTRL-W CTRL-J", which is mapped to the same function as "CTRL-W j").

" Disable timing out on mappings as it makes mapped key sequences unreliable:
" any intermediate delay of more than 1 second would break them.
set notimeout

" Insert mode remappings.  See ":help i_CTRL-G_j" and ":help i_CTRL-G_k".
inoremap <c-g>n <c-g>j
inoremap <c-g><c-n> <c-g><c-j>
inoremap <c-g>e <c-g>k
inoremap <c-g><c-e> <c-g><c-k>
" Due to some bug in Vim 8.0, the following two tautological lines are also
" necessary for the Insert mode remappings to work.
inoremap <c-g>j <c-g>j
inoremap <c-g>k <c-g>k

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
