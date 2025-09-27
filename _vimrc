" 1. Basic Settings
set noloadplugins
filetype off
syntax on
filetype plugin indent on

" 2. Cross-Platform Clipboard Integration
if has("win32") || has("win64")
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif
set mouse=a

" 3. Display Optimization
set shortmess+=I
set number

" 4. Cross-Platform Font Configuration
if has("gui_running")
  if has("win32") || has("win64")
    "set guifont=RobotoMono_Nerd_Font:h16,Yahei_Consolas_Hybrid:h16
    set guifont=RobotoMono_Nerd_Font:h16,Yahei_Consolas_Hybrid:h16
  else
    set guifont=RobotoMono\ Nerd\ Font\ 14,Yahei\ Consolas\ Hybrid\ 14 
  endif
endif

" 5. Encoding Standards
set encoding=utf-8
set fileencoding=utf-8
set fileformats=unix
set nobackup
set nowritebackup
set noswapfile

" 6. Interface Control
set cmdheight=1
set laststatus=2
set statusline=%F%m%r%h%w\ [%Y]\ [%{&fileformat}:%{&fileencoding}]\ %=\ %l,%v\ :\ %L

set visualbell
set t_vb=
set guioptions-=m
set guioptions-=T

" 7. Intelligent Editing
inoremap { {}<Esc>i
inoremap [ []<Esc>i
inoremap ( ()<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
inoremap <C-x> <Delete>
inoremap <C-z> <Backspace>
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" 8. Color Scheme
"    Consistent Terminal and GUI Coloring
if !has("gui_running")
  set t_Co=256
  colorscheme merrynuts
else
  colorscheme merrynuts
endif

" 9. Cursor Movement in Insert Mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" 10. Compatibility Handling
set langmap=
set noexrc
set lazyredraw
" 自动将 DOS 格式（CRLF）中的^M 删除
" 增强版：处理前备份/支持特定文件类型
function! RemoveCR()
    if &modifiable && !&readonly
        " 备份修改前的文件内容（用于撤消）
        let b:cur_text = getline(1, '$')
        
        let save_cursor = getpos(".")
        silent! %s/\r//ge
        call setpos('.', save_cursor)
        
        " 可选：检测是否修改了内容
        if b:cur_text !=# getline(1, '$')
            echo "已移除 Windows 换行符(^M)"
        endif
    endif
endfunction

" 只对文本文件生效（按需修改扩展名）
autocmd BufRead *.txt,*.py,*.js,*.html,*.css call RemoveCR()
