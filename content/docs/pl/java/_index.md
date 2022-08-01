---
Categories: ["语言"]
title: "Java"
date: 2018-10-09T08:48:07+08:00
---
# 基础
    历史
        1991.4 Oak
        1995.5 Java1.0 "Write Once, Run Anywhere"
        1996.1 JDK1.0, 纯解释型JVM(Sun Classic VM), Applet, AWT
        1996.5 JavaOne大会
        1997.2 JDK1.1, JDBC, JAR文件格式, JavaBeans, RMI, 内部类(Inner Class), 反射(Reflection)
        1998.12 JDK1.2, 分出J2SE、J2EE、J2ME。JVM内置JIT, EJB, Java Plug-in, Java IDL, Swing, Collections, strictfp关键字
        1999.4 JVM HotSpot
        2000.5 JDK1.3, 数学运算, Timer, JNDI成为平台服务, CORBA IIOP实现RMI, 2D API, JavaSound
        2002.2 JDK1.4, 成熟版本，多公司参与。正则, 异常链, NIO, 日志类, XML, XSLT
            # .NET发布
        2004.9 JDK1.5, 自动装箱, 泛型, 动态注解, 枚举, 变长参数, foreach, 改进内存模型JMM(Java Memory Model), concurrent包
        2006.12 JDK1.6, 改名为Java SE 6, Java EE 6, Java ME 6。动态语言支持(内置Mozilla JavaScript Rhino), 编译API, HTTP服务器API。JVM改进(锁、gc、类加载)
        2006.11 JavaOne Java开源。建立OpenJDK
        2009.2 JDK1.7, OpenJDK1.7和Sun JDK1.7几乎一样。Lambda项目, Jigswa项目(虚拟机模块化), 动态语言支持, GarbageFirst收集器, Coin项目(语言细节进化)。Oracle收购Sun后延迟部分项目。支持Mac OS X和ARM
        2009.4 Oracle收购Sun

        o-> JVM历史
        Sun Classic                 # 1.0到1.3
            解释器
            sunwjit                 # 外挂编译器, 还有SymantecJITt shuJIT等
                编译器和解释器不能同时工作，编译器接管后，要对所有代码编译，不能用耗时稍高的优化，效率低
        Exact VM                    # 1.2到1.3
            使用准确内存管理EMM(Exact Memory Management)而得名
                虚拟机知道内存数据类型, gc时好判断数据是否被使用
                抛弃Classic VM基于handler(句柄关联对象移动地址)的对象查找方式, 每次定位对象少一次间接查找
            两级即时编译器
            与解释器混合工作
        Sun HotSpot VM              # 1.2, Sun JDK和OpenJDK, 来源Strongtalk VM
            EMM
            热点代码探测              # 与解释器协同，平衡最优响应时间和最佳执行性能
                执行计数器找出最有编译价值的代码，通知JIT以方法为单位编译
                方法频繁调用或有效循环多，触发标准编译和OSR(栈上替换)
                不用等待本地代码输出就执行，编译时间压力小，可引入更多优化技术，输出更高效本地代码
        KVM                         # 强调简单、轻量、可移植，但运行慢。Android, iOS前手机平台广泛使用
        CDC-HI VM/CLDC-HI VM        # CDC/CLDC(Connected Limited Device Configuration)希望在移动端建立统一java编译接口, 这是它们的参考实现， Java ME的支柱
        Squawk VM                   # 运行于Sun SPOT(small programmable object technology, 一种手持wifi设备)。java本身实现大部分
        JavaInJava                  # 实验，java实现自身元循环(meta-circular), 需要运行在宿主虚拟机上，没有JIT, 解释运行
        Maxine VM                   # 几乎java实现, 有JIT和gc, 没有解释器，宿主或独立运行，效率接近HotSpot Client VM

        BEA JRockit                 # 专注服务器端，不太关心响应时间，没有解释器
            gc和MissionControl领先
        IBM J9 VM                   # IT4J(IBM Technology for Java Virtual Machine), SmallTalk虚拟机扩展而来, 面向各平台，主要应用于IBM产品

        Azul VM                     # HotSpot改进，Azul Systems公司运行于专有硬件Vega
            每个实例管理数十cpu, 数百GB内存，可控gc时间，对硬件优化线程调度
        Zing JVM                    # Azul VM运行于x86平台
        BEA Liquid VM               # 现在的JRockit VE(virtual edition), BEA运行在自己Hypervisor系统上
            实现专用操作系统的必要功能，如文件系统、网络支持
            虚拟机直接控制硬件, 好处如 线程调度不用切换内核态、用户态等
        Apache Harmony              # 虚拟机，兼容Java1.5、1.6, 没得到TCK认证(Technology Compatibility Kit)兼容性测试的授权
            许多代码吸纳进IBM的JDK1.7和Google Android SDK
        Google Android Dalvik VM    # Android平台核心组成部分之一
            不能直接执行class, 执行dex文件可由class文件转化, 可直接使用大部分Java API
            寄存器架构，非栈架构
            Android2.2提供JIT
        Microsoft JVM               # 微软想垄断Java，Sun打官司令开发停止
        其它
            JamVM, cacaovm, SableVM, Kaffe, Jelatine JVM, NanoVM, MRP, Moxie JVM, Jikes RVM

        o->JDK发行版 
        Open JDK
        Oracle JDK
        IBM JDK
    概念
        JDK(java development kit)       # java开发的最小环境
            Java语言
            JVM
            Java API类库
        JRE(java runtime environment)
            JVM
            Java SE API
        平台
            Java Card                        # Applets, 运行在小内存设备
            Java ME(Micro Edition)           # 以前叫J2ME。手机, PDA, 精简API
            Java SE(Standard Edition)        # 以前叫J2SE, 桌面应用, 完整API
            Java EE(Enterprise Edition)      # 企业应用(ERP, CRM), 扩充API(javax包, 有些合入了JavaSE), 部署支持
# JDK
    5
        自动装箱拆箱
        枚举类型
        import static
        可变参数
        内省
        泛型
        for增强
        注解
    6
        AWT新类Desktop、SystemTray
        JAXB2，把Bean变为XML
        StAX XML处理
        Compiler API动态生成class
        Http Server API, 轻量http容器
        Common Annotations补充, Annotations API
        Console类
        脚本语言引擎: js, groovy, ruby
    7
        switch支持String
        泛型推断
            new ArrayList<>()
        AutoCloseable interface，对象销毁时自动调用close()
        FileSystem新方法, 取环境变量
            getJavaIoTempDir()      # IO临时文件夹
            getJavaHomeDir()        # JRE目录
            getUserHomeDir()        # 用户目录
            getUserDir()            # 运行目录
        Boolean加方法
            negate()
            and()
            or()
            xor()
        Character加方法
            equalsIgnoreCase()
        Math加方法，安全计算
            safeToInt()
            safeNegate()
            safeSubtract()
            safeMultiply()
            safeAdd()
        switch case可以匹配String
        数值可下划线, 二进制
            int i = 1_000_000
            int i = 0b1001_1001
        多异常类型
            catch(A|B e){}
        try with resource自动关闭资源
            try (FileInputStream s1 = new FileInputStream(""); FileOutputStream o1 = new FileOutputStream("")) {}
    8
        interface default方法
        lambda表达式
        lambda作用域可访问实际final变量, 可访问对象字段和静态变量 
        函数式接口
            @FunctionalInterface
        函数引用
            Converter<String, Integer> f = Integer::valueOf
            User::new
        Predicate类, Function接口, Supplier接口, Consumer接口, Comparator接口, Optional接口
        Stream接口
            filter()...
            Collection
                stream()
                parallelStream()
        Date API
            Clock
                static systemDefaultZone()
                millis()
                instant()
            Date.from(instant)
            ZoneId
                static getAvailableZoneIds()
                static of()
                getRules()
            LocalTime
                static now()
                static of()
                static parse
                plust()...
            LocalDate
                static parse()
            LocalDateTime
                static of()
                toInstant()...
            ChronoUnit.HOURS.between()
            DateTimeFormatter
                static ofLocalizedTime(FormatStyle.SHORT)
                static ofPattern()
                withLocale(Locale.GERMAN)
        多重注解, 同一注解使用多次
            @Repeatable
    9
        JDK模块化加载，瘦身
        AOT(Ahead of Time Compilation)
        接口私有方法
        jshell
        try with resource改进
            FileInputStream s1 = new FileInputStream("");
            FileOutputStream o1 = new FileOutputStream("");
            try (s1;o1){}
        下划线不能单独成为变量名，后续会成为关键字
        String从char[]改为byte[]
        stream加强，集合加强
            list.of()
            map.of()
            copyof()
    10
        引入var, 只能声明局部变量
            var a = "a";
    11
        直接运行源码
            java a.java
        String
            strip()             # 可去除unicode空白字符
            isBlank()           # 长度为0或空格
            repeat(4)           # 重复4次生成新串
        lambda var类型推断
            (var a) -> a
        Optional加强
        InputStream
            transferTo()
        HTTP Client API
    12
        switch多值（preview）
            switch(a) {
                case 1,2,3 -> a;
            }
    13
        switch返回值(preview)
            String s = switch(a) {
                case 1 -> "a";
            }
        文本块(preview)
            String s = """
                abc
                """;
    14
        instanceof模式匹配(preview)
            if (o instanceof Integer i){
                i++;
            }
        空指针定位到对象        # a().b().c的情况
            -XX:+ShowCodeDetailsInExceptionMessages
        record类型(preview)
            public record User(String name, Integer age){}
        jpackage
    15
        sealed类(preview), 限制子类继承
            public sealed class Animal permits Cat, Dog {}
            public final class Cat extends Animal {}
            public sealed class Dog extends Animal permits Husky {}
            public final class Husky extends Dog {}
        CharSequence interface添加default isEmpty()
        TreeMap添加方法
            putIfAbsent()
            computeIfAbsent()
            computeIfPresent()
            compute()
            merge()
        正式版: 文本块
    16
        包装类编译时警告
            Integer i = new Integer(1)
            synchronized(i){}
        获取AM或PM
            DateTimeFormatter.ofPattern("B").format(LocalDateTime.now())
        InvocationHandler添加方法
            invokeDefault()     # 调interface default方法
        JVM优化: ZGC并发栈处理，弹性metaspace
        Stream
            toList()
        正式版: record类型、instanceof模式匹配、jpackage
    17, LTS版
        去掉AOT、GraalVM的JIT
        switch模式匹配(preview)
            switch(a) {
                case B b -> b.b();
                case null -> ;
            }
        伪随机数增加interface, 用于使用stream
            RandomGeneratorFactory
            RandomGenerator, 由Random和ThreadLocalRandom继承

        正式版: sealed类
    21, LTS版
# 命令与工具
    bin
        javac           #  编译器
        java            #  解释器
            -jar a.jar
                --spring.config.location=/application.yml 
                --spring.profiles.active=prod 
                    # 指定spring config
                -Xmx2g
                -Dserver.port
                    # 覆盖properties
        javadoc         #  生成HTML格式的帮助文档
            javadoc -d docs -sourcepath src/ -subpackages com.ryx -author
        jdb             #  java调试器
        javah           #  反编译成c头文件
        javap           #  反编译成java文件
        jar             #  打包工具
            打包标签
                把包目录和class类放到jnb目录
                jnb/META-INF/tld文件添加<uri>http:# www.xxx.com</uri>
                jar cvf jnb.jar *
            jar cvfm ul.jar manifest.mf com
        native2ascii    #  转换为unicode编码
        serialver       #  返回指定类的序列化号serialverUID
        appletviewer    #  小程序浏览器，执行HTML文件上java小程序类
        htmlconverter   #  转换applet tags成java plug-in
        javap           # 反编译
        jad             # 反编译
            jad -o -a d.java Xxx.class
        jps                                 # 查java进程
        jinfo                               # 输出、修改opts
        jstat                               # 性能分析
            -option                         # 查看分析项
            -class                          # 加载class的数量
            -compiler                       # 实时编译数量
            -gc                             # gc次数，时间
            -gccapacity                     # gc占量: young、old、perm
            -gcnew                          # new对象数量
            -gcnewcapacity                  # new对象占量
            -gcutil                         # gc统计
        jmap                                # 内存分配
        jconsole                            # 图形统计：heap, threads, classes, cpu, VM summary
        jstack                              # 查看线程(如死锁),得到java stack和native stack
    工具
        MAT (Memory Analyzer)
            # eclipse MAT插件分析dump文件
        JProfiler
            # 图形化全面性能分析
    常见场景
        分析GC效果，内存泄漏
            jstat -gcutil -t -h8 [pid] 1000
        dump内存
            jmap -dump:live,format=b,file=heap.bin [pid]
        查死锁
            jstack |grep deadlock            # deadlock会列在最后
        CPU占用
            top
            top -Hp [pid]
            printf '%x' [tid]
            jstack [pid] | grep [16进制tid] -A 10
# 语法
## 基础
    类型
        基本类型
            # 作为面向对象语言，为了方便引入了基本类型
            boolean 1或4字节
                # 没有定义类型的字节码，跟据jvm实现有时用int代替
                # 据说[]boolean是1个，boolean直接用int类型是4个
            byte  1个字节
            short 2个字节
            char  2个字节
                # gbk, gb2312这种2字节编码，一个汉字存一个char。utf-8一个字用3字节
            int   4个字节
            long  8个字节
            float 4个字节
            double 8个字节
        包装类型
            # 不可变(immutable)类
            Boolean, Byte, Short, Character, Integer, Long, Float, Double
            享元
                Integer i1 = 120, i2 = 120, i3 = 130, i4 = 130;
                i1 == i2; i3 != i4
                    # 数字小于1字节(-128 -- 127)后 , 内部存在IntegerCache中,这是一种享元模式
            自动折装箱(java5)
                Integer iObj = 3;        # 装箱
                iObj + 12;            # 折箱
        字符串
            # 不可变(immutable)类, 用cahr数组实现
            字面量处理 String str = "abc"
                # String s = new String("abc") 放堆里
                定义引用变量str
                栈中查找"abc", 有则返回地址，没有则开辟地址，再创建String对象，对象指向该地址, 该地址标记对象引用
                    # 放在栈的静态区(static segement)里
                str指向地址, 所以str保存了一个指向栈中数据的引用
            "a"+"b" 会编译成使用StringBuilder
                # 循环中会重复创建
        泛型
            字面量
                Map<String, Integer> a = new HashMap<>();               # 后面的菱形操作符做了类型推断
                f(new HashMap<>)                                        # 传值使用菱形操作符

    引用
        强引用(strong reference)
            String s = new String("")
        软引用(soft reference)     # 内存不足时回收
            # 用来实现内存敏感的高速缓存, 如object-cache，为了能cache又不会内存不足
            SoftReference<String> softRef = new SoftReference<String>(s)
            回收
                将softRef引用referent(s)设为null，不再引用new String("")
                new String("")设置为可结束(finalizable)
                new String("")运行finalize(),空间释放。softRef添加到它的ReferenceQueue(如果有)
        弱引用(weak reference)     # 表示可有可无, gc扫描到随时回收
            WeakReference<String> weakRef = new WeakReference<String>(s)
        虚引用(PhantomReference)   # 形同虚设，像没引用，用来跟踪垃圾回收活动
            ReferenceQueue<String> queue = new ReferenceQueue<>()
            PhantomReference<String> phantomRef = new PhantomReference<String>(s, queue)
            # 必须和ReferenceQueue联合使用
            # 可以通过判断ReferenceQueue是否有虚引用，来了解被引用对象是否将要被回收
    修饰
        volatile    # 类型修饰符，告诉jvm该变量在寄存器/工作内存中值是不确定的
            # 没有原子性
            # 不会造成线程阻塞
            # 读性能几乎不变，写稍慢，因为插入内存屏障来保证不乱序执行
            对所有线程可见(可见性，线程的修改对其它线程可见)
                # 跳过cpu cache，新值立即同步到内存, 使用前从内存刷新
            禁止编译器指令重排序优化
        synchronized    # 锁当前变量、方法、类，只有当前线程可用
            # 保证可见性和原子性
    语句
        ==
            # 基础类型比较数值，引用类型比较地址
        +1 与 += 1
            short s1 = 1; s1 = s1 + 1   # 出错，类型变为int
            s1 += 1     # 相当于 s1 = (short)(s1 + 1)
        + ""    # 编译成StringBuilder实现
        goto和const是保留字但没有使用
        标签
            label1:
            for(; true; ) {
                break lable1;
                // continue lable1;
            }
        增强for循环(1.5)
            for(int i : args){
                sum += i;
            }
        同步
            public synchronized void synMethod(){}
            synchronized(a1){}
        switch
            expr类型
                1.5前只能byte, short, char, int
                1.5可以枚举
                1.7可以String
                long目前不可以
    表达式
        java赋值语句返回被赋值的对象
        & 与 &&
            &是 按位与，逻辑与(后面会计算)
            &&是 短路与
        | 与 ||
            # 同上
        lambda表达式                                                     # 为了便于并行编程, 提高语法的抽象级别
            字面量
                () -> o.f()
                () -> {
                    o.f()
                }
                event -> o.f()
                (x, y) -> x + y
                (Long x, Long y) -> x + y

                f(O::f1)                                                # 简化 f((o) -> o.f1())
            类型
                Predicate<T>
                    Predicate<String> condition = (s) -> s.length() > 4);
                    if (condition.test(s)) {}

                    Predicate<String> a = (s) -> s.length() > 1; b = (s) -> s.length() > 2;
                    Predicate<String> c = a.and(b)
                Consumer<T>
                Function<T, R>
                Supplier<T>
                UnaryOperator<T>
                BinaryOperator<T>
            特点
                参数类型推断
                作为匿名内部类
                    button.addListener(event -> o.f())
                引用外部变量时，不一定声明final, 但要是即成事实(effectively)的final变量(不能重复赋值)
                重载解析参数类型时，找最具体类型。
                    无法推断时报错, 如                                    # 重定义方法名或传入时做强转
                        f(Predicate<Integer> p)
                        f(IntPredicate p)
    声明
        静态导入(1.5)
            import static java.lang.Math.max
            import static java.lang.Math.*
                # 导入的是方法，该方法就可以直接使用
    方法
        修饰
            开放性
                修饰符     当前类     同包      子类      其他包
                public       √        √        √          √
                protected    √        √        √
                无           √        √
                private      √
            default修饰接口默认方法(虚方法)
        方法参数都是值传递，无法改变外部的参数本身
        可变参数(1.5)
            public void sum(int x, int... args)
        static方法初始化先于构造方法
        overload与override
            重载
                父类、同类、子类中比较
                方法名一致，入参有变化
                返回值不影响
                    # 为副作用调用时(忽略返回值)考虑
                修饰符、异常声明不影响
            重写
                入参，出参一致
                构造方法、final方法不能被重写
                static方法不能被重写，可再次声明
                访问权限不能缩小
                异常声明不扩大，可加非强制异常
        finally
            # return前走finally, catch块中也一样
    类
        字面量
            public class A {{
                ...
            }}
                这是匿名构造函数，相当于:
                    public class A {
                        public A() {
                            ...
                        }
                    }
        接口
            不能定义构造函数
            只定义抽象方法
            类成员全部public
            定义的实际上都是常量
            不能定义静态方法
            类可实现多接口
            函数接口，接口声明默认方法
            default方法
                Collection中添加stream()会打破前版本二进制兼容性(原版本找不到stream而报错)，默认方法指定找不到时使用的方法, 维护兼容性
                可被其它接口继承重写
                多重继承
                    继承代码块，不继承类状态(属性)                         # 有些人认为多重继承的问题在于状态的继承
                    冲突报错, 可子类重写解决
                优先级: 子类 > 类 > 接口
        抽象类
            # 有抽象方法的类
            可定义构造函数
            可定义抽象方法和具体方法
            成员可以是private, default, protected, public
            可定义成员变量
            可定义静态方法
            类只继承一个抽象类
        接口与抽象类
            不能实例化
            可作为引用类型
            继承的类要实现所有抽象方法，否则还是抽象类
        抽象方法
            不能static，static方法不能被重写
            不能native，native需要实现
            不能synchronized，synchronized表示一种实现方式
        静态变量
            # 实例变量属于对象实例，有多个
            属于类，只有一个，实现共享内存
        内部类
            静态嵌套类(static nested class), 可不依赖外部类实例被实例化
            内部类，外部类实例化后才能实例化
                new Outer().new Inner()     # 在Outer类中也不能new Innter()
    注解
        @FunctionalInterface                        # 检查是否符合函数接口标准
    安全性
        安全沙箱机制
            类加载体系
            .class文件检验器
            JVM及语言的安全特性
            安全管理器与java api

## 异常
    异常机制
        运行时出现错误，控制权交给异常处理器
        方法立即结束，抛出一个异常对象。调用该方法的程序停止，搜索处理代码

    Throwable
        Error
            # JVM相关问题，如系统崩溃、虚拟机错误、内存不足、方法调用栈溢出
        Exception
            # 指可处理的异常
            RuntimeException
                # 非强制(unchecked)。除RuntimeException都是强制异常(checked)
    Error
        java.lang.OutOfMemoryError      # 内存溢出
        java.lang.StackOverflowError        # 堆溢出

    运行时异常
        ArithmeticExecption     # 算术异常类
        IllegalArgumentException    # 方法传递参数错误
        NullPointerException        # 空指针异常类
        ClassNotFoundException  # 类找不到，加载路径错误
        ClassCastException      # 类型强制转换异常
        NoClassDefFoundException    # 未找到类定义
        ArrayIndexOutOfBoundsException      # 数组越界异常
        ArrayStoreException      # 数组存储异常，操作数组时类型不一致
        BufferOverflowException     # 缓冲溢出异常
        NegativeArrayException      # 数组负下标异常
        NoSuchMethodException       # 方法未找到异常
        IllegalStateException     # servlet过滤器中 chain.doFilter中request,response类型为ServletRequest，ServletResponse时出错
        NumberFormatException   # 字符串转换为数字异常
        SQLException        # sql语句出错
        InstantiationException      # 实例化异常
        DateTimeException   # 无效时间

    强制异常
        FileNotFoundException       # 文件未找到异常
        ParseException      # 解析时间字符串到时间类型出错
        ServletException        # servlet转发时出现过该异常
        IOException     # io异常
        java.sql.BatchUpdateException       # sql批处理
        com.mysql.jdbc.MysqlDataTruncation      # mysql 插入数据被截断,插入数据过长时遇到


## 注解
    # annotation (1.5特性)
    jdk的注解
        @SuppressWarnings("deprecation")        # 压制警告
            # SuppressWarning不是一个标记注解。它有一个类型为String[]的成员，
            # 参数如下
            all to suppress all warnings
            boxing to suppress warnings relative to boxing/unboxing operations
            cast to suppress warnings relative to cast operations
            dep-ann to suppress warnings relative to deprecated annotation
            deprecation to suppress warnings relative to deprecation
            fallthrough to suppress warnings relative to missing breaks in switch statements
            finally to suppress warnings relative to finally block that don’t return
            hiding to suppress warnings relative to locals that hide variable
            incomplete-switch to suppress warnings relative to missing entries in a switch statement (enum case)
            nls to suppress warnings relative to non-nls string literals
            null to suppress warnings relative to null analysis
            rawtypes to suppress warnings relative to un-specific types when using generics on class params
            restriction to suppress warnings relative to usage of discouraged or forbidden references
            serial to suppress warnings relative to missing serialVersionUID field for a serializable class
            static-access to suppress warnings relative to incorrect static access
            synthetic-access to suppress warnings relative to unoptimized access from inner classes
            unchecked to suppress warnings relative to unchecked operations
            unqualified-field-access to suppress warnings relative to field access unqualified
            unused to suppress warnings relative to unused code

        @Deprecated                             # 标记过时
        @Override
    元注解(metadata)
        @Retention(RetentionPolicy.RUNTIME)
            # 保留策略 CLASS、RUNTIME和SOURCE这三种，分别表示注解保存在类文件、JVM运行时刻和源代码阶段
            # 只有当声明为RUNTIME的时候，才能够在运行时刻通过反射API来获取到注解的信息。
        @Target用来声明注解作用目标，如类型、方法和域等。如
            @Target(ElementType.TYPE)  //接口、类、枚举、注解
            @Target(ElementType.FIELD) //字段、枚举的常量
            @Target(ElementType.METHOD) //方法
            @Target(ElementType.PARAMETER) //方法参数
            @Target(ElementType.CONSTRUCTOR)  //构造函数
            @Target(ElementType.LOCAL_VARIABLE)//局部变量
            @Target(ElementType.ANNOTATION_TYPE)//注解
            @Target(ElementType.PACKAGE) ///包
        @Document：说明该注解将被包含在javadoc中
        @Inherited：说明子类可以继承父类中的该注解
    自定义注解
        # @interface用来声明一个注解
        ## 其中的每一个方法实际上是声明了一个配置参数。方法的名称就是参数的名称，返回值类型就是参数的类型。可以通过default来声明参数的默认值。
        @Retention(RetentionPolicy.RUNTIME)
        @Target(ElementType.TYPE)
        public @interface Assignment {
            String assignee();
            int effort();
            double finished() default 0;
        }
## 版本特性
    java8
        接口中可以定义静态方法与默认方法
            不能重写equals，hashCode或toString的默认实现。
        Lambdas
            # Lambda更好地利用多核处理器
            与匿名内部类
                匿名内部类编译成.class文件，lambda表达式编译成私有方法, 使用invokedynamic(java7)字节码指令动态绑定
                    private static java.lang.Object lambda$0(java.lang.String)
                匿名内部类this指向该匿名内部类, lambda的this总指向所有的外部类
            内部变量
                可以使用静态、非静态局部变量
                只能引用final和局部变量，不能修改外部变量     # 不可变闭包
            注解
                @Functionalnterface     # 函数式接口
                    有且公有一个抽象方法      # SAM(single abstract method)
                    允许定义静态方法、默认方法、Object中的public方法
                    不是必须的，接口符合以上定义就算函数式接口
            函数
                (int x, int y) -> { return x + y; }
                Runnable r = () -> { System.out.println("Running!"); }
            SAM
                new Thread(() -> System.out.println(""))
                    # Thread有单个抽象方法run()
            列表
                list1.forEach(System::out::println)
        java.util.function包
            # 声明于function包内的接口可接收lambda表达式
            Predicate
            Stream
        Optional
        Jigsaw
            # jdk上的模块系统，使大块的代码更易于管理

    java7
        switch中可以使用字符串了
        运用List<String> tempList = new ArrayList<>(); 即泛型实例化类型自动推断
        语法上支持集合，而不一定是数组
            final List<Integer> piDigits = [ 1,2,3,4,5,8 ];
        map集合支持并发请求，且可以写成
            Map map = {name:"xxx",age:18};
    java6
        ui增强
            Java应用程序可以和本地平台更好的集成
        web service支持增强：jax-ws2.0与jaxb2.0
            优先支持编写 XML web service 客户端程序。
            用过简单的annotaion将你的API发布成.NET交互的web services.
        jdbc4.0
        Scripting可以在Java源代码中混入JavaScript

    java5
        泛型，允许指定集合里元素的类型
        枚举类型
        自动类型包装和拆包
        可变参数
        注解
        增强for循环
        静态引入
        新的线程模型与并发库
            HashMap的替代者ConcurrentHashMap
            ArrayList的替代者CopyOnWriteArrayList

# api
## Object
    clone()
        # 开始与new相同分配内存, 然后填充对象的域。是浅拷贝
        深拷贝
            class Body implements Cloneable {
                @Override
                protected Object clone() throws CloneNotSupportedException {
                    body = (Body) super.clone()
                    body.head = (Head)head.clone()
                    return body
                }
            }
    equals()
        # 具有自反性、对称性、传递性、一致性
        # 先确定hashCode一致，equals相等的对象hashCode一定相等
        # 没重写时比较地址
        重写equals
            1 == 检查是否引用
            2 instanceof 检查类型
            3 属性是否匹配
            4 是否满足对称性、传递性、一致性
            5 总要重写hashCode
    finalize()
        # 垃圾收集时调用
    valueOf()   # 转换成自己类型
    wait()
    notify()
    notifyAll()
## 系统
    System
        currentTimeMillis();
            # Clock.systemDefaultZone().millis()  # java8
        arraycopy()
    File
        String[] list()            # 列出目录下的所有文件名
        String[] list(FilenameFilter filter)            # 列出目录下符合filter规范的文件名（filter用匿名内部类定义）
    Scanner
        next()
            例如：
            Scanner input = new Scanner(System.in);
            int data = input.nextInt();
            System.out.println(data);
        得到继承结构
            StackTraceElement [] stackTraces = new Throwable().getStackTrace();
            for(StackTraceElement temp : stackTraces){
            temp.getClassName()
            temp.getFieldName();
            temp.getMethodName();
            }
    Cloneable接口
        clone()
## 包装类型
    parseXxx(String)    # 从字符串转换
    valueOf(String)     # 从字符串转换
## String
    # final类，不可继承
    length()
        # String length是方法, 数组length是属性
    isEmpty()
    indexOf()
    lastIndexOf()
    chatAt()
    substring()
    trim()
    toLowerCase()
    toUpperCase()
    split()
    getBytes()
    replaceAll()
        String p = "A0A1A2".replaceAll("([A-Z]{1,1})([A-Z0-9]{1,1})?", "$1=$2 ");
        # A=0 A=1 A=2
        ## $符是组的概念，与"([A-Z]{1,1})([A-Z0-9]{1,1})?"中的两对括号代表两组
        ## {1,1}代表匹配1次, (从1次到1次)
        replaceAll("[A_Z]", "_$0")            # 分组匹配被替换的值到替换字符串中

    类
        StringBuffer
            # 线程安全
            append()
            insert()
        StringBuilder
            # 1.5引入
        intern()
            # 返回常量池中的引用(String对象equals池中某对象为true)，没有时添加
### 正则
    Pattern
    [abc]
    [^abc]
    [a-zA-Z]
    [a-z&&[def]]
    [a-z&&[^bc]]    =    [ad-z]
    [a-z&&[^m-p]]    =    [a-lq-z]
    .除了换行符之外的任意字符
    \d    [0-9]
    \D    [^0-9]
    \s    [ \t\n\x0B\f\r]
    \S    [^\s]
    \w    [a-zA-Z_0-9]
    \W    [^\w]

    posix的字符
    \p{Lower}        [a-z]
    \p{Upper}        [A-Z]
    \p{ASCII}        [\x00-\x7F]
    \p{Alpha}        [\p{Lower}\p{Upper}]
    \p{Digit}        [0-9]
    \p{Alnum}        [\p{Alpha}\p{Digit}]
    \p{Punct}        !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~    之一
    \p{Graph}        [\p{Alnum}\p{Punct}]所有可见字符
    \p{Print}        [\p{Graph}\x20]    \x20为空格
    \p{Blank}        [ \t]    一个空格或tab
    \p{Cntrl}        [\x00-\x1f\x7f]    控制字符
    \p{XDigit}        [0-9a-fA-F]    十六进制符号
    \p{Space}        [ \t\n\x0B\f\r]

    代表边界的字符
    ^        行首
    $        行尾
    \b        A word boundary
    \B        A non-word boundary
    \A        input的开始
    \G        The end of the previous match
    \Z        The end of the input but for the final terminator,if any
    \z        The end of the input

    Greedy 定量
    X?        0或1个
    X*        0或多个
    X+        1或多个
    X{n}        n个
    X{n,}    最少n个
    X{n,m}    n到m，包含n,m

    Logical operators
    XY        XY
    X|Y        X或Y
    (X)        捕获的匹配
    \n        得到第n个捕获

    Quotation
    \        Nothing, but quotes the following character
    \Q        Nothing, but quotes all characters until \E
    \E        Nothing, but ends quoting started by \Q

    Special constructs (non-capturing)
    (?某某)

    * 方案
    * 任意字符

        [\S\s]        # 匹配空格或非空格，就是任意一个字符
            ## [\W\w] 相同

    * 匹配多个
        Pattern p1 = Pattern.compile("\\(.*?\\)");
            Matcher m1 = p1.matcher("kjdjdjj(738383)ddk(9999)ppp");
            while (m1.find()) {
                System.out.println(m1.group().replaceAll("[()]", ""));
            }

## Math
    round
        # 四舍五入, -11.5得到11
## 时间
    java8的新时间类实现JSR-310
        特点
            不变性, 内部状态不变、线程安全
            关注点分离，定义了不同的类：Date, Time, DateTime, timestamp, 时区
            策略模式，所有类定义format()和parse()方法
            实用方法，所有类定义了方便操作的方法
            扩展性，使用ISO-8601日历系统，也可扩展在其它系统
        包
            java.time       # 基础包
            java.time.chrono     # 非ISO日历系统的泛化api
            java.time.format    # 格式化和解析，基本不用(基础包有封装)
            java.time.temporal  # 时态对象，用来改变时间
            java.time.zone      # 时区相关类
        JSR-310
            精确到纳秒
            对应人类观念，也不是像Date一样用零点时间表示日期
            大部分基于Joda-Time，区别：
                包名从org.joda.time到java.time
                不接受null值，Joda-Time视null为0
                机器用Instant和人用DateIme接口差别更明显
                所有异常继承DateTimeException
        方法
            Of  # 静态工厂
            parse   # 静态解析
            get
            is
            with    # 设置时间，不可变
            plus
            minus
            to      # 转换类型
            at      # 组合对象
    Calendar
        getInstance()
        get(Calendar.YEAR)   # YEAR, MONTH, DATE, HOUR_OF_DAY, MINUTE, SECOND
        getTimeInMillis()   # 时间戳，毫秒
        getTime()
        set()   # 设置到时间
        使用
            Calendar c = Calendar.getInstance()
            c.set(Calendar.DAY_OF_MONTH, 1)     // 月第一天
            c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH))     // 月最后一天
            System.out.println(format.format(c.getTime(0))
            c.add(Calendar.DATE, -1)    // 昨天
    SimpleDateFormat
        format(Date)
        使用
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd")
            System.out.println(formatter.format(new Date()))
    LocalDate     # java8, 默认格式(yyyy-MM-dd)
        now()
            LocalDate.now()
            LocalDate.now(ZoneId.of("Asia/Kolkata"))   // 时区时间
        of()    # 指定时间
        ofEpochDay()  # 纪元日(1970.1.1)后多少天
        ofYearDay()   # 年后多少天

        minusDays()
            today.minusDays(1)  # 昨天
        isLeapYear()    # 闰年
        isBefore()  # 比较大小
        atTime()    # 返回LocalDateTime
        plusDays()
        plusWeeks()
        plusMonths()
        minusDays()
        minusWeeks()
        minusMonths()
        with()      # 定位时间
            today.with(TemporalAdjusters.irstDayOfMonth())
            today.with(TemporalAdujsters.lastDayOfYear())
        until()     # 返回Period
        使用
            LocalDate today = LocalDate.now()
            LocalDate firstday = LocalDate.of(today.getYear(), today.getMonth(), 1)     // 月第一天
            LocalDate lastDay = today.with(TemporaAdjusters.lastDayOfMonth())       // 月最后一天
            System.out.println(lastDay)
    LocalTime     # java8, 默认格式(hh:mm:ss.zzz)
        now()
        of()
        ofSecondOfDay()     # 从0开始多少秒后
    LocalDateTime   # java8，默认格式(yyyy-MM-dd-HH-mm-ss.zzz)
        now()
        of()
            LocalDaeTime.of(LocalDate.now(), LocalTime.now())
            LocalDateTime.of(2014, Month.JANUARY, 1, 10, 10, 30)
        ofEpochSecond()
        ofInstant()
        parse()     # 按格式parse字符串
            LocalDateTime.parse("27::Apr::2014 21::39::48", DateTimeFormatter.ofPattern("d::MMM::uuuu HH::mm::ss"))

        getYear()
        getMonthValue()
        getDayOfMonth()
        getHour()
        getMinute()
        getSecond()
        minusDays()
        plush()
    ZonedDateTime
        now()
        parse()
            ZonedDateTime.parse("2013-12-31T23:59:59Z[Europe/Paris]")
    Clock     # java8
        systemDefaultZone()
        systemUTC()
        system(ZoneId.of("Europe/Paris"))
        fixed(Instant.now(), ZoneId.of("Asia/Shanghai"))    # 固定时区
        offset(c1, Duration.ofSeconds(2))   # 偏移

        millis()        # 时间戳
    Instant     # java8, 机器可读格式，精确到纳秒
        now()
            now(clock1)     # 得到瞬间时间
        ofEpochMilli

        toEpochMilli()
        getEpochSecond()
    Duration        # java8, 时间段
        between()
        ofDays()

        toDays()
        toHourse()
    Period      # java8
        getMonths()     # 算成月数
    DateTimeFormatter   # java8
        BASIC_ISO_DATE
        ofPatter()
        使用
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd")
            System.out.println(LocalDate.now().format(formatter))
    Chronology  # java8 年表
        localDateTime(LocalDateTime.now())

        类
            HijrahChronology
                INSTANCE
    新旧转换
        // Date, Instant, LocalDateTime
        Instant timestamp = new Date().toInstant()
        LocalDateTime date = LocalDateTime.ofInstant(timestamp, ZoneId.of(ZoneId.SHORT_IDS.get("PST")))
        Date date = Date.from(Instant.now())

        // Calendar, Instant
        Instant time = Calendar.getInstance().toInstant()

        // TimeZone, ZoneId
        ZoneId defaultZone = TimeZone.getDefault().toZoneId()
        TimeZone timeZone = TimeZone.getTimeZone(defaultZone)

        // GregorianCalendar, ZonedDateTime
        ZonedDateTime gCalendarDateTime = new GregorianCalendar().toZonedDateTime()
        GregorianCalendar gCalendar = GregorianCalendar.from(gCalendarDateTime)

## 数组
    length
        属性
    newInstance()
        泛型数组实例化
            T[] = (T[]) new Object[0];
            (T[]) Array.newInstance(type, size);

## 枚举
    # 枚举类型的比较取决于声明顺序
    举类的实现类
        java.lang.Enum<E> extends Object
            static <T extends Enum<T>> T valueOf(Class<T> enumType, String name)

        javax.lang.model.element.ElementKind extends java.lang.Enum<ElementKind>
            # 实际创建枚举类型时继承的类
            # 此类的静态方法不是Enum本身的方法，所以它们在java.lang.Enum的javadoc中没有出现。
            static ElementKind valueOf(String name)
                # 为提供的字符串返回一个枚举类型，该枚举类型必须精确地匹配源代码声明。
            static ElementKind[] values()
                # 返回一个枚举类型所有可能值的数组。

    定义1
        public enum Color {
        RED, GREEN, BLANK, YELLOW
            # 元素列表必须在最前, 如果元素列表后面没有东西的话，可以省略分号
            // 枚举的构造方法必须是私有的
            // private WeekDay() {
            //}
        }

    定义2
        enum Signal {
        GREEN, YELLOW, RED
        }

    定义3
        自定义构造（要注意必须在enum的实例序列最后添加一个分号）
        public enum Color {
            RED("红色", 1), GREEN("绿色", 2), BLANK("白色", 3), YELLO("黄色", 4);
            // 成员变量
            private String name;
            private int index;
            // 构造方法
            private Color(String name, int index) {
                this.name = name;
                this.index = index;
            }
            // 普通方法
            public static String getName(int index) {
                for (Color c : Color.values()) {
                if (c.getIndex() == index) {
                    return c.name;
                }
                }
                return null;
            }
            // get set 方法
            public String getName() {
                return name;
            }
            public void setName(String name) {
                this.name = name;
            }
            public int getIndex() {
                return index;
            }
            public void setIndex(int index) {
                this.index = index;
            }
        }
    使用
        public enum TrafficLamp {
            RED(30) {

                @Override
                public TrafficLamp nextLamp() {
                    return GREEN;
                }
            },
            GREEN(45) {
                @Override
                public TrafficLamp nextLamp() {
                    return YELLOW;
                }
            },
            YELLOW(5) {
                @Override
                public TrafficLamp nextLamp() {
                    return RED;
                }
            };
            public abstract TrafficLamp nextLamp();

            private int time;

            private TrafficLamp(int time) {
                this.time = time;
            }
        }
        @Test
        public void testHere() {
            WeekDay weekDay = WeekDay.MON;
            weekDay.toString();
            weekDay.name();
            // 排行
            weekDay.ordinal();
            WeekDay.valueOf("SUN");
            WeekDay.values();
        }
    自己实现
        public abstract class WeekDay {
            private WeekDay() {
            };

            /*
            * public WeekDay nextDay(){ if(this == SUN){ return MON; }else { return
            * SUN; } }
            */

            public abstract WeekDay nextDay();

            public final static WeekDay SUN = new WeekDay() {

                @Override
                public WeekDay nextDay() {
                    return MON;
                }
            };
            public final static WeekDay MON = new WeekDay() {

                @Override
                public WeekDay nextDay() {
                    return SUN;
                }
            };

            @Override
            public String toString() {
                return this == SUN ? "SUN" : "MON";
            }
        }
    使用接口组织枚举
        public interface Food {
        enum Coffee implements Food{
            BLACK_COFFEE,DECAF_COFFEE,LATTE,CAPPUCCINO
        }
        enum Dessert implements Food{
            FRUIT, CAKE, GELATO
        }
        }
    用switch判断
        # JDK1.6之前的switch语句只支持int,char,enum类型
        enum Signal {
        GREEN, YELLOW, RED
        }
        public class TrafficLight {
        Signal color = Signal.RED;
        public void change() {
            switch (color) {
            case RED:
            color = Signal.GREEN;
            break;
            case YELLOW:
            color = Signal.RED;
            break;
            case GREEN:
            color = Signal.YELLOW;
            break;
            }
        }
        }
    枚举的集合
        java.util.EnumSet    # 集合中的元素不重复
        java.util.EnumMap    # key是enum类型，而value则可以是任意类型。
## Collection
    继承结构
        <<Collection>>
            <<Queue>>
                PriorityQueue
                <<Deque>>
                    ArrayDeque
            <<List>>
                ArrayList
                LinkedList  # 实现<<Deque>>
                Vector
                    Stack
            Set
                HashSet
                EnumSet
                <<SortedSet>>
                    TreeSet
        <<Map>>
            HashMap
            LinkedHashMap
            <<SortedMap>>
                TreeMap
    Arrays
        fill()                      # 赋初值
        asList()                    # 数组转List
        sort()
        binarySearch()
        equals()                    # 数组比较
        parallelPrefix()            # 前值和，如0, 1, 2, 3 处理后为 0, 1, 3, 6。
        parallelSetAll()            # 修改值
        parallelSort()
    ArrayList
        # 用数组实现，查询快，增删慢
        toArray() # 返回list中的所有元素作为一个Object []
        toArray(T[] a)  # 返回泛型类型的list中的所有元素

        trimToSize()    # 优化掉删除出现的空位

        stream()
        parallelStream()  # 并行流
        实现
            public ArrayList() {
                array = EmptyArray.OBJECT;
            }
            public ArrayList(int capacity) {
                if (capacity < 0) {
                    throw new IllegalArgumentException("capacity < 0:" + capacity);
                }
                array = (capacity == 0 ? EmptyArray.OBJECT : new Object[capacity]);
            }
            public ArrayList(Collection<? extends E> collection) {
                if (collection == null) {
                    throw new NullPointerException("collection == null");
                }

                Object[] a = collection.toArray();
                if (a.getClass() != Object[].class) {
                    Object[] newArray = new Object[a.length];
                    System.arraycopy(a, 0, newArray, 0, a.length);
                    a = newArray;
                }
                array = a;
                size = a.length;
            }
            @Override
            public boolean add(E object) {
                Object[] a = array;
                int s = size;
                if (s == a.length) {
                    Object[] newArray = new Object[s +
                    (s < (MIN_CAPACITY_INCREMENT / 2) ?
                    MIN_CAPACITY_INCREMENT : s >> 1)];
                System.arraycopy(a, 0, newArray, 0, s)
                array = a = newArray;
                }
                a[s] = object;
                size = s + 1;
                modCount++;     // 修改次数
                return true;
            }
            @Override
            public E remove(int index){
                Object[] a = array;
                int s = size;
                if (index >= s) {
                    throwIndexOutOfBoundsException(index, s);
                }
                @SuppressWarnings("unchecked")
                E result = (E) a[index];
                System.arraycopy(a, index + 1, a, index, --s - index);
                a[s] = null;
                size = s;
                modCount++;
                return result;
            }
            @Override
            public void clear() {
                if (size != 0) {
                    Arrays.fill(array, 0, size, null);
                    size = 0;
                    modCount++;
                }
            }
    LinkedList
        # 循环双向链表实现，增删快，查询慢

        类
            Entry
    Vector
        # 数组实现，线程安全，增删慢，查询慢

    HashMap
        # hash表实现，支持null的键和值
        实现
            数组存Entry, 位置称为bucket
            Entry为元素，单链表拉链解决碰撞
            hashcode(key)得到bucket索引
            扩容要rehash
        类
            Entry

        computeIfAbsent()                                               # 无值时用计算新值
        forEach()
    LinkedHashMap
        # 继承HashMap，hash表和链表实现，保存了插入顺序
    HashTable
        # 线程安全，不支持null的键和值
    TreeMap
        # 红黑树实现，有序，实现SortedMap接口

    HashSet
        # HashMap实现，有时需要重写equals()和hashCode()
        # HashSet先按hashCode分区, 后比较equals的值再存放。修改参与hashCode值运算的属性后, 该元素删除会因无法定位,导致内存泄漏
    LinkedHashSet
        # 继承HashSet。LinkedHashMap实现
    List、Map、Set区别
        List、Set单列，Map双列
        List有序可重复, 可索引, Map无序，键不重复，值可重复，Set无序，不重复
    Queue
        Queue<String> queue = new LinkedList<String>();
        queue.offer("a");            # 添加
        queue.poll();                # 返回第一个元素并删除
        queue.element();            # 返回第一个元素, empty时抛异常
        queue.peek();                # 同element(), 但empty时返回null
    Collections
        sort(List, Comparator)
        synchronizedCollection()
            # 线程不安全集合方法调用前加锁
        synchronizedList()
        synchronizedMap()
        synchronizedSet()
## 流
    函数流特点
        Iterator是外部迭代，串行化操作。Stream是内部迭代, 自动并行处理
        方法分惰性和及早执行
        有序集合有序处理，无序集合无序处理
    Stream
        of()                                                            # 静态方法，产生流

        forEach()
        collect()                                                       # 用收集器, 转出结构化数据
            collect(Collectors.toList())                                # 转出List
        map()
            map(s -> s.toUpperCase())
        reduce()
            reduce(0, (acc, element) -> acc + element)                  # acc是累加器
        filter()
            filter(s -> isDigit(s.charAt(0)))
        flatMap()                                                       # 平铺多stream
            flatMap(numbers -> numbers.stream())
        min()
            min(Comparator.comparing(track -> track.getLength()))
        max()
        peek()
        get()                                                           # 执行得到结果
        count()

        mapToInt()                                                      # IntStream, LongStream, DoubleStream, 对基本类型做特殊优化(如不装箱占内存)
    IntStream
        range(0, N)
        sequential()                                                    # 串行
        parallel()                                                      # 并行, fork-join结构。注意数据结构(arrayList快于linkedList)。有状态操作会线程通信, 如sorted, distinct, limit
        mapToObj()
        summaryStatistics()
    IntSummaryStatistics
        getAverage()
    Optional
        of("a")
        ofNullable(null)
        empty()

        get()                                                           # 空时抛异常
        isPresent()
        ifPresent((s) -> {})
        orElse("b")                                                     # 空返回b
        orElseGet(() -> "b")
        orElseThrow(ValuesAsentException::new)
        map((s) -> s + "b")                                             # map非空值，返回Optional
        flatMap((s) -> Optinal.of(s + "b"))
        filter((s) -> s.length() > 6)
    Collectors
        toList()
        toSet()
        toCollection(TreeSet::new)
        minBy()
        maxBy()
        averagingInt()
        summingInt()
        partitioningBy()                                                # 按true, false分两组
        groupingBy()                                                    # 分多组
        joining(",", "[", "]")                                          # 拼字符串, 传参是分隔符、前缀、后缀

        o-> 自定义收集器
        public class StringCombiner {
            public StringCombiner add(String element) {
                if (atStart()) {
                    builder.append(prefix);
                } else {
                    builder.append(delim);
                }
                builder.append(element);
                return this;
            }
            public StringCombiner merge(StringCombiner other) {
                builder.append(other.builder);
                return this;
            }
        }
        public class StringCollector implements Collector<String, StringCombiner, String> {
            public Supplier<StringCombiner> supplier(){
                return () -> new StringCombiner(delim, prefix, suffix);
            }
            public BiConsumer<StringCombiner, String> accumulator(){
                return StringCombiner::add;
            }
            public BinaryOperator<StringCombiner> combiner(){
                return StringCombiner::merge;
            }
            public Function<StringCombiner, String> finisher(){
                return StringCombiner::toString;
            }
            characteristics()                                           # 描述特征
        }
        o-> predicate
            void filter(list list, Predicate condition)
            list1.stream().filter((s) -> (condition.test(s))).forEach((s) -> { System.out.println(s)})


    io流分类
        输入、输出
        节点流(如FileReader)、处理流(抽象处理方法)
        字节流(InputStream)、字符流(InputStreamReader)
            字节流处理一个字节，字符流包装字节流，设置编码类型映射成字符，处理字符
    InputStream
        BufferedInputStream
        FileInputStream
    OutputStream
        BufferedOutputStream
        FileOutputStream
    Reader
        InputStreamReader
            FilerReader
        BufferedReader
            readLine()
    Writer
        OutputStreamWriter
            FileWriter
        BufferedWriter
            newLine()
            write(String)
    Serializable接口
        # 对象流化
        需求例如
            spring中配置的bean
            session中用到的类
        为什么实现序列化接口
            为了注册序列化序号（不显式注册会自动注册）来标识java类，区分相同类名不同包名的类
    实现深拷贝
        public static <T extends Serializable> T clone(T obj) throws Exception {
            // 不必调close(), 因为gc时流对象释放
            ByteArrayOutputStream bout = new ByteArrayOutputStream()

            ObjectOutputStream oos = new ObjectOutputStream(bout)
            oos.writeObject(obj)

            ByteArrayInputStream bin = new ByteArrayInputStream(bout.toByteArray())
            ObjectInputStream ois = new ObjectInputStream(bin)

            return (T)ois.readObject()
        }
## 并行
    线程通信
        共享变量
        wait(), notify()实现生产和消费通知
    同步线程
        wait(), sleep(), notify(), notifyAll()
    ThreadLocal
        # 线程内数据共享，线程隔离
        withInitial(() -> new SimpleDateFormat())                       # 直接get()时返回调用结果
        set(T t)                                                        # 向当前线程对象放入泛型对象
        get()                                                           # 得到当前线程已放入的对象

    InheritableThreadLocal<T>
        # 继承ThreadLocal, 子线程可使用父线程变量
    Timer
        o->
        class MyTask extends java.util.TimerTask{
            @Override
            public void run() {
                // TODO Auto-generated method stub
                System.out.println("________");
            }
        }
        Timer timer = new Timer()
        timer.schedule(new MyTask(), 1000, 2000)    // 1秒后执行，每两秒执行一次
        timer.cancel();     // 停止任务
    Thread
        currentThread().getContextClassLoader().getResource("/").getPath()  # 静态路径
        run()
        start()
        sleep() # 占有锁
        o->
            # 异常抛出不到父线程
        new Thread(){
            @Override
            public void run(){
                while(count > 0){
                    synchronized(AboutThread.class){
                        count--;
                    }
                }
            }
        }.start();

        o->
            # 异常抛出不到父线程
        new Thread(new Runnable() {
            @Override
            public void run() {
                while(count > 0){
                    synchronized(AboutThread.class){
                        count--;
                    }
                }
            }
        }).start();

    FutureTask  # java5
        o->
            # 有结果和异常
        FutureTask<String> future = new FutureTask(new Callable<String>(){
            @Override
            public String call() {
                return ""
            }
        })
        new Thread(future).start()
        future.get()
    java.util.concurrent
        Executors   # 线程池工厂
            策略
                1 创建并设置
                2 execute()时
                    1 线程数小于corePoolSize, 创建线程并执行
                    2 线程数大于或等于corePoolSize, 任务入队列
                    3 队列满，线程数小于maximumPoolSize, 创建线程并执行
                    4 队列满，线程数大于maximumPoolSize, 抛出异常
                3 线程完成任务，从队列取任务执行
                4 线程空闲，超过keepAliveTime, 运行线程大于corePoolSize, 线程停掉
            newFixedThreadPool(3)   # 固定数量
                ExecutorService Pool = Executors.newFixedThreadPool(2);
                pool.execute(new MyRunnable())
                pool.shutdown()
            newCachedThreadPool()   # 根据情况创建数量
            newSingleThreadExecutor()   # 数量为1
            newScheduledThreadPool(2)   # 延时
                ScheduledExecutorService pool = Executors.newScheduledThreadPool(2);
                Thread r1 = new MyRunnable();
                pool.execute();
                pool.schedule(r1, 10, TimeUnit.MILLISECONDS);    # t1在10秒后执行
                pool.shutdown();
        <<ExecutorService>>
            execute(Runnable)
            submit(Runnable)        # 返回Future
                # submit(Callable)
            invokeAny()     # 返回执行最快的一个结果
            invokeAll()     # 所有执行结束后返回
            shutdown()  #   只interrupt()空闲线程
            shutdownNow()   # interrupt()所有线程
        ThreadPoolExecutor
            corePoolSize    # 最小数量
            maximumPoolSize # 最大数量
            keepAliveTime   # 线程空闲等待时间
        <<ScheduledExecutorService>>
            schedule(r1, 10, TimeUnit.MILLISECONDS) # 10秒后执行
            scheduleAtFixedRate(r1, 1, 2, TimeUnit.MILLISECONDS)    # 1秒后执行，2秒一次，间隔计算开始时间。异常直接关闭
            scheduleWithFixedDelay(r1, 1, 2, TimeUnit.MILLISECONDS)     # 同上，间隔计算结束时间
        ScheduledExecutorPoolService


        ForkJoinPool    # java7
            ForJoinPool(4)  # 并行级别
            invoke()
        RecursiveAction # 没返回值
            MyRecursiveAction extends RecursiveAction {
                @Override
                protected void compute() {
                    new MyRecursiveAction().fork()
                }
            }
        RecursiveTask   # 有返回值
            MyRecursiveTask extends RecursiveTask<Long> {
                @Override
                protected Long Compute() {
                    MyRecursiveTask t1 = new MyRecursiveTask()
                    t1.fork()
                    retrun t1.join()
                }
            }


        CopyOnWriteArrayList
            # 列表被修改时，使用旧副本(保护性复制)
        <<BlockingQueue>>   # 锁实现，插入和取值阻塞, 不能插入null
            add()   # 抛异常
            offer() # 超时退出，返回特殊值
            put()   # 阻塞
            remove()    # 抛异常
            poll()      # 超时退出，返回特殊值
            take()      # 阻塞
            element()   # 检查，抛异常
            peek()      # 返回特殊值
        ArrayBlockingQueue  # 固定大小
            size()

            o->
            queue.put(new PoisonPill())     # 毒丸, 标志数据取完
            obj.isPoisonPill()
        LinkedBlockingQueue     # 链式
            # 两个ReentrantLock(可重入锁)分别控制元素入队和出队
            # tomcat用TaskQueue的父类，它重写offer方法减少创建多余线程
        PriorityBkockingQueue   # 无界，排序
            # 一个独占锁控制入队和出队, 通过cas(无锁算法)保证同时只有一个线程扩容成功
        DelayQueue  # 无界, 延迟期满才能提取。内部用PriorityQueue实现
        SynchronousQueue    # 单元素, cas实现
        ConcurrentQueue
            add()
            offer()
            poll()
            peek()
        ConcurrentLinkedQueue   # 无界队列, 使用cas
            isEmpty()
            size()
            remove()
            contains()
        ConcurrentHashMap
            # 并发集合通过复杂的策略提高效率, 用ReentrantLock
            # 加了concurrencyLevel属性，决定锁分段个数，取2的次幂。内部用分段锁技术，每段Segment中再存放Entity[]数组
        ConcurrentSkipListMap   # 非阻塞Hash跳表, 功能同TreeMap，线程安全，用跳表实现
    java.util.concurrent.atomic     # 基本数据
        AtomicBoolean
            get()
            set()
            getAndSet()
            compareAndSet()
        AtomicInteger
            get()
            set()
            getAndSet()
            compareAndSet()
            getAndIncrement()
            getAndDecrement()
            getAndAdd()
        AtomicIntegerArray  # 对int[]类型封装，使用Unsafe类通过cas方式实现线程安全
            get()
            length()
            getAndSet()
            compareAndSet()
            getAndIncrement()
            getAndDecrement()
            addAndGet()
        AtomicLong
        AtomicLongArray

        Semaphore
            # 信号量控制并发
            semaphore(5, true)  # 5个信号量，公平(先启动线程大概率先获得锁)
            o->
            Semaphore semaphore = new Semaphore(5, true)
            semaphore.acquire()
            semaphore.release()
    java.util.concurrent.locks     # 锁
        <<Lock>>    # 主要是可重入锁，非阻塞结构上下文使用
            ReentrantLock
                # 多线程不可同时访问一个类中2个加Lock的方法, 因为是2个锁。
                lock()
                unlock
                    # 用lock, unlock可设置交替锁(hand-over-hand locking), 轮流锁、解锁一部分
                tryLcok()
                    # 可设置超时
                    # 同时超时，再尝试失败再尝试而进入活锁。设置不同超时时间减少活锁机率
                lockInterruptibly()
                    # 突破死锁
                newCondition()
                    # 条件变量, 原子地阻塞并解锁，直到条件满足(如有容量，队列非空)
                    condition.await()
                    condition.signal()
                    condition.signalAll()
        <<ReadWriteLock>>   # 读写锁，写独占
        <<Condition>>   # 替代wait(), notify()
            await()
            signal()


## 内省
    # IntroSpector，操作javabean
    例子
        Point p = new Point();
        PropertyDescriptor pd = new PropertyDescriptor("x", p.getClass());
        Method methodGetX = pd.getReadMethod();
        Method methodSetX = pd.getWriteMethod();
        methodSetX.invoke(p, 7);
        System.out.println(methodGetX.invoke(p));

        BeanInfo beanInfo = Introspector.getBeanInfo(p.getClass());
        PropertyDescriptor[] pds = beanInfo.getPropertyDescriptors();
        for(PropertyDescriptor pd2 : pds){
            if(pd.getName().equals("x")){
                System.out.println(pd.getReadMethod().invoke(p));
                break;
            }
        }
## 反射
    # 类中成分映射为类
    字节码
        Class类型对象指向类加载器中加载的字节码
        Class对象不可以new, 因为字节码是类加载器中加载的, 不可能new出来
        虚拟机中同一个类的字节码只有一份
        预定义的class实例对象9个
            # 包装类型中Type就是class，如int.class == Integer.Type
            # void的包装类型为Void
            void
            byte short int long
            float double
            boolean
            char
        获得字节码三种方法
            Class.forName(类名)
            类名.class
            this.getClass()
        内部类
            内部类不为public时，会在前面加上public 的类的类名和$，所以不能用其类名.class来得到它的字节码
        泛型
            父类可以通过反射泛型类得到泛型的class, 通过该class创建泛型实例
            方法中泛型类实例通过传入class创建(如dbutils)
    用途
        1. 根据配置文件实例化并注入对象(如spring)
        2. 实现框架
            # 运行时调用自定义类的指定方法(如struts的Action)
    代理
        动态代理机制  # 运行时确定, 用来AOP编程
            没有接口的类：CGlib通过派生子类实现。运行时动态修改字节码
            有接口的类:Proxy生成代理，但是生成的类是接口类型
        静态代理    # 代理指定类，编译时确定

    Class
        Type        # 该类对应的字节码对象

        isPrimitive()       # 是否是基本类型
        isArray()       # 是否是数组
        getConstructor(Class<?>... parameterTypes)
        newInstance()                    # 用不带参数的构造方法创建对象
        getField("y") : Field                    # 得到属性
            field.get(该class的对象);            # 得到属性的值
        getDeclaredField("x") : Field
            field.setAccessible(true);
            field.get(该class的对象);            # 暴力反射
        getFields() : Field[]
            field.set(该class的对象, 新的值);
        getMethod(方法名, 方法参数类型的字节码对象) : Method
            method.invoke(该class的对象, 该方法的参数);
                # invoke中调用对象为null表是调用静态方法
                # 注意，jdk1.5中为了兼容jdk1.4(jdk1.4中如果用到可变参数传递的是一个参数的数组),
                ## 在invoke中第二个参数为数组时，会把数组拆开成可变参数传递。但是这样的话，当我们传递的参数本身就是数组时，
                ## 如main(String[] args)中的参数, 就会变成多个参数。解决办法是：对要传递的数组参数进行打包，
                ## 如new Object[]{new String[]{"aa", "bb", "cc"}},
                    # 注：基本类型的数组是Object对象，String[]不是Object对象，而是Object[]对象
                ## 参数也可以写成(Object)new String[]{"aa", "bb", "cc"};
                    # 这里把Object[]强转为是个Object对象, 这样jdk就不会对数组对象Object[]进行拆分了
        getClassLoader()
            getResourceAsStream("")                    # 相对路径从class根目录开始。没有绝对路径，"/"会报错
        getResourceAsStream("")                        # 相对路径从当前包目录开始。"/"绝对路径从class根目录开始

        使用class
            Class cls1 = Data.class;                    # 虚拟机中已经加载过该类的字节码时
            Class cls2 = p1.getClass();
            Class cls3 = Class.forName("java.lang.String");        # 在虚拟机中没有加载过该类的字节码时
        使用constructor新建实例
            Constructor constructor1 = String.class.getConstructor(StringBuffer.class);
            String str1 = (String)constructor1.newInstance(new StringBuffer("abc"));
        数组
            class上的isArray()判断是否数组
                # 不同维度(一维、二维等), 不同类型的数组，不是同一份字节码。只有同维度同类型的数组是相同的字节码
                ## 基本类型的数组是Object对象，如int[]。String[]是一个Object[]对象，不是Object对象
                Arrays.asList()
                    # 打印Object[], 不能打印基本类型数组的Object
                Array.getLength(obj)
                    # 得到长度
                Array.get(obj, i)
                    # 得到数组中的元素
                    # 没有办法得到int[] 对象的元素类型(即int), 只能取得其元素之后得到其类型
        泛型
            public class BaseDao<T> 中
                // 得到的是继承类的字节码
                // hibernate.basedao2.HeroDao
                Class subClass = this.getClass();
                // 直接超类
                // hibernate.basedao2.BaseDao<hibernate.domain.Hero>
                Type type = subClass.getGenericSuperclass();
                // 得到参数
                ParameterizedType pt = (ParameterizedType) type;
                // 参数数组
                Type[] types = pt.getActualTypeArguments();
                // hibernate.domain.Hero
                type = types[0];
                //User
                this.clazz= (Class) type;
    Proxy   # 只代理有接口的类
        o->
        final List<String> list = newArrayList<String>()
        List<String> proxyInstance = (List<String>) Proxy.newProxyInstance(list.getClass().getClassLoader(), list.getClass().getInterfaces(), new InvocationHandler() {
            @Override
            public Object invoke(Object proxy, Method method, Object[] args) throws Throwable{
                return method.invoke(list, args)
            }
        })
        proxyInstance.add(1)
## web service
    常识
        基于socket                # socket可以跨语言访问
            # 单用socket提供网络服务出现的问题：
            1.不能处理不同协议的请求，如http协议发送的是请求头信息
                #　http调用socket:127.0.0.1:8888/或action="127.0.0.1:8888"
            2.添加新参数，客户端也要修改
        版本
            jdk6之后的版本开始支持web service
            jdk6不支持soap1.2
        传输标准：xml或json                # 普遍使用xml,RestFul使用json
    优点
        易推广、协议匹配、便于升级（加参数）
    服务方式
        # 返回的结果均为xml
        http get
        http post
            # get与post方式直接传递参数，参数易混淆，所以有soap发送xml的方式
        soap1.1
        soap1.2
    soap
        常识：
            soap:simple object access protocol
            soap是以post方式传输的

        内容
            请求soap
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:q0="http://my.test/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                <soapenv:Body>
                    <q0:sayHello>
                    <arg0>小明</arg0>
                    </q0:sayHello>
                </soapenv:Body>
                </soapenv:Envelope>
            响应soap
                <S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">
                <S:Body>
                    <ns2:sayHelloResponse xmlns:ns2="http://my.test/">
                    <return>hello,小明</return>
                    </ns2:sayHelloResponse>
                </S:Body>
                </S:Envelope>
    wsdl
        获得
            http://192.168.10.3:1234/hello?wsdl                # 发布url后面加?wsdl
        内容                        # 查看时从后向前看
            <service>标签
                    name属性：默认 发布类名 + Service
                <port>标签
                        name属性：默认有soap1.1 soap1.2 get post(jdk1.6只有soap1.1)，默认 类名 + port
                    binding属性:真正的实现者    # 指向<binding>标签
                    <soap:address>标签
                            location属性:访问的地址
            <binding>标签：是真正的实现类,soap协议，是文本，方法名
            <portType>标签：
                input
                output
            <message>标签 用schema格式来描述参数类型
            xsd:schema关联的schema文件中
                <element>标签  ，约定了参数类型
    创建与发布
        发布到eclipse的jetty容器
            @WebService
            MyWebService
                public String showName(Strng name)
                    System.out.println("name=" + name);
                    return name + "你好!";
                main
                    Endpoint.publish("http://localhost:8888/hello",new MyWebService());
                                            # 发布webService
                        ## 1.6.0_13及之前的版本不支持,1.6.0_14之后的版本支持
                        ## 发布之后http://localhost:8888/hello?wsdl中有wsdl文件
        可以发布成服务的方法
                1.非final、static修饰的public方法
                2.@WebMethod(exclude=true)方法前加该注解时不发布该方法
    调用
        HttpClient
            get
            post
            soap
        wsdl.xml
            #　web service提供给不同平台生成解决方案的配置文件
            ## HttpClient发送soap时充当了:wsdl.xml解决方案调用的过程
            o-> wsimport.exe(jdk1.6)
                解析wsdl.xml文件
                    命令：wsimport -s . -p cn.itcast                # -s 保存源码（默认不保存）,-p指定包名
                    生成类：
                                # jdk1.6中解析时忽略生成soap12服务类文件（jdk1.6不支持）与get post服务类文件(默认忽略)
                        XxxService
                        XxxServicePort
                        Xxx
                        ..
                    调用：
                        MyWSService mywsService = new MyWSService();
                        String retVal = mywsService.getMyWSPort().sayHello();
            o-> myeclipse的web service soap浏览器
                # 可以从soap浏览器中查看请求和返回的soap.xml文件的源码
                |-> 右上角wsdl page
                |-> 左边栏 uddi main
                |-> 右边栏按提示输入即可
            o-> ajax
                方式一：直接调用
                缺点
                    新版浏览器（ie10等）不支持跨域请求(为了安全)，所以只能请求localhost
                    会把数据暴露在客户端
    注解
        @WebMethod(exclude=true)    # 对此方法不进行发布
        @WebService     # 声明为web service服务类
            ## 可选属性
            name="服务名",
            portName="端口名",
            serviceName="真正服务类的名字",
            targetNamespace="包名a.b.c"
        @WebResult(name="")     # 方法返回值类型前，指定返回值名（如果返回的是集合，则指定的是集合内元素的名）
        @WebParam(name="")     # 方法参数值类型前，指定参数名
## 框架
    cglib
        # 构造接口
    dbutils
    fastjson
        # 淘宝json
    beanUtils
    ioUtils

# jvm
## 基础
    继承
        被继承的对象是会单例，不会新创建。如果被继承的对象没有，则创建一个
    多态
        父类(接口)中定义的引用变量，在运行时动态绑定到具体实例的方法执行
    内部unicode编码
    类
        初始化时机
            new
            访问静态变量，或对静态变量赋值
            调用静态方法
            反射 Class.forName("")
            初始化子类，会先初始化父类
            jvm启动时标明的类 (java com.a.A中的A类)
        步骤
            类加载
            链接
                验证
                准备  # 静态变量分配内存，设置默认初始值
                解析  # 符号引用替换直接引用
            初始化父类(非接口)
            初始化
                父类
                初始化语句   # 如static块和static变量
    线程
        运行时都有线程栈，保存变量值信息。访问对象值时，建立变量副本。修改后(线程退出前)副本值写到对象
    JIT(just in time)
        # 热点代码检测, 运行时编译和优化
### 内存
    # java自动管理堆栈, c++手动分配
    组成
        方法区(method area)
            组成
                类信息
                    class
                数据区(data segment)
                    运行时常量池(constant pool) # 编译期确定，保存在.class中的数据
                        字面量
                        文本形式的符号引用
                            字段名称和描述符
                            方法名称和描述符
                            类和接口的全限定名
                    静态区(static segment)
                        静态变量
                代码区(code segement)
                    JIT编译后的代码
            特点
                线程共享
                静态分配, 位置不改变
        栈(stack)
            分类
                虚拟机栈(vm stack)
                本地方法栈(native method stack)
            保存
                基础数据类型
                引用类型在栈分配地址, 局部变量生命周期结束后，栈空间立即回收
                方法调用    # 一次调用一个帧(frame)
                方法的形参, 调用完回收
                方法引用参数, 在栈上分配地址, 调用完回收
                方法实参，栈空间分配，调用完释放
            特点
                线程隔离
                逻辑概念，可连续可不连续, 系统自动分配。栈中的字面值可共享,如int i = 3
                StackOverflowError
            实现
                java的stack存放的是frames, frames由heap分配，所以stack内存不连续
                只存在本地变量、返回值、调用方法，不能直接push和pop frams
        堆(heap)
            保存
                引用类型在堆分配类变量, 局部变量生命周期结束后，堆空间等待gc回收
                this
            特点
                线程共享
                以随意顺序，运行时分配和回收空间, 代码申请
                大小、数量、生命期常常在编译时不确定
                细分为新生代和老年代, 再具体为 eden survivor(from survivor、to survivor), tenured
                OutOfMemoryError
            实现
                存放所有runtime data
                heap是jvm启动时创建
        程序计数器(program counter register)
            特点
                线程隔离
    机制
        程序计数器、虚拟机栈、本地方法栈 是线程私有空间
            随线程产生和销毁，每个栈帧分配多少内存在随类结构确定。内存分配回收都是确定的
        方法区和堆
            一个接口的各实现类需要内存可能不一样, 所以运行时才知道创建哪些对象，内存分配和回收是动态的，gc主要关注
    内存溢出
        原因
            加载数据过大  # 大约10万条以上, 应分页查询
            集合中对象引用未清除
            代码循环产生对象
            第三方软件bug
            启动参数内存设置过小
        方案
            jvm启动参数 -Xms, -Xmx
            jvm错误日志, OutOfMemory前信息
            内存查看工具动态查看
## 类加载器
    父亲委派机制(java2)
        # 常用类不被替代
        先试上层类加载器

    4种类加载器(加载类文件位置不同)
        层级关系
            # 父级类加载器向下加载子加载
            BootStrap
                ExtClassLoader
                    AppClassLoader
                        自己的类加载器
        优先级
            只加载层级关系靠前面的同名类

        BootStrap
            # c++写的二进制代码，jvm中启动时创建,无法获得引用对象
            位置
                JRE/lib/rt.jar  # java9后为jrt-fs.jar
                参数-Xbootclasspath指定
            代码
                System.class.getClassLoader()
                    # null
                    ## 说明是BootStrap类加载器加载的，不能得到该类加载器
        ExtClassLoader(sun.misc.Launcher$ExtClassLoader)
            位置
                JRE/lib/ext/*.jar
                参数-Djava.ext.dirs指定
        AppClassLoader(sun.misc.Launcher$AppClassLoader)
            位置
                环境变量CLASSPATH 或 系统属性java.class.path
                参数-cp覆盖
            代码
                ClassLoaderText.class.getClassLoader().getClass().getName()
                    # AppClassLoader
        自定义     # 如tomcat的StandardClassLoader
            # 继承ClassLoader
    api
        TestClass.class.getClassLoader()
            getParent()                        # 得到加载该类加载器的类加载器
            loadClass(String name)                # 找parent委托，没有加载时执行findClass(String name)
                                                    ## 模板方法的设计模式，见 note-> 设计模式
            findClass(String name)                # 自己加载
            defineClass(..)                                # 将二进制数据转换为class
        线程
            # 该线程类加载器加载线程中的第一个类
            线程.setContextClassLoader(ClassLoader cl)    # 指定一个线程的类加载器
    自己的类加载器
        挂在AppClassLoader下面
        加载指定的目录
            该目录下的class加密后，自己的类加载器解密
        写法
            覆盖findClass(String name)
        例子
            public class MyClassLoader extends ClassLoader{
                private String classDir;
                @Override
                protected Class<?> findClass(String name) throws ClassNotFoundException{
                    // 传入的name是全限定名
                    String classFileName = classDir + "\\" + name.substring(name.lastIndexOf('.') + 1) + ".class";
                    // 处理异常
                    FileInputStream fis = new FileInputStream(classFileName);
                    ByteArayOutputStream bos = new ByteArraOutputStream();
                    cypher(fis, bos);
                    fis.close();
                    byte[] bytes = bos.toByteArray();
                    return defineClass(bytes, 0, bytes.length);
                    // 抛出异常时 return super.findClass(name);
                }
                public MyClassLoader(){}
                public MyClassLoader(String classDir){this.classDir = classDir;}
                private static void cypher(InputStream ips, OutputStream ops){...}
            }
            // 删掉父类的ClassLoaderAttachment.class
            // new 的MyClassLoader挂在了AppClassLoader这个类加载器上
            Class clazz = new MyClassLoader("itcastLib").loadClass("cn.itcast.day2.ClassLoaderAttachment");
            // 错误写法。因为这样写 jvm编译器要加载ClassLoaderAttachment类，但是该类已经加密
            ClassLoaderAttachment d1 = (ClassLoaderAttachment)clazz.newInstance();
            // 正确写法。用该加密类继承的父类来引用它的实例
            Date d1 = (Date)clazz.newInstance();
    servlet部署
        tomcat类加载器
            AppClassLoader
                StandardClassLoader
                    WebappClassLoader
        输出Servlet.class的jar与servlet-api.jar到jdk/lib/ext
            # 因为servlet.class加载的时候需要HttpServlet类，该类在tomcat提供的servlet-api.jar
# 规范
    命名与写法
        包名 小写、只用一个单词、只用单数
        类名 UpperCamelCase
            类名可以使用复数
            抽象类开头 Abstract或Base
            异常类结尾 Exception
            测试类以要测试类名开始，以Test结尾
            使用的设计模式，可以写在类名上
            接口类形容能力时，用形容词做名字(一般是-able, 如Translatable)
                实现类1: 结尾加Impl
                实现类2: Translatable的实现类名Translator
            枚举类结尾加Enum
                成员全大写,下划线隔开
        方法名、参数名、成员变量、局部变量 lowerCamelCase
            获得单个对象前缀get
            获得多个对象前缀list
            获得统计值前缀count
            插入前缀save或insert
            删除前缀remove或delete
            修改前缀update
            方法按顺序排列
                # 公有或保护 -> 私有 -> getter/setter
        常量 MAX_COUNT
        布尔类型变量不以is开头
        保留字和运算符左右加空格, 参数逗号后加空格
        缩进用4空格
        杜绝不规范的缩写
            如 AbstractClass写成AbsClass、condition写成condi
        换行
            # 单行120要换行
            运算符、点号在下一行
            参数中的逗号在上一行
            括号前不换行，如append("a")的括号前
        空行
            执行语句组、变量定义语句组、业务逻辑或不同语义之间插入空行
                # 相同业务逻辑和语义间不要空行
        领域模型
            # POJO是 DO/DTO/BO/VO 的统称，禁止命名xxxPOJO
            数据对象 xxxDO
            数据传输对象 xxxDTO
            展示对象 xxxVO
        ide的text file encoding设置为utf-8, 文件换行用unix格式
    类
        类成员和方法，访问控制从严
        构造方法不加业务逻辑
        POJO类要实现toString (避免继承)
        接口类
            接口类中方法和属性，不要加修饰(如public)，
            尽量不定义变量和default实现
        枚举类
            变量值在一范围内变化的，用Enum类，有延伸属性的(如MONDAY(1))，用Enum类
    方法
        覆写方法一定加@Override，可判断是否覆盖成功
        过时方法要加@Deprecated，并写明新接口是什么
        可变参数只用在ids之类的地方
        不使用过时方法
    变量
        常量
            不要定义一个总常量类，应分类定义单独的类
            共享常量
                跨应用，放在二方库，如client.jar中的constant目录
                应用内，放在一方库modules中的constant目录
                子工程内部，放在子工程的constant目录
                包内，放在包的constant目录
                类内，在类中定义private static final
            不写魔法值，如key="Id#toabao"
            long型赋值用大写L, 如Long a = 2L
        数组 String[] args,而不是String args[]

    编程
        方法可以反回null, 但要注释充分
        POJO类属性和RPC方法参数返回值使用包装类型，局部变量使用基本类型
        避免所有NPE(空指针)问题(赋初值或非空检查)
        用"a".equals(object)而不是object.equals("a"),否则容易抛空指针
            # 也可以用java.util.Objects#equals
        String.split时，要检查最后分隔符后有无内容 (如 "a,b,,", 使用arr[3]时异常)
        包装类比较，用equals
            # 只有Integer -128到127在IntegerCache中运用享元，才==
        用StringBuilder扩展字符串
        慎用Object.clone，是浅拷贝，要重写
        final
            不需要重新赋值的变量
            对象参数加final，表示不修改引用
            类方法不重写
        正则要预编译
            # Patern.compile()在外
        Math.random()可以取到0，取整数时用nextInt或nextLong方法
        用System.currentTimeMillis()而不是new Date().getTime()
        任何数据结构的构造或初始化，都要指定大小，避免OOM
        NPE(空指针异常)场景
            返回包装类型为null时，解包NPE
            数据库查询结果
            集合里元素即使isNotEmpty，也可取出null
            远程调用结果要判null
            Session中数据判null
            级联调用 a.b().c()
    集合
        初始化时，尽量指定大小
        hashCode与equals
            # 同时重写
            Set存的对象与Map的键，要重写hashCode与equals
        sublist只是个视图，不能转ArrayList
            sublist修改原集合个数，会引起之后使用的CuncurrentModificationException异常
        集合转数组要用toArray(T[])
        Arrays.asList返回的集合不要add/remove/clear
            # 只是适配器，内部还是数组
        <? extends T>接收的对象，不能用add方法
        remove/add用Iterator，并发要加锁，不能foreach
        JDK7以上版本，Comparator要满足3个条件，不然Arrays.sort和Collections.sort会报异常
            x,y比较结果和y,x相反
            x>y, y>z, 则x>z
            x=y则x, z比较结果与y, z比较结果相同
        使用entrySet遍历Map, 而不是KeySet, JDK8使用Map.foreach
            # KeySet遍历了2次，一次转为Iterator对象，一次从hashMap取key的value
        null情况
            集合类                 Key      Value     Super       说明
            Hashtable           非null       非null   Dictionary  线程安全
            ConcurrentHashMap   非null       非null   AbstractMap 分段锁技术
            TreeMap             非null       可null   AbstractMap 线程不安全
            HashMap             可null       可null   AbstractMap 线程不安全
        稳定性和有序性
            ArrayList   order/unsort
            HashMap     unorder/unsort
            TreeSet     order/sort
    并发
        单例方法要线程安全, 获取单例要注意线程安全
        线程或线程池指定有意义的名称
            public class TimerTaskThread extends Thread {
                public TimerTaskThread() {
                    super.setName("TimerTaskThread")
        线程资源只从线程池取，不要自行创建
        不用Executors而用ThreadPoolExecutor创建
            FixedThreadPool和SingleThreadPool允许请求队列长度为Integer.MAX_VALUE, 可能堆积大量请求OOM(out of memory)
            CachedThreadPool和ScheduledThreadPool允许创建线程数量为Integer.MAX_VALUE，可能创建大量线程，导致OOM
        SimpleDateFormat线程不安全，不要static。应使用DateUtils
            JDK8用Instant代替Date, LOcalDateTime代替Calendar, DateTimeFormatter代替Simpledateformatter
        尽量锁小范围
        多线程中，都对多对象加锁，加锁顺序要一致，否则会死锁
        并发修改时，在应用层加锁或在缓存加锁或在数据库层加乐观锁并使用version作更新依据
            每次访问冲突率小于20%, 使用乐观锁，否则用悲观锁。
            乐观锁重试次数不得小于3
        Timer的多个TimeTask，一个没有捕获异常会同时终止。应使用ScheduledExecutorServcie
        CountDownLatch进行异步转同步时，线程代码注意catch异常，确保countDown执行
            # 子线程异常，主线程catch不到
        Random多线程下，会因竞争同一seed导致性能下降。JDK7后用ThreadLocalRandom
        延迟初始化的双重检查锁隐患。将目标属性声明为volatile
        volatile不能解决多写问题, 使用AtomicInteger或JDK8的LongAdder，它减少了乐观锁的重试次数
        HashMap在容量不够进行resize时，高并发可能会出现死链，导致cpu飙升
        ThreadLocal使用static修饰
    控制语句
        switch中，case要么有break/return，要么注释执行到哪个case。switch都要有default
        不要省略大括号
        尽量少用else，用卫语句（只有一个if）或状态模式
        条件判断只调用getXxx/isXxx，运算赋值给布尔变量判断，提高可读性
        循环体中语句考量性能
        参数校验场景
            调用频次低的方法
            执行时间大的方法
            需要极高稳定性和可用性
            对外开放接口
            敏感权限入口
        不需参数校验场景
            可能被循环调用     # 要注明外部参数检查
            底层方法，如DAO
            private方法明确入参已校验
    注释
        # 自解释代码少注释，注释要反应设计思想与代码逻辑，描述业务含义
        类、类属性、类方法使用/**内容*/      # Javadoc规范
        抽象方法要Javadoc注释，除返回值、参数、异常说明外，还要指出做什么事，实现什么功能
        类要添加创建者
        枚举类型都要注释
        用中文说清楚
        注释要跟进修改
        注释掉的代码要有说明
        特殊注释，要注明标记人和标记时间
            TODO: (标记人，标记时间，[预计处理时间])
    异常
        事先检查值，而不是调用后处理异常
        异常不要用来做流程控制，效率低
        异常要对小段代码, 要细分
        异常要处理或上抛，最外层一定要处理
        注意事务回滚
        finally资源要关闭，异常要处理，JDK7用 try-with-resources
        finally中不要return，否则不执行try中return
        不要捕获异常的父类
        rpc异常定义自己的result，好处一是调用方不会漏查，二是可以加异常栈
        不抛RuntimeException，Exception和Throwable。抛确定异常
    日志
        不直接用日志系统，用门面模式的日志框架
        日志保存15天，因为有“周”频次发生的异常
        利用日志文件名和目录 stats/desc/monitor/visit/appName_logType_logName.log
        直接logger.debug(a + b)，级别为warn是表达式还会执行。用2种方式避免
            if logger.isDebugEnabled() {...}
            logger.debug("{} {}", id, symbol)
        设置log4j.xml的additivity=false，防止重复打印
        要记录异常堆栈。logger.error(参数或对象toString + "_" + e.getMessage(), e)
        可以用warn记录用户输入参数错误的情况，避免用户投诉时无所适从
        生产环境禁止输出debug日志，有选择地输出info。如果用warn来记录刚上线业务，要注意量的问题
    mysql
        类型
            is_xxx  unsigned tinyint    # 1是0否
            唯一索引名 uk_字段名，普通索引idx_字段名        # unique key, index
        表名、字段名
            库名与应用名尽量一致
            小写与数字
            不数字开头
            不能下划线间仅有数字
            不使用复数
            不用保留字
                desc、range、match、delayed等
            必有三字段
                id unsigned bigint，单表时自增，步长为1
                gmt_create date_time
                gmt_modified date_time
            表名 业务名称_表的作用，如tiger_task, mpp_config
            字段含义修改或追加状态时，及时更新注释
        orm
            boolean属性POJO不加is, 数据库前缀is_
                # mybatis generator生成的代码中需要修改
            不能返回resultClass, HashMap, Hashtable
            xml配置用 #{}, #param#, 不要${}，容易sql注入
            尽量不用ibatis的queryForList(String statementName, int start, int size)
                # 会查整表
                应在sqlmap.xml中引入#start# #size#
            更新时要同时更新gmt_modified
            不要大而全的更新接口，传入POJO类。会更新无改动字段，易出错，效率低，增加binlog存储
            @Transactional事务不要滥用，影响qps
                事务回滚方案包括缓存回滚、搜索引擎回滚、消息补偿、统计修正等
    分层
        开放接口层
        终端显示层
        web层
            对访问控制进行转发，参数校验，不复用业务简单处理
        service层
        manager层
            对第三方封装
            service通用能力下沉，如缓存方案、中间件通用处理
            与dao层交互，对dao业务通用能力封装
        dao层
            直接抛DAOException，由service层处理
        外部接口或第三方平台
        分层领域模型
            DO (Data Object)
            DTO (Data Transfer Object)
            BO (Business Object)
            QUERY
            VO (View Object)
    服务器
        JVM设置- XX :+ HeapDumpOnOutOfMemoryError, OOM时输出dump信息