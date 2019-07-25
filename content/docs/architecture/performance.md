
# 原则
    qps
    latency
    through put

    bottle-nect

    io
        磁盘
            iops: 2k
        网络
            带宽
            iops: 3w


# 流量
    小米论坛
        pv 2000w
        热门并发300
        20k/页面
        300k/图片(未压缩)
        70k/无图帖子
        500k-3M/有图帖子

        动态服务器最小带宽: 48Mbps
        静态服务器最小带宽: 1440Mbps
        实际购买带宽: 800M
        带宽费用: 8.7w/month

    糗事百科
        pv 1000w
        热门并发150
        10k/页面
        70k/图
        4图/页
        90k-400k/综合页
        动态服务器带宽: 12Mbps
        静态服务器带宽: 336Mbps

# 带宽
    建议
        热门并发1.5倍到2倍购买
# cdn
    介绍
        流量不大时带宽比cdn便宜, 流量大时cdn便宜。
        界限为250Mbps左右，价格在9k/month
    价格     50TB/月        100TB/月
    阿里云   3.8w/月        6.9w/月
    盛大云   9k/月          1.7w/月
    网宿                  
    蓝汛                  
# 服务
    teamwork
        confluence
        teambition
        basecamp
        jira
        testlink
        shimo
        dropbox
        trello
    itsm/erp
        # IT Service Management, 信息技术服务管理
        salesforce
        servicenow
        workday
            # hr平台
    pay
        支付宝
        易宝
        财付通
    cti
        天润
        云之讯
        容联
    report/olap
        palo
    idc
        # infomation data corporation 互联网数据中心
    cdn
        七牛
    ws
        阿里云
        青云
        digital ocean
        vultr
        aws
        Linode
        azure
            # 微软开放平台
        gce
            # google compute engine
        txCloud
            # 云柜，数据存储和计算
        首都在线
    paas
        gae
            # google app engine
        sae
            # sina app engine
        heroku
    im
        环信
        云片
        jpush
        im
        sms.webchinese.cn
        个推
    ops
        docker
    safe
        1password
    dns
        godaddy
        万网
        dnspod
# 压力
    并发
        jetty 2k-3k
        nginx 1w
        lvs 100w
        f5 + lvs 400w-800w
        mysql 1k
        oracle 1.5k-2k
        tomcat 1k

    1并发/10在线用户/100注册用户

    1用户/20pv

    访问时段
        8点 - 23点
        最大访问量为平均值1.7倍

    每个html页面20k, 40k/css, 50k/js. css与js会缓存

    数据库
        mongodb
            查询
                4w++/5s                # aurora测

    一个进程13M左右
        10g内存787多并发(最早的apache)
    一个线程2M内存
        10g内存5120并发

    cpu一级缓存取数据: 3个时钟周期(tick)
    cpu二级缓存取数据: 14 tick
    内存取数据: 250 tick
    磁盘取数据: 4100w tick
    网络取数据: 24000w tick

    负载均衡器
        # 并发在100w - 800w
        深信服
        F5
# 优化
    目的
        稳定
        性能
        扩展
        代码清晰
        解耦
        冷热，新旧数据区隔
        成本
    结构
        找瓶颈
        去单点
        服务化
        优质业务专门机器
        广播改订阅
        换语言/框架重构
    数据库
        连接释放
        减少不必要数据
        索引
        异步化
        分表
            # 垂直 分字段，水平 分记录
            拆微服务直接做
            hash到几张表
            时间分表
            水平分表proxy
            冷热分离
            lookup table
# 工具数据
    nodejs
        虚拟机数据
            mem: 512m
            mem: 66.7%
            cpu: 1%
        执行
            5秒循环mongo数据: 17w条
        状况
            程序完全阻塞

        并发: 300
        qps: 140
        8核全满

        2-4G 内存 3000万并发
        5w socket                        # 系统最高65535个端口，支持这么多连接
        已实现成就
            ruby迁移到node.js有10倍的性能提升，特定情况下20倍性能提升
            5w并发/min


    redis
        200并发, 每次3ms, 37000次/s

    mysql
        最多3.5w写入/s