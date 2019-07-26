---
Categories : ["架构"]
title: "架构-原理"
date: 2018-10-10T15:25:12+08:00
---

# 基础
    CAP定理
        # 当面临分区的时候，必须在一致性和可用性之间权衡
        一致性Consistency
        可用性Availability
        分区容错性Partition tolerance
    BASE    # 解决CAP
        基本可用(basic available)
        软状态(soft state)
        最终一致性(eventually consistent)
# cpu
    介绍
        单cpu串行工作，前任务完成，后任务才开始
            # 串行不适合图形处理(多点，线，面要同时乘投影矩阵)
        cpu把大量空间和电量分配给控制器和缓存，不能集成太多计算单元
        cpu内存通过cpu总线连接, cpu总线与pci总线通过主桥(北桥)连接
            # 显卡在pci总线上
            ## 控制逻辑在cpu中运行, 生成渲染数据, 到内存, 再到显存显卡计算。
            ### 内存到显存数据传输最花费时间。
    进程: 独有内存
    线程: 共享进程内存(地址空间、文件描述符)
        一个进程下的轻量进程
        POSIX线程api是对已有unix进程模型扩展, 与进程多方面类似
            自己的信号掩码
            cpu affinity(倾向在某cpu尽量长时间运行)
            cgroups
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
## 进程调度
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
# gpu
    介绍
            gpu控制单元少, 计算单元多
            显卡在pci总线上
# 内存
    dma
        # direct memory access 不依赖cpu的内存存取
    栈
        申请方式: 系统自动分配
        申请响应: 栈剩余空间小于申请空间, 报overflow
        申请大小限制: 栈是向低地址扩展的连续内存，线顶地址和最大容量是系统编译时预设的，windows下为2M(或1M), 申请超过剩余空间报overflow
        申请效率: 系统分配，速度快
        存储内容: 函数调用时，函数调用语句的下一条指令的地址进栈，然后是参数(C中由右向左), 然后是局部变量。调用结束后，局部变量先出栈，然后是参数，最后栈顶指针指向开始保存的函数下一指令，继续运行
        数据结构: 满足后进先出的数据结构
    堆
        申请方式: 程序手动申请
        申请响应: os有记录空闲内存地址的链表，申请时遍历链表，寻找第一个空间大于申请空间的堆结点，该结点从空闲结点删除，节点分配给程序。自动将多余部分重新放入空闲链表
        申请大小限制：堆是向高地址扩展的不连续内存，系统用链表存储空闲内存地址。受限于有效虚拟内存
        申请效率: 慢，容易产生内存碎片
        存储内容: 堆头部一个字节存放堆的大小。内容由程序员安排
        数据结构: 满足优先队列的数据结构(第1个元素有最高优先权)

# 网络
    OSI分层
        物理层
        数据链路层
        网络层
        传输层
        会话层
        表示层
        应用层
    ABR(area border router)：区域边界路由器
## 安全
    子网隔离
    CSRF (Cross-site request forgery)
        客户端登录A, 本地生成cookie
        客户端登录B, B给客户端参数，使客户端请求A
        避免
            token验证     # 放
            入自定义头域
            验证Referer头域
## 状态
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
## 数据链路层
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
    mac
        Media Access Control
                mac帧结构
![""](/docs/architecture/mac.jpg)

                    单位
                            字节
                    帧类型/长度（TYPE/LEN）：
                            该字段的值大于1500时，表示上层数据使用的协议类型。例如0x0806表示ARP请求或应答，0x0800表示IP协议。
                            该字段的值小于1500时表示以太网数据的长度，上层携带LLC-PDU。
                    帧校验FCS：
                            以太网采用32位CRC冗余校验。
    llc
        Logical Link Control
                llc-pdu结构
![""](/docs/architecture/llc1.jpg)
![""](/docs/architecture/llc2.jpg)

                    pdu : 协议数据单元
                    dsap : 目标服务访问点
                    ssap : 源服务访问点
                    控制位 : 三种


    arp
        Address Resolution Protocol                                                                # arp属于中间层，为ip层服务协议
                arp帧结构
![""](/docs/architecture/arp1.jpg)

                arp协议的分组格式
![""](/docs/architecture/arp2.jpg)

                arp在windows命令提示行下的命令
                        arp -a                                         查看arp缓存表中的内容
                        arp -d                                        清空arp缓存表

## 网络层
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

    icmp
        Internet Control Message Protocol   # Internet控制报文协议
            是ip层的子协议
            封装
![""](/docs/architecture/icmp1.jpg)

            报文格式
![""](/docs/architecture/icmp2.jpg)

            主要报文类型
![""](/docs/architecture/icmp3.jpg)

            时间戳报文举例
![""](/docs/architecture/icmp4.jpg)

            重定向报文举例
![""](/docs/architecture/icmp5.jpg)

    igmp
        Internet Group Management Protocol                                                        # Internet组管理协议
                报文格式
                        8位IGMP类型    8位响应时间    16位检验和
                        32位组地址(D类IP地址)）
    ospf
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
    bgp
        介绍　
                border gateway protocol 边界网关协议
### ip
    Internet Protocol                                # ip地址是互联网主机的唯一标识
![""](/docs/architecture/ip1.jpg)

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
![""](/docs/architecture/ip2.jpg)

    ip分片    # 一个MTU（链路层）较大的网络传输到MTU较小的网络过程中，将一个较大的数据包分为几个较小的数据包来传输。
        利用PING命令中的参数–l 可以设置数据部分的字节数
### 抓包
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
## 传输层
    协议
            TCP        Transmission Control Protocol 传输控制协议
            UDP        User Datagram Protocol 用户数据报协议
            RTP
            SCTP
            SPX
            ATP
            IL
            rts/cts    视频数据传输
    udp
        User Datagram Protocol
            封装
![""](/docs/architecture/udp1.jpg)

            报文
![""](/docs/architecture/udp2.jpg)

            有伪首部的报文                                                                        # 伪首部只是单纯为了做校验用的
![""](/docs/architecture/udp3.jpg)

                校验和的计算方法                                                        # UDP“检验和”是一个端到端的“检验和”，包括UDP首部、UDP伪首部和UDP数据。
                                                                                            ## UDP12字节的伪首部是为了计算“校验和”而设置的，不参与网络传输。

    tcp
        Transmission Control protocol
            报文格式
![""](/docs/architecture/tcp1.jpg)

            三次握手
![""](/docs/architecture/tcp2.jpg)

                    ACK : Acknowledgement
                    SEQ : Sequence
                    SYN : Synchronous
            断开连接
![""](/docs/architecture/tcp3.jpg)

                    FIN : Final
            d.o.s(denial of service)攻击                                                # ddos(distributed denial of service)
![""](/docs/architecture/tcp4.jpg)

    socket
        socket可以基于tcp或udp
        一个socket对应系统中一个端口
                # 操作系统中可用端口65535, 所以只能有65535个socket连接
    ssl
        ssl加密(消息, node模块)
                非对称生成公私钥(慢)
                对称传数据(快)
## 会话层
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
## 表示层
    协议
            XDR
            ASN.1
            SMB
            AFP
            NCP
## 应用层
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
### tcp传输
    telnet
        telnet                                        # 一个简单的远程终端协议。用户可以通过TCP连接登录到远程的一个主机上，好象使用远程主机一样。
                采用客户机/服务器计算模式。在本地系统上运行TELNET客户机进程，在远程主机上运行TELNET服务器进程。
                用于远程管理一台主机
                命令
                        >telnet 192.168.1.200
                        >Login: group1_1
                        >Password: group1_1
                        >按“CTRL+]”回到telnet提示符下
                        >quit 退出telnet

    ftp
        File Transfer Protocol
                一个客户机/服务器系统。
                端口 : 20或21                                                                        # 21用于控制，20传输数据流

    smtp
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

    pop
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
    imap
        Internet Mail Access Protocol                                                        # 交互邮件访问协议 ， 本地对邮件服务器中的邮件进行管理
                端口 : 143
    rtmp
        介绍　
            adobe专利, flash支持,
    http-flv
        介绍　
                开源流式传输协议，优于RTMP
    hls
        介绍　
                http live streaming 苹果创建, 延迟较高
                html5原生支持
                m3u8扩展名，里面封装ts小视频
#### http
    1.0与1.1区别
        扩展性
            1.1消息中增加版本号
            1.1增加OPTIONS方法
            1.1增加Upgrade头域, 客户端使服务器知道它支持的其它备用通信协议
        缓存
            1.0使用Expire头域判断资源的fresh或stale，使用条件请求(conditional request)判断资源是否仍有效
            1.1加了新特性，当缓存对象的Age超过Expire时变为stale对象, cache不是直接抛弃stale对象，而是与源服务器进行重新激活(revalidation)
        带宽
            1.0中只能下载全部文档
            1.1请求消息引入range头域，只请求资源某个部分。响应消息Content-Range头域声明这部分对象的偏移值和长度。
                返回范围内容时，响应码为206(Partial Content)，可防止Cache误以为是完整对象
            1.1新状态码100(Continue), 事先发送只带头域的请求，服务器因权限拒绝就返回401(Unauthorized)，服务器接收就返回100。避免发送完整请求浪费带宽
            1.0不支持状态码100, 可加入Expect请求头, 值设置为100-continue
            压缩传送的数据，Content-Encoding是对消息端到端(end-to-end)的编码，可能是资源在服务器上的固有格式(如jpeg图片格式)。请求头加入Accept-Encoding头域，通知服务器客户端能够解码的方式
        长连接
            1.0只有短连接,请求后立即断开TCP连接。多数网页请求流量小，一次TCP连接很少通过slow-start区，带宽利用率低
            1.1支持长连接(persistent connection), 和请求的流水线(Pipelining)处理。
                数据传完不发RST包，不四次握手，等待同域名继续用这个通道。
                在一个TCP连接上传送多个HTTP请求和响应。
                允许客户端不等待上一次请求结果返回，就发出下一次请求。服务端必须按照接收到客户端请求的顺序返回响应结果。
        消息传递
            1.1引入Chunkedtransfer-coding, 发送方将消息分割，每块附上长度，最后用零长块作为结束标志。允许发送方只缓冲消息的一个片段，避免缓冲整个消息带来过载
                结束块之后，再传递一个拖尾(trailer)，包含传递完所有块计算出的头域
            1.0有个Content-MD5头域，计算它需要发送方缓冲整个消息。Content-Length需要计算整个消息的大小
        Host头域
            1.0认为每台服务器有唯一绑定的ip，实际一台物理服务器可以存在多个虚拟主机(Multi-homed Web Servers)，共享一个ip
            1.1请求和响应消息都应支持Host头域, 请求消息中没有Host头域会报错(400 Bad Request)。
        错误提示
            1.0只定义了16个状态响应码
            1.1引入Warning头域，增加对错误或警告的描述
            1.1新增了24个状态响应码
    状态码
        200 OK
        301 Moved Permanently       永久移除
        302 Found                   重定向
        400 Bad Request             请求有语法错误
        401 Unauthorized            请求未经授权
        403 Forbidden               拒绝服务
        404 Not Found               资源不存在
        500 Internal Server Error   服务器发生不可预期的错误
        503 Server Unavailable      服务器当前不能处理请求
        409 Conflict                请求资源与资源当前状态冲突
        410 Gone                    资源永久性删除
    http/1.1 请求动作
        get
            数据在url, 最多1024字节(各浏览器实现有差异,受操作系统限制)
        post
        options         # 返回服务器支持的所有http请求方法
        head             # 同get, 但不传回文本部分
        put             # 同post, 但是idempotent的，后面相同的请求会覆盖前面的请求,服务器状态会被crawler修改
        delete             # 请求删除被请求的资源
        trace             # 回显服务器收到的请求
        connect      # 预留给能够将连接改为管道方式的代理服务器。通常用于SSL加密服务器的链接（经由非加密的HTTP代理服务器）
        patch             # 给服务器资源打补丁
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
### udp传输
    dns
        domain name system
            分类
                    位于最右端的域称为顶级域。接下来是二级域名和三级域名。如www.jlu.edu.cn
            端口
                    53
            过程
                    本机缓冲区 -> 本地域名服务器(缓冲区与数据库) -> 其它域名服务器
            报文格式
![""](/docs/architecture/dns1.jpg)

                    Queries
![""](/docs/architecture/dns2.jpg)

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

    dhcp
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



    rip
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

    snmp
        Simple Network Management Protocol                                        # 简单网络管理协议 ， 使网络管理员能够管理网络效能,发现并解决网络问题以及规划网络增长。
                                                                                        ## 通过SNMP接收随机消息及事件报告网络管理系统获知网络出现问题。
                端口 : 161
    rtp
        介绍
                real-time transport protocol 传输流媒体
                udp传输, 实时性好
    rtcp
        介绍
                RTP Control Protocol 交互控制RTP传输
    radius
        介绍
                拨号认证用的AAA协议
# 电话
    cti 
        computer telephony integration
        computer telecommunication integration
            计算机技术应用到电话系统中，识别信令信息进行处理，传送预定录音文件
            转接来话，处理传真，电子邮件等

# 分布式服务
    架构
        服务网格
        容器调度编排
        容器runtime
        基础设施
                # 云服务器
    分层
        服务
            对外网关
            服务容器    # 如aws, k8s, mesos
                通讯能力    # http/1.1 http/2 grpc tcp
            配置(分布式)
                部署
                版本控制
            网关
                访问策略/认证(auth)
                    细粒度权限控制
                智能路由
            服务治理(注册,发现)
                区域感知、load balance
                容错: 故障切换、熔断、故障注入测试
                流量拆分和推出
        监控
            metrics(api统计, cpu、内存、时长、平均、缓存命中等)
            调用链跟踪(tracing)
            日志
            健康检查和告警
            服务网可视化
        对外
            授权(OAuth2)
            安全传输协议(tls)
            限流(quota)   # 网络数据、api调用
## 高可用(high available)
### 负载均衡与反向代理
### 隔离
### 限流
### 降级
### 超时与重试
### 回滚
### 压测
## 高并发(high concurrency)
### 应用级缓存
### http缓存
### 多级缓存
### 连接池线程池
### 异步并发
### 扩容
### 队列
