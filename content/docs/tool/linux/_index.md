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
        /loadavg                                # 1分钟、5分钟、15分钟平均负载。运行队列进程数/进程总数。最后一个进程id
    /etc
        /etc/fstab
            /dev/nvme0n1p5 /home ext4 defaults 0 2
            /dev/nvme0n1p3 /home/outrun/nvme0n1p3 ntfs-3g defaults 0 0

            # /dev/nvme0n1p6
            UUID=b00fac49-46d7-43ef-aea7-256d82b862b2	/         	ext4      	rw,relatime,data=ordered	0 1

            # /dev/nvme0n1p1 LABEL=ESP
            UUID=FE8F-730F      	/boot/EFI 	vfat      	rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro	0 2
        /sudoers
            outrun ALL=(ALL) NOPASSWD:ALL
        /passwd
        /group
        /resolv.conf                            # dns
            nameserver 223.5.5.5
            nameserver 223.6.6.6                # alidns
            nameserver 114.114.114.114
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
                /docker.service.d/http-proxy.conf                           # docker代理
                    Environment="HTTP_PROXY=http://127.0.0.1:8123"
                        "HTTPS_PROXY=http://127.0.0.1:8123"
                        "NO_PROXY=192.168.1.1,localhost"
        /security
            /limits.conf                        # 设置系统限制，如文件句柄数
        /X11
            /xorg.conf.d/70-synaptics.conf      # 触摸板设置
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

# 发行版
    lfs
    coreos
    debian
    gentoo
    opensuse
    mint
## centos
    包
        dnf install @development-tools
        yum install epel-release
    安装VBoxAdditions
        yum update kernel
        yum install kernel-headers kernel-devel gcc
        # 可能要加软连接 /usr/src/kernels/
        mount /dev/cdrom /mnt
        /mnt/VBoxLinuxAdditions.run
    gcc升级
        yum -y install centos-release-scl
        yum -y install devtoolset-6-gcc devtoolset-6-gcc-c++ devtoolset-6-binutils
        scl enable devtoolset-6 bash
        echo "source /opt/rh/devtoolset-6/enable" >>/etc/profile
## ubuntu
    包
        apt-cache madison xxx       # 查看仓库中所有版本
        apt-cache search xxx
        apt-get -f -y --assume-yes install
        aptitude
            search
            show
            install
            remove 
            purge                   # 删除包及配置
            clean                   # 删除下载的包文件
            autoclean               # 仅删除过期
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
    AUR
        git clone https://aur.archlinux.org/snapd.git
        cd snapd
        makepkg -si
        sudo systemctl enable --now snapd.socket
