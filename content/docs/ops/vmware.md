---
Categories: ["运维"]
title: "Vmware"
date: 2018-10-11T18:17:12+08:00
---


# 安装
        安装后会创建两个虚拟网卡
# 设置
        edit -> preferences -> Hot Keys 设置退出快捷键
# 网络连接方式
        1.vm9自带的virtual network editor中选择桥接到有线网卡
        2.vm -> setting -> network adapter选项设置
                bridged（桥接）:与主机平等，可以设置为同一个网段相互访问
                nat:通过虚拟网卡连接主机，共享网络
                host-only:单机模式
        
        
