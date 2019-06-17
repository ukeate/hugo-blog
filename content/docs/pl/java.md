---
Categories: ["语言"]
title: "Java"
date: 2018-10-09T08:48:07+08:00
---

# 打包
1. 建立一个文件夹叫jnb
1. 将编译好的标签处理类连同包一起拷贝到jnb中
1. 在jnb目录下创建META-INF目录
1. 在META-INF中存储tld文件，修改tld文件添加<uri>http:# www.xxx.com</uri>
1. jar cvf jnb.jar *
        
# bin目录命令 
    javac        #  编译器
    java            #  解释器
    appletviewer    #  小程序浏览器，执行HTML文件上java小程序类
    javadoc        #  生成HTML格式的帮助文档
    jdb            #  java调试器
    javah        #  反编译成c头文件
    javap        #  反编译成java文件
    jar            #  打包工具
    htmlconverter    #  不明
    native2ascii    #  转换为unicode编码
    serialver        #  返回指定类的序列化号serialverUID

# java类型占字节数
    byte  1个字节
    short 2个字节
    char  2个字节
    int   4个字节
    long  8个字节
    float 4个字节
    double 8个字节    
    boolean 1-4字节
# 命令
    javac            #  编译器
    java            #  解释器
    appletviewer    #  小程序浏览器，执行HTML文件上java小程序类    
    javadoc            #  生成HTML格式的帮助文档
    jdb                #  java调试器
    javah            #  反编译成c头文件
    javap            #  反编译成java文件
    jar                #  打包工具
    htmlconverter    #  不明    
    native2ascii    #  转换为unicode编码
    serialver        #  返回指定类的序列化号serialverUID
    jar cvfm ul.jar manifest.mf com
        ＃　打包　
    javadoc -d docs -sourcepath src/ -subpackages com.ryx -author

# 语法

    o-> 外部类只能用两个访问修饰符
        public default
    o-> 内部类或方法可以用四个访问修饰符
        public default protected private
    o-> 子类继承的父类public 方法不可被外部调用
    o-> 静态导入(1.5)
        import static java.lang.Math.max        
        import static java.lang.Math.*        # 导入的是方法，该方法就可以直接使用
    o-> 增强for循环(1.5)
    o-> 可变参数(1.5)
    o-> 基本数据类型自动折装箱(1.5)
        Integer 进行了享元设计
            －128 － 127 范围的对象是同一对象， 其它会成为不同对象
    o-> synchronized
        public synchronized void synMethod(){}

        synchronized(a1){}
    o-> 表达式
        java 赋值语句返回被赋值的对象 
    o-> 反射
    用途
            描述
        Class类型对象指向类加载器中加载的字节码
        Class对象不可以new, 因为字节码是类加载器中加载的, 不可能new出来
        虚拟机中同一个类的字节码只有一份
    用途
        o-> 运行时读取配置文件，用反射换掉已实例化对象中的默认配置
        o->  写框架。
            # 运行时用户传递不同类名，调用其中的相同的方法（用反射调用的类可以先写, 具体执行方法的类可以随时开发）， 这就是框架(如struts的Action类)
        
    得到实例
        Class cls1 = Data.class;                    # 虚拟机中已经加载过该类的字节码时
        Class cls2 = p1.getClass();
        Class cls3 = Class.forName("java.lang.String");        # 在虚拟机中没有加载过该类的字节码时
    九个预定义的class实例对象
        void
        八个基本类型
            byte short int long
            float double
            boolean
            char
                # int.class == Integer.Type 包装类型中的Type属性是指其包装的基本类型的字节码
                ## void类型的包装类型Void
                ## int[] 是一个类型，也有class字节码，但不是基本类型
    class的api
        属性
        方法
            isPrimitive()                            # 是否是基本类型
            isArray()                            # 是否是数组
    反射            # 把java类中的各种成分映射成相应的java类
        反射用的Class的api
            属性
                Type                            # 该类对应的字节码对象
            方法
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
                    method.invoke(该class的对象, 该方法的参数);                    # invoke中调用对象为null表是调用静态方法
                        # 注意，jdk1.5中为了兼容jdk1.4(jdk1.4中如果用到可变参数传递的是一个参数的数组), 
                        ## 在invoke中第二个参数为数组时，会把数组拆开成可变参数传递。但是这样的话，当我们传递的参数本身就是数组时，
                        ## 如main(String[] args)中的参数, 就会变成多个参数。解决办法是：对要传递的数组参数进行打包，
                        ## 如new Object[]{new String[]{"aa", "bb", "cc"}}, 
                            # 注：基本类型的数组是Object对象，String[]不是Object对象，而是Object[]对象
                        ## 参数也可以写成(Object)new String[]{"aa", "bb", "cc"}; 
                            # 这里把Object[]强转为是个Object对象, 这样jdk就不会对数组对象Object[]进行拆分了
                            
                数组反射
                    isArray()            # 判断是否数组
                    # 不同维度(一维、二维等), 不同类型的数组，不是同一份字节码。只有同维度同类型的数组是相同的字节码
                    ## 基本类型的数组是Object对象，如int[]。String[]是一个Object[]对象，不是Object对象
                    ## Arrays.asList()            打印Object[], 不能打印基本类型数组的Object
                    ## Array.getLength(obj)        得到长度
                    ## Array.get(obj, i)            得到数组中的元素
                    ## 没有办法得到int[] 对象的元素类型(即int), 只能取得其元素之后得到其类型
                集合反射
                    # ArrayList只按顺序存放, HashSet按hashCode分区(hashCode分区后避免了每次全局遍历查找)后比较equals的值再存放(所以效率较低)
                    ## 先hashCode再equal这种方法只是hash集合里用到。
                    ## 修改了hash集合中元素的 参与hashCode值运算的属性的值以后, 该集合中的该元素将不再能删除, 因为无法定位, 
                    ## 如果这时以为该元素已经删除了的话，就导致了内存泄漏
                        # 覆盖equals方法时，必须是int equals(Object obj)进行override , 如果写成int equals(当前类, obj)的话相当于是重载, 并没有覆盖
                getClassLoader()
                    getResourceAsStream("")                    # 相对路径从class根目录开始。没有绝对路径，"/"会报错
                getResourceAsStream("")                        # 相对路径从当前包目录开始。"/"绝对路径从class根目录开始
        例子
            Constructor constructor1 = String.class.getConstructor(StringBuffer.class);
            String str1 = (String)constructor1.newInstance(new StringBuffer("abc"));
                # getConstructor与newInstance方法中的参数都是可变参数
                ## newInstance不用"已确定了的"constructor1中的参数，因为写代码是在编译时， 而"已确定"是在运行时。
                ## 我们在写代码就是在“运行”代码，写代码就是在运行时，所以在写代码过程中确定的事就是运行时才确定的事。
                ## 同样，返回的str1类型也是在运行时才确定的，所以在写代码的编译时要进行类型的强传。
            泛型的反射
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
    o-> 内省
    IntroSpector                # 对 javabean进行操作
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
    o-> 注解
    annotation            # jdk5的新特性, 就是在各种元素(可以加在包上面)上加了某种标记
        jdk的所有注解
            @SuppressWarnings("deprecation")                    # 压制警告
            @Deprecated                                # 标记过时
            @Override
    元注解(metadata)
        包括  @Retention @Target @Document @Inherited四种。
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
    保留策略
        用元注解@Retention(RetentionPolicy.RUNTIME)标识
        CLASS、RUNTIME和SOURCE这三种，分别表示注解保存在类文件、JVM运行时刻和源代码阶段
            # 只有当声明为RUNTIME的时候，才能够在运行时刻通过反射API来获取到注解的信息。



    @SuppressWarnings({"unchecked"})                # 压制警告，可以放在任何上面
        # SuppressWarning不是一个标记注解。它有一个类型为String[]的成员，
            # 常见参数
            1.deprecation：使用了不赞成使用的类或方法时的警告
            2.unchecked：执行了未检查的转换时的警告，例如当使用集合时没有用泛型 (Generics) 来指定集合保存的类型; 
            3.fallthrough：当 Switch 程序块直接通往下一种情况而没有 Break 时的警告;
            4.path：在类路径、源文件路径等中有不存在的路径时的警告; 
            5.serial：当在可序列化的类上缺少 serialVersionUID 定义时的警告; 
            6.finally：任何 finally 子句不能正常完成时的警告; 
            7.all：关于以上所有情况的警告。
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

    @Override            # 重写（标记注解（marker annotation）：只要声明即可）

    @Deprecated                    # 标记注解，用于修饰已经过时的方法;

    自定义注解
        @Retention(RetentionPolicy.RUNTIME)
        @Target(ElementType.TYPE)
        public @interface Assignment {
            String assignee();
            int effort();
            double finished() default 0;
        } 
            # @interface用来声明一个注解
            ## 其中的每一个方法实际上是声明了一个配置参数。方法的名称就是参数的名称，返回值类型就是参数的类型。可以通过default来声明参数的默认值。

    

    o-> 静态导入
        静态导入方法            # jdk5的特性
        例子
            import static java.lang.Math.random;
                # 在类中可以直接调用random来调用该方法
            import static java.lang.Math.*;
                # 静态导入了Math类中的所有方法
    o-> 可变参数，增强for循环
        # jdk5的特性
        例子
            public void sum(int x, int... args){
                int sum = x;
                for(int i : args){
                    sum += i;
                }
            }
    o-> 自动装箱拆箱
        #jdk5特性
        例子
            Integer iObj = 3;        # 装箱
            iObj + 12;            # 折箱
        特点
            Integer i1 = 120;
            Integer i2 = 120;        
                i1与i2是一个对象
                当数字大于1字节(-128 -- 127)后 , 分成两个对象
                # 这是一种设计模式 : 享元模式（fly weight）
    o-> 枚举
    例子
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
    枚举写单例
        # 只有一个成员时作为自己的单例，这个类的实例永远是一个。
        public enum WeekDay {
            // 元素列表必须在最前, 如果元素列表后面没有东西的话，可以省略分号
            SUN(1), MON(), TUE, WEN, THI, FRI, SAT;
            // 枚举的构造方法必须是私有的
            private WeekDay() {
            }

            private WeekDay(int day) {
            }
        }

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
    1.6特性
        枚举类实现的类
            java.lang.Enum<E> extends Object
                static <T extends Enum<T>> T valueOf(Class<T> enumType, String name) 
                
            javax.lang.model.element.ElementKind extends java.lang.Enum<ElementKind>
                static ElementKind valueOf(String name) 
                static ElementKind[] values() 
                    # 这个才是我们实际创建枚举类型时继承的类
        
        注意
            o-> 比较枚举类型的时候，声明它们的指令表明了它们的顺序值。 
            o-> 我们实际创建枚举类型时继承的类并不是 java.lang.Enum<E> 
                而是 javax.lang.model.element.ElementKind
            
        枚举类中的两个隐藏的静态方法
            values()        # 返回一个枚举类型所有可能值的数组。 
            valueOf()        # 为提供的字符串返回一个枚举类型，该枚举类型必须精确地匹配源代码声明。 
                # 因为它们是枚举子类上的静态方法，而不是Enum本身的方法
                ## ，所以它们在java.lang.Enum的javadoc中没有出现。 

        用法 
            o-> 定义1
                public enum Color {  
                RED, GREEN, BLANK, YELLOW  
                }  
            
            o-> 定义2
                enum Signal {  
                GREEN, YELLOW, RED  
                }  
                
            o-> 定义3
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
            
            o-> 枚举类可以实现接口
            
            o-> 使用接口组织枚举
                public interface Food {  
                enum Coffee implements Food{  
                    BLACK_COFFEE,DECAF_COFFEE,LATTE,CAPPUCCINO  
                }  
                enum Dessert implements Food{  
                    FRUIT, CAKE, GELATO  
                }  
                }  
            
            o-> 可以用switch进行判断
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
                
            o-> 专用于迭代枚举的集合
                java.util.EnumSet    # 集合中的元素不重复
                java.util.EnumMap    # key是enum类型，而value则可以是任意类型。

# 常用api
## String 
    replaceAll
        String p = "A0A1A2".replaceAll("([A-Z]{1,1})([A-Z0-9]{1,1})?", "$1=$2 ");  
        # A=0 A=1 A=2   
        ## $符是组的概念，与"([A-Z]{1,1})([A-Z0-9]{1,1})?"中的两对括号代表两组
        ## {1,1}代表匹配1次, (从1次到1次)
        replaceAll("[A_Z]", "_$0")            # 分组匹配被替换的值到替换字符串中
    isEmpty()
    length()
## 数组
    泛型数组实例化
        T[] = (T[]) new Object[0];
        (T[]) Array.newInstance(type, size);
## Collection
    list 与 set区别
        list放每一个引用
        set先检查引用是否已存在，没有时再放入
### Map

### List
        Object [] toArray() # 返回list中的所有元素作为一个Object []
        <T> T[] toArray(T[] a)  # 返回泛型类型的list中的所有元素
## Queue
    Queue<String> queue = new LinkedList<String>();
    queue.offer("a");            # 添加
    queue.poll();                # 返回第一个元素并删除
    queue.element();            # 返回第一个元素, empty时抛异常
    queue.peek();                # 同element(), 但empty时返回null
## ThreadLocal
    InheritableThreadLocal<T>
        set(T t)        ＃ 向当前线程对象放入泛型对象
        get()            # 得到当前线程已放入的对象
## System
    System.currentTimeMillis();
## File
    String[] list()            # 列出目录下的所有文件名
    String[] list(FilenameFilter filter)            # 列出目录下符合filter规范的文件名（filter用匿名内部类定义）
## Scanner
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
## Arrays
    这个类提供了5个功能：
    1，将数组转换成java.util.ArrayList类型；【asList()】
    2，数组的排序；【sort()】
    3，数组的二分查找；【binarySearch()】
    4，两个数组的比较；【equals()】
    5，给数组赋初值；【fill()】
## 正则
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
# 版本
    java8
            1.接口中可以定义静态方法与默认方法，但不能重写equals，hashCode或toString的默认实现。 
            一个接口定义一个唯一的抽象方法，这个接口是函数式接口，用新的Annotation：@FunctionalInterface标记
            
            2.Lambdas项目，用来定义函数（Lambda更好地利用多核处理器）
                    (int x, int y) -> { return x + y; }
                    Runnable r = () -> { System.out.println("Running!"); }
            
            3.java.util.function包
            
            4.Jigsaw项目，jdk上的模块系统，使大块的代码更易于管理
            
    java5
            1.泛型，允许指定集合里元素的类型
            
            2.枚举类型
            
            3.自动类型包装和拆包
            
            4.可变参数
            
            5.注解
            
            6.增强for循环
            
            7.静态引入
            
            8.新的线程模型与并发库
                    HashMap的替代者ConcurrentHashMap
                    ArrayList的替代者CopyOnWriteArrayList
                    
    java6
            1.ui增强
                    Java应用程序可以和本地平台更好的集成
            2.web service支持增强：jax-ws2.0与jaxb2.0
                    优先支持编写 XML web service 客户端程序。
                    用过简单的annotaion将你的API发布成.NET交互的web services.
            3.jdbc4.0
            4.Scripting可以在Java源代码中混入JavaScript
            
    java7
            1.switch中可以使用字符串了
            
            2.运用List<String> tempList = new ArrayList<>(); 即泛型实例化类型自动推断

            3.语法上支持集合，而不一定是数组
                    final List<Integer> piDigits = [ 1,2,3,4,5,8 ]; 
            4.map集合支持并发请求，且可以写成 
                    Map map = {name:"xxx",age:18};
# 方案
    代理
        动态代理机制
                没有接口的类：可以用CGlib生成动态代理
                有接口的类:Proxy生成代理，但是生成的类是接口类型

        Proxy类
                只能代理有接口的类
    线程跟踪
        ThreadLocal
    任务
        Timer类来实现
                Timer timer = new Timer();                # Timer(String name, boolean isDaemon) 指定任务名和是否后台执行
                timer.schedule(new MyTask(), 1000, 2000);        # 1秒后执行，每两秒执行一次
                timer.cancel();                # 停止任务
                
                Timer的任务类
                        class MyTask extends java.util.TimerTask{ 
                        @Override
                        public void run() { 
                            // TODO Auto-generated method stub
                            System.out.println("________");
                        }
                    }                        
    序列化
        需要序列化的对象
                如
                        spring中配置的bean
                        session中用到的类

        为什么实现序列化接口
                为了注册序列化序号（不显式注册会自动注册）来标识java类，区分相同类名不同包名的类
    线程与进程
        方法1：
        new Thread(){
                public void run(){
                        while(count > 0){
                                synchronized(AboutThread.class){
                                        count--;
                                        System.out.println(currentThread() + ": 售出1张，剩余： " + count);
                                }
                        }
                        
                }
        }.start();
        
        方法2：用实现 Runnable接口的类重写线程中的run()方法，因为有时候不能重新定义类的父母，或者不能定义派生的线程类，也许类的层次要求父类为特定的类。就用该方法重写该线程的run方法实现运行自己的线程方法
        new Thread(new Runnable() {
                public void run() {
                        while(count > 0){
                                synchronized(AboutThread.class){
                                        count--;
                                        System.out.println(Thread.currentThread() + ": 售出1张，剩余：" + count);
                                }
                        }
                }
        }).start();
    静态路经
        Thread.currentThread().getContextClassLoader().getResource("/").getPath()
    异常
        异常机制：程序出现错误后程序如何处理，控制权交给异常处理器。(异常都是在运行中的，不是编译时的)

        异常处理流程：遇到错误，方法立即结束，同时抛出一个异常对象。调用该方法的程序停止，并搜索一个可以处理该异常的，并执行其中的代码。

        Throwable
                Error
                Exception
                        Error及RunTimeException及其子类为未检测异常,及自己会跑出不需要程序员抛出；而其他为已检测异常，需要程序员抛出。

                        1、Error体系描述了java运行中的内部错误以及资源耗尽的情形，一般由虚拟机抛出。
                        2、Exception体系包括RunTimeException和其他非RunTimeException体系：
                                (1)RunTimeException体系包括错误的类型转换、数组越界访问和试图访问空指针。 一定是程序员的错误。
                                        例如可以通过检查数组下标和数组边界来避免数组越界访问异常。
                                (2)其他一般都是外部错误，例如试图从文件尾后读取数据，
                                        这并不是数据本身的错误，而是在应用环境中出现的外部错误。

        Exception不能捕获的异常
                属于Throwable但是不属于Exceptio的异常，如invocationtargetexception，不能捕获
                解决办法
                        catch(Throwable t)        {  }

        异常处理:

            1、既然捕获了异常，就要对它进行适当的处理。不要捕获异常之后又把它丢弃，不予理睬。

            2、在catch语句中尽可能指定具体的异常类型，必要时使用多个catch。不要试图处理所有可能出现的异常。

            3、保证所有资源都被正确释放。充分运用finally关键词。
        
            4、在异常处理模块中提供适量的错误原因信息，组织错误信息使其易于理解和阅读。
                        例如当前正在执行的类、方法和其他状态信息，包括以一种更适合阅读的方式整理和组织printStackTrace提供的信息。 
                5、尽量减小try块的体积。

            6、全面考虑可能出现的异常以及这些异常对执行流程的影响。
            
        常见异常
                
                算术异常类：ArithmeticExecption
                
                空指针异常类：NullPointerException
                
                类型强制转换异常：ClassCastException
                
                数组负下标异常：NegativeArrayException
                
                数组下标越界异常：ArrayIndexOutOfBoundsException
                
                文件未找到异常：FileNotFoundException
                
                方法未找到异常：NoSuchMethodException
                
                java.lang.OutOfMemoryError                                                        # 内存溢出
                java.lang.StackOverflowError                                                # 堆溢出 
                ParseException                                                                                -->        解析时间字符串到时间类型出错
                ServletException                                                                        -->        servlet转发时出现过该异常
                IOException                                                                                        -->        io异常
                java.sql.BatchUpdateException                                                -->        sql批处理
                SQLException                                                                                -->        sql语句出错
                java.lang.IllegalStateException                                                --> servlet过滤器中 chain.doFilter中request,response类型为ServletRequest，ServletResponse时出错
                com.mysql.jdbc.MysqlDataTruncation                                        --> mysql 插入数据被截断,插入数据过长时遇到
    类加载器   
        原理
                委托机制
                        jvm加载一个类时，派出哪个类加载器加载
                                当前线程类加载器加载线程中的第一个类
                                        线程.setContextClassLoader(ClassLoader cl)指定一个线程的类加载器
                                类A引用了类B, jvm使用加载类A的加载器加载类B
                                可以直接调用ClassLoader.loadClass()方法指定类加载器加载某个类
                        类加载器加载类时，优先委托其上级类加载器
                                所有上级类加载器没有加载到类时，回到发起者类加载器，还加载不了，抛出ClassNotFoundException。
                                不会找发起者的儿子，因为没有getChild方法
                        
        三种类加载器(加载类文件位置不同)
                层级关系
                        BootStrap
                                ExtClassLoader
                                        AppClassLoader
                                                自己的类加载器
                        # 父级类加载器向下加载子加载
                优先级
                        只加载层级关系靠前面的同名类

                BootStrap
                                # c写的二进制代码，jvm中自带
                        位置
                                JRE/lib/rt.jar
                        代码
                                System.class.getClassLoader()
                                        # null
                                        ## 说明是BootStrap类加载器加载的，不能得到该类加载器
                ExtClassLoader
                        位置
                                JRE/lib/ext/*.jar
                AppClassLoader
                        位置
                                CLASSPATH指定的所有jar或目录
                        代码
                                ClassLoaderText.class.getClassLoader().getClass().getName()
                                        # AppClassLoader
        api
                TestClass.class.getClassLoader()
                        getParent()                        # 得到加载该类加载器的类加载器
                        loadClass(String name)                # 找parent委托，没有加载时执行findClass(String name)
                                                                ## 模板方法的设计模式，见 note-> 设计模式
                        findClass(String name)                # 自己加载                
                        defineClass(..)                                # 将二进制数据转换为class
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
        wsdl.xml                #　web service提供给不同平台生成解决方案的配置文件
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
                                        # 缺点
                                        ## 新版浏览器（ie10等）不支持跨域请求(为了安全)，所以只能请求localhost
                                        ## 会把数据暴露在客户端
    注解   
        @WebMethod(exclude=true)                # 对此方法不进行发布
        @WebService                        # 声明为web service服务类
                                                ## 可选属性
                                                        name="服务名",
                                                        portName="端口名",
                                                        serviceName="真正服务类的名字",
                                                        targetNamespace="包名a.b.c"
        @WebResult(name="")                # 方法返回值类型前，指定返回值名（如果返回的是集合，则指定的是集合内元素的名）
        @WebParam(name="")                # 方法参数值类型前，指定参数名

# 疑难
    泛型不能强转
        Map<String,Object> map = request.getParameterMap();    # 错误，getParameterMap()得到的是Map<String,String[]>类型，虽然String[]类型是Object,但是不能强转
        
    类继承 
        被继承的对象是会单例，不会新创建。如果被继承的对象没有，则创建一个

    同文件中的类
        同一个文件中属性不为public的类，会加上public 的类的类名和$在前面，所以不能用其类名.class来得到它的字节码

    发布空文件夹
        上传给服务器的文件存到服务器的目录中，当重新发布工程后目录会被覆盖，文件也就没有了

    父类可以通过反射泛型类得到泛型的class, 通过该class创建泛型实例
        方法泛型类实例通过传入class创建(如dbutils)
# 框架
    cglib
        # 构造接口
    dbutils
    fastjson
        # 淘宝json
    beanUtils
    ioUtils