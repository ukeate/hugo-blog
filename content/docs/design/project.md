---
Categories : ["设计"]
title: "工程"
date: 2018-10-10T17:39:31+08:00
---
# 产品
    愿景
        定义产品的目的和原因，将到达的地点
    ux
        微交互                  # 细节决定成败
## RoadMap
    介绍
        到达愿景的策略路径，提供一系列与产品战略相一致的战术步骤
    为什么
        简单、清晰的通讯文档
            少的多的会议
            健康的团队辩论：交付成果与目标联系起来
            做出每个人都理解的产品决定，不再打击创意
        高维度的概述
        动态演变
    要素
        时间周期
            时间区间，只定时间范围
                big-view(product)
                    全局理解产品的未来,  交付顺序
                    统一视野(vision), 范围(scope)，时间期限(time line)
                pre-view(release)
                    release中的产品功能, 和前几个迭代从backlog中要交付的工作项(item)
                now-view(iteration)
                    团队在一次迭代中要交付的需求(requirements)
            优先级，留空间适应变化
        项目事件
            完成产品总体计划必要的工作项, 详尽且切合目的
            分解目的，制定步骤
        路标
            关键工作项完成的时间节点(里程碑)
            结果反馈：审视是否偏离，试验中改进
            确定在每个时间范围内实现可衡量的结果。定义为目标关键结果(OKR)、关键性能指标(KPI)
    种类
        基于目标
            current
            near term
            future
        基于功能
            5000新用户
    步骤
        确定目标
        分解目标，穷尽事项，组织，优先级排序
        使用优化框架
            effort / impact
            impact / goal
            卡洛斯模型?
    注意
        定义战略主题(名词)，抓住核心用户行为的本质、产品能力、竞争优势、技术改进
        保持路线图战略，避免战术
        每个计划阶段都考虑优先级, 每个目标、动作、发布、特性的价值可见性
        始终在试验(ABE), 为了正确定义目标和后续特征
            先做出有根据的猜测
            测试
            基于反馈迭代

# 业务
    目标
        降低人才素质需求
        减少开发时间
    分类
        创造虚拟空间
        自动化
        辅助决策
    思路
        逻辑: 因果(演绎), 时间, 空间, 优先
        方法: 5w2h(who, when, where, why, what, how, how much)
        建模:
            中心                                # 调整抽象领域和层次(视问题决定)
                自上而下                        # 问题明确，展开
                自下而上                        # 内容分类、剪枝、归纳
            分解
                MECE(mutually exclusive collectively exhaustive)
                    正交
                    穷尽
        经验
            优秀的产品都有全局把控感(confluence, jira)
            设计思想多源自: 操作系统、编译器、函数式
            深入一线(面对客户)
            思考全面, 全局
            考虑需求本质，考虑上下游全局
            想清楚再行动
    过程
        发掘(discovery)
            价值定位(价值驱动)
            客户体验梳理和设计
            愿景
            干系人
            电梯演讲收敛
        定义(define)
            用户旅程，业务流程
            事件风暴 -> 映射技术 -> 架构
        设计(design)
            总体
                识别问题域, 归纳服务, 上下游关系
                架构图, api, 技术栈
                提升方向, 改进
            迭代
                价值/成本分布图
                milestone演进
                业务技术/需求拆解全景图(白板贴标)
                mvp(minimum viable product最小可行计划)迭代计划
        开发(develop)
            度量, 质量指标
            工具选择, 规范
            架构守护，治理
        实施策略
        交付
        产品生命周期管理
            目标, 资本
            机会点->需求
    角度决定设计
        找到不动点
        如对cache的设计
            业务角度
                选择简单易用的缓存框架
                有人会用，学习成本别太高
                关注数据模型结构设计
                缓存更新真麻烦
            paas角度
                声明式使用，配置文件设置
                缓存对比，选择强大且稳定的
                存取接口设计，方便易用
                数据变动监听，自动刷新缓存
            平台角度
                缓存服务器集群方式
                存储空间监控
                命中率监控
                避免缓存集中失效引起雪崩
    不过度设计      # 不超出需求，不用复杂方式实现
                    # 少就是多，应一减再减。简单才能强大，也会提高性能和扩展性
        范围减少    # 28原则，最小可行产品
        设计减少    # 易理解，低成本，可扩展
        实施减少    # 找开源->找内部已实现->找方案描述->自己解决
        二八定律
    墨菲定律
        事情不是表面看起来那么简单
        事情都会比预计时间长
        可能出错总会出错
        如果你担心发生，它更可能发生
    维护
        设计时考虑扩展性
            DID(design, implement, deploy)(设计20倍, 实现3-20倍, 部署1.5-3倍)
        设计能够监控的应用
        版本升降      # 代码仓库
    业务
        防重          # 重复提交，重复扣减，重复支付(异构系统无法防重，用退款处理)
            防重key, 防重表
        幂等          # 消息处理，第三方支付回调
        流程要抽象     # 如工作流
        状态与状态机
            订单系统
                # 状态多时用状态机驱动
                正向状态(待付款、待发货、已发货、完成)
                逆向状态(取消、退款)
                状态轨迹    # 跟踪和记日志，可回溯
                并发修改，状态变更有序，状态变更消息有序
    前端
        减少dns查找     # dns可能查多个域
        减少对象        # 页面布局少，图片合并。对象不要过大，减少到浏览器并发连接数
        后台系统操作可反馈   # 便于确认效果
    文档和注释
        设计架构
        设计思想
        数据字典/业务流程
        现有问题
# 设计
    分层做维度扩展
## DDD
    # domain driven design
    本质
        维护概念完整性(纯洁)，避免语义泄露和腐化
### 建模
    要求
        简单、容易、清晰
        使用不动点
        领域专注
        内部概念完整一致(unification)
            术语不变、不矛盾、不重叠
    模型形式
        失血                            # 纯数据, 只有getter, setter
        贫血                            # 包含不依赖持久化的逻辑
        充血                            # 包含持久化的逻辑，service很薄，仅有事务和简单逻辑，不使用dao
        胀血                            # 无service
    过程
        分析模型                        # 业务领域分析, 不考虑代码
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
        重构
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
    战略建模                            # 形成上下文映射图
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
    战术建模                            # 组成限界上下文
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
### 分层
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
# 项目
## 分层
    mv*
        mvc
            # view controller model, 单向循环
        mvp
            # view presenter model, presenter双向交互
        mvvm
            # view view-model model, view-model双向绑定

    验证
    异常层
        # 封装每层异常为不同异常类
    过滤层
    监听器
    日志
    测试
## 稳定
    高并发、高可用、高可靠
    容量规划(流量、容量)
    SLA(service level agreement)制定(吞吐量、响应时间、可用性、降级方案)
    压测方案(线下、线上)
    监控报警(机器负载、响应时间、可用率)
        tracing
    应急预案(容灾、降级、限流、隔离、切流量、可回滚)
### 高并发原则
    无状态     # 应用无状态，配置有状态
        尽可能浏览器端维护会话
        分布式缓存放状态
    拆分  # 加法组合，乘法功能
          # 项目死于1到10，或10到100，因为解耦不够，无法重构
        业务拆分
        功能细分
        读写      # 读缓存，写分库分表，聚合数据
        AOP      # 如CDN
        模块      # 代码特征，如基础模块分库分表，数据库连接池
    扩展
        服务化发展
            进程内服务
            单机远程服务
            集群手动注册服务(nginx负载多实例)
            自动注册和发现服务(zookeeper)
            服务分组/隔离/路由
            服务治理(限流/黑白名单)
        AKF扩展立方
            x轴 横向复制                 # 复制服务或db, 瓶颈：内存缓存、特有数据
            y轴 面向功能、服务、资源拆分   # 微服务
                动词拆分                 # 登录、搜索、推荐等
                名词拆分                 # 目录、库存、账户等
            z轴 拆相近东西               # 数据分片(大小客户、地区、新旧等)
        横向扩展    # 复制服务或数据分散负载，纵向扩展是升级设备
            使用经济型系统
            扩展数据中心      # 三实时站点备份: a(0.5b, 0.5c), b(0.5a, 0.5c), c(0.5a,0.5b), 尽量分散
            使用云
    通信      # 要异步
        消息队列
            作用
                服务解耦
                异步处理
                流量削峰/缓冲     # 如促销期
            问题
                丢失/失败     # 持久化，日志，报警, 数据校对修正(worker扫库)
                重复          # 业务上防重
            例子
                redis扣库存->记录日志->同步worker->DB
        消息总线可扩展     # x扩展不行，y扩展用专用总线(降低了灵活性), z扩展根据客户
        减少拥挤          # 消息划分价值
    数据异构
        例子
            聚合数据表(一般KV存储)   # 数据闭环(不依赖其它服务)
            历史归档
    缓存
        客户端
            浏览器缓存   # Pragma, Expires, Cache-control
            ajax
            app缓存     # 大促时更新静态资源, 地图
        客户端网络      # 代理服务器缓存
        广域网
            代理服务器(如CDN)
                推送 或 拉取(回源)
            镜像服务器
            P2P
        源站
            接入层缓存   # 如页面缓存，用redis
                url重写
                一致性哈希
                proxy_cache         # 内存/SSD缓存内容
                proxy_cache_lock    # 一段时间的回源合并成一个
                shared_dict         # lua, 重启缓存不丢失
            应用层缓存           # 如搜索，建议物品等
                堆内缓存
                堆外缓存        # local redis cache
            分布式缓存(接入层后)
                redis集群     # 异步化写入, lua-resty-lock(非阻塞锁)
            对象缓存    # db和应用间的查询结果集
            静态化, 伪静态化
            服务器操作系统缓存
        并发化
    选择工具
        数据库     # rdb, nosql, hadoop
        防火墙     # 墙需要的东西
        日志       # 采集分析
        用同品牌设备
        慎用第三方
    容错
        隔离               # 不同步调用，限制异步调用(数量和超时)，能迅速发现故障
        不单点             # 一切都出故障
        不系统串联
        功能支持启用禁用    # 实现wire on/wire off框架
### 高可用原则
    降级
        开关集中化管理, 推送开关配置
        开关前置      # nginx层做开关
        可降级读服务   # 只读本地缓存、只读分布式缓存、只读默认数据
        业务降级      # 部分业务异步，处理高优先级，分配流量保障系统可用
    限流
        思路
            恶意请求流量只访问cache
            穿透到应用的流量用nginx limit
            恶意ip nginx deny
        切流量     # 某服务器挂了
            DNS切换
            httpDNS         # app配置，绕过运营商localDNS
            lvs/haproxy     # 切换故障的nginx
            nginx           # 切换故障应用
    可回滚
        事务
        代码库
        部署版本
        数据版本
        静态资源版本
## 微服务
    单体应用问题
        复杂: 模块多, 边界模糊, 依赖关系不清晰, 代码质量不统一
        技术债务: 不坏不修
        部署频率低: 迭代要部署整个应用，部署时间长，风险高。修复问题慢, 易出错
        可靠性差: 某bug导致整个应用崩溃
        扩展性差
        阻碍技术更新
    特征
        服务组件化
        按业务组织团队
        负责的态度, 不再是交付给维护者
        粗粒度通信, http(二进制协议)或消息总线
        去中心化治理
        去中心化管理数据
        基础设施自动化
        容错设计
        演进式设计
    原则
        单一职责
        自洽
        轻量级通信
        服务粒度: 边界(DDD中的界限上下文)
    持续发布
        工具链，自动化
        契约
        架构守护
        灰度替换
    *aaS
        SaaS(software as a service)
        PaaS(platform as a service)
        aPaaS(application PaaS)         # 简单配置产生任意需求的application
        saPaaS(specific aPaaS)          # 领域定制的aPaaS
        GaPaaS(generator of aPaaS)      # 脚手架，产生定制的aPaaS
## 云原生
    介绍
        cloud navtive, Pivotal 2013年提出
    12-Factor
        1 基准代码(code base)
            一份代码，多份部署
        2 依赖(dependences)
            显式声明依赖
        3 配置(config)
            配置存储于环境变量中
            环境变量粒度足够小，相对独立
        4 后端服务(backing services)
            后端服务作为附加资源, 与第三方服务不区别对待
        5 分离构建、发布、运行(build, release, run)
            构建: 代码转化到可执行包
            发布: 可执行包结合配置
            运行: 选定发布版本，按计划启动
        6 进程(process)
            多个无状态进程运行
        7 端口(port binding)
            网络服务通过端口绑定提供服务
            完全自我加载不依赖网络服务器
        8 并发(concurrency)
            进程作为一等公民
            通过进程模型扩展并发
        9 易处理(disposability)
            进程快速启动、优雅终止可最大化健壮性
            追求最小启动时间, 收到SIGTERM优雅终止，突然死亡时保持健壮
        10 环境等价(dev/prod parity)
            开发环境等价线上环境
        11 日志(logs)
            日志作为事件流
            应用本身使用stdout事件流，不考虑存储输出流，不管理日志
        12 管理进程(admin processes)
            管理进程不常驻, 一次性运行
            使用同样环境、代码版本、配置、依赖隔离, 避免同步问题
            提供REPL shell使一次性脚本变简单
# 服务化
    # autonomy.design
    表现
        一个需求拉很多人，代码写进来就删不掉了
        通用功能要么多种实现，要么参数过多
        线上问题难定位，本地做不了有意义的测试，反馈周期特别长
    本质
        减少沟通
            autonomy(自治): 减少沟通，功能可以删掉
                问题: 产品从整体效果出发，开发从实现出发
                依赖倒置
                    UI插槽, 服务集成
                    实现(服务)
                        编译时: 模板、函数替换
                        运行时: 组合对象、组合函数
                    实现(UI)
                        编译时: 页面模板替换, 显式组合与隐式组合
                        运行时: Vue插槽
            feedback(反馈): 故障定位，测试反馈，发版反馈，用户反馈无响应
                控制边界
                    进程
                        跨进程调用监控: 基础设施完善
                        OS强制配额、安全性: 基础设施好
                        内存隔离
                    函数
                        caller/callee索引: 同步调用栈、异步调用链、组件树
                        问题: 日志多，负责模糊
                    插件
                控制变更
                    多进程
                        多进程部署
                    多租户
                    多变种
                        配置中心下发开关
            consistency(一致性): 工具复用
                用户可见的一致性: UI/UE设计，前端落地
                autonomy: 上层业务推动
                    问题: 依赖修改要慎重
                feedback: QA, KPI
    拆分
        编辑时: 文件
        运行时: 进程
        组合关系
            加法
            乘法
            一致性