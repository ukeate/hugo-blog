---
title: 项目规划
Categories: ["规划"]
date: 2018-10-10T14:51:24+08:00
type: docs
---

# 平台服务
## aPaaS
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
## SaaS
    aws线上云
    微服务 + gRPC + k8s + Istio
    Golang + TypeScript + Python
    TiDB


# 行为分析
## 埋点
    架构
        数据采集
            客户端采集
            服务器采集
            业务系统
            第三方渠道
        数据治理
            ETL
            实时ID mapping
            元数据管理
            数据质量管理: 数据校验, 实时导入监控，异常报警，debug数据查询，用户关联校验，数据质量看板
        数据仓库
            数据模型：Event, User, Item内容
            实时导入系统
            存储引擎、查询引擎
        数据智能
            特征工程
            特征选择
            模型训练: 深度学习, 自然语言处理，时序预测，GBDT/LR, AutoML
            模型可视化
            在线服务
    工具
        采集: SDK(JS, Android, iOS, 小程序，服务端，全埋点), ID Mapping, 归因链路
        实施工具: 事件管理，变量管理，命名工具，埋点SLA配置, 预警配置，session管理，生命周期管理，tag管理，测试工具，ABTest工具
        分析工具: 事件分析，漏斗分析，分布分析，留存分析，数据看板，热图分析，归因分析，自定义SQL查询, API管理，广告和活动效果监测
    实现方式
        代码埋点
        全埋点、可视化全埋点（圈选）
    规范
        结构与命名清晰
        方便历史版本对比
        每个埋点数据质量负责到人（开发、测试、数据负责人）
        数据统一管理
        尽量用工具自动化


# 企业中台
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

# 本地生活
[服务与功能](https://github.com/ukeate/logseq/blob/main/jncloud/pages/%E5%AE%9E%E4%BD%93%E8%A7%86%E5%9B%BE.md)