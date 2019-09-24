---
Categories : ["设计"]
title: "设计-代码"
date: 2018-10-10T17:40:53+08:00
---

# 原则
    观念
        kiss(keep it simple stupid)
        YAGNI(You Ain’t Gonna Need It)
        取好名字占设计一半
        约定大于配置
        并发的世界，并发的软件
            分布式的世界，分布式的软件
            不可预测的世界，容错性强的软件
            复杂的世界，简单的软件
        代码即数据
            物体上绑定行为数据
            传递代码数据(函数一等公民)
        防御性编程
            接口前validator
            启动时自检断言
            异常处理
            不可过度
    设计
        solid原则
            单一职则(single responsibility)
                一个类负责一个功能
            开闭(open/closed)
                对扩展开放，对修改关闭，如接口, 如数组扩展结构体状态
            里氏替换原则(liskov substitution)
                子类继承超类的所有
            接口分离(interface segregation)
                最小功能隔离
            依赖反转(dependency inversion)
                低层依赖高层, 具体依赖抽象
        非侵入     # non-intrusion
            将功能推入代码，而非代码拿到功能
            代码实现接口，而非继承类
        拆分
            边界
            正交
        unix rules
            模块化(modularity)          # 模块由精心设计的接口连接
            清晰化(clarity)             # 可读性、可维护性
            组合(composition)
            分离(separation)
            简单(simplicity)
            节俭(parsimony)             # 越小越好
            透明(transparency)          # log, tracing
            鲁棒(robustness)
            可展示(representation)      # 逻辑简单，数据复杂
            最小惊吓(least surprise)     # 少打破用户预期
            安静(silence)
            修复(repair)                # 产生足够报错
            经济(economy)               # 减少开发时间
            生成(generation)            # 避免手写, 用高阶抽象生成代码
            优化(optimization)            # 优化和收益平衡
            分化(diversity)             # 一开始设计不限制、优雅开放灵活
            扩展(extensibility)         # 协议可扩展
    优化
        需要时再优化，设计时考虑扩展性
        dry(don't repeat yourself), 不可过度
        找瓶颈
    产出
        设计清晰
        选型简单
        代码精炼
        抽象优雅
# 设计
    创建
        factory, abstract factory       # 工厂
        builder                         # 构建者
        prototype                       # 原型复制来产生对象
        singleton                       # 单例
    结构
        adapter                         # 适配器
        bridge                          # 抽象与实现分离
        composite                       # 抽取公共行为
        decorator                       # 装饰
        facade                          # 外观。提供子类的默认视图
        flyweight                       # 享元
        proxy                           # 代理
    行为
        interpreter                     # 解释器
        template method                 # 模板方法、泛型
        chain of responsibility         # 责任链
        command                         # 命令
        iterator                        # 迭代器
        mediator                        # 消息传递中介
        memento                         # 保存、恢复状态
        observer                        # 观察者
        state                           # 不同状态定义不同行为
        strategy                        # 同行为的不同算法、替换算法
        visitor                         # 访问者。抽象行为本身，不同访问对象不同行为
    元素模式
        抽象各模式成元素，简化表示
    actor                               # 消息通信
    reactor                             # 事件轮循，注册回调，如libevent
    proactor                            # 注册事件回调，os通知触发回调


    惰性求值
        链式定义(配方)，后自动触发(js tick调度)终止操作
    dsl测试(如jasmine.js)
## 数据结构
    状态机解决流程问题
    AST解决主义问题
## 面向对象(Object Oriented)
    特性
    ooad
        # Object Oriented Analysis and Design
        ooa     # analysis
            建立针对业务问题域的清晰视图
            列出核心任务
            针对问题域建立公共词汇表
            列出针对问题域的最佳解决方案
        ood     # design
            细化类关系，明确可见性
            增加属性
            分配职责(方法)
            消息驱动系统中消息传递方式
            局部应用设计模式
            类图时序图
        oop     # program
            抽象: abstract
                接口
                    无实现
                    可多重继承
                抽象类
                    可以有私有方法变量
                    实现部分方法
            封装: encapsulation
                # 数据和方法绑定
            继承: inheritance
            多态: polymorphism
                overload为编译时
                override为运行时
            关联: association
                # has a
                双向关联
                    两个类互相知道对方公共属性和操作
                单向关联（大多数）
                    一个类知道另一个类的公共属性和操作
                聚合: aggregation
                    a包含b, b可以不在a创建时创建
                组合: composition
                    比聚合强，a包含b, b在a创建时创建
            内聚与耦合: cohesion & coupling
                # 高内聚低耦合
            依赖: dependency
                # use a
            泛化: generalization
                # is a
                泛型
## 函数式
    数组
        [1, 1, 3, 5, 5].reduce(function(x, y){ return x + y;})
        [1, 4, 9].map(function(num){return num * 2;})
    高阶函数(higher-order function)
        操作函数的函数, 接收函数作为参数, 返回函数
    不完全函数(partial function)
        一次调用拆成多次调用，每次调用返回一个函数，如f(1,2)(3,4)(5,6)
            # 每次调用叫做不完全调用(partial application)
    不变式
        循环不变式
            用于形式化证明正确性
            描述
                有循环变量
                算法初始、保持、终止时, 某特性不变, 如选择排序中, arr[0,...,j-1]一直有序
        类(或数据类型)不变式
            并发时, 不变的成员关系
                如, 并发临界区(同时只能一个线程占用)
    cps(continuation passing style)
        传入处理函数, 处理函数中传处理函数
    curry
        f(1,2,3)改写成f(1).f(2).f(3)
    thunk
        触发函数, 如 f(){_f(1)}
# 风格
    命名
        包名类名为名词, 方法名为动词
        参数、方法名称在上下文语义中合理 , 像写文章一样
        横向代码单屏内分行
    性能
        避免嵌套循环，特别是数据库操作
    结构
        # 高内聚，低耦合
        抽取方法
        业务逻辑分层
        框架无侵入性
    技巧
        注释驱动写复杂业务
        自解释代码
    安全
        密码二次验证
        离机锁屏
        用户名、密码、ip、端口不提交
        代码安全, 如sql注入, XSS
# 质量
    代码
        功能、结构、资源
    非遗留代码
        写了测试
    改代码
        bug
        重构
            # 只改结构
         确定修改点
            找出测试点
            解依赖
                伪/仿对象
                接缝
                    全局函数
                        提取重写方法
                    宏预处理
                    替换连接的代码
                    对象
                        # 耦合对象不好初始化
                        子类化重写方法
                        接口提取
                        创建简化接口
                        创建简化类与对象，引用原对象
                        暴露静态方法
                        对象提取公共方法，只测公共方法
                    传方法参数
            写测试
        优化
            # 只改资源
# 工具
    CLI(command client)和GUI
        GUI更快更容易
        CLI的优势
            更通用，更底层，更强大
            定制化脚本
            更少占用内存
            可定义别名
