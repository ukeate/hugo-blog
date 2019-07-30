---
Categories : ["架构"]
title: "构架-方案"
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
# 业务
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

## 工作流
    本质
        状态管理
        工作流重流程轻数据，业务重数据轻流程。工作流修改数据，数据触发工作流
    分层
        engine                          # engine
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
        adapter                         # services
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
