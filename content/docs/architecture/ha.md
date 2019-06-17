---
Categories : ["架构"]
title: "架构-高可用"
date: 2018-10-10T17:15:05+08:00
---


# high-availability linux
# 目标
        reliability: 可靠性
        availability: 可用性
        serviceability: 可服务性
                ras: remote access service(远程服务访问)

# 术语
        节点(node): 唯一主节点，多个备用节点
        资源(resource): 是节点可控制的实体，主节点发生故障时，可以被其它节点接管
                例如:
                        磁盘分区
                        文件系统
                        ip地址
                        应用程序服务
                        nfs文件系统
        事件(event): 集群中可能发生的事件
                例如:
                        系统故障
                        网络连通故障
                        网卡故障
                        应用程序故障
        动作(action): 事件发生时ha的响应方式
                例如: 用shell 脚本对资源进行转移

# 心跳
    heartbeat
    keepalived
            vrrp
                    # virtual router redundancy protocol 虚拟路由器冗余协议
                    # 解决静态路由出现的闪单点故障问题，它能够保证网络的不间断．稳定运行
# 负载
    方法
            dns轮循

            java nio
            erlang语言
            linux epoll
            bsd kqueue
            消息队列、事件通知
            c/c++下ace, boost.asio, libev(libevent)
            服务器mina, jetty, node.js, netty
            java协程框架 quasar kilim
    haproxy
            监控页面
                    /status 
    nginx
    varnish
    squid 