---
Categories: ["运维"]
title: "运维"
date: 2018-10-10T17:33:07+08:00
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

# 套件
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
    fushsia
            # goolge os
# 虚拟化
    vitualbox
    vagrant
            # 用一个virtualbox虚拟机来快速部署开发环境
    vmware
    parallels desktop
            # 苹果
    kvm
    xen
    gnome boxes
    docker
    hyper-v
            # 微软
# 版本
    svn
    git
    mercurial
            # 简称hg，分布式版本控制系统，比git好
    clearQuest
            # IBM Rational提供的缺陷及变更管理工具。它对软件缺陷或功能特性等任务记录提供跟踪管理。提供了查询定制和多种图表报表。
    clearcase
            # 配置管理的工具，只是SCM管理工具其中的一种。是RATIONAL公司开发的配置管理工具
    ant
    maven
    gradle
            # dsl声明设置
    spm
            # 构建sea.js项目
    bower
            # 构建前端
    redmine
# 工具
## vsftp
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

    openvpn --config openvpn.conf
            # 连接
            ## --user outrun
            ## --auth-nocache
            # askpass pass.txt 放密码到文件
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
## pyshark
    介绍
            包嗅探
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