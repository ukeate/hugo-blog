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
## WM
### 桌面
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
### 快捷键
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
    # 同步备份
    .config/onedrive/sync_list
        # 这里包含了多个连接
        bak/pc/etc/

        bak/pc/home/outrun/scripts/app/
        bak/pc/home/outrun/scripts/bulk/
        bak/pc/home/outrun/scripts/login/
        bak/pc/home/outrun/scripts/work/bootstrap

        bak/pc/home/outrun/.config/awesome/
        bak/pc/home/outrun/.openvpn/
        bak/pc/home/outrun/.ssh/

        bak/pc/home/outrun/.config/VirtualBox/VirtualBox.xml
        bak/pc/home/outrun/.config/Code/User/settings.json
        bak/pc/home/outrun/.m2/settings.xml
        bak/pc/home/outrun/.bashrc
        bak/pc/home/outrun/.bash_profile
        bak/pc/home/outrun/.gitconfig
        bak/pc/home/outrun/.vimrc
        bak/pc/home/outrun/.xinitrc
        bak/pc/home/outrun/.tmux.conf
    .config/onedrive/config
        sync_dir = "~/OneDrive"
        skip_file = ""

    # 其它备份
    ~/scripts/config
    ~/scripts/work
    /opt/
        env
        svc

    # logs
    ~/logs
    ~/VBoxSVC.log
    ~/.config/VirtualBox/selectorwindow.log



