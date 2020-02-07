---
Categories : ["架构"]
title: "架构-方案"
date: 2018-10-10T16:49:27+08:00
---

# 微服务
    o->
    数据
      租户
      用户
    micro service
      每个service监控
      每个service不单点
      单功能拆分，边界明确
      service间只依赖sdk(好莱坞法则)，通过服务总线发现
      servcie无状态接入
      分类
        内部服务 internal
          # 内外服务用互相转化
          文件上传
          图像处理
          数据挖掘
          报表
        外部服务 external
          # 流控、质量监控、多链路备用、降级方案
          邮件
          短信
          推送
          cti
          企业信息校验
        业务服务 transaction
          审批流
          工作流
          登录
          海
        核心服务 core
          租户id服务
          检索服务
          报表服务
          监控服务
          k8s
          服务总线
        支持服务 supportive
          文档
          测试环境
          沙盒同步
        插件服务 plugin
        集成服务 integration
        事务服务
          finance
          CPQ
          ERP
        saas基础
          计费
          用户管理
        联动
          导入企业数据
          调用aws或aliyun，提供webhook
      服务的sdk
        多语言sdk
        降级
        ha
        apm
      服务监控
        # 用于发现问题、追查事故、评估缩容或扩容、评估降级
        日志
        接口
          # 调用服务提供的监控接口
        系统
          # 容器提供
        apm
          # 客户端采样
        可达性
          # 由通用监控完成
      工程
        打包docker镜像
      服务升级
        灰度发布与AB test
        提供api版本接口供客户端查询
      服务总线
        管理服务状态、位置

    o-> 《一个可供中小团队参考的微服务架构技术栈》
# aPaaS
    # platform as a service，介于IaaS和SaaS中间
    将软件研发的平台做为服务，以SaaS的模式交付
    组件化支撑和驱动
        # 组件的发展决定paas广度，组件的聚合决定paas深度
        # 对内固守组件边界，对外暴露标准接口
    分层
        平台组件
        基础业务    # 不可见，影响全局，通用业务逻辑，对性能很敏感
        业务
    组件
        设计
            # 自描述的，这样就在设计和开发上解耦
            确定边界
            定义标准接口
            确定核心功能
            规范异常处理
        开发
            # 像开发dsl一样,来评判核心逻辑和接口，抽象度高
            技术评审
            定义接口
                # 面向接口开发，也称为BDD
                dubbo、grpc等
                restful
            接口设计
                标准化
                说明
                服务路由
                版本管理
                授权管理
    核心理念
        # 体现在 服务、工具、模型、规范
        开放 而非 封闭
        合作 而非 限制
        共享 而非 替代
    重点关注
        基础业务
            组织架构和用户组
            审批流
            权限
        通用模型
            透明分布式缓存模型
            分布式存储模型
            分布式事务模型
        效率工具
            数据迁移工具
            缓存配置工具
# 常用技术栈
    SaaS
        aws线上云
        微服务 + gRPC + k8s + Istio
        Golang + TypeScript + Python
        TiDB
    轻应用
        node.js + mongodb
        mysql
# 数据
## 数据迁移
    去掉约束
    排序（中断继续）
## 数据存储
    缓存
        queue + map
            # queue存储、限量, map查询，指向queue中元素
## 缓存
    queue + map
        # queue存储、限量, map查询，指向queue中元素
# 大数据
    流程
        采集 -> kafka -> ETL -> kafka -> 存储 -> OLAP
    借鉴
        宜信
    采集
        实时
            trigger、日志
                canel
        准实时
            日志
        非实时
            任务调度
                quartz, xxl-job, 大数据
    处理
        流式框架、ETL
            storm, flink, spark
    存储
        es, HDFS, driud, 业务系统
        hadoop: hbase, hive
    展现
        OLAP
            kylin, superset, Davinci
        DBus-allinone
# 实时并发
## 异步方案
    node.js + mongodb
    tornado + celery + rabbitmq + 优先级
    quartz
## 消息
    功能
        好友
        单聊, 群聊
        语音, 视频
        im      # 浏览器聊天(tcp, 不https)
    协议
        XMPP        # 基于xml
        MQTT        # 简单，但自己实现好友、群组
        SIP         # 复杂
        私有协议     # 工作量大，扩展性差
## go高并发实时消息推送
    问题
        长连接             # 支持多种协议(http、tcp)
            server push
            HTTP long polling(keep-alive)
            基于TCP自定义
            心跳侦测
        高并发             #>= 10,000,000
            C1000K
        多种发送方式
            单播: 点对点聊天
            多播: 定点推送
            广播: 全网推送
        持久/非持久
        准实时         # 200ms ~ 2s
            gc卡顿是大问题
        客户端多样性
        同帐号多端接入
        网络变化
            电信、联通切换
            wifi, 4g, 3g
            断线、重连、断线、重连
    系统架构
        组件
            room
                # 接入客户端
                分布式全对称
                一个client一个goroutine
                每个server一个channel存消息队列
                book记录user与server映射
                统一http server收消息并将消息路由到room和server
                manager掌控room的服务：内部单播、多播、广播
                admin负责room进程管理
            center
                # 运营人员从后台接入
                提供操纵接口给应用服务器调用
                restful
                长时操作，有任务概念来管理
                提供统计接口
            register
                # room和center注册
                key-value的map，value是struct
                记录用户连到哪个room
                记录在线时长等信息
                hash算法定位register进程
                不直接用redis是为了添加业务逻辑
            saver
                # room和center调用
                # 使用redis
                分布式全对称
                提供存储接口
                采用encoding/gob编码格式的rpc
            idgenerator
                # saver和center调用
                全局消息id生成器, int64
                分布式，每个进程负责一块id区域
                后台goroutine每隔一秒写一次磁盘，记录当前id
                启动时跳过一段id，防止一秒内未写入磁盘的id重复生成
        存储
            redis
                存核心数据
                db_users: zset, 存各产品用户集合
                db_slots: list, 存用户离线消息队列
                db_buckets: dict, 存消息id -> 消息体
    数据
        16机器，标配24硬件线程, 64g内存
        linux kernel 2.6.32 x86_64
        单机80万并发连接
            load 0.2 ~ 0.4 cpu
            总使用率7%~10%
            内存占用20g
        目前接入1280万在线用户
        2分钟一次gc, 停顿2秒，tip上提供了并行gc
        15亿个心跳包/天
        持续运行一个月无异常
## 直播
    《关于直播，所有的技术细节都在这里了》
## 游戏
    进程
        gateway进程组
            # 对外api
        function进程组
            # 注册玩家全局信息
        session进程组
            # 玩家状态
        dbserver进程组
            # 数据
        多word进程组
            # 不同地图的信息、逻辑
# 功能实现
## 重复提交
    直接redirect
    csrf令牌
## 权限
    过滤器 页面权限
    拦截器aop 数据权限
## seo
    静态化
## web状态
    cookie
    url中sessionId
## 加密
    base64
    sha
# 业务
## 关注/信箱
    要求
        user人数10w, 活跃1w。
        大部分user关注1k人, 一部分大v被关注100w人。
        每人每天发100条博文
        user新博文数量提醒，消息标记已读
    表
        user
        user_followers
        user_followed
        user_posts(u_id, created_ts)
        user_messages(u_id, p_id, is_read)
            # 10w * 100条数据 / 天
    定时任务拉取
        user_followed拉u_id, user_posts表按时段拉id, 更新user_messages
        优点
            平均, 少次, 增量。
        缺点
            及时性中
            每次对所有用户操作
        数据
            10w*1k*100条数据 / 天
    发布时推送
        有p_id, user_followers, 更新user_messages
        优点
            及时性高
        缺点
            计算集中, 可能高峰
        数据
            最高 100w*100条数据 / 次
            10w*100次 / 天
    messages处理
        存部分messages
            不活跃user不存message
                在登录状态，定时拉取
                    优点
                        减少message
                    缺点
                        计算集中
                    数据
                        1k * N(N<100)条 / 次
                        1w * 1k * 100条数据 / 天
        messages结构变化
            u_id: [{p_id: uint, is_read: bool}]         #  条数稳定为10w
            用mongodb或redis
    消息队列?
        服务端存message状态，不能mq
        如果客户端存状态，这就是个简单的mq问题
## 权限
    类型
        ACL(access control list)                        # 权限存成列表
        RBAC(role base access control)                  # 角色对应权限
        ABAC(attribute base access control)             # 计算属性匹配权限
    成员
        user
        role
        group
    访问权限
        权限1: 游客，用户，rememberMe
        权限2: uri前缀(功能模块)
        权限3: uri后缀(静态资源过滤)
        判断位置: 过滤器中
    资源权限
        权限: kind:part1:part2...
        判断位置: 渲染数据前
    数据权限
        资源层级
            权限: 2
            判断位置: 进方法前
        单表
            权限: 表名:列名:值
            判断位置: 写sql前
    方法权限
        权限: 方法域:方法名
        判断位置: 进方法前
    性能
        grantTable缓存u_id, res_id关系
## 审批
    模板
        准入规则
        起始、终止节点
        节点, 节点成员, 替换成员, 节点事件(脚本), 跳转公式
    审批流程
        创建, 状态查询
        审批
## 海
    type                    # 记录类型
        property            # 类型动作, 关联到节点, 记录进出节点的动作。如对成员可读、可写, 记录负责人，对记录执行脚本, 记录回收计划
    model                   # 模式
        节点树、一个激活
    节点
        节点组
        两节点方向
    成员
        节点成员1对多
        成员分组(group, role)也是成员
    记录
        节点记录1对1
    流转                     # 记录按规则在节点流转, 指定某些节点, 或某些记录。动作流程短路
        motion               # 一次动作，如新建，移动，删除。
        规则                 # 该次动作对记录的验证
        fomula               # 计算motion次序
        历史                  # 动作历史
    权限
        kind                 # pass或 type、model、property、节点、节点from, 节点to 的任意组合
        access              # 分不同kind划分具体权限, 如(节点from, 节点to)kind的转移权限
        pass权限             # 如创建type, 创建model, 某节点所有权限等
    计划                     # 定时或周期的流转
## 适配器boss
    action                  # 存http地址，参数名，验证器
        code                # 业务，如用户套餐
        mode: get/post/put/delete               # 如获得套餐，添加套餐，修改套餐，删除套餐
        ctx                 # 参数map, action调用前后修改
        next                # 下个触发action
    history_action          # action调用历史
    suite                   # 带参action, thunk待触发
        price               # 标价
        tag                 # 用作商品分类
    order                   # 用户关联到suite, 计费
    category                # 生成action模板
        apps/plugins        # 由category生成, 多个带形参(如app_id)action, 封装成的模板。添加实例填入实参
    role
    permission              # action code
        type                # action, suite等
        access              # crud和其它自定义权限
## 工作流
    本质
        状态管理
        工作流重流程轻数据，业务重数据轻流程。工作流修改数据，数据触发工作流
    标准
        BPMN                            # omg制定
        workflow
        XPDL                            # WfMC制定, xml, 复杂
    思路
        # 模型驱动架构(MDA)
        petri nets
        有限状态机(FSM)                  # 并行(流水线)状态机
        活动图                          # JBoss使用
        事件过程驱动链(EPC)
        微内核                          # 安全性高, 降耦合
    已有实现
        开源
            yawl, jbpm, activiti, osworkflow, jboss, shark, obe
        商业
            aws, salesforce, sap等
    分层
        外设层                          # 交互协议
        网关(WAPI)
        交互代理                         # 网关与内核通信形式
        引擎                            # engine
            specification, case
            net
                netRunner
                    continueIfPossible  # 遍历task, fire task,
            condition
            task
                join, split             # and所有, xor只一个, or规则
                workitem
            flow
            persisting
            gateway
        引擎运行服务                      # 为引擎提供服务, 如解析流程定义、流程实例存储、参与者(workItem)解析、脚本计算、事件监听等
        扩展实现
            支撑
                组织模型适配
                    人工task实现人工接口
                流程实例存储
                    执行器中嵌入
                其它应用适配              # 如邮件
                    内核获取环境资源
                    执行器定义扩展
                    应用适配扩展接口
                操作流程定义
                任务分配
            辅助
                条件验证                 # 可以有外部验证器
                    分支时判断
                事件处理/function处理
                抽象的客户操作            # 如退回、跳转等
            增强
                自定义策略(workItem), 如代理人处理、工作日历(任务期限)
                    工作项分配、执行、提交
                事件监听
                超时处理
                    订阅应用事件, 应用时间触发器
        基础组件
# 企业
## erp
    # enterprise resource planning, 企业资源计划
    元数据驱动去抽象和设计
## mes
    # manufacturing execution system, 制造生产过程执行系统
## wms
    # warehouse management system, 仓库管理系统
## oms
    # 订单管理系统
## tms
    # 物流管理系统
## cmp
    # campaign management platform, 营销活动管理平台
# 前端模板渲染
    layout
        layout service
            # 缓存layout到redis
            crud layout功能
        layout对象
            index
                # 缩略信息
            plugins
                components
                    table
                layout
                    # 组合方式
                    水平，垂直，tab
# 工业互联网(IoT)
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
# 优秀项目借鉴
    thingsBoard
    confluence, jira
# 运维
    标准
        ITIL(IT Infrastructure Library)
        ITSM(IT System Management)
    资产管理
    运维
        规章
        容器
            vspere, openstack
        服务
            硬件: 巡检
            软件
        交换机
            ng, lvs
        展现
            zabbix
    DevOps