
# 名词
    Alb        automaticLoopBack 自动回环，虚拟接口
    sdn        software defined network 软件定义网络

# 服务网格
    # service mesh
## service fabric
    # 微软
## lstio
    #google IBM, lyft开源，基于envoy
    组成
        数据面板
        控制面板
## traefik
    # go实现，多后台如k8s, swarm, marathon, mesos
## linkerd
    # buoyant出品
## conduit
    # 面向k8s轻量化mesh
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
## cloudfoundry
    # 根据应用模板，动态生成很多tomcat, mysql, nosql, 动态控制这些实例的启停。
## openstack
    # 云操作系统，管理虚拟资源
# 分布式服务(容器调度编排)
|特性             |dubbo                      |spring cloud                        |k8s|
|:----------------|:--------------------------|:-----------------------------------|:--|
|配置管理          |-                          |config                              |k8s configMap|
|服务发现          |zookeeper                  |eureka, consul, zookeeper           |k8s services
|负载均衡          |自带                        |ribbon                              |k8s services
|网关              |-                          |zuul                                |k8s services
|分布式追踪        |-                          |spring cloud sleuth                 |open tracing
|容错              |不完善                     |hystrix                             |k8s health check
|通信方式          |rpc                        |http, message                       |
|安全模块          |-                          |spring cloud security               |-
|分布式日志        |                           |ELK                                 |EFK
|任务管理          |                           |spring batch                        |k8s jobs
## kubernetes
    # google开源的，borg的发展，在docker技术上，管理容器化应用
    特点
        不限语言
        无侵入, 服务只写业务
        适合微服务                       # 调整服务副本数, 横向扩容
        无缝迁移到公有云                  # cluster ip实现不改配置迁移
        自动化资源管理
            服务发现，用dns解析服务名
            内嵌负载均衡
            部署实施
            治理
            监控
            故障发现、自我修复
            透明服务注册、发现
            服务滚动升级、在线扩容, 根据负载自动扩容缩容
            可扩展资源自动调度、多粒度资源配额
        多层安全防护、准入
        多租户
        完善的工具

        pod运行容器
        etcd保存所有状态
    架构
        cluster
            master
                api server              # 对外http rest接口, 管理资源对象(pod, RC, service)增删改查
                controller manager      # 管理控制器, node, pod, endpoint, namespace, serviceAccount, resourceQuota自动化管理
                scheduler               # 接收controller manager命令执行pod调度
                etcd                    # 配置
            node                        # 一master多node
                特点
                    node宕机，pod调度到其它节点
                pod                     # 一node几百个pod, 基本操作单元，代表一个运行进程，内部封装一个(或多个紧密相关的)容器。
                    特点
                        pod内通信高效，放密切相关服务进程
                        可以判断一组相关容器的状态(用pause)
                        pause解决共享ip、容器通信、共享文件的问题
                        pod间通信用虚拟二层协议(flannel, openvswitch)实现
                        普通pod在etcd存储，再调度到某node实例化，静态pod在node中存储，在node实例化
                        对pod可进行资源(cpu,内存)限额
                    label               # 标签，用标签选择器选择。key和value由用户指定，可附加到node, pod, service, rc等
                    pause容器            # 根容器，共享网络栈、挂载卷
                docker/rocket           # 容器
                kubelet                 # master监视pod, 创建、修改、监控、删除
                kube-proxy              # 代理pod接口
                fluentd                 # 日志收集、存储、查询
                kube-dns                # 服务dns解析
    概念
        service                         # 服务网关
            特点
                唯一名字
                唯一虚拟ip(cluster ip, service ip, vip)                  # 可多端口，每端口有名字
                提供远程服务              # 目前socket
                应用到一组pod
        event                           # 探针检测失败记录，用于排查故障
        rc                              # replication controller
            副本数
            筛选标签
            pod模板
            改变pod镜像版本，滚动升级
        replica set                     # 1.2 rc升级, 支持基于集合的标签选择。被deployment使用
        deployment                      # pod编排, rc升级
            特点
                查看pod部署进度
        HPA                             # horizontal pod autoscaler, 自动扩容缩容
            指标
                cpu utilization percentage                              # 1分钟内利用率平均值
                应用自定义指标(tps, qps)
        volume
            emptyDir
            hostPath
            gcePersistentDisk
            awsElasticBlockStore
            NFS
            persistent volume
            namespace
            annotation
    动作
        扩容
            创建rc自动创建pod, 调度到合适的node
                pod定义
                副本数
                监控label                # 筛选pod得到数量
    命令
        kubectl
            logs
                kubectl logs --tail=1000 appID1
                    # 查看日志
            exec
                kubectl exec -it appID1 /bin/sh
                    # 交互命令进入app
            create
                -f mysql-rc.yaml        # 创建rc
                -f mysql-svc.yaml       # 创建service
            get
                rc                      # 查看rc
                pods
                pod
                    kubectl get pod -l app=app1 -o wide
                        # 查看pod app状态
                services
                svc                     # 查看service, 包含cluster ip
                nodes
                endpoints               # service pod的ip:端口
            describe                    # 详情
                node
                deployments
            scale                       # pod扩容或缩容
            autoscale                   # 创建hpa对象
                deployment
            rolling-update              # pod滚动升级
            apply                       # 应用配置
                -f
    配置
        用yaml或json定义
        pod
            kind: Pod                   # 表明是Pod
            metadata:
                name: myweb             # pod名
                labels:
                    name: myweb         # 标签
## spring cloud
    介绍
        spring boot基础上构建，快速构建分布式系统
        面向云环境架构(云原生)    # 适合在docker和paas部署
    功能
        配置管理
        服务发现
        熔断
        智能路由
        微代理
        控制总线
        分布式会话
        集群状态管理
    子项目
        spring cloud netflix    # 对netflix oss套件整合
            eureka     # 服务治理(注册、发现)
            hystrix    # 容错管理
            ribbon     # 软负载均衡(客户端)
            feign      # 基于hystrix和ribbon，服务调用组件
            zuul       # 网关，智能路由、访问过滤
            archaius   # 配置
        spring cloud config     # 应用配置外部化, 推送客户端配置
        spring cloud bus        # 消息总线，传播集群状态变化来触发动作
        spring cloud security   # 应用安全控制
        spring cloud consul     # 封装consul(服务发现与配置, 与docker无缝)
        spring cloud sleuth     # 跟踪
## Dubbo
    介绍
        阿里开源，分布式服务框架，rpc方案，soa治理
    功能
        远程通讯    # 多协议，多种长连接nio框架封装
        集群容错    # 负载均衡，容错，地址路由，动态配置
        自动发现    # 注册中心
    节点
        容器(container)
        提供者(provider)
        消费者(consumer)
        注册中心(registry)
        监控中心(monitor)
        调用关系
            容器启动提供者
            提供者注册
            消费者订阅
            注册中心返回地址列表, 长连接更新
            消费者软负载均衡挑选列表中提供者
            提供者和消费者累计调用次数和时间，定时发送到监控中心
    容错机制
        failover    # 默认，失败自动切换
        failfast    # 立即报错，用于幂等写操作
        failsafe    # 忽略
        failback    # 定时重发
        forking     # 并行多个取最快(any)
        broadcast   # 逐个多个，异常退出
    连接方式
        广播
            服务端配置 applicationContext-service.xml
                <dubbo:application name=”taotao-manager-service” />
                <dubbo:registry address=”multicast://224.5.6.7:1234” />
                <dubbo:protocol name=”dubbo” port=”20880” />
                <dubbo:service interface=”com.taotao.manager.service.TestService” ref=”testServiceImpl” />
            客户端配置 springMVC.xml
                <dubbp:application name=”taotao-manager-web” />
                <dubbo:registry address=”multicast://224.5.6.7:1234” />
                <dubbo:service interface=”com.taotao.manager.service.TestService” id=”testService”
                timeout=”10000000” />
        直连
            服务端配置
                <dubbo:application name=”taotao-manager-service” />
                <dubbo:registry address=”N/A” />
                <dubbo:protocol name=”dubbo” port=”20880” />
                <dubbo:service interface=”com.taotao.manager.service.TestService” ref=”testServiceImpl” /> applicationContext-service.xml
            客户端配置 springMVC.xml
                <dubbp:application name=”taotao-manager-web” />
                <dubbo:service interface=”com.taotao.manager.service.TestService” id=”testService”
                timeout=”10000000” />
    注册中心
        zookeeper
## orleans
    # .NET
## hsf
    # high-speed service framework, 阿里出品， socket直连
    特点
        不增加中间点(稳定，高度可伸缩)
    结构
        注册服务信息，推送服务地址
        基于osgi
    组件
        服务提供者
        消费者
        地址服务器
        配置服务器               # 分布式配置
        规则服务(diamond)       # 设置(黑白名单，认证，权重，限流)与推送

# soa
    # 面向服务架构 service oriented architecture
## eai
        # Enterprise Application Integration 建立底层结构将异构应用集成
## esb
        # Enterprise Service Bus 企业服务总线， 是连接中枢

# rpc
    # 远程过程调用 remote procedure call
## thrift
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
    # 是caucho公司的开源协议,基于http
## Burlap
    # caucho公房的开源协议,基于http
## httpinvoker
    # spring提供的协议，必须用spring
## web service
    # soap通讯

# 粘合层
## zookeeper
    介绍
        google chubby的开源实现。用于服务发现
        分布式, hadoop中hbase的组件
        fast paxos算法        # paxos存在活锁问题, fast paxos通过选举产生leader, 只有leader才能提交proposer
    功能
        配置维护
        域名服务
        分布式同步
        组服务
        分布式独享锁、选举、队列
    流程
        选举leader        # 多种算法, leader有最高执行ID
        同步数据
        大多数机器得到响应follow leader
    exhibitor
        # supervisor for zk
## gearman
    # 把工作委派给其他机器
## etcd
    # k8s中用到的服务发现仓库
## mesos
    # apache开源的分布式资源管理框架
## hystrix
    功能
        服务线程隔离、信号量隔离
        降级: 超时、资源不足
        熔断: 自动降级、快速恢复
        请求缓存、请求合并
## twemproxy
    redis/memcache分片代理


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

### tengine
    # 淘宝基于nginx修改，添加了功能
    监控
        /upstream_status
### openresty
    # 淘宝改的nginx, lua工具
    安装
        yum install -y gcc gcc-c++ kernel-devel readline-devel pcre-devel openssl-devel openssl zlib zlib-devel pcre-devel
        wget openresty-1.9.15.1.tar.gz
        ./configure --prefix=/opt/openresty --with-pcre-jit --with-ipv6 --without-http_redis2_module --with-http_iconv_module -j2
        make && make install
        ln -s /opt/openresty/nginx/sbin/nginx /usr/sbin
        /opt/openresty/nginx/conf/nginx.conf
### varnish
    # 反向代理, http缓存
### traffic server
    # apache 缓存
### squid
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
# 容器服务
## tomcat
    ## 介绍
        tomcat从7开始默认就是nio的
    ## 配置
        bin/startup.bat
                set JAVA_HOME=
                                # 设置tomcat运行jdk
        context.xml
            <Loader delegate="true"/>
                    # true表示使用java加载器的代理模式
                    ## false代表永远先在Web应用程序中寻找
        web.xml
            Content-Type: text/x-zim-wiki
            Wiki-Format: zim 0.4
            Creation-Date: 2013-08-04T19:40:08+08:00

            ====== web.xml文件 ======
            Created Sunday 04 August 2013

            <servlet>
                    <servlet-name>
                    <servlet-class>
                    <load-on-startup>1
                    <init-param>
                            <param-name>
                            <param-value>
            <servlet-mapping>
                    <servlet-name>
                    <url-pattern>

            <welcome-file-list>
                    <welcome-file>

            <filter>
                    <filter-name>
                    <filter-class>
                    <init-param>
            <filter-mapping>
                    <filter-name>
                    <url-pattern>

            <mime-mapping>
                    <extension>bmp
                    <mime-type>image/bmp

            <error-page>
                    <exception-type>异常类的完全限定名 /<error-code>错误码
                    <location>以“/”开头的错误处理页面路径

    ## 启动顺序
        web.xml中配置的启动顺序
                监听器
                过滤器
                servlet
                        load-on-startup属性值越小越先启动

        tomcat的加载过程：        # 分析启动日志得到
                启动http协议
                启动catalina
                启动servlet引擎
                加载xml配置文件
                初始化日志配置
                初始化ContextListener
                初始化SessionListener
                部署web项目
                        spring监听器，加载xml配置(开始spring自己的日志记录)
                                实例化bean
                                        初始化c3p0连接池的记录显示
                                        初始化LocalSessionFactoryBean的记录显示
                        application监听器(监听器按配置顺序启动)
                        struts过滤器，加载xml配置(开始struts自己的日志记录)
                                struts-default.xml
                                        根据其中配置的bean属性加载类，并记录了日志
                                struts-plugin.xml                # 里面有加载spring-struts-plugin包
                                        初始化struts-spring 集成
                                struts.xml
    ## 目录
        LICENSE
        NOTICE
        RELEASE-NOTES
        RUNNING.txt
        bin
                bootstrap.jar
                commons-daemon.jar
                tomcat-juli.jar
                tomcat-native.tar.gz
                commons-daemon-native.tar.gz
                catalina.bat
                shutdown.bat
                startup.bat
                cpappend.bat
                digest.bat
                setclasspath.bat
                tool-wrapper.bat
                version.bat
                catalina.sh
                shutdown.sh
                startup.sh
                digest.sh
                setclasspath.sh
                tool-wrapper.sh
                version.sh
                catalina-tasks.xml
        conf
                catalina.policy
                catalina.properties
                logging.properties
                context.xml
                server.xml
                tomcat-users.xml
                web.xml
                Catalina
                        localhost
                                host-manager.xml
                                manager.xml
        lib
                annotations-api.jar
                catalina.jar
                catalina-ant.jar
                catalina-ha.jar
                catalina-tribes.jar
                el-api.jar
                jasper.jar
                jasper-el.jar
                jasper-jdt.jar
                jsp-api.jar
                servlet-api.jar
                tomcat-coyote.jar
                tomcat-dbcp.jar
                tomcat-i18n-es.jar
                tomcat-i18n-fr.jar
                tomcat-i18n-ja.jar
        log
                catalina.2013-07-28.log等等
        webapps
                ROOT
                        WEB-INF
                                web.xml
                docs
                examples
                manager
                host-manager
        tmp
        work

        发布
                conf/server.xml 中8080端口 位置
                <Context path="/bbs" reloadable="true" docBase="E:\workspace\bbs" workDir="E:\workspace\bbs\work" />

        发布war文件：
                localhost:8080 -> tomcat manager -> WAR file to deploy

## netty
    ## 介绍
        JBOSS提供，由Trustin Lee开发，比mina晚
        java开源框架
    ## 原理
        基于socket的数据流处理
                # socket数据流不是a queue of packets , 而是a queue of bytes, 所以分次传输的数据会成为a bunch of bytes
    ## 例子
        Handler
            ChannelHandler
                ChannelOutboundHandler
                        ChannelOutboundHandlerAdapter                        # 可作Encoder
                        MessageToByteEncoder
                ChannelInboundHandler                # 提供可重写的事件
                        ChannelInboundHandlerAdapter
                        ByteToMessageDecoder        # easy to deal with fragmentation issue
                                事件
                                        decode(ctx, in, out)                        # 内部处理过数据，堆积到了buffer(in)
                                                                                ## out中add了数据, 表示decode成功，则执行后抛弃in中数据
                                                                                # decode会被循环调用直到有一次out中没有add东西
                        ReplayingDecoder
                        事件
                                channelRead()                # 从client接收到数据时调用，数据的类型是ByteBuf
                                                        ## ByteBuf是 reference-counted object
                                                        ## 必须用ReferenceCountUtil.release(msg)或((ByteBuf) msg).release()来明确释放
                                exceptionCaught()        # 当抛出Throwable对象时调用
                                channelActive()                # as soon as a connection is established
                方法
                        handlerAdded()
                        handlerRemoved()
            ByteBuf
                方法
                        buf.writeBytes(m)                # 将m[ByteBuf]中的数据 cumulate into buf[ 定长的ByteBuf, 如ctx.alloc().buffer(4) ]
                        isReadable()                        # 返回ByteBuf中data的长度
            ChannelHandlerContext                # 用于触发一些i/o事件
                方法
                        write(msg)                # msg在flush后自动realease
                                write(msg, promise)                                # promise是ChannelPromise的对象，用来标记msg是否确切地写入到管道中
                        flush()
                        writeAndFlush(msg)                                        # 返回ChannelFuture
                        alloc()                                                        # 分配缓冲区来包含数据
            ByteBufAllocator
                buffer(4)                        # 返回存放32-bit Integer的ByteBuf
        Server
            EventLoopGroup
                NioEventLoopGroup                # 多线程 i/o eventloop
                方法
                        shutdownGracefully()                                                # 返回Funture类来通知group是否完全关闭并且所有group的channels都关闭
            ServerBootstrap                        # 建server的帮助类，链式编程
                                                ## 可以直接用Channel来建server
                方法
                    group(bossGroup, workerGroup)                                # boss接收连接，worker处理boss中的连接
                            group(workerGroup)                                        # 只有一个参数时，该group即作boss也作worker
                    channel(NioServerSocketChannel.class)                        # 用来接收连接的channel的类型
                            channel(NioSocketChannel.class)                        # create client-side channel
                    childHandler(channelInitializer)                                # 新接收的channel总执行本handler
                                                                                    ## 只有workerGroup时不用
                    option(ChannelOption.SO_BACKLOG, 128)                        # channel实现的参数
                    childOption(channelOption.SO_KEEPALIVE, true)                # option设置boss, childOption设置worker
                                                                                    ## 在只有workerGroup时不用childOption,因为它没有parent
                    bind(port)                                                        # 开始接收连接，返回的是ChannelFuture
                                                                                        ## 绑定网卡上的所有port端口，可以bind多次到不同的端口
            ChannelInitializer                        # 帮助设置channel, 如设置channel的pipeline中的handler
                实例
                    new　ChannelInitializer<SocketChannel>(){
                            @Override
                            public void initChannel(SocketChannel ch) throws Exception{
                                    ch.pipeline().addLast(new DiyHandler());
                            }
                    }
            ChannelFuture
                方法
                    sync()
                    channel()                                                        # 返回Channel
                    addListener(channelFutureListener)
            Channel
                    closeFuture()                                                        # 返回ChannelFuture
            ChannelFutureListener
                实例
                    new ChannelFutureListener(){
                        // 当请求结束时通知
                        @Override
                        public void operationComplete(ChannelFuture future){
                            assert f == future;
                            ctx.close();
                        }
                    }
        client
            Bootstrap                        # for non-server channels such as a client-side or connectionless channel
                connect(host, port)
## netty-tcnative
    介绍
            tomcat native 的分支
    特点
            简化本地库的分配和连接
            可以maven配置dependency
            提供openssl的支持
## jetty
    # 是开源的servlet容器，基于java, 可以给jsp和servlet提供运行环境
    # jetty容器可以实例化成一个对象，迅速为一些独立运行(stand-alone)的java应用提供网络和web连接
## apache
    # http容器，可容纳php, python。一请求一线程
    安装
        pacman -S apache
        mkdir /srv/http
        chown http:http /srv/http
    编译安装
        ./configure
            --prefix=/全路径/install_path
            --with-apxs2=/全路径/apxs            # 模块
        make
        make install
    命令
        httpd
            -f                                  # 指定配置
            -t                                  # 配置检查
            -k
                start
                restart
                graceful
                stop
                graceful-stop
        apachectl
            graceful                            # 重载配置
            -f /全路径/httpd.conf                # 指定配置
            -t                                  # 配置检查
    配置
        /etc/httpd/conf/httpd.conf
            DocumentRoot "/srv/http"            # 项目路径
            Listen                              # 端口
    案例
        php
            docker解决
## lighttpd
## meteor
    # 包装node
## ringojs
    # jvm上commonJs规范的服务器
## mina
    apache提供， 由Trustin Lee开发，比netty更早
## tomcat native
    # 基于apr(apache portable runtime)技术，让tomcat在操作系统级别的交互上做的更好
## tinyHttpd
## resin
    # 收费, 类似tomcat的java容器，性能提升
## uwsgi
    # 一个web服务器，实现了wsgi, uwsgi, http等协议
## weblogic
    # oracle
## was
    # ibm服务器
## gunicon
    # python wsgi http server
## node.js
# 通信服务
## log
### elk
            # elasticsearch, logstash, kibana
### log.io
## mq
    消息重发
        状态表记录消息状态
### rabbitMQ
    介绍
        erlang开发, 重量级
        支持协议多，AMQP、XMPP、SMTP、STOMP
        Broker构架        # 消息在中心队列排队
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
    介绍
        基于kafka, 快速持久化(O(1)时间开销)
        高吞吐，一台普通服务器 100k/s
        完全分布式，Broker, Producer, Consumer原生支持分布式，自动负载均衡
        支持hadoop并行加载
### kafka
    介绍
        apache子项目，scala语言编写, 发布订阅队列
        相对activeMQ轻量
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
    介绍
        apache子项目, 类似zeroMQ
    通信方式
        点到点
            不成功时保存在服务端
        发布订阅
            不成功消息丢失

### beanstalkd
### mqtt
        # 最早由ibm提供的，二进制消息的mq
## 任务
### quartz
    # java作业调度
    配置applicationContext_job.xml
        job             # 任务内容
        jobDetail       # 调度方案
        trigger         # 时间
        scheduler       # jobDetail和trigger的容器
    状态监控
        # 用日志表记录
        运行中
            JobListener监听器
        暂停中
            scheduler.pauseTrigger()
        等待中
            创建job时
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

## cdn
    介绍
        流量不大时带宽比cdn便宜, 流量大时cdn便宜。
        界限为250Mbps左右，价格在9k/month
    价格     50TB/月        100TB/月
    阿里云   3.8w/月        6.9w/月
    盛大云   9k/月          1.7w/月
    网宿
    蓝汛
## aws服务器
    命令
        aws
            s3
                cp --recursive bin s3://meiqia/crm-module/search/bin
                    # 级联复制
                sync s3://meiqia/crm-module/search/bin bin
                    # 下载
                rm --recursive s3://meiqia/crm-module/search
                    # 级联删除
