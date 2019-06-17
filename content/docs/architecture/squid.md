---
Categories : ["架构"]
title: "Squid"
date: 2018-10-11T16:16:37+08:00
---

# 配置文件
        /etc/squid/squid.conf
# 代理类型
        普通代理
        透明代理
        反向代理
# 缓存
        动态资源
        静态资源

# 参考资料
        squid 透明代理详解
# 配置
    # squid.conf
    http_port 3128                                                # squid服务端口
    icp_port 3130                                                # udp端口,用来接收和发送ICP消息
    cache_dir ufs /var/spool/squid                                # 缓存目录, 写入方式有aufs与ufs两种,aufs使用大量线程异步进行磁盘i/o操作
    cache_access_log /var/log/squid/access.log 
    cache_log /var/log/squid/cache.log 
    cache_store_log /var/log/squid/store.log 
    pid_filename /var/run/squid.pid                        # 日志文件位置

    #auth_param basic children 5 
    #auth_param basic realm Squid proxy-caching web server 
    #auth_param basic credentialsttl 2 hours                 # 关闭认证，认证一般不需要

    cache_effective_user squid 
    cache_effective_group squid  
    cache_mgr youraccount@your.e.mail                        # 设置squid用户及用户组、管理员账号

    cache_mem 128 MB                                        # 运行内存配置

    cache_swap_low 90 
    cache_swap_high 95 
    maximum_object_size 4096 KB                        ＃ 与磁盘容量相关的配置，90、95为百分比，磁盘大时4096 KB可以改成32768 KB

    maximum_object_size_in_memory 8 KB                ＃ 内存缓存资料大小

    以下为定义acl(访问控制列表)
            ＃ 语法为:acl<acl> <acl名称> <acl类型> <配置的内容> 
    acl All src 0/0  
    acl Manager proto cache_object  acl Localhost src 127.0.0.1/32  
    acl Safe_ports port 80 21 443 563 70 210 280 488 591 777 1025-65535
    acl SSL_ports 443 563  
    acl CONNECT method CONNECT  
    acl MyNetwork src 192.168.0.0/16  

    以下为利用前面定义的acl,定义访问控制规则
    http_access allow Manager Localhost 
    http_access deny Manager 
    http_access deny !Safe_ports 
    http_access deny CONNECT SSL_ports 
    http_access allow MyNetwork 
    http_access deny All

    例子: 禁止访问sina
    acl sina dstdomain .sina.com.cn .sina.com 
    http_access deny sina 
    或 
    acl sina dst 58.63.236.26 58.63.236.27 58.63.236.28 58.63.236.29 58.63.236.30 58.63.236.31 58.63.236.32 58.63.236.33 58.63.236.34 58.63.236.35 58.63.236.36 58.63.236.37 58.63.236.38 58.63.236.39 58.63.236.49 58.63.236.50 
    http_access deny sina 
    或 
    acl sina dst www.sina.com.cn 
    http_access deny sina

    例子: 禁止来自某些ip的访问
    acl zhang src 192.168.63.6/32 
    http_access deny zhang

    例子: 禁止在某些时段访问 
    acl Working_hours MTWHF 08:00-17:00 
    http_access allow Working_hours 
    http_access deny !Working_hours

    例子: 禁止某个代理客户建立过多连接  
    acl OverConnLimit maxconn 
    http_access deny OverConnLimit

    定义与其它代理服务器的关系,语法: <cache_peer> <主机名称> <类别> <http_port> <icp_port> <其它参数> 
    cache_peer 192.168.60.6 parent 4480 7 no-query default

    #设置与其它代理服务器的关系: <cache_peer_access> <上层 Proxy > <allow|deny> <acl名称> 
    #cache_peer_access 192.168.60.6 allow aclxxx  
    #cache_peer_access 192.168.60.6 deny !aclxxx
    coredump_dir /var/spool/squid                                        # 崩溃存储目录
# 使用
    step1 检查配置文件
            squid -k parse                                
    step2  初始化cache 目录
            squid -z(X)                                # X会显示过程
    step3 启动squid
            service squid start
            或
            /usr/local/squid/sbin/squid -sD

    停止squid
            squid -k shutdown

    重新载入配置
            squid -k reconfigure

    滚动日志
            squid -k rotate
                    # 
# 案例
    透明代理
        step1 检查配置文件
                squid -k parse                                
        step2  初始化cache 目录
                squid -z(X)                                # X会显示过程
        step3 启动squid
                service squid start
                或
                /usr/local/squid/sbin/squid -sD

        停止squid
                squid -k shutdown

        重新载入配置
                squid -k reconfigure

        滚动日志
                squid -k rotate
                        # 
    代理
        squid.conf
                http_port 3128
                http_access allow all
                或
                http_port 3128
                http_access deny all前面添加
                acl 192.168.0.42 src 192.168.0.0/24
                http_access allow 192.168.0.42                        ＃ 192.168.0.42为允许的ip
