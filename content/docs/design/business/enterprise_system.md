---
title: 企业级系统
Categories: ["业务"]
date: 2018-10-10T14:51:24+08:00
type: docs
---

# ERP
    # Enterprise Resources Planning, 企业资源计划
## CMS
    # Content Management System
    grav
        # 开源cms
### wordpress
    # php
### dedecms
    # 织梦cms, SEO优化
### 帝国cms
    # SEO优化
### phpcms
### phpwind
    # 开源, 社区管理系统
### drupal
    # 开源, cms
## 工作流
    activiti
        # 5,6已暂停维护，7叫作Activiti Cloud BPM
    flowable
        # activiti继任
    YAML
        # 工作流
    bossa
        # 工作流引擎
    azkaban
        # 开源oa
### JBPM
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
## 规则引擎(BRMS)
    概念
        组成
            知识库(Knowledge base)
            既定事实(Fact base)
            推理机(Rule Engine)

    Drools
        # JBoss开发, 基于RETE算法
    OpenRules
    OpenLexicon
# MES
    # Manufacturing Execution System
# ITSM
    # IT service management
    sap
    salesforce
    servicenow
    workday
        # hr平台
# GIS
    ide
        skylive
        arcGIS
        mapInfo
        mapGIS
        superMap
    webglobe
    arcpy
# MES
    # manufacturing execution system, 制造生产过程执行系统
# WMS
    # warehouse management system, 仓库管理系统
# OMS
    # 订单管理系统
# TMS
    # 物流管理系统
# CMP
    # campaign management platform, 营销活动管理平台
# 商城
    nopCommerce
        # .net开源电商
    ecshop
        # 开源, 商城系统, 微信商城
# HRP
    # Hospital Resource Planning, 医院资源规划