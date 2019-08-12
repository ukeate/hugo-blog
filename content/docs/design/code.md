---
Categories : ["设计"]
title: "设计-代码"
date: 2018-10-10T17:40:53+08:00
---

# 思想
    原则
        替换
            子类继承超类的所有
        单一职则
            一个类负责一个功能
        开闭
            对扩展开放，对修改关闭，如接口
        最小功能隔离
        顺序依赖
            低层依赖高层，具体依赖抽象

        非侵入     # non-intrusion
            将功能推入代码，而非代码拿到功能
            代码实现接口，而非继承类

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
    并发的世界，并发的软件
        分布式的世界，分布式的软件
        不可预测的世界，容错性强的软件
        复杂的世界，简单的软件

## 面向对象(Object Oriented)
    接口
        无实现
        可多重继承
    抽象类
        可以有私有方法变量
        实现部分方法
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