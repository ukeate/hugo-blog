---
Categories : ["架构"]
title: "IoT"
date: 2018-10-10T16:49:27+08:00
---

# 框架
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
# 业务
    目的
        解决可读性可操作性
    模块
        展示
            dashboard
                在线设备
                消息量
                规则引擎消息流转次数
            运维大盘
                产品品类
                地区排名
                指标趋势
                设备在线率
                设备排行
                    事件数
                    事件类型
                    停用时长
                    延迟
        开发服务
            studio
                开发
                    web
                    移动
                    自动化服务
                设备
                    产品                        # 软硬分离的桥梁
                        设备开发 -> 设备模拟(在线写c, js) -> 软件开发
                配置(使用移动端)
                运营运维
                    后台
                    监控
                插件开发
                服务编排
            行业服务
                智能生活
            os                                  # 高性能、极简开发、云端一体、丰富组件、安全防护
                项目生成
                    领域模板
                    插件选择
        网络
            网关
            凭证
            无线
                车联网、智能家居、穿戴、媒体内容分发、环境监测、智慧农业
        设备
            节点
                接入
                    多协议: MQTT、CoAP、HTTP
                    多平台(设备端代码): c、node.js、java
                    多网络: 2/3/4G、NB-IoT、LoRa
                    多地域
                通信
                    双向通信
                        稳定
                        安全
                    影子缓存                            # 设备与应用解耦, 网络不稳定时增加可靠性
                安全
                    认证(一机一密)
                    传输: TLS
                    权限: 设备权限
                规则引擎
                    数据流转
                        M2M(machine to machine)            # 设备间通信
                        数据结构化存储
                        数据计算: 函数计算、流式计算、大规模计算
                        数据mq转发
                    联动触发
                管理
                    生命周期: 注册、分组、拓扑、标签、状态、数据采集、禁用删除
                    模型
                        数据标准化: 属性、事件、服务
                        存储结构化
                    远程
                        设备调试
                            实物
                            模拟
                        维护
                            指令
                            固件升级
                            下发配置
                        监控
                            日志
                            实时数据
                        通知
            分组
        数据分析
            流计算实时分析
            可视化
                三维设备关联
                二维(地图)分布, 实况， 搜索
            数据源适配
        边缘计算                                        # 就近计算, 实时, 离线运行, 快速编程, 降低成本
            功能
                视频设备sdk
                    边缘算法容器(接入方案)
                视频智能
                    视频算法容器
            驱动
                websocket、modbus、lightSensor、light、opcua,
        合作
# ThingsBoard
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