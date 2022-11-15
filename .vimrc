" ======================================================================
" Vim-plug
" ======================================================================

call plug#begin('~/.vim/plugged')

" Deoplete
if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp', { 'do': 'pip install -r requirements.txt' }
	Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
	\ }

" Colorscheme
Plug 'morhetz/gruvbox'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" ======================================================================
" Configuration
" ======================================================================

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Paste from clipboard
set pastetoggle=<F2>

" Show line number
set number

" Incremental search
set incsearch

" Auto indent
set smartindent

" Tab related
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Encoding
set encoding=utf-8

" Hide mode
set noshowmode

" Colorscheme stuff
set background=dark

" Gruvbox dark theme contrast level
let g:gruvbox_contrast_dark = 'hard'

" Auto load colorscheme
autocmd vimenter * ++nested colorscheme gruvbox

" ======================================================================
" LSP
" ======================================================================

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'java': ['/usr/bin/jdtls', '-data', getcwd()],
	\ 'python': ['pyls'],
	\ }

function SetLSPShortcuts()
	nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
	nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
	nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
	nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
	nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
	nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
	nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
	nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
	nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
	nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
	autocmd!
	autocmd FileType java,python call SetLSPShortcuts()
augroup END

" ======================================================================
" Building source stuff
" ======================================================================

" Python
function! PYTHON_SET()
	nnoremap <buffer> <F5> :w<CR>:!clear; python %<CR>
endfunction

" Sagemath
function! SAGE_SET()
	setfiletype python
	nnoremap <buffer> <F5> :w<CR>:!clear; sage %<CR>
endfunction

" Bash
function! BASH_SET()
	nnoremap <buffer> <F5> :w<CR>:!clear; bash %<CR>
endfunction

" ASM
function! NASM_SET()
	set ft=nasm
	nnoremap <buffer> <F5> :w<CR>:!clear; nasm -f elf %; ld -m elf_i386 -o %:r %:r.o; ./%:r<CR>
endfunction

" PHP
function! PHP_SET()
	nnoremap <buffer> <F5> :w<CR>:!clear; php %<CR>
	nnoremap <buffer> <F6> :w<CR>:!clear; php -S localhost:8080<CR>
endfunction

" NODEJS
function! NODEJS_SET()
	nnoremap <buffer> <F5> :w<CR>:!clear; node %<CR>
endfunction

" Load configuration corresponding to file type
autocmd FileType python			call PYTHON_SET()
autocmd FileType sh				call BASH_SET()
autocmd FileType asm			call NASM_SET()
autocmd FileType php			call PHP_SET()
autocmd FileType javascript		call NODEJS_SET()

autocmd BufNewFile,BufRead *.sage call SAGE_SET()
