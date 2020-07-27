"PLUGINS"
"{{{
    filetype indent plugin on
    "Identa de acordo com o tipo do arquivo

    "PLUGINS"

    "VIM-PLUG
    "{
        call plug#begin('~/.vim/plugged')
        if has('nvim')
            Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
        elseif  v:version >= 800
            Plug 'Shougo/denite.nvim'
        endif


        Plug 'mhartington/oceanic-next'
        Plug 'vim-syntastic/syntastic'
        Plug 'honza/vim-snippets'
        Plug 'SirVer/ultisnips'
        Plug 'majutsushi/tagbar'
        Plug 'scrooloose/nerdtree'
        Plug 'ctrlpvim/ctrlp.vim'
        Plug 'ryanoasis/vim-devicons'
        Plug 'chemzqm/denite-extra'
        Plug 'mhinz/vim-grepper'
        Plug 'xolox/vim-misc'
        Plug 'tpope/vim-fugitive'
        Plug 'airblade/vim-gitgutter'
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'kshenoy/vim-signature'
        Plug 'morhetz/gruvbox'
        Plug 'godlygeek/tabular'
        Plug 'bling/vim-bufferline'
        Plug 'lervag/vimtex'
        Plug 'tpope/vim-surround'
        Plug 'gkapfham/vim-vitamin-onec'
        Plug 'flazz/vim-colorschemes'
        Plug 'felixhummel/setcolors.vim'
        Plug 'neoclide/coc.nvim', {'branch' : 'release'}
        Plug 'franbach/miramare'
        Plug 'sheerun/vim-polyglot'
        Plug 'ervandew/supertab'


        call plug#end()
    "}
    "COC"
    "{
        " if hidden is not set, TextEdit might fail.
        set hidden

        " Some servers have issues with backup files, see #649
        set nobackup
        set nowritebackup

        " Better display for messages
        set cmdheight=2

        " You will have bad experience for diagnostic messages when it's default 4000.
        set updatetime=300

        " don't give |ins-completion-menu| messages.
        set shortmess+=c

        " always show signcolumns
        set signcolumn=yes

        " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
        " Coc only does snippet and additional edit on confirm.
        inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        " Or use `complete_info` if your vim support it, like:
        " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

        " Use `[g` and `]g` to navigate diagnostics
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        " Remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        " Use K to show documentation in preview window
        nnoremap <silent> K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
            else
                call CocAction('doHover')
            endif
        endfunction

        " Highlight symbol under cursor on CursorHold
        autocmd CursorHold * silent call CocActionAsync('highlight')

        " Remap for rename current word
        nmap <leader>rn <Plug>(coc-rename)

        " Remap for format selected region
        xmap <leader>f  <Plug>(coc-format-selected)
        nmap <leader>f  <Plug>(coc-format-selected)

        augroup mygroup
            autocmd!
            " Setup formatexpr specified filetype(s).
            autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
            " Update signature help on jump placeholder
            autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end

        " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
        xmap <leader>a  <Plug>(coc-codeaction-selected)
        nmap <leader>a  <Plug>(coc-codeaction-selected)

        " Remap for do codeAction of current line
        nmap <leader>ac  <Plug>(coc-codeaction)
        " Fix autofix problem of current line
        nmap <leader>qf  <Plug>(coc-fix-current)

        " Create mappings for function text object, requires document symbols feature of languageserver.
        xmap if <Plug>(coc-funcobj-i)
        xmap af <Plug>(coc-funcobj-a)
        omap if <Plug>(coc-funcobj-i)
        omap af <Plug>(coc-funcobj-a)

        " Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
        nmap <silent> <C-d> <Plug>(coc-range-select)
        xmap <silent> <C-d> <Plug>(coc-range-select)

        " Use `:Format` to format current buffer
        command! -nargs=0 Format :call CocAction('format')

        " Use `:Fold` to fold current buffer
        command! -nargs=? Fold :call     CocAction('fold', <f-args>)

        " use `:OR` for organize import of current buffer
        command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

        " Add status line support, for integration with other plugin, checkout `:h coc-status`
        set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

        " Using CocList
        " Show all diagnostics
        nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
        " Manage extensions
        nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
        " Show commands
        nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
        " Find symbol of current document
        nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
        " Search workspace symbols
        nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
        " Do default action for next item.
        nnoremap <silent> <space>j  :<C-u>CocNext<CR>
        " Do default action for previous item.
        nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
        " Resume latest coc list
        nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

        "COC-SNIPPETS"
        inoremap <silent><expr> <TAB>
                    \ pumvisible() ? coc#_select_confirm() :
                    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
                    \ <SID>check_back_space() ? "\<TAB>" :
                    \ coc#refresh()

        function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        let g:coc_snippet_next = '<tab>'

    "}

    "AIRLINE"
    "{
        "AIRLINE"
        let g:airline_powerline_fonts = 1
        let g:airline_theme='tomorrow'
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#left_sep = ' '
        let g:airline#extensions#tabline#left_alt_sep = '|'
        let g:airline#extensions#tabline#formatter = 'unique_tail'
        let g:bufferline_show_bufnr = 0
        let g:bufferline_rotate = 1
        let g:bufferline_echo = 0
    "}

    "LATEX PREVIEW"
    "{
        let g:vimtex_view_method='zathura'
        let g:tex_flavor='latex'
        let g:vimtex_quickfix_mode=0
        set conceallevel=1
        let g:tex_conceal='abdmg'

        noremap <leader>c :VimtexCompile<CR>
    "}
    
    "NERDTREE"
    "{
        "NERDTREE"
        "Toogle a arvore de arquivos
        nnoremap <space>t <esc>:NERDTreeToggle<CR>
    "}

    "TABULAR"
    "{
        "TABULAR"
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:\zs<CR>
        vmap <Leader>a: :Tabularize /:\zs<CR>
    "}

    "TAGBAR"
    "{
        "TAGBAR"
        nmap <F7> :TagbarToggle<CR>
        "Toogle com f8
    "}
"}}}

"CONFIGURACOES BASICAS"
"{{{
    "CONFIGURACOES BASICAS
    "
    "
    set colorcolumn=80
    " Marca a linha que nao podemos ultrapassar
    "
    set number
    "Mostra o numero na linha usada
    "
    setlocal spell
    set spelllang=nl,en_us,pt_br
    inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
    "spell checking for the english language
    "
    set statusline+=%#warningmsg#
    set statusline+=%*
    "Mostra mensagens de erro status line

    set clipboard=unnamedplus
    "Coloca como registrador do clipboard o padrao

    set background=dark
    "Dark always

    set termguicolors
    "Gui colors

    highlight Cursor guifg=white guibg=black
    highlight iCursor guifg=white guibg=steelblue
    set guicursor=n-v-c:block-Cursor
    set guicursor+=i:ver100-iCursor
    set guicursor+=n-v-c:blinkon0
    set guicursor+=i:blinkwait10
    "Set a underline in the normal mode

    set encoding=utf-8
    " Encoding

    set t_Co=256
    "Mais cores

    set scrolloff=999
    "Mantem o cursor no centro da tela

    set nocompatible
    "Apenas roda coisas compativeis com o Vim

    set autoindent
    set smartindent
    "Tenta identar de forma inteligente

    let mapleader=","
    "Leader é a vírgula

    set relativenumber
    "Faz aparecer numeros relativos no lado direito

    set cursorline
    "Faz aparecer uma linha encima de onde esta o cursor

    set mouse=a
    "Deixa possivel clicar com o mouse

    set foldmethod=indent
    "Faz dobras a partir da indentacao

    syntax on
    "Faz com que o vim reconheca a syntaxe

    set modelines=0
    "Disativa os modelines

    set nowrap
    "Faz o vim nao mostrar texto fora do tamanho do terminal

    "set formatoptions=tcqrn1
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
    set noshiftround
    "Formata o vim de forma conveniente

    set noswapfile
    set nobackup
    set nowb
    "Tenta nao criar arquivos swap

    nnoremap p p=`]
    nnoremap P P=`]
    "Indenta codigo colado

    set backspace=indent,eol,start
    "Faz o backspace funcionar como deveria

    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
    "Mostra caracteres em branco

    set ttyfast
    "Scroll mais rapido

    set hlsearch
    "Ilumina o que se pesquisa

    set incsearch
    "Pesquisa incremental

    set ignorecase
    "Não importa maiúscula ou minúscula

    set viminfo='100,h,n~/.vim/viminfo
    "Deixa os arquivos no .vim

    colo Atelier_PlateauLight
    "Cor bonita

    nnoremap ; :
    vnoremap ; :
    "Commandos sem ter que ficar apertando o shift

    set showtabline=2
    "Mostra os buffers na parte de cima

    au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl
    "Syntax do glsl
"}}}

"MAPPINGS"
"{{{
    "MAPPINGS

    nnoremap<space>t :CocCommand explorer<CR>
    "Abre o explorador de arquivos do coc

    nnoremap<leader>t :e#<CR>
    "Abre o ultimo arquivo que foi fechado

    nnoremap <leader>r :make!<CR>
    "Compila usando um make file com um run

    nnoremap <leader>e :Errors <CR>
    "Mostra o que nao faz compilar

    nnoremap <leader>us :UltiSnipsEdit<CR>
    "Map ,es para editar os snippets

    nnoremap ( ci(
    nnoremap ) di(
    nnoremap { ci{
    nnoremap } di{
    "Faz algo util com os ( {

    nnoremap <silent> <Space><Space> @=(foldlevel('.')?'za':"\<Space><Space>")<CR>
    vnoremap <Space> zf
    "Folda mais facil


    nnoremap O o<esc>k
    "Cria linhas brancas abaixo

    nnoremap <space>s :vsplit!
    nnoremap <space>h :hsplit!
    "Splits

    noremap <silent> <Leader>+ :exe "vertical resize " . (winwidth(0) * 3/2) <CR>
    nnoremap <silent> <Leader>- :exe "vertical resize " . (winwidth(0) * 2/3) <CR>
    "Muda o tamanho do split

    nnoremap <leader>s :s/
    "Substituicao de termos

    nnoremap <leader><space> :nohls<CR>
    "Apaga a iluminacao de procuras

    nnoremap <leader>v Vip
    "Seleciona um paragrafo


    nnoremap <leader>ev <esc>:tabedit $MYVIMRC<CR>
    "Edita o vimrc

    nnoremap <leader>sv <esc>:source $MYVIMRC<CR>
    "Utiliza o vimrc

    nnoremap <leader>w <esc>:w!<CR>
    nnoremap <c-s> :w<CR>
    inoremap <c-s> <ESC>:w<CR>

    vnoremap <c-s> :w<CR>
    "Salva com facilidade


    nnoremap <space>e <esc>:bnext!<CR>
    nnoremap <space>q <esc>:bprevious!<CR>
    "Move de forma facil entre os buffers

    nnoremap <leader>n <esc>:edit!
    "Edita um novo arquivo

    nnoremap <leader>q <esc>:bd!<CR>
    "Fecha um buffer
    
    "nnoremap <c-w> :wqa!<CR>
    "inoremap <c-w> :wqa!<CR>
    "vnoremap <c-w> :wqa!<CR>

    inoremap jk <esc>
    "Deixa de ter que ficar apertando esc

    nnoremap H 0
    nnoremap L $
    vnoremap H 0
    vnoremap L $
    "Mapeia versoes maiores de movimento

    nnoremap <c-j> <c-w>j
    nnoremap <c-k> <c-w>k
    nnoremap <c-h> <c-w>h
    nnoremap <c-l> <c-w>l
    "Mexe com mais facilidade nos splits
"}}}

""AUTOCMDS""
"{{{
  autocmd filetype python nnoremap <F5> :w <bar> exec '!python '.shellescape('%')<CR>
  autocmd filetype c nnoremap <F5> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
  autocmd filetype cpp nnoremap <F5> :w <bar> exec '!make && ./dtp test/test1.dtp'<CR>
"}}}

