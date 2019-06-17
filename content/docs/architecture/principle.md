---
Categories : ["架构"]
title: "架构-原理"
date: 2018-10-10T15:25:12+08:00
---

# 微机
    并行架构
            位级(bit-level): 32位, 64位计算机
            指令级(instruction-level)
                    # 处理器内部并行度很高
                    流水线
                    乱序执行
                    猜测执行
            数据级, 单指令多数据(SIMD)架构
                    # 图像处理
            任务级(task-level)
                    # 多处理器
                    # 超线程, 虽只有4个核，但可用核返回8
                    共享内存模型
                    分布式内存模型
    分类
            指令流的重数分类
                    SI(single instruction stream)单指令流
                    MI(multiple instruction stream)多指令流
            操作数流的重数分类
                    SD(single data stream)单数据流
                    MD(multiple data stream)多数据流
            SISD 串行计算机
            SIMD 阵列机(多处理单元)
            MISD 很少
            MIMD
                    多处理机
                    多计算机

    并发: 一个时间段有多个程序在运行，在同一个处理机上。
        # 伪并发是单核处理器并发，真并发是多核处理器并发
        # 可处理时间点i/o的数目来衡量
        互斥: 程序(进程)间不使用临界资源
        同步: 程序间依赖，有等待关系
            同步的其它意思:
                1. os开发中指进程协作
                2. 数据异步复制(如同步歌曲)
    并行: 多处理器才并行，单处理器叫交替执行
        多线程
    异步: 与同步相对。多线程是实现异步的一种手段

    进程
    线程
            一个进程下的轻量进程
    协程
            单线程下事件并行(就是仿cpu时间调度)
    事件(非阻塞)
            介绍
                    就是回调
            事件模型
                    原理
                            队列存事件, 单进程检测事件是否回调
                    工具
                            epoll(select, poll)
                            libev(libevent)
    dma        
            direct memory access 不依赖cpu的内存存取
    长连接        
            socket连接

## cpu
    介绍
            单cpu串行工作，前任务完成，后任务才开始
                    # 串行不适合图形处理(多点，线，面要同时乘投影矩阵)
            cpu把大量空间和电量分配给控制器和缓存，不能集成太多计算单元
            cpu内存通过cpu总线连接, cpu总线与pci总线通过主桥(北桥)连接
                    # 显卡在pci总线上
                    ## 控制逻辑在cpu中运行, 生成渲染数据, 到内存, 再到显存显卡计算。
                    ### 内存到显存数据传输最花费时间。
### 进程调度
    等级
            高级调度(High-Level Scheduling)
                    作业调度, 后备作业调入内存运行
            低级调度(Low-Level Scheduling)
                    进程调度, 就绪队列中某进程获得cpu
            中级调度(Intermediate-Level Scheduling)
                    虚拟存储器引入, 内外存对换区进行进程对换

    方式
            非剥夺方式
                    处理机分配给某进程后一直运行下去,直到阻塞时,才分配处理机到另一个进程
            剥夺方式
                    进程运行时,系统基于某种原则,剥夺分配给它的处理机. 
                    采用算法
                            先进先出算法
                                    批处理系统用. 总把处理机分配给最先进队的进程, 将一直执行下去,直到阻塞
                            短进程优先(SCBF  Shortest CPU Burst First)
                                    批处理系统用. 从就绪队列中选出下一个cpu执行期最短的进程,分配处理机
                            轮转法
                                    分时系统中,都采用时间片轮转法
## gpu 
    介绍
            gpu控制单元少, 计算单元多
            显卡在pci总线上
## 网络
### 协议
    rts/cts: 视频数据传输
    ABR：区域边界路由器                        area border router
#### 数据链路层
    分层
            数据链路层分为两层
                    llc上层子层                                                # Logical Link Control 逻辑链路控制。
                    mac下层子层                                                # Media Access Control 介质访问控制层

    帧(frame)传输
            网络驱动程序成型帧,  网卡发送到网线上，到达目的机器，以网络驱动程序解析
    协议
            以太网
            令牌环
            HDLC
            帧中继
            ISDN
            ATM
            IEEE 802.11
            FDDI
            PPP
##### mac 
    Media Access Control
            mac帧结构
![""](/series/architecture/mac.jpg)

                单位
                        字节
                帧类型/长度（TYPE/LEN）：
                        该字段的值大于1500时，表示上层数据使用的协议类型。例如0x0806表示ARP请求或应答，0x0800表示IP协议。
                        该字段的值小于1500时表示以太网数据的长度，上层携带LLC-PDU。
                帧校验FCS：
                        以太网采用32位CRC冗余校验。
##### llc
    Logical Link Control
            llc-pdu结构
![""](/series/architecture/llc1.jpg)
![""](/series/architecture/llc2.jpg)

                pdu : 协议数据单元
                dsap : 目标服务访问点
                ssap : 源服务访问点
                控制位 : 三种
                                

##### arp
    Address Resolution Protocol                                                                # arp属于中间层，为ip层服务协议
            arp帧结构
![""](/series/architecture/arp1.jpg)

            arp协议的分组格式
![""](/series/architecture/arp2.jpg)

            arp在windows命令提示行下的命令
                    arp -a                                         查看arp缓存表中的内容
                    arp -d                                        清空arp缓存表

#### 网络层
    数据包
            接收
                    # 一般情况下，网络上所有的机器都可以“听”到通过的流量, 但对不属于自己的数据包则不予响应
                    ## 网卡到混杂模式，可以捕获网络上所有的数据包和帧
                    广播包
                            可达到局域网中的所有机器
                    单播包
                            到达处于同一碰撞域中的机器
    协议
            IP        Internet Protocol 网际协议
            ICMP        Internet Control Message Protocol internet控制报文
            IGMP        Internet Group Management Protocol internet群组管理协议 
            IPX
            BGP        Border Gateway Protocol 边界网关协议
            OSPF        Open Shortest Path First 开放式最短路径优先
            RIP        Routing Information Protocol 选路信息协议
            IGRP
            EIGRP
            ARP
            RARP        Reverse Address Resolution Protocol 反向地址解析协议
            X.25
            NAPT        Network Address Port Translation 网络地址端口转换
            ASBR        Autonomous System Border Router  自治系统边界路由器
##### ip
    Internet Protocol                                # ip地址是互联网主机的唯一标识
![""](/series/architecture/ip1.jpg)

        ip地址分类
                 A类 : 0.0.0.0 -- 127.255.255.255 (0段和127段不使用)
                B类 : 128.0.0.0 -- 191.255.255.255
                C类 : 192.0.0.0 -- 223.255.255.255
                D类 : 224.0.0.0 -- 239.255.255.255
                E类 : 240.0.0.0 -- 254.255.255.255

        特殊ip地址
                主机地址全0 : 作为网络本身的标识 , 称为网地址
                主机地址全1 : 广播地址 ， 称为直接广播地址
                32位全1 : 称为受限广播地址
                内部地址
                        10.0.0.0 -- 10.255.255.255 : 一个A类
                        172.16.0.0 -- 172.32.255.255 : 16个B类
                        192.168.0.0 -- 192.168.255.255 : 256个C类
        子网                                        # 把ip划分为网络地址和主机地址
                作用 
                        便于网络管理、提高系统性能
                子网掩码                        # 同ip地址一样长 ， 不分离部分为1，分离部分为0
                        知道子网掩码后算出
                                网络地址
                                广播地址
                                地址范围
                                本网有几台主机
        ip数据报文格式
![""](/series/architecture/ip2.jpg)
               
    ip分片    # 一个MTU（链路层）较大的网络传输到MTU较小的网络过程中，将一个较大的数据包分为几个较小的数据包来传输。
        利用PING命令中的参数–l 可以设置数据部分的字节数

##### icmp
    Internet Control Message Protocol   # Internet控制报文协议
        是ip层的子协议
        封装        
![""](/series/architecture/icmp1.jpg)
        
        报文格式
![""](/series/architecture/icmp2.jpg)
        
        主要报文类型
![""](/series/architecture/icmp3.jpg)
        
        时间戳报文举例
![""](/series/architecture/icmp4.jpg)
        
        重定向报文举例
![""](/series/architecture/icmp5.jpg)
        
##### igmp
    Internet Group Management Protocol                                                        # Internet组管理协议
            报文格式                
                    8位IGMP类型    8位响应时间    16位检验和 
                    32位组地址(D类IP地址)） 
##### ospf
    Open Shortest Path First                                                        # 开放式最短路径优先。是一种典型的链路状态路由协议。
                                                                                    ## 采用OSPF的路由器彼此交换并保存整个网络的链路信息，从而掌握全网的拓扑结构，独立计算路由。
            报文
                    版本    类型    报文长度 
                    路由器标识符 
                    区域标识符 
                    检验和          鉴别类型 
                    鉴别 
                    鉴别 
                    OSPF报文（有五种类型） 
                            问候(Hello)报文：发现及维持邻居关系，选举DR、BDR。 
                            数据库描述(Database Description)报文：描述本地LSDB的情况。 
                            链路状态请求(Link State Request)报文：向对端请求本端没有或对端更新的LSA。 
                            链路状态更新(Link State Update)报文：向对方更新LSA。
                            链路状态确认(Link State Acknowledgment)报文：收到LSU报文后，进行确认。 
##### bgp
    介绍　
            border gateway protocol 边界网关协议
##### 抓包
    sniffer(嗅探器)
            # 网络层
            # 硬件sniffer称为 协议分析仪
            原理
                    利用Ethernet特性, 把nic(网络适配卡，一般为以太网卡), 设为promiscuous(混杂)
                    几乎能得到任何以太网上传送的数据包
            需求
                    windows
                            BPF
                    linux
                            socket-packet
                            root权限来激活内核支持的Bpfilter(伪设备)
            限制
                    只能抓取同物理网段的包，即与监听的目标中间不能有路由或其他屏蔽广播包的设备
                            # 对一般拨号上网的用户来说, 不可能利用sniffer窃听其他人通信内容
                    数据包内容的过滤有一定难度
            分类
                    软件
                    硬件
            举例
                    NetXray, Packetboy, Net monitor
            应用场景
                    攻陷一台主机后，安装sniffer, 侦听同网段数据包，存到log文件(通常是包含username或password的包)，截获其他主机密码后，登入这台主机。
                            # 属于第M层攻击，即 在攻击者已经进入了目标系统的情况下
                            ## 也可以截获金融信息
#### 传输层
    协议
            TCP        Transmission Control Protocol 传输控制协议
            UDP        User Datagram Protocol 用户数据报协议
            RTP
            SCTP
            SPX
            ATP
            IL
##### udp
    User Datagram Protocol
        封装
![""](/series/architecture/udp1.jpg)
        
        报文
![""](/series/architecture/udp2.jpg)
        
        有伪首部的报文                                                                        # 伪首部只是单纯为了做校验用的
![""](/series/architecture/udp3.jpg)
        
            校验和的计算方法                                                        # UDP“检验和”是一个端到端的“检验和”，包括UDP首部、UDP伪首部和UDP数据。
                                                                                        ## UDP12字节的伪首部是为了计算“校验和”而设置的，不参与网络传输。

##### tcp
    Transmission Control protocol
        报文格式
![""](/series/architecture/tcp1.jpg)
        
        三次握手
![""](/series/architecture/tcp2.jpg)
        
                ACK : Acknowledgement
                SEQ : Sequence
                SYN : Synchronous
        断开连接
![""](/series/architecture/tcp3.jpg)
        
                FIN : Final
        d.o.s(denial of service)攻击                                                # ddos(distributed denial of service)
![""](/series/architecture/tcp4.jpg)
        
##### socket
    socket可以基于tcp或udp
    一个socket对应系统中一个端口
            # 操作系统中可用端口65535, 所以只能有65535个socket连接
##### ssl
    ssl加密(消息, node模块)
            非对称生成公私钥(慢)
            对称传数据(快)
#### 会话层
    udp传输
        netBIOS
            Network Basic Input Output System                                        # 网络基本输入输出系统 由ibm开发
                                                                                    ## 定义了一种软件接口以及在应用程序和连接介质之间提供通信接口的标准方法。
            wins
                Windows Internet Name Server                                                # Windows网际名字服务 WINS为NetBIOS名字提供名字注册、更新、释放和转换服务，
                                                                                                ## 这些服务允许WINS服务器维护一个将NetBIOS名链接到IP地址的动态数据库，大大减轻了对网络交通的负担。
            smb/cifs
                smb        Sever Message Block                                                                # 服务信息块协议 , 用于计算机间共享文件系统、打印机和其他资源。 
                cifs        Common Internet File System）                                                # 通用互联网文件系统。
                                                                                                        ## 微软将原有的几乎没有多少技术文档的SMB协议进行整理， 重新命名为CIFS
                                                                                        ## 成为Internet上计算机之间相互共享数据的一种标准。
#### 表示层
    协议
            XDR
            ASN.1
            SMB
            AFP
            NCP
#### 应用层
    协议
            HTTP        Hypertext transfer protocol 超文本传输协议
            HSTS        HTTP Strict Transport Security HTTP安全传输
            DNS        Domain Name System 域名系统
            SMTP
            SNMP
            FTP        File Transfer Protocol 文件传输协议
            Telnet
            SIP
            SSH
            NFS        Network File System 网络文件系统
            RTSP
            XMPP
            MQTT
            SIP
            Whois
            ENRP
            DHCP        Dynamic Host Configuration Protocol 动态主机配置
            BOOTP        Bootstrap Protocol 自举协议
##### tcp传输
###### http
    http/1.1 请求动作
            get
            post
            options                        # 返回服务器支持的所有http请求方法
            head                        # 同get, 但不传回文本部分
            put                        # 同post, 但是idempotent的，后面相同的请求会覆盖前面的请求,服务器状态会被crawler修改
            delete                        # 请求删除被请求的资源
            trace                        # 回显服务器收到的请求
            connect                # 预留给能够将连接改为管道方式的代理服务器。通常用于SSL加密服务器的链接（经由非加密的HTTP代理服务器）
            patch                        # 给服务器资源打补丁
    缓存头
            response.setHeader("pragma", "no-cache");                        # http1.0设置不缓存的参数
            response.setHeader("cache-control", "no-cache");        # http1.1设置不缓存的参数，只用这个就可以了
            response.setHeader("expires", "0");                                        # 支持缓存时，设置缓存有效时间。不支持缓存时，无效
                # <meta http-equiv="pragma" content="no-cache">
                                jsp页面中的meta设置方式：jboss可以解析,tomcat不支持【只能服务器设置】
                ## post方式不缓存时提示页面过期，刷新后重新提交请求。get方式不缓存时则会直接重新提交请求
                ## 缓存的配置只对ie浏览器有效。面对未知编程(浏览器兼容，flex可以解决浏览器兼容问题【flash页面】)
                    # cache-control=no-store
    端口
        httpd                80
        ssh                22
        telnet                23
        ftp                21/20
        smtp                25
        pop2                109
        pop3                110
        pop3s                995
        imap                143
        irc                194
        https                443
        who                513(udp)
        login                513(tcp)
        whoami        565
        svn                3690
        vnc                5901/5801 5902/5802 ...
        mysql                3306
        mycat                3128
    报文
        request消息头(请求头)
        Accept:text/html,image/*,*/*
        Accept-Charset:ISO-8859-1
        Accept-Encoding:gzip,compress
        Accept-Language:en-us,zh-cn
        Host:www.itcast.cn:80
        If-Modified-Since:Tue,11 Jul 2000 18:23:51 GMT
        Referer:http://www.itcast.cn/index.jsp
        User-Agent:Mozilla/4.0(compatible; MSIE 5.5; Windows NT 5.0)x
        Cookie
        Connection: close/Keep-Alive
        Date: Tue, 11 Jul 2000 18:23:51 GMT

        response消息头（响应头）
        HTTP/1.1 200 OK
        Server: Microsoft-IIS/5.0
        Date: Thu, 13 Jul 2000 05:46:53 GMT
        Content-Length: 2991
        Content-Type: text/html; charset=GB2312
        Content-Encoding:gzip
        Content-Language: zh-cn
        Cache-control: private
        Location:http://www.itcast.cn/index.jsp
        Last-Modified: Tue, 11 Jul 2000 18:23:51 GMT
        Refresh: 1; url=http://www.itcast.cn
        Content-Disposition: attachment; filename=aaa.zip       # 设置响应类型是下载文件，文件名是aaa.zip
                    # inline   表示在浏览器中显示,非w3c标准，像innerHTML一样。但是主流浏览器都支持。
                    ## appllication/octet-stream    表示任意二进制文件（有的浏览器也会解析成文件下载，但是没有指定文件名）
                    ## attachment;filename=文件名   附件，文件下载
        Transfer-Encoding: chunked   //标记以分块传输
        Set-Cookie:SS=QQ=5Lb_nQ; path=/search
        Expires: -1
        Cache-Control: no-cache
        Pragma: no-cache

###### telnet
    telnet                                        # 一个简单的远程终端协议。用户可以通过TCP连接登录到远程的一个主机上，好象使用远程主机一样。
            采用客户机/服务器计算模式。在本地系统上运行TELNET客户机进程，在远程主机上运行TELNET服务器进程。
            用于远程管理一台主机
            命令
                    >telnet 192.168.1.200
                    >Login: group1_1
                    >Password: group1_1
                    >按“CTRL+]”回到telnet提示符下
                    >quit 退出telnet 

###### ftp
    File Transfer Protocol
            一个客户机/服务器系统。
            端口 : 20或21                                                                        # 21用于控制，20传输数据流

###### smtp
    simple mail transfer protocol                                                # SMTP协议的最大特点是简单，它规定了发送程序和接收程序之间的命令和应答格式。 
            基于DNS中的邮件交换（MX）记录路由电子邮件。
            通过用户代理程序（UA）完成邮件的编辑、收取和阅读等功能；通过邮件传输代理程序（MTA）将邮件传送到目的地。
            传输协议
                    tcp
            常用命令
                    HELO  <domain> <CRLF>
                    MAIL FROM：<邮件地址><CRLF>
                    RCPT TO：<邮件地址><CRLF>
                    DATA <CRLF>邮件内容，以＜CRLF＞.＜CRLF＞标识数据的结尾;
                    REST <CRLF>退出/复位当前的邮件传输QUIT <CRLF>关闭传输;

###### pop
    Post Office Protocol                                                                # 邮局协议 是一个脱机协议，它是一个具有存储转发功能的中间服务器。
            采用客户/服务器工作模式。
            传输协议
                    tcp
            功能
                    允许本地检索邮件服务器上的邮件
            命令
                    USER <用户邮件地址>指出用户正在连接的邮箱;
                    PASS <口令>输入邮箱的口令;
                    STAT请求服务器发回关于邮箱的统计资料;
                    LIST<邮件编号>返回邮件数量和每个邮件的大小;
                    RETR<邮件编号>返回由参数标识的邮件的文本;
                    DELE<邮件编号>删除邮件编号;
                    QUIT退出;
###### imap
    Internet Mail Access Protocol                                                        # 交互邮件访问协议 ， 本地对邮件服务器中的邮件进行管理
            端口 : 143
###### rtmp
    介绍　
        adobe专利, flash支持, 
###### http-flv
    介绍　
            开源流式传输协议，优于RTMP
###### hls
    介绍　
            http live streaming 苹果创建, 延迟较高
            html5原生支持
            m3u8扩展名，里面封装ts小视频
##### udp传输
###### dns
    domain name system
        分类
                位于最右端的域称为顶级域。接下来是二级域名和三级域名。如www.jlu.edu.cn
        端口
                53
        过程
                本机缓冲区 -> 本地域名服务器(缓冲区与数据库) -> 其它域名服务器
        报文格式
![""](/series/architecture/dns1.jpg)
        
                Queries
![""](/series/architecture/dns2.jpg)
                
        命令
                windows下命令提示行
                        正向解析
                                nslookup 域名
                        反向解析
                                nslookup -qt=ptr ip地址
                                        # ptr Pointer Recore 指针记录
                                        ## 是电子邮件系统中的一种数据类型，被互联网标准文件RFC1035所定义。
                                        ## 与其相对应的是A记录、地址记录。二者组成邮件交换记录。
                                        ## A记录解析名字到地址，而PTR记录解析地址到名字。
                                        ## 另外两个与ptr平行的参数为mx和a
                                或
                                nslookup
                                set q=ptr
                                ip地址
    ldns

###### dhcp
    Dynamic Host Configuration Protocol
        基于 客户端/服务器模式
        报文
                操作代码(1字节)    硬件类型(1字节)    硬件长度(1字节)    跳数(1字节)
                事务ID(4字节) 
                秒 (2字节)                                      标志 (2字节) 
                客户端IP地址 (4字节) 
                您(客户端)的IP地址 (4字节) 
                服务器IP地址 (4字节) 
                网关IP地址 (4字节) 
                客户端硬件地址 (16字节) 
                服务器名 ( 64字节) 
                引导文件名 (128字节)        
                选项 (64字节)
 


###### rip
    Routing Information Protocol                                        # 路由信息协议
            RIP通过广播UDP报文来交换路由信息，默认每30秒发送一次路由信息更新报文。
            RIP提供跳跃计数(hop count)作为尺度来衡量路由距离
                    跳跃计数是一个数据报到达目标设备所必须经过的路由器的数目。
                    RIP最多支持的跳数为15，即在源和目的网间所要经过的最多路由器的数目为15， 跳数16表示不可达。
            RIP协议的特点：
                    1．仅和相邻路由器交换信息。 
                    2．交换的信息是当前本路由器所知道的全部信息，即自己的路由表。
                    3．按固定的时间间隔交换路由信息，例如:每隔 30 秒。 
                    4.  设置一个180秒地超时时间。如果180秒没有任何更新信息，路由的跳数设为16。

###### snmp
    Simple Network Management Protocol                                        # 简单网络管理协议 ， 使网络管理员能够管理网络效能,发现并解决网络问题以及规划网络增长。
                                                                                    ## 通过SNMP接收随机消息及事件报告网络管理系统获知网络出现问题。 
            端口 : 161
###### rtp
    介绍
            real-time transport protocol 传输流媒体
            udp传输, 实时性好
###### rtcp
    介绍
            RTP Control Protocol 交互控制RTP传输
###### radius
    介绍
            拨号认证用的AAA协议
### cookie
    介绍
            cookie的弊端
                    数据在客户端可以被修改，所以不能存重要数据
                    cookie中字段太多会影响传输效率

    请求头
            set-cookie
                    # 规定cookie的格式为name = value
    响应
            path
                    # cookie发送的相对路径
            expires和maxAge
                    # expires是UTC时间, maxAge是cookie多久后过期
                    ## 不设置这两个时产生的是session cookie, 它是transient的，用户关闭浏览器时清除。一般用来保存session_id
            secure
                    # true时, cookie在HTTP中是无效的, 在HTTPS中才有效
            httpOnly
                    # 通知浏览器不允许脚本操作document.cookie。一般都应设置为true, 可以避免被xss攻击拿到cookie
    签名( 信息摘要算法)
            原user='alsotang'
            现user=sha1('my_secret' + 'alsotang') === 'xxxx...xxx'
### session
    介绍
            session通过cookie中存放session_id来实现
            可以存放在
                    1. 内存
                    2. cookie本身
                            # 不用担心集群的状态共享问题，安全性可以遵照最佳实践来，也是有保证的，最大的弊端在于增大了数据量传输。有受到回放攻击的危险
                    3. redis或memcached等缓存
                            # 常用
                    4. 数据库中
# 安全
    子网隔离
# 电话
    cti 
        computer telephony integration
        computer telecommunication integration
                计算机技术应用到电话系统中，识别信令信息进行处理，传送预定录音文件
                转接来话，处理传真，电子邮件等
# 并发并行
    并发的世界，并发的软件
            分布式的世界，分布式的软件
            不可预测的世界，容错性强的软件
            复杂的世界，简单的软件 
## 线程与锁
    概念
            互斥
                    竞态条件(race condition)
                            # 代码行为取决于各操作的时序
                    死锁
                            # 方法同步时，多把锁时出现
                            哲学家就餐问题，五个哲学家同时拿起左手边筷子，等待右手边筷子
                                    解决办法，按照全局固定顺序获取多把锁
                                            # 使用锁的地方比较零散时，遵守此顺序变得不实际
                                            # 可以用对象散列值作全局顺序减小死锁机率
                                    保护性复制(defensive copy)
                                            # 减少代码持有锁的时间，随意调用外星方法
                            外星方法中可能包含另一把锁，要避免在持锁时调用外星方法
            内存可见性
                    一个线程产生的修改对另一个线程不可见，如脏读
            过度竞争
                    过多线程尝试同时使用一个共享资源
            乱序执行
                    # java 中标记volatile的变量可以不乱序执行, 现多用原子变量
                    编译器或JVM的静态优化可以打乱代码执行顺序(java)
                    硬件可以通过乱序执行来优化性
            synchronized(java)
                    # 等待内置锁而进入阻塞的纯种无法中断
                    # 尝试获取内置锁时无法设置超时
                    # 使用synchronized块时，获取锁和释放锁代码必须严格嵌在同一个方法中
                    内置锁、互斥锁(mutex)、管程(monitor)、临界区(critical section)
            ReentrantLock对象
                    lock
                    tryLcok可设置超时
                            # 同时超时，再尝试失败再尝试而进入活锁。设置不同超时时间减少活锁机率
                    unlock
                            # 用lock, unlock可设置交替锁(hand-over-hand locking), 轮流锁、解锁一部分
                    lockInterruptibly突破死锁
                    newCondition条件变量, 原子地阻塞并解锁，直到条件满足(如有容量，队列非空)
                            condition.await()
                            condition.signal()
                            condition.signalAll()
            原子变量
                    AtomicInteger
                            # 无锁(lock-free)非阻塞(non-blocking), 不用锁和阻塞达到同步的目的
                            incrementAndGet()
            Executors
                    newFixedThreadPool线程池
            CopyOnWriteArrayList
                    # 列表被修改时，使用旧副本(保护性复制)
            ArrayBlockingQueue阻塞队列，适合生产者-消费者模式
                    queue.put(new PoisonPill())毒丸
                    obj.isPoisonPill()
                            # 标志数据取完
            SynchronizedMap
    锁
            互斥锁 mutex
                    # 访问前加锁，访问后解锁
                    悲观锁
                            读加锁
                    乐观锁
                            读不加锁，写时判断数据版本是否修改，再重试
            读写锁 rwlock
                    状态
                            读加锁状态
                                    可个线程占用
                                    阻塞写线程
                                            # 导致写线程抢占不到资源，所以有写线程时，阻塞后进入的读线程
                            写加锁状态
                                    一次只有一个线程占用
                                    阻塞所有线程
                            不加锁状态
            自旋锁 spinlock
                    互斥锁改，自己进入循环等待状态(忙等)
                            # 适合锁持有时间较短
            RCU锁 Read-Copy Update
                    读写锁改，一个写线程，读线程无限制
                            实现垃圾回收器
                            写线程copy副本修改，向垃圾回收器注册callback以执行真正的修改
                            垃圾回收器收到信号，所有读线程结束，执行callback
            可重入锁
                    # 互斥锁改，允许同一线程多次获得写锁
    信号量
            进程, 线程间通知状态
## 函数式
    介绍
            消除可变状态

    概念
            命令式语言中，求值顺序与源码的语句顺序紧密相关(有可能乱序执行)
            函数式程序并不描述"如何求值以得到结果"，而是描述"结果应当是什么样的"。函数式编程中，如何安排求值顺序相对自由
            引用透明性
                    # 任何调用函数的地方，都可以用函数运行结果来替换函数调用，而不会产生副作用
            数据流式编程(dataflow programming)
                    # (+ (+ 1 2) (+ 3 4))就是一个数据流，所有函数都可以用时执行
                    future模型
## 分离标识与状态
    介绍
            Clojure, 指令式编程和函数式编程混搭

    clojure四种并发模型
            vars (thread-local)
            atoms原子变量
            agent代理
            refs引用 与 ATM软件事务内存
## actor模型
    介绍
            作为actor自己修改自己的数据，对外提供消息，处理对外消息
            共享内存模型和分布式内存模型，适合解决地理分布型问题，强大的容错性
            基于消息传递，侧重通道两端实体
            每个actor有一个mailbox, mailbox中转消息
## csp
    介绍
            通信顺序进程(communicating sequential processes)
            基于消息传递，侧重信息通道
## 数据级并行
## lambda架构
    介绍
            综合MapReduce和流式处理的特点，处理大数据问题的架构

# 认证
    token 
        类型
                access token
                        # 标识唯一用户
                        user_id
                        issue_time
                                # token发放时间，单位秒
                        ttl
                                # 有效时间，uint16,单位分钟
                        mask
                                # int128, 按bit分组用户，用于批量封禁或其它功能
                refresh token
                        # 用来换access token，与access token同时发放
                        # 过期时间更长
        实现
                redis存储
                token不要太长
# 数据库
    数据库类型
            关系型数据库
            模糊型数据库
            统计数据库
                    管理统计数据的数据库系统。这类数据库包含有大量的数据记录，但其目的是向用户提供各种统计汇总信息，而不是提供单个记录的信息。 
            网状数据库(层次数据库)
                    处理以记录类型为结点的网状数据模型的数据库。处理方法是将网状结构分解成若干棵二级树结构，称为系。
            演绎数据库         
                    是指具有演绎推理能力的数据库。一般地，它用一个数据库管理系统和一个规则管理系统来实现。将推理用的事实数据存放在数据库中，称为外延数据库
                    ；用逻辑规则定义要导出的事实，称为内涵数据库。主要研究内容为，如何有效地计算逻辑规则推理。
                    具体为：递归查询的优化、规则的一致性维护等。

    其它数据存储方式
            文件系统
                    版本控制
            保存持久状态
                    cqrs
            对象数据库
    趋势
            Polyglot persistence (混合持久化)
                    # 将对不同数据库的操作封装成服务
    事务隔离级别
        未授权读取
        也称为读未提交（Read Uncommitted）：允许脏读取，但不允许更新丢失。如果一个事务已经开始写数据，则另外一个事务则不允许同时进行写操作，但允许其他事务读此行数据。该隔离级别可以通过“排他写锁”实现。
        授权读取
        也称为读提交（Read Committed）：允许不可重复读取，但不允许脏读取。这可以通过“瞬间共享读锁”和“排他写锁”实现。读取数据的事务允许其他事务继续访问该行数据，但是未提交的写事务将会禁止其他事务访问该行。
        可重复读取
        可重复读取（Repeatable Read）：禁止不可重复读取和脏读取，但是有时可能出现幻影数据。这可以通过“共享读锁”和“排他写锁”实现。读取数据的事务将会禁止写事务（但允许读事务），写事务则禁止任何其他事务。
        序列化
        序列化（Serializable）：提供严格的事务隔离。它要求事务序列化执行，事务只能一个接着一个地执行，但不能并发执行。如果仅仅通过“行级锁”是无法实现事务序列化的，必须通过其他机制保证新插入的数据不会被刚执行查询操作的事务访问到。

    事务特点
            原子性、一致性、隔离性、持久性（arid）

    事务的两种编写方式
            1.编程式：灵活但不可重用
            2.声明式：不用写java代码,可重用但不灵活
    三种连接
            Connection
                    # 默认情况下，Connection 对象处于自动提交模式下，这意味着它在执行每个语句后都会自动提交更改。如果禁用自动提交模式，为了提交更改，必须显式调用 commit 方法；否则无法保存数据库更改。
            Pooled Connection
                    # 该连接在应用程序使用完后可以回收而不用关闭，从而减少了需要建立连接的次数。
            XA Connection
                    # 为分布式事务提供支持的对象。可以通过 XAResource 对象在分布式事务中利用 XAConnection 对象。事务管理器（通常为中间层服务器的一部分）通过 XAResource 对象管理 XAConnection 对象。
## rds
    缺点
            阻抗失谐
                    # 和内存中的模型存在差异
    事务正确性
            # ACID,将请求序列化，使之成为原子的，隔离的
            Atomicity(原子性)
            Consistency(一致性)
            Isolation(隔离性)
            Durability(持久性)
    安全
            sql注入
                    # 方法  用 prepareStatement  或  存储过程
                    # 避免:用preparedStatement 中的? 替代sql语句中的参数 ，这样可以先编译sql语句中的条件为对象      
                    ' or 1=1 or '
    关系级别
            # Normal Form 范式, 用于避免冗余数据
            1NF
                    有主键，主键非空，主键不重复
                    列原子性
            2NF
                    列不能只依赖联合主键中的一个列
            3NF
                    不能存在非主键的传递性依赖
                            # 非主属性在其它表做属性
    工具
            postgres
            sqlserver
            mysql
            mariadb
            percona
                    # mysql分支
            drizzle
                    # mysql分支
            oracle
            sqlite
            db2
            oceandb
            h2database
            tidb
### sql
    dcm操作: create drop alter show desc                                    
            create database db1 character set utf8 collate utf8_general_ci;
                    # create or replace
            drop database db1;
            create table student(
                    # create or replace
                    id int unsigned not null auto_increment
                    name varchar(20),
                    age int,
                    birthday date
                    )character set utf8 collate utf8_general_ci
                    engine=innodb default charset=utf8;
            create table person like student;
                    # 复制表结构
                    create table emp1 as select * from emp;
            drop table student;
            truncate table emp;
            alter database db1 character set gbk collate gbk_chinese_ci;      
                    # 更改数据库的编码
            alter table student add column sex char(1);
                    alter table student change sex gender char(1);
                            # 只能改名，但类型必须写
                    alter table student modify birthday varchar(20);
                            # 只能改类型
                    alter table student drop column name;
                    alter table student rename to stu;
                    alter table student convert to character set utf8 collate utf8_general_ci;
                            # 转换表编码
                    alter table tb1 rename to tb2
                    alter table tb add constraint id_pr primary key (id)
                            # 添加约束
                            alter table tb add constraint  st_id_fk foreign key (st_id) references tb2(id)

            rename table tb1 to tb2;
            show databases;
            show create database day02;
            show tables;
            show create table student;
            desc student;

    dml操作: insert delete update select
            insert into tb1 (name) values ('a'),('b');
                    insert into tb1 values (3, 'a', null);
                    insert into emp select * from xx_emp;
                            insert into emp(a, b) select c, d from xx_emp
            delete from tb1 | update tb1 set name='a' | select name as n1 from tb as tb1
                    where and | or | (not) in | (not) between | like
                            # like不能用*, * 在select中代表所有列
                            # % 匹配任意个字符
                            #_ 匹配一个字符
                            # \ 转义_或%（oracle 要在like语句后加escape '\'语名，也可escape其它字符）
                    order by asc | desc 
                            ## 空值看作最大值
                    group by having
                            # select 语句中的真实列名一定出现在group by中，group by 语句中出现的条件不一定出现在select中
                            # where 是行过滤器, having 是组过滤器, where 先执行
                            # 有多行合并函数时，where剩下的部分分列在不同的表中，只有按照列名分组以后having才能按列名执行多行合并函数
                            select a count(b) from tb group by a having count(b) > 2
                            select a from tb1 
                                    where b in (select b from tb2 where c='c') 
                                    group by a 
                                    having count(distinct b) = (select count(*) from tb2 where c='c')
            
            select * from outrun.employee;
                    # 限定数据库名    
            select a, b into tb2 from tb1;
            // 总分字段不能在where 后,distinct 表示不重复,limit 0分页的第几页  1代表1条数据
            select distinct (a+b) as c from tb
                    sum(price)

    连接查询
            内连接
                    select * from emps as a,emps as b where a.id = b.id;
                            # 笛卡尔积
                    select * from emps as a [cross] join emps as b where a.id = b.id;
                            # 交插连接
            左外连接                
                    # 以左边表为基准，查右边
                    select * from emps as d left [outer] join employee as e on d.dep_id=e.dep_id
            右外连接
                    right [outer] join
            全连接
                    # 合并左外和右外, 要求两边查询出的结构相同
                    左外连接 union 右外连接
            自连接
                    # self join
                    # mysql中没有自连接,两边表名一样即可
                    select a.cno, b.pcno from course as a, course as b where a.cno=b.pcno
            自然连接
                    # 两表列名相同，类型相同或可隐式转换，合并重复内容
                    natural [left [outer]] join
                    natural [right [outer]] join
            
    约束
            主键
                    primary key unique, not null auto_increment
                    primary key(col1, col2)
                            # 联合主键                    
            外键
                    constraint st_id_fk
                            foreign key(st_id) references tb2(id) 
                                    # 例: st_id int, foreign key(st_id) references teacher(id)
                                    # 被引用的列要建索引，如主键
                                    # 不可以删掉被引用的记录，可以修改
                                    # 不可以改被引用的值，要用级联操作
                            on update cascade
                            on delete cascade
                                    # 级联约束, 约束外键
            添加约束
                    alter table tb add constraint id_pr ...
    视图                
            create view emp_v (a,b) as select a, b from tb
                    #  create or replace 
            # 如果没有指定视图别名, 就使用查询的别名
## nosql

    介绍
            aggregate-oriented (面向聚合)
                    键值
                    文档
                    列族
            relationship-oriented (面向关系)
                    图
    特点
            schemaless
            应用程序数据库（作为微服务的数据库来解耦）
            aggregate
                    # 图除外
                    # 领域驱动设计中提出
            图支持事务
            牺牲一部分一致性和持久性

    CAP定理
            # 当面临分区的时候，必须在一致性和可用性之间权衡
            Consistency(一致性)
            Availability(可用性)
            Partition tolerance(分区容错性)

    问题
            逻辑不一致
                    # 存在不一致窗口
                    会话一致性问题

    方式
            物化视图来处理更新
            实时BI, 来更新中间关系聚合
            一致性
                    锁
                    条件更新(更新前检查)
                            版本戳
                                    # http 中的etag
                    写入仲裁与读取仲裁
                            复制因子大于某值时认为写入完成
                            读取多于某值个节点数据并相同时，认为读到最新数据
                    用zookeeper等外部“事务”程序库同步读写操作
### 图
    介绍        
            领域
            关系是一等公民
            大部分不支持分布式
            Gremlin，Cypher 查询语言
    适用
            互联数据
            运输等基于位置的服务
            推荐引擎
    不适用
            经常更新
    工具
            neo4j
            flockDB
                    # 仅支持单深度关系及邻接表
            hyperGraphDB
            infiniteGraph
            allegroGraph
            orientdb
### 列族
    特点
            键空间
    适用
            事件记录
                    # 事件id为行
            内容管理
            计数器
            带过期的列
    不适用
            ACID事务
            多行数据聚合
    工具
            cassandra
            hbase
            amazon simpleDB
            hypertable
            bigtable
#### cassandra
    特点
            良好的分布式扩展性
            功能比key-value丰富，不如mongo
            写快于读
            不稳定
            没有主节点，所有节点平等
            查询语言CQL
            列TTL(秒)
    命令
            use aaa
                    # 用aaa键空间
#### hbase
    特点
            hdfs存储，分布式，面向列
            可利用map reduce
    特点
            多版本
            列权限控制
            多个列划分为列族，可设置保留多少版本
            多行划分为region
            空列不占空间，可稀疏存储
            无类型，所有类型都是字符串
            行一致性，一行数据在一个server
            查询方式有限：rowkey, rowkey的range, 全表扫描
            协处理器coprocessors
                    观察者observer（监听器）
                    终端endpoint（rpc调用代码）
### 文档
    适用
            事件记录
            内容管理
            网站分析与实时分析数据
            电子商务中产品或订单
    不适用
            事务
            持续变化的数据
    工具
            couchDB
            orientDB
            ravenDB
            terrastore
            xml数据库
            mongoDB
            memDB
                    # 带事务的mongo
            tokumx
#### couchDB
    特点
            apache托管,  alang语言开发的，面向文档的分布式数据库
            json结构，易于存储cms, 电话本，地址本等半结构化数据。存储类似于lucene的index
            易添加，不易修改
            主主双向复制
### 键值
    适用
            session
            用户配置信息
            购物车
    不适用
            数据间关系
            多项操作的事务
            模糊键查询
            对集合关键字操作
    工具
            redis
            riak
                    # 类cassandra
            berkeleyDB
            levelDB
                    # google
            memcached
            project voldemort
            tokyo cabinet
            rocksDB
## newsql
    工具
            分布式
                    google spanner
                    voltdb
                    clustrix
                    nuodb
                    tidb
            h-store
            foundationDB
            scalebase
            dbshards
            scalearc
            tokudb
            memsql
## 流式数据库
    piplelineDB
            # 依赖zeromq, 记录时间段内的事件
## proxy
    mycat