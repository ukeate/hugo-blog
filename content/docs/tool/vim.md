---
Categories: ["运维"]
title: "VIM"
date: 2018-10-11T18:31:16+08:00
---

# 编译
    --with-features=tiny                # 只包含最基本功能。small, normal, big, huge, :h feature-list查看
# 命令
    vim -u NONE -N                      # -u NONE 不加载配置文件和插件，并进入vi兼容模式
        -u code/essential.vim           # 加载指定配置文件
        -N set nocompatible             # 不进入vi兼容模式
        --version                       # 可查看特性
# mode
    普通模式
    插入模式
    可视模式
        v/V                             # 面向字/面向行 可视模式
        <C - v>                         # 面向块 可视模式
        gv                              # 重选上次选区
        o                               # 切换到选区的开头, 再按切换回尾端　
    替换模式
        R
    命令行模式(Ex命令)
        :                               # 可视模式中选定范围，切换到命令行时，自动输入range'<,'>代表选中区
    操作符待决模式                         # operator 与 motion之间的空闲时期
                                        # 两个字符的operator, 字符间的空闲时期不是该模式，是命名空间，是普通模式的扩充
                                        # 有了这个模式，能创建自定义映射项来激活或终结操作符待决模式，就可以自定义operator和motion
    选择模式                              # 类似windows中选中
        <C - g>在可视和选择模式切换
    历史
        q:                              # 命令历史
        q/                              # 搜索历史
# operate
    思想
        {operator}{motion}
        {operator}{text-objects}
    shortcut key
        ctrl + c                        # 同Esc
    motions
        .                               # 重复前一次修改, 目标做到一键移动，一键执行。修改是指: 一个normal模式下的按键, 插入内容, <ESC>; 或一组normal模式下按键
        K                               # 当前单词的:h 手册
        ga                              # 当前字符的unicode码
    Ex command                          # 可视模式下选中行, : 时前面有'<,'> 表示对选中的行执行操作
        :h e 或 :help e                 # 查看e的帮助
            vimtutor 查看教程
            operator 查看operator
            map-operator 查看自定义operator
            omap-info 查看自定义motion
            digraphs-default
            digraphs
            digraphs-table 查看二合字符表
            ex-cmd-index 查看所有Ex命令
            vi-differences vim 相对vi的特性
        :version                        # 查看版本和支持的功能
        :! command                      # 执行某shell命令(CR返回)
            !! 执行前一个命令
            r!command 执行结果插入当前位置
            w!command 当前文件作为输入执行
        :cd directory                   # 修改工作目录
        :sh                             # 跳到shell, 再执行exit返回
        :map bbc ia                     # 定义命令序列ia的别名为bbc
        :pwd                            # 显示当前目录
        :normal A;                      # 执行普通模式命令A;, 添加分号到行尾
        系统命令
            :grep t * # 在当前所有文件中匹配t, 自动加-n参数(显示行号)
            :ls
# locate oper
    motion
        ^/$/0/<home>/g_/h/l/j/k/w/W/e/E/b/B/ge/gE/gg/G/[[/]]/(/)/{/}/nH/M/nL/点鼠标
            # 移动motion
            ge同b, 停在单词尾部
            <home>同0, 到行开始, ^则到本行第一个字符
            gg同[[，G同]]，10G跳到第10行
            fx 移动到下一个x, F反向查找, tx 移动到x的前一个字符

            nG 跳到第n行
        f/F/t/T                         # 行搜索motion         重复查找(以相反方向重复搜索)
        ;                               # 重复移动上次f/F/t/T的字符
        ,                               # 撤销上次f/F/t/T移动
        *                               # 查找当前词
        nzz/nz-                         # 跳到指定行, 显示在屏幕中间/底部
            zz 当前屏幕到中间
        可视模式
            $                           # 块可视模式中，表示所有行尾
            i/a                         # 块可视模式中有不同含义
    operator
        3G                              # 跳到第3行
        /text　　                        # 查找text，按n健查找下一个，按N健查找前一个。
        ?text　　                        # 查找text，反向查找，按n健查找下一个，按N健查找前一个。
        *或#                            # # *相当于/，#相当于?
            g* 搜索子串
            gd  同* 但跳到第一个匹配序列
        %                               # 搜索对应括号

        o-> marks
        ``                              # 跳回
            `" 最后编辑的位置
            `[ 最后修改的开始位置
            `] 最后修改的结束位置
            '. `. 跳到上次编辑位置
        ''                              # 跳回到第一个非空白字符
        marks                           # 显示系统全部书签
        ma                              # mark当前光标位置为a，小写字母不同文件标记不同行, 大写字母全局标记，但webstorm中ideaVim不行
        `a                              # 跳到a的位置
    Ex command
        :10                             # 跳到第10行, 同10G, 0位于第一行上方
        :jumps                          # 输出能跳往的位置列表，可跳转多个文件
        :$                              # 文件结尾
        :.                              # 当前位置
        :%                              # 文件中的所有行
        :'<                             # 选中区开始
        :'>                             # 选中区结尾
        :'m                             # 位置标记为m的行
        :/<html>/,/<\html>/             # 模式匹配范围
        : 1+1, 5-1                      # 开始向下偏移一行，结尾向上偏移一行
        :vim[grep] abc test             # 在test文件中grep匹配abc
    shortcut key
        <c - e>/y                       # 向下/上滚动一行
        <c - d>/u                       # 向下/上滚动半屏
        <c - f>/b                       # 向下/上滚动一屏
        <c - i>/o                       # 到下个/上个跳动过的位置
# edit oper
    shortcut key
        <C - r>                         # 撤销的撤销
        <C - a>/x                       # 数字增加/减少1, 对0开关数字进行八进制操作, 0x进行十进制操作。可以设置nrformats改变
        插入模式/命令模式
            <C - h>                     # 删除前一个字符
            <C - w>                     # 命令模式可用，删除前一个单词
            <C - u>                     # 命令模式可用，删至行首
            <C - [>                     # 返回普通模式
            <C - o>                     # 到插入-普通模式
            <C - v>                     # 命令模式可用，插入编码对应的字符
                065                     # 两位的编码
                u00bf                   # 超过3位的unicode码
                非数字                   # 直接插入, 如expandtab开启后插入tab
            <C - k>{char1}{char2}       # 命令模式可用，插入以二合字母表示的字符
                12
                <<
                ?I
            <C - r>{register}           # 命令模式可用，插入寄存器内容
        补全
            <C - n>/p                   # 自动补全下/上

            <C - x> 接着按如下
                <C - L>                 # 整行补全
                <C - N>                 # 根据当前文件里关键字补全
                <C - K>                 # 根据字典补全
                <C - T>                 # 根据同义词字典补全
                <C - I>                 # 根据头文件内关键字补全
                <C - ]>                 # 根据标签补全
                <C - F>                 # 补全文件名
                <C - D>                 # 补全宏定义
                <C - V>                 # 补全vim命令
                <C - U>                 # 用户自定义补全方式
                <C - S>                 # 拼写建议
    operator                            # num + operator 来多次操作, 合并命令如A(同$a), 是为了普通模式下一个按键进行插入，这样能够在.命令中重复
        @:                              # 重复Ex命令
        &                               # 重复substitute命令
        x/X                             # 删除当前字符/删除前一个字符， x等于dl，X 等于dh
        u/U                             # 撤销(Undo)/撤销对整行的操作
        r/R                             # 替换一个字符/持续替换字符，tab是一个字符
            gR                          # 一个tab由tabstop个字符才能替换
            gr
        y/yy/Y                          # yank 复制/复制一行/同yy
            :y
        p/P                             # 粘贴/前面粘贴
            :p
        a/A                             # s当前字符后插入
            A同$a, 行尾插入
        o/O                             # 向后插入行
            o同A<CR>
            O同ko, 向前插入行
        s/S                             # 替换当前字符/替换当前行
            s同cl
            S同^C
        i/I                             # 当前字符前插入/行首插入
            I同^i 
        c/cc/C                          # 替换/替换一行/同cc
            :0,10c 与 :c
            C同c$
        d/dd/D                          # 删除/删除一行/删到行尾
            dd 同 :d
            10d表示删除10行
            D同d$
            :0,10d 与 :d
        <</>>
            可视模式下 </>
            命令下 1>>2 表示从1行开始, 作用2行>>, 可以1>>>>2
            1,2> 表示 1到2行>>, 可以1,2>>
            >G 缩进当前到最后一行
        =                               # 自动缩进
            == 自动缩进当前行
        !                               # 用外部命令过滤指定行
            如!j, 自动进入命令模式, 选定了指定行进行!
            !!当前[count]行
        J                               # 与下行合并
        g                               # :[range]global/{pattern}/{command}
            global命令在[range]指定的文本范围内（缺省为整个文件）查找{pattern}，然后对匹配到的行执行命令{command}，如果希望对没匹配上的行执行命令，则使用global!或vglobal命令。
            g/^/m 0 倒序文件行
        g_                              # 到本行最后一个不是blank字符的位置
        gd                              # 智能跳到当前变量定义的位置
        gu/gU                           # 转换到小写/大写, 如gUw
            gugu / guu / gUgU / gUU
        g~                              # 大写转小写，小写转大写
            g~g~ / g~~ 转换一行
        可视模式下
                U/u                     # 大写/小写
    ex command
        :1,10 co 20                     # 将1-10行插入到第20行之后。
            :1,$ co $ 复制整个文件添加到尾部
        :1, 10 m 20                     # 第1-10行移动到第20行之后
        :ab attr attribute              # 缩写, 输入模式中输入attr,再输入非字母字符(空格, 点等)，自动补全
            ab查看所有缩写
            una/unab attr 取消缩写　
        :!                              # 执行外部命令
        :[range]copy{address} /:t /:co  # 复制range到address后, :t 2 表示复制当前行到第2行后
        :[range]move{address}           # 移动
        :[range]join                    # 连接
        :[range]delete[x]               # 删除指定范围内的行到寄存器中
        :[range]yank[x]                 # 复制
        :[line]put[x]                   # 指定行后粘贴寄存器中内容
        :[range]normal{commands}        # 指定范围执行命令
        :[range]print / p               # 在vim下方回显指定行的内容
    text-object
        i"
            " 表示 光标所在""的内容
            '
            `
            ) 表示 ()的内容
            ( 同上
            ]
            [
            >
            <
            }
            {
            B 表示 {}的内容
            t 表示 tag之间的内容，如<h2>aaaa</h2>
            w 表示 光标所在word
            s 表示 光标所在句子
            p 表示 段落
        a"                              # 包括外围，命令同i
        视图模式下
            vit                         # 在可视模式下选中标签内容，如<a>xxx</a>的xxx
## patterns oper
    operator
        &                               # 重复:s上次执行的命令, 不包含g
            g& 全局重复:s上次的命令
        n/N                             # 查找下一个/上一个
    Ex command
        :[range]substitude/{pattern}/{string}/[flags]
            :s 用new替换old，替换当前行的第一个匹配
            前面是正则, 用()分组，后面用\1引用分组
            :s/old/new/g 作用到整行
            :%s/old/new/ 作用到每行第一个
            :10,20 s/^/    /g 作用到10到20行的每一个
            :%s/old/new/g 作用到全文
            :s/old/new/gc 每次修改前询问

        :[range]global/{pattern}/[cmd]
            :g 查找text的行执行命令,如:g/text/s/old/new/g
            v/text/command 查找到行不执行命令,其它行执行
        :&                              # 同operator中&
# registers oper
    register                            # 寄存器
        :reg                            # 查看所有寄存器 或 :reg 1 查看寄存器1的内容
        "0p                             # "0<operator> 粘贴寄存器0的内容
            "0y 复制到寄存器0
        :pu 0                           # 同上
            :pu! 0 同 "0P
        :y a                            # 复制当前行到"a寄存器
            :5,10y m 复制5到10行到"m寄存器
        分类
            ""                          # unamed 缓存最后一次操作内容
            "0                          # numbered 范围0 - 9 。"0缓存最近一次复制的内容
                "1到"9缓存最近9次删除的内容, "9向后则丢弃
                第2次删除时，缓存1转存到缓存2, 新的删除内容存到缓存1
            "-                          # small delete 缓存行内删除内容
            "a                          # named 范围a - z 与 A - Z
            ":                          # read-only
                如 ": 最近命令 ". 最近插入文本 "% 当前文件名 "# 当前交替文件名
            "=                          # expression 用于执行表达式命令，只读
            "*                          # selection and drop
                如 "* "+ "~ 存取GUI选择文本，可用于与外部交互，要求系统剪切板(clipboard)可用
            "_                          # black hole 表示不缓存，干净删除
            "/                          # last search pattern 缓存最近的搜索模式
    shortcut key
        <C - r>0                        # 插入寄存器缓冲区内容, 原理是vim插入模式模拟打入
                <C - p>0                # 保持格式不变
        <C - r>=6 * 35<CR>              # 计算结果
    宏
        qa ... q                        # 录制宏a，存到寄存器中，可以用"ap粘贴出来
        @a                              # 运行宏a
        let @a = ""                     # 用let @a 在.vimrc设置文件中设置宏a
        内置宏
            :                           # 上次的Ex命令
# file oper
    shell
        $ vim file1 file2..
        $ vimtutor                      # vim的教程

    operator
        o-> 折叠
        zf                              # 创建折叠
            zf% 创建括号折叠
            zf56G 创建从当前行起到56行代码的折叠
        zo/zO                           # 展开当前/递归展开当前(folding open, z这个字母看上去比较像折叠的纸)
        zc/zC                           # 再折叠/递归再折叠(folding close)
        [z                              # 到折叠的开始处
        z]                              # 到折叠的结束处
        zk                              # 向上移动到前一个折叠的结束处
        zd/zD                           # 删除当前光标下的折叠/嵌套删除折叠

        o-> 文件对比
        vim -d file1 file2
        diffsplit file2
        diffthis
        diffupdate
        [c                              # 跳到前一个不同点
        ]c                              # 跳到后一个不同点
        dp                              # 合并增加另一个 （diff put）
        do                              # 合并增加当前 （diff get）
    Ex command
        :help                           # 显示帮助, 同F1
            帮助文件中位于||之间的内容是超链接，可以用Ctrl+]进入链接，Ctrl+o（Ctrl + t）返回
            :help tutor 显示vimtutor的教程
            :help xx 显示某个帮助, 如help CTRL-[
            :help 'number' 显示vim选项的帮助
            :help <Esc> 显示特殊键的帮助
            :help -t 显示vim启动参数的帮助
            :help i_<Esc> 插入模式下Esc的帮助，某个模式下的帮助用 模式_主题的模式
        :r/nr filename                  # 插入一个文件的内容/插入到第n行
        :f                              # 显示当前文件状态
        :.=                             # 打印当前行号
            := 打印总行号
        :open file                      # 新窗口打开文件
        :saveas filename                # 另存为并切换到文件
        :tabnew                         # 新建标签页
        :split file/:new                # 屏幕分割
        :vsplit 纵向打开窗口
        :q                              # q! 强制退出
        :w/:write                       # :w filename 写入新文件
        :x                              # 有改动时保存并退出, 无改动只退出
        ZZ
        :e/:edit                        # 重新打开文件, e! 放弃所有修改重新打开文件
            e filename 当前窗口打开另一个文件
        :bn/:bp                         # 切换上个/下个文件
        :saveas <path/to/file>          # 另存为到 <path/to/file>
        :!command                       # 执行shell命令，如 :!ls
            :!perl -c script.pl 检查perl脚本语法，可以不用退出vim，非常方便。
            :!perl script.pl 执行perl脚本，可以不用退出vim，非常方便。
        :suspend                        # 挂起vim，回到shell，命令fg返回vim。
        :buffers/:ls                    # 缓冲区列表
        :bprev                          # 上一缓冲区
        :bnext                          # 下一缓冲区

        o-> 多视窗
        :vert                           # 横向打开
        :vsplit                         # 横向打开
        :split
        :prev                           # 上一个文件
        :next                           # 下一个文件
        :close                          # 最后一个窗口不能使用此命令，可以防止意外退出vim。
        :only                           # 关闭所有窗口，只保留当前窗口

        o-> 标签窗口                      # 启动 Vim 时用 "vim -p filename ..."
        :tabe[dit]                      # 打开文件到标签
        :tabnew                         #  在当前标签页之后打开带空窗口的新标签页。
        :tabc[lose][!]{count}           #  关闭当前标签页。 {}表示关闭第count个标签
        :tabo[nly][!]                   # 关闭所有其它的标签页。
        :tabn[ext] {count}              # 切换到后面的标签页
        :tabp[revious] {count}          # 切换到前面的标签页
        :tabr[ewind]                    # 回卷跳转
        :tabfir[st]                     #  转到第一个标签页。
        :tabl[ast]                      # 转到最后一个标签页。
        :tabm[ove] [N]                  # 重排标签页
            把当前标签页移到第 N 个标签页之后。用 0 使当前标签页成为首个标
            签页。如果没有 N，当前标签页成为最后一个。
        :tabs                           # 列出标签页和它们包含的窗口信息。
            当前窗口显示 ">"。
            修改过的缓冲区显示 "+"。
        :tabd[o] {cmd}                  # 对每个标签页执行 {cmd}

    shortcut keys
            ctrl - z                    # 同 :suspend
            ctrl + g                    # 同 :f

            o-> 多视窗
            ctrl + w + hljk
            ctrl + w + w                # 跳到下一个
            ctrl + w + p                # 跳到前一个
# settings
    设置文件
        /etc/vimrc
        ~/.vimrc                        # vim的配置文件, 优先于.exrc
        ~/.exrc                         # vi的配置文件
    命令
        :set
            all                         # 打印所有set选项
            nocompatible                # 不设置vi兼容
            ruler? 　　                  # 查看是否设置了ruler，在.vimrc中，使用set命令设制的选项都可以通过这个命令查看
            shell    :/usr/bin/sh       # 使用SystemⅤ中的shell来执行vi中以！或  :!开头的shell命令
            nrformts                    # 设置进制, <c - a> <c - x>时对八进制有用，如07

            encoding=utf-8              # 程序显示编码
            enc                         # 同上
            fileencodings=ucs-bom,utf-8,cp936                       # 设置读取文件支持的编码
            fencs                       # 同上
            fileencoding=utf-8          # 当前文件编码
            fenc                        # 同上
            termencoding=utf-8          # 设置终端编码
            tenc                        # 同上

            list                        # 显示非打印字符，如tab，空格，行尾等。
            nolist                      # 取消显示非打印字符, 如果tab无法显示，请确定用 set lcs=tab:>- 命令设置了.vimrc文件
            number                      # 显示行号
            nu                          # 同上
            nonumber                    # 不显示行号
            nonu                        # 同上
            reprot=2                    # 用户做2行以上修改时显示统计信息
            hlsearch                    # 设置查找高亮
            hls                         # 同上
            incsearch                   # 查找高亮所有(增量高亮)

            smartindent                 # 括号补全
            sm                          # 同上
            ignorecase                  # 查找时忽略大小写
            ic                          # 同上
            noignorecase                # 查找时不忽略大小写
            noic                        # 同上
            expandtab                   # 存起来的文件, 用space替换tab
            shiftwidth=4                # 换行时缩进长度
            sw                          # 同上
            softtabstop=4               # 插入模式tab长度
            tabstop=4                   # 识别和显示tab时，转换成space的长度

            autoindent                  # 启用自动缩进
            ai                          # 同上
            foldmethod=indent           # 设置折叠
            fdm                         # 同上
                indent 缩进折叠
                syntax 语法高亮折叠
                expr 表达式定义折叠
                diff 对没有更改的文本折叠
                marker 对文中的标志折叠
        :scriptnames                    # 脚本文件位置，如.vimrc文件、语法文件、plugin
        :syntax clear                   # 列出已经定义的语法项
            clear 清除已定义的语法规则
            case match 大小写敏感，int和Int将视为不同的语法元素
            case ignore 大小写无关，int和Int将视为相同的语法元素，并使用同样的配色方案
    配置
        inoremap <C-]> <C-X><C-]>       # 插入模式下映射
        nnoremap                        # 在normal模式下映射
        fileType plugin on              # 激活内置插件, 检测文件类型
        filetype on                     # 同上
# plugins
    netrw
        介绍
            自带插件
        edit ./                         # 查看目录树
        Ex                              # 同上
        Se                              # 下面弹出目录树 好用
        Ve                              # 左面弹出目录树 好用

        <cr>   netrw 进入目录或读入文件 |netrw-cr|
        <del>  netrw 试图删除文件/目录 |netrw-del|
        -    netrw 往上走一层目录 |netrw--|
        a    在以下三种方式间切换: 正常显示，|netrw-a|
            隐藏 (不显示匹配 g:netrw_list_hide 的文件) 和
            显示 (只显示匹配 g:netrw_list_hide 的文件)
        c    使浏览中的目录成为当前目录 |netrw-c|
        d    建立目录 |netrw-d|
        D    netrw 试图删除文件/目录 |netrw-D|
        i    在瘦、长、宽和树形的各种列表方式间切换 |netrw-i|
        <c-l>  netrw 刷新目录列表 |netrw-ctrl-l|
        o    打开新浏览窗口，进入光标所在的目录。使用水平分割。|netrw-o|
        p    预览文件 |netrw-p|
        P    在前次使用的窗口里浏览 |netrw-P|
        r    反转排序顺序 |netrw-r|
        R    给指定的文件/目录换名 |netrw-R|
        s    选择排序方式: 按名字、时间或文件大小排序 |netrw-s|
        S    指定按名字排序的后缀优先级 |netrw-S|
        t    在新标签页里打开光标所在的文件/目录 |netrw-t|
        v    打开新浏览窗口，进入光标所在的目录。使用垂直分割。|netrw-v|
    ctags
        将ec57w32.zip解压，在解压后文件夹中找到ctags.exe，将其复制到C:\ProgramFiles\Vim\vim72下，并编辑_vimrc文件，添加以下内容：
        set tags=tags;
        set autochdir
        打开cmd命令行，切换到你要查看的源代码的根目录处，运行
        ctags -R
        将会在此目录处生成一个tags文件。
        用gvim打开一个代码文件，将光标放到某一函数名上，如下图的UpdateViewByPosNo()，按下"ctrl+]"，光标会自动跳转到定义处。按下"ctrl+T"会跳回到原来的位置。
        变量、结构体、宏等等，都可以这样做。
        当你的源文件有更新时，只能重新运行ctags -R命令，来更新tags文件。

        taglist
            将taglist_45.zip解压，解压后包含一个doc文件夹和一个plugin文件夹，将其中内容分别复制到C:\Program Files\Vim\vim72下的doc及plugin中。
            在_vimrc文件中加入以下内容：
            let Tlist_Show_One_File=1
            let Tlist_Exit_OnlyWindow=1
            用gvim打开代码文件（已生成过tags文件），:Tlist，TagList窗口即出现在左侧。

    visual-star
    Qargs
    nerdTreeToggle
        介绍
            目录显示插件
# 方案
    加分号
        jA;
        j.
    批量执行
        选中多行, :normal .
    批量前缀
        选中多行, I
    括起文字
        ci"        # 替换内容""
        ca"        # 替换所有
        di"        # 删除内容
        cit        # 替换标签
    执行python
        选中代码, :!python
    缩进全文
        gg=G
    替换到"
        cf"
    esc
        <C-[>
    目录窗口
        :Sex


    console输出乱码
        language messages utf-8
        set termencoding=utf-8
    设置文件编码
        set encoding=utf-8
        set fileencodings=utf-8,chinese,latin-1