"===============================================================================
" Plugin source
"===============================================================================
"'psf/black'

"===============================================================================
"" Plugin Configurations
"===============================================================================
" black.vim imports black into vim's own interpreter, so a Homebrew python bump
" leaves it importing a venv built for the previous version. ALE shells out to
" the black executable instead, which no vim/python pairing can invalidate.
let g:load_black = 1
let g:ale_python_black_options = '--skip-string-normalization --line-length 110'

"===============================================================================
" Plugin Keymappings
"===============================================================================
nnoremap <F9> :ALEFix black<CR>
command! Black ALEFix black

"===============================================================================
"" Unite Keymap Menu Item(s)
"===============================================================================
