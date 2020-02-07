# 基础
    历史
        40年代：汇编语言
        60年代：汇编语言unux
        70年代初：c语言、c语言unux、unux开源（美国反垄断法制裁AT&T）
        70年代末：AT&T分裂，unix闭源
        80年代：minix
        90年代：linux  # 80、90年代之间：gun计划
    文件权限
        drwxr-xr-x  # d代表目录
        lrwxrwxrwx  # l代表软连接
        drwxrwxrwt  # 末尾的t代表粘滞位(sticky bit)，用户只能删除自己建东西
                    ## chmod 1777来设置
    扩展名
        .bin
            # 二进制可执行文件，加上执行权限./执行即可
        .tar.gz
            # gzip压缩,tar打包的文件
        .tar.tgz
            ＃ 同gzip
        .tar.bz2
        .tar.xz
    环境变量
        http_proxy=http://1.1.1.1：8082         # http代理
        https_proxy=http://1.1.1.1：8082        # https代理
        no_proxy='m.test.com,127.0.0.1'         # 代理白名单

        PATH                                    # 命名查找路径
        SHELL                                   # shell命令位置
        PWD                                     # 当前用户目录
        HOME                                    # 同上
        LOGNAME                                 # 用户名
        USER                                    # 同上
        LANG                                    # 语言环境
        _                                       # 查看环境变量的命令
# 文件位置
    /var
        /log
            /boot.log                           # 启动日志
    /proc
        /[pid]
            /status                             # 任务虚拟地址空间的大小 VmSize, 应用程序正在使用的物理内存的大小 VmRSS
    /etc
        /sudoers
            outrun ALL=(ALL) NOPASSWD:ALL
        /passwd
        /group
        /resolv.conf                            # dns
            nameserver 223.5.5.5
            nameserver 223.6.6.6                # alidns
        /sysconfig
            /network-scripts/ifcfg-eth0         # 永久修改网卡
                DEVICE=eth0                     # 设备别名
                BOOTPROTO=static                # 网卡获得ip地址的方式，默认dhcp
                HWADDR=00:00:00:00:00:00        # mac
                IPADDR=192.168.0.100            # ip
                NETMASK=255.255.255.0           # netmask
                ONBOOT=yes                      # 系统启动时是否激活此设备
            /network                            # 修改网关
                NETWORKING=yes                  # 系统是否使用网络
                HOSTNAME=abc                    # 设置本机主机名, 要与/etc/hosts中设置的主机名相同
                GATEWAY=192.168.0.1             # 网关ip
            /selinux                            # 软连接到../selinux/config
                SELINUX=disabled                # 关闭selinux
        /selinux/config                         # selinux
            SELINUX=enforcing                   # disabled 为关闭
        /systemd
            /logind.conf                        # 电源管理配置
                HandleLidSwitch=ignore          # 关闭盖子不执行操
            /system                             # units位置
                /default.target                 # 启动级别
        /security
            /limits.conf                        # 设置系统限制，如文件句柄数
        /issue                                  # 发行版信息
        /hosts                                  # 修改localhost
        /ld.so.conf                             # lib设置,加入so文件的配置路径如:/usr/local/lib
            执行/sbin/ldconfig -v 更新
        /profile                                # 用户登录时加载的环境变量
        /inittab                                # 设置启动级别
            id:3:initdefault:
    /usr
        /lib
            /systemd
                /system                         # units位置
        /share
            /applications                        # desktop文件
    /run
        /systemd
            /system                             # units位置
    /sys
        /class
            /backlight
                /acpi_video0                    # ati显卡是acpi_video0, intel显卡是intel_backlight
                    /brightness                 # 修改亮度
    ~
        /.bash_profile
        /.bash_login
        /.profile                               # 在登录时执行一次, 先.bash_profile, 再bash_login, 再.profile
        /.bashrc
        /.bash_logout
        /.local
            /share
                /applications                   # desktop文件


    initd
        /etc/rc.d/init.d/rc.local
            chmod +x rc.local
            ln -sf ../init.d/rc.local rc0.d/S999rc.local
            ln -sf ../init.d/rc.local rc1.d/S999rc.local
            ln -sf ../init.d/rc.local rc2.d/S999rc.local
            ln -sf ../init.d/rc.local rc3.d/S999rc.local
            ln -sf ../init.d/rc.local rc4.d/S999rc.local
            ln -sf ../init.d/rc.local rc5.d/S999rc.local
            ln -sf ../init.d/rc.local rc6.d/S999rc.local
                # 文件名中S表示传递start参数(K表示stop), 999为启动级别



    fstab
        /dev/sda1 /home/outrun/sda1 ntfs-3g defaults 0 0


    日志
        access-log      # http传输
        acct和pacct     # 用户命令
        aculog          # modem活动
        btmp            # 失败记录
        lastlog         # 最近成功登录、最后一次不成功登录
        syslog          # 系统日志
        messages        # syslog
        sudolog         # sudo记录
        sulog           # su记录
        utmp            # 当前登录用户
        wtmp            # 用户登录登出记录
        xferlog         # ftp会话
# 设置
    lib设置
        /etc/ld.so.conf加入so文件的配置路径如:/usr/local/lib
        执行/sbin/ldconfig -v 更新
# 系统编程
## 进程通信
    对象
        ipc
    种类
        消息队列
        共享内存
        信号量
    消息队列
## 错误处理
    curedump机制, 产生core文件
    命令
        ulimit
    目录
        /proc/[pid]/
## fork
    介绍
        子线程
## epoll
    介绍
        多路复用io接口，提高大量并发连接中只有少量活跃情况下系统cpu利用率
## signals
    介绍
        unix系统中出错时显示的错误码（通常是拼在最后）
        http://people.cs.pitt.edu/~alanjawi/cs449/code/shell/UnixSignals.htm
    SIGHUP	1	Exit	Hangup
    SIGINT	2	Exit	Interrupt
    SIGQUIT	3	Core	Quit
    SIGILL	4	Core	Illegal Instruction
    SIGTRAP	5	Core	Trace/Breakpoint Trap
    SIGABRT	6	Core	Abort
    SIGEMT	7	Core	Emulation Trap
    SIGFPE	8	Core	Arithmetic Exception
    SIGKILL	9	Exit	Killed
    SIGBUS	10	Core	Bus Error
    SIGSEGV	11	Core	Segmentation Fault
    SIGSYS	12	Core	Bad System Call
    SIGPIPE	13	Exit	Broken Pipe
    SIGALRM	14	Exit	Alarm Clock
    SIGTERM	15	Exit	Terminated
    SIGUSR1	16	Exit	User Signal 1
    SIGUSR2	17	Exit	User Signal 2
    SIGCHLD	18	Ignore	Child Status
    SIGPWR	19	Ignore	Power Fail/Restart
    SIGWINCH	20	Ignore	Window Size Change
    SIGURG	21	Ignore	Urgent Socket Condition
    SIGPOLL	22	Ignore	Socket I/O Possible
    SIGSTOP	23	Stop	Stopped (signal)
    SIGTSTP	24	Stop	Stopped (user)
    SIGCONT	25	Ignore	Continued
    SIGTTIN	26	Stop	Stopped (tty input)
    SIGTTOU	27	Stop	Stopped (tty output)
    SIGVTALRM	28	Exit	Virtual Timer Expired
    SIGPROF	29	Exit	Profiling Timer Expired
    SIGXCPU	30	Core	CPU time limit exceeded
    SIGXFSZ	31	Core	File size limit exceeded
    SIGWAITING	32	Ignore	All LWPs blocked
    SIGLWP	33	Ignore	Virtual Interprocessor Interrupt for Threads Library
    SIGAIO	34	Ignore	Asynchronous I/O
## pf-kernel
    介绍
        是linux kernel 的fork, pf代表post-factum, 是作者的nickname
## libev
    libevent
        介绍
            是linux kernel 的fork, pf代表post-factum, 是作者的nickname
# 发行版
    lfs
    coreos
    arch
    fedora
    debian
    gentoo
    opensuse
    mint
## centos
    安装VBoxAdditions
        yum update kernel
        yum install kernel-headers kernel-devel gcc
        # 可能要加软连接 /usr/src/kernels/
        mount /dev/cdrom /mnt
        /mnt/VBoxLinuxAdditions.run

## fedora
    升级
        fedup --network 21
        或
        fedora-upgrade
    升级21
        rpm --import https://fedoraproject.org/static/95A43F54.txt
        yum update yum
        yum clean all
        yum --releasever=21 distro-sync --nogpgcheck
    group
        yum grouplist
        yum groupinstall "X Window System"
        yum groupinstall "GNOME Desktop Environment"
        yum groupinstall "KDE"

    gnome的快捷方式存放地址
    安装unity  
        cd /etc/yum.repos.d/
        wget http://download.opensuse.org/repositories/GNOME:/Ayatana/Fedora_17/GNOME:Ayatana.repo
        yum install unity
## arch
    设置
        ahci, secure boot, post behavious thorough
    源
        vim /etc/pacman.d/mirrorlist
        pacman -Syy
    依赖
        base-devel
    分区
        # mount -t efivarfs efivarfs /sys/firmware/efi/efivars
                # 判断efi
        cfdisk
        mkfs.vfat -F32 /dev/nvme0n1p1
                # 或直接使用windows的uefi分区
        mkfs.ext4 /dev/nvme0n1p2
        mkswap /dev/nvme0n1p3
        swapon /dev/nvme0n1p3
        mount /dev/nvme0n1p2 /mnt
        mkdir -p /mnt/boot/EFI
        mount /dev/nvme0n1p1 /mnt/boot/EFI
    配置
        pacstrap -i /mnt base
        genfstab -U -p /mnt >> /mnt/etc/fstab
        arch-chroot /mnt /bin/bash
        pacman -S dialog wpa_supplicant vim 
        vim /etc/locale.gen
        locale-gen
        echo LANG=en_US.UTF-8 > /etc/locale.conf
        ls -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
        hwclock --systohc --utc
        echo outrun > /etc/hostname
    grub
        pacman -S dosfstools grub os-prober efibootmgr
                # bios下 grub os-prober 
        grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=grub
        grub-mkconfig -o /boot/grub/grub.cfg
    用户
        passwd
        groupadd outrun
        useradd -m -g users -G outrun -s /usr/bin/bash outrun
        passwd outrun
        vim /etc/sudoers
    退出
        exit
        umount -R /mnt
        reboot
    桌面
        pacman -S xorg-server xorg-apps xorg xorg-xinit
        pacman -S xf86-video-intel mesa xf86-input-synaptics
        pacman -S gnome
        echo exec gnome-session > .xinitrc
        # systemctl enable gdm
        /etc/modprobe.d/blacklist_nouveau.conf中写blacklist nouveau
        /etc/modprobe.d/modprobe.conf中写blacklist nouveau
        pacman -S ttf-dejavu wqy-microhei
    network
        pacman -S networkmanager-openvpn
        systemctl enable NetworkManager
    yaourt
        vim /etc/pacman.conf
            [archlinuxfr]
                SigLevel = Never
                Server = http://repo.archlinux.fr/$arch
        pacman -Sy base-devel yaourt
    字体
        wiki上找font configuration
# 方案
## 高并发
    查看当前TCP连接的状态和对应的连接数量：
        netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
            # TIME_WAIT占用端口会影响后继新连接
    初步优化（提升服务器的负载能力之外，还能够防御小流量程度的DoS、CC和SYN攻击。）
        /etc/sysctl.conf
            net.ipv4.tcp_syncookies = 1
                # 表示开启SYN Cookies。当出现SYN等待队列溢出时，启用cookies来处理，可防范少量SYN攻击，默认为0，表示关闭；
            net.ipv4.tcp_tw_reuse = 1
                # 表示开启重用。允许将TIME-WAIT sockets重新用于新的TCP连接，默认为0，表示关闭；
            net.ipv4.tcp_tw_recycle = 1
                # 表示开启TCP连接中TIME-WAIT sockets的快速回收，默认为0，表示关闭；
            net.ipv4.tcp_fin_timeout = 30
                # 修改系統默认的 TIMEOUT 时间。
        sysctl -p       # 生效
    大流量下的优化
        # 如果你的连接数本身就很多，我们可以再优化一下TCP的可使用端口范围，进一步提升服务器的并发能力
        /etc/sysctl.conf
        net.ipv4.tcp_keepalive_time = 1200
            # 表示当keepalive起用的时候，TCP发送keepalive消息的频度。缺省是2小时，改为20分钟。
        net.ipv4.ip_local_port_range = 10000 65000
            # 表示用于向外连接的端口范围。缺省情况下很小：32768到61000，改为10000到65000。（注意：这里不要将最低值设的太低，否则可能会占用掉正常的端口！）
        net.ipv4.tcp_max_syn_backlog = 8192
            # 表示SYN队列的长度，默认为1024，加大队列长度为8192，可以容纳更多等待连接的网络连接数。
        net.ipv4.tcp_max_tw_buckets = 6000
            # 表示系统同时保持TIME_WAIT的最大数量，如果超过这个数字，TIME_WAIT将立刻被清除并打印警告信息。默 认为180000，改为6000。对于Apache、Nginx等服务器，上几行的参数可以很好地减少TIME_WAIT套接字数量，但是对于Squid，效果却不大。此项参数可以控制TIME_WAIT的最大数量，避免Squid服务器被大量的TIME_WAIT拖死。
    其它参数说明
        net.ipv4.tcp_max_syn_backlog = 65536
            # 记录的那些尚未收到客户端确认信息的连接请求的最大值。对于有128M内存的系统而言，缺省值是1024，小内存的系统则是128。
        net.core.netdev_max_backlog = 32768
            # 每个网络接口接收数据包的速率比内核处理这些包的速率快时，允许送到队列的数据包的最大数目。
        net.core.somaxconn = 32768
            # web应用中listen函数的backlog默认会给我们内核参数的net.core.somaxconn限制到128，而nginx定义的NGX_LISTEN_BACKLOG默认为511，所以有必要调整这个值。
        net.core.wmem_default = 8388608
        net.core.rmem_default = 8388608
        net.core.rmem_max = 16777216           #最大socket读buffer,可参考的优化值:873200
        net.core.wmem_max = 16777216           #最大socket写buffer,可参考的优化值:873200
        net.ipv4.tcp_timestsmps = 0
            # 时间戳可以避免序列号的卷绕。一个1Gbps的链路肯定会遇到以前用过的序列号。时间戳能够让内核接受这种“异常”的数据包。这里需要将其关掉。
        net.ipv4.tcp_synack_retries = 2
            # 为了打开对端的连接，内核需要发送一个SYN并附带一个回应前面一个SYN的ACK。也就是所谓三次握手中的第二次握手。这个设置决定了内核放弃连接之前发送SYN+ACK包的数量。
        net.ipv4.tcp_syn_retries = 2
            # 在内核放弃建立连接之前发送SYN包的数量。
        #net.ipv4.tcp_tw_len = 1
        net.ipv4.tcp_tw_reuse = 1
            # 开启重用。允许将TIME-WAIT sockets重新用于新的TCP连接。
        net.ipv4.tcp_wmem = 8192 436600 873200
            # TCP写buffer,可参考的优化值: 8192 436600 873200
        net.ipv4.tcp_rmem  = 32768 436600 873200
            # TCP读buffer,可参考的优化值: 32768 436600 873200
        net.ipv4.tcp_mem = 94500000 91500000 92700000
            # net.ipv4.tcp_mem[0]:低于此值，TCP没有内存压力。
            # net.ipv4.tcp_mem[1]:在此值下，进入内存压力阶段。
            # net.ipv4.tcp_mem[2]:高于此值，TCP拒绝分配socket。
            # 上述内存单位是页，而不是字节。可参考的优化值是:786432 1048576 1572864
        net.ipv4.tcp_max_orphans = 3276800
            # 系统中最多有多少个TCP套接字不被关联到任何一个用户文件句柄上。
            # 如果超过这个数字，连接将即刻被复位并打印出警告信息。
            # 这个限制仅仅是为了防止简单的DoS攻击，不能过分依靠它或者人为地减小这个值，
            # 更应该增加这个值(如果增加了内存之后)。
        net.ipv4.tcp_fin_timeout = 30
            #如果套接字由本端要求关闭，这个参数决定了它保持在FIN-WAIT-2状态的时间。对端可以出错并永远不关闭连接，甚至意外当机。缺省值是60秒。2.2 内核的通常值是180秒，你可以按这个设置，但要记住的是，即使你的机器是一个轻载的WEB服务器，也有因为大量的死套接字而内存溢出的风险，FIN- WAIT-2的危险性比FIN-WAIT-1要小，因为它最多只能吃掉1.5K内存，但是它们的生存期长些。

        sysctl -w fs.file-max=12000000
        sysctl -w fs.nr_open=11000000

        /etc/security/limits.conf
            nofile=10000000         # 文件句柄数
