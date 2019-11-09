---
title: 寄存器
title: "Register"
type: docs
---

# 快速访问
信息:
<a href="http://localhost:1315/docs/infomation/" target="_blank">信息</a>
<a href="https://www.vtrhome.net/" target="_blank">vpntech</a>
<br/>
同步盘:
<a href="https://onedrive.live.com/?id=root&cid=FFED8E49854C02E8" target="_blank">OneDrive</a>
<a href="https://www.icloud.com/" target="_blank">iCloud</a>
<br/>
同步信息:
<a href="https://www.onenote.com/notebooks?auth=1&nf=1&fromAR=1" target="_blank">OneNote</a>
<a href="https://trello.com/b/bWRQmKff/%E8%BF%9B%E5%BA%A6" target="_blank">Trello</a>
<a href="https://shimo.im/" target="_blank">石墨</a>
<br/>
资讯1级:
<a href="http://yinwang.org" target="_blank">YinWang</a>
<a href="https://www.weibo.com/u/6347862377?is_hot=1#_loginLayer_1570797857600" target="_blank">YinWang微博</a>
<a href="https://www.zhihu.com/people/tao-wen-54/pins" target="_blank">TaoWen</a>
<br/>
资讯2级
<a href="https://www.infoq.cn/" target="_blank">infoQ</a>
<a href="https://www.v2ex.com/" target="_blank">V2EX</a>
<a href="https://juejin.im/" target="_blank">掘金</a>
<br/>
资讯3级
<a href="http://www.oreilly.com.cn" target="_blank">O' Reilly</a>
<a href="https://www.thoughtworks.com/cn/radar" target="_blank">技术雷达</a>
<a href="http://insights.thoughtworkers.org/tech-radar/" target="_blank">技术雷达(分类)</a>
<br/>
工具:
<a href="https://www.atlassian.com/" target="_blank">Atlassian</a>
<a href="https://www.jetbrains.com" target="_blank">JetBrains</a>

## 数据流向
    输入
        搜索
            pages, DEVONagent, 知网
        发散
            百度指数
            DEVONSphere
        资讯                   
            博客
            知乎
        资料
            慕课, 网易公开课, 微信/qq                
            坚果云, 百度网盘, oneDrive
        会议
            notability[iCloud]
        GTD
            trello
            drafts[drafts]
        动画
            录屏
                quickTime
    转换
        分类            # 学术 阅读 实践
            DEVONthink
        格式
            wps(word,ppt -> pdf)     
            pdfElement(pdf -> word,ppt) 
        视频
    输出
        字
            缩进
                workflowy[workflowy], 幕布[幕布]
        图
            表
                excel
            脑图
                marginNote[iCloud]
                liquidText[iCloud]
                xmind[oneDrive]
                mindNode, ithought
                scapple
            结构图
                visio, ppt, 
        库
            oneNote[oneDrive]
            blog[github]
            goodnotes
# phone
    本质
        移动
## 功能
    v2rayNG
    备忘录
    夸克
    百度地图
    支付宝
## 计划
    tudo
    日历
    时钟
## 其它
    知乎
    网易云音乐
    荔枝
# ipad
    本质
        接现实
    边界                            # 非边界内不要
        办公
        个人学习
    对比纸
        纸：多量，大面积
        pad: 结构化，深入
    操作
        下边向上(短)：桌面
        下边向上(停): dock
            dock拖app: 小窗、分屏
                小窗向边(短): 隐藏
                小窗向边(停): 分屏
                小窗向上：分离
        下角向内(短): 切app
        下角向内(停): app表
        右上角向下: 控制中心
        左上角向下：通知
        桌面向下: 搜索
        3指左右: app内切换
        4指左右：切app
        4指向内(短): 桌面
        4指向内(停): app表 

        home一下：桌面
        home两下：app表
## 功能
    系统
        讯飞输入法
        kitsunebi
        快捷指令
    现实
        测距仪
    文档
        wps
        documents
    计算
        calculator
        geogebra
    资源图片
        unsplash
## 任务
    trello
## 文件
    icloud                      # 应用数据
    oneDrive                    # oneNote
    百度云                      # 资料
## 结构化
    xmind
    marginNote3
    liquidText
    石墨
## 笔记
    oneNote
# mac
    本质
        资料
    操作
        四指
            向内：启动台
            向外：桌面
        三指
            左右：切桌面
            向上：app列表
            向下：expose(单程序多窗口)
        二指
            上下：滚动
            左右：前进后退
            右边：通知中心
            缩放,旋转
            点一下：菜单
            点二下：小缩放
        一指
            点一下：选中
            点二下：打开
            点一段：拖
            点二段：查询
## 办公
    微信
    qq
    office
    旺旺
# pc
    本质
        编程
## 系统
### 命令
    dmesg
    journalctl

    快捷键
        ctrl alt f1/f2/...
### 端口
    8123 polipo
    1080 shadowsocks

    1315 blog

    7000,7001,7199,9042,9160 cassandra
    9092 kafka
    2181 kafka zookeeper
    9020 kafka-manager
    8001 nginx
    3306 mysql
    5432 postgres
    54321 timescaledb
    8002 adminer
    27017 mongo
    8003 mongo-express
    6379 redis
    7474,7687 neo4j
    4369, 5671, 5672, 15671, 15672 rabbitmq
    9411 zipkin
    9200 es
    9100 es-head
    5601 kibana
    10001 haproxy
    5433,8090,8091 confluence

    8004 dokuwiki
    8005 wordpress
    8006 nginx-php-fpm
    9090, 1883, 5683 thingsBoard

    9000 provider
    9001,9002 consumer
    9003,9004 discovery
    9005,9006 consumer-metadb
    9010 monitor
    9011 api-gateway
    9012 config-server
    9013 config-client
    9014 zipkin-server
    9015 admin-server
    9016 auth
    9017 auth-client
### 安装的工具
    bin
        # 系统需要
        synaptics
        yaourt
            wps-office
            ttf-wps-fonts
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
        mplayer

        # 运维需要
        openssh
        git
        expect
        wget
        vsftpd
        sysdig
        sysstat     # sar, sadf, mpstat, iostat, pidstat
        shadowsocks
        polipo
        ansible

        # 程序需要
        g++
        python2.7
            python3.5
        php
            php-cgi
            php-fpm
        node
        nvm
            babel-cli
        lua
        ruby
        cmake
        protobuf
        openjdk8
        docker
        docker-compose
            mysql
            redis
            mongodb
            nginx
            zipkin
            nsq
            rabbitmq
            es
            kafka
            cassandra
            neo4j

            dokuwiki
            tiddlywiki
            wordpress
            nginx-php

        # 设计需要
        dia

        # 工作需要
        snapcast
        mosquitto
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
        cassandra

        # 工具
        go
        maven
        tomcat
        flame-graph
        jdk1.8
        jdk12
        protoc
    diy
        blog
### 配置
    ~/
        code
        scripts/
            work
            app
            config
            login
        bak
        .xinitrc
        .bashrc
        .bash_profile
        .gitconfig
        .openvpn
        .ssh
        .tmux.conf
        .config/
            awesome
            VirtualBox/VirtualBox.xml
        .m2/
            settings.xml
        .local/
            share/
                fonts
    /opt/
        env
        svc
    /etc/
        resolv.conf
        vsftpd.conf
        X11/
            xorg.conf.d/
                70-synaptics.conf
    /var/ftp

    # log
    ~/logs
    ~/VBoxSVC.log
    ~/.config/VirtualBox/selectorwindow.log
## 桌面
### 布局
    全
        console
        chromium
        nautilus
    常切回默认
        左1, 中2, 右1
    左
        1: vscode、blog、wiki
        2: 扩展ide
        3: dia
        4: work display
        5: virtual box
        6: postman

        9: chrome、console
    中
        1: goland
        2: intellij idea
        3: webstorm

        9: chrome、console
    右
        1: console
        2: 扩展ide

        9: chrome、console
### awesome
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
### tmux
## 编程
### vim
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

### intellij
    shift shift     # 打开文件
    alt enter       # 补全, 快速修复
### go工具
    go test -bench=.  --cpuprofile=cpu.prof --memprofile=mem.prof -config ../conf/config_lc.toml -test.run TestCreateType
    go tool pprof service.test cpu.prof
    go-torch -b cpu.prof
    go test -cover -args -config config.toml -test.run "TestCreate"
## 工具
###   docker
    /etc/docker/daemon.json
        {
          "registry-mirrors": ["https://nmp74w3y.mirror.aliyuncs.com", "https://3laho3y3.mirror.aliyuncs.com", "http://hub-mirror.c.163.com", "https://registry.docker-cn.com", "http://f1361db2.m.daocloud.io", "https://mirror.ccs.tencentyun.com"]
        }
    /etc/systemd/system/docker.service.d/http-proxy.conf            # 没有时创建
        Environment="HTTP_PROXY=http://127.0.0.1:8123"
            "HTTPS_PROXY=http://127.0.0.1:8123"
            "NO_PROXY=192.168.1.1,localhost"
    sudo systemctl daemon-reload
    sudo systemctl restart docker
### http proxy
    export https_proxy=http://127.0.0.1:8123
    export http_proxy=http://127.0.0.1:8123
### git
    git config --global http.proxy 'http://127.0.0.1:8123'
    git config --global https.proxy 'http://127.0.0.1:8123'
### maven
    ~/.m2/settings.xml
        <proxies>
            <proxy>
              <id>my-proxy</id>
              <active>true</active>
              <protocol>http</protocol>
              <host>localhost</host>
              <port>8123</port>
              <!--
              <username>admin</username>
              <password>admin</password>
              <nonProxyHosts>repository.mycom.com|*.google.com</nonProxyHosts>
              -->
            </proxy>
        </proxies>
### synaptics
    /etc/X11/xorg.conf.d/70-synaptics.conf
        Section "InputClass"
            Identifier "touchpad"
            Driver "synaptics"
            MatchIsTouchpad "on"
                    Option "TapButton1" "1"
                    Option "TapButton2" "3"
                    Option "TapButton3" "2"
                    Option "VertEdgeScroll" "on"
                    Option "VertTwoFingerScroll" "on"
                    Option "HorizEdgeScroll" "on"
                    Option "HorizTwoFingerScroll" "on"
                    Option "CircularScrolling" "on"
                    Option "CircScrollTrigger" "2"
                    Option "EmulateTwoFingerMinZ" "40"
                    Option "EmulateTwoFingerMinW" "8"
                    Option "FingerLow" "30"
                    Option "FingerHigh" "50"
                    Option "MaxTapTime" "125"
                Option "VertScrollDelta" "-50"
                Option "HorizScrollDelta" "-50"
        EndSection