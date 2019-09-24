---
Categories: ["运维"]
title: "LinuxTool"
date: 2018-10-11T18:47:57+08:00
---
# 包
    net-tools
        ifconfig
# 内核
    modprobe vboxdrv                    # 内核
    lsmod                               # 显示当前系统加载的模块，如systemctl中start了的模块
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
# 文件
    rm -rf
    touch
        -t 0712250000 file              # 修改文件时间戳(YYMMDDhhmm)
    ls *[0-9]*
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
    find .
        maxdepth 1
        -name "*.go"
        -type f
        -atime +100         # 100天未使用过的执行文件
        -mtime -10          # 10天内创建或修改的文件
        -exec chmod +x      # 对找到的文件执行命令
        -xdev               # 忽略块设备
    pwd                     # 当前路径
    file                    # 探测文件类型
    uniq                    # 删除重复列
    ln
    du -d 1 -h
        -s                  # 只返回汇总情况
        -k                  # 统一单位
    chmod ugo+rwx           # 所有人(u), 群组(g), 其他人(o)以读、写、执行权限
    chattr +i file          # 改变属性
    lsattr file
    chown -R outrun:outrun .
    chgrp -R outrun .
    getfacl                 # 查看一个文件的ACL设置
    setfacl
        -m u:linuxcast:rwx   filename   # 配置用户权限
        -m g:linuxcats:r-x  filename    # 配置组的权限
        -x u:linuxcast filename         # 删除一个ACL设置

    mucommander             # 跨平台文件管理软件

    cat
    tac                     # 倒转行显示
    wc                      # 统计行, 单词, 字符
    grep
    awk
    sort
        -r                  # reverse
        -n                  # 显示行号
    more
    less

    iconv
        -l                  # 列出已知的编码
        -f gbk -t utf-8 -c orig.txt -o tgt.txt      # 转码
    tar xf
        cfzv x.tar.gz x     # 压缩
        xfzv x.tar.gz       # 解压
        --exclude=/proc
    gzip x                  # 压缩
        -d x                # 解压
    unzip
    unzip-beta              # 解压并转码中文
    head -2
    tail -2
        -f
    paste file1 file2       # 合并两个文件或两栏内容
        -d '+'              # 分隔符
    nano
    strings                 # 打印可打印字符
    getenforce              # 查看selinux状态
    sestatus -v             # 查看selinux状态
    setenforce 0            # 临时关闭selinux
        1                   # 启用
    chcon
        -R                  # 递归
        -t                  # type
        -u                  # user
        -r                  # role
        --reference         # 参照更新
        chcon -R -t mysqld_db_t /data
        chcon -R --reference=/var/lib/mysql /data

# 系统
    man
        -f                  # 简要介绍
        -k                  # 通配搜索
    w                       # 在线用户、系统负载
    id outrun               # 用户信息
    su
    sudo
    clear
    whatis                  # man -f
    apropos                 # man -k
    uname -a                # 查看版本
    hostname
    id                      # 用户信息
    useradd outrun          # 创建用户
        -g outrun           # 指定组
        -r                  # 是系统用户
        -d /home/outrun     # 指定登录目录
        -u 544              # 指定id
    passwd                  # 修改密码
    usermod                 # 修改用户状态
        -a -G root outrun   # 加入组
        -l newuser user1    # 改名
        -L user1            # 锁定
        -U user1            # 解锁
        -d /home/ftp ftp    # 改登录目录
        -u 123 outrun       # 修改id
    userdel -r user1        # 完全删除用户
    groups                  # 查看组
    groupadd ftp            # 创建组
    poweroff                # 立即关机
    shutdown -h now
        -h                  # 关机
        -r                  # 重启
    pm-suspend              # 挂起电脑
    halt
    bash
        -c                  # 执行命令字符串

# 查看
    env                     # 查看所有环境变量
    echo
    watch -n 1 -d netstat  -ant         # 监视
    date +%Y/%m/%d/%H:%M
    rig                     # 随机产品人名地名
    forturn                 # 随机名言
    toilet                  # 彩虹字
    cowsay
    figlet                  # 大写字
    cmatrix                 # 终端黑客帝国
    sl                      # 火车
    cal 9 1752              # 打印日历
# 控制
    script/scriptreply      # 终端录制
    source
    bc
    maxima                  # 符号计算
    pv -qL 10               # 文件缓慢显示
    aview                   # 图片文件化
    shred                   # 文件粉碎
    factor                  # 分解质因数
    screenfetch
    expect                  # 为运行的脚本预填表单

        o-> 实例
        #!/usr/bin/expect -f
        spawn sudo /usr/local/mysql/bin/mysqld_safe --user=mysql
        expect "*password:*"
        send -- "asdf"
        send -- "\n"

        interact            # interact留下交互, exit退出

        o-> 后台执行        # 不要expect eof
        if [fork]!=0 exit
        disconnect
# 日志
    dmesg                   # 启动日志
    rsyslog                 # 日志管理, syslog的实现, 在systemd中被systemd-journal取代
    mcelog                  # machine check exception log
    journalctl              # 日志查看
            -xe
# 设备
    top
        top -d 1 -p pid [,pid ...]
    htop
    vmstat                  # 获得有关进程、swap、内存、cpu等系统信息
    dstat                   # 定时收集系统信息
    sar                     # 全面的系统活动情况
    ulimit -s unlimited     # 限制shell启动资源, 不限制堆栈大小
        -a 显示各种限制
        -u 10000 最大用户数
        -n 102400 文件句柄数
        -d unlimited 数据段长度
        -m unlimited 内存大小
        -t unlimited cpu时间
        -v unlimited 虚拟内存
    setup

    slabtop                 # 内核片缓存信息
    mpstat                  # cpu统计信息
    lxtask                  # 监控内存

    xgamma -gamma .75       # 调整屏幕色值

    amixer set Master 100%  # 调节音量
    alsamixer               # 调节声音
    powertop                # intel电源管理


    lspci
    lsusb
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
## 进程
    pidstat                 # 进程使用资源的情况
    ps
        aux                 # 用在unix style中, BSD格式显示
        ef                  # 用在system v style中, 标准格式显示
    pstree                  # 进程关系
    pmap pid                # 进程

    kill 1024
        -9
            # 3 QUIT 退出(同ctrl + \)
            # 1 HUP 终端断线
            # 2 INT 中断(同ctrl + c)
            # 9 KILL 强制终止
            # 15 TERM 终止
            # 18 CONT 继续(与STOP相反, 同fg/bg)
            # 19 STOP 暂停(同ctrl + z)
        -l      # 列出所有信号名称和编号

    pkill Xorg              # kill 所有包含
    killall Xorg            # kill 所有包含
    xkill                   # 运行后 在xwindow点击kill窗口
## 网络
    mtr                     # myTrace, 合并ping与traceroute，默认发送ICMP包, 做持续探测, 避免节点波动的影响
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
    traceroute              # 做一次探测, 默认UDP包, 发包TTL值逐渐增大
        -I                  # 使用ICMP包
    ufw                     # 简化防火墙
    iptables
        -L                  # list 显示
        -n                  # 端口以数字显示
        -A                  # append, 添加
        -D                  # delete, 删除
        -p                  # 协议
        --dport             # 目标端口
        --sport             # 源端口
        -j                  # 跳转
            ACCEPT
            SNAT            # 只适用于POSTROUTING链，修改源地址
        -t                  # 要操作的匹配表
        -F                  # flush

        表
            filter          # 默认表
                INPUT       # 进入
                OUTPUT      # 出去
                FORWORD     # 通过
            nat             # 遇到产生新的连接的包
                PREROUTING  # 修改到来的包
                OUTPUT      # 修改路由前本地的包
                POSTROUTING # 修改准备出去的包
            mangle          # 指定包修改
                PREROUTING
                OUTPUT

        o->
        iptables -A INPUT -p tcp --dport 22 -j ACCEPT
        iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
        iptables -L -n
        service iptables save
        iptables -t nat -L  # 查nat表
        iptables -F

        配置文件
            /etc/sysconfig/iptables
            /usr/libexec/iptables/iptables.init
                save

        service iptables save
        service iptables restart            # 开放端口

        systemctl enable iptables.service

        iptables -A INPUT -p tcp --dport 3128 -j ACCEPT         # DROP
        iptables -A OUTPUT -p tcp --sport 3128 -j ACCEPT

        iptables -t nat -A POSTROUTING -s 192.168.252.0/24 -j SNAT --to-source 10.171.83.146
            # vpn服务器
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

    ping
    telnet
    nmblookup -A ip             # 查询域名
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
    route                   # 查看路由表
        -n                  # 不解析域名
    arp -n                  # 显示局域网 ip mac表
        -s ip mac           # 设置ip mac表
    tcpdump
        介绍
            抓包
        使用
            tcpdump -n -i eth0 host 192.168.31.147 and 114.114.114.114
                # 本机192.168.31.147与远程主机114.114.114.114的数据
            tcpdump -n -i eth0 dst 192.168.31.147
                #  进入本机192.168.31.147的数据
                # tcpdump -n -i eth0 dst 192.168.31.147 or 192.168.31.157 and tcp
                ## 进入两个本机的tcp包
                # and port !22
                ## 端口
            tcpdump -n -i eth0 src 192.168.31.147
                # 本机出去的包
    curl
        curl -v             # 详细头信息
        curl -H "Cookie: foo=bar; baz=val"          # 发送cookie
        curl -X post -k http://localhost:9090/a -H "Content-Type: text/plain" -d '{"name": "a"}'
            # post请求
        curl -O http://104.223.142.166/isu80        # 抓文件
    nc                      # netcat, 功能全面
        -U a.sock           # 指定socket
        -v                  # 显示详情
        -z                  # 只测试连通
        -u                  # 使用udp

        o-> 测试udp端口
        nc -vzu 127.0.0.1 1194
    dig                     # 域名解析
    nmap
        -sP ip/24           # 查看网内所有ip
    ip                      # 网卡与ip信息

    iotop                   # 实时监视io
    iostat                  # 负载情况
    lsof -i:8080            # 列出当前系统打开的文件，必须root运行才准确
    nicstat                 # 网络流量统计
    netstat
        -a                  # 显示所有
        -n                  # 显示数字，而不是别名
        -t                  # 仅显示tcp
        -u                  # 仅显示udp
        -p                  # 显示建立链接的程序名
        -l                  # 仅列出listen的服务
        -o                  # 显示timer, 如keepalive
        -antpu          # 端口
    ss                      # 端口，性能高
        -l                  # listening
    iwlist                  # 列出无线网
    iwconfig                # 无线网卡设置
    pppoe                   # 宽带
    w3m                     # 命令行浏览器

    ssh
    sshpass
        sshpass -p asdf ssh root@47.74.230.238
    sshfs -o allow_other root@ip:~ /mnt                 # 挂载远程目录
    scp a.txt root@ip:~
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
    wifi-menu
# 调度
    at                      # 某时间运行一次

    jobs                    # 后台作业
    fg                      # 后台作业调度到前台
    bg                      # 继续执行后台作业
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
# 包管理
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
                -i                      # 详情, 两个i显示备份文件和修改状态
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
            -Scc                                # 清除缓存
            -Qii zsh                            # 包信息
            -Ql zsh                             # 查看安装的文件
            -Qo /bin/zsh                        # 查看文件属于的包

        源
            mirrors.163.com
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
# init
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
        --list
# 编程
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

    bash
        set -o              # 设置快捷键模式，默认emacs
        快捷键
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
            <C-r> 查看历史
            <C-s> 冻结
            <C-q> 解冻
            <C-t> 交换字符
            <C-w> 删word
            <C-z> 暂停到后台
            <C-\> 中断
            <C-/> 撤消
            <C-_> 删除一行
            <M-r> 取消历史变更
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
    makepkg                 # 创建软件包

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
    配置
        .config/awesome/rc.lua
            Variable definitions            # 可定义布局优先级
            Menu                            # 右键菜单
            Wibar                           # 生成screen, 设壁纸
            Mounse bindings                 # 鼠标键绑定函数
            Key bindings                    # 快捷键
            Rules                           # client规则, 如在哪个screen显示
            Signals                         # client启动信号触发动作
            自定义
            awful.util.spawn_with_shell("~/.config/awesome/autorun.sh")
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
## 显示
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
# 方案
    命令组合                    # xargs sed | grep awk
        grep                    # 去除某些 grep nginx | grep -v grep
    过滤进程并kill
        ps -ef|grep -v "grep"|grep aurora/app.js |awk '{print $2}'| xargs kill -9
            # grep -v 去掉包含"grep"的条目
            ## 因为ps执行时列出当前命令与命令内容，会影响后面的过滤
            # awk 取第二列(pid)的内容
            # xargs 将前面过滤后的内容作为参数，执行kill -9
    后台
        nohup *** > /dev/null &                 # 在脚本文件中写入^C可以使脚本执行完nohup退出(exit不可以)

    复制多个
        ls -rt | tail -4 | xargs -i cp -r {} ~/sdb/work/ryxWork/架构/

    替换文本
        sed -i "s/a/@/g" `grep -rl "a" ./`

    代码行数
        find -name "*.go" -or -name "*.py" |xargs grep -v "^$" |wc -l

    lib设置
        /etc/ld.so.conf加入so文件的配置路径如:/usr/local/lib
        执行/sbin/ldconfig -v 更新

    unzip中转码
        unzip -P “$(echo 中文 | iconv -f utf-8 -t gbk)”

    切换登录
        sudo -i su outrun

    查找删除
        ls | grep '^Dar' | xargs rm

    爬网站
        wget -x -P curSite -r -l 100 -k -L -np http://nodeapi.ucdok.com/api/
        带cookie
            wget --post-data="username=u1&password=asdf" --save-cookies=cookie --keep-session-cookies "http://www.abc.com/logging.php"
            wget -x -P curSite -r -l 1 -k -L -np --load-cookies=cookie --keep-session-cookies "https://www.abc.com/display/1"
    递归查找所有内容
        grep -nr 'a' .

    终端录制
        script -t 2>timing.log -a output.log
        scriptreply timing.log output.log

    simplehttp
        python -m SimpleHTTPServer 8080
    无线热点
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
