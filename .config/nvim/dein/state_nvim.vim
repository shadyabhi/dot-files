if g:dein#_cache_version !=# 420 || g:dein#_init_runtimepath !=# '/Users/arastogi/.config/nvim,/usr/local/etc/xdg/nvim,/etc/xdg/nvim,/Users/arastogi/.local/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/usr/local/Cellar/neovim/0.9.2/share/nvim/runtime,/usr/local/Cellar/neovim/0.9.2/lib/nvim,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/arastogi/.local/share/nvim/site/after,/etc/xdg/nvim/after,/usr/local/etc/xdg/nvim/after,/Users/arastogi/.config/nvim/after,/Users/arastogi/.config/nvim/dein/repos/github.com/Shougo/dein.vim' | throw 'Cache loading error' | endif
let [s:plugins, s:ftplugin] = dein#min#_load_cache_raw(['/Users/arastogi/.config/nvim/init.vim'])
if empty(s:plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = s:plugins
let g:dein#ftplugin = s:ftplugin
let g:dein#_base_path = '/Users/arastogi/.config/nvim/dein'
let g:dein#_runtime_path = '/Users/arastogi/.config/nvim/dein/.cache/init.vim/.dein'
let g:dein#_cache_path = '/Users/arastogi/.config/nvim/dein/.cache/init.vim'
let g:dein#_on_lua_plugins = {}
let &runtimepath = '/Users/arastogi/.config/nvim,/usr/local/etc/xdg/nvim,/etc/xdg/nvim,/Users/arastogi/.local/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/Users/arastogi/.config/nvim/dein/repos/github.com/zchee/deoplete-go,/Users/arastogi/.config/nvim/dein/repos/github.com/Shougo/dein.vim,/Users/arastogi/.config/nvim/dein/.cache/init.vim/.dein,/usr/local/Cellar/neovim/0.9.2/share/nvim/runtime,/Users/arastogi/.config/nvim/dein/.cache/init.vim/.dein/after,/usr/local/Cellar/neovim/0.9.2/lib/nvim,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/arastogi/.local/share/nvim/site/after,/etc/xdg/nvim/after,/usr/local/etc/xdg/nvim/after,/Users/arastogi/.config/nvim/after'
filetype off
