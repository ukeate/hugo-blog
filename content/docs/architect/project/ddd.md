---
Categories : ["设计"]
title: "工程"
date: 2018-10-10T17:39:31+08:00
---

# 介绍
    介绍
		Domain-driven Design
        针对传统软件开发流程（分析-设计-编码）各阶段业务割裂问题，一开始定义好领域
    目标
        维护概念完整性(纯洁)，避免语义泄露和腐化
# 概念
    领域（Domain）
    界限上下文（Bounded Context）
    领域模型（Domain Model）
    领域通用语言
    分层架构
        展示层、应用层、领域层、基础设施层
    最佳实践
        关联尽量少、尽量单项、尽量降低整体复杂度
        实体（Entity）
            领域中的唯一标识，属性尽量少
        值对象（Value Object）
            没有唯一标识，属性值不变
        领域服务（Domain Service）
            协调多个领域对象，只有方法没有状态
            应用层服务、领域层服务、基础层服务
        聚合、聚合根（Aggregate, Aggregate Root）
            聚合定义了一组有内聚关系的对象集合，聚合根是对聚合引用的唯一元素
            修改聚合必须在事务级别
            70%的聚合只有一个实体, 30%有2到3个实体。
            只有一个实体时，实体就是聚合根。多实体时思考哪个对象有独立存在的意义，且可与外部直接交互
        工厂（Factory）
            工厂模式
        仓储（Repository）
            持久化到DB，管理对象
            只对聚合设计仓储

# 建模
## 原则
	简单、容易、清晰
	使用不动点
	领域专注
	聚合内强一致，跨聚合最终一致
	内部概念完整一致(unification)
		术语不变、不矛盾、不重叠
## 数据模型（DO）
	失血
		DO和DAO无业务逻辑，纯数据
	贫血
		持久化逻辑在DAO中
	充血
		service很薄，持久化的逻辑在DO中，无DAO或与DO双向依赖
	肿胀
		无service，全部逻辑放DO
## 分析设计
### 分析模型
	# 业务领域分析, 不考虑代码
	问题
		含意不完整，不可图形或文字表达，错误假设
		会深入某细节
		忽略某细节直到设计或实现, 如持久化、性能
	目标
		领域模型
		架构设计
	事件风暴                    # 是开发建模，不是用户需求故事
		准备
			功能确认: 近期milestone
			找正确的人: 领域专家, 前后端，架构师
			引导者: 准备资料, 排程, 时间, 2/3时间预警
		事件风暴
			领域事件: 用户可感知状态
			分支小组 -> 个人发散 -> 小组一致 -> 整体一致        # 不能一致表示准备不足
			逻辑顺序 -> 最终流程
		命令风暴                # 为什么, 分色
			事件触发原因、方式
			用户角色
			读模型: 用户前置需求
			写模型: 动词
			描述
		聚合
			取名, 分职责
		持续探索
	领域模型一开始就结合编码设计    # 设计围绕模型, 模型受设计反馈改善
		开发时意识到模型变更, 会保持完整性
		每个开发在修改前需要了解模型
		面向对象更易于建模, 过程化易于流程，如数学
### 重构
	要求
		设计灵活
		使用经过验证的构造
	目标
		领域理解更深、更清晰
			深刻(incisive)、深层(deep)的模型
		技术的动机的代码转换
	实现
		小幅可控
		基于测试
		突破
			新的概念或抽象
			隐含的概念被凸显
				倾听领域语言
				过分复杂是因为关键点被替代
				领域文献        # 深层视图
				约束            # 表达不变量
				过程(process)   # 面向对象中的面向过程, 多个过程时用策略
				规约            # 测试对象返回布尔值, 重构成对象而非写在application
## 战略建模                            
	# 形成上下文映射图
	问题空间
		领域                                            # 与公司组织关联
			子域                                        # 最好对应一个限界上下文
				核心域(core domain)                     # 项目动机, 公司核心竞争力, 尽量小, 最高优先级
				通用子域(generic subdomain)             # 作用于整个系统的支撑子域
				支撑子域                                # 重要非核心
		集成
			合作关系(partnership)                       # 同时成功失败
			共享内核(shared kernel)                     # 小型内核, 持续集成功能
			客户/供应(customer-supplier development)    # 上下游
			遵从(conformist)                            # 下游遵从上游
			防腐层(anticorruption layer)                # 翻译转换领域服务
			开放主机服务(open host service)             # 公开协议，子系统访问
			发布语言(published language)                # dsl, 通常与开放主机服务一起
			分隔(separate way)                          # 声明无关联
			大泥球(big ball of mud)                     # 已有纠缠的系统，隔离出来
	解决方案空间
		通用语言
			一个限界上下文一个通用语言
			清晰(概念无二义性), 简洁                    # 如卖家和买家都叫用户，就是不清晰。如用type标记用户是卖家或买家，就是不简洁。所以直接用两个对象
		限界上下文                  # 条件的集合
			目的
				确保术语含义明确
				切分规模, 易于保持领域纯洁
				设定进化框架而非模块，包含模块
			考虑因素
				团队组织结构
				应用特定部分惯例、物理表现
			挑战
				团队开发碎片化      # 写重复的代码，由于不知道或怕改错
				持续集成
					早合并
					自动构建测试    # 检测不一致
			模块
				作用
					降低模型规模复杂度
					代码高内聚低耦合
				设计
					通信性内聚(communicational cohesion)
					功能性内聚(functional cohesion)
					每模块统一接口
					名称反映深层理解
					灵活性，进化性
		上下文映射                  # 领域间集成关系
			模式
				共享内核(shared kernel)                 # 为减少重复, 共享领域子集，多方测试
				客户-供应商(customer-supplier)          # 做反馈的需求, 需求测试, 自动化验收
				顺从者                                  # 供应商不做需求, 客户用适配器对接组件
				防腐层(anticorruption layer)            # 双向领域模型转换器, 保持内部模型纯洁
					从前
						原始数据(api, db)无模型无语义的处理
					实现
						对外多门面(facade)
						每个门面一个适配器(adapter)
						适配器间用转换器(translator)
				隔离通道(separate way)
				开放主机服务(open host service)         # 实现开放服务协议
				提炼                                    # 多次重构后还很大
					实现
						分离基本概念和普通概念, 提炼核心域和子域
						子域
							使用第三方服务
							外包
							修改已有模型
		六边形架构
			领域模型简洁自治
			对外适配器防腐, 保护限界上下文              # 如面向接口
				消息, 内存, 数据库
				soap, rest
		CQRS(command query responsibility segregationg)             # 修改只记事件(日志), 查询时计算
			查询方式
				单数据库/读写分离，查询时计算事件
				读写分离, 读库异步计算事件保存冗余, 读库负载均衡
## 战术建模                            
	# 组成限界上下文
	领域
		实体(entity)                # 标识和延续性, 有id, 持续变化。
		值对象(value object)        # 无id, 只有属性, 最好不可变(可共享)。尽量建模值对象。可包含实体引用或值对象。
		生命周期
			聚合(aggregate)         # 定义对象所有权和边界
				简化
					关联            # 可导航到的关联
						1对1        # 对象引用
						1对n        # 包含集合
						n对n        # 删除关联，关系加约束或转换 
				目的
					一致性
					强化不变量
				实现
					聚合根(root)    # 聚合根间是最终一致性
						是个实体,有id
						外部访问的唯一对象
						向外传递副本
			工厂(factory)           # 在领域中没有定义, 但程序需要
				目的
					并非对象创建对象
					对象创建存在自有知识
					创建过程原子性
					对已有持久化对象重建并修复
				问题
					外部访问根内对象，需关联不必要的根实体
				实现
					不用工厂
						构造不复杂
						不涉及其它对象
						客户希望用策略创建
						类是具体类型, 无层级
					聚合根提供方法
					单独工厂        # 违反了封装原则, 但保持了简单
			资源库(repository)      # 内存假象
				目的
					不关联根获取对象引用
					不暴露细节, 会减少领域专注
						防止代码扩散
						减少变更修改
						维护聚合封装性
						容易的基础设施被滥用, 产生除聚合根外导航
				实现
					封装所有获取对象逻辑
					基础设施, 全局可访问
					不同对象不同策略访问、存储      # 领域与基础设施解耦
					接口是领域模型, 实现像基础设施
					参数筛选或规约(specification)筛选(筛选器)
	entity
		介绍
			entity即状态
			应用开发即处理entity的表现
		主从
			主存储(可变)                    # 关键是选择主存储
				多派生一致性好保障
				派生表达业务的难易成度
			只读派生(representation, 不可变)
				多份存储, 一致性
				派生, 合并, 转化
		类型
			东西(可变)                      # 单据叠加成东西, 东西叠加成东西
			单据(可变)                      # 事件叠加成单据
			事件(event, 不可变)
			命令(command, 不可变)
			视图(view model, 不可变)
			子集(subset, 不可变)
			视图(aggregation, 不可变)
			表单(可变)                      # 是主存储
		物理介质
			OLTP(mysql)                     # 点查询
			OLAP(clickHouse)                # 范围查询
			queue(kafka)                    # 顺序读, 低延迟
			业务服务                        # 业务逻辑, 像虚拟的表
		分组entity主存储(BC, bounded context)
			目的
				分解
					管理复杂度
						系统
						组织部门
					实现内部一致性
						概念, 数据
				对主存储进行受控的修改
			边界entity                          # 用于集成，不一定是主存储
				形式
					授权、binlog、工作流、视图数据、租户作为其它租户user
					东西、单据、event
				介质
					queue, 带权限db, rpc虚拟表
				触发
					queue, ui, api
					触发由worker托管, 输入是queue或rpc socket
			粒度
				分entity
				分步骤
				分entity字段
				原则
					BC尽可能少而大
			关系
				时间错开
					外键关系                    # BC挂载到BC, 如后台系统与计费系统的定价, 运营人员与服务系统的配置, 流程节点系统对流程的依赖
						rpc, 数据库, 数据复制
					报表关系
						时效性高
						一般做复制              # 所以边界entity是数据变更event
					触发关系                    # fire and forget
					交棒关系
						下游给上游command/event, 上游触发
						上游实现降级            # 下游不可用时，安慰语
				时间同时
					accountable/responsible关系                 # 负责人与实现人
						原则
							accountable尽量小
								只调度
									与responsible的边界entity是rpc虚拟表, 请求command, 返回event
								补偿实现一致                    # 如超卖
								responsible提供自己界面         # accountable不控制
					抢资源关系
						锁服务
	服务(service)                   # 无法划分对象的动作, 无状态。按功能分组, 多对象的连接点
		可在application, domain, infrastructure
# 最终一致性建模
## In-Memory
	聚合根在内存，同步最新状态
## 事件溯源（Event Sourcing）
		没有CRUD，只有Append Event。数据不可变
		对象最新状态通过事件溯源获得
## Actor
	通过Mailbox取代调用，保证消息线性处理
## EDA(Event-driven Architecture)
	节点只处理逻辑，节点间Event通信
	是最终一致性的架构
## CQRS
	介绍
		Command Query Responsibility Seperation
		CQ接口分离、代码分离，分别设计
	概念
# 项目结构
    用户接口(user interface)
    应用(application)                   # 尽可能小。数据验证，事务。故事, 表达出操作的事情
        application service
        unit work
        presentation model
    领域(domain)                        # 专注领域。准确定义业务对象
        aggregate, entity, value object
        domain service, domain event
    基础设施(infrastructure)            # 辅助层
        repository
        global support
    项目文件
        [ui]
            mall                            # 商城api
        [saleDomain]
            [application]
                mall.application            # 分模块，讲述故事
                    CartService
                        GetCart()
                    BuyService
                        Buy()
                mall.application.domainEventSubscribers         # 订阅domain事件
            [domain]
                mall.domain                 # 不大而全，要求刚好满足需求
                    cartModule
                        entity
                            CartItem
                        aggregate
                            Cart
                    valueObject
                        Product
                        SellingPriceCart
                    IDomainServices
                    IRemoteServices         # 访问远程资源接口
                        IUserService
                        ISellingPriceService
                    IRepositories           # 仓储接口
                        ICartRepository
                mall.domain.events          # 领域事件, 用于实现最终一致性
                mall.domainService          # 操作domain的无状态方法
                    ConfirmUserCartExistedDomainService
        [sellingPriceDomain]                # 与saleDomain合作关系, sale请求sellingPrice定价
            [appication]
                mall.application.SellingPrice
                    dto
                        CalculatedCartDTO
                    mapper
                        ValueObjectToDTO
            [domain]
        [infrastructure]
            mall.infrastructure             # 通用类库
                domainCore                  # mail.domain base方法
                    AggregateRoot
                        Cart
                    Entity
                        CartItem
                    ValueObject
                        Product
                    IUnitOfWork             # 仓储事务
                domainEventCore
                    DomainEvent
                    DomainEventBus
                    DomainEventSubscriber
                    IDomainEvent
                    IDomainEventSubscriber
            mall.infrastructure.repositories                # 仓储
                CartSqlServerRepository
            mall.infrastructure.translators                 # 防腐层, 访问远程资源实现
                user
                    UserAdapter             # 请求原始结果
                    UserService
                    UserTranslator          # 转换原始结果
	模块结构
		api: controller
		biz: 特异业务
			manager
			converter
		core: 公用业务
			model
				entity
				bo
			service
				repository
		common
			dal
				dataobject
					do
				dao
				mapper
			service
				facade
					dto: facade和controller用
					service: 服务间api
					validate
				integration
					service
			shared
				dto: 项目内部公用
