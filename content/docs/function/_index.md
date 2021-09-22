---
title: 大功能
Categories: ["功能"]
date: 2018-10-10T14:51:24+08:00
type: docs
---

# 企业
## ERP
    # Enterprise Resources Planning
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
### CMS
    # Content Management System
#### wordpress
    # php
#### dedecms
    # 织梦cms, SEO优化
#### 帝国cms
    # SEO优化
#### phpcms
#### phpwind
    # 开源, 社区管理系统
#### drupal
    # 开源, cms
### 工作流
#### JBPM
    # 常识
        适用对象：业务逻辑不复杂，业务流程会变化
            # s2sh适合业务逻辑复杂，但是业务流程不会变化的项目
        jbpm封装hibernate
        包含对象
            模型
            实例（由活动组成，包括活动、箭头等）
            任务（需要人办理的活动）


    # 使用
        myeclipse添加jbpm xml画图插件
            MyEclipse -> MyEclipse Configuration Center -> Software -> Browse Software(add site) -> add from archive file找到jbpm-gpd-site.zip,取名为jbpm4.4 -> Browse Software(Personal Sites -> jbpm4.4下8个选项)右键add to Profile -> 右下角apply changes -> 重启myeclipse -> 新建文件中找到新建jbpm xml文件
            画图
                test.jpdl.xml文件用jbpm工具打开
                打开Properties视图
        配置
            jbpm.hibernate.cfg.xml                # mysql方言要配置InnoDB的方言（因为jbpm建表时对表指定了type=InnoDB约束）
            配置hibernate的5个映射文件（导入的jbpm.jar包中有）
                <mapping resource="jbpm.repository.hbm.xml" />
                <mapping resource="jbpm.execution.hbm.xml" />
                <mapping resource="jbpm.history.hbm.xml" />
                <mapping resource="jbpm.task.hbm.xml" />
                <mapping resource="jbpm.identity.hbm.xml" />
            jbpm.cfg.xml:

        api
            hibernate的api:org.hibernate.cfg.Configuration()
                .configure("jbpm.hibernate.cfg.xml").buildSessionFactory();进行hibernate配置文件加载测试
            delete_deployment       # 有实例时不能删除
                                    # 级联删除时出现constraintViolationException的原因：
                                    ## jbpm4.4下载包中/install/src/db/create/下有创建jbpm各个数据库时用到的sql文件
                                    ##　如果是mysql数据库，其中表有type=InnoDB约束。该约束的方言类为hibernate-core.jar包下/org.hibernate.dialect.MySQLInnoDBDialect的类文件
                                    ## ，在hibernate的配置文件中配置该方言就可以解决问题
    # 表结构
        表
            模型
                jbpm4_deployment
                jbpm4_lob
                jbpm4_deployprop
            实例
                jbpm4_execution
                jbpm4_hist_procinst
                jbpm4_task
                jbpm4_hist_task
            活动
                jbpm4_hist_actinst
            变量
                jbpm4_variable

        id关联
## MES
    # Manufacturing Execution System
## ITSM
    # IT service management
    sap
    salesforce
    servicenow
    workday
        # hr平台
# IoT
    # Internet of Things
    Kaa
    SiteWhere
        # tomcat, mongodb, hbase, influxdb, grafana
    ThingSpeak
        # matlab可视化
    DeviceHive
        # 开源, docker, k8s, es, spark, cassandra, kafka
    Zetta
    Thinger.io
    wso2
## ThingsBoard
    # java, 社区版、企业版
    文档
        github.com/thingsboard/thingsboard
        thingsboard.io/docs
        localhost:8080/swagger-ui.html      # 本地swagger
    安装
        docker
            docker run -it -p 9090:9090 -p 1883:1883 -p 5683:5683/udp -v ~/.mytb-data:/data -v ~/.mytb-logs:/var/log/thingsboard --name mytb thingsboard/tb-postgres
        maven
            确定ui/pom.xml中<nodeVersion>
            mvn install -DskipTests
        配置
            application
                zk
                    ZOOKEEPER_ENABLED
                    ZOOKEEPER_URL
                cassandra
                    CASSANDRA_URL
                    CASSANDRA_USERNAME
                    CASSANDRA_PASSWORD
                redis
                    REDIS_HOST
                    REDIS_PORT
                    REDIS_DB
                    REDIS_PASSWORD
                postgresql
                    SPRING_DATASOURCE_URL
                    SPRING_DATASOURCE_USERNAME
                    SPRING_DATASOURCE_PASSWORD
                kafka
                    TB_KAFKA_SERVERS
        运行
            application
                server
            transport
                http
        demo数据
            admin
                sysadmin@thingsboard.org    sysadmin
            tenant
                tenant@thingsboard.org  tenant
            customer
                customer@thingsboard.org或customerA@thingsboard.org  customer
                customerB@thingsboard.org   customer
                customerC@thingsboard.org   customer
            device
                A1, A2, A3  A1_TEST_TOKEN,...   customerA
                B1  B1_TEST_TOKEN   customerB
                C1  C1_TEST_TOKEN   customerC
                'DHT11 Demo Device'     DHT11_DEMO_TOKEN
                'Raspberry Pi Demo Device'  RASPBERRY_PI_DEMO_TOKEN
    包结构
        application                         # 可改, 网关
            server
                install
                config                      # 同源策略、swagger、websocket、消息、安全
                exception
                controller                  # 页面调用
                service
                actors
                    service
                        DefaultActorService
                            actorContext
                                actorService(this)
                                actorSystem
                                appActor
                                statsActor
                            rpcManagerActor
        common                              # 不可改, 功能代理
            data                            # 数据结构
            message                         # 消息类型
            transport                       # 客户端调用
        dao                                 # 可改, 业务, 适配db
            model                           # 数据库对象
            resources
                sql                         # 表结构
        netty-mqtt                          # 不可改, 数据通信协议
        rule-engine                         # 不可改, 规则引擎
        transport                           # 不可改, 设备端运行
            http                            # 启动http传输协议
            coap
            mqtt
        tools                               # 可改, 工具
        ui                                  # 可改, 页面, angular, react, webpack
        docker                              # 不可改, 打包
        msa                                 # 不可改，分布式
            black-box-tests                 # 黑盒测试
            js-executor                     # 执行js
        log
        img         
    模块
        application
            common
                data                        # 数据结构
                message                     # 消息结构
                transport                   # 接口结构，适配客户端
        dao                                 # 交互data, 兼容不同db
        tools
            extensions
                kafka
                mqtt
                rabbitmq
                rest-api-call
            extensions-api
                action
                filter
                plugin
                processor
            extensions-core                 # 实现公用extensions-api
        transport
            http                            # rest
            coap                            # californium
            mqtt                            # netty
        规则引擎                             # 基于actors执行
            filters
            processors
            action
        ui                                  # node.js + yarn
    表结构
        tenant
        customer                            # 关联tenant
        tb_user                             # user信息、角色
        user_credentials                    # user密码
        admin_settings                      # admin信息, key value形式
        audit_log                           # 登录日志

        asset
        entity_view     
        attribute_kv                        # entity attribute
        component_descriptor                # node类

        device                              # 设备, label
        device_credentials                  # 设备ACCESS_TOKEN
        ts_kv                               # 设备事件
        ts_kv_latest                        # 设备当前状态

        rule_chain                          # rule root chain
        rule_node                           # rule节点
        relation                            # rule关系
        event                               # rule事件
        alarm                               # alarm事件

        dashboard                           # dashboard设置
        widget_type                         # widget, 别名
        widgets_bundle
    api
        host:port/api/v1/$ACCESS_TOKEN/
            telementry                      # 上传遥测数据
                post {"key1":"value1"}
                post [{"key1":"value1"}]
                post {"ts":1451649600512, "values":{"key1":"value1"}}
            attributes
                post {"attribute1":"value1"}          # 更新属性
                get                         # 请求属性
            attributes/updates
                get ?timeout=20000          # 订阅属性
            rpc
                get ?timeout=20000          # 要求订阅，返回id, method, params
                post {"method": "getTime", "params":{}}     # 执行method
            rpc/{$id}
                post
            claim                           # 用户认领设备
                post
    服务架构
    产品架构
        设备接入: MQTT、CoAP、HTTP
        规则引擎                             # 处理设备消息
            消息(message)
                设备传入数据
                设备生命周期事件
                rest api事件
                rpc请求
            规则节点(node)                   # 过滤消息
                filter
                enrichment
                transformation
                action
                external
                rule chain
            规则链                           # 连接节点
        核心服务
            设备认证: token、X.509
            规则和插件
            多租户(tenant)
                客户
                    资产
                    设备
            部件(widget)仪表盘(dashboard)
                alarm
                实体视图
                    设备即服务(DaaS)
                    共享资产、设备
                    传感器等权限
            告警和事件
        网关: rest api, websocket
        actor模型: 用于并发
        集群: zookeeper服务发现, 一致性哈希
        安全: SSL
        第三方
            akka
            zookeeper
            grpc
            cassandra

        system
            general
            mail
            security
    功能模块
        admin
        tenant
            rule chain
                filter
                enrichment
                transformation
                action
                *analytics
                external
                rule chain
            *data converters
            *integrations
            *roles
            *customers hierarchy
            *user groups
            customers
            *customer groups
            assets
            *asset groups
            devices
            *device groups
            entity views
            *entity view groups
            widgets library
            dashboards
            *dashboard groups
            *scheduler
                report
                send rpc
                update attributes
            *white labeling
                main server
                mail templates
                custom translation
                custom menu
                white labeling
                login white labeling
                self registration
            audit logs
        entities
            包含
                tenants
                customers
                users
                devices
                assets
                alarms
                dashboards
                rule node
                rule chain
            操作
                detail
                assigned to customer
                attributes
                    client
                    server
                    shared
                telemetry
                alarms
                events
                relations
                audit logs
# 博客
## cleaver
    # 基于node幻灯片
## hexo
    介绍
        简单轻量，基于node的静态博客框架
        可以部署在自己node服务器上，也可以部署在github上
    目录结构
        scaffolds                                        # 脚手架
        scripts                                            # 写文件的js, 扩展hexo功能
        source                                            # 存放博客正文内容
                _drafts                                    # 草稿箱
                _posts                                        # 文件箱
        themes                                            # 皮肤
        _config.yml                                        # 全局配置文件
        db.json                                            # 静态常量
    使用
        npm install -g hexo
        hexo version
        hexo init nodejs-hexo
        cd nodejs-hexo && hexo server
        hexo new 新博客                            # 产生 source/_posts/新博客.md
        hexo server                                        # 启动server
        hexo generate                                    # 静态化处理
        github中创建一个项目nodejs-hexo, 在_config.yml中找到deploy部分，设置github项目地址
        hexo deploy
                # 部署以后，分支是gh-pages, 这是github为web项目特别设置的分支
        上github，点settings找到github pages, 找到自己发布的站点
        无法访问静态资源
                设置域名
                        申请域名
                        dnspod 中 绑定ip
## hugo
    简介

        hugo由go编写，开源，特点为编译快
        本文基于hugo0.49

    help
        hugo help
        hugo help server    # server代表任何子命令

     生成站点
        hugo new site blog1 # 站点命令在blog1中执行

     生成文章
        hugo new about.md
        hugo new post/first.md

     主题
        git clone https://github.com/spf13/hyde.git themes/hyde # 更多主题在https://themes.gohugo.io


     本地服务器
        hugo server
            # 自带watch
            -s /path/to/codes
            --theme=hyde
            --buildDrafts
            -p 1315
                # 默认端口1313

     发布
        hugo --theme=hyde --baseUrl="https://outrunJ.github.io"

     文章
        开头
            ---
            用YAML写内容
            --- # +++标记可写TOML

            Description = ""
            Categories = ["a1", "a2"]
            Tags = ["b1","b2"]
            draft = true    # 文章隐藏
            menu = ""
            title = "a" # 文章标题

     配置
        打开config.toml   # 可以是config.yaml、config.json
        baseURL = ""
        title = ""
        theme = ""
        [permalinks]
            post = "/:year/:month/:title/"  # 生成list页面

        [taxonomies]
            category = "categories"
            tag = "tags"

        [params]
            description = ""
            author = ""

        ignoreFiles = []

        [blackfriday]   # 设置markdown库

## jekyll
    介绍
        ruby静态站点生成器，根据网页源码生成静态文档文件
        提供模板、变量、插件等功能
        生成的站点可以直接发布到github上
    使用
        curl http://curl.haxx.se/ca/cacert.pem -o cacert.pem
            # 移动到ruby安装目录
        安装devkit
        gem install jekyll
        git clone https://github.com/plusjade/jekyll-bootstrap.git jekyll
            # 下载jekyll-bootstrap模版
        cd jekyll && jekyll serve
        rake post title = 'Hello'
            # 生成文章
            ## 编辑_posts下面生成的文章
        修改convertible.rb文件编码为utf-8
        jekyll serve
        发布到github
            github上创建新仓库
            git remote set-url origin git@新仓库
            git add .
            git commit -m 'new'
            git push origin master
            git branch gh-pages
                # 新建一个分支，用于发布项目
            git checkout gh-pages
            修改_config.yml
                production_url: http://outrun.github.io
                BASE_PATH: /jekyll-demo
# GIS
    ide
        skylive
        arcGIS
        mapInfo
        mapGIS
        superMap
    webglobe
    arcpy
# AI
    tensorflow
        # 神经网络计算
    convnet.js
        # js深度学习
    scikit-learn
        # python机器学习
# 在线服务
## webIDE
    codebox
# 游戏
    pomelo
        # node.js上网易开源的实时性好的游戏类服务器
# 商城
## ecshop
    # 开源, 商城系统, 微信商城

# 三方服务
## webs
    aws
    阿里云
    青云
    轻云
    digital ocean
    vultr
    Linode
    azure
        # 微软开放平台
    gce
        # google compute engine
    txCloud
        # 云柜，数据存储和计算
    首都在线
## paas
    gae
        # google app engine
    sae
        # sina app engine
    heroku
## dns
    godaddy
    万网
    dnspod
## cdn
    七牛
## pay
    支付宝
    易宝
    财付通
## idc
    # infomation data corporation, 互联网数据中心
## cti
    天润
    云之讯
    容联
## 报表/olap
    palo
## im
    环信
    云片
    jpush
    im
    sms.webchinese.cn
    个推
## safe
    1password
## 设备
    京东叮咚
        # 智能音箱
    萤石
        # 视频设备