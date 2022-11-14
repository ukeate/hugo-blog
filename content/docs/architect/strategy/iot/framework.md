
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