---
Categories : ["架构"]
title: "Lvs"
date: 2018-10-11T15:31:54+08:00
---

# 介绍
    第四层开始负载(可以建立到三层负载)

    第四层负载
            socket进必须连lvs

# 模式
        tun
                # lvs负载均衡器将请求包发给物理服务器，后者将应答包直接发给用户
        net
                # 请求和应答都经过lvs
        dr
                # 不要隧道结构的tun
# 使用
    DR模式 centos6

            yum install-y gcc gcc-c++ makepcre pcre-devel kernel-devel openssl-devel libnl-devel popt-devel
            modprobe -l |grep ipvs
                    # 检查内核是否集成
            echo "1" > /proc/sys/net/ipv4/ip_forward
                    # 开启路由转发
            安装ipvsadm
                    http://www.linuxvirtualserver.org/software/kernel-2.6/ipvsadm-1.26.tar.gz
            安装keepalived
                    http://www.keepalived.org/software/keepalived-1.2.7.tar.gz
                    ./configure --prefix=/usr/local/keepalived

                    cp  /usr/local/keepalived/etc/rc.d/init.d/keepalived        /etc/init.d/
                    cp /usr/local/keepalived/etc/sysconfig/keepalived        /etc/sysconfig/
                    mkdir /etc/keepalived/
                    cp /usr/local/keepalived/etc/keepalived/keepalived.conf        /etc/keepalived/
                    cp /usr/local/keepalived/sbin/keepalived        /usr/sbin/

                    o-> 配置文件/etc/keepalived/keepalived.conf
                    ! Configuration File forkeepalived
                    global_defs {
                    notification_email {
                    test@sina.com    #故障接受联系人
                    }
                    notification_email_from admin@test.com  #故障发送人
                    smtp_server 127.0.0.1  #本机发送邮件
                    smtp_connect_timeout 30
                    router_id LVS_MASTER  #BACKUP上修改为LVS_BACKUP
                    }
                    vrrp_instance VI_1 {
                    state MASTER    #BACKUP上修改为BACKUP
                    interface eth0
                    virtual_router_id 51  #虚拟路由标识，主从相同
                    priority 100  #BACKUP上修改为90
                    advert_int 1
                    authentication {
                    auth_type PASS
                    auth_pass 1111  #主从认证密码必须一致
                    }
                    virtual_ipaddress {    #Web虚拟IP（VTP）
                    172.0.0.10
                    }
                    }
                    virtual_server 172.0.0.10 80 { #定义虚拟IP和端口
                    delay_loop 6    #检查真实服务器时间，单位秒
                    lb_algo rr      #设置负载调度算法，rr为轮训
                    lb_kind DR      #设置LVS负载均衡DR模式
                    persistence_timeout 50 #同一IP的连接60秒内被分配到同一台真实服务器
                    protocol TCP    #使用TCP协议检查realserver状态
                    real_server 172.0.0.13 80 {  #第一个web服务器
                    weight 3          #节点权重值
                    TCP_CHECK {      #健康检查方式
                    connect_timeout 3 #连接超时
                    nb_get_retry 3    #重试次数
                    delay_before_retry 3  #重试间隔/S
                    }
                    }
                    real_server 172.0.0.14 80 {  #第二个web服务器
                    weight 3
                    TCP_CHECK {
                    connect_timeout 3
                    nb_get_retry 3
                    delay_before_retry 3
                        }
                    }
                    }

                    service keepalived restart
                    
            启动脚本 /etc/init.d/real.sh
                    #description : start realserver
                    VIP=172.0.0.10
                    . /etc/init.d/functions
                    case "$1" in
                    start)
                    /sbin/ifconfig lo:0 $VIP broadcast $VIP netmask 255.255.255.255 up
                    echo "1" >/proc/sys/net/ipv4/conf/lo/arp_ignore
                    echo "2" >/proc/sys/net/ipv4/conf/lo/arp_announce
                    echo "1" >/proc/sys/net/ipv4/conf/all/arp_ignore
                    echo "2" >/proc/sys/net/ipv4/conf/all/arp_announce
                    echo "LVS RealServer Start OK"
                    ;;
                    stop)
                    /sbin/ifconfig lo:0 down
                    echo "0" >/proc/sys/net/ipv4/conf/lo/arp_ignore
                    echo "0" >/proc/sys/net/ipv4/conf/lo/arp_announce
                    echo "0" >/proc/sys/net/ipv4/conf/all/arp_ignore
                    echo "0" >/proc/sys/net/ipv4/conf/all/arp_announce
                    echo "LVS RealServer Stoped OK"
                    ;;
                    *)
                    echo "Usage: $0 {start|stop}"
                    exit 1
                    esac
            
            o-> 开机启动
                    chmod +x /etc/init.d/real.sh
                    /etc/init.d/real.sh start
                    echo "/etc/init.d/real.sh start" >> /etc/rc.local
            o-> 测试
                    service httpd start
                    echo "1" > /var/www/html/index.html
                    service iptables stop
                    setenforce 0
                            # 关闭selinux
            o-> 其他命令
                    ipvsadm -ln
                            # 集群中服务器ip信息
                    ip addr
                            # 显示VIP当前绑定的服务器
                    tail -f /var/log/messages
                            # 日志