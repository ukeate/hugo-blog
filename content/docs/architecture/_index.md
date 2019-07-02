---
title: 架构
type: docs
---

# 名词
    Alb        automaticLoopBack 自动回环，虚拟接口
    sdn        software defined network 软件定义网络


# 模块
    服务
        注册
        发现
    性能/ha
        区域感知load balance
        故障切换
        故障注入
        熔断
        健康检查
        流量拆分和推出
    策略
        quota
            网络数据
            api调用
        服务准入条件
        路由规则
        容错
        访问策略
    安全
        服务间认证(auth)
        tls
        细粒度权限控制
    配置
        啮合层
            # 服务与网络间加入透明层，用来功能配置
    查看
        服务网可视化
        monitor
        log
        tracing
    迭代
        部署
        版本控制
    平台支持
        # 如aws, k8s, mesos
    通讯能力
        # http/1.1 http/2 grpc tcp


# mesh
    # 服务网格
## lstio
    #google IBM, lyft开源，基于envoy
    组成
        数据面板
        控制面板
## linkerd
    # buoyant出品
## fingle
    # twitter出品
## envoy
    # lyft出品
## nginmesh
    # nginx推出


# paas
    # platform as a service
## cloudStack
    # 托管在apache的开源、高可用、高扩展性的云计算平台
    # 支持主流hypervisors
    # 一个开源云计算解决方案，可以加速iaaS的部署、管理、配置
## kubernetes
    # google开源的，在docker技术上，为容器化应用提供:
    作用
        资源调度
        部署运行
        服务发现
        扩容缩容
## cloudfoundry
    # 根据应用模板，动态生成很多tomcat, mysql, nosql, 动态控制这些实例的启停。
## openstack
    # 云操作系统，管理虚拟资源
## hsf
    # high-speed service framework
    特点
        不增加中间点(稳定，高度可伸缩)
    结构
        注册服务信息，推送服务地址
        基于osgi


# rpc
    # 远程过程调用 remote procedure call
## hsf
    # 高速服务框架 (socket直连)
## thrift
## Dubbo
## cxf
    常识
        自己内部整合spring(但是不耦合)
    支持的协议
        soap1.1/1.2
        post/http
        restful
        http
    使用
        导入cxf包
        方法1      # 不支持注解
            String address="http://localhost:8888/hello";
                ServerFactoryBean factoryBean=new ServerFactoryBean();
                factoryBean.setAddress(address);
                factoryBean.setServiceBean(new MyWS());
                factoryBean.create();
        方法2      # 支持注解,wsdl文件中类型不再单独schema文件
            ServerFactoryBean factoryBean = new JaxWsServerFactoryBean      # java and xml web service
        日志    # 记录握手信息(访问wsdl文件)
                ## 看日志记录得到 soap
            serverFactoryBean.getInInterceptors().add(new LoggingInInterceptor());
            serverFactoryBean.getOutInterceptors().add(new LoggingOutInterceptor());
    整合spring
        o-> cxf2.4.4.jar/schemas/jaxws.xsd中找到命名空间"http://cxf.apache.org/jaxws"
        o-> 配置applicationContext.xml，加入cxf的命名空间http://cxf.apache.org/jaxws,schema地址为http://cxf.apache.org/schemas/jaxws.xsd。
            并且在eclipse中配置schema约束文件的路径
                # 该xsd约束文件的url地址用的是包地址,不规范
        o-> applicationContext.xml中配置
            <bean id="studentService" class="test.spring.StudentServiceImpl"/>
                # 用于：自身调用，被spring引用
            <jaxws:server serviceClass="test.spring.StudentService" address="/student">
                # address配置服务的名称即可(web.xml的servlet中配置了服务的实际访问地址)
                ## serviceClass配置的才是真正的服务，既然它是接口，那么webService注解也应该写在接口上
                <jaxws:serviceBean>
                    <ref bean="studentService"/>
                <jaxws:inInterceptors>
                    <bean class="org.apache.cxf.interceptor.LoggingInInterceptor" />
                <jaxws:outInterceptors>
                    <bean class="org.apache.cxf.interceptor.LoggingOutInterceptor" />
        o-> web.xml中配置servlet
             <servlet>
                  <servlet-name>springWS
                  <servlet-class>org.apache.cxf.transport.servlet.CXFServlet        # 在cxf-2.4.4.jar包中
                  <load-on-startup>1
             <servlet-mapping>
                  <servlet-name>springWS
                  <url-pattern>/ws/*
        o-> web.xml中配置spring监听器

## spring cloud
## grpc
## protobuf
    # 通信协议
    命令
        protoc -I. -I-I$GOPATH/src  --go_out=plugins=grpc:. *
            # -I import目录
        protoc --grpc-gateway_out=.
    插件
        安装
            # go build 出protoc-gen-go后，放入go/bin下
        protoc-gen-go
            # 编译proto文件
        protoc-gen-grpc-gateway
            # http服务


# rmi
    # java远程调用 remote method invocation
## hessian


# soa
    # 面向服务架构 service oriented architecture
## eai
        # Enterprise Application Integration 建立底层结构将异构应用集成
## esb
        # Enterprise Service Bus 企业服务总线， 是连接中枢


# 粘合层
## zookeeper
    # 服务发现
    exhibitor
        # supervisor for zk
## gearman
    # 把工作委派给其他机器
## etcd
    # k8s中用到的服务发现仓库
## mesos
    # apache开源的分布式资源管理框架


# tracing
## zipkin
## opentracing


# monitor
## spy.js
    # webstorm用的监控工具
## alinode
    # 朴灵写的运行时性能管理工具
## oneapm
    # 监控node性能
    功能
        接口响应时间
        数据库方法时间
        外部服务时间
        单请求的耗时比
## nscale
    # 可扩展容器，用node.js和docker实现

# ha
    # high-availability linux
    目标
        reliability: 可靠性
        availability: 可用性
        serviceability: 可服务性
            ras: remote access service(远程服务访问)
    术语
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

## 心跳
### heartbeat
    2.0模块
        heartbeat: 节点间通信检测模块
        ha-logd: 集群事件日志服务
        CCM(Consensus CLuster Membership): 集群成员一致性管理模块
        LRM(Local Resource Manager): 本地资源管理模块
        Stonith Daemon: 使出现问题的节点从集群资源中脱离
        CRM(Cluster Resource management): 集群资源管理模块
        Cluster policy engine: 集群策略引擎
                用于实现节点与资源之间的管理与依赖关系
        Cluster transition  engine: 集群转移引擎

    3.0拆分之后的组成部分
        Heartbeat: 负责节点之间的通信
        Cluster Glue: 中间层，关联Heartbeat 与 Pacemaker,包含LRM 与 stonith
        Resource Agent: 控制服务启停，监控服务状态脚本集合，被LRM调用
        Pacemaker: 也就是曾经的CRM，包含了更多的功能
            管理接口:
                crm shell
                一个使用ajax web 的web窗口
                hb_gui图形工具
                DRBD-MC, 一个基于java的工具

    版本差异
        与1.x相比，2.1.x版本变化
            保留原来所有功能
            自动监控资源
            对各资源组进行独立监控
            同时监控系统负载
                自动切换到负载低的node上

### keepalived
    vrrp
        # virtual router redundancy protocol 虚拟路由器冗余协议
        # 解决静态路由出现的闪单点故障问题，它能够保证网络的不间断．稳定运行
## 负载
    # load balance
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
### haproxy
    监控页面
            /status
### nginx
### varnish
### squid
### lvs
    介绍
        第四层开始负载(可以建立到三层负载)

        第四层负载
            socket进必须连lvs

    模式
        tun
            # lvs负载均衡器将请求包发给物理服务器，后者将应答包直接发给用户
        net
            # 请求和应答都经过lvs
        dr
            # 不要隧道结构的tun
    使用
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
# 通信服务
## log
### elk
            # elasticsearch, logstash, kibana
### log.io
## mq
### rabbitMQ
    install
            yum install rabbitmq-server
    命令
            添加用户:
                    rabbitmqctl add_user rainbird password
            添加权限:
                    rabbitmqctl set_permissions -p "/" rainbird ".*" ".*" ".*"
            删除测试用户:
                    rabbitmqctl delete_user guest
    原理
        虚拟主机 virtual host: 用户通过虚拟主机进行权限控制(如禁止A组访问B组的交换机)
                ＃ 默认虚拟主机为"/"
                队列 queue: 由生产者(producers)通过程序建立，再通过消费者(consuming)连接取走
                        消息:
                                路由键 routing key
                交换机 exchange: 负责把消息放入队列
                        绑定 binding(路由规则): 如指明交换机中具有路由键"X"的消息要到名为"Y"的队列中去
                                # 如果同一个键对应多个队列，则复制后分别发送

        功能
                持久化
                        队列和交换机创建时指定标志durable,指定队列和交换机重启生重建
                                ＃ 如果绑定了durable的队列和durable的交换机，该绑定自动保留
                                ＃ non-durable的交换机与durable的队列不能绑定
                                ＃ 一但创建durable标志，不能修改
                        消息发布到交换机时，指定标志Delivery Mode=2,这样消息会持久化
    使用(原文http://adamlu.net/rabbitmq/tutorial-one-python)
            安装python 与插件支持
                    pip
                    python-pip git
                    python-pika
            rabbitmq-server start
            send.py
                #!/usr/bin/env python
                import pika

                connection = pika.BlockingConnection(pika.ConnectionParameters(
                        host='localhost'))
                channel = connection.channel()

                channel.queue_declare(queue='hello')

                channel.basic_publish(exchange='',
                                    routing_key='hello',
                                    body='Hello World!')
                print " [x] Sent 'Hello World!'"
                connection.close()
                        receive.py
                                #!/usr/bin/env python
                import pika

                connection = pika.BlockingConnection(pika.ConnectionParameters(
                        host='localhost'))
                channel = connection.channel()

                channel.queue_declare(queue='hello')

                print ' [*] Waiting for messages. To exit press CTRL+C'

                def callback(ch, method, properties, body):
                    print " [x] Received %r" % (body,)

                channel.basic_consume(callback,
                                    queue='hello',
                                    no_ack=True)

                channel.start_consuming()
### jafka
### kafaka
    介绍
        scala语言编写
    架构
            push/pull队列架构，适合异构集群
            高吞吐率
            分布式
            支持数据并行到hadoop
    工具
        manager # 监控
### nsq
    介绍
        go
    工具
        admin   # 监控
### memcacheQ
### zeroMQ
### activeMQ
### beanstalkd
### mqtt
        # 最早由ibm提供的，二进制消息的mq
## 任务
### quartz
    # java
### celery
    # python
### rundeck
    # java

# 存储服务
    存储的概念和术语
        scsi: 小型计算机系统接口(Small Computer System Interface)
        fc: 光纤通道(Fibre channel)
        das: 直连式存储(Direct-Attached Storage)
        nas: 网络接入存储(Network-Attached Storage)
        san: 存储区域网络(Storage Area Network)
            连接设备: 路由,  光纤交换机, 集线器(hub)
            接口: scsi fc
            通信协议: ip scsi

## iscsi
    # internet scsi
    优点
        可以网络传输
        服务器数量无限
        在线扩容．动态部署
    架构
        控制器架构: 专用数据传输芯片．专用RAID数据校验芯片．专用高性能cache缓存和专用嵌入式系统平台
        iscsi连接桥架构:
            前端协议转换设备(硬件)
            后端存储(scsi磁盘阵列．fc存储设备)
        pc架构
            存储设备搭建在pc服务器上，通过软件管理成iscsi, 通过网卡传输数据
            实现
                以太网卡 + initiator软件
                toe网卡 + initiator软件
                iscsi HBA卡
    iscsi系统组成
        iscsi initiator 或　iscsi hba
        iscsi target
        以太网交换机
        一台或多台服务器
## fastdfs
    # 开源分布式文件系统

## squid
    配置文件
        /etc/squid/squid.conf
    代理类型
        普通代理
        透明代理
        反向代理
    缓存
        动态资源
        静态资源
    参考资料
        squid 透明代理详解
    配置
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
    使用
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
    案例
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
        代理
            squid.conf
                http_port 3128
                http_access allow all
                或
                http_port 3128
                http_access deny all前面添加
                acl 192.168.0.42 src 192.168.0.0/24
                http_access allow 192.168.0.42                        ＃ 192.168.0.42为允许的ip
## varnish
    # 反向代理，web缓存


