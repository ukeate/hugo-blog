---
Categories : ["架构"]
title: "架构-治理"
date: 2018-10-10T17:10:32+08:00
---


# 功能
        服务
                注册
                发现
        性能/ha
                区域感知load balance
                故障切换
                故障注入
                熔断
                健康检查
                流量拆分和推出
        策略        
                quota
                        网络数据
                        api调用
                服务准入条件
                路由规则
                容错
                访问策略
        安全
                服务间认证(auth)
                tls
                细粒度权限控制
        配置
                啮合层
                        # 服务与网络间加入透明层，用来功能配置
        查看
                服务网可视化
                monitor
                log
                tracing
        迭代
                部署
                版本控制
        平台支持
                # 如aws, k8s, mesos
        通讯能力
                # http/1.1 http/2 grpc tcp

rmi
        # java远程调用功能
        hessian

# soa
    eai
            # Enterprise Application Integration 建立底层结构将异构应用集成
    esb
            # Enterprise Service Bus 企业服务总线， 是连接中枢
# rpc
    hsf
            # 高速服务框架 (socket直连)
    protobuf
    thrift
    Dubbo
    spring cloud
# paas
    cloudStack
            # 托管在apache的开源、高可用、高扩展性的云计算平台
            # 支持主流hypervisors
            # 一个开源云计算解决方案，可以加速iaaS的部署、管理、配置
    kubernetes
            # google开源的，在docker技术上，为容器化应用提供:
            作用
                    资源调度
                    部署运行
                    服务发现
                    扩容缩容
    cloudfoundry
            # 根据应用模板，动态生成很多tomcat, mysql, nosql, 动态控制这些实例的启停。
    openstack
            # 云操作系统，管理虚拟资源
    hsf
            # high-speed service framework
            特点
                    不增加中间点(稳定，高度可伸缩)
            结构
                    注册服务信息，推送服务地址
                    基于osgi
# mesh
    lstio
            #google IBM, lyft开源，基于envoy
            组成
                    数据面板
                    控制面板 
    linkerd
            # buoyant出品
    fingle
            # twitter出品
    envoy
            # lyft出品
    nginmesh
            # nginx推出
# 粘合层
    zookeeper
            # 服务发现
            exhibitor
                    # supervisor for zk
    gearman
            # 把工作委派给其他机器
    etcd
            # k8s中用到的服务发现仓库
    mesos
            # apache开源的分布式资源管理框架
# monitor
    spy.js
            # webstorm用的监控工具
    alinode
            # 朴灵写的运行时性能管理工具
    oneapm
            # 监控node性能
        功能
                    接口响应时间
                    数据库方法时间
                    外部服务时间
                    单请求的耗时比  
    nscale
            # 可扩展容器，用node.js和docker实现
# tracing
    zipkin
    opentracing
# 日志
    elk
            # elasticsearch, logstash, kibana
    log.io