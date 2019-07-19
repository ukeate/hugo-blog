
# 历史
    40年代：汇编语言
    60年代：汇编语言unux
    70年代初：c语言、c语言unux、unux开源（美国反垄断法制裁AT&T）
    70年代末：AT&T分裂，unix闭源
    80年代：minix
    90年代：linux  # 80、90年代之间：gun计划
# 文件位置
    /var
        /log
            /boot.log   # 启动日志
    /proc
        /[pid]
            /status # 任务虚拟地址空间的大小 VmSize, 应用程序正在使用的物理内存的大小 VmRSS
    /etc
        /sudoers
        /group
        /passwd
        /resolv.conf
            # dns
            nameserver 223.5.5.5
            nameserver 223.6.6.6    # alidns
        /sysconfig
            /network-scripts/ifcfg-eth0
            # 永久修改ip
            DEVICE=eth0 # 设备别名
            BOOTPROTO=static    # 网卡获得ip地址的方式，默认dhcp
            HWADDR=00:00:00:00:00:00    # mac
            IPADDR=192.168.0.100    # ip
            NETMASK=255.255.255.0   # netmask
            ONBOOT=yes  # 系统启动时是否激活此设备
            /network    # 修改网关
            NETWORKING=yes  # 系统是否使用网络
            HOSTNAME=abc    # 设置本机主机名, 要与/etc/hosts中设置的主机名相同
            GATEWAY=192.168.0.1 # 网关ip
        /systemd
            /logind.conf
                # 电源管理配置
                HandleLidSwitch=ignore  # 关闭盖子不执行操
            /system
                # units位置
                /default.target # 启动级别
        /issue
            # 发行版信息
        /hosts
            # 修改localhost
        /ld.so.conf
            # lib设置,加入so文件的配置路径如:/usr/local/lib
            执行/sbin/ldconfig -v 更新
        /profile
            # 用户登录时加载的环境变量
        /inittab
            # 设置启动级别
            id:3:initdefault:
        /selinux/config
            SELINUX=enforcing
                # disabled 为关闭
    /usr
        /lib
            /systemd
                /system # units位置
    /run
        /systemd
            /system # units位置
    /sys
        /class
            /backlight
                /acpi_video0
                    /brightness # 修改亮度
## initd
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
## fstab
    /dev/sda1 /home/outrun/sda1 ntfs-3g defaults 0 0
## 日志
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

# 原理
## 约定
    权限
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
## 错误处理
    curedump机制
    命令
        ulimit
    目录
        /proc/[pid]/
## 内核
### fork
    介绍
        子线程
### epoll
    介绍
        多路复用io接口，提高大量并发连接中只有少量活跃情况下系统cpu利用率
### signals
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
### pf-kernel
    介绍
        是linux kernel 的fork, pf代表post-factum, 是作者的nickname
### libev
    libevent
        介绍
            是linux kernel 的fork, pf代表post-factum, 是作者的nickname
## 进程通信
    对象
        ipc
    种类
        消息队列
        共享内存
        信号量
    消息队列
# 发行版
    lfs
    centos
    coreos
    arch
    fedora
    debian
    gentoo
    opensuse
    mint
## fedora
    升级
        fedup --network 21
        或
        fedora-upgrade
    升级21
        # rpm --import https://fedoraproject.org/static/95A43F54.txt
        # yum update yum
        # yum clean all
        # yum --releasever=21 distro-sync --nogpgcheck
    group
        #yum grouplist
        #yum groupinstall "X Window System"
        #yum groupinstall "GNOME Desktop Environment"
        #yum groupinstall "KDE"

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
