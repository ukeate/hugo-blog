---
Categories : ["后端"]
title: "后端"
date: 2018-10-10T14:36:50+08:00
---

# 领域
## erp
    jbpm
    activiti
            # 工作流
    YAML
            # 工作流
    bossa
            # 工作流引擎
    azkaban
            # 开源oa
    grav
            # 开源cms
    nopCommerce
            # .net开源电商
## 游戏
    pomelo
            # 网易开源的实时性好的游戏类服务器 
## 展示
    cleaver
            # 基于node幻灯片
    hexo
            # 生成博客
    jekyll
            # 博客
    hugo
            # 静态网站
## gis
    ide
            skylive
            arcGIS
            mapInfo
            mapGIS
            superMap
    库
            webglobe
            arcpy
## 搜索
    分类
            垂直搜索引擎
                    针对某一个行业的专业搜索引擎，是搜索引擎的细分和延伸，是对网页库中的某类专门的信息进行一次整合，定向分字段抽取出需要的数据进行处理后再以某种形式返回给用户。
            通用搜索引擎
                    通过关键字的方式实现的，是语义上的搜索，返回的结果倾向于知识成果，比如文章，论文，新闻等
                    通用搜索引擎的信息量大、查询不准确、深度不够
                    通用搜索引擎的海量信息无序化

    部分
            １.索引
            ２.分词
            ３.搜索

    lucene
    solr
    compass
            # 基于lucene
    nutch
            # 基于lucene
    sunspot
            # 基于Rsolr，以dsl结构用ruby调solr
    elasticsearch
    sphinx
            # 基于sql的全文检索引擎
## 数据
    爬虫
        cheerio
                # node解析html，如jquery
        scrapy-redis
                # python 分布式爬虫框架
        phantomjs
                # js浏览器模拟框架
    分析
        pandas
                # python数据分析
    计算
        hadoop
    日志
        scribe
                facebook出品
                特点
                        支持nfs存储
                结构
                        scribe agent
                                向scribe发送数据
                        scribe
                                接收数据，不同topic 的数据发送给不同的store中
                        存储系统(store)
                                file, buffer, network, bucket, null, thriftfile, multi
                        
        chukwa
                # apache出品，hadoop系列产品
        flume
                cloudera出品
                特点
                        可靠性(节点故障时，日志传送到其他节点)
                                三种级别
                                        end-to-end 发送前写磁盘，成功时删除
                                        store on failure 失败返回时写磁盘
                                        best effort 不确认数据是否成功
                        可扩展性
                                agent collector storage三层架构，每层可扩展。
                                        agent: 将数据源数据发送给collector
                                        collector: 将多个agent数据汇总后, 加载到storage中
                                        storge: 存储系统, 可以是file, hdfs, hive, hbase等
                                agent collector 由master统一
        logstash
                # 分布式日志收集，需结合kafka
## ai
    tensorflow
            # 神经网络计算
    convnet.js
            # js深度学习
    scikit-learn
            # python机器学习
## http
    luavit
            # lua实现, 类node
    scotty
            # haskell
    webapi
            # .net
    meteor.js
            # 基于node.js + mongodb的网站开发平台，把这个基础构架延伸到浏览器端, 本地和远程数据通过DDP(Distributed Data Protocol)协议传输
    restify
            # 基于nodejs的rest应用框架，去掉express中的 template, render等功能, 提供DTrace功能，方便调试
    connect
    express
    koa
    ssh
            # java
    naga
            # java nio
    shiro
            # java 权限
    echo
            # go
    beego
            # go
    gin
            # go，类express
    iris
            # go, fasthttp的一种实现
    tornado
            # python nio
    web.py
    twisted
            # event driven
    flask
    django
    bottle
            # python wsgi
    rails
            # ruby的web mvc开发框架
    ror
            # ror(ruby on rails)
    sinatra
            # 微型web
    grape
            # 运行在rack或rails/sinatra配合使用的restful风格的ruby微框架
    yii
            # php
    laravel        
            # php
    codelgniter
            # php
## 消息
    socket.io
    sockjs
            # node websock
    postal
            # nodejs 在内存上构建的发布订阅框架
    pusher
            # 发布订阅模式socketio框架
    juggernaut
            # 基于socketio
    datachannel.io
            # 基于socket.io和html5 webRTC的实时聊天室框架
    faye-websocket-node
            # 扩展faye项目开发的websocket的一个实现, 非常简单，而且不依赖其他库
    websocket-node
            # 一个简单的websocket库，支持draft-10及之前的各种版本, 支持同样是node的c/s交互模式
    ejabberd
            # 基于erlang/OTP 的xmpp im 开源框架
    singalR
            # .net sock服务
    nsq
            # go
    openfire
            # java, 性能较差, 最多单机10w并发
    webrtc
            # c++实现的web视频聊天
## dsl
    lex
            # 生成词法分析程序
    yacc
            # 生成自底向上语法分析程序
    antlr
# 写法
    traits-decorator
            # js mixin
    q
            # js 流程控制
    co
            # js generator to async
    async
            # js 流程控制
    thunkify
            # js函数Thunk化, 确保回调调用一次
    step
            # async轻量库
    wind
            # js定义的宏
    streamline
            # 基于源代码编译来实现流程控制简化
    eventproxy
            # js event回调
    spring
            # java ioc
    castle
            # .net ioc
    spring.net
            # .net ioc
    anko
            # go 代码解释器
    antlr
            # java dsl
# 格式
    moment
            # js格式化时间
    iconv
            # nodejs调用c++ libiconv库来转码
    iconv-lite
            # nodejs实现的转码，比调用c++ 的iconv更高效
    poi
            # java 文件处理
    jFreeChart
            # java图表库
    jackson
            # java json序列化
    xstream
            # java xml序列化
# 套件
## ha
    retry
            # js retry
## log
    log4j
            # java
    log4js
            # js
## client
    c3p0
            # java rds 连接池
    dbcp
            # java rds 连接池
    druid
            # java rds 连接池
    jdbc
            # java rds client
    dbutil
    hibernate
    mybatis
    ef
            # .net orm
    NHibernate
            # .net orm
    peewee
            # python orm
    node-mysql
    mongoose
    httpClient
            # java http
    request
            # js http
    superagent
            # js http
## 邮件
    javamail
    nodemailer
## 定时
    later
            # nodejs corntab
## 命令
    glob
            # nodejs 匹配获得文件
    rd
            # node 遍历文件
    commander
            # node制作命令
    mkdirp
            # node 递归makedir
    fs-extra
            # node扩展fs包
## 图形
    ccap
            # 基于c++的图形CImg库，就是一个CImg.h文件
    canvas
            # node canvas
    tesseract
            # node 验证码
## 线程
    tagg
            # node线程池
    cluster
            # node单机集群
    fiber
            # node协程
## 特征
    simhash
            # google 文档hash
## 代码生成
    pygments
            # python 生成高亮html
    mako
            # python 模板
    jinja2
            # python 模板
    freemarker
            # java 模板