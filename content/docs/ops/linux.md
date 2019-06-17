---
Categories: ["运维"]
title: "Linux"
date: 2018-10-11T18:47:57+08:00
---

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
# 方案
    命令组合
        # xargs sed | grep awk
        grep
            # 去除某些 grep nginx | grep -v grep
    过滤进程并kill
        ps -ef|grep -v "grep"|grep aurora/app.js |awk '{print $2}'| xargs kill -9
            # grep -v 去掉包含"grep"的条目
            ## 因为ps执行时列出当前命令与命令内容，会影响后面的过滤
            # awk 取第二列(pid)的内容
            # xargs 将前面过滤后的内容作为参数，执行kill -9
    后台
        nohup *** > /dev/null &
            # 在脚本文件中写入^C可以使脚本执行完nohup退出(exit不可以)

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
        wget -x -P curSite -r -l 100 -k -p -L -np http://nodeapi.ucdok.com/api/

    递归查找所有内容
        grep -nr

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
            option domain-name-servers 192.168.0.1,8.8.8.8; # 自己的dns提供商
            option routers 192.168.0.42;    # 本机ip
            option domain-name "mydhcp";
            option domain-name-servers 192.168.0.1;
            log-facility local7;
            subnet 192.168.0.0 netmask 255.255.255.0 {
                range  192.168.0.160 192.168.0.170;
                option broadcast-address 192.168.0.255;
            }
# 工具
## 内核
    modprobe vboxdrv
        # 内核
    lsmod                                                                
        # 显示当前系统加载的模块，如systemctl中start了的模块
    sysdig
        sysdig
            -c
                topprocs_cpu
                    # 进程cpu top
                    evt.cpu=0
                        # 只统计cpu0
                topprocs_net
                    # 进程带宽 top
                topprocs_file
                    # 进程硬盘i/o top
                topfiles_bytes
                    # 文件读写 top
                    proc.name=httpd
                        # 指定进程名
                topfiles_time
                    # 文件时间 top
                topprocs_errors
                    # 进程error top
                topfiles_errors
                    # 文件error top
                topscalls_time
                    # 系统调用时间 top
                topscalls "evt.failed=true"
                    # 系统调用出错 top
                topconns
                    # 网络连接 top
                fdcount_by
                    proc.name "fd.type=file"
                        # 进程文件描述符
                fdbytes_by
                    fd.directory "fd.type=file"
                        # 目录读写 top
                    fd.filename "fd.directory=/tmp/"
                        # /tmp目录文件 读写top
                    fd.type
                        # fd type i/o
                echo_fds "fd.filename=passwd"
                    # 所有名为passwd文件的i/o
                stdout
                    proc.name=bash
                        # 进程标准输出
                fileslower 1
                    # 文件i/o 大于1ms
                spy_users
                    # 命令执行情况
                    
            -A
                # 只显示可读数据
            -s 4096
                # 指定 data buffer 字节
            -r trace.scap
                #  指定trace file
            -pc
                # 详情 
        csysdig
            # 交互式工具
            -vcontainers
                # 容器资源
            -pc
                # 详情
## 文件
    rm -rf
    touch
        -t 0712250000 file
            # 修改文件时间戳(YYMMDDhhmm)
    ls *[0-9]*
        -R
            # 递归显示文件
        -l
            # 详情
        -S
            # 按大小排列
        -r
            # reverse
        -h
            # 自动大小单位
        -F
            # 加后缀标识类型
    tree
    mkdir 
    rmdir
    cd
        ~
        -
    cp
        -a
            # 带权限复制
    mv
    find .
        maxdepth 1
        -name "*.go"
        -type f
        -atime +100
            # 100天未使用过的执行文件
        -mtime -10
            # 10天内创建或修改的文件
        -exec chmod +x
            # 对找到的文件执行命令
        -xdev
            # 忽略块设备
    pwd
    file
        # 探测文件类型
    ln
    du -d 1 -h
        -s
            # 只返回汇总情况
        -k
            # 统一单位
    chmod ugo+rwx
        # 所有人(u), 群组(g), 其他人(o)以读、写、执行权限
    chattr +i file
        # 改变属性
    lsattr file
    chown -R outrun:outrun .
    chgrp -R outrun .
    getfacl
        # 查看一个文件的ACL设置
    setfacl
        -m u:linuxcast:rwx   filename
            # 配置用户权限
        -m g:linuxcats:r-x  filename
            # 配置组的权限
        -x u:linuxcast filename
            # 删除一个ACL设置

    mucommander
        # 跨平台文件管理软件

    cat
    tac
        # 倒转行显示
    wc
        # 统计行, 单词, 字符
    grep
    awk
    sort
        -r
            # reverse
        -n
            # 显示行号
    more
    less

    iconv
        -l
            # 列出已知的编码
        -f gbk -t utf-8 -c orig.txt -o tgt.txt
            # 转码
    tar xf
        zcvf x.tar.gz x
            # 压缩
        zxvf x.tar.gz
            # 解压
        --exclude=/proc
    gzip x
        # 压缩
        -d x
            # 解压
    unzip
    unzip-beta
        # 解压并转码中文
    head -2
    tail -2
        -f
    paste file1 file2
        # 合并两个文件或两栏内容
        -d '+'
            # 分隔符
    nano
### vim
    命令
        vim -u NONE -N
            # -u NONE 不加载配置文件和插件，并进入vi兼容模式, -N set nocompatible，不进入vi兼容模式
            # -u code/essential.vim 加载指定配置文件
    编译
        --with-features=tiny
            # 只包含最基本功能。small, normal, big, huge
            # :h feature-list查看
#### mode
    普通模式
    插入模式
    可视模式
        v/V
            # 面向字/面向行 可视模式
        <C - v>
            # 面向块 可视模式
        gv
            # 重选上次选区
        o
            # 切换到选区的开头, 再按切换回尾端　
    替换模式
        R
    命令行模式(Ex命令)
        :
            # 可视模式中选定范围，切换到命令行时，自动输入range'<,'>代表选中区
    操作符待决模式
        # operator 与 motion之间的空闲时期
        # 两个字符的operator, 字符间的空闲时期不是该模式，是命名空间，是普通模式的扩充
        # 有了这个模式，能创建自定义映射项来激活或终结操作符待决模式，就可以自定义operator和motion
    选择模式
        # 类似windows中选中
        <C - g>在可视和选择模式切换

    历史
        q:
            # 命令历史
        q/
            # 搜索历史
#### operate
    思想
        {operator}{motion}
        {operator}{text-objects}
    shortcut key
        ctrl + c                # 同Esc
    motions
        .               # 重复前一次修改, 目标做到一键移动，一键执行
                        ## 修改是指: 
                        ### 一个normal模式下的按键, 插入内容, <ESC>
                        ### 一组normal模式下按键
        K
            # 当前单词的:h 手册
        ga
            # 当前字符的unicode码
    Ex command
        # 可视模式下选中行, : 时前面有'<,'> 表示对选中的行执行操作
        :h e/:help e
            # 查看e的帮助
            # :h vimtutor 查看教程
            # :h operator 查看operator
            # :h :map-operator 查看自定义operator
            # :h omap-info 查看自定义motion
            # :h digraphs-default
            # :h digraphs
            # :h digraphs-table 查看二合字符表
            # :h ex-cmd-index 查看所有Ex命令
            # :h vi-differences vim 相对vi的特性
        :version
            # 查看版本和支持的功能
        :! command 
            # 执行某shell命令(CR返回)
            # !! 执行前一个命令
            # r!command 执行结果插入当前位置
            # w!command 当前文件作为输入执行
        :cd directory        
            # 修改工作目录
        :sh
            # 跳到shell, 再执行exit返回
        :map bbc ia        
            # 定义命令序列ia的别名为bbc
        :pwd
            # 显示当前目录
        :normal A;
            # 执行普通模式命令A;, 添加分号到行尾
        系统命令
            :grep t *
                # 在当前所有文件中匹配t, 自动加-n参数(显示行号)
            :ls
#### locate oper
    motion
        ^/$/0/<home>/g_/h/l/j/k/w/W/e/E/b/B/ge/gE/gg/G/[[/]]/(/)/{/}/nH/M/nL/点鼠标
            # 移动motion
            ## ge同b, 停在单词尾部
            ## <home>同0, 到行开始, ^则到本行第一个字符
            ## gg同[[，G同]]，10G跳到第10行
            ## fx 移动到下一个x, F反向查找, tx 移动到x的前一个字符
            # nG 跳到第n行
        f/F/t/T
            # 行搜索motion         重复查找(以相反方向重复搜索)
        ;
            # 重复移动上次f/F/t/T的字符
        ,
            # 撤销上次f/F/t/T移动
        *
            # 查找当前词
        nzz/nz-
            # 跳到指定行, 显示在屏幕中间/底部
            # zz 当前屏幕到中间
        可视模式
            $
                # 块可视模式中，表示所有行尾
            i/a
                # 块可视模式中有不同含义
    operator
        3G
            # 跳到第3行
        /text　　                                
            # 查找text，按n健查找下一个，按N健查找前一个。
        ?text　　                                
            # 查找text，反向查找，按n健查找下一个，按N健查找前一个。
        *或#
            # # *相当于/，#相当于?
            # g* 搜索子串         
            # gd  同* 但跳到第一个匹配序列        
        %
            # 搜索对应括号

        o-> marks
        ``
            # 跳回
            ## `" 最后编辑的位置
            ## `[ 最后修改的开始位置
            ## `] 最后修改的结束位置
            ## '. `. 跳到上次编辑位置
        ''                         
            # 跳回到第一个非空白字符
        marks
            # 显示系统全部书签
        ma
            # mark当前光标位置为a，小写字母不同文件标记不同行
            ## 大写字母全局标记，但webstorm中ideaVim不行
        `a
            # 跳到a的位置
    Ex command
        :10       
            # 跳到第10行, 同10G                
            # 0位于第一行上方
        :jumps
            # 输出能跳往的位置列表，可跳转多个文件
        :$
            # 文件结尾
        :.
            # 当前位置
        :%
            # 文件中的所有行
        :'<
            # 选中区开始
        :'>
            # 选中区结尾
        :'m
            # 位置标记为m的行
        :/<html>/,/<\html>/
            # 模式匹配范围
        : 1+1, 5-1
            # 开始向下偏移一行，结尾向上偏移一行
        :vim[grep] abc test
            # 在test文件中grep匹配abc
    shortcut key
        <c - e>/y 
            # 向下/上滚动一行
        <c - d>/u 
            # 向下/上滚动半屏
        <c - f>/b 
            # 向下/上滚动一屏
        <c - i>/o 
            # 到下个/上个跳动过的位置
#### edit oper
    shortcut key
        <C - r>                 # 撤销的撤销
        <C - a>/x
            # 数字增加/减少1, 对0开关数字进行八进制操作, 0x进行十进制操作。可以设置nrformats改变
        插入模式/命令模式
            <C - h>
                # 删除前一个字符
            <C - w>
                # 命令模式可用，删除前一个单词
            <C - u>
                # 命令模式可用，删至行首
            <C - [>
                # 返回普通模式
            <C - o>
                # 到插入-普通模式
            <C - v>
                # 命令模式可用，插入编码对应的字符
                065
                    # 两位的编码
                u00bf
                    # 超过3位的unicode码
                非数字
                    # 直接插入, 如expandtab开启后插入tab
            <C - k>{char1}{char2}
                # 命令模式可用，插入以二合字母表示的字符
                12
                <<
                ?I
            <C - r>{register}
                # 命令模式可用，插入寄存器内容
        补全
            <C - n>/p
                # 自动补全下/上
            
            <C - x> 接着按如下
                #-> <C - L>                        # 整行补全
                #-> <C - N>                        # 根据当前文件里关键字补全
                #-> <C - K>                        # 根据字典补全
                #-> <C - T>                        # 根据同义词字典补全
                #-> <C - I>                       # 根据头文件内关键字补全
                #-> <C - ]>                        # 根据标签补全
                #-> <C - F>                        # 补全文件名
                #-> <C - D>                        # 补全宏定义
                #-> <C - V>                        # 补全vim命令
                #-> <C - U>                        # 用户自定义补全方式
                #-> <C - S>                        # 拼写建议
    operator                        
        # num + operator 来多次操作
        # 合并命令如A(同$a), 是为了普通模式下一个按键进行插入，这样能够在.命令中重复
        @:
                # 重复Ex命令
        &
                # 重复substitute命令
        x/X
                # 删除当前字符/删除前一个字符， x等于dl，X 等于dh
        u/U
                # 撤销(Undo)/撤销对整行的操作
        r/R
                # 替换一个字符/持续替换字符，tab是一个字符
                gR
                        # 一个tab由tabstop个字符才能替换
                gr
        y/yy/Y                
                # yank 复制/复制一行/同yy
                ## :y
        p/P
                # 粘贴/前面粘贴
                ## :p
        a/A
                # s当前字符后插入
                # A同$a, 行尾插入
        o/O
                # o同A<CR>, 向后插入行
                # O同ko, 向前插入行
        s/S
                # s同cl, 替换当前字符
                # S同^C, 替换当前行
        i/I
                # i当前字符前插入
                # I同^i, 行首插入
        c/cc/C
                # 替换/替换一行/同cc
                ## :0,10c 与 :c
                ## C同c$
        d/dd/D
                # dd 同 :d。10d表示删除10行
                ## D表示删到行尾，同d$
                ## :0,10d 与 :d
        <</>>
                # 可视模式下 </>
                # 命令下 1>>2 表示从1行开始, 作用2行>>, 可以1>>>>2
                # 1,2> 表示 1到2行>>, 可以1,2>>
                # >G 缩进当前到最后一行
        =
                # 自动缩进
                # == 自动缩进当前行
        !
                # 用外部命令过滤指定行
                ## 如!j, 自动进入命令模式, 选定了指定行进行!
                # !!当前[count]行
        J
                # 删除当前行与下一行之间的换行
        g
                # :[range]global/{pattern}/{command} 
                ## global命令在[range]指定的文本范围内（缺省为整个文件）查找{pattern}，然后对匹配到的行执行命令{command}，如果希望对没匹配上的行执行命令，则使用global!或vglobal命令。
                ## g/^/m 0 倒序文件行
        g_
                # 到本行最后一个不是blank字符的位置
        gd
                # 智能跳到当前变量定义的位置
        gu/gU
                # 转换到小写/大写, 如gUw
                # gugu / guu / gUgU / gUU 
        g~
                # 大写转小写，小写转大写
                # g~g~ / g~~ 转换一行
        可视模式下
                U/u
                    # 大写/小写
    ex command
        :1,10 co 20
                # 将1-10行插入到第20行之后。
                ## :1,$ co $ 复制整个文件添加到尾部
        :1, 10 m 20
                # 第1-10行移动到第20行之后
        :ab attr attribute
                # 缩写, 输入模式中输入attr,再输入非字母字符(空格, 点等)，自动补全
                # ab查看所有缩写
                # una/unab attr 取消缩写　
        :!
                # 执行外部命令
        :[range]copy{address} /:t /:co
                # 复制range到address后
                # :t 2 表示复制当前行到第2行后
        :[range]move{address}
                # 移动
        :[range]join
                # 连接
        :[range]delete[x]
                # 删除指定范围内的行到寄存器中
        :[range]yank[x]
                # 复制
        :[line]put[x]
                # 指定行后粘贴寄存器中内容
        :[range]normal{commands}
                # 指定范围执行命令
        :[range]print / p
                # 在vim下方回显指定行的内容
    text-object
        i"
            ## " 表示 光标所在""的内容
            ## '
            ## `
            ## ) 表示 ()的内容
            ## ( 同上
            ## ]
            ## [
            ## >
            ## <
            ## }
            ## {
            ## B 表示 {}的内容
            ## t 表示 tag之间的内容，如<h2>aaaa</h2>
            ## w 表示 光标所在word
            ## s 表示 光标所在句子
            ## p 表示 段落
        a"
            # 包括外围，命令同i
        视图模式下
            vit                
                # 在可视模式下选中标签内容，如<a>xxx</a>的xxx
##### patterns oper
    operator
        &
            # 重复:s上次执行的命令, 不包含g
            # g& 全局重复:s上次的命令
        n/N
            # 查找下一个/上一个
    Ex command
        :[range]substitude/{pattern}/{string}/[flags]
            # :s 用new替换old，替换当前行的第一个匹配
            # 前面是正则, 用()分组，后面用\1引用分组
            # :s/old/new/g 作用到整行
            # :%s/old/new/ 作用到每行第一个
            # :10,20 s/^/    /g 作用到10到20行的每一个
            # :%s/old/new/g 作用到全文
            # :s/old/new/gc 每次修改前询问

        :[range]global/{pattern}/[cmd]    
            # :g 查找text的行执行命令,如:g/text/s/old/new/g
            # v/text/command 查找到行不执行命令,其它行执行
        :&
            # 同operator中&
#### registers oper
    register                        # 寄存器
        :reg                # 查看所有寄存器 或 :reg 1 查看寄存器1的内容
        "0p                # "0<operator> 粘贴寄存器0的内容
                        ## "0y 复制到寄存器0
        :pu 0                # 同上
                        # :pu! 0 同 "0P
        :y a                # 复制当前行到"a寄存器
                        ## :5,10y m 复制5到10行到"m寄存器
        分类
            ""        # unamed 缓存最后一次操作内容
            "0        # numbered 范围0 - 9 。"0缓存最近一次复制的内容
                    ## "1到"9缓存最近9次删除的内容, "9向后则丢弃
                    ## 第2次删除时，缓存1转存到缓存2, 新的删除内容存到缓存1
            "-        # small delete 缓存行内删除内容
            "a        # named 范围a - z 与 A - Z 
            ":        # read-only
                    ## 如 ": 最近命令 ". 最近插入文本 "% 当前文件名 "# 当前交替文件名
            "=        # expression 用于执行表达式命令，只读
            "*        # selection and drop
                    ## 如 "* "+ "~ 存取GUI选择文本，可用于与外部交互，要求系统剪切板(clipboard)可用 
            "_        # black hole 表示不缓存，干净删除
            "/        # last search pattern 缓存最近的搜索模式
    shortcut key
        <C - r>0
                # 插入寄存器缓冲区内容, 原理是vim插入模式模拟打入
                <C - p>0
                        # 保持格式不变
        <C - r>=6 * 35<CR>
                # 计算结果
    宏
        qa ... q        # 录制宏a，存到寄存器中，可以用"ap粘贴出来
        @a        # 运行宏a
        let @a = ""        # 用let @a 在.vimrc设置文件中设置宏a
        内置宏
            :
                # 上次的Ex命令
#### file oper
    shell
        $ vim file1 file2..
        $ vimtutor                                # vim的教程

    operator
        o-> 折叠
        zf
                # 创建折叠 
                # zf% 创建括号折叠
                # zf56G 创建从当前行起到56行代码的折叠
        zo/zO
                # 展开当前/递归展开当前(folding open, z这个字母看上去比较像折叠的纸)
        zc/zC
                # 再折叠/递归再折叠(folding close)
        [z                
                # 到折叠的开始处
        z]     
                # 到折叠的结束处
        zk
                # 向上移动到前一个折叠的结束处
        zd/zD
                # 删除当前光标下的折叠        嵌套删除折叠

        o-> 文件对比
        vim -d file1 file2
        diffsplit file2
        diffthis
        diffupdate
        [c        # 跳到前一个不同点
        ]c        # 跳到后一个不同点
        dp        # 合并增加另一个 （diff put）
        do        # 合并增加当前 （diff get）
    Ex command
        :help   # 显示帮助, 同F1
                ## 帮助文件中位于||之间的内容是超链接，可以用Ctrl+]进入链接，Ctrl+o（Ctrl + t）返回
                ## :help tutor 显示vimtutor的教程
                ## :help xx 显示某个帮助, 如help CTRL-[
                ## :help 'number' 显示vim选项的帮助
                ## :help <Esc> 显示特殊键的帮助
                ## :help -t 显示vim启动参数的帮助
                ## :help i_<Esc> 插入模式下Esc的帮助，某个模式下的帮助用 模式_主题的模式
        :r/nr filename          
                # 插入一个文件的内容/插入到第n行
        :f
                # 显示当前文件状态
        :.=
                # 打印当前行号        
                # := 打印总行号
        :open file
                # 新窗口打开文件
        :saveas filename
                #另存为并切换到文件
        :tabnew
                # 新建标签页
        :split file/:new
                # 屏幕分割
                # :vsplit 纵向打开窗口
        :q
                # q! 强制退出
        :w/:write
                # :w filename 写入新文件
        :x               
                # 有改动时保存并退出, 无改动只退出
        ZZ
        :e/:edit                         
                # 重新打开文件, e! 放弃所有修改重新打开文件
                # e filename 当前窗口打开另一个文件
        :bn/:bp
                # 切换上个/下个文件
        :saveas <path/to/file>  # 另存为到 <path/to/file>
        :!command   # 执行shell命令，如 :!ls
                    ## :!perl -c script.pl 检查perl脚本语法，可以不用退出vim，非常方便。
                    ## :!perl script.pl 执行perl脚本，可以不用退出vim，非常方便。
        :suspend    # 挂起vim，回到shell，命令fg返回vim。
        :buffers/:ls
                # 缓冲区列表
        :bprev
                # 上一缓冲区
        :bnext
                # 下一缓冲区

        o-> 多视窗
        :vert          # 横向打开
        :vsplit        # 横向打开
        :split
        :prev
            # 上一个文件
        :next
            # 下一个文件
        :close 最后一个窗口不能使用此命令，可以防止意外退出vim。
        :only 关闭所有窗口，只保留当前窗口

        o-> 标签窗口
            # 启动 Vim 时用 "vim -p filename ..."
        :tabe[dit]          # 打开文件到标签 
        :tabnew        #  在当前标签页之后打开带空窗口的新标签页。
        :tabc[lose][!]{count}  #  关闭当前标签页。 {}表示关闭第count个标签
        :tabo[nly][!]  # 关闭所有其它的标签页。
        :tabn[ext] {count}      # 切换到后面的标签页
        :tabp[revious] {count}      # 切换到前面的标签页
        :tabr[ewind]    # 回卷跳转
        :tabfir[st]    #  转到第一个标签页。
        :tabl[ast]      转到最后一个标签页。
        :tabm[ove] [N]    
            # 重排标签页 
            ##把当前标签页移到第 N 个标签页之后。用 0 使当前标签页成为首个标
            ##签页。如果没有 N，当前标签页成为最后一个。
    
        :tabs
            # 列出标签页和它们包含的窗口信息。
            ## 当前窗口显示 ">"。
            ##修改过的缓冲区显示 "+"。
        :tabd[o] {cmd}  # 对每个标签页执行 {cmd}

    shortcut keys
            ctrl - z                # 同 :suspend
            ctrl + g                # 同 :f

            o-> 多视窗
            ctrl + w + hljk
            ctrl + w + w        # 跳到下一个
            ctrl + w + p        # 跳到前一个
#### settings
    设置文件
        # vim启动时自动运行
        .vimrc
                # 全局设置
        .exrc                
                # 如home/.exrc文件，用于多用户设置
    命令 
        :set
            nocompatible
                    # 不设置vi兼容
            ruler?
    　　        # 查看是否设置了ruler，在.vimrc中，使用set命令设制的选项都可以通过这个命令查看
            list
                    # 显示非打印字符，如tab，空格，行尾等。
                    ## set nolist 取消显示非打印字符
                    ## 如果tab无法显示，请确定用 set lcs=tab:>- 命令设置了.vimrc文件，并确保你的文件中的确有tab，
                    ### 如果开启了expendtab，那么tab将被扩展为空格。

            fileencodings=ucs-bom,utf-8,cp936
                    # 设置读取文件支持的编码
            fileencoding=utf-8
                    # 当前文件编码
            encoding=utf-8
                    # 程序显示编码
            termencoding=utf-8
                    # 设置终端编码
            all
                    # 打印所有set选项
            sm
                    # 括号补全
            ai
                    # 启用自动缩进
            set sw=4
                    # 设置缩进字符数为4
            nu/number/nonu/nonumber
                    # 显示(不显示)行号
            ic/noic
                    # 查找时忽略(不忽略)大小写
            reprot=2
                    # 用户做2行以上修改时显示统计信息 
            shell    :/usr/bin/sh
                    # 使用SystemⅤ中的shell来执行vi中以！或  :!开头的shell命令 
            fdm=indent
                    # 设置折叠为缩进折叠
                    # syntax 语法高亮折叠
                    # expr 表达式定义折叠
                    # diff 对没有更改的文本折叠
                    # marker 对文中的标志折叠
            hls
                    # 设置查找高亮
            nrformts
                    # 设置进制, <c - a> <c - x>时对八进制有用，如07
            expandtab
                    # 存起来的文件, 用space替换tab
            shiftwidth=4
            softtabstop=4
            tabstop=8
                    # tab的长度
        :scriptnames    # 查看vim脚本文件的位置，比如.vimrc文件，语法文件及plugin等。
        :syntax # 列出已经定义的语法项
                ## :syntax clear 清除已定义的语法规则
                ## :syntax case match 大小写敏感，int和Int将视为不同的语法元素
                ## :syntax case ignore 大小写无关，int和Int将视为相同的语法元素，并使用同样的配色方案
    配置
        inoremap <C-]> <C-X><C-]>                
            # 插入模式下映射
            # nnoremap 在normal模式下映射
        fileType plugin on
            # 激活内置插件
#### plugins
    netrw
        介绍
            自带插件

        edit ./ # 查看目录树
        Ex  # 同上
        Se  # 下面弹出目录树 好用
        Ve  # 左面弹出目录树 好用

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
#### 方案
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
## kit
    man
        -f
            # 简要介绍
        -k
            # 通配搜索
    su
    sudo
    clear
    whatis
            # man -f
    apropos
            # man -k
    uname -a
            # 查看版本
    hostname

    id
            # 用户信息
    adduser outrun
    passwd
            # 修改密码
    usermod
            # 修改用户状态
        -a -G root outrun
                # 加入组
        -l 
                # 改名
        -L 
                # 锁定
        -U        
                # 解锁
    groups
            # 查看组
    adddgroup
    groupadd
    script/scriptreply
            # 终端录制



    echo
    source

    poweroff
            # 立即关机
    shutdown -h now
        -h
                # 关机
        -r
                # 重启
    pm-suspend
            # 挂起电脑
    halt

    expect

    date +%Y/%m/%d/%H:%M
    bc
    maxima
            # 符号计算
    rig
            # 随机产品人名地名
    forturn
            # 随机名言
    toilet
            # 彩虹字
    pv -qL 10
            # 文件缓慢显示
    aview
            # 图片文件化
    cowsay
    figlet
            # 大写字
    cmatrix
            # 终端黑客帝国
    sl
            # 火车
    cal 9 1752
            # 打印日历
    shred
            # 文件粉碎
    factor
            # 分解质因数
    screenfetch
    expact
        介绍
                为运行的脚本预填表单

        o-> 实例
        #!/usr/bin/expect -f
        spawn sudo /usr/local/mysql/bin/mysqld_safe --user=mysql
        expect "*password:*"
        send -- "asdf"
        send -- "\n"

        expect eof

        o-> 后台执行
                # 不要expect eof
        if [fork]!=0 exit
        disconnect
## 日志
    dmesg
            # 启动日志
    rsyslog
            # 日志管理, syslog的实现, 在systemd中被systemd-journal取代
    mcelog
            # machine check exception log
    journalctl
            # 日志查看
            -xe
## 设备
    top
        top -d 1 -p pid [,pid ...]   
    htop
    vmstat
        # 获得有关进程、swap、内存、cpu等系统信息
    dstat
        # 定时收集系统信息
    sar
        # 全面的系统活动情况
    ulimit -s unlimited
        # 限制shell启动资源
        # 不限制堆栈大小
        -a 显示各种限制
        -u 10000 最大用户数
        -n 102400 文件句柄数
        -d unlimited 数据段长度
        -m unlimited 内存大小
        -t unlimited cpu时间
        -v unlimited 虚拟内存
    setup

    slabtop
        # 内核片缓存信息
    mpstat
        # cpu统计信息
    lxtask
        # 监控内存

    xgamma -gamma .75
        # 调整屏幕色值

    amixer set Master 100%
        # 调节音量
    alsamixer
        # 调节声音
    powertop
        # intel电源管理


    lspci
    lsusb
### 硬盘
    fdisk -l
    cfdisk
    sfdisk
    parted
    mkfs
    mkswap

    testdisk /dev/sdb1
    e2fsck -a /dev/sdb1
        # 修复ext2
    ntfsfix -d -b /dev/sdb1
        # 修复ntfs坏扇区和脏标记
    fsck /dev/sda1
        # 检查并修复

    udisks --detach 设备编号
        # 移除磁盘

    mount  /dev/sdb1 /mnt
        -o acl
                # 打开acl功能
        -o loop x.iso
                # 挂载文件
        -o iocharset=utf8
                # 指定编码
        -t vfat
                # 指定类型
    umount
        -n
                # 执行umount却不写入
        -l
                # lazy
        -f
                # force

    df -h
        # 已挂载分区列表
        -T
                # 查看分区类型
    blktrace
        # 磁盘访问情况
    lsblk
        # 查看挂载的分区
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
### 进程
    pidstat
        # 进程使用资源的情况
    ps ef
        ps auxf
    pstree
        # 进程关系
    pmap pid
        # 进程

    kill 1024
        # kill - QUIT/3 1024 退出(同ctrl + \)
        ## HUP/1 终端断线
        ## INT/2 中断(同ctrl + c)
        ## KILL/9 强制终止
        ## TERM/15 终止
        ## CONT/18 继续(与STOP相反, 同fg/bg)
        ## STOP/19 暂停(同ctrl + z)
    kill -l
        # 列出所有信号名称和编号
            
    pkill Xorg
        # kill 所有包含
    killall Xorg
        # kill 所有包含
    xkill
        # 运行后 在xwindow点击kill窗口
### 网络
    ufw
        # 简化防火墙
    iptables
        iptables -A INPUT -p tcp --dport 22 -j ACCEPT
        iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
        iptables -L -n
        service iptables save
        iptables -t nat -L
                # 查nat表
        iptables -F

        配置文件
            /etc/sysconfig/iptables
            /usr/libexec/iptables/iptables.init
                save

        service iptables save
        service iptables restart    # 开放端口

        systemctl enable iptables.service

        iptables -A INPUT -p tcp --dport 3128 -j ACCEPT
                # DROP
        iptables -A OUTPUT -p tcp --sport 3128 -j ACCEPT

        iptables -t nat -A POSTROUTING -s 192.168.252.0/24 -j SNAT --to-source 10.171.83.146
                # vpn服务器
    firewall
        systemctl start firewalld

        firewall-cmd --query-port=8080/tcp
            --add-port=8080/tcp --permanent --zone=public
            --reload
            --get_active-zones
            --list-all
            --set-default-zone=public
    wget
            -i filelist.txt
                # 下载一个文件中的所有url
            -np -m -l 5
                # 不下载本站所链接的其它站点内容，5级目录结构
    ping
    telnet
    nmblookup -A ip
        # 查询域名
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
    netctl
        # 配置网卡服务
    route
        # 查看路由表
        -n
            # 不解析域名
    arp -n
        # 显示局域网 ip mac表
        -s ip mac
            # 设置ip mac表
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
        curl -v
            # 详细头信息
        curl -H "Cookie: foo=bar; baz=val" 
            # 发送cookie
    nc -U a.sock
        # netcat, 功能全面
    dig
        # 域名解析
    nmap
        -sP ip/24
            # 查看网内所有ip
    ip
        # 网卡与ip信息

    iotop
        # 实时监视io
    iostat
        # 负载情况
    lsof -i:8080
        # 列出当前系统打开的文件，必须root运行才准确
    nicstat
        # 网络流量统计
    netstat -antpu
        # 端口
    ss
        # 端口，性能高
        -l
            # listening
    iwlist
        # 列出无线网
    iwconfig
        # 无线网卡设置
    pppoe
        # 宽带
    w3m
        # 命令行浏览器

    ssh
    sshfs -o allow_other root@ip:~ /mnt
        # 挂载远程目录
    scp a.txt root@ip:~
    vnc
        # 远程桌面
        Virtual Network Computing
        相关文章
            linux 自带远程桌面--VNC服务配置说明  
        安装
            yum install vnc*

            yum install *vnc-server*
        启动
            vncserver :1 
        登录
            vncviewer
                # fedora 下gnome自带的vncviewer名为:Remote Desktop Viewer
                输入192.168.0.62:1        # 实际端口号为5901, 如果服务号为2则为5902
            或者浏览器java-plugin
                localhost:5801                # 需要安装java
    wifi-menu
## 调度
    at
        # 某时间运行一次

    jobs
        # 后台作业
    fg
        # 后台作业调度到前台
    bg
        # 继续执行后台作业
    osmo
        # 计划任务软件
    reap
        # 用于定时删除目录中文件，并打印日志
        -h
            # 打印帮助信息
        -t
            # 后台运行, 并设置时间间隔
        -s
            # single 单次运行
## 包管理
    rpm
        #源 rpm fusion
        -i 安装
        -e 卸载
        -qa 查看安装的包名
        -ql 包名, 查看安装的文件
        -qc 包名, 查看软件的配置文件
    pacman
        # 源 mirrors.163.com
        -Qeq | pacman -S -
            # 重新安装所有包
        -S $(pacman -Qnq)
            # 重新安装所有包
        -Ss ^ibus-*
            # 通配search
        -S $(pacman -Ssq fcitx*)
            # 通配安装
        -R $(pacman -Qsq fcitx)
            # 通配删除
        -Rcns plasma
            # 删除plasma
        -Sc
            # 清除缓存
        -Qii zsh
            # 包信息
        -Ql zsh
            # 查看安装的文件
        -Qo /bin/zsh
            # 查看文件属于的包
    downgrade
        # 用于给pacman安装过后软件降级
    yum
        设置代理
            /etc/yum.conf
            proxy=http://XXX.XXX.XXX.XXX：XXXX
            或
            proxy=FTP://XXX.XXX.XXX.XXX:XXXX
            proxy_username=你的用户名
            proxy_password=你的用户名的密码

        yum 
            whatprovides 'bin/isstat'
                # 查看命令属性哪个包
            whatprovides git
                # 查看git命令所在的包
            history list
            history redo 序号
                # 重新做序号
            history undo 序号
                # 恢复历史中执行的动作
            groups list
                # 查看安装的组
            list installed
            list extras
            info installed

        编译用包
            build-essential
                # yum中基本编译依赖包
            yum install make cmake apr* autoconf automake curl-devel gcc gcc-c++ zlib-devel openssl openssl-devel pcre-devel gd  kernel keyutils  patch  perl kernel-headers compat* mpfr cpp glibc libgomp libstdc++-devel ppl cloog-ppl keyutils-libs-devel libcom_err-devel libsepol-devel libselinux-devel krb5-devel zlib-devel libXpm* freetype libjpeg* libpng* php-common php-gd ncurses* libtool* libxml2 libxml2-devel patch freetype-devel ncurses-devel libmcrypt libtool flex pkgconfig libevent glib libgnomeui-devel
    dpkg
        # 管理deb包程序
        -i
            # 安装
        -r
            # 删除
    pkgfile
        # 查看命令所需的包
## 输入法
    fcitx
    ibus
    ibus-daemon -d -x -r
        # ibus后台运行
## 桌面
    gnome
        gnome3应用程序列表
            /usr/share/applications
        取消ctrl+alt+down/up
            gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['']"
            gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['']"
        gnome-shell
            alt + f2后输入lg
        gnome terminate
            ctrl + shift + c/v          # 复制/粘贴
            ctrl + shift + t/n          # 打开新标签/新窗口
            ctrl + w 或 alt + backspace  # 删除最后的word
            ctrl + shift + w/q          # 关闭当前term/所有term
            ctrl + shift + f/g/h        # 搜索/搜索下一个/搜索上一个
            ctrl + pageUp/pageDown      # 切换标签
            ctrl + shift + pageUp/pageDown  # 移动标签
            alt + 1/2/3/..../0          # 切换到第1/2/3/....../10个标签
        系统快捷键
            右键快捷键
                shift + f10
    kde
    awesome
    i3
## init
    grub
        /etc/default/grub       # 设置文件
        grub2-mkconfig -o /boot/grub2/grub.cfg      # 使设置生效，update-grub 是debian下做的包装
    upstart
        # 状态 waiting, starting, pre-start, spawned, post-start,running,pre-stop, stopping, killed, post-stop
    systemv
    systemd
    sestatus -v
        # 查看selinux 状态
    systemctl
        status
        daemon-reload
            # 修改service文件后重载
        systemctl list-units
            # list known units
        systemctl list-unit-files
            # 已知的services
        systemctl list-sockets
            # list socket units ordered by the listening address
        systemctl enable NAME
            # 设置开机启动, 生成service脚本命令
        systemctl disable NAME
        systemctl start NAME
        systemctl stop NAME
        systemctl restart NAME
        systemctl reload NAME
    setenforce 0
        # 临时systemd
    getenforce
        # 临时关闭systemd
    service
        service start
        service restart
        service stop
        service status
    chkconfig iptables on/off
        # 设置服务启动
        --level 2345 iptables off
            # 查看各level服务状态
        --list
## 编程
    :() { :|:& };:
        # fork bombmake
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
        set -o
            # 设置快捷键模式，默认emacs
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
                "        # 横分
                %         # 竖分
                x        # 关闭
                !        # 移到新window
                方向        # 切换
                o        # 切换到下一个
                <C-o>        # 向下旋转
                <M-o>        # 向上旋转
                {        # 向前置换
                }        # 向后转换
                <C-方向>        # 调整size
                <M-方向>        # 5倍调整size
                空格        # 切换布局
                <M-[0-5]>        # 选择布局
                q        # 显示编号

        内置命令
            source-file a
    screen
        -ls
            # 查看所有session
        -r
            # 进入id
    makepkg
        # 创建软件包

    perf
        # 性能调优
    strace
        # 跟踪系统调用
    itrace
        # linux系统编程中跟踪进程的库函数调用
        -S ./hello
            # 跟踪所有系统调用
    dtrace
        # 应用程序动态跟踪
    gdb
## 模拟
    wine
    winetricks
        # 安装wine的各种依赖
    cabextract
        # microsoft cabinet获取工具