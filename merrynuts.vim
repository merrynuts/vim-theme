" --------------------------------------------------------------------------
" Theme information
" --------------------------------------------------------------------------
"
" Name: merrynuts
" File: merrynuts.vim
" Description: Terminal-friendly color scheme with enhanced visual mode support
" Version: 2.2 (Enhanced visual mode and syntax highlighting preservation)
"
" Features:
" - Clear distinction between line number area and editing area in all environments
" - Optimized white text on blue background for 8-color terminals
" - Enhanced visual mode with bright yellow background in 8-color terminals
" - Preserved syntax highlighting in visual mode across all environments
" - Support for multiple programming languages and plugins
" - Enhanced terminal-friendly color scheme
" - Optimized for line number and editing area background distinction
"

set background=dark
hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'merrynuts'

" --------------------------------------------------------------------------
" Color Palette
" --------------------------------------------------------------------------
let s:bg_edit = '#151515'      " Editing area background
let s:bg_num  = '#1e1e1e'      " Line number column background
let s:fg      = '#f8f8f2'
let s:red     = '#f92672'
let s:green   = '#a6e22e'
let s:yellow  = '#fd971f'
let s:blue    = '#66d9ef'
let s:purple  = '#ae81ff'
let s:cyan    = '#a1efe4'
let s:gray    = '#75715e'
let s:comment = s:gray
let s:orange  = '#fd971f'

" --------------------------------------------------------------------------
" Terminal color support detection
" --------------------------------------------------------------------------
if has('gui_running')
  " GUI Mode
  let s:is_gui = 1
  let s:term_colors = 256
  let s:bg_edit_ctermbg = 'NONE'
  let s:bg_num_ctermbg = 'NONE'
else
  " Terminal mode
  let s:is_gui = 0
  
  if &t_Co == 256 || &t_Co == 88
    " 256-color or 88-color terminal
    let s:term_colors = &t_Co
    let s:bg_edit_ctermbg = 232
    let s:bg_num_ctermbg = 234
  elseif &t_Co == 8 || &t_Co == 16
    " 8-color or 16-color terminal
    let s:term_colors = &t_Co
    let s:bg_edit_ctermbg = 0
    let s:bg_num_ctermbg = 4
  else
    " Fallback to 8-color
    let s:term_colors = 8
    let s:bg_edit_ctermbg = 0
    let s:bg_num_ctermbg = 4
  endif
  
  " Force 8-color for simple terminals
  if $TERM =~ 'linux\|vt220\|dumb\|xterm-monocolor'
    let s:term_colors = 8
    let s:bg_edit_ctermbg = 0
    let s:bg_num_ctermbg = 4
  endif
endif

" --------------------------------------------------------------------------
" Core UI Elements
" --------------------------------------------------------------------------

" Base interface
exe 'hi Normal       guifg=' . s:fg . ' guibg=' . s:bg_edit . ' ctermfg=255 ctermbg=' . s:bg_edit_ctermbg

" Special settings for 8-color terminals
if s:term_colors <= 8 && !s:is_gui
  " Editing area: black background, light text
  exe 'hi Normal ctermfg=7 ctermbg=0'
  
  " Line number area: blue background, white text
  exe 'hi LineNr ctermfg=7 ctermbg=4'
  exe 'hi CursorLineNr ctermfg=7 ctermbg=4 cterm=bold'
  
  " Current line and column
  exe 'hi CursorLine ctermbg=4'
  exe 'hi CursorColumn ctermbg=4'
  exe 'hi ColorColumn ctermbg=4'
  
  " Sidebar elements
  exe 'hi SignColumn ctermbg=4'
  exe 'hi FoldColumn ctermfg=7 ctermbg=4'
  exe 'hi Folded ctermfg=7 ctermbg=4'
  
  " Enhanced Visual mode for 8-color terminals - use bright yellow background
  " This ensures selected text remains visible while preserving syntax highlighting
  " Bright yellow background, keep original text colors
  exe 'hi Visual ctermbg=11 cterm=NONE'  
  exe 'hi VisualNOS ctermbg=11 cterm=NONE'
  
else
  " Standard settings for 256-color terminals and GUI
  exe 'hi Normal       guifg=' . s:fg . ' guibg=' . s:bg_edit . ' ctermfg=255 ctermbg=' . s:bg_edit_ctermbg
  exe 'hi LineNr       guifg=' . s:gray . ' guibg=' . s:bg_num . ' ctermfg=59 ctermbg=' . s:bg_num_ctermbg
  exe 'hi CursorLineNr guifg=' . s:fg . ' guibg=' . s:bg_num . ' ctermfg=255 ctermbg=' . s:bg_num_ctermbg . ' gui=bold cterm=bold'
  exe 'hi CursorLine   guibg=' . s:bg_num . ' ctermbg=' . s:bg_num_ctermbg
  exe 'hi CursorColumn guibg=' . s:bg_num . ' ctermbg=' . s:bg_num_ctermbg
  exe 'hi ColorColumn  guibg=' . s:bg_num . ' ctermbg=' . s:bg_num_ctermbg
  exe 'hi SignColumn   guibg=' . s:bg_num . ' ctermbg=' . s:bg_num_ctermbg
  exe 'hi FoldColumn   guifg=' . s:gray . ' guibg=' . s:bg_num . ' ctermfg=59 ctermbg=' . s:bg_num_ctermbg
  exe 'hi Folded       guifg=' . s:comment . ' guibg=' . s:bg_num . ' ctermfg=59 ctermbg=' . s:bg_num_ctermbg
  
  " Visual mode for 256-color terminals and GUI
  exe 'hi Visual guibg=#3a3a3a ctermbg=237'
  exe 'hi VisualNOS guibg=#3a3a3a ctermbg=237'
endif

" General settings (all environments)
exe 'hi Cursor       guifg=' . s:bg_edit . ' guibg=' . s:fg . ' ctermfg=' . s:bg_edit_ctermbg . ' ctermbg=255'
exe 'hi Search       guifg=' . s:bg_edit . ' guibg=' . s:yellow . ' ctermfg=' . s:bg_edit_ctermbg . ' ctermbg=208 gui=bold cterm=bold'
exe 'hi IncSearch    guifg=' . s:bg_edit . ' guibg=' . s:yellow . ' ctermfg=' . s:bg_edit_ctermbg . ' ctermbg=208 gui=bold cterm=bold'
exe 'hi MatchParen   guifg=' . s:bg_edit . ' guibg=' . s:cyan . ' ctermfg=' . s:bg_edit_ctermbg . ' ctermbg=123 gui=bold cterm=bold'

" --------------------------------------------------------------------------
" Enhanced Visual Mode Settings for All Environments
" --------------------------------------------------------------------------

" Ensure Visual mode preserves syntax highlighting by not forcing specific foreground colors
" The key is to use a background color that provides good contrast while allowing
" the original syntax colors to show through

" For GUI and 256-color terminals (already set above, but ensure they don't override syntax colors)
if s:term_colors > 8 || s:is_gui
  " These settings use background colors only, preserving syntax highlighting
  exe 'hi Visual guibg=#3a3a3a ctermbg=237 gui=NONE cterm=NONE'
  exe 'hi VisualNOS guibg=#3a3a3a ctermbg=237 gui=NONE cterm=NONE'
endif

" --------------------------------------------------------------------------
" Wild Menu and Popup Menus
" --------------------------------------------------------------------------
exe 'hi WildMenu     guifg=' . s:bg_edit . ' guibg=' . s:blue . ' ctermfg=' . s:bg_edit_ctermbg . ' ctermbg=81'
exe 'hi Pmenu        guifg=' . s:fg . ' guibg=#2d2d2d ctermfg=255 ctermbg=235'
exe 'hi PmenuSel     guifg=' . s:bg_edit . ' guibg=' . s:blue . ' ctermfg=' . s:bg_edit_ctermbg . ' ctermbg=81 gui=bold cterm=bold'
exe 'hi PmenuSbar    guibg=#2d2d2d ctermbg=235'
exe 'hi PmenuThumb   guibg=' . s:gray . ' ctermbg=59'

" --------------------------------------------------------------------------
" Status Line and Tab Line
" --------------------------------------------------------------------------
exe 'hi StatusLine   guifg=' . s:fg . ' guibg=#2d2d2d ctermfg=255 ctermbg=236 gui=bold cterm=bold'
exe 'hi StatusLineNC guifg=' . s:gray . ' guibg=#2d2d2d ctermfg=59 ctermbg=236'
exe 'hi VertSplit    guifg=' . s:gray . ' guibg=' . s:bg_edit . ' ctermfg=59 ctermbg=' . s:bg_edit_ctermbg
exe 'hi TabLine      guifg=' . s:gray . ' guibg=#2d2d2d ctermfg=59 ctermbg=236'
exe 'hi TabLineSel   guifg=' . s:fg . ' guibg=' . s:bg_edit . ' ctermfg=255 ctermbg=' . s:bg_edit_ctermbg . ' gui=bold cterm=bold'
exe 'hi TabLineFill  guifg=' . s:gray . ' guibg=#2d2d2d ctermfg=59 ctermbg=236'

" --------------------------------------------------------------------------
" Text Elements
" --------------------------------------------------------------------------
exe 'hi NonText      guifg=' . s:gray . ' ctermfg=59'
exe 'hi SpecialKey   guifg=' . s:gray . ' ctermfg=59'
exe 'hi Title        guifg=' . s:green . ' ctermfg=148 gui=bold cterm=bold'
exe 'hi ErrorMsg     guifg=' . s:red . ' guibg=' . s:bg_edit . ' ctermfg=197 ctermbg=' . s:bg_edit_ctermbg . ' gui=bold cterm=bold'
exe 'hi WarningMsg   guifg=' . s:yellow . ' guibg=' . s:bg_edit . ' ctermfg=208 ctermbg=' . s:bg_edit_ctermbg . ' gui=bold cterm=bold'
exe 'hi MoreMsg      guifg=' . s:green . ' ctermfg=148 gui=bold cterm=bold'
exe 'hi ModeMsg      guifg=' . s:green . ' ctermfg=148 gui=bold cterm=bold'
exe 'hi Question     guifg=' . s:green . ' ctermfg=148 gui=bold cterm=bold'
exe 'hi Error        guifg=' . s:red . ' guibg=' . s:bg_edit . ' ctermfg=197 ctermbg=' . s:bg_edit_ctermbg . ' gui=bold cterm=bold'
exe 'hi Todo         guifg=' . s:bg_edit . ' guibg=' . s:yellow . ' ctermfg=' . s:bg_edit_ctermbg . ' ctermbg=208 gui=bold cterm=bold'

" --------------------------------------------------------------------------
" Syntax Highlighting - Enhanced for Visual Mode Compatibility
" --------------------------------------------------------------------------

" Important: These syntax highlighting groups will be preserved in Visual mode
" because we're only setting background colors for Visual mode, not foreground

" Comments and Documentation
exe 'hi Comment      guifg=' . s:comment . ' ctermfg=59'
exe 'hi SpecialComment guifg=' . s:comment . ' ctermfg=59'

" Constants
exe 'hi Constant     guifg=' . s:purple . ' ctermfg=141'
exe 'hi String       guifg=' . s:green . ' ctermfg=148'
exe 'hi Character    guifg=' . s:green . ' ctermfg=148'
exe 'hi Number       guifg=' . s:purple . ' ctermfg=141'
exe 'hi Boolean      guifg=' . s:purple . ' ctermfg=141'
exe 'hi Float        guifg=' . s:purple . ' ctermfg=141'

" Identifiers
exe 'hi Identifier   guifg=' . s:yellow . ' ctermfg=208'
exe 'hi Function     guifg=' . s:blue . ' ctermfg=81 gui=bold cterm=bold'

" Statements and Keywords
exe 'hi Statement    guifg=' . s:red . ' ctermfg=197'
exe 'hi Conditional  guifg=' . s:red . ' ctermfg=197'
exe 'hi Repeat       guifg=' . s:red . ' ctermfg=197'
exe 'hi Label        guifg=' . s:red . ' ctermfg=197'
exe 'hi Operator     guifg=' . s:red . ' ctermfg=197'
exe 'hi Keyword      guifg=' . s:red . ' ctermfg=197'
exe 'hi Exception    guifg=' . s:red . ' ctermfg=197'

" Preprocessor
exe 'hi PreProc      guifg=' . s:yellow . ' ctermfg=208'
exe 'hi Include      guifg=' . s:blue . ' ctermfg=81'
exe 'hi Define       guifg=' . s:yellow . ' ctermfg=208'
exe 'hi Macro        guifg=' . s:yellow . ' ctermfg=208'
exe 'hi PreCondit    guifg=' . s:yellow . ' ctermfg=208'

" Types
exe 'hi Type         guifg=' . s:cyan . ' ctermfg=123'
exe 'hi StorageClass guifg=' . s:cyan . ' ctermfg=123'
exe 'hi Structure    guifg=' . s:cyan . ' ctermfg=123'
exe 'hi Typedef      guifg=' . s:cyan . ' ctermfg=123'

" Special Characters
exe 'hi Special      guifg=' . s:yellow . ' ctermfg=208'
exe 'hi SpecialChar  guifg=' . s:yellow . ' ctermfg=208'
exe 'hi Tag          guifg=' . s:yellow . ' ctermfg=208'
exe 'hi Delimiter    guifg=' . s:fg . ' ctermfg=255'
exe 'hi Debug        guifg=' . s:red . ' ctermfg=197'

" --------------------------------------------------------------------------
" Diff and Spell Checking
" --------------------------------------------------------------------------
exe 'hi DiffAdd    guifg=' . s:green . ' guibg=' . s:bg_edit . ' ctermfg=148 ctermbg=' . s:bg_edit_ctermbg . ' gui=bold cterm=bold'
exe 'hi DiffChange guifg=' . s:yellow . ' guibg=' . s:bg_edit . ' ctermfg=208 ctermbg=' . s:bg_edit_ctermbg . ' gui=bold cterm=bold'
exe 'hi DiffDelete guifg=' . s:red . ' guibg=' . s:bg_edit . ' ctermfg=197 ctermbg=' . s:bg_edit_ctermbg . ' gui=bold cterm=bold'
exe 'hi DiffText   guifg=' . s:blue . ' guibg=' . s:bg_edit . ' ctermfg=81 ctermbg=' . s:bg_edit_ctermbg . ' gui=bold cterm=bold'

exe 'hi SpellBad   guifg=' . s:red . ' guibg=' . s:bg_edit . ' ctermfg=197 ctermbg=' . s:bg_edit_ctermbg . ' gui=undercurl cterm=undercurl'
exe 'hi SpellCap   guifg=' . s:blue . ' guibg=' . s:bg_edit . ' ctermfg=81 ctermbg=' . s:bg_edit_ctermbg . ' gui=undercurl cterm=undercurl'
exe 'hi SpellRare  guifg=' . s:cyan . ' guibg=' . s:bg_edit . ' ctermfg=123 ctermbg=' . s:bg_edit_ctermbg . ' gui=undercurl cterm=undercurl'
exe 'hi SpellLocal guifg=' . s:yellow . ' guibg=' . s:bg_edit . ' ctermfg=208 ctermbg=' . s:bg_edit_ctermbg . ' gui=undercurl cterm=undercurl'

" --------------------------------------------------------------------------
" Terminal Support
" --------------------------------------------------------------------------
if has('terminal')
  exe 'hi Terminal guifg=' . s:fg . ' guibg=' . s:bg_edit . ' ctermfg=255 ctermbg=' . s:bg_edit_ctermbg
endif

" --------------------------------------------------------------------------
" File Type Specific Enhancements
" --------------------------------------------------------------------------
exe 'hi markdownH1 guifg=' . s:red . ' ctermfg=197 gui=bold cterm=bold'
exe 'hi markdownH2 guifg=' . s:orange . ' ctermfg=208 gui=bold cterm=bold'
exe 'hi markdownBold guifg=' . s:yellow . ' ctermfg=220 gui=bold cterm=bold'

exe 'hi pythonBuiltin guifg=' . s:cyan . ' ctermfg=81'
exe 'hi pythonFunction guifg=' . s:blue . ' ctermfg=81 gui=bold cterm=bold'

exe 'hi javaScriptFunction guifg=' . s:red . ' ctermfg=197 gui=bold cterm=bold'
exe 'hi javaScriptIdentifier guifg=' . s:yellow . ' ctermfg=208'

exe 'hi htmlTagName guifg=' . s:red . ' ctermfg=197'
exe 'hi htmlArg guifg=' . s:yellow . ' ctermfg=208'

exe 'hi cssIdentifier guifg=' . s:yellow . ' ctermfg=208'
exe 'hi cssClassName guifg=' . s:green . ' ctermfg=148'

" --------------------------------------------------------------------------
" Plugin Support
" --------------------------------------------------------------------------
exe 'hi NERDTreeDir guifg=' . s:blue . ' ctermfg=81 gui=bold cterm=bold'
exe 'hi NERDTreeExecFile guifg=' . s:green . ' ctermfg=148'

exe 'hi GitGutterAdd guifg=' . s:green . ' ctermfg=148'
exe 'hi GitGutterChange guifg=' . s:yellow . ' ctermfg=208'
exe 'hi GitGutterDelete guifg=' . s:red . ' ctermfg=197'

exe 'hi airline_a guifg=' . s:bg_edit . ' guibg=' . s:blue . ' ctermfg=' . s:bg_edit_ctermbg . ' ctermbg=81'
exe 'hi airline_b guifg=' . s:fg . ' guibg=' . s:bg_num . ' ctermfg=255 ctermbg=' . s:bg_num_ctermbg

" --------------------------------------------------------------------------
" Clean up variables
" --------------------------------------------------------------------------
unlet s:bg_edit s:bg_num s:fg s:red s:green s:yellow s:blue s:purple s:cyan s:gray s:comment s:orange
unlet s:bg_edit_ctermbg s:bg_num_ctermbg s:is_gui s:term_colors

