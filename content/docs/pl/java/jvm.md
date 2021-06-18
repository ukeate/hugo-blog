---
Categories: ["语言"]
title: "JVM"
date: 2018-10-09T08:48:07+08:00
---
# 基础
    定义
        JVM规范说明书, JVMS(Java Virtual Machine Specifications)
        Java语言规范, JLS(Java Language Specification)
        虚拟机
            指令集
            内存管理
    过程
        x.java -> javac -> x.class -> ClassLoader -> (字节码解释器、JIT) -> 执行引擎
    JVM语言
        Scala, Kotlin, Groovy, Clojure, jython, jruby等100多个
    JVM实现
        HotSpot                 # Oracle官方, 8之后收费, OpenJDK为开源版本
        Jrockit                 # Oracle收购, 合并入HotSpot
        J9                      # IBM
        Microsoft VM
        TaobaoVM                # HotSpot深度定制
        LiquidVM                # 直接匹配专门硬件
        azul zing               # 收费，快, GC1mm, HotSpot参考写的G1
    JRE, JDK
        JRE = jvm + core lib
        JDK = JRE + development kit
# JVM构造
## 指标
    吞吐量: 代码时间 / (代码时间 + GC时间)
    响应时间: STW越短, 响应时间越好
## 指令(Instructions)
    分类
        基于栈的指令类          # 简单, HotSpot
        基于寄存器的指令集      # 复杂但快, HotSpot局部变量表
    8大原子操作(JSR-133已放弃这个描述，但指令没变化)
        lock                    # 主内存，标识变量线程独占
        unlock                  # 主内存，解锁独占
        read                    # 主内存，读到工作内存
        load                    # 工作内存，read后的值放入线程本地变量副本
        use                     # 工作内存，传值给执行引擎
        assign                  # 工作内存，执行引擎结果赋值给线程本地变量 
        store                   # 工作内存，存值到主内存给write备用
        write                   # 主内存，写变量值
    方法指令                    # 在methods的Code中罗列
        aload_0                 # 变量表第0项入栈
        invokespecial #1        # 调private(无多态)的方法
        invokevirtual           # 调有多态可能性的方法
        invokestatic            # 调静态方法
        invokeinterface         # 调interface方法
        invokedynamic           # 1.7加入，定义类似函数指针时生成(但每个函数都创建了类)
            调用动态产生的类
                lambda
                反射
                scala等JVM语言
                CGLib ASM
            组成
                bootstrapMethod
                方法签名
            <1.8的bug           # 类产生于Perm Space，内存不回收
                for(;;) {I j = C::n;}
        return                  # 方法返回
        bipush 8                # byte扩展成int类型，放到方法栈中
        sipush 200              # short
        istore_1                # 出栈，放到下标为1的局部变量表
        iload_1                 # 局部变量表下标1位置值压栈
        iinc 1 by 1             # 局部变量表1位置值+1
        iadd                    # 出栈两个，相加压栈
        new                     # new对象, 地址压栈
        dup                     # 复制栈顶并压栈
        pop                     # 弹出栈顶
        if_icmpne 7             # int值比较，不等时跳到第7条指令
        mul                     # 乘法
        sub                     # 减法
## class结构
### 工具
    javap -v a.class
    jetbrain jclasslib
    jetbrain BinEd
    JBE                         # 可编辑
### 二进制
    Magic Number(4字节)
        cafe babe
    Minor Version(2字节)        # 小版本
    Major Version(2字节)        # 大版本
        JDK1.7是51.0
        JDK1.8是52.0
    constant_pool_count(2字节)
        # 长度constant_pool_count-1的表
    constant_pool               # 索引、tag、类型
        1 CONSTANT_Utf8_info                        # 存一些描述字符串
        2 标记
        3 CONSTANT_Integer_info
        4 CONSTANT_Float_info
        5 CONSTANT_Long_info
        6 CONSTANT_Double_info
        7 CONSTANT_Class_info
        8 CONSTANT_String_info
        9 CONSTANT_Fieldref_info                
        10 CONSTANT_Methodref_info                  # 方法引用
            指向CONSTANT_Class_info
            指向CONSTANT_NameAndType_info
        11 CONSTANT_InterfaceMethodref_info
        12 CONSTANT_NameAndType_info                # 方法名与类型
        15 CONSTANT_MethodHandle_info
        16 CONSTANT_MethodType_info
        18 CONSTANT_InvokeDynamic_info
    access_flags(2字节)         # bitmap按位与组合
        # class的修饰符
        ACC_PUBLIC 0x0001 public
        ACC_FINAL 0x0010 final
        ACC_SUPER 0x0020 JDK1.0.2之后必须为真, 表示invokespectial用新语义
        ACC_INTERFACE 0x0200 是否接口
        ACC_ABSTRACT 0x0400 抽象类
        ACC_SYNTHETIC 0x1000 编译器自动生成
        ACC_ANNOTATION 0x2000 
        ACC_ENUM 0x2000 
    this_class(2字节)
        存名字对应指向常量池序号
    super_class(2字节)
        存名字对应指向常量池序号
    interfaces_count(2字节)
    interfaces
    fields_count(2字节)
    fields
        access_flags(2字节)
        name_index              # 存常量池索引
        descriptor_index
            byte B
            char C
            double D
            float F
            int I
            long L
            short S
            boolean Z
            void V
            Object Ljava/lang/Object
            数组
                一维数组 [B
                多维数组 [[C
        attributes_count        # 赋加属性
        attributes
    methods_count(2字节)
    methods
        access_flags(2字节)
        name_index
        descriptor_index        # 先参数列表，后返回值
            void m() -> ()V
            String toString() -> Ljava/lang/String;
        attributes_count
        attributes              # 赋加属性
            Code                # 指令列表, 一般先压栈this(aload_0)
                LineNumberTable
                LocalVariableTable
    attributes_count(2字节)
    attributes
## Agent
    例子
        打包 a.jar
            MANIFEST.MF
                Premain_Class: MyAgent
            public class MyAgent {
                public static Instrumentation inst;
                public static void premain(String agentArgs, Instrumentation _inst) {
                    inst = _inst;
                } 
            }
        JVM参数 -javaagent: a.jar
        使用 MyAgent.inst
# JMM(Java Memory Model)
## 内存
### 运行时区域
    # Runtime data areas
    分类
        Program Counter             # 程序计数器，下一条指令位置
        Method Area                 # 方法区,线程间共享
            存储
                Class元信息
                代码编译信息, JIT编译信息
                常量池(Runtime Constant Pool)           # 常量池在运行时存放区
            版本区别
                Perm Space(<1.8)    # 要设定大小, 会溢出报错
                    存字符串常量
                    lambda生成临时类永远存在
                    Full GC不清理
                Meta Space(>=1.8)   # 自动大小无上限
                    字符串常量位于堆
                    会触发Full GC
        JVM stacks                  # 线程栈 
            Frame(栈帧)             # 一个方法一个栈帧
                Local Variable Table                # 局部变量表, 方法内的局部变量，值在常量池
                    默认第0个为this
                Operand Stack                       # 操作数栈
                Dynamic Linking                     # 指向调用方法的 运行时常量池的符号连接
                return address                      # 当前方法执行完的返回地址
        Native Method Stacks        # C/C++方法栈
        Direct Memory               # 直接内存
        Heap                        # 堆, 线程间共享
### 屏障
    CPU屏障
    JVM规范
        LoadLoad                # 上load和下load不能重排
        StoreStore
        LoadStore
        StoreLoad               # 最强
## 对象
### 对象内存存储
    普通对象
        对象头: markword 8字节
        ClassPointer            # 指向Class对象, 启用压缩4字节，不启用8字节
        实例数据
            引用类型            # 启用压缩4字节，不启用8字节
        Padding: 对齐8的倍数
    数组对象
        对象头
        ClassPointer
        数组长度4字节
        数组数据
        Padding
    对象头
        # 32位64位(25位没用到)，内容不同
        锁标志位2位             # 根据锁标志位判断存储内容
            01 无锁/偏向锁
            00 轻量级锁
            10 重量级锁
            11 GC标记
        是否偏向锁1位
        剩余位 
            无锁状态
                对象hashCode(25位或31位)
                    没重写过时默认计算(System.identityHashCode())
                    重写过的hashCode()结果不存在这里
                分代年龄
            轻量级锁
                指向栈中锁记录的指针
            重量级锁
                指向互斥量（重量级锁）的指针
            偏向锁
                线程ID 23位
                Epoch 2位
                分代年龄4位(所以分代年龄只有15)
        其它问题
            对象计算过hashCode，对象不能进入偏向锁状态(位已经被占了)
    实验工具 javaagent
### 对象定位
    句柄池                      # 指向句柄，句柄有对象指针和class指针, 三色标记GC提高效率
    直接指针                    # 指向对象，对象指class, HotSpot使用
## 并发
### 硬件层数据一致性
    硬件结构
        L0寄存器                # 1 cycles
        L1高速缓存              # 3-4 cycles, 1ns
        L2高速缓存              # 10 cycles, 3ns
        L3高速缓存              # 40-45 cycles, 15ns, 在主板
        (QPI总线传输)           # 20ns
        L4主存                  # 60-80ns
        L5磁盘
        L6远程文件存储
    数据不一致                  # 从L2多CPU开始
        锁总线(bus lock)
        CPU缓存一致性协议(如intel MESI)
### volatile
    工具
        hsdis                   # HotSpot Dis Assembler, 虚拟机字节码对应汇编
    bytecode
        ACC_VOLATILE
    JVM
        StoreStoreBarrier
        volatile写操作          # 上边写完再写，写完下边再读，写一致
        StoreLoadBarrier

        LoadLoadBarrier
        volatile读操作          # 上边读完再读，读完下边再写，读一致
        LoadStoreBarrier
    OS
        windows
            lock
        linux
            上下屏障，最后lock
### synchronized
    bytecode
        方法修饰
            synchronized
        代码
            monitorenter
            monitorexit
    JVM
        C/C++实现，会调用OS的同步机制
    OS
        lock
### happens-before原则
    # Java要求指令不能重排的几种情况
### as if serial
    # 不管如何重排序，单线程执行结果不变
    
# 过程
## 编译
    过程
        代码 -> bytecode -> JVM指令 -> OS指令
    解释器(bytecode intepreter)
    JIT(Just In-Time compiler)
    混合模式
        解释器 + 热点代码编译
        热点代码检测
            方法计数器
            循环计数器
## 加载
    HotSpot C++代码加载
        class对象加载到MethodArea
            metaspace(JDK1.8)
            permGeneration(JDK1.8之前)
    class加载过程
        loading                 # 读到内存
        linking
            verification        # 校验
            preparation         # 静态变量赋默认值
            resolution          # 解析, loadClass()可指定是否解析。常量池的符号引用转换成内存地址引用
        initializing            # 静态变量赋初始值，执行静态代码
    对象加载
        new过程
            class加载
            申请对象内存
            成员变量赋默认值
            调用构造方法<init>
                成员变量顺序赋初始值
                执行构造方法语句(先super)
    双亲委派                
        过程
            类名一层层向上找
            找不到时，一层层找再向下委派找
            都不能加载时, 抛ClassNotFound
        为什么
            安全, 自定义类不能覆盖
            已加载不用重复加载
        父加载器
            不是类加载器的加载器
            不是父类
            是组合的parent对象
        打破
            为什么                    
                JDK1.2之前都重写loadClass()
                thread.setContextClassLoader()指定线程上下文classLoader
                热启动/热部署(OSGi tomcat)加载同一类不同版本
            做法
                重写loadClass(), new多个ClassLoader
    类加载器
        Bootstrap               # 加载核心类 lib/rt.jar charset.jar等, C++实现所以get时为null
            如加载String
        Extension               # 加载扩展jar jre/lib/ext/*.jar, 由-Djava.ext.dirs指定
        App                     # 加载classpatch指定内容
        Custom ClassLoader      # 自定义ClassLoader
    加载路径环境变量            # 来自Launcher源码
        Bootstrap.ClassLoader   sun.boot.class.path
        ExtensionClassLoader    java.ext.dirs
        AppClassLoader          java.class.path
    API
        Class
            getClassLoader()
        ClassLoader             # findInCache() -> parent.loadClass() -> findClass()
            private final ClassLoader parent
            loadClass           # 热加载
        Launcher
            $AppClassLoader
            $ExtClassLoader
    自定义类加载器
        class MyClassLoader extends ClassLoader {
            @Override
            Class findClass(String) {
                return defineClass()
            }
        }
    懒加载                      # JVM未规定什么时候加载,但规定了什么时候初始化
    初始化
        new getstatic putstatic invokestatic指令，访问final变量除外
        java.lang.reflect对类进行反射调用
        初始化子类时，父类首先初始化
        虚拟机启动时，被执行的主类
        动态语言支持java.lang.invoke.MethodHandle解析的结果为REF_getstatic, REF_putstatic, REF_invokestatic的方法句柄时, 该类初始化
## GC
### 引用方式(强软弱虚)
    软引用
        # 内存不够用时回收，用做缓存
        # -Xms20M -Xmx20M
        SoftReference<byte[]> m = new SoftReference<>(new byte[1024*1024*10]);
        System.gc();
        m.get();
        new byte[1024*1024*15]
        m.get();
    弱引用
        # 只要gc就回收，用做容器如WeakHashMap(key是弱引用), ThreadLocalMap的key
        WeakReference<M> m = new WeakReference<>(new M());
        System.gc();
        m.get();
    虚引用
        # 值被回收时放入队列来通知, 用来触发回收堆外内存(用Unsafe的freeMemory())
        # 如NIO的直接内存DirectByteBuffer
        PhantomReference<M> r = new PhantomReference<>(new M(), QUEUE);
        r.get() // 自己写永远返回null                     
### 对象分配过程
    向栈分配                # 不要调参数
        好处
            不必GC
        条件
            线程私有小对象
            无逃逸
            可标量替换(基本类型替换整个对象)
    过大，分配到老年代
    线程本地分配            # TLAB(Thread Local Allocation Buffer), 不要调参数
        好处
            为了减少线程争用
        条件
            小对象
            占用eden, 默认每个线程占1%
    伊甸区
    s1,s2
        次数                   # 最大15(对象头上空间决定)
            Parallel Scavenge 15
            CMS 6
            G1 15
        动态年龄
            eden + s1 复制到s2, 超过s2总内存一半时，年龄最大的对象进入老年代
        分配担保
            YGC时survivor区空间不够, 直接进入老年代
    GC清除或到老年代
### GC分代过程
    YGC -> s0
    YGC, eden + s0 -> s1
        年龄足够 -> old
        s区装不下 -> old
    YGC, eden + s1 -> s0
    old满了 -> FGC
### 常见的回收器
    概念
        Safe Point              # STW时机
        没有无STW的回收器
    分代
        Young
            Serial              # 第一个GC
                STW, 单线程串行回收
            Parallel Scavenge
                STW, 并行回收
            ParNew              # Parallel New
                增强PS, 以配合CMS并行回收, CMS到某阶段时PN运行
        Old
            Serial Old
                特点
                    适用几十M
                    mark-sweep-compact，单线程
            Parallel Old
                特点
                    适用几个G
                    mark-sweep-compact，多线程
            CMS                 # concurrent mark sweep, 1.4后期引入, JDK11取消
                特点
                    适用20G
                    多线程并行回收, 并发回收(GC与程序同时运行)，降低STW时间(200ms)
                不足            # 问题多，没有版本默认CMS
                    浮动垃圾
                    碎片多，新对象分配不下时，使用SerialOld
                        设低GC阈值回收浮动垃圾
                清理过程
                    初始标记(initial mark)
                        STW, 单线程, 标记根对象
                    [预标记]                        # Card Marking, 把Card标为Dirty
                    并发标记(concurrent mark)
                        不STW, 多线程, 执行多次
                    重新标记(remark)                # 处理并发标记过程中的变化
                        STW, 多线程, 
                    并发清理(concurrent sweep)      # 过程中产生的浮动垃圾, 下次回收
                        不STW, 多线程, 
                    [整理阶段]
                日志
                    [GC(Allocation Failure)[ParNew:6144K->640K(6144K)], 0.02 secs] 6585K->2770K(19840K),0.02 secs][Times:user=0.02 sys=0.00, real=0.02 secs]
                        6144K->640K(6144K): 回收前 回收后 总容量
                        6585K->2770K(19840K): 堆回收前 回收后 总大小  

                    [GC (CMS Initial Mark)]
                        [1 CMS-initail-mark]
                    [CMS-concurrent-mark-start]
                    [CMS-concurrent-preclean-start]
                    [GC (CMS Final Remark)]
                        [YG occupancy]              # 清理后年轻代占用及容量
                        [Rescan(parallel)]          # STW下标记存活对象
                        [weak refs processing]      # 弱引用处理
                        [class unloading]           # 卸载用不到的class
                        [scrub symbol table]        # 清理常量池
                        [scrub string table]        # 清理常量池
                        [1 CMS-remark]              # 清理后老年代占用及容量
                    [CMS-concurrent-sweep-start]
                    [CMS-concurrent-reset-start]

    不分代
        G1                      # Garbage First, 1.7引入, 1.8完善, 1.9默认
            特点
                适用上百G
                STW 10ms回收
                    容易预测STW时间
                    低latency, 但throughput也低
                并发回收, 三色标记
                只逻辑分代, 不物理分代 
                    内存分Region, Region组成不同大小块，块在逻辑分代中
                    Eden和Old区的内存映射会变化
                动态新老代空间                      # 如果YGC频繁，就Young调大
                    不要手工指定, 是G1预测YGC停顿时间的基准, 停顿时间通过参数设置
            概念
                CSet            # Collection Set
                    可回收Region集合, 回收时存活的对象被移动
                    占堆空间不到1%
                RSet            # Remembered Set
                    用于找到谁引用当前对象(对象级别), 记录其他Region的引用
                    赋值时有GC写屏障                # 非内存屏障
                CardTable       # YGC定位垃圾，要从Root查所有Old区对象，效率低
                    Old区对象引用Young区时, bitmap标DirtyCard。YGC时只扫描DirtyCard
                MixedGC         # 默认45%, 同CMS
                    初始标记
                    重新标记
                    筛选回收    # 筛选Region回收，有用对象复制到其它Region
            日志
                [GC pause (G1 Evacuation Pause) (young) (initial-mark)]         # 复制存活对象, initial-mark在MixedGC时有
                [GC concurrent-root-region-scan-start]                          # 混合回收
                [GC concurrent-mark-start]                                      # 混合回收
                [Full GC (Allocation Failure)]                                  # 无法evacuation时, G1中很严重
        ZGC                     # JDK11, 不分代(SingleGeneration)
            特点
                STW设计10ms, 实际1ms
                适用4T（JDK13 16T）
                内存分块（有大有小）
            概念
                没有RSet, 改进了SATB指针
        Shenandoah              # JDK11
        Epsilon                 # JDK11, debug用
        Zulu
    组合
        S + SO
        PS + PO                 # 1.8默认, 10G内存10+秒
        PN + CMS
### 算法
    定位
        引用计数(ReferenceCount)
            循环引用问题        # 内部互相引用，没有外部引用
        根可达算法(RootSearching)
            线程栈变量 
            静态变量
            常量池
            JNI指针             # 本地方法用到的对象
    并发标记
        三色标记
            白                  # 未被标记
            灰                  # 自身被遍历到，成员变量未被遍历到
            黑                  # 自身、成员变量都被遍历到
            漏标问题 
                两个必要条件 
                    黑引用白后，灰对白的引用断开
                算法
                    incremental update                      # 增量更新，关注引用的增加, CMS用的
                        增加引用后，标记为灰, 重新标记阶段再扫描
                        缺点是灰色还要重新扫描
                    SATB snapshot at the beginning          # 关注引用的删除, G1用的
                        开始时快照, 引用消失时，引用推到堆栈, 下次扫描还扫白色对象
                        优点是只扫描修改过的对象, 看RSet中有没有引用
        颜色指针                # 信息记在指针里
        租户隔离, Session Base GC           # Web专用, 基于session, session断开后删除
        各GC应用
            CMS
                三色标记 + Incremental Update
            G1
                三色标记 + SATB
            ZGC
                颜色指针 + 写屏障
            Shenandoah
                颜色指针 + 读屏障
    清除
        标记清除(Mark-Sweep)    # 一遍标记，一遍清理, 适合老年代
            算法简单，戚对象多时效率高
            两遍扫描效率低，容易产生碎片
        拷贝(Copying)           # 存活对象copy到新内存, 旧内存直接清理，适合伊甸区(新生代)
            适用存活对象少的情况
            内存减半
        标记压缩(Mark-Compact)  # 有用的填到前边去空隙去, 适合老年代
            不会碎片，不会内存减半
            扫描两次，还要移动
    分代模型
        分代模型                # -Xms -Xmx设置大小
            new/young(新生代)   # MinorGC/YGC, -Xmn设置大小, 默认占比1
                eden(伊甸)      # 默认占比8
                survivor x 2    # 默认每个占比1
            old(老年代)         # MajorGC/FullGC, 1.8默认占比2, 之前是3
                tenured(终身)
            methodArea          # 1.7永久代, 1.8元数据区
        各JVM的分代模型
            Epsilon ZGC Shenandoah不是分代模型
            G1是逻辑分代，物理不分代
            其他都是逻辑分代 + 物理分代

# 调优(Tuning)
    前提
        从业务场景开始
        无监控(能压测), 不调优
    目标
        减少FGC
        确定倾向                        # 吞吐量, 或响应时间
            吞吐量好: PS + PO
            响应时间好: G1 或 PN + CMS  # G1吞吐量少10%
    组成部分
        JVM预规划
        优化JVM运行环境(慢、卡顿)
        解决JVM运行时出现的问题(OOM)
    步骤
        熟悉业务场景
            响应时间
            吞吐量
        选择回收器组合
        计算内存需求(小的快，大的少gc)
        选CPU
        设定年代大小、升级年龄
        设定日志参数
        观察日志情况
## 问题分析
### 工具
    CPU经常100%
        top查进程CPU(top)
        进程中线程CPU(top -Hp)
        导出该线程堆栈(jstack)
        查哪个方法(栈帧)消耗时间(jstack)
    内存高
        导出堆内存(jmap)
        分析(jhat jvisualvm mat jprofiler ...)
    监控JVM
        jstat jvisualvm jprofiler arthas top ...
        网管: Ansible
    流程
        网管报警
        top -Hp 进程号
        jstack 进程号               # 列出所有线程号, 线程状态
            WAITING, 一直等不到, BLOCKED, 拿不到锁
            waiting on <0x0000> (a java.lang.Object)    # 找到目标等待的线程
        jstack -l 16进制线程号      
        jps
        jinfo 进程号                # 列JVM信息
        jstat -gc 进程号 500        # 每500ms打印一次gc信息
        jmap -histo 进程号 | head -20                   # 列所有对象
            有性能消耗，但不很高，可以在线执行
        jmap -dump:format=b, file=x pid                 # 导出转储文件
            内存特别大时，jmap会卡顿
            多个服务器可用，停一个不影响
            设定HeapDumpOnOutOfMemoryError产生堆转储文件                 
            在线定位(中小型公司用不到)
        jhat -J-mx512M x.hprof      # 分析堆dump文件, 有OQL
        arthas                      # 在线定位
            启动
                java -jar arthas-boot.jar
            常用命令                # 没有集成jmap功能
                jvm                 # jinfo
                thread              # jstack
                    thread 1
                dashboard           # top
                heapdump            # jmap -dump
                dump
                redefine            # 热替换
                    目前只能改method实现，不能改方法名与属性
                jad                 # 反编译类
                    看动态代理生成的类
                    看第三方类
                    看版本
                sc                  # search class, 显示class信息
                watch               # watch method
        MAT                         # 分析dump文件
        jprofiler
        jconsole                    # 需要JMX
            JMX会消耗性能生产服务器不开
            JMX图形界面只用于压测
        jvisualVM                   # 需要JMX, 可分析dump文件
### 内存
    现象
        OOM崩溃
        CPU飙高, 不断FGC
    线程池不当运用
    加内存反而卡顿
        GC, 应该用CMS或G1替换 PS+PO
    JIRA不停FGC, 没定位出来
        扩内存到50G, GC换G1, 重启
    tomcat server.max-http-header-size过大
        默认4096, 每个请求都分配
    lambda表达式导致方法区溢出
        java.lang.OutofMemoryError: Compressed class space
    disruptor不释放缓存
    使用Unsafe分配内存, 直接内存溢出
    -Xss设定小, 栈溢出
    重写finalize()引发GC
        finalize()耗时长, GC时回收不过来，不停GC
    内存不到10%，频繁FGC
        有人显式调用System.gc()                         # 不定时调，但会频繁调
    大量线程, native thread OOM
        减少堆空间，留更多系统内存产生native thread
    G1产生FGC
        降低MixedGC触发的阈值       # 默认45%
        扩内存
        提高CPU                     # 回收快
## HotSpot参数
    辅助
        -XX:+PrintCommandLineFlags -version             # 打印启动参数, -version是随便一个命令
        -XX:+PrintFlagsFinal -version                   # 打印所有XX参数
        -XX:+PrintFlagsInitial      # 打印默认参数
        -XX:+PrintVMOptions         # 显示VM启动参数
        -                           # 标准参数
        -X                          # 显示非标参数
        -XX                         # 显示不稳定参数
    内存
        -XX:+HeapDumpOnOutOfMemoryError                 # OOM时产生堆转储文件 
        -Xms40M                     # 堆起始大小
        -Xmx60M                     # 堆最大大小, 最好和Xms一样以免堆弹大弹小
        -Xmn                        # 年经代
        -Xss                        # 栈空间
        -XX:InitialHeapSize         # 起始堆大小，自动算
        -XX:MaxHeapSize             # 堆最大大小，自动算
    内存模型
        -XX:-DoEscapeAnalysis       # 去逃逸分析
        -XX:-EliminateAllocations   # 去标量替换
        -XX:-UseTLAB                # 去tlab
        -XX:TLABSize                # 设置TLAB大小
        -XX:+PrintTLAB
        -XX:MaxTenuringThreshold    # 进老年代（升代）回收次数, 最大值15， CMS默认6，其它默认15
    对象和类
        -XX:+UseCompressedClassPointers                 # class指针压缩
            开启时4字节，不开启时8字节
        -XX:+UseCompressedOops                          # 引用类型指针压缩, Ordinary Object Pointers
            开启为4字节，不开启时8字节
        -verbose:class              # 类加载详细过程
        -XX:PreBlockSpin            # 锁自旋次数
    编译
        -Xmixed                     # 混合模式
        -Xint                       # 解释模式
        -Xcomp                      # 编译模式
        -XX:CompileThreshold = 10000                    # 检测热点代码次数
    GC
        -XX:+PrintGC                # 打印GC信息
        PrintGCDetails              # 打印GC更详细
        PrintGCTimeStamps           # 打印GC时间
        PrintGCCauses               # GC原因
        PrintHeapAtGC
        PrintGCApplicationConcurrentTime                # GC应用程序时间
        PrintCApplicationStoppedTime                    # 打印STW时长
        -XX:+PrintReferenceGC       # 打印回收多少种引用类型
        -XX:+UseConcMarkSweepGC     # 用CMS
        -XX:+DisableExplictGC       # System.gc()不管用

        Parallel常用
            -XX:SurvivorRatio           # 新生代Eden区和Surivor区的比例
            -XX:PreTenureSizeThreshold  # 大对象到底多大
            -XX:+ParallelGCThreads      # 并发线程数, 默认是CPU数
            -XX:+UseAdaptiveSizePolicy  # 自动调所有区比例
        CMS常用
            -XX:ParallelCMSThreads      # 并发线程数，默认是CPU数一半
            -XX:CMSInitiatingOccupancyFraction 92%          # 老年代占多少时触发GC, 1.8 92%, 之前68%
                设小一点，清除浮动垃圾
                过大时，栈分配不下，Promotion Failure，触发FGC
            -XX:+UseCMSCompactAtFullCollection              # GC时压缩，避免碎片片
            -XX:CMSFullGCsBeforeCompaction                  # 多少次GC后压缩
            -XX:+CMSClassUnloadingEnabled                   # 回收方法区
            -XX:CMSInitiatingPermOccupancyFraction          # 到什么比例时进行Perm回收, 1.8之前
            GCTimeRatio                                     # GC占程序运行时间的百分比
            -XX:MaxGCPauseMillis                            # GC停顿时间, CMS会减少年轻代大小
        G1
            -XX:MaxGCPauseMillis                            # STW时间, 区别CMS, G1会调整Young区的块数
            GCTimeRatio
            -XX:GCPauseIntervalMillis                       # STW之间间隔时间
            -XX:+G1HeapRegionSize                           # Region大小, 1 2 4 8 16 32, 逐渐增大, GC间隔更长, 每次GC时间更长
                ZGC是动态调整的
            G1NewSizePercent                                # 新生代最小比例, 默认5%
            G1MaxNewSizePercent                             # 新生代最大比例，默认60%
            ConcGCThreads                                   # GC线程数
            InitiatingHeapOccupancyPercent                  # 启动GC的堆空间占用比例

    JMX监控
        -Djava.rmi.server.hostname=192.168.1.1
        -Dcom.sun.management.jmxremote 
        -Dcom.sun.management.jmxremote.port=11111 
        -Dcom.sun.management.jmxremote.authenticate=false 
        -Dcom.sun.management.jmxremote.ssl=false
    调优                            # 参数越来越少
        JVM参数800个
        CMS参数300个
        G1参数100个
        ZGC更少
        Zing1个
    GC组合参数
        -XX:+UseSerialGC
            S + SO
        -XX:+UseParNewGC                # 已废弃
            PN + SO
        -XX:+UseConc(urrent)MarkSweepGC
            PN + CMS + SO
        -XX:+UseParallelGC               # 1.8默认
            PS + PO
        -XX:+UseParallelOldGC
            PS + PO
        -XX:+UseG1GC
            G1
    日志参数
        -Xloggc:/logs/xx-xx-%t.log
        -XX:+UseGCLogFileRotation           # 5个满了，覆盖第一个
        -XX:NumberOfGCLogFiles=5
        -XX:GCLogFileSize=1024M
        -XX:+PrintGCDetails
        -XX:+PrintGCDateStamps
        -XX:+PrintGCCause
## HotSpot日志
    GC                          # PrintGCDetails
        [GC
            GC表示YGC, Full GC是FGC
        (Allocation Failure)
            原因
        [DefNew:4544k->259k(6144k), 0.0873 secs]
            DefNew表示年轻代, 回收前后的大小, 6144是年轻代总大小，回收时间
        4544k->4356k(19840k), 0.0812 secs]
            堆的前后大小, 19840是堆总空间, 回收时间
        [Times: user=0.01 sys=0.00, real=0.01 secs]
            linux time命令，用户态时间，内核态时间，总时间
    异常退出dump堆
        def new generation total 6144k, used 5504k [0x00, 0x00, 0x00]
            新生代总共多少，用了多少。内存起始地址，使用空间结束地址，整体空间结束地址
            total = eden + 1个survivor
        eden space 5504k, 100% used []
            eden
        from space 640k, 0% used []
            s0
        to space 640, 0% used []
            s1
        tenured generation total 13696k, used 13312k []
            old
        the space 13696k, 97% used []
            old
        Metaspace used 2538k, capacity 4486k, committed 4864k, reserved 1056768k
            used真正使用的大小
            capacity目前指定的容量 
            committed 表示预先占用的大小
            reserved表示共保留的大小
        class space used 275k, capacity 386k, committed 512k, reserved 1048576k
            metaspace中存class的部分