# phone
    本质
        移动
    app
        tudo, v2rayNG
        夸克, 百度地图, 支付宝
        网易云音乐
# ipad
    本质
        接现实
            纸：多量，大面积
            pad: 结构化，易重构
    标志app
        notability, marginNote3, procreator
# mac
    本质
        非编程
    快捷键
        divvy：control + command + v
        alfred：option + 空格
    标志app
        OmniPlan, outlook 
        DEVONagent, DEVONthink, marginNote3, xmind
# pc
    本质
        编程
## 命令
    dmesg
    journalctl

    快捷键
        ctrl alt f1/f2/...
## WM
    全
        console
        chromium
        nautilus
    常切回默认
        左1, 中2, 右1
    左                              # 资料、工具
        1: vscode、blog、wiki
        2: 扩展ide
        3: dia
        4: work display
        5: virtual box
        6: postman

        9: chrome、console
    中                              # 编程
        1: goland
        2: intellij idea
        3: webstorm

        9: chrome、console
    右                              # 辅助
        1: console
        2: remote console
        3: 扩展ide
        5: blueberry
        6: synergy

        9: chrome、console
## 端口
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
## 配置
### 系统
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
### vim
    set encoding=utf-8
    set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
    set termencoding=utf-8

    set hlsearch
    set incsearch
    set ignorecase

    set expandtab
    set shiftwidth=4
    set softtabstop=4
    set tabstop=4
    set autoindent
    set smartindent

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
            awful.key({ modkey,           }, "q", function () awful.spawn("xscreensaver-command --lock") end,
                {description = "lock screen", group = "launcher"}),

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
### docker
    /etc/docker/daemon.json
        {
          "registry-mirrors": ["https://nmp74w3y.mirror.aliyuncs.com", "https://3laho3y3.mirror.aliyuncs.com", "http://hub-mirror.c.163.com", "https://registry.docker-cn.com", "http://f1361db2.m.daocloud.io", "https://mirror.ccs.tencentyun.com"]
        }
    /etc/systemd/system/docker.service.d/http-proxy.conf            # 没有时创建
        Environment="HTTP_PROXY=http://127.0.0.1:8123"
            "HTTPS_PROXY=http://127.0.0.1:8123"
            "NO_PROXY=192.168.1.1,localhost"
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
### tmux




