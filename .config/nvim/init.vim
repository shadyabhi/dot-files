" For new installation
"
" $curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
" $sh ./installer.sh ~/.config/nvim/dein
" :call dein#install()
" :call dein#update()
" :UpdateRemotePlugins
if &compatible
  set nocompatible
endif
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

" Install plugins
if dein#load_state('~/.config/nvim/dein')
  call dein#begin('~/.config/nvim/dein')

  call dein#add('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim')
  " Looks
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('gosukiwi/vim-atom-dark')
  call dein#add('tomasr/molokai')
  call dein#add('vim-airline/vim-airline')

  " Tags
  call dein#add('majutsushi/tagbar')
  call dein#add('pseewald/nerdtree-tagbar-combined')

  " Syntax highlighting and autocomplete
  call dein#add('neomake/neomake')
  call dein#add('Shougo/deoplete.nvim')
	if !has('nvim')
	  call dein#add('roxma/nvim-yarp')
	  call dein#add('roxma/vim-hug-neovim-rpc')
	endif
	let g:deoplete#enable_at_startup = 1

  " Json
  call dein#add('elzr/vim-json')

  " Generic
  call dein#add('wincent/ferret')
  call dein#add('scrooloose/nerdtree')
  call dein#add('kien/ctrlp.vim')
  call dein#add('jlanzarotta/bufexplorer')
  call dein#add('tpope/vim-surround')
  call dein#add('terryma/vim-multiple-cursors')
  call dein#add('mklabs/split-term.vim')

  " Git
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('Raimondi/delimitMate')

  " Salt
  call dein#add('saltstack/salt-vim')

  " Editing
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('sudar/comments.vim')

  " Python
  call dein#add('klen/python-mode')
  call dein#add('zchee/deoplete-jedi')

  " Go
  call dein#add('fatih/vim-go', {'on_ft': 'go'})
  " call dein#add('nsf/gocode', {'rtp': 'nvim/'})
  call dein#add('t-yuki/vim-go-coverlay')
  call dein#add('zchee/deoplete-go', {'build': 'make'})


  call dein#end()
  call dein#save_state()
endif

" Generic configs
for f in split(glob('~/.config/nvim/settings.d/*.vim'), '\n')
    exe 'source' f
endfor
" Load Plugin related settings
for f in split(glob('~/.config/nvim/plugin-settings.d/*.vim'), '\n')
    exe 'source' f
endfor

filetype plugin indent on
syntax enable
