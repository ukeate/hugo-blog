---
title: 运维
Categories: ["运维"]
date: 2018-10-10T17:33:07+08:00
type: docs
---


# 基础
    目标
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
    工作方式
        邮件申请开通 LDAP, VPN, 测试, 线上

# 系统
    linux
    windows
    chrome os
    mac os
    fushsia
        # goolge os
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
    网络连接
|                 |NAT  |Bridged Adapter|Internal|Host-only Adapter|
|:----------------|:----|:--------------|:--------|:----------------|
|虚拟机->主机      |√    |√              |×         |默认不能，需设置
|主机->虚拟机      |×    |√              |×         |默认不能，需设置
|虚拟机->其他主机   |√    |√              |×        |默认不能，需设置
|其他主机->虚拟机   |×    |√              |×         |默认不能，需设置
|虚拟机间          |×    |√              |同网络可以 |√
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
    安装
        yum install openvpn easy-rsa lzo lzo-devel openssl openssl-devel -y
        或编译安装openvpn
            mkdir –p /usr/local/openvpn && cd /usr/local/openvpn/
            ./configure --with-lzo-headers=/usr/local/include --with-lzo-lib=/usr/local/lib
            make
            make install

    生成证书
        目标
            服务器: ca.crt、server.key、server.crt、dh.pem
            客户端: ca.crt、client.key、client.crt
        查找模板
            find / -name "vars.example" -type f                         # vars文件
            find / -name "server.conf" -type f                          # server.conf文件
        进入目录easy-rsa
            cd /usr/local/openvpn/openvpn-2.0.9/easy-rsa/2.0/
            cd /usr/share/easy-rsa/3.0.3/
        设置vars
            cp vars.example vars
            vars文件
                set_var KEY_COUNTRY="CN"
                set_var KEY_PROVINCE="BJ"
                set_var KEY_CITY="Beijing"
                set_var KEY_ORG="linux"
                set_var KEY_EMAIL="test@example.net"
                # set_var EASYRSA_NS_SUPPORT "yes"                      # 客户端配置ns-cert-type server时配置
        生成server文件
            rm -rf pki
            ./easyrsa init-pki                                          # pki目录
            ./easyrsa build-ca  nopass                                  # 回车过, 生成ca.crt
            ./easyrsa gen-req vpnserver nopass                          # 回车过, 生成vpnserver.key, vpnserver.req(密钥对、证书请求文件)
            ./easyrsa sign server vpnserver                             # 生成vpnserver.crt(ca.crt与vpnserver.req签名)
            ./easyrsa gen-dh                                            # 生成dh.pem(diffie hellman)
            cp -r ../3.0.3/ ~
        生成client文件
            rm -rf pki
            ./easyrsa init-pki
            ./easyrsa gen-req client nopass                             # 回车过, 生成client.key, client.req
            cp pki/reqs/client.req ~/3.0.3/pki/reqs/
            cp pki/private/client.key ~/3.0.3/pki/private/
            cd ~/3.0.3
            ./easyrsa sign client client                                # 生成client.crt(ca.crt与client.req签名)
        移动server文件到openvpn配置目录
            cp pki/{ca.crt,dh.pem} /etc/openvpn/server/
            cp pki/private/vpnserver.key /etc/openvpn/server/
            cp pki/issued/vpnserver.crt /etc/openvpn/server/
            cp server.conf /etc/openvpn/server
        下载client文件
            pki/ca.crt
            pki/private/client.key
            pki/issued/client.crt
    server.conf
        cp -p ../../sample-config-files/server.conf /etc/openvpn
        o-> server.conf
            ;local 172.21.223.196
            port 1194
            proto udp
            dev tun

            ca /etc/openvpn/ca.crt
            cert /etc/openvpn/server.crt
            key /etc/openvpn/server.key
            dh /etc/openvpn/dh1024.pem

            server 192.168.200.0 255.255.255.0
            ifconfig-pool-persist ipp.txt
            push "route 0.0.0.0 0.0.0.0"
            keepalive 10 120

            cipher AES-256-CBC
            comp-lzo                                                    # 减少带宽
            persist-key
            persist-tun

            status openvpn-status.log
            log /var/log/openvpn.log

            verb 3
            explicit-exit-notify 1                                      # 只能udp协议使用
        sudo openvpn --config /etc/openvpn/server.conf --daemon
        netstat -anulp | grep 1194
    linux配置
        iptables
            vim /etc/sysctl.conf
                net.ipv4.ip_forward = 1     # 开启路由转发
            sysctl -p
            iptables -t nat -A POSTROUTING -s 192.168.200.0/24 -j SNAT --to-source 45.55.56.16
        firewall
            firewall-cmd  --add-service=openvpn --zone=public --permanent
            firewall-cmd --reload
    client配置
        o-> client.ovpn
            client
            dev tun
            proto udp
            remote 45.55.56.16 1194
            resolv-retry infinite
            nobind
            ca ca.crt
            cert client.crt
            key client.key
            ;ns-cert-type server
            cipher AES-256-CBC
            comp-lzo
            persist-key
            persist-tun
            verb 3
            mute 20
        sudo openvpn --config client.ovpn
            # --user outrun
            # --auth-nocache
            # askpass pass.txt 放密码到文件
        o-> 免密码连接
            #!/usr/bin/expect -f
            spawn sudo openvpn --config /home/outrun/.openvpn/meiqia-vpn-ldap.ovpn
            # match_max 100000
            expect "*?assword*:*"
            send -- "1234\n"
            expect "*Username:*"
            send -- "outrun\n"
            expect "*Password:*"
            expect "#"
    案例
        代理http上网                                                     # tcp连接国内服务器会被reset
            server.conf
                dev tap
                proto tcp

                push "redirect-gateway def1 bypass-dhcp"
                push "dhcp-option DNS 114.114.114.114"
                push "dhcp-option DNS 8.8.8.8"

                client-to-client
                ;explicit-exit-notify 1
            client.ovpn
                dev tap
                proto tcp
        改成用户名密码认证
            服务器
                server.conf
                    auth-user-pass-verify /etc/openvpn/server/checkpsw.sh via-env
                    verify-client-cert none
                    username-as-common-name
                    tls-auth /etc/openvpn/server/ta.key 0
                    script-security 3
                checkpsw.sh
                    #!/bin/sh
                    PASSFILE="/etc/openvpn/server/user/psw-file"
                    LOG_FILE="/etc/openvpn/server/log/openvpn-password.log"
                    TIME_STAMP=`date "+%Y-%m-%d %T"`

                    if [ ! -r "${PASSFILE}" ]; then
                      echo "${TIME_STAMP}: Could not open password file \"${PASSFILE}\" for reading." >> ${LOG_FILE}
                      exit 1
                    fi

                    CORRECT_PASSWORD=`awk '!/^;/&&!/^#/&&$1=="'${username}'"{print $2;exit}' ${PASSFILE}`

                    if [ "${CORRECT_PASSWORD}" = "" ]; then
                      echo "${TIME_STAMP}: User does not exist: username=\"${username}\", password=\"${password}\"." >> ${LOG_FILE}
                      exit 1
                    fi

                    if [ "${password}" = "${CORRECT_PASSWORD}" ]; then
                      echo "${TIME_STAMP}: Successful authentication: username=\"${username}\"." >> ${LOG_FILE}
                      exit 0
                    fi

                    echo "${TIME_STAMP}: Incorrect password: username=\"${username}\", password=\"${password}\"." >> ${LOG_FILE}
                    exit 1
                chmod 645 checkpsw.sh
                mkdir user
                mkdir log
                user/psw-file
                    outrun asdfasdf
                openvpn --genkey --secret ta.key
            客户端
                下载ta.key
                client.ovpn
                    ;cert client.crt
                    ;key client.key
                    auth-user-pass
                    tls-auth ta.key 1
## shadowsocks
    安装
        sudo yum -y install epel-release
        sudo yum -y install python-pip
        sudo pip install --upgrade pip
        sudo pip install shadowsocks
    服务器
        server.json
            {
                "server":"0.0.0.0",
                "server_port":443,
                "local_address":"127.0.0.1",
                "local_port":1080,
                "password":"asdfasdf",
                "timeout":300,
                "method":"aes-256-cfb",
                "fast_open":false,
                "workers":5
            }
        ssserver -c server.json -d start
    中继代理
        client.json
            {
                "server":"47.74.230.238",
                "server_port":443,
                "local_address": "127.0.0.1",
                "local_port":1080,
                "password":"asdfasdf",
                "timeout":300,
                "method":"aes-256-cfb"
            }
        sslocal -c client.json
    协议转换
        安装polipo
        /etc/polipo/config
            logSyslog = false
            logFile = "/var/log/polipo/polipo.log"
            socksParentProxy = "127.0.0.1:1080"
            socksProxyType = socks5
            chunkHighMark = 50331648
            objectHighMark = 16384
            serverMaxSlots = 64
            serverSlots = 16
            serverSlots1 = 32
            proxyAddress = "0.0.0.0"
            proxyPort = 8123
        polipo -c /etc/polipo/config
    客户端
        switchOmega
            SOCKS5 127.0.0.1 1080
            http 127.0.0.1 8123
        环境变量
            export http_proxy=http://127.0.0.1:8123
            export https_proxy=http://127.0.0.1:8123
## opendj
    介绍
        open source directory services for the java platform
        LDAPv3的认证系统
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
# cmdb
    # configuration management database
## bt-panel
    # 宝塔面板，服务器运维面板
## jumpserver
        # 跳板机
# 自动化
    tty.js
        # 浏览器运行命令
    jenkins
        # java实现的持续集成工具
    saltstack
        # 部署, 自动化运维
    puppet
        # 自动化运维
    selenium
        # 自动化运维
## ansible
    # python实现的自动化部署工具
    命令
        ansible
            通配符
                10.1.1.113
                '*'
                all
            -m
                command                     # 执行命令
                    -a 'uptime'
                file                        # 操作文件
                    -a "dest=/tmp/t.sh mode=755 owner=root group=root"                  # 改属性
                    -a "src=/etc/resolv.conf dest=/tmp/resolv.conf state=link"          # 软链接
                    -a "path=/tmp/resolv.conf state=absent"                             # 删除软连接
                copy
                    -a "src=/a.cfg dest=/tmp/a.cfg owner=root group=root mode=0644"
                cron                        # 定时任务
                    -a 'name="custom job" minute=*/3 hour=* day=* month=* weekday=* job="/usr/sbin/ntpdate 172.16.254.139"'
                group                       # 操作组
                    -a 'gid=2017 name=a'    # 创建组
                user                        # 操作用户
                    -a 'name=aaa groups=aaa state=present'          # 创建用户
                    -a 'name=aaa groups=aaa remove=yes'             # 删除用户
                yum
                    -a "state=present name=httpd"
                service
                    -a 'name=httpd state=started enabled=yes'       # 开机启动
                ping
                script
                    -a '/root/test.sh'
                shell
                    -a 'ps aux|grep zabbix'
                raw                         # 同shell
                get_url
                    -a 'url=http://10.1.1.116/a.ico dest=/tmp'      # 下载
                synchronize
                    -a 'src=/root/a dest=/tmp/ compress=yes'        # 推送

            o-> 例子
            ansible '*' -m command -a 'uptime'
# 版本
    mercurial
        # 简称hg，分布式版本控制系统，比git好
    clearQuest
        # IBM Rational提供的缺陷及变更管理工具。它对软件缺陷或功能特性等任务记录提供跟踪管理。提供了查询定制和多种图表报表。
    clearcase
        # 配置管理的工具，只是SCM管理工具其中的一种。是RATIONAL公司开发的配置管理工具
    spm
        # 构建sea.js项目
    bower
        # 构建前端
    redmine
## gradle
    介绍
        dsl声明设置
    命令
        gradle
            init
                --type pom                          # 转换maven项目
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
    工作流程
        fork + pull / merge request 更新代码
        commit message, pr messsage 提交说明
            pr是功能展示，前面加"WIP:"
        user.name, user.email用公司的
        pr必需有人review, assign到人, 推动review
        pr不要大
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
        代理
            git config --global https.proxy http://127.0.0.1:1080
            git config --global https.proxy https://127.0.0.1:1080
            git config --global http.proxy 'socks5://127.0.0.1:1080' 
            git config --global https.proxy 'socks5://127.0.0.1:1080'

            git config --global --unset http.proxy
            git config --global --unset https.proxy
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
    仓库
        mvnrepository.com
    依赖范围
        compile     # 默认,对编译、测试、运行有效
        test        # 对测试有效
        runtime     # 对测试和运行有效
        provided    # 编译和测试有效
        system      # 本地仓库
        import
    命令
        mvn                                     # 相当于mvn compile
            o-> 全局
            -version                            # 版本
            -e                                  # 错误详情
            help:describe                       # help插件的describe
                -Dplugin=help                   # 显示help插件的详情
                -Dfull                          # 显示完整参数
            help:effective-pom                  # 显示默认设置

            o-> 项目生成
            archetype:create                    # 创建java项目
                -DgroupId=com.outrun
                -DartifactId=erp
                -Dversion=0.0.1-SNAPSHOT
                -DarchetypeArtifactId=maven-archetype-webapp                            # 指定模板为webapp
            archetype:generate                  # 向导创建项目
            site                                # 产生html文档
            source:jar                          # 源码打包
            generate-sources                    # 生成源码, 如xdoclet
            eclipse:eclipse                     # 生成或转化成eclipse工程
            eclipse:clean                       # 清除eclipse设置
            idea:idea                           # 生成idea项目


            o-> 项目执行
            validate                            # 项目验证
            verify                              # 验证包
            compile                             # 编译
                exec:java                       # 编译完成后，执行java main方法
            test-compile                        # 编译测试代码
            test                                # 运行测试
                -skipping                       # 跳过
                    compile                     # 不编译
                    test-compile                # 不编译测试
            integration-test                    # 集成测试
            package                             # 打包
                -Dmaven.test.skip=true          # 跳过单元测试，不编译
                -DskipTests                     # 跳过单元测试，编译
            install                             # compile, package后， 保存到本地仓库
                -X                              # 显示依赖
                -Dmaven.test.skip=true          # 跳过测试
                -rf 模块名                       # 从指定模块从新开始
            clean                               # 清除编译
                install-U                       # 强制更新
                package                         # 编译成jar包
            deploy                              # install后, 上传
            jar:jar                             # 打jar包


            o-> 插件
            jetty:run                           # 引入jetty-plugin后, 运行jetty
            tomcat:run


            o-> 分析
            dependency:list                     # 列出依赖
            dependency:tree                     # 列出依赖树
            dependency:analyze                  # 依赖分析, 未使用的做标记
            dependency:resolve                  # 列出已解决的依赖
            dependency:sources                  # 下载源码
            dependency:copy-dependencies        # 得到jar包
    配置
        <groupId>                               # 包名
        <artifactId>                            # 项目名
        <version>
        <packaging>                             # 打包方式, war, jar

        <parent>                                # 父模块

        <properties>
            <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
            <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
            <java.version>1.8</java.version>
            <spring-cloud.version>Dalston.RELEASE</spring-cloud.version>
        </properties>

        <dependencies>                              # 子模块继承
            <dependency>
                <groupId>
                <artifactId>
                <version>
                    LATEST
                    ${spring-cloud.version}         #引用properties中定义的变量
                <scope>                             # 何时使用
                    compile
                    provided                        # 类似compile
                    runtime
                    test
                    system
            </dependency>
        </dependencies>

        <dependenciesManager>                       # 子模块不继承, 继承时需要声明
            <dependencies>
        </dependenciesManager>

        <build>
            <plugins>
                <plugin>
                    <groupId>
                    <artifactId>
                </plugin>
            </plugins>
        </build>
    插件
        介绍
            按顺序执行，完成maven生命周期
            无配置时调默认插件
        生命周期(lifecycle)顺序
            clean                                   # 清除target目录
            resources                               # 复制resources下文件到target/classes
            complie                                 # 包含resources, 编译java下文件到target/classes
            testResources                           # 复制test/resources下文件到target/test-classes
            testCompile                             # 包含testResources, 编译test/java下文件到target/test-classes
            test                                    # 包含resources, compile, testResources, testCompile, test
            package
            jar                                     # 打包class文件, 配置文件, 不打包lib
            install
        
        maven-clean-plugin
        maven-resources-plugin
            <plugin>  
                <groupId>org.apache.maven.plugins</groupId>  
                <artifactId>maven-resources-plugin</artifactId>  
                <version>2.6</version>  
                <executions>  
                    <execution>  
                        <id>copy-resources</id>  
                        <phase>validate</phase>
                        <goals>  
                            <goal>copy-resources</goal>  
                        </goals>  
                        <configuration>  
                            <outputDirectory>${project.build.outputDirectory}</outputDirectory>  
                            <resources>  
                                <resource>  
                                    <directory>src/main/${deploy.env}/applicationContext.xml</directory>  
                                    <excludes>
                                        <exclude>WEB-INF/*.*</exclude>
                                    </excludes>
                                    <filtering>false</filtering>  
                                </resource>  
                            </resources>  
                        </configuration>  
                        <inherited></inherited>  
                    </execution>  
                </executions>  
            </plugin>  
        maven-compiler-plugin
        maven-surefire-plugin                       # 对应test, 单元测试
        maven-dependency-plugin                     # 打包lib
        maven-jar-plugin
            <plugin>
                 <groupId>org.apache.maven.plugins</groupId>
                 <artifactId>maven-jar-plugin</artifactId>
                 <version>2.6</version>
                 <configuration>
                    <archive>
                         <manifest>
                             <addClasspath>true</addClasspath>
                             <classpathPrefix>lib/</classpathPrefix>
                            <mainClass>com.xxx.xxxService</mainClass>
                       </manifest>
                    </archive>
                </configuration>
            </plugin>
            <plugin>                                # 单独打包lib
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-dependency-plugin</artifactId>
                <version>2.10</version>
                <executions>
                    <execution>
                        <id>copy-dependencies</id>
                        <phase>package</phase>
                        <goals>
                            <goal>copy-dependencies</goal>
                        </goals>
                        <configuration>
                            <outputDirectory>${project.build.directory}/lib</outputDirectory>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        maven-assembly-plugin                       # 打包lib, 有bug缺失spring xds文件, 同级jar会冲突
            <plugin>
                 <artifactId>maven-assembly-plugin</artifactId>
                 <configuration>
                     <descriptorRefs>
                         <descriptorRef>jar-with-dependencies</descriptorRef>
                     </descriptorRefs>
                     <archive>
                         <manifest>
                             <mainClass>com.xxx.xxxService</mainClass>
                        </manifest>
                    </archive>
                </configuration>
                <executions>
                    <execution>
                        <id>make-assembly</id>
                        <phase>package</phase>
                        <goals>
                            <goal>single</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        maven-shade-plugin                          # 打包lib, 同级jar会冲突, 提示SF,DSA,RSA冲突，排除META-INF相关文件
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-shade-plugin</artifactId>
                <version>2.4.3</version>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>shade</goal>
                        </goals>
                        <configuration>
                            <filters>
                                <filter>
                                    <artifact>*:*</artifact>
                                    <excludes>
                                        <exclude>META-INF/*.SF</exclude>
                                        <exclude>META-INF/*.DSA</exclude>
                                        <exclude>META-INF/*.RSA</exclude>
                                    </excludes>
                                </filter>
                            </filters>
                            <transformers>
                                <transformer
                                        implementation="org.apache.maven.plugins.shade.resource.AppendingTransformer">
                                    <resource>META-INF/spring.handlers</resource>
                                </transformer>
                                <transformer
                                        implementation="org.apache.maven.plugins.shade.resource.AppendingTransformer">
                                    <resource>META-INF/spring.schemas</resource>
                                </transformer>
                                <transformer
                                        implementation="org.apache.maven.plugins.shade.resource.AppendingTransformer">
                                    <resource>META-INF/spring.tooling</resource>
                                </transformer>
                                <transformer
                                        implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                                    <mainClass>com.xxx.xxxInvoke</mainClass>
                                </transformer>
                            </transformers>
                            <minimizeJar>true</minimizeJar>
                            <shadedArtifactAttached>true</shadedArtifactAttached>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        maven-install-plugin
        spring-boot-maven-plugin
        gradle-maven-plugin
        protobuf-maven-plugin
        build-helper-maven-plugin                   # 用于指定自定义目录
        dockerfile-maven-plugin                     # root用户直接打包到docker images
            <plugin>
                <groupId>com.spotify</groupId>
                <artifactId>dockerfile-maven-plugin</artifactId>
                <version>1.4.10</version>
                <configuration>
                    <repository>${project.artifactId}</repository>
                    <contextDirectory>./</contextDirectory>
                    <tag>${project.version}</tag>
                    <buildArgs>
                        <JAR_FILE>mqtt/target/*.jar</JAR_FILE>
                    </buildArgs>
                </configuration>
            </plugin>
            ./Dockerfile
                FROM primetoninc/jdk:1.8

                #ADD mqtt/target/*.jar app.jar
                ARG JAR_FILE

                COPY ${JAR_FILE} /opt/app.jar

                ENTRYPOINT ["java", "-jar", "/app.jar"]
            mvn package dockerfile:build
    方案
        新项目安装
            mvn clean install -DskipTests
            mvn install -rf :模块名 -DskipTests     # 指定模块开始
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
        代理
            复制$M2_HOME/conf/settings.xml到.m2/
            settings.xml
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
# 代码
    github
    bitBucket
    gitee.com
        # 码云
    sentry
        # 产品error tracing
    gerrit
        # code review 工具
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
    www.webpagetest.org
        # 测试网站性能
## gitlab
# 应用控制
## forever
    openvpn --config openvpn.conf
            # 连接
            ## --user outrun
            ## --auth-nocache
            # askpass pass.txt 放密码到文件
## supervisor
    介绍
        监视重启
    命令
        supervisord
            # 启动后台服务
        supervisorctl
            status          # 查看所有
            update          # 重载配置
            reload          # 

            start
            stop
            restart
            start all
            stop all
            restart all

    配置
        /etc/supervisor/supervisord.conf
            [include]
            files = /etc/supervisor/conf.d/*.conf
        /etc/supervisor/conf.d/app.conf
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
            environment=ASPNETCORE_ENVIRONMENT=Production       # 环境变量
            user=root                                           # 执行的用户
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
# 监控
    prometheus
        # 监控, go实现
    grafana
        # 监控
    zabbix
        # 分布式监控
    nagios
        # 监控
    emq
        # mqtt broker, erlang开发, 管理控制台
# 个人操作
## ngrok
    # 内网穿透
## vsftp
    介绍
        默认端口21
    用户
        匿名用户
            默认为ftp或anonymous
            目录在/var/ftp
            只能下载不能上传
        本地用户
            用户名和密码与本地用户相同
            目录为该用户的登录目录
        虚拟用户
            文件配置名字和密码
            要生成认证文件
    文件
        /usr/sbin/vsftpd                    # 主程序
        /etc
            /rc.d/init.d/vsftpd             # initd启动脚本
            /vsftpd.conf                    # 主配置
            /vsftpd.ftpusers                # 用户黑名单, 一行一名字
            /vsftpd.user_list               # 用户黑/白名单, 一行一名字
            /pam.d/vsftpd                   # pam认证文件
        /var
            /ftp                            # 匿名用户主目录
            /ftp/pub                        # 匿名用户的下载目录
    默认用户与组
        用户
            adduser -d /var/ftp -g ftp -s /sbin/nologin ftp
        组
            ftp
    命令
        systemctl start vsftpd
    使用
        /etc/vsftpd.conf
            anonymous_enable=YES            # 允许匿名用户
            local_enable=YES                # linux用户可登录, 虚拟用户可登录
            write_enable=YES                # 可写
            local_umask=022                 # user文件权限, 默认077
            dirmessage_enable=YES           # 显示目录信息
            xferlog_enable=NO               # 记录上传/下载日志
            connect_from_port_20=YES        # 确保用20端口传输
            ls_recurse_enable=NO            # 允许ls -R
            allow_writeable_chroot=NO
            listen=NO
            listen_ipv6=YES                 # 包含ipv4,和listen只能有一个YES

            pam_service_name=vsftpd
            local_root=/home/outrun/Downloads                       # linux用户默认目录。会先登录到用户目录，再切换到这里
            ftp_username=ftp                # 匿名用户名，默认ftp
            tcp_wrappers=NO                 # 结合tcp_wrapper限制ip登录
                /etc
                    /hosts.allow            # 允许地址
                    /hosts.deny             # 拒绝地址
        useradd -d /home/ftp ftp
        mkdir /home/ftp && chown ftp /home/ftp && chgrp ftp /home/ftp
        systemctl restart vsftpd
        打开tcp, udp端口21, 20
    用户
        匿名登录
            /etc/vsftpd/vsftpd.conf
                anonymous_enable=YES
                anon_root=/home/outrun/Downloads                    # 匿名用户默认目录
                anon_upload_enable=YES      # 匿名可写，要求write_enable=YES
                anon_mkdir_write_enable=YES # 匿名创建文件夹
                anon_other_write_enable=YES # 匿名可删除、重命名
                anon_umask=000              # 如创建077文件，anon_umask=022时，则为055 
            chmod 777 dir1

        本地用户登录
            /etc/vsftpd/vsftpd.conf
                anonymous_enable=NO
                userlist_enable=YES
                userlist_deny=YES           # YES时user_list为黑名单
                userlist_file=/etc/vsftpd/user_list

                chroot_local_user=YES       # 默认可以chroot到用户home。YES时, chroot_list_file指定黑名单
                chroot_list_enable=YES
                chroot_list_file=/etc/vsftpd/chroot_file            # 名单用户只能访问自己home
                allow_writeable_chroot=YES  # 不限制chroot目录可写
            /etc/vsftpd/ftpusers
            /etc/vsftpd/user_list
                注释root
        虚拟用户
## SimpleHTTPServer
    pythom -m SimpleHTTPServer 8080
## pyshark
    介绍
        包嗅探

