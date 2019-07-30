---
title: 寄存器
title: "Register"
type: docs
---

# 连接
<a href="http://localhost:1315/docs/infomation/" target="_blank">信息</a>
<a href="https://shimo.im/" target="_blank">石墨</a>
<a href="https://processon.com/" target="_blank">processon</a>
<a href="https://www.vtrhome.net/" target="_blank">vpntech</a>


# go
    go test -bench=.  --cpuprofile=cpu.prof --memprofile=mem.prof -config ../conf/config_lc.toml -test.run TestCreateType
    go tool pprof service.test cpu.prof
    go-torch -b cpu.prof
    go test -cover -args -config config.toml -test.run "TestCreate"

# linux
    dmesg
    journalctl

    快捷键
        ctrl alt f1/f2/...

# 系统配置
    bin
        # 系统需要
        yaourt
        network-manager
        awesome
        i3-wm
        ibus
        wireless-tools
        pkgfile
        os-prober
        ntfs-3g
        pepper-flash
        tree
        unzip
        alsamixer
        arandr
        xscreensaver

        virtualbox
        firefox
        chromium
        thunderbird
        tmux
        vim

        # 运维需要
        openssh
        git
        expect
        wget
        sysdig
        sysstat     # sar, sadf, mpstat, iostat, pidstat

        # 程序需要
        g++
        python
        lua
        ruby
        cmake
        protobuf
        openjdk8
        docker
            mysql
            nginx
            nginx-php
            nsq
            redis
            zipkin
    opt
        # ide
        webstorm
        datagrip
        eclipse-inst
        eclipse-birt
        eclipse-jee-neon
        goland
        intellij idea
        phpstorm
        pycharm
        vscode
        sublime
        mps
        android studio

        # 图形工具
        wireshark
        filezilla
        postman
        robomongo
        emacs
        neoclipse

        # 数据库
        elasticsearch
        elasticsearch-head
        elasticsearch-analysis-hanlp
        elasticsearch-ik
        elasticsearch-pinyin
        redis
        mongodb
        mariadb
        neo4j
        pgsql

        # 工具
        go
        maven
        tomcat
        flame-graph
        jdk1.8
        node
        protoc
    diy
        blog
    文件
        ~/code
        ~/scripts/work
        ~/scripts/app
        ~/scripts/config
        ~/scripts/login
        ~/.xinitrc
        ~/.bashrc
        ~/.gitconfig
        ~/.openvpn
        ~/.ssh
        ~/.tmux.conf
        ~/.config/awesome
        ~/.config/VirtualBox/VirtualBox.xml
        /opt/env
        /opt/svc
        /etc/resolv.conf
        /data/var/mysql
        /db/mongo
        /srv/ftp
        /srv/http

        # log
        ~/VBoxSVC.log
        ~/VirtualBox VMs/machinename/Logs
        ~/.config/VirtualBox/selectorwindow.log
# vim
    命令
        vim
            --version   # 查看插件
    可视模式
        o   # 切换头尾
        gv  # 重选上次
        <C - v> 
        U/u # 转换大写/小写
    替换模式
        R
    思想
        {operator}{motion}
        {operator}{text-objects}
    operator
        ;
        ,
        3G
        */#
        %   # 括号
        ``  # 跳回
        ''  # 跳回非空白
        :marks
        ma/`a   # 标记跳转
        &   # 重复substitute
        cc/C    # 替换一行
        J   # 删除向下的空行 
        g~  # 转换大小写
            # g~~ 转换一行
    motion
        ^/$/0/<home>/g_/h/l/j/k/w/W/e/E/b/B/ge/gE/gg/G/[[/]]/(/)/{/}/nH/M/nL/点鼠标
        f/F/t/T
        .
        K   # man查询
        ga  # unicode码
        nzz/nz-
    q:  # 命令历史
    命令模式
        :3   # 跳转
        :'<,'>   # 选中内容
        :/<html>/,/<\html>/  # 模式匹配范围
        :h e    # e的帮助
        :%s///g  # substitute
        :! command     # 执行shell命令
                      # !! 执行前一命令
                      # r!command 结果插入当前
            # sh 打开sh
            # pwd
            # grep t *  当前文件匹配t
            # ls
        :normal  A;  # 普通模式下执行A,后写入分号
    shortcut key
        <C - d>/u   # 滚半屏
        <C - f>/b   # 滚一屏
        <C - i>/o   # 下个/上个跳动位置
        <C X>   # 当前单词大小写转换
    text-object
        i"  # 中间内容
            # ' ` ( ) [ ] < > { }
            # B 表示{}, t 表示 tag之间内容, w 表示word, s 表示句子, p 表示段落
        a"  # 包括外围
    registers
        :reg    # 查看所有
        :y a    # 复制到a寄存器
        分类
            ""  # 最后一次操作
            "0  # 最近一次复制, 排到9
            "-  # 行内删除
            "a  # a - z, A - Z
            "=  # 只读，用于执行表达式命令
            "*  # clipboard，针对选中部分(selection)
            "+  # clipboard, windows下与*同，linux X11下针对复制或剪切部分(cut buffer)
            "_  # black hole
            "/  # 最近的搜索模式
    宏
        qaq
        @a
    折叠
        # ide支持不好
    对比
        vim -d file1 file2
            [c  # 上一个不同
            ]c  # 下一个不同
            dp  # 合并增加另一个
            do  # 合并增加当前
    文件
        # ide支持不好
        <C - w> hljk
        <C - w> w
        <C - w> s
        <C - w> v

# intellij
    shift shift

# awesome
    快捷键
        独立
            <M - s>             # 帮助
            <M - w>             # 菜单
        client
            <M - 回车>            # 终端
            <M - ctrl - r>       # reload
            <M - c>              # 自定义chromium
            <M - f>              # 全屏
            <M - shift - c>      # 关闭
            <M - 数字>            # 切换到tag
            <M - j> <M - k>      # 本tag切换client
            <M - 空格>            # 变布局
    ~/.xinitrc
        exec /usr/bin/awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
    ~/.config/awesome/rc.lua
        # 默认在/etc/xdg/awesome/rc.lua

        -- Table of layouts to cover with awful.layout.inc, order matters.
        awful.layout.layouts = {
            -- awful.layout.suit.floating,
            awful.layout.suit.max,
            -- awful.layout.suit.max.fullscreen,
            awful.layout.suit.tile.bottom,
            awful.layout.suit.tile,
            -- awful.layout.suit.tile.left,
            -- awful.layout.suit.tile.top,
            -- awful.layout.suit.fair,
            -- awful.layout.suit.fair.horizontal,
            awful.layout.suit.magnifier,
            awful.layout.suit.corner.nw,
            -- awful.layout.suit.corner.ne,
            -- awful.layout.suit.corner.sw,
            -- awful.layout.suit.corner.se,
            awful.layout.suit.spiral,
            -- awful.layout.suit.spiral.dwindle,
        }
        -- }}}

        
        -- {{{ Menu
        mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
            { "chromium", "chromium" },
            { "open terminal", terminal }
          }
        })


        -- {{{ Key bindings
        -- Standard program
            awful.key({ modkey,           }, "c", function () awful.spawn("chromium") end,
                {description = "open a chromium", group = "launcher"}),


        -- {{{ Rules
        -- Floating clients.
        {
        rule = { class = "VirtualBox"},
        properties = { screen = "DP2-1", tag = "1"}
        },

        {
        rule = { class = "MyBase"},
        properties = { screen = "DP2-1", tag = "2"}
        },


        {
        rule = { class = "jetbrains-goland"},
        properties = { screen = "HDMI1", tag = "1"}
        },

        {
        rule = { class = "Code"},
        properties = { screen = "HDMI1", tag = "2"}
        },

        {
        rule = { class = "jetbrains-webstorm"},
        properties = { screen = "HDMI1", tag = "3"}
        },


        -- {{{ diy auto run
        awful.util.spawn_with_shell("~/.config/awesome/autorun.sh")
        -- }}}

    ~/.config/awesome/autorun.sh
        #!/usr/bin/env bash

        # nothing to use
        function run {
            if ! pgrep $1 ; then
                $@&
            fi
        }

        if xrandr | grep -q 'eDP1 connected' ; then
            run xrandr --output VIRTUAL1 --off --output eDP1 --mode 1920x1080 --pos 0x720 --rotate normal --output DP1 --off --output DP2-1 --mode 2560x1080 --pos 3360x720 --rotate normal --output DP2-2 --off --output DP2-3 --off --output HDMI2 --off --output HDMI1 --primary --mode 2560x1440 --pos 1920x0 --rotate left --output DP2 --off
        fi

        run ibus-daemon --xim
        run nm-applet

# tmux

