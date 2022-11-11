---
Categories: ["运维"]
title: "LinuxTool"
date: 2018-10-11T18:47:57+08:00
---

# 辅助
## 快捷键
    ctrl alt f1/f2/...      # 终端切换
## 帮助
    man
        -f                  # 简要介绍
        -k                  # 通配搜索
    whatis                  # man -f
    apropos                 # man -k
## 命令行
    clear
    pwd                     # 当前路径
    bash
        -c                  # 执行命令字符串
        set -o              # 设置快捷键模式，默认emacs

        快捷键
            <Tab> bash补全
            <C-c> 中断
            <C-d> eof
            <C-tab> ls
            <C-l> clean
            <C-a> 移到行首
            <C-e> 移到行尾
            <C-u> 删除到行首
            <C-k> 删除到行尾
            <C-p> 上一个命令
            <C-n> 下一个命令
            <C-r> 查看历史      # <C-s> 向前查看历史
            <C-s> 冻结
            <C-q> 解冻
            <C-t> 交换字符
            <C-w> 删word
            <C-z> 暂停到后台
            <C-\> 中断
            <C-/> 撤消
            <C-_> 删除一行
            <M-r> 取消历史变更
        场景
            禁用<C-s><C-q>, 以使<C-s>变为向前查看历史
                stty -ixon -ixoff
                stty STOP ^w            # 把原<C-s>改成<C-w>
    zsh
    fish
    tmux
        session
        window
        pane
        ~/.tmux.conf

        快捷键prefix <C-b>

        系统
            prefix
                ?        # 帮助
                :        # 命令模式
                [        # 复制模式
            tmux
                kill-server
                source a
        session
            prefix
                d        # 脱离
                D        # 选择脱离
                r        # 重绘
                s        # 选择
                ~        # 信息历史

            tmux
                ls
                attach a
                    # 返回session
                    -t name
                rename-session a
                switch -t a
        window
            prefix
                c        # 新建
                &        # 关闭
                ,        # 命名
                .        # 编号
                w        # 选择
                [0-9]        # 切换
                n        # 向后切换
                p        # 向前切换
                l        # 置换
                f        # 所有window查找
        pane
            prefix
                "            # 横分
                %            # 竖分
                x            # 关闭
                !            # 移到新window
                方向          # 切换
                o            # 切换到下一个
                <C-o>        # 向下旋转
                <M-o>        # 向上旋转
                {            # 向前置换
                }            # 向后转换
                <C-方向>      # 调整size
                <M-方向>      # 5倍调整size
                空格          # 切换布局
                <M-[0-5]>    # 选择布局
                q            # 显示编号

        内置命令
            source-file a
    screen
        -ls                 # 查看所有session
        -r                  # 进入id
    echo
    watch -n 1 -d netstat  -ant         # 监视
    forturn                 # 随机名言
    toilet                  # 彩虹字
    cowsay                  # 牛说
    source                  # 当前shell执行
    figlet                  # 大写字
    sl                      # 火车
    cal 9 1752              # 打印日历
    date +%Y/%m/%d/%H:%M
    bc
    maxima                  # 符号计算
    factor                  # 分解质因数
    expect                  # 为运行的脚本预填表单
        o-> 结束
        #!/usr/bin/expect

        spawn ssh outrun@192.168.1.103
        expect "*password"
        send "asdf\n"
        expect eof

        o-> 交互
        #!/usr/bin/expect -f
        spawn sudo /usr/local/mysql/bin/mysqld_safe --user=mysql
        expect "*password:*"
        send -- "asdf"
        send -- "\n"

        interact            # interact留下交互, exit退出

        o-> 后台执行        # 不要expect eof
        if [fork]!=0 exit
        disconnect
    script/scriptreply      # 终端录制
        script -t 2>timing.log -a output.log
        scriptreply timing.log output.log
    jobs                    # 后台作业
    fg                      # 后台作业调度到前台
    bg                      # 继续执行后台作业
    nohup
        nohup *** > /dev/null 2>&1 & 
## 文字处理
    uniq                    # 删除重复列
    cat file1 file2         # 上下拼接
    paste file1 file2       # 左右拼接
        -d '-'              # 加分隔符
    tac                     # 倒转行显示
    wc                      # 统计行, 单词, 字符
    grep
        -v grep         # 过滤掉grep
        常用
            grep -nr --exclude-dir={.git, res, bin} 'a' .
                # 递归查找
    xargs
        -d "\t"         # 定义分隔符
        -t              # -t打印执行的命令
        -L 1            # 1行执行一次
        -n 1            # 一次使用1项
        -I arg1 sh -c 'echo arg1; mkdir arg1'       
            # 执行多命令
        --max-procs 0   # 并行执行，不限数量
        常用
            代码行数
                find -name "*.go" -or -name "*.py" |xargs grep -v "^$" |wc -l
            复制最近修改的文件
                ls -rt | tail -4 | xargs -i cp -r {} ~/sdb/work/ryxWork/架构/
    awk
        awk '{print $1}'
        awk '{cmd="kubectl delete pvc "$1;system(cmd)}'
            # 按行执行命令
    sed
        sed -i '1i\new line'
            # 第一行前插入
        常用
            替换文本
                sed -i "s/a/b/g" `grep -rl "a" ./`
    sort
        -r                  # reverse
        -n                  # 显示行号
    more
    less
    iconv
        -l                  # 列出已知的编码
        -f gbk -t utf-8 -c orig.txt -o tgt.txt      # 转码
    head -2
    tail -2
        -f
    paste file1 file2       # 合并两个文件或两栏内容
        -d '+'              # 分隔符
    nano
    strings                 # 打印可打印字符
    jq . a.json             # 验证json格式
    pv -qL 10               # 文件缓慢显示
    aview                   # 图片文件化
## 媒体处理
    convert                 # 转换图片
        convert a.jpg a.png # 转格式

        -resize 1024x768
            convert -resize a.jpg a1.jpg
        -sample 50%x50%     # 缩略图
        -rotate 270         # 顺时针旋转270度
        -flip               # 左右翻转
        -paint 4            # 旋转角度

        -draw               # 加文字
            convert -fill black -pointsize 60 -font helvetica -draw 'text 10,80 "A" ‘  a.jpg  a1.jpg
                # 用黑色, 60磅, helvetica字体, 在位置10,80 写A
        -raise 5x5          # 右下增加
        +raise 5x5          # 左上增加
        -bordercolor red -border 5x5                # 红色边框
        -mattecolor black -frame 5x5                # 黑色边框

        -noise 3            # 油画
        -monochrome         # 噪声
        -blur 80            # 高斯模糊
        -flop               # 底片
        -negate             # 黑白
        -charcoal 2         # 炭笔
        -spread 30          # 漩涡
        -swirl 67           # 凸起
    ffmpeg
# 系统
## 启动与任务
    grub
        /etc/default/grub       # 设置文件
        grub2-mkconfig -o /boot/grub2/grub.cfg      # 使设置生效，update-grub 是debian下做的包装
    upstart                     # 状态 waiting, starting, pre-start, spawned, post-start,running,pre-stop, stopping, killed, post-stop
    systemv
    systemd
    systemctl
        status
        daemon-reload           # 修改service文件后重载
        systemctl list-units                        # list known units
        systemctl list-unit-files                   # 已知的services
        systemctl list-sockets                      # list socket units ordered by the listening address
        systemctl enable NAME                       # 设置开机启动, 生成service脚本命令
        systemctl disable NAME
        systemctl start NAME
        systemctl stop NAME
        systemctl restart NAME
        systemctl reload NAME
    service
        service start
        service restart
        service stop
        service status
        service --status-all
    chkconfig iptables on/off   # 设置服务启动
        --level 2345 iptables off                   # 查看各level服务状态
        --list iptables
    at                      # 某时间运行一次
    osmo                    # 计划任务软件
    reap                    # 用于定时删除目录中文件，并打印日志
        -h                  # 打印帮助信息
        -t                  # 后台运行, 并设置时间间隔
        -s                  # single 单次运行
    cron
        介绍
            crond服务在systemd中被timer取代

        使用
            $ service crond start
            $ service crond stop
            $ service crond restart
            $ service crond reload                      # 重载配置
            $ crontab crontest.cron                     # 添加定时任务。打印的文件在用户根目录下
            $ crontab -l                                # 列出用户目前的crontab
            $ crontab -u                                # 设定某个用户的cron服务
            $ crontab -r                                # 删除某个用户的cron服务
            $ crontab -e                                # 编辑某个用户的cron服务
                # crontab -u root -l   查看root的设置

            /etc/crontab                                # 系统配置文件
            /etc/cron.hourly
            /etc/cron.daily
            /etc/cron.weekly
            /etc/cron.monthly                           # 每小时、天、周、月执行的脚本

            定时格式
                M H D m d cmd
                    M: 分钟（0-59）每分钟用*或者 */1表示
                    H: 小时（0-23）
                    D: 天（1-31）
                    m: 月（1-12）
                    d: 一星期内的天（0~6，0为星期天）
                    cmd: 如 ~/a.sh
        例子
            crontest.cron文件中
                15,30,45,59 * * * * echo "aa.........." >> aa.txt
                    # 每15分钟执行一次打印
            0 */2 * * * date                            # 每两个小时
## 日志
    dmesg                   # 启动日志
    rsyslog                 # 日志管理, syslog的实现, 在systemd中被systemd-journal取代
    mcelog                  # machine check exception log
    journalctl              # 日志查看
        -x                  # 显示解释
        -e                  # 显示到底部
        -u                  # 指定unit名, 如kubelet
        --no-pager          # 不输出到管道来分页
        -f                  # 追加显示
        -q                  # 只显示warn以上信息
        --user-unit         # 指定用户
        --since "2018-03-26" 
        --until "2018-03-26 03:00"
        场景
            journalctl -f --user-unit onedrive
            journalctl -xefu kubelet --no-pager
## 电源
    poweroff                # 立即关机
    shutdown -h now
        -h                  # 关机
        -r                  # 重启
    pm-suspend              # 挂起电脑
    halt
## 用户
    w                       # 在线用户名, 终端号, 登录时间, 空闲时间, 终端连接所有进程时间, 当前进程时间, 当前命令
    id outrun               # 用户信息
    su
        常用
            切换登录
                sudo -i su outrun
    sudo
    id                      # 用户信息, 所在组
    passwd                  # 修改密码
    useradd outrun          # 创建用户
        -g outrun           # 指定组
        -r                  # 是系统用户
        -d /home/outrun     # 指定登录目录
        -u 544              # 指定id
    userdel -r user1        # 完全删除用户
    groups user1            # 查看组
    groupadd ftp            # 创建组
    usermod                 # 修改用户状态
        -a -G root outrun   # 加入组
        -l newuser user1    # 改名
        -L user1            # 锁定
        -U user1            # 解锁
        -d /home/ftp ftp    # 改登录目录
            -u 123 outrun       # 修改id
## 内核
    uname -a                # 查看版本
    modprobe vboxdrv                    # 内核
    lsmod                               # 显示当前系统加载的模块，如systemctl中start了的模块
    dkms
        status
## 配置
    env                     # 查看所有环境变量
    envsubst                # 编译文件中环境变量
        envsubst '${THREAD_NUM}' < decoder.conf.template > decoder.conf
    getent                  # 查看系统数据库中数据
        group docker        # 查看docker用户组
    ulimit -s unlimited     # 限制shell启动资源, 不限制堆栈大小
        -a 显示各种限制
        -u 10000 最大用户数
        -n 102400 文件句柄数
        -d unlimited 数据段长度
        -m unlimited 内存大小
        -t unlimited cpu时间
        -v unlimited 虚拟内存
# 系统设备
## 接口查看
    lspci
    lsusb
## 显示器
    xrandr
        # 多显示器布局
        -q                         # 列出所有屏幕
        --verbose                   # 列出所有屏幕详情
        --output eDP1               # 指定屏幕
        --off                       # 禁用屏幕
        --primary                   # 指定主显示器
        --mode                      # 分辨率
        --pos                       # 指定屏幕在背景板的位置, 根据各屏幕分辨率、位置算
        --rotate                    # 旋转屏幕
            normal
            left
            right
            inverted
## 声卡
    amixer set Master 100%  # 调节音量
    alsamixer               # 调节声音
    alsactl                 # 设置alsamixer
        store                      # 保存
        restore                    # 加载
    aplay -l
        /etc/asound.conf
            defaults.pcm.card 1
            defaults.pcm.device 1
            defaults.ctl.card 1
    pactl
        场景
            默认声卡
                pactl list short sources
                pactl list short sinks
                pactl set-default-source alsa_input.pci-0000_00_1b.0.analog-stereo
                pactl set-default-sink alsa_output.pci-0000_00_1b.0.analog-stereo
# 系统监控
## 综合监控
    uptime                  # 当前时间, 运行时间, 用户数, 系统负载
    tload                   # 系统负载图(用字符画)
    top
        top -d 1 -p pid [,pid ...]
    htop
        按键
            h               # 帮助
    atop
    btop
    nmon
    glances
    netdata
    vmstat                  # 获得有关进程、swap、内存、cpu等系统信息
    dstat                   # 定时收集系统信息
    sar                     # 全面的系统活动情况
        -u 3 5              # 查CPU负载, 3秒一次共5次 
        -d                  # 磁盘
        -r                  # 内存
        -W                  # SWAP
        -n DEV              # 网络接口
        -n SOCK             # socket连接信息
        -n TCP              # TCP连接
        -b                  # I/O速率
        -q                  # 平均负载
    lxtask                  # GUI监控CPU、内存
    sysdig
        sysdig
            -c
                topprocs_cpu            # 进程cpu top
                    evt.cpu=0           # 只统计cpu0
                topprocs_net            # 进程带宽 top
                topprocs_file           # 进程硬盘i/o top
                topfiles_bytes          # 文件读写 top
                    proc.name=httpd     # 指定进程名
                topfiles_time           # 文件时间 top
                topprocs_errors         # 进程error top
                topfiles_errors         # 文件error top
                topscalls_time          # 系统调用时间 top
                topscalls "evt.failed=true"                 # 系统调用出错 top
                topconns                # 网络连接 top
                fdcount_by
                    proc.name "fd.type=file"                # 进程文件描述符
                fdbytes_by
                    fd.directory "fd.type=file"             # 目录读写 top
                    fd.filename "fd.directory=/tmp/"        # /tmp目录文件 读写top
                    fd.type             # fd type i/o
                echo_fds "fd.filename=passwd"               # 所有名为passwd文件的i/o
                stdout
                    proc.name=bash      # 进程标准输出
                fileslower 1            # 文件i/o 大于1ms
                spy_users               # 命令执行情况

            -A                          # 只显示可读数据
            -s 4096                     # 指定 data buffer 字节
            -r trace.scap               #  指定trace file
            -pc                         # 详情
        csysdig                         # 交互式工具
            -vcontainers                # 容器资源
            -pc                         # 详情
## 内存
    slabtop                 # 内核片缓存信息
## CPU
    powertop                # intel开发，找到高功率进程
    mpstat                  # cpu统计信息
## 进程
    pidstat -p 434  # 进程使用资源的情况
        -u 1        # CPU
        -r 1        # 内存
        -d 1        # 磁盘
        -w          # 上下文切换
    ps
        aux                 # 用在unix style中, BSD格式显示
        ef                  # 用在system v style中, 标准格式显示
    pstree                  # 进程关系
    pwdx [pid]              # 查看进程工作目录
        ll /proc/[pid]/cwd
    pmap [pid]              # 进程

    kill 1024
        -9
            # 3 QUIT 退出(同ctrl + \)
            # 1 HUP 终端断线
            # 2 INT 中断(同ctrl + c)
            # 9 KILL 强制终止
            # 15 TERM 终止
            # 18 CONT 继续(与STOP相反, 同fg/bg)
            # 19 STOP 暂停(同ctrl + z)
        -l                  # 列出所有信号名称和编号
        常用
            删除名字的进程
                ps -ef|grep -v "grep"|grep aurora/app.js |awk '{print $2}'| xargs kill -9
    pkill Xorg              # kill 所有包含
    killall Xorg            # kill 所有包含
    xkill                   # 运行后 在xwindow点击kill窗口
# 网络
## 配置
    hostname
    nmtui                   # 设置网卡
    nmcli                       # 设置网络连接
        sudo nmcli c mod 'Wired connection 1' ipv4.never-default false
            # 解决manual ip不能设置路由的问题
    wpa_supplicant
    iwlist                  # 列出无线网
    iwconfig                # 无线网卡设置
    wifi-menu
    pppoe                   # 宽带
    ifconfig
        打开, 关闭网卡
            ifconfig eth0 up
            ifconfig eth0 down
        临时修改ip
            ifconfig eth0 192.168.0.1 netmask 255.255.255.0 up
                # up表示立即激活
        临时mac
            ifconfig enp0s20u6u3 hw ether 00:50:56:c0:00:02
        虚拟网卡
            ifconfig wlp7s0:1 ip netmask
                # 共用一个ip
    netctl                  # 配置网卡服务
    route                   
        -n                  # 查看路由表 
        //添加到主机的路由
        route add –host 192.168.168.110 dev eth0
        route add –host 192.168.168.119 gw 192.168.168.1
        //添加到网络的路由
        route add –net IP netmask MASK eth0
        route add –net IP netmask MASK gw IP
        route add –net IP/24 eth1
        //添加默认网关
        route add default gw IP
        //删除路由
        route del –host 192.168.168.110 dev eth0
    arp -n                  # 显示局域网 ip mac表
        -s ip mac           # 设置ip mac表
    ip                      # 网卡与ip信息
        添加路由
            ip route add 10.146.81.0/24 via 10.146.81.29
        配置ip段互斥的宿主机转发
            服务器
                ip link set up dev tun0
                sysctl net.ipv4.ip_forward=1
                /etc/sysctl.d/30-ipforward.conf
                    net.ipv4.ip_forward=1
                    net.ipv6.conf.default.forwarding=1
                    net.ipv6.conf.all.forwarding=1
            客户端
                ip addr add 192.168.123.201/24 dev eth0             # 要转发的网段
                ip link set up dev eth0
                ip route add default via 192.168.123.100 dev eth0   # 服务器ip
    hostapd                 # 无线热点
        yum install hostapd
        vi /etc/hostapd/hostapd.conf
            wpa_passphrase=asdfasdf
            ssid=myflowers
            interface=p3p1

        yum install dhcp
        vi /etc/dhcp/dhcpd.conf
            option domain-name-servers 192.168.0.1,8.8.8.8;         # 自己的dns提供商
            option routers 192.168.0.42;    # 本机ip
            option domain-name "mydhcp";
            option domain-name-servers 192.168.0.1;
            log-facility local7;
            subnet 192.168.0.0 netmask 255.255.255.0 {
                range  192.168.0.160 192.168.0.170;
                option broadcast-address 192.168.0.255;
            }
## 测试工具
    ab                      # 压测
        ab -c 10 -n 100 https://www.baidu.com/
            # 10并发100次, url结尾要有/
    mtr                     # myTrace, 合并ping与traceroute，默认发送ICMP包, 做持续探测, 避免节点波动的影响
    traceroute              # 做一次探测, 默认UDP包, 发包TTL值逐渐增大
        -I                  # 使用ICMP包
    ping
    telnet
    nslookup                    # 查域名ip
    dig                     # 域名解析
    nmblookup -A ip             # 查ip域名
    nmap
        -sP ip/24           # 查看网内所有ip
        -p1-65535           # 扫描所有端口
        常用
            nmap 192.168.100.1/24 -p1-65535
    nc                      # netcat, 功能全面
        -U a.sock           # 指定socket
        -v                  # 显示详情
        -z                  # 只测试连通
        -u                  # 使用udp

        o-> 测试udp端口
        nc -vzu 127.0.0.1 1194
        o-> 文件传输
        nc -l -p 9999 | tar xf -
        tar cf - $(find . -name "*") | nc -v 10.99.11.44 9999
    rinetd                  # TCP端口转发
        rinetd.conf
            0.0.0.0 80 192.168.1.2 80    
        rinetd -c /etc/rinetd.conf
    simplehttp
        python -m SimpleHTTPServer 8080
## 请求工具
    curl
        curl -v             # 详细头信息
        curl -H "Cookie: foo=bar; baz=val"          # 发送cookie
        curl -X post -k http://localhost:9090/a -H "Content-Type: text/plain" -d '{"name": "a"}'
            # post请求
        curl -O http://104.223.142.166/isu80        # 抓文件
    wget
        -i filelist.txt         # 下载一个文件中的所有url
        -x  # 强制创建目录
        -P  # 目录prefix
        -r  # 递归下载
        -l  # 最大递归深度, inf或0代表无限制
        -k  # 修改链接，指向本地文件
        -p  # 下载所有用于显示页面的资源, 如图片
        -L  # 只跟踪relative链接
        -N  # 只获取比本地新的文件
        -np # 不追踪父目录
        -m  # 缩写-N -r -l inf --no-remove-listing
        --no-remove-listing         # 不删除listing文件

        常用
            爬网站
                wget -x -P curSite -r -l 100 -k -L -np http://nodeapi.ucdok.com/api/
                带cookie
                    wget --post-data="username=u1&password=asdf" --save-cookies=cookie --keep-session-cookies "http://www.abc.com/logging.php"
                    wget -x -P curSite -r -l 1 -k -L -np --load-cookies=cookie --keep-session-cookies "https://www.abc.com/display/1"
    ssh
        ssh 10.1.10.2 -L 9901:localhost:5901
            # 用ssh建tunnel访问内部端口
        ssh -t -L 5900:localhost:5900 remote_host 'x11vnc -localhost -display :0'
            # 本机执行命令并端口映射
    sshpass
        sshpass -p asdf ssh root@47.74.230.238
    sshfs -o allow_other root@ip:~ /mnt                 # 挂载远程目录
    scp a.txt root@ip:~
    w3m                     # 命令行浏览器
    vnc                     # 远程桌面
        Virtual Network Computing
        相关文章
            linux 自带远程桌面--VNC服务配置说明
        安装
            yum install vnc*

            yum install *vnc-server*
        启动
            vncserver :1
        登录
            vncviewer        # fedora 下gnome自带的vncviewer名为:Remote Desktop Viewer
                输入192.168.0.62:1                      # 实际端口号为5901, 如果服务号为2则为5902
            或者浏览器java-plugin
                localhost:5801                          # 需要安装java
## 监控
    iftop -n                # 流量监控
    ntop                    # 流量监控, web界面
        # localhost:3000
        -W 3001
                            # Loss%丢包率, Snt每秒包数, Last最近一次延迟, Avg平均值, Best最小值, Worst最大值, StDev标准差
        -u                  # 使用udp包
        --no-dns            # 不对ip做域名反解析
        -4                  # 只用ipv4
        -6                  # 只用ipv6
        结果
            1,2,3,4 本地网络
            5,6 运营商骨干网络
            7,8,9,10 目标服务器本地网络
                8 链路负载均衡
    tcpdump
        -v                          # verbose输出
        -vvv            # 最详细输出
        -n                          # 网络地址显示数字
        -nn                         # ip和端口显示
        -i                          # 指定网卡
        -c 100                      # 100条后退出
        -w file1                    # 保存到文件
        -r file1 tcp                # 从文件读取，指定tcp协议
        -G 5 -w /opt/capfile-%Y_%m%d_%H%M_%S        # 滚动日志
        greater 200                 # 报文字节大于200
        host 192.168.0.1            # 包含ip
        port 80                     # 包含端口
        port !80
        dst host 192.168.0.1        # 目标ip
        dst port 80                 # 目标端口
        src host
        src port
        net 192.168.0.1/32          # 包含网段
        udp/tcp/icmp/igmp/arp       # 指定协议
        ip                          # ip协议
        ip proto ospf               # 类型为ospf的ip包
        ip[9]=6                     # ip包头第10字节为6（tcp协议）
        ether multicast                             # 二层类型为多播
        ether src host 00:0c:29:9a:1f:4e            # 二层mac
        常用
            tcpdump -i eth0 -vnn \(src host 8.8.8.8 and port 80 \) or \(src host 10.10.10.10 and dst port 443\)
            tcpdump -n tcp port 8383 -i lo and src host 183.14.132.117
    iotop                   # 实时监视io
        p                   # 显示pid
        o                   # 只显示活跃
    iostat                  # 负载情况
    lsof -i:8080            # 列出当前系统打开的文件，必须root运行才准确
        -i                  # 端口
        -P                  # 显示端口号而非名称
        -n                  # 显示ip而非域名
        -i -n -P            # 查看进程句柄数
    nicstat                 # 网络流量统计
    netstat
        -a                  # 显示所有
        -n                  # 显示数字，而不是别名
        -t                  # 仅显示tcp
        -u                  # 仅显示udp
        -p                  # 显示建立链接的程序名
        -l                  # 仅列出listen的服务
        -o                  # 显示timer, 如keepalive
        -antpu              # 端口
    tapestat                # 磁带驱动器信息
    ss                      # 端口，性能高
        -l                  # listening
## 防火墙
    getenforce              # 查看selinux状态
    sestatus -v             # 查看selinux状态
    setenforce 0            # 临时关闭selinux
        1                   # 启用
    ufw                     # ubuntu, 简化防火墙
    iptables [-t 表] -命令 匹配 操作
        参数
            -t                  # 要操作的匹配表
            命令
                -P                  # 策略, INPUT等
                -A                  # append, 添加
                -I 1                # 在第2条前添加
                -D 1                # delete, 删除
                -R 1                # 替换

                -L                  # list 显示
                -n                  # 端口以数字显示
                -v                  # verbose, 显示更多信息
                -F                  # flush
                -X                  # 清除自定chain
                -Z                  # 清除统计数
            规则
                -p                  # 协议
                -i                  # 指定网卡流入
                -o                  # 指定网卡流出
                -s                  # 来源ip, !表示排除
                -d                  # 目标ip
                --sport             # 源端口
                --dport             # 目标端口
                -m                  # 使用模块, 会根据-p选择模块
            动作
                -j                  # 跳转
                    ACCEPT
        四表(table)
            raw             # 跟踪
            mangle          # 标记
            nat             # 修改ip、port
            filter          # 过滤, 默认
        五链(chain)
            PREROUTING
            FORWORD         # INPUT前转发到POSTROUTING
            INPUT
            OUTPUT
            POSTROUTING 
        策略(policy)
            ACCEPT          # 通过
            REJECT          # 拒绝，返回数据
                返回数据包
                    ICMP port-unreachable
                    ICMP echo-reply
                    tcp-reset
                iptables -A  INPUT -p TCP --dport 22 -j REJECT --reject-with ICMP echo-reply
            DROP            # 丢弃
            REDIRECT        # 导向端口(PNAT)
                iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT--to-ports 8081
            MASQUERADE      # 改写来源ip为本机ip, 可指定目标端口范围
                iptables -t nat -A POSTROUTING -p TCP -j MASQUERADE --to-ports 21000-31000
            LOG             # 日志, 记在/var/log
                iptables -A INPUT -p tcp -j LOG --log-prefix "input packet"
            ULOG
            SNAT            # 改写源地址, 只适用POSTROUTING
                iptables -t nat -A POSTROUTING -p tcp-o eth0 -j SNAT --to-source 192.168.10.15-192.168.10.160:2100-3200
            DNAT            # 改写目标地址, 只适用POSTROUTING
                iptables -t nat -A PREROUTING -p tcp -d 15.45.23.67 --dport 80 -j DNAT --to-destination 192.168.10.1-192.168.10.10:80-100
            TOS
            MIRROR          # 对调源ip与目标ip后返回
            QUEUE           # 封包入队列待处理，实现功能如：计算联机费用
            RETURN          # 退出当前规则链, 返回主规则链
            TTL
            MARK            # 对包做标记数字
                iptables -t mangle -A PREROUTING -p tcp --dport 22 -j MARK --set-mark 22
        规则(rule)          # 自定义的条件
        配置文件
            /etc/sysconfig/iptables
            /usr/libexec/iptables/iptables.init
                save
            rules.v4        # 自定义配置
                *filter
                :INPUT ACCEPT [186:19951]
                :FORWARD ACCEPT [0:0]
                :OUTPUT ACCEPT [71:11164]
                -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
                -A INPUT -p tcp -m tcp --dport 23 -j ACCEPT
                -A INPUT -p tcp -m tcp --dport 24 -j ACCEPT
                COMMIT
        命令
            systemctl enable iptables.service
            service iptables save
            service iptables restart
            iptables-restore < rules.v4
                # 导入配置
        案例
            关iptables
                service iptables stop
                chkconfig iptables off
            查看
                iptables -L -n -v --line-numbers
            查nat表
                iptables -t nat -L
            flush, 生效
                iptables -F
            service命令
                service iptables save
                service iptables stop
                service iptables start
                service iptables restart
            开机启动
                /etc/network/if-pre-up.d/iptables
                    iptables-restore < rules.v4

            插入规则
                iptables -I INPUT 2 -s 202.54.1.2 -j DROP
            删除规则
                iptables -D INPUT 4
            开放所有input/output
                iptables -P INPUT ACCEPT
                iptables -P OUTPUT ACCEPT
            开放input/output tcp 22
                iptables -A INPUT -p tcp --dport 22 -j ACCEPT
                iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
            vpn转发
                iptables -t nat -A POSTROUTING -s 192.168.252.0/24 -j SNAT --to-source 10.171.83.146
            屏蔽私有地址
                iptables -A INPUT -i eth1 -s 192.168.0.0/24 -j DROP
                iptables -A INPUT -i eth1 -s 10.0.0.0/8 -j DROP
            屏蔽ip
                iptables -A INPUT -s 1.2.3.4 -j DROP
                iptables -A INPUT -s 192.168.0.0/24 -j DROP
                iptables -A OUTPUT -d 192.168.1.0/24 -j DROP
                iptables -A OUTPUT -o eth1 -d 192.168.1.0/24 -j DROP
            屏蔽端口
                iptables -A INPUT -p tcp -s 1.2.3.4 --dport 80 -j DROP
                iptables -A INPUT -i eth1 -p tcp -s 192.168.1.0/24 --dport 80 -j DROP
            记录并屏蔽
                iptables -A INPUT -i eth1 -s 10.0.0.0/8 -j LOG --log-prefix "IP_SPOOF A: "
                iptables -A INPUT -i eth1 -s 10.0.0.0/8 -j DROP
            mac屏蔽
                iptables -A INPUT -m mac --mac-source 00:0F:EA:91:04:08 -j DROP
                # *only accept traffic for TCP port # 8080 from mac 00:0F:EA:91:04:07 * ##
                iptables -A INPUT -p tcp --destination-port 22 -m mac --mac-source 00:0F:EA:91:04:07 -j ACCEPT
            屏蔽icmp
                iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
                iptables -A INPUT -i eth1 -p icmp --icmp-type echo-request -j DROP
            开启范围端口
                iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 7000:7010 -j ACCEPT
            开启范围ip
                iptables -A INPUT -p tcp --destination-port 80 -m iprange --src-range 192.168.1.100-192.168.1.200 -j ACCEPT
            nat
                iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o eth0 -j SNAT --to 123.4.5.100
                    # 改写来自192.168.1.0/24的包, 源ip为123.4.5.100
                iptables -t nat -A PREROUTING -s 192.168.1.0/24 -i eth1 -j DNAT --to 123.4.5.100
                    # 改写来自192.168.1.0/24的包, 目标ip为123.4.5.100
                iptables -t nat -A POSTROUTING -s 172.27.0.0/16 -d 10.0.0.1 -p tcp --dport 80 -j SNAT --to-source MASQUERADE
                    # 改写来自172.27.0.0/16去向10.0.0.1:80的tcp包, 源ip为本机ip
                iptables -t nat -A PREROUTING -d 192.168.1.1 -p tcp --dport 80 -j DNAT --to-destination 10.0.0.1
                    # 改写去向192.168.1.1:80的tcp包, 目标ip为10.0.0.1

    firewall
        systemctl start firewalld

        o-> ftp
        firewall-cmd --zone=public --add-port=20/tcp --permanent
        firewall-cmd --zone=public --add-port=21/tcp --permanent
        firewall-cmd --permanent --add-port=1000-2000/tcp
        firewall-cmd --complete-reload

        o-> 8080
        firewall-cmd --query-port=8080/tcp
            --add-port=8080/tcp --permanent --zone=public
            --reload
            --get_active-zones
            --list-all
            --set-default-zone=public
        o->
        firewall-cmd --permanent --remove-port=8080/tcp
# 存储
## 硬盘
    fdisk -l
    cfdisk
    sfdisk
    parted
    mkfs
    mkswap

    testdisk /dev/sdb1
    e2fsck -a /dev/sdb1         # 修复ext2
    ntfsfix -d -b /dev/sdb1     # 修复ntfs坏扇区和脏标记
    fsck /dev/sda1              # 检查并修复

    udisks --detach 设备编号     # 移除磁盘

    mount  /dev/sdb1 /mnt
        -o acl                  # 打开acl功能
        -o loop x.iso           # 挂载文件
        -o iocharset=utf8       # 指定编码
        -t vfat                 # 指定类型
    umount
        -n                      # 执行umount却不写入
        -l                      # lazy
        -f                      # force

    df -h                       # 已挂载分区列表
        -T                      # 查看分区类型
    blktrace                    # 磁盘访问情况
    lsblk                       # 查看挂载的分区
    lvs
        LVM逻辑卷的创建流程如下：
            将一个磁盘或分区格式化为物理卷：pvcreate /dev/sdb1
            将物理卷添加到一个卷组中：vgcreate linuxcast-vg /dev/sdb1 /dev/sdb2
            基于卷组创建一个逻辑卷mylv：lvcreate -L 10G -n mylv  linuxcast-vg
            格式化逻辑卷：mkfs.ext4 /dev/linuxcast-vg/mylv
            挂载使用：mount /dev/linuxcast-vg/mylv  /mnt
        逻辑卷查看命令：
        pvdisplay
        pvs
        vgdisplay
        vgs
        lvdisplay
        lvs
        删除一个逻辑卷：
        lvremove /dev/linuxcast-vg/mylv
        删除一个卷组：
        vgremove linuxcast-vg
        删除一个物理卷：
        pvremove /dev/sda1
    nfsiostat               # nfs驱动器信息
    cifsiostat              # CIFS信息
    growpart                # 磁盘热扩容
## 文件操作
    fuser                   # 查看文件被谁使用
        -u                  # 列出使用者用户名
        -uk                 # 终止文件的所有进程
        -n tcp 8080         # 列出端口的进程号
    ldd /bin/ls             # 查看可执行文件动态引用模块
    rename 's/\.bak$//' *.bak           # 重命名
    rm -rf
    touch
        -t 0712250000 file              # 修改文件时间戳(YYMMDDhhmm)
    ls *[0-9]*
        -t                  # 时间排序
        -R                  # 递归显示文件
        -l                  # 详情
        -S                  # 按大小排列
        -r                  # reverse
        -h                  # 自动大小单位
        -F                  # 加后缀标识类型
        -Z                  # 显示文selinux状态
    tree
    mkdir
    rmdir
    cd
        ~
        -
    cp
        -r                  # 递归
        -p                  # 带权限复制
        -d                  # 保留链接
        -a                  # -dpr
    mv
    whereis
    which
    find .
        maxdepth 1
        -name "*.go"
        -type f
        -atime +100         # 100天未使用过的执行文件
        -mtime -10          # 10天内创建或修改的文件
        -exec chmod +x      # 对找到的文件执行命令
        -xdev               # 忽略块设备
    file                    # 探测文件类型
        file 可执行文件     # 可查看是否静态编译
    ln
    du -d 1 -h
        -s                  # 只返回汇总情况
        -k                  # 统一单位
    tar xf
        cfzv x.tar.gz x     # 压缩
        xfzv x.tar.gz       # 解压
        --exclude=/proc
    gzip x                  # 压缩
        -d x                # 解压
    unzip
        常用
            unzip中转码
                unzip -P “$(echo 中文 | iconv -f utf-8 -t gbk)”
    unzip-beta              # 解压并转码中文
    diff        # 改变以匹配第二个文件
        diff -y a b
        diff dir1 dir2

        diff -uN a b > b.patch
        patch -p0 < b.patch
        patch -RE -p0 < b.patch

        diff -uNra a b > b.patch
        cd a
        patch -p1  < ../b.patch
        patch -RE -p1 < ../b.patch
    rsync -av --exclude=.git --exclude=logs/* ./* 192.168.0.14:/data/app/ext-marketing/
    vimdiff a b

    mucommander             # 跨平台文件管理软件
    shred                   # 文件粉碎
    rclone                  # 云存储同步
        config              # 配置向导
        ls [name]:          # 显示文件
        lsd [name]:         # 显示文件夹
        copy a [name]:a     # 上传
        cleanup             # 只保留最新版本
        sync                # 本地向远程同步
        mount               # 双向一致同步
            fusermount -u /path/to/local/mount
                # umount
    rclone-browser          # rclone GUI
    onedrive
        onedrive --resync
        常用命令
            systemctl --user enable onedrive
            systemctl --user start onedrive
            journalctl --user-unit onedrive -f
## 权限
    chmod ugo+rwx           # u拥有者, g群组, o其他人, +添加, -删除, r读、w写、x执行
        chmod a+rwx         # a指所有人
    chattr +i file          # 改变属性
    lsattr file
    chown -R outrun:outrun .
    chgrp -R outrun .
    getfacl                 # 查看一个文件的ACL设置
    setfacl [-bkndRLP] { -m|-M|-x|-X ... } file ...
        -b                  # 去掉所有acl设置
        -m u:sudo:rwx   filename    # 配置用户权限
        -m g:sudo:r-x  filename     # 配置组的权限
        -x u:user1 filename         # 删除一个ACL设置
        -d -m g:sudo:rwx            # 指定default
    chcon                   # 修改文件安全上下文
        -R                  # 递归
        -t                  # type
        -u                  # user
        -r                  # role
        --reference         # 参照更新
        chcon -R -t mysqld_db_t /data
        chcon -R --reference=/var/lib/mysql /data
# 功能软件
## 包管理
    snap
        list                    # 列已安装
        info                    # 查看仓库所有版本
        find                    # 搜索
        install
        remove
        refresh                 # 更新
            refresh all
        revert                  # 还原到上个版本
            --revision          # 指定版本
        run                     # 运行命令
        start                   # 运行service
            --enable            # 开机启动
        stop                    # 停止service
        save                    # 存配置快照
        saved                   # 列出所有快照
    rpm                         # 源 rpm fusion
        -i 安装
        -e 卸载
        -qa 查看安装的包名
        -ql 包名, 查看安装的文件
        -qc 包名, 查看软件的配置文件
    pacman
        命令 pacman<操作> [选项] [目标]
            操作
                -Q                      # 查询
                -S                      # 安装
                -R                      # 删除
                -D                      # 数据库
                -F                      # 文件
            选项
            选项-S, -R, -U
                -s
            选项-S, -U
            选项-Q
                -s                      # 搜索
                -e                      # 明确指定的
                -n                      # 本地的
                -q                      # 静默
                -i                      # 详情, 两个i显示备份文件和修改状态, 显示依赖
                -l                      # 列出文件
                -o                      # 显示拥有此文件的包名
            选项-R
                -s                      # 递归
                -c                      # 级联依赖此包的包
                -n                      # 不记录备份信息
            选项-S
                -s                      # 搜索
                -y                      # 刷新, 两个y强制升级所有包数据库
                -q                      # 静默
                -u                      # 系统升级
                -c                      # 清理, 一个c清理未安装包, 两个c清理所有cache
            选项-D
            选项-F
            目标

        常用
            -Qeq | pacman -S -                  # 重新安装所有包
            -S $(pacman -Qnq)                   # 重新安装所有包
            -Ss ^ibus-*                         # 通配search
            -S $(pacman -Ssq fcitx*)            # 通配安装
            -R $(pacman -Qsq fcitx)             # 通配删除
            -Rcns plasma                        # 删除plasma
            -Rns                                # 删依赖并删配置
            -Scc                                # 清除缓存
            -Qii zsh                            # 包信息
            -Ql zsh                             # 查看安装的文件
            -Qo /bin/zsh                        # 查看文件属于的包
            -Qdt                                # 查孤儿包 

        源
            mirrors.163.com
    apt
        源
            阿里云mirror: https://developer.aliyun.com/mirror
            ubuntu
                sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list 
    downgrade                               # 用于给pacman安装过后软件降级
    yum
        list                                # 列出所有包
            updates                         # 列可更新的包
            installed                       # 列已安装
            extras                          # 已安装但不在yum repository的包
        search
        install
        remove
        info                                # 包详情
            updates
            installed
            extras
        provides                            # 包文件
        whatprovides 'bin/isstat'           # 查看命令属性哪个包
        history
            list
            redo 序号                        # 重新做序号
            undo 序号                        # 恢复历史中执行的动作
        groups list                         # 查看安装的组


        设置代理
            /etc/yum.conf
            proxy=http://XXX.XXX.XXX.XXX：XXXX
            或
            proxy=FTP://XXX.XXX.XXX.XXX:XXXX
            proxy_username=你的用户名
            proxy_password=你的用户名的密码
        编译用包
            build-essential                     # yum中基本编译依赖包
            yum install make cmake apr* autoconf automake curl-devel gcc gcc-c++ zlib-devel openssl openssl-devel pcre-devel gd  kernel keyutils  patch  perl kernel-headers compat* mpfr cpp glibc libgomp libstdc++-devel ppl cloog-ppl keyutils-libs-devel libcom_err-devel libsepol-devel libselinux-devel krb5-devel zlib-devel libXpm* freetype libjpeg* libpng* php-common php-gd ncurses* libtool* libxml2 libxml2-devel patch freetype-devel ncurses-devel libmcrypt libtool flex pkgconfig libevent glib libgnomeui-devel
    dpkg                        # 管理deb包程序
        -i                      # 安装
        -r                      # 删除
    pkgfile                     # 查看命令所需的包
## 编译
    :() { :|:& };:              # fork bombmake
    make
        注意
            缩进只能用tab
        命令
            make
            make install
            make glide
        条目里执行shell
            @echo $(shell $(SHELL_PATH))

        o->
        TESTS = test/*.js
        REPORTER = spec
        TIMEOUT = 10000
        MOCHA_OPTS =

        test:
            @NODE_ENV=test ./node_modules/mocha/bin/mocha \
                --reporter $(REPORTER) \
                --timeout $(TIMEOUT) \
                $(MOCHA_OPTS)
                $(TESTS)

        test-cov
            @$(MAKE) test MOCHA_OPTS='--require blanket' REPORTER=html-cov > coverage.html

        test-all: test test-cov

        .PHONY: test

        o->
        TESTS = $(shell ls -S `find test -type f -name "*.js" -print`)
        TESTTIMEOUT = 5000
        MOCHA_OPTS =
        REPORTER = spec

        install:
            @$PYTHON=`which python2.6` NODE_ENV=test npm install

        test:
            @NODE_ENV=test ./node_modules/mocha/bin/mocha \
                --reporter $(REPORTER) \
                --timeout $(TIMEOUT) \
                $(MOCHA_OPTS) \
                $(TESTS)

        test-cov:
            @$(MAKE) test REPORTER=dot
            @$(MAKE) test MOCHA_OPTS='--require blanket' REPORTER=html-cov > coverage.html
            @$(MAKE) test MOCHA_OPTS='--require blanket' REPORTER=travis-cov

        reinstall: clean
            @$(MAKE) install

        clean:
            @rm -rf ./node_modules

        build:
            @./bin/combo views .

        .PHONY: test test-cov clean install reinstall
    cmake
    makepkg                 # 创建软件包
## 调试
    perf                    # 性能调优
    strace                  # 跟踪系统调用
    itrace                  # linux系统编程中跟踪进程的库函数调用
        -S ./hello          # 跟踪所有系统调用
    dtrace                  # 应用程序动态跟踪
    bpftrace                # btrace2.0
    gdb
    SystemTap               # 内核动态探针
# 图形程序
## 桌面
    kde
    xfce
### gnome
    启动
        .xinitrc
            exec gnome-session
        startx
    gnome3应用程序列表
        /usr/share/applications
    取消ctrl+alt+down/up
        gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['']"
        gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['']"
    gnome-shell
        alt + f2后输入lg
    gnome terminate
        ctrl + shift + c/v                  # 复制/粘贴
        ctrl + shift + t/n                  # 打开新标签/新窗口
        ctrl + w 或 alt + backspace          # 删除最后的word
        ctrl + shift + w/q                  # 关闭当前term/所有term
        ctrl + shift + f/g/h                # 搜索/搜索下一个/搜索上一个
        ctrl + pageUp/pageDown              # 切换标签
        ctrl + shift + pageUp/pageDown      # 移动标签
        alt + 1/2/3/..../0                  # 切换到第1/2/3/....../10个标签
    系统快捷键
        右键快捷键
            shift + f10
### i3
    启动
        .xinitrc
            exec i3
### awesome
    启动
        .xinitrc
            exec /usr/bin/awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
    命令
        awesome
        awesome-client
    配置
        配置模板
            /etc/xdg/awesome/rc.lua
        .config/awesome/rc.lua
            Variable definitions            # 可定义布局优先级
            Menu                            # 右键菜单
            Wibar                           # 生成screen, 设壁纸
            Mounse bindings                 # 鼠标键绑定函数
            Key bindings                    # 快捷键
            Rules                           # client规则, 如在哪个screen显示
            Signals                         # client启动信号触发动作
            自定义
        API
            文档地址
                https://awesomewm.org/apidoc/
            快捷键简写
                modkey                      # win键
                Mod1                        # alt
            gears                           # 工具组件
            wibox                           # wibar
                widget
                layout
            beautiful                       # theme
                init(gears.filesystem.get_configuration_dir() .. "/themes/default/theme.lua")
                    # 主题
                useless_gap = 5             # 窗口间隔
                theme.lua文件
                    theme.wallpaper = "~/.config/awesome/themes/awesome-wallpaper.png"
                        # 背景

            naughty
                notify({ preset = naughty.config.presets.critical, title = "Oops, there were errors during startup!", text = awesome.startup_errors })
            menubar
                menu_gen
            hotkeys_popup
            awful
                layout
                tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
                key({ modkey }, "F12", function () awful.spawn{ "xlock" } end)
                    # 快捷键
                    awful.key({ "Mod1" }, "Escape", function () awful.menu.menu_keys.down = { "Down", "Alt_L" } awful.menu.clients({theme = { width = 250 }}, { keygrabber=true, coords={x=525, y=330} }) end),
                widget
                rules
                spawn("firefox", { tag = mouse.screen.selected_tag })
                util.spawn_with_shell("~/.config/awesome/autorun.sh")
                    # 随桌面启动脚本
        autorun.sh
            #!/usr/bin/env bash

            # nothing to use
            function run {
                if ! pgrep $1 ; then
                    $@&
                fi
            }

            if randr | grep -q 'eDP1 connected' ; then
                run xrandr --output VIRTUAL1 --off --output eDP1 --mode 1920x1080 --pos 0x720 --rotate normal --output DP1 --off --output DP2-1 --mode 2560x1080 --pos 3360x720 --rotate normal --output DP2-2 --off --output DP2-3 --off --output HDMI2 --off --output HDMI1 --primary --mode 2560x1440 --pos 1920x0 --rotate left --output DP2 --off
            fi

            run ibus-daemon -d -x
            run nm-applet
    插件
        revelation          # 全局client
        shifty              # 动态tag
        naughty             # 通知
        vicious             # widgets
        obvious             # widgets
        bashets             # widgets
## 小程序
    cmatrix                 # 终端黑客帝国
    screenfetch
    import                  # 截图
        import a.png        # 选取区域
        -pause 3 -frame a.png                       # 截窗口, 延迟3秒(为了选定)
    xgamma -gamma .75       # 调整屏幕色值
    display                 # 显示图片
        display *.png       # 幻灯片
        -delay 5            # 5百分之秒切换

        快捷键
            空格            # 下一张
            退格            # 上一张
            h               # 水平翻转
            v               # 垂直翻转
            /               # 顺时针翻转90度
            \               # 逆时针旋转90度
            >               # 放大
            <               # 缩小
            f7              # 模糊
## 任务栏
    nm-applet
        # 联网
## 输入法
    fcitx
    ibus
    ibus-daemon -d -x -r        # ibus后台运行
## 模拟
    wine
    winetricks                  # 安装wine的各种依赖
    cabextract                  # microsoft cabinet获取工具
## 资源管理
    nautilus
        快捷键
            <Ctrl+L>            # 路径编辑
            <Ctrl+W>            # 关闭tab
            <Ctrl+Shift+W>      # 关闭所有tab
            <Ctrl+T>            # 新建tab
            <F9>                # 侧边栏
