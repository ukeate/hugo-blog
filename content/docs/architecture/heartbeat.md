---
Categories : ["架构"]
title: "Heartbeat"
date: 2018-10-11T15:32:51+08:00
---

# 2.0模块
        heartbeat: 节点间通信检测模块
        ha-logd: 集群事件日志服务
        CCM(Consensus CLuster Membership): 集群成员一致性管理模块
        LRM(Local Resource Manager): 本地资源管理模块
        Stonith Daemon: 使出现问题的节点从集群资源中脱离
        CRM(Cluster Resource management): 集群资源管理模块
        Cluster policy engine: 集群策略引擎
                用于实现节点与资源之间的管理与依赖关系
        Cluster transition  engine: 集群转移引擎

# 3.0拆分之后的组成部分
        Heartbeat: 负责节点之间的通信
        Cluster Glue: 中间层，关联Heartbeat 与 Pacemaker,包含LRM 与 stonith
        Resource Agent: 控制服务启停，监控服务状态脚本集合，被LRM调用
        Pacemaker: 也就是曾经的CRM，包含了更多的功能
                管理接口:
                        crm shell 
                        一个使用ajax web 的web窗口
                        hb_gui图形工具
                        DRBD-MC, 一个基于java的工具

# 版本差异
        与1.x相比，2.1.x版本变化
                保留原来所有功能
                自动监控资源
                对各资源组进行独立监控
                同时监控系统负载
                        自动切换到负载低的node上
        
