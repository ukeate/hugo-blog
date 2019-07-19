---
title: 运维
Categories: ["运维"]
date: 2018-10-10T17:33:07+08:00
type: docs
---


# 目标
    安全性
            账号管理
            漏洞修复
            安全审计
    可用性
            服务监控
            架构优化
            冗余备份
            预案演练
            故障响应
    运维成本
            成本核算
            服务选型
            成本优化
    运维效率
            研发工作流支持
            服务支持平台建设
            运维自动化平台建设

    操作系统
            windows
            linux
            chrome os
            mac os
            fushsia
                    # goolge os

# 产品
    confluence
            # wiki
    grafana
            # 监控
    jira
            # IBM Rational提供的缺陷及变更管理工具。它对软件缺陷或功能特性等任务记录提供跟踪管理。提供了查询定制和多种图表报表。
    teambition
    redmine
            # ror开发的项目管理web，支持git, svn, cvs等，把成员、任务、文档、讨论等资源整合在一起
    gerrit
            # code review 工具
    jenkins
            # java实现的持续集成工具
    ansible
            # python实现的自动化部署工具
    gradle
            # 自动化构建
    jumpserver
    saltstack
            # 自动化运维工具
    zabbix
            # 分布式监控
    nagios
            # 监控
    puppet
            # 自动化运维
    selenium
            # 自动化运维
    tty.js
            # 浏览器运行命令
    coverallx
            # github上项目的coverage测试覆盖率条目由它提供服务
    circleCI
            # github代码测试
    travis-ci
            # 利用github hook测试
    fitness
            # 自动单元测试
    coverity
            # 代码静态检查
    sentry
            # error tracing
# 系统
    windows
    fushsia
            # goolge os
## linux
    高并发优化
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
                nofile=10000000
# 虚拟化
    docker
    vagrant
            # 用一个virtualbox虚拟机来快速部署开发环境
    parallels desktop
            # 苹果
    xen
    gnome boxes
    hyper-v
            # 微软
## kvm
    介绍
        kernel-based virtual machine, 使用linux自身的调度器进行管理,所以代码较少
                # 又叫qemu-system或qemu-kvm
        虚拟化需要硬件支持(如 intel VT技术或AMD V技术)，是基于硬件的完全虚拟化
    原理
        包含一个可加载的内核模块kvm.ko, 由于集成在linux内核中，比其他虚拟机软件高效
    使用
        检查系统是否支持硬件虚拟化
                egrep '(vmx|svm)' --color=always /proc/cpuinfo

## vmware
    安装
        安装后会创建两个虚拟网卡
    设置
        edit -> preferences -> Hot Keys 设置退出快捷键
    网络连接方式
        1.vm9自带的virtual network editor中选择桥接到有线网卡
        2.vm -> setting -> network adapter选项设置
                bridged（桥接）:与主机平等，可以设置为同一个网段相互访问
                nat:通过虚拟网卡连接主机，共享网络
                host-only:单机模式

## virtualbox
    方案
        linux安装增强iso
                iso位置
                        /usr/share/virtualbox
                编译环境
                        kernel-devel
                        gcc


        共享剪切板与拖拽文件
                虚拟机启动后devices下设置
        共享文件夹
            linux下挂载
                    mount -t vboxsf 共享名 /mnt/share
            windows下挂载
                    我的电脑 右键 映射网络驱动器
        clone
            clone 时选择更新mac,并在虚拟机中网络连接设置中重写mac与ip

            配置主机间ssh免登录，远程ssh与所有主机免登录
# 认证
## ssh（secure shell）
    特点
        1.加密和压缩：http与ftp都是明文传输
        2.ssh有很多子协议，实现不同功能：如sftp,scp
        3.端口:22
    配置
        修改ip地址：
            有虚拟机时：先设置虚拟机的连接方式是桥接
            图形界面直接修改（或重启到root用户的图形界面修改）
            命令修改
                /etc/network/interfaces
                    auto eth0
                    iface eth0 inet static
                    address ip地址
                    netmask  子网掩码
                    gateway  网关
                    broadcast 广播地址
                    dns-nameservers DNS
                重启网络服务：/etc/init.d/networking restart，
        /etc/ssh/sshd_config
            PasswordAuthentication no
                # 关闭密码登录
            PermitRootLogin no
                # 关闭root登录
    命令
        ssh outrun@10.1.1.1
            # -p 22 端口
            # PubkeyAuthentication=no 不公钥登录
    免登录
            ssh-keygen -t rsa
                # 一直回车，生成~/.ssh/id_rsa 与 id_rsa.pub两个文件
            ssh-copy-id -i 192.168.56.11
                # 这样就可以免登录访问192.168.56.11了
                ## ssh-copy-id -i localhost　免登录自己

            或
            把A机下的1中生成的id_rsa.pub的内容复制到B机下，在B机的.ssh/authorized_keys文件里，这样可以多个主机对B机进行免登录
    sshpass
        介绍
            命令行密码登录
        命令
            sshpass  -p zlycare@123 ssh zlycare@10.162.201.58

## openvpn
    o-> 安装 2.0.9
        yum install openssl-devel gcc lzo-devel
        mkdir –p /usr/local/openvpn && cd /usr/local/openvpn/
        ./configure --with-lzo-headers=/usr/local/include --with-lzo-lib=/usr/local/lib
        make
        make install
        cd /usr/local/openvpn/openvpn-2.0.9/easy-rsa/2.0/
        tail -5 vars
                export KEY_COUNTRY="CN"
                export KEY_PROVINCE="BJ"
                export KEY_CITY="Beijing"
                export KEY_ORG="tshar365"
                export KEY_EMAIL="tshare365@help.org"
        source vars
        ./clean-all
        ./build-ca
        ./build-key-server server
        ./build-key-pass zdong
                # ./build-key zdong 无密码
        ./build-dh
        mkdir -p /etc/openvpn
        cp -p ../../sample-config-files/server.conf /etc/openvpn
        cp keys/* /etc/openvpn
        /usr/local/sbin/openvpn --config /etc/openvpn/server.conf &

        cd keys
        mkdir zdong
        cp zdong.* zdong
        cp ca.* zdong
        vim zdong/client.ovpn
        tar cvzf zdong.tar.gz zdong

        vim /etc/sysctl.conf
                net.ipv4.ip_forward = 1
                        # 开启路由转发
        sysctl -p
        iptables -t nat -A POSTROUTING -s 192.168.200.0/24 -j SNAT --to-source 45.55.56.16


    o-> server.conf
        dev tun
        ca /etc/openvpn/ca.crt
        cert /etc/openvpn/server.crt
        key /etc/openvpn/server.key
        dh /etc/openvpn/dh1024.pem
        server 192.168.200.0 255.255.255.0
        ifconfig-pool-persist ipp.txt
        push "route 0.0.0.0 0.0.0.0"
        #push "route 192.168.10.0 255.255.255.0"
        push "redirect-gateway def1 bypass-dhcp"
        push "dhcp-option DNS 223.5.5.5"
        #client-config-dir ccd
        client-to-client
        #duplicate-cn
        #keepalive 10 120
        comp-lzo
        persist-key
        persist-tun
        status openvpn-status.log
        log /var/log/openvpn.log
        verb 3

    o-> client.ovpn
        client
        dev tun
        proto udp
        remote 45.55.56.16
        resolv-retry infinite
        nobind
        persist-key
        persist-tun
        ca ca.crt
        cert zdong.crt
        key zdong.key
        comp-lzo
        verb 3
        mute 20
        #redirect-gateway def1

    o-> 连接
        openvpn --config openvpn.conf
            # --user outrun
            # --auth-nocache
            # askpass pass.txt 放密码到文件

    o-> expect免密码连接
        #!/usr/bin/expect -f
        spawn sudo openvpn --config /home/outrun/.openvpn/meiqia-vpn-ldap.ovpn
        # match_max 100000
        expect "*?assword*:*"
        send -- "1234\n"
        expect "*Username:*"
        send -- "outrun\n"
        expect "*Password:*"
        expect "#"
## opendj
    介绍
        open source directory services for the java platform
        LDAPv3的认证系统
## openvpn
    openvpn --config openvpn.conf
        # 连接
        ## --user outrun
        ## --auth-nocache
        # askpass pass.txt 放密码到文件
## openssl
    使用
        openssl genrsa -out server.key 1024
            # 生成私钥
        openssl rsa -in server.key -pubout -out server.pem
            # 生成公钥
        openssl req -new -key ca.key -out ca.csr
            # 通过私钥生成csr(certificate signing request, 证书签名请求)文件
        openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt
            # 通过csr生成自签名ca证书，用来颁发证书
        openssl x509 -req -CA ca.crt -CAkey ca.key -CAcreateserial -in server.csr -out server.crt
            # 向自己的ca机构申请签名，需要ca.crt, ca.key, server.csr, 得到带有CA签名证书。用来给客户端验证公钥属于该域名
            # 客户端发起安全连接前会获取服务器端的证书, 并通过ca证书验证服务器端证书的真伪，并对服务器名称, IP地址等进行验证
        openssl s_client -connect 127.0.0.1:8000
            # 测试证书是否正常

# 应用控制
## forever
    openvpn --config openvpn.conf
            # 连接
            ## --user outrun
            ## --auth-nocache
            # askpass pass.txt 放密码到文件
## supervisor
    介绍
            实时代码改动重启node

    命令
            supervisord
                    # 启动后台服务
            supervisorctl update
            supervisorctl status
    配置
    [program:tri]
    command=/data/apps/tri/bin/tri --config /data/apps/tri/conf/config.tri.toml
    directory=/data/apps/tri
    autostart=true
    autorestart=true
    startsecs=10
    startretries=3
    stdout_logfile=/data/logs/supervisor/tri/access.log
    stdout_logfile_maxbytes=100MB
    stdout_logfile_backups=20
    stderr_logfile=/data/logs/supervisor/tri/stderr.log
    stderr_logfile_maxbytes=100MB
    stderr_logfile_backups=2
## pm2
    介绍
        带有负载均衡功能的node应用进程管理器
        内建负载均衡(使用node cluster模块)
        后台运行
        热重载
        停止不稳定进程，如无限循环
    安装
        npm install -g pm2
    命令
        pm2 start app.js
        pm2 stop
        pm2 restart
        pm2 status
        pm2 info 1
        pm2 logs 1

# 版本
    mercurial
            # 简称hg，分布式版本控制系统，比git好
    clearQuest
            # IBM Rational提供的缺陷及变更管理工具。它对软件缺陷或功能特性等任务记录提供跟踪管理。提供了查询定制和多种图表报表。
    clearcase
            # 配置管理的工具，只是SCM管理工具其中的一种。是RATIONAL公司开发的配置管理工具
    gradle
            # dsl声明设置
    spm
            # 构建sea.js项目
    bower
            # 构建前端
    redmine
## git
    目录结构
        .git
            branches
            config  # 存放版本库git地址
    规定
        HEAD
            # HEAD的版本号, HEAD^^ 表示HEAD之前两个的版本, HEAD~n 表示之前n个版本
        buffered stage branch head
            # buffered表示当前修改所在的版本，stage是buffered中文件add之后到的版本，branch是stage commit后到的分支(版本)，head是远程仓库的最新版本
    命令
        git [command] --help
        git help submodule
        仓库
            clone
            checkout
                # 切换到分支。检出原有文件替换
                -b
                        # 创建并切换到分支
            branch
                # 创建并切换到分支
                -r
                        # 指定操作远程分支
                        -r origin/dev
                -a
                        # 本地远程所有分支
                dev ef71
                        # 从ef71创建分支dev
                dev
                -d dev
                        # 删除
                -D dev
                        # 强制删除
            remote
                remove origin
                show
                        # 显示仓库
                prune origin
                        # 删除远程没有而本地缓存的远程分支
                add origin git@bitbucket.org:outrun/www2.git
                        # 设置仓库
                set-url origin git@github.com:outrun/jeky
                        # 设置仓库url
            fetch
                # pull加merge
            pull origin master
                --allow-unrelated-histories
                    # 本地有已存文件时，强行pull并检查冲突
            merge dev
                # 合并dev到当前分支
                --squash dev-bak
                    # dev-bak改动写到stash
            push origin master
                -u origin master
                    # 设定git push 默认参数
                origin :dev
                    # origin +dev:dev
                    # 强制替换掉原来版本
            commit
                # stage 提交到branch
                -a
                    # 提交删改，忽略增加
                -m
                    # 注释
                --amend
                    # 合并到上次commit
            revert  -m 1 ea1
                # 舍弃最近一次commit
                git commit -am 'revert'
                git revert revertid1 取消上次revert
                    # intellji - local history - revert
            rebase master
                # 相当于当前改动代码之前merge master
            reset
                --hard ea1
                    # 回退
            stash
                # 暂存buffered
                list
                    # 显示stash
                drop
                    # 删除暂存
                pop
                    # 恢复并删除暂存
                apply stash@{0}
                    # 恢复暂存
            tag tag1
                # 添加tag tag1
                -a tag1
                    # 添加tag1
                -m 'a'
                    # 注释
                -d tag1
                        # 删除tag1
            show tag1
                # 查看tag1的信息
        文件
            add
                -A
                    # 递归
            mv a b
                # 重命名
            rm
                # buffered和stage中都删除
                --cached
                    # 只删除stage中
            log
                # HEAD到指定版本号之前的log
                --stat
                    # 文件名差异
                -p
                    # 细节差异
                -2
                    # 文件最近2次差异
            reflog
                # 包括reset前的版本号
            diff master dev
                # 对比分支差异，可指定到文件
                # 默认对比buffered和stage的差异
                --cached
                    # 对比stage和branch的差异
            ls-files
                -u
                    # 显示冲突文件
                -s
                    # 显示标记为冲突已解决的文件
                --stage
                    # stage中的文件
            submodule
                init
                    # 初始化本地配置文件
                update
                    # --init --recursive
                    # 同步项目中的submodule
    设置
        .gitignore

        .git/config

        ~/.gitconfig
            [commit]
            template=/t.txt
                # 每次commit会打开模板
    方案
        回退commit
            git reset --hard ea1
                # 进行回退
            git push -f
                # 强制提交
            git clean -xdf
                # 一般配合git reset使用, 清除已有的改动
        补充commit
            git commit --amend
            git push origin +a:a
        远程回退
            git revert id
        删除远程分支
            git branch -r -d origin/test
            git push origin :test
        恢复历史版本文件
            git reset ba5798aff7778c95252b9e01e924dddb5811bcd7 courseModel.js
            git checkout -- courseModel.js
            git push origin +master:master                # 提交回退版本到远程
        查看修改的内容
            git show
                # 与上个commit 比较
            git whatchanged
            git log --stat --date=relative
        删除历史
            git filter-branch --force --index-filter 'git rm -r --cached --ignore-unmatch .idea' --prune-empty --tag-name-filter cat -- --all
            git push origin master --force
            rm -rf .git/refs/original/
            git reflog expire --expire=now --all
            git gc --prune=now
            git gc --aggressive --prune=now
        合并commit历史
            git branch test-bak
            git reset --hard ea1
            git merge --squash test-bak
            git push origin test -f
            git branch -D test-bak
        打tag
            git tag
                # git tag -l 'v1.*' 通配查找
            git tag -a v1.0 -m "a"
                # git tag -a v1.0 ba1 给commit打标签
            git show v1.0
            git checkout v1.0
            git push origin v1.0
                # git push origin -tags 将本地所有标签提交
            git tag -d v1.0
            git push origin --delete tag v1.0
                # git push origin :refs/tags/v1.0c
        统计某人代码
            git log --author="$(git config --get user.name)" --pretty=tformat: --numstat | gawk '{ add += $1 ; subs += $2 ; loc += $1 - $2 } END { printf "added lines: %s removed lines : %s total lines: %s\n",add,subs,loc }' -
        共添加或修改行数
            git log --stat|perl -ne 'END { print $c } $c += $1 if /(\d+) insertions/'
        pr
            介绍
                fork与pull request

            fork后本地
                git clone git@github.com:chenduo/auth.git
                git remote add upstream git@github.com:Meiqia/auth.git
            本地合并更新
                git checkout master
                git fetch upstream
                    # fetch远程仓库
                git rebase upstream/master
                    # 合并远程master
                git push
                git checkout branch1
                git rebase master
            pr追加
                git commit --amend
                    # 更新本地的本次commit,不产生新的commit
                git push origin +branch1:branch1
                    # 使用本地的commit覆盖远程分支的有问题的commit
            处理pr
                git fetch origin
                git checkout -b pr1 origin/pr1
                git checkout master
                git merge --no-ff pr1
                git reset --hard
                git revert -m 1 ea1
                    # 舍弃pr
                git commit -am 'revert'
                git revert revertid1 取消上次revert
                    # intellji - local history - revert
                git push origin master
        开发
            提交
                git pull eoecn dev
                    # 等于git fetch加git merge
                git diff
                    # buffer与HEAD的差异(不包括新建文件)
                git add -A .
                    # 添加到stage
                git status
                    # stage与HEAD的差异
                git diff --cached/--stage
                    # stage与HEAD的详细差异
                git diff HEAD
                    # buffer, stage与HEAD的详细差异
                git commit -am 'a'
                git push origin dev
                网站上点pull request
    github
        ssh -T git@github.com
            # 检查github ssh是否设置成功
    插件
        octotree    # 树形显示

## svn
    linux下移植的版本控制器
    默认端口: 3690
    ## 目录结构
        conf:配置文件
        db:数据库
        hooks:勾子（自定义功能）
        locks:文件锁
    ## 命令
    ### 服务器
        svn --version
        svnadmin create c:\svn        # 创建仓库
                                            ## hooks勾子 locks锁 conf db
        svnserve -h
        svnserve -d -r c:\svn      # 启动服务(-d是后台运行，windows不支持，需要创建服务)
                                                ## --listen-port 3691 指定监听端口
        windows 下注册服务
                        sc create 服务名 binPath= "d:/suversion/bin/svnserve --service -r c:\svn" displayName= "显示名"
                            # 注意双引号前面要有空格
                        sc delete 服务名

        使用多个仓库
                svnadmin create d:\svn2 创建仓库以后
                svnserve -d -r d:\svn2 --listen-port 3691        配置用另一个服务端口启动该仓库        # svn默认启动端口是3690
                svn://192.168.10.3:3691        来访问该仓库
    #### 客户端
        添加项目
                svn add test/
                svn ci -m "first"                # svn commit -m "fisrt"
                                                ## ci是checkin
        检出
                svn checkout svn://192.168.0.2/framework
        显示所有分支(目录)
                svn ls svn://192.168.0.2/fr --verbose
        创建分支
                svn copy svn://192.168.0.2/repo/trunk/ svn://192.168.0.2/repo/branches/try-sth -m 'make branch try-sth'
                        # 注意trunk后面要有/
        更换本地分支
                svn switch svn://192.168.0.2/repo/branches/try-sth
    ## 配置
        conf/svnserve.conf
                anon-access = read                # 匿名用户权限
                auth-access = write                # 登录用户权限
                                        # write权限包括read权限
                                        ＃ none没有验证无权限(匿名权限)
                password-db = passwd        # 加载conf/passwd文件（中的用户帐户）
                authz-db = authz                        ＃开启权限控制
                        同目录authz文件中配置权限
                        [/]                               # 对根目录设置权限
                        * = r                            # 所有人都可读
                        outrun = rw                # 配置所有版本库只读，outrun可读可写
                        @admin = rw                # @组名    对组进行引用
                realm = aa
                                        # 认证域名称, 本svn路径为 svn://192.168.0.2/aa
        conf/authz

        conf/passwd
                [groups]
                        admin = outrun
        例子
            authz
                    [groups]
                    admin = a1, a2
                    [/]
                    @admin = rw
                    a3 = rw
                    * = r
            passwd
                    [users]
                    a1 = 123
                    a2 = 123
                    a3 = 123
            svnserve.conf
                    [general]
                    anon-access = none
                    auth-access = write
                    password-db = passwd
                    authz-db = authz
                    realm = trunk
                    force-username-case = none
    ## 工具
        tortoiseSVN
            下载
                        右键 svn checkout 选择版本 下载 (show log 查看日志)

                上传
                        第一次提交 右键 tor.../import
                        svn://192.168.10.188     # 输入用户名、密码登录
                        第二次提交 右键 commit
                还原
                        右键 tor.../Revert 还原其中的文件
                多人
                        右键 svn update ,更新另一个人提交的文件内容
                新建文件的提交
                        tor../add 或 commit的时候选择该文件
                        tor./Repo-browser，浏览仓库
                加锁文件    # 只有自己在不提交更改的前提下才可以解锁
                tor../get lock      # 不会改变版本
                        tor../release lock  # 解锁,但是新下载的工程不可以再解锁，如果删除原工程则无法解锁
                冲突
                        当前版本已经有人修改后commit的话提示版本已经过时
                        update:下载所有版本，右键 tor../edit conflicts -> mark as resolved确定解决
                        # 避免冲突：减少公共修改时间，重写前更新
                使用经验
                        TortoiseSVN -> Setting -> Saved Data 可以清空自动登录

        svn的myeclipse插件：
                        # eclipse6中不能用，eclipse7每次报错，能用，eclipse8报错一次，能用 eclipse10不报错
                1.复制插件文件夹features与plugins到/myeclipse 10/dropins/文件夹中
                2.创建目录/myeclipse 10/my_plugin/svn/
                                复制插件文件夹features与plugins到/myeclipse 10/my_plugin/svn/文件夹中
                                /myeclipse 10/dropins/添加svn.link文件 ，内容为:path=my_plugin\\svn                # 这里写相对路径
                3.使用：重启myeclipse,弹出确认窗口（也可以从window -> show view中找到svn的视图）
                        项目：右键->share project 上传项目到svn(bug 第一次只上传空文件夹,再右键Team/提交 时上传项目文件)
                                再右键就可以对该项目进行一系列的操作了
                        导入项目：file -> import -> svn

        rapidsvn
## ant
    功能
        js压缩
        自动发布
    build.xml
        示例
        <?xml version="1.0" encoding="UTF-8"?>
        <project default="execute">
                <target name="compile">
                        <javac destdir="." srcdir="."/>
                </target>

                <target name="execute" depends="compile">
                        <java classpath="." classname="HelloWorld"/>
                </target>
        </project>
## maven
    repository包依赖关系网站
        mvnrepository.com
    依赖范围
        compile     # 默认,对编译、测试、运行有效
        test        # 对测试有效
        runtime     # 对测试和运行有效
        provided    # 编译和测试有效
        system      # 本地仓库
        import
    命令
        pom.xml生成项目命令
                mvn
                mvn compile                        # mvn compile exec:java
        eclipse插件
                m2e
        得到jar包
                mvn dependency:copy-dependencies
        生成eclipse工程
                mvn eclipse:eclipse
        jetty-plugin下运行
                mvn jetty:run
        版本
                mvn -version
    方案
        ojdbc14本地加载
            ＃ oracle是收费的，所以不能直接下载到驱动
            o-> mvn install:install-file -DgroupId=com.oracle -DartifactId=ojdbc14 -Dversion=10.2.0.4.0 -Dpackaging=jar -Dfile=ojdbc14-10.2.0.4.0.jar
            o-> 把ojdbc14-10.2.0.4.0.jar复制到目录下: /home/outrun/.m2/repository/com/oracle/ojdbc14/10.2.0.4.0/
            o-> /home/outrun/.m2/repository/com/oracle/ojdbc14/下会产生maven-metadata-local.xml文件存放maven引入依赖
            o-> 项目中引入本地依赖
                <dependency>
                    <groupId>com.oracle</groupId>
                    <artifactId>ojdbc14</artifactId>
                    <version>10.2.0.4.0</version>
                    </dependency>


# 架构
## k8s
    kubectl get pod -l app=app1 -o wide
        # 查看pod app状态
    kubectl exec -it appID1 /bin/sh
        # 交互命令进入app
    kubectl logs --tail=1000 appID1
        # 查看日志
## aws服务器
    s3命令
        aws s3 cp --recursive bin s3://meiqia/crm-module/search/bin
            # 级联复制
        aws s3 sync s3://meiqia/crm-module/search/bin bin
            # 下载
        aws s3 rm --recursive s3://meiqia/crm-module/search
            # 级联删除


# 个人操作
## vsftp
    介绍
        默认端口21
        匿名用户登陆名为ftp或anonymous, 目录在/var/ftp, 只能下载不能上传
        本地用户用户名和密码与本地用户相同，目录为该用户的登录目录
    文件
        /usr/sbin/vsftpd
                # VSFTPD的主程序
        /etc/rc.d/init.d/vsftpd
                # initd启动脚本
        /etc/vsftpd/vsftpd.conf
                # 主配置文件
        /etc/pam.d/vsftpd
                # PAM认证文件
        /etc/vsftpd.ftpusers
                # 禁止使用VSFTPD的用户列表文件
        /etc/vsftpd.user_list
                # 禁止或允许使用VSFTPD的用户列表文件
        /var/ftp
                # 匿名用户主目录
        /var/ftp/pub
                # 匿名用户的下载目录
    默认用户与组
        用户
            adduser -d /var/ftp -g ftp -s /sbin/nologin ftp
        组
            ftp
    命令
        systemctl start vsftpd
    配置
        /etc/vsftpd/vsftpd.conf文件中
            anonymous_enable=YES
            local_enable=YES
            write_enable=YES
            chroot_local_user=YES
            allow_writeable_chroot=YES
            local_root=/
                    # local_root表示使用本地用户登录到ftp时的默认目录
            anon_root=/
                    # anon_root表示匿名用户登录到ftp时的默认目录
            chroot_list_file=/etc/vsftpd/chroot_list

        编辑/etc/vsftpd/chroot_list
            在这里面输入用户名字，一行写一个用户名。

        重启vsftpd
        打开tcp, udp端口21, 20

        root 登录
                /etc/vsftpd/vsftpd.conf
                        userlist_enable=YES
                        pam_service_name=vsftpd
                /etc/vsftpd/ftpusers与/etc/vsftpd/user_list
                        注释root
## SimpleHTTPServer
    pythom -m SimpleHTTPServer 8080
## pyshark
    介绍
        包嗅探

