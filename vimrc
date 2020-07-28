""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" file:   .vimrc
" author: kyrieluo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 配色
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme desert 
"colorscheme ron

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 编码语言设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 缓冲文本编码，默认使用locale
set encoding=utf-8
" :w时保存文件类型（vim打开文件如果没有默认编码，保存就用这种编码，否则就沿用打开时识别的编码类型）
set fileencoding=utf-8
" 打开文件的猜测列表，用于打开文件
set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,big5
" 输出到终端的编码类型，默认空值，不进行转码（使用终端默认编码类型）
"set termencoding=utf-8
" 语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn
" 自动搜索格式打开文件
set fileformats=unix,dos

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 基础设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 启动的时候不显示那个援助乌干达儿童的提示
"set shortmess=atI
" 使用vim而非vi
set nocompatible
" 不要图形按钮 
set go=
" 显示中文帮助
if version >= 603
	set helplang=cn
	set encoding=utf-8
endif
" 错误输入时不要窗口闪烁  
set novisualbell
" 去掉输入错误的提示声音
set noerrorbells
" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 历史记录数
set history=1000
" 不生成备份文件 
set nobackup
"禁止生成临时文件
set noswapfile


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 编辑设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"语法高亮
syntax on
" 显示行号
set number
" 自动缩进
set autoindent
"c/c++自动缩进
set cindent
" 为C程序提供自动缩进
set smartindent
" Tab键的宽度
set tabstop=4
" 用空格代替制表符
set expandtab
" 自动缩进的空白长度
set shiftwidth=4
" 搜索忽略大小写
set ignorecase
" 搜索字符高亮
set hlsearch
" 逐字符高亮并匹配
"set incsearch
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 使回退键（backspace）正常处理indent, eol, start等
set backspace=indent,eol,start
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=5
" 打开状态栏标尺（有状态栏就集成在状态栏显示）
set ruler
" 突出显示当前行
set cursorline
" 启用折叠
"set foldenable
" 折叠方式
"set foldmethod=indent 
" 显示折叠栏宽度（可设置0-12）
"set foldcolumn=0
" 折叠的层次
"set foldlevel=3 
" 侦测文件类型
filetype on
" 载入文件类型插件
filetype plugin on
" 为特定文件类型载入相关缩进文件
filetype indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 状态（命令）栏
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 命令行显示输入命令（默认就有）
set showcmd
" 命令行显示vim当前模式（默认就有）
set showmode
" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2
" 显示状态行（0:不显示 1:窗口多余一个时显示 2:总是显示）
set laststatus=2
"状态行显示的内容
set statusline=%t%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%y/%m/%d\ -\ %H:%M\")}
" 多窗口下在被分割的窗口（状态栏）用字符显示空白
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 选择模式
set selectmode=mouse,key
" 选择文本时保留光标所在位置
set selection=inclusive
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 其他设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 代码补全 
set completeopt=preview,menu 
" 共享剪贴板  
set clipboard+=unnamed 
" 自动保存
set autowrite
" 设置魔术字符查找（与特殊字符有关）
set magic

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.cpp,.h,.sh 文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func! SetTitle() 
	"如果文件类型为.sh文件 
	if &filetype == 'sh' 
		call setline(1,"\#########################################################################") 
		call append(line("."), "\# File Name: ".expand("%")) 
		call append(line(".")+1, "\# Author: kyrieluo") 
		call append(line(".")+2, "\#########################################################################") 
		call append(line(".")+3, "\#!/bin/bash") 
		call append(line(".")+4, "") 
	else 
		call setline(1, "\/*************************************************************************") 
		call append(line("."), "	> File Name: ".expand("%")) 
		call append(line(".")+1, "	> Author: kyrieluo") 
		call append(line(".")+2, " ************************************************************************\/") 
		call append(line(".")+3, "")
	endif

	if &filetype == 'cpp'
		call append(line(".")+4, "#include<iostream>")
		call append(line(".")+5, "using namespace std;")
		call append(line(".")+6, "")
	endif
	if &filetype == 'c'
		call append(line(".")+4, "#include<stdio.h>")
		call append(line(".")+5, "")
	endif
	"新建文件后，自动定位到文件末尾
	autocmd BufNewFile * normal G
endfunc 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 快捷键命令
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 目录结构显示隐藏文件[夹]
"let NERDTreeShowHidden=1

" 去空行  
"nnoremap <F2> :g/^\s*$/d<CR> 
" 去掉windows格式导致的
"map <F3> :%s///g<CR> 

" 显示NerdTree
nmap <F2> :NERDTreeToggle<CR>

" 显示空白字符
nmap <F3> :set invlist<CR>

" 窗口上下左右缩进
nmap <C-H> :vertical resize +2 <cr>
nmap <C-L> :vertical resize -2 <cr>
nmap <C-J> :resize +2 <cr>
nmap <C-K> :resize -2 <cr>

autocmd! BufWritePost ~/.vimrc	source ~/.vimrc
