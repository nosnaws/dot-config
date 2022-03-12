" Plugins
call plug#begin("~/.config/nvim/plugged")
Plug 'preservim/nerdtree' " file tree
Plug 'ryanoasis/vim-devicons' " icons for nerdtree
Plug 'nvim-lua/plenary.nvim' " task running for telescope
Plug 'nvim-telescope/telescope.nvim' " fuzzy finder
Plug 'itchyny/lightline.vim' " status line
Plug 'tpope/vim-fugitive' " git integrations
Plug 'preservim/nerdcommenter' " comment/uncomment visual block
Plug 'neoclide/coc.nvim', {'branch': 'release'} " all the auto completion
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " syntax highlighting
Plug 'steelsojka/pears.nvim' " auto pairs
Plug 'tpope/vim-rhubarb' " allows vim-fugitive to link to github

" Themes
" Plug 'sainnhe/everforest'
" Plug 'arcticicestudio/nord-vim'
Plug 'folke/tokyonight.nvim', {'branch': 'main'}
call plug#end()

" Colors
set background=dark
"let g:everforest_background = 'soft'
colorscheme tokyonight " Set the colorscheme

if has('termguicolors')
  set termguicolors " Enables 24-bit colors
endif

" Status bar color setting
let g:lightline = {
  \ 'colorscheme': 'tokyonight',
  \}

" Editor
let mapleader=" " " Set the leader key to space
syntax enable " Enable syntax highlight
set noshowmode " Shows the current mode
set number " Sets line numbers
set cursorline " Highlights the current line
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when needed
set showmatch " highlight matching [{()}]
filetype indent on " load filetype-specific indent files
set incsearch " search while typing
set confirm " Always confirms before actions like closing a file
set foldenable " Enables code folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max
set foldmethod=indent " fold based on indent level
set hidden " allows hidden buffers
set nohlsearch " removes search highlighting
set noswapfile " don't use swap file
set splitright
set splitbelow

" indent stuff
set expandtab
set tabstop=2
set shiftwidth=2

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Main keybinds
nnoremap <leader>fc :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>fs :w<cr>
nnoremap <leader>wq :q<cr>
nnoremap <leader>ga :Git add %<cr>

" telescope
nnoremap <leader><leader> <cmd>Telescope find_files<cr>
nnoremap <leader>sf <cmd>Telescope live_grep<cr>
nnoremap <leader>sh <cmd>Telescope help_tags<cr>
nnoremap <leader>sb <cmd>Telescope buffers<cr>

" Terminal
if has("nvim")
  tnoremap <Esc> <C-\><C-n>
  " start terminal in insert mode
  au BufEnter * if &buftype == 'terminal' | :startinsert | endif
  " open terminal on ctrl+n
  function! OpenTerminal()
    vsplit term://zsh
    vertical resize 60
  endfunction
  nnoremap <c-n> :call OpenTerminal()<CR>
endif


" NERDTree

let g:NERDTreeShowHidden = 1 
let g:NERDTreeMinimalUI = 1 " hide helper
let g:NERDTreeIgnore = ['^node_modules$'] " ignore node_modules to increase load speed 
let g:NERDTreeStatusline = '' " set to empty to use lightline

" " Toggle

noremap <leader>po :NERDTreeToggle<CR>


" " Close window if NERDTree is the last one

autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" " Map to open current file in NERDTree and set size

nnoremap <leader>pv :NERDTreeFind<bar> :vertical resize 45<CR>


" " Map ++ to call NERD Commenter and use iTerm key bindings 

" " to bind Ctmd+/ to ++

vmap ++ <plug>NERDCommenterToggle

nmap ++ <plug>NERDCommenterToggle


" COC

" " COC extension

let g:python_host_prog = '/Users/aswanson/.pyenv/shims/python'
let g:python3_host_prog = '/Users/aswanson/.pyenv/shims/python'

let g:coc_global_extensions = [
      \ 'coc-emmet', 
      \ 'coc-css', 
      \ 'coc-html', 
      \ 'coc-json', 
      \ 'coc-prettier', 
      \ 'coc-tsserver', 
      \ 'coc-snippets', 
      \ 'coc-eslint']

" " To go back to previous state use Ctrl+O

nmap <silent><leader>gd <Plug>(coc-definition)

nmap <silent><leader>gy <Plug>(coc-type-definition)

nmap <silent><leader>gi <Plug>(coc-implementation)

nmap <silent><leader>gr <Plug>(coc-references)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" " Always show the signcolumn, otherwise it would shift the text each time

" " diagnostics appear/become resolved.

if has("patch-8.1.1564")
  " " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" " Use <c-space> to trigger completion.

inoremap <silent><expr> <c-space> coc#refresh() 

" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current

" " position. Coc only does snippet and additional edit on confirm.

" " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif


" " Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')


" " Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)


" " Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" " Applying codeAction to the selected region.

" " Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)


" " Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" " Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" " Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" " Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" " Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" pull in LUA configs
lua require('config')
" CUSTOM FUNCTIONS
augroup filetype_jsx
    autocmd!
    autocmd FileType javascript set filetype=javascriptreact
augroup END
