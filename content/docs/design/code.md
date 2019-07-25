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

## 面向对向
    # Object Oriented
    接口
        一定要实现所有方法
        接口可以实现多重继承
    抽象类
        抽象类可以有私有方法或私有变量
        可以只实现部分方法

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
## 单例
    单例模式
        单例模式确保某个类只有一个实例，自行实例化并向整个系统提供这个实例。
            # 大多有资源管理器的功能
            # java反射机制会使所有单例失效：私有构造方法可以被访问
            如
                线程池
                缓存
                日志对象
                对话框
                打印机
                显卡驱动程序
    例子
        public class Singleton{
            private static Singleton uniqueInstance = null;
            private Singleton(){}
            public static Singleton getInstance(){
                if(uniqueInstance == null){
                    uniqueInstance = new Singleton();
                }
                return uniqueInstance;
            }
        }
    几种单例
            o-> 饿汉式，类初始化时实例化
            public class Singleton1 {
                // 私有的默认构造子
                private Singleton1() {}
                // 已经自行实例化 ，final
                private static final Singleton1 single = new Singleton1();
                // 静态工厂方法 
                public static Singleton1 getInstance() {
                    return single;
                }
            }

            o-> 懒汉式，第一次调用时实例化
            public class Singleton2 {
                // 私有的默认构造子
                private Singleton2() {}
                // 注意，这里没有final    
                private static Singleton2 single=null;
                // 静态工厂方法 
                public synchronized  static Singleton2 getInstance() {
                    if (single == null) {  
                        single = new Singleton2();
                    }  
                    return single;
                }
            }

            o-> 双重锁,解决问题并发创建问题。在不同jvm或多核cpu上，有无序写入bug
                # 避免bug就直接创建static属性，或get方法修饰synchronized
            public class Singleton {
                private static Singleton instance = null;
                private Singleton(){}
                public static Singleton getInstance(){
                    if(instance == null){
                        // 两线程并行到此，一个block
                        synchronized(Singleton.class){
                            // 线程1返回，线程2到此需要再判断instance
                            if(instance == null){
                                instance = new Singleton();
                            }
                        }
                    }
                    return instance;
                }
            }

            o-> map注册
                # 学Spring，将类名注册
            public class Singleton3 {
                private static Map<String,Singleton3> map = new HashMap<String,Singleton3>();
                static{        
                    Singleton3 single = new Singleton3();
                    map.put(single.getClass().getName(), single);
                }
                // 保护的默认构造子
                protected Singleton3(){}
                // 静态工厂方法,返还此类惟一的实例
                public static Singleton3 getInstance(String name) {
                    if(name == null) {
                        name = Singleton3.class.getName();
                        System.out.println("name == null"+"--->name="+name);
                    }
                    if(map.get(name) == null) {
                        map.put(name, (Singleton3) Class.forName(name).newInstance());
                    }
                    return map.get(name);
                }
            }
## 异步
    cps: continuation-passing style
        在函数式编程中, 多传一个参数k明确控制continuation
    bio
        blocking IO
        特点
            顺序执行
        例子
            tomcat的单个请求
            fio
                操作系统不支持file回调，所以不支持基于文件的nio
    nio
        nonblocking IO
        特点
            基于事件与回调
        例子
            net io
                如nodejs中的单线程处理业务
            db io
                oracle 已支持回调, nodejs模块支持后可做到nio
    aio
        Asynchronous Input/Output
        特点
            基于硬件，速度快
        例子
            nodejs的socket广播, 利用nodejs的线程池作c++模块的轮循传发
## oo
    接口
        一定要实现所有方法
        接口可以实现多重继承
    抽象类
        抽象类可以有私有方法或私有变量
        可以只实现部分方法

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
            继承: inheritance
            多态: polymorphism
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
# 方案
    重复提交
            直接redirect
            csrf令牌
    权限
            过滤器 页面权限
            拦截器aop 数据权限
    seo
            静态化
    web状态
            cookie
            url中sessionId
    加密
            base64
            sha
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