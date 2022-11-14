---
Categories : ["架构"]
title: "中台"
date: 2018-10-10T16:49:27+08:00
---
# 业务中台
## 权限
    类型
        ACL(access control list)                        # 访问权限列表
        RBAC(role base access control)                  # 基于角色的访问控制
        ABAC(attribute base access control)             # 基于属性(计算属性)的访问控制
        DAC(discretionary access control)               # 自主访问控制
            主体对所属对象有全部控制权
            主体执行的程序权限相同
            主体权限可分配给其它用户
        MAC(mandatory access control)                   # 强制访问控制
            管理分配权限，主体不能改变
            主体只能访问他的对象，也不能写低级别对象
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

# 数据中台