---
Categories : ["设计"]
title: "设计-代码"
date: 2018-10-10T17:40:53+08:00
---

# 思想
    todo: 待统一
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

            non-intrusion
                    将功能推入代码，而非代码拿到功能
                    代码实现接口，而非继承类

    创建
            factory, abstract factory
            builder
            prototype
                    # 原型复制来产生对象
            singleton
    结构
            adapter
            bridge
                    # 抽象与实现分离
            composite
                    # 抽取公共行为
            decorator
            facade
                    # 外观描述
            flyweight
                    # 享元
            proxy
    行为
            interpreter
            template method
            责任链
            command
            iterator
            mediator
                    # 消息传递中介
            memento
                    # 保存，恢复状态
            observer
            state
                    # 不同状态下不同行为
            strategy
                    # 同行为的不同算法，替换算法
            visitor
                    # 抽象行为本身，不同对象不同行为
## 单例
    单例模式
            单例模式确保某个类只有一个实例，而且自行实例化并向整个系统提供这个实例。
                    如                # 大多有资源管理器的功能
                            线程池
                            缓存
                            日志对象
                            对话框
                            打印机
                            显卡驱动程序
            java反射机制会使所有单例失效：私有构造方法可以被访问
            
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
    三种单例
            // 饿汉式单例类.在类初始化时，已经自行实例化 
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
            // 懒汉式单例类.在第一次调用的时候实例化 
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
            // 双重锁形式,解决问题
                    # 1：并发访问非单例问题
                    ## 2：下放到if内部，在实例创建以后每次直接跳过，只有实例没创建时才每个线程加锁判断，缩小了判断范围。否则不论实例有没有，每次都会加锁判断。
            public class Singleton {
                    private static Singleton instance = null;
                    private Singleton(){}
                    public static Singleton getInstance(){
                    if(instance == null){
                    synchronized(Singleton.class){
                            if(instance == null){
                                    instance = new Singleton();
                            }
                    }
                    }
                    return instance;
            }
            // 登记式单例类.
            // 类似Spring里面的方法，将类名注册，下次从里面直接获取。
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
            ooa
                    建立针对业务问题域的清晰视图
                    列出核心任务
                    针对问题域建立公共词汇表
                    列出针对问题域的最佳解决方案
            oop
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
            参数、方法名称在上下文语义中合理 , 就像写小说一样
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