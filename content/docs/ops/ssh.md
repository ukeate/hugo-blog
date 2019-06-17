---
Categories: ["运维"]
title: "SSH"
date: 2018-10-11T18:11:27+08:00
---

# ssh（secure shell）：特点
        1.加密和压缩：http与ftp都是明文传输
        2.ssh有很多子协议，实现不同功能：如sftp,scp
        3.端口:22
# 配置
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
# 命令
        ssh outrun@10.1.1.1
                # -p 22 端口
                # PubkeyAuthentication=no 不公钥登录
# 免登录
    1> 
            ssh-keygen -t rsa                        # 一直回车，生成~/.ssh/id_rsa 与 id_rsa.pub两个文件
    2> 
            ssh-copy-id -i 192.168.56.11                # 这样就可以免登录访问192.168.56.11了
                                                    ## ssh-copy-id -i localhost　免登录自己
                                            
            或
            把A机下的1中生成的id_rsa.pub的内容复制到B机下，在B机的.ssh/authorized_keys文件里，这样可以多个主机对B机进行免登录
# sshpass
    介绍
            命令行密码登录
    命令
            sshpass  -p zlycare@123 ssh zlycare@10.162.201.58