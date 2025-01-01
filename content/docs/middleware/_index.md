---
weight: 6
title: 中间件
Categories : ["中间件"]
date: 2018-10-10T14:36:50+08:00
type: docs
---



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
    介绍
        JBOSS提供，由Trustin Lee开发，比mina晚
        java开源框架
    对比java nio
        java原生nio有bug(epoll bug)且编写困难, 网络可靠性自己处理
        netty设计优雅，使用方便，高性能、稳定
    原理
        基于socket的数据流处理
            # socket数据流不是a queue of packets , 而是a queue of bytes, 所以分次传输的数据会成为a bunch of bytes
    例子
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
## OpenResty
	# 基于Nginx扩展
## Tengine
	# 基于Nginx扩展
# 数据库访问
## Druid
## Sharding JDBC
# 缓存
	缓存失效策略
		FIFO(First Input First Output)
		LRU(Least Recently Used)
		LFU(Least Frequently Used)
## 客户端缓存
	Header
		Cache-Control: no-cache, no-store, max-age=0, must-revalidate
		Vary: Accept-Encoding
		Vary: Origin
		Vary: Access-Control-Request-Method
		Vary: Access-Control-Request-Headers
		Vary: Origin
		Vary: Access-Control-Request-Method
		Vary: Access-Control-Request-Headers
## 本地缓存
	Ehcache
		堆内、堆外、磁盘三级缓存，可按容量制定缓存策略
		可按时间、次数制定过期策略
	Guava Cache
		堆内缓存
	Nginx本地缓存
	Nginx PageSpeed插件
## 缓存服务
	HTTP
		Nuster
			基于HAProxy的HTTP缓存服务器
		Varnish
			3台Varnish代替12台Squid
		Squid
	Memcached
	Redis
	Tair
# 配置、服务发现
## Apollo
	# 支持推、拉模式更新
## Eureka
## Nacos
# RPC
## Dubbo
## Thrift
## gRPC
# 消息队列
    消息重发
        状态表记录消息状态
## pulsar
    # 雅虎开源, 存储和服务分离，高可用存储, 支持流
## rabbitMQ
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
## jafka
    介绍
        基于kafka, 快速持久化(O(1)时间开销)
        高吞吐，一台普通服务器 100k/s
        完全分布式，Broker, Producer, Consumer原生支持分布式，自动负载均衡
        支持hadoop并行加载
## kafka
    介绍
        apache子项目，scala语言编写, 发布订阅队列
        相对activeMQ轻量
    特点
        push/pull队列架构，适合异构集群
        分布式, 高吞吐率, 易扩展
        支持数据并行到hadoop
        分区有序
        批量压缩, 零拷贝, 内存缓冲, 磁盘顺序写入
        可持久化
    工具
        manager # 监控
## nsq
    介绍
        go
    工具
        admin   # 监控
## memcacheQ
## zeroMQ
## activeMQ
    介绍
        apache子项目, 类似zeroMQ
    通信方式
        点到点
            不成功时保存在服务端
        发布订阅
            不成功消息丢失

## beanstalkd
## mqtt
    # 最早由ibm提供的，二进制消息的mq
## emqttd
    介绍
        mqtt broker
## apollo
    介绍
        apache mqtt broker
## metaq
    # 阿里mq
# 定时任务
## Cron
## XXL Job
## quartz
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
## celery
    # python
## rundeck
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
## AWS S3
    命令
        aws
            s3
                cp --recursive bin s3://meiqia/crm-module/search/bin
                    # 级联复制
                sync s3://meiqia/crm-module/search/bin bin
                    # 下载
                rm --recursive s3://meiqia/crm-module/search
                    # 级联删除
# 网关
## Zuul
## Spring Cloud Gateway
## Kong
	# 基于OpenResty
# 日志
## ELK
	# elasticsearch, logstash, kibana
    FileBeat
        命令
        filebeat --environment systemd -c /etc/filebeat/filebeat.yml --path.home /usr/share/filebeat --path.config /etc/filebeat --path.data /var/lib/filebeat --path.logs /var/log/filebeat
## log.io
# DNS服务
## Nscd
    DNS本地缓存
# 实时计算
	阿里云Flink
		集群
			计算单元
			vertex拓扑
		名词
			DataHub源表
			RDS维表
			RDS结果表