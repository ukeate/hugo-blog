# 基础
    特点
        容器, 也容纳管理了第三方框架         # 目的是解耦框架api
        轻量级，模块化，无(少)侵入
    IOC(inversion of control)
        容器用工厂装配对象并管理, 面向接口编程
        优点
            降低代码量
            容易测试
            最小侵入性松耦合
        方式
            Setter
            构造器
            静态工厂、实例工厂
    DI(dependency injection)
        容器向类添加属性        # 反射，用带参构造或set方法
    AOP(aspect oriented programming)
        # 继承是纵向组织，AOP横切入业务
        # oop是静态概念，aop是动态概念（aop的切面可以替换或不使用）
        动态代理实现切入代码
            权限控制
            事务管理
            记录日志
        概念
            连接点:普通方法
            切入点:名称满足条件的连接点
            增强（通知）类:服务对象
                # 切入点与增强是多对多的
            切面:切入点 + 增强类                        # 我们切入的是横切面
            目标对象（服务对象）：要注入的对象
        通知
            before              # 执行前
            after               # 执行后
            after-returning     # 正常退出
            after-throwing      # 异常退出
            around              # 执行前后
            代理对象(业务对象)：被注入的对象
    模块
        dao
        orm
        aop
        jee
        web
        core
    结构
        核心容器(core container)
            Core        # 最底层，资源访问，类型转换
            Beans       # IOC, DI, BeanFactory
            Context     # 以Core、Beans为基础，ApplicationContext。资源绑定，数据验证，国际化，JavaEE支持，容器生命周期，事件传播
            EL          # 表达式语言
        AOP, Aspects    # Aspects对AspectsJ集成, 功能多于spring asp
        数据访问/集成
            JDBC
            ORM
            OXM         # object xml 映射
            JMS         # 消息与异步通信
            事务
        Web/Remoting
            Web             # ioc窗口，rmi, hessian,burlap, web service
            Web-Servlet
            Web-Struts
            Web-Porlet      # portal认证
        Test
    设计模式
        代理
            目标对象实现接口，使用Proxy
            未实现接口，使用CGLIB
        单例
            bean默认单例
        模板, 解决代码重复问题
            RestTemplate, JmsTemplate, JpaTemplate
        控制器
            DispatherServlet对请求分发
        视图帮助(view helper)
            提供jsp标签、高效宏 帮助在视图中写代码
        依赖注入
            BeanFactory, ApplicationContext核心理念
        工厂
            BeanFactory
    版本
        2.5
            注解
        3.2
            基于注解的注入测试类@RunW..
    整合配置
        spring boot
            # 用于在maven中快速构建spring项目
        spring integration
# 使用
    jar包 ：
        核心包：/dist/modules                # 或是/dist中的spring.jar包
            core模块
                beans
                context
                context-support
                core
        日志包：/lib/jakata-commons/commons-logging.jar
    创建xml文件(最好在JavaBean的旁边)
        绑定约束文件        /dist/resources/spring-beans-2.5.xsd
        copy xml文件的头：/sample/petclinic/war/web-inf/app...xml
        创建JavaBean.java
        xml文件中配置bean                # src下
            <bean id="" class="">                # id值唯一,class指定 javaBean的类目录
                <property name="" value="">
                <property name="" ref="girlID">                # 引用类型，其中girlID为spring配置的bean Id
    业务类中
        ApplicationContext ac = new ClassPathXmlApplicationContext(new String [] {"配置xml文件路径"})
            # 注意：ac创建时，其内部的JavaBean默认全部实例化一遍，并且全部注入了属性
            ## 该容器不用关闭
        if(ac.containsBean("boyID")){
            Boy boy = (Boy)ac.getBean("boyID");
        }
# api
    ApplicationContext是一个接口，表示spring容器/ioc容器

    ClassPathXmlApplicationContext        # 只从类路径中读取xml配置文件（src/目录下能访问的路径）省略src/目录

    FileSystemXmlApplicationContext                # 文件路径 ,从src/开始

        ac.getBean("boyID")
        ac.containsBean("boyID")                # 通过此方法去判断是否存在 ，而不是得到的是否为null
        ac.destroy()                                        # ac中的bean实例全部销毁

    BeanFactory
        # 基础IOC容器, 默认延迟初始化
        DefaultListableBeanFactory
        ApplicationContext
        XmlBeanFactory      # 根据xml中的定义加载bean
    Spring-DAO      # 提供规范, 翻译框架(JDBC<Hibernate,JPA等)异常为DataAccessException
        @Repository 注解DAO类
    Spring-JDBC     # 模板类
        DataSource
        JdbcTemplate
        JdbcDaoSupport  # 对dao扩展, DataAccessExceptions异常翻译器
    Spring-ORM      # 统称，对各模块(JPA,JDO,Hibernate,iBatis,TopLink,OJB)实现了spring的集成类
        把DataSource注入到SessionFactory或EntityManagerFactory等bean中     # jdbc不需要，因为jdbc直接使用DataSource
        HibernateTemplate
        HibernateDAOSupport     # 继承它提供aop拦截器
    Web
        # 在ApplicationContext基础上, 提供web上下文和面向web的服务
        ApplicationContext      # 以BeanFactory为基础,容器启动后默认全部初始化绑定
            FileSystemXmlApplicationContext     # 指定文件
            ClassPathXmlApplicationContext      # 从classpath找设置
            WebXmlApplicationContext
# 注解
    applicationContext.xml
        <context:annotation-config/>
        <!-- 添加注解扫描功能,启动的时候哪些包要检查是否有注解 -->
        <context:component-scan base-package="xxx" />


    @Required           # setter
    @Autowired          # setter、构造方法、变量
    @Qualifier
    @Bean               # 返回对象注册为bean
    @Configuration      # bean定义

    @Service            # 添加类名小写的spring bean id        也可以@Service(value="xx")自定义id
                        ## action类前换成@Controller                @Service也是可以的
    @Scope(value="prototype")
                        # 工具类或其它组件类换成@Component 也可以@Service,如定时器TimerTask就是组件
    @Resource           # 按属性名注入资源

    测试类
        @RunWith(SpringJUnit4ClassRunner.class)
        @ContextConfiguration(locations = "classpath:applicationContext*.xml")


    @PostConstruct      # 类加载时运行的方法，相当于xml中配置的init-method
    @PreDestroy         # 类销毁前运行的方法

    aop
        applicationContext.xml
            <aop:aspectj-autoproxy/>

        @Aspect
            # 注册一个类为切面

        @Pointcut(value="execution(* cn.it.shop.service.impl.GoodsServiceImpl.save(..))")
            # 配置切点表达式
        private void testAop(){}

        @AfterReturning(pointcut="execution(* cn.it.shop.service.impl.GoodsServiceImpl.save(..))")
            # 配置通知，在通知中配置切点
        @AfterReturning(value="testAop()")
            # 配置通知，使用已经配置的切点
        @Around(value="testAop()")
            # 配置通知，使用已经配置的切点
        @Around(value="execution(* cn.it.shop.service.impl.GoodsServiceImpl.queryByWord(..))")
            # 配置通知，在通知中配置切点,注意这里没有pointcut,只有value

# 监听器
    原理
        org.springframework.web.context.ContextLoaderListener中
            this.contextLoader.initWebApplicationContext(event.getServletContext());
                # 加载Spring 的配置文件 ，加载Application内置对象中
        initWebApplicationContext方法中
            this.context = createWebApplicationContext(servletContext, parent);
            servletContext.setAttribute(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE, this.context);
                # 创建并存储spring的application内置对象到ServletContext中，属性名称是WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE
        createWebApplicationContext方法中
            wac.setConfigLocation(sc.getInitParameter(CONFIG_LOCATION_PARAM));
                # 该类文件中有：public static final String CONFIG_LOCATION_PARAM = "contextConfigLocation";
                # 获得web.xml中配置的context-param初始化参数：contextConfigLocation的内容，并加载spring配置文件

    使用
        servletContext.getAttribute(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);

        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(servletContext)
# 事务
    TransactionInterceptor
        transactionManager          # 指定事务治理类
        transactionAttributes       # key方法名 value事务属性
    注解
        @Transactional(propagation = Propagation.REQUIRED)
    手写      # TransactionDefinition
        Public class BankServiceImpl implements BancService{
            Private BanckDao bankDao;
            private TransactionDefinition txDefinition;
            private PlatformTransactionManager txManager;
            public boolean transfer(Long fromId, Long toId, double amount) {
                TransactionStatus txStatus = txManager.getTransaction(txDefinition);
                boolean result = false;
                try {
                    result = bankDao.transfer(fromId, toId, amount);
                    txManager.commit(txStatus);
                } catch (Exception e) {
                    result = false;
                    txManager.rollback(txStatus);
                    System.out.println("Transfer Error!");
                }
                return result;
            }
        }
    手写      # TransactionTemplate
        public class BankServiceImpl implements BankService {
            private BankDao bankDao;
            private TransactionTemplate transactionTemplate;
            public boolean transfer(final Long fromId, final Long toId, final double amount) {
                return (Boolean) transactionTemplate.execute(new TransactionCallback(){
                public Object doInTransaction(TransactionStatus status) {
                    Object result;
                    try {
                        result = bankDao.transfer(fromId, toId, amount);
                    } catch (Exception e) {
                        status.setRollbackOnly();
                        result = false;
                        System.out.println("Transfer Error!");
                    }
                    return result;
                }
                });
            }
        }
    配置      # TransactionInterceptor
        <bean id="transactionInterceptor" class="org.springframework.transaction.interceptor.TransactionInterceptor">
            <property name="transactionManager" ref="transactionManager"/>
            <property name="transactionAttributes">
                <props>
                    <prop key="transfer">PROPAGATION_REQUIRED</prop>
                </props>
            </property>
        </bean>
        <bean id="bankServiceTarget" class="footmark.spring.core.tx.declare.origin.BankServiceImpl">
            <property name="bankDao" ref="bankDao"/>
        </bean>
        <bean id="bankService" class="org.springframework.aop.framework.ProxyFactoryBean">
            <property name="target" ref="bankServiceTarget"/>
            <property name="interceptorNames">
                <list>
                    <idref bean="transactionInterceptor"/>
                </list>
            </property>
        </bean>
    配置      # TransactionProxyFactoryBean
        <bean id="bankServiceTarget" class="footmark.spring.core.tx.declare.classic.BankServiceImpl">
            <property name="bankDao" ref="bankDao"/>
        </bean>
        <bean id="bankService" class="org.springframework.transaction.interceptor.TransactionProxyFactoryBean">
            <property name="target" ref="bankServiceTarget"/>
            <property name="transactionManager" ref="transactionManager"/>
            <property name="transactionAttributes">
                <props>
                    <prop key="transfer">PROPAGATION_REQUIRED</prop>
                </props>
            </property>
        </bean>
    配置      # tx空间
        <?xml version="1.0" encoding="UTF-8"?>
        <beans xmlns="http://www.springframework.org/schema/beans"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:aop="http://www.springframework.org/schema/aop"
            xmlns:context="http://www.springframework.org/schema/context"
            xmlns:tx="http://www.springframework.org/schema/tx"
            xsi:schemaLocation="
                http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop-2.5.xsd
                http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-2.5.xsd
                http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-2.5.xsd
                http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx-2.5.xsd">

        <!--配置c3p0连接池-->
        <!-- 配置JdbcTemplate类 -->
        <!-- 配置Dao -->
        <!-- 配置jdbc事务管理器 -->
        <bean id="dataSourceTransactionManagerID" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
            <property name="dataSource" ref="comboPooledDataSourceID"/>
        </bean>

        <!-- 配置事务增强(服务对象) -->
        <tx:advice id="txAdvice" transaction-manager="dataSourceTransactionManagerID">
        <tx:attribute>
            <tx:method name="addUsers"                      # 可以用通配符"*users"
                    propagation="required"                  # 传播行为：事务开始、结束的时间。required 保证方法执行时事务已开始，事务开始时不创建，没有开始时创建
                    isolation="default"                     # 隔离级别
                    timeout="-1"                            # 事务超时,-1代表不超时，用数据库底层的配置
                    rollback-for:"java.lang.Exception"      # 何时回滚
                    read-only="false"                       # 不只读
                        # name 方法名的匹配模式
                        # required : 外部存在事务，则加入外部事务，不存在则新建事务
                        # requires_new : 总是新建事务
                        # mandatory : 外部必须存在事务
                        # never : 外部不能存在事务
                        # supports : 外部存在则加入，不存在则不以事务方式运行
                        # not_supported : 总是非事务
                        # nested : 外部存在事务，嵌套执行，不存在则新建
                        # no-rollback-for 以逗号分隔异常，这些异常不会导致事务回滚
                        # rollback-for 导致事务回滚的异常
            />
        <tx:attribute>

        <!-- 配置AOP -->
        <aop:config>
                <aop:pointcut id="xxxx" expression="execution(public void *Users(..))"/>
                ##
                任意公共方法的执行：
                execution(public * *(..))
                任何一个以“set”开始的方法的执行：
                execution(* set*(..))
                AccountService 接口的任意方法的执行：
                execution(* com.xyz.service.AccountService.*(..))
                定义在service包里的任意方法的执行：
                execution(* com.xyz.service.*.*(..))
                定义在service包和所有子包里的任意类的任意方法的执行：
                execution(* com.xyz.service..*.*(..))
                定义在pointcutexp包和所有子包里的JoinPointObjP2类的任意方法的执行：
                execution(* com.test.spring.aop.pointcutexp..JoinPointObjP2.*(..))")

                <!-- 将事务代码切入点addUser()方法中，从而产生事务 -->
                <aop:advisor advice-ref="txAdvice" pointcut-ref="xxxx"/>
        </aop:config>
# aop
    实现      # 基于Aspectj

    原理
        启动容器时，创建目标对象与代理对象
        <aop:config/>加载完时,通过cglib创建目标对象的代理对象，运行时产生
        程序员-代理对象-代理方法-目标对象-目标方法-代理对象

    使用
        写类文件
        1.jar包  aspectjweaver.jar/aspectjrt.jar/cglib-nodep-2.1_3.jar(动态代理包)
        2.配置xml文件头,保留aop
            <bean id class/>        # 目标对象
            <bean id="serviceBeanID" class />    # 配置增强对象
            <aop:config>            # 相当于创建了代理对象
                <aop:pointcut id="xxxx" expression="" />        # 切入点表达式：expression="execution(public void addUser() throws java.lang.Exception)"
                        ## 可以写成execution(public void 类名.*()),表示匹配所有方法
                        ## execution(* *(..))        第一个*是返回值，第二个*是方法，..表示参数不限
                        ## 可以声明抛异常
                        ## 条件命名为xxxx,升级连接点到切入点
                <aop:aspect ref="serviceBeanID">
                    <aop:before method="writeLog" pointcut-ref="xxxx"/>    # 前置增强，method是注入的方法，xxxx是增强的条件,只能写一个方法
                    <aop:after/>
                    <aop:after-returning/>      # 方法返回后执行
                    <aop:after-throwing/>      # 抛出异常时执行
                    <aop:around/>              # 环线，执行目标方法前、后都执行,出错则之后的函数不执行
                        public void both(ProceedingJoinPoint pjp){      # ProceedingJoinPoint是连接代理对象 与目标对象的桥梁
                            open();
                            pjp.proceed();      # 执行目标代码
                            close();
                        }
                        # 目标方法出错，后置增强仍然执行,after-throwing执行，前置增强不执行,after-returning不执行
                        <aop:advisor advice-ref="txAdvice" pointcut-ref="xxxx"/>                # 配置事务的切面
    切入点表达式
        execution(方法的修饰符 方法的返回值类型 方法所属的类 方法名 方法中参数列表 方法抛出的异常)
            方法的修饰符：    支持通配符*，可省略
            方法的返回值类型：支持通配符*，表示所有返回值，不可省
            方法所属的类：    支持通配符*，可省略
            方法名：          支持通配符*，表示所有方法，不可省
            方法中参数列表：  支持通配符*，不可省
                    # *表示【一个】任意类型的参数
                    ## ..表示零个或一个或多个任何类型的参数【提倡】
        execution(方法的返回值类型 方法名（方法中参数列表））                # 一般形式

        例如:
                execution(public void add()throws Exception)
        execution(public void add(..)throws Exception)
        execution(public void add(*)throws Exception)
        execution(* cn.itcast.web.spring.aop.UserDao.add(..))
        execution(* add()throws Exception)
        execution(public void *(..)throws Exception)
                execution(public void a*(..)throws Exception)：方法名以a字符开始
        execution(public void *d(..)throws Exception)：方法名以d字符结束
        execution(* add())
        execution(* *(..))
            
    切点方法的编写
        public void Xxx(JoinPoint joinPoint){
            joinPoint.getTarget();                # 获取目标对象
            joinPoint.getSignature();        # 获取当前连接点的方法信息
            joinPoint.getArgs()[0];                # 获取当前连接点的第一个参数
            ..
        }
        public Goods Yxx(ProceedingJoinPoint joinPoint){
            Object object = joinPoint.proceed();        # 得到连接点的返回值
            ..
            return goods;                # 本切面返回的数据会作为切点返回的数据返回给调用它的函数
        }
# bean
    创建bean的顺序
        xml中按配置顺序的先后
        注解中按照字母的顺序
    生命周期
        配置中定义<bean></bean>
        初始化
            配置文件中init-method
            实现org.springframework.beans.factory.InitializingBean接口
        调用
        销毁
            配置文件中destroy-method
            实现org.springframework.bean.factory.DisposeableBean
    scope
        # 默认singleton
        prototype   # 每次产生新对象
        singleton   # 单例
        request     # 一个请求一个对象，只在ApplicationContext下有效
        session     # 一个session一个对象，只在ApplicationContext下有效
        global-session      # 一个全局session一个对象, 只在ApplicationContext下有效
    内部bean
        <property>或<constructor-arg>中定义的<bean>,通常匿名
    注入对象
        <list>
        <set>
        <map>
        <props>         # 键值都只能是string类型
    自动装配
        方式
            no      # 不自动装配，通过ref属性指定
            byName
                查找类中setter
                容器中找id
                报空指针
            byType
                容器中找类型      # 找到多个时抛异常
            constructor
                byType带构造函数参数
            autodetect
                先试constructor, 再试byType
        写法
            <bean>属性autowire="byName"
            @Autowired
                类型自动装配
                加上@Qualifier(value="a")
                    @Resource(name="a")注解的name装配
                    byName装配
                    byType装配

    配置
        <?xml version="1.0" encoding="UTF-8"?>
        <beans xmlns="http://www.springframework.org/schema/beans"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:context="http://www.springframework.org/schema/context"
            xsi:schemaLocation="
                http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-2.5.xsd
                http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-2.5.xsd">
            <bean
                id="userDaoID"
                name=""
                class="cn.itcast.javaee.spring.bean.life.UserDao"
                init-method="getSession"
                destroy-method="closeSession"
                factory-method="getUserDao"
                scope="singleton"
                lazy-init="false"
                parent="userDaoID"
                abstract="true"
                autowire="no">
                    <constructor-arg type="java.lang.Integer" index ref>
                        <value>2013</value>
                    <constructor-arg type="java.lang.Double">
                        <value>6000</value>
                    <property name="name" value="aa"></property>
                    <property name="name" ref="dateID" />
                    <property name="telSet">
                    <set>
                        <value>11</value>
                    <property name="cityList">
                    <list>
                        <value></value>
                    <property name="telCityMap">
                    <map>
                        <entry key="">
                            <value></value>
                    <property name="">
                        <props>
                            <prop key=""></prop>
    标签、属性分析
            bean标签：代表一个JavaBean
                            # 多个JavaBean配置时，先配置的先创建，先创建的后销毁
                    id：该JavaBean的唯一标识
                    name：可以和id一样用，但是name可以设置"/a"来绑定路径
                    class：该JavaBean的类路径
                    init-method：创建该JavaBean时运行的其中的方法
                    destroy-method：销毁该JavaBean时运行的其中的方法
                            # ClassPathXmlApplicationContext类的实例不监听销毁方法
                            ## 用AbstractApplicationContext中的close()与registerShutdownHook()方法
                            ## close()直接马上销毁，registerShutdownHook()方法会注册关闭钩子,监听容器的销毁
                            ## 
                    factory-method：创建该Bean的函数
                        得到接口实现类的方法
                        1.通过实现类的无参构造器                # 没有factory-method属性
                        2.没有无参构造器时，工厂静态方法创建实例
                            <bean id="userDaoID" factory-bean="daoFactoryID" factory-method="getUserDao">
                                                    # class中的内容是工厂类，而非UserDao类，factory-method是工厂类中返回UserDao类的静态方法
                        3.没有无参构造器时，工厂非静态方法创建实例
                            <bean id="daoFactoryID" class="cn.itcast.javaee.spring.bean.create.type3.DaoFactory">
                                            <bean id="userDaoID" factory-bean="daoFactoryID" factory-method="getUserDao">
                                                    # 先实例化工厂（Spring 加载本xml文件默认实例化），然后静态方法的配置即可
                    scope：作用域
                            1.singleton（单例）是默认值，是单例的，会调用init destory方法 
                            2.prototype（原型）每次创建一个实例， 调用init方法，但不调用destory方法（实例的维护 ：javase程序交给jvm,javaee程序交给服务器）
                    lazy-init
                            1.false:为启动容器时立即创建一个实例                # singleton与prototype模式都会创建
                            2.true:启动时不加载,获取时创建
                    parent：        继承一个Spring bean(包含其中的所有属性)
                            # javaBean类中不必有实际的继承关系（但是有继承关系则必要配置parent）
                    abstract="true"        : 配置此Bean为抽象Bean
                    autowire="no":自动装配，只能装配关联属性
                                            # 还可以进行注解装配
                                    byName      装配时根据bean中的每个属性名从spring中找id同名的bean,通过setter方法注入到该属性中
                                    byType      根据bean中的每个属性的类型找到spring中映射该类型的bean进行装配,通过setter方法注入到该属性中
                                    constructor 找满参构造器装载，构造器中的参数以byType方式注入
                                    autodetect  先找构造器装载，再set方法注入。但实际使用中只能set方法注入
                                    no          不注入
                    可以配置init-method与destroy-method属性来配置该bean创建和销毁时执行的方法
            注入值                  # 通过setter方法注入值 
                    <constructor-arg type="java.lang.Integer" index ref>        
                            <value>2013</value>                                        # 传入构造方法参数注入值，,位置不能颠倒，不调用setter方法
                                                                                                    ## type是注入参数的类型，index是参数的标号，从0开始，ref是引用类型,有引用类型时不用<value>标签
                    <property name="name" value="aa"/>                # 基本类型直接赋值（包括包装类型与String）
                    <property name="name" ref="dateID"/>        # 引用类型,dateID是一个Spring Bean
                                                                                                    ## 可以直接引用Spring Bean 的id 
                    <set>
                            <value></value>                                                # set集合
                    <list>
                            <value></value>                                                # list集合
                    <map>
                            <entry key="">
                                    <value></value>                                        # map集合
                            # 集合的值均可配置引用类型
                    <property name="">
                            <props>
                                    <prop key=""></prop>                        # 属性类型，只能配置基本类型 （包括包装类型与String）
# dao
    使用
        1.xml文件中
        <!-- 配置C3P0连接池 -->
            <bean id="comboPooledDataSourceID" class="com.mchange.v2.c3p0.ComboPooledDataSource">
                <property name="driverClass" value="com.mysql.jdbc.Driver"/>
                <property name="jdbcUrl" value="jdbc:mysql://127.0.0.1:3306/spring"/>
                <property name="user" value="root"/>
                <property name="password" value="root"/>
                <property name="initialPoolSize" value="60"/>
                <property name="acquireIncrement" value="5"/>
            </bean>

            <!-- 配置JdbcTemplate -->
            <bean id="jdbcTemplateID" class="org.springframework.jdbc.core.JdbcTemplate">
                <property name="dataSource" ref="comboPooledDataSourceID"/>
            </bean>

            <!-- 配置UserDao -->
            <bean id="userDaoID" class="dao.UserDao">
                <property name="jt" ref="jdbcTemplateID"/>
            </bean>
        2.Dao中
            private JdbcTemplate jt;
            addUser()
                String sql = "";
                Object [] params = {user.getUsername(),user.getPassword()}
                jt.update(sql,params);
                批量：
                for(int i = 0; i < ids.length; i++){
                    sqls[i] = "";
                }
                jt.batchUpdate(sqls);
                查询一个
            return (User)jt.queryForObject(sql,params,new RowMapper(){
                    public Object mapRow(ResultSet rs,int rowNum){          # rs是查询出来的结果集,rowNum是结果集的行号,从0开始
                        Integer id = rs.getInt("id");
                        User user = new User(id);
                        return user;
                    }
                    });
                查询多个                # query方法把RowMapper帮助类中返回的user分别加入到list中，返回一个list
                list = jt.query(sql,new RowMapper(){
                        public Object mapRow()
                            ..
                            return bean;
                    })
                分页
                                String sql = "select * from users limit ?,?";
                                Object[] params = {0,3};
                jt.query(sql,params,new RowMapper(){
                记录
                jt.queryForInt(sql);
# properties
    spring xml配置文件中使用properties配置的属性
        配置一个bean的class类是org.springframework.beans.factory.config.PreferencesPlaceholderConfigurer的单例bean
            <property name="locations" value="classpath:public.properties" >
                <array>
                    <value>classpath:conn.properties</value>
            或
            <property name="location" value="classpath:conn.properties" />
        xml文件中用"${driver}"的方式引用properties中配置的属性
    java类中用spring的注解注入properties配置的属性
        # 要求必须是spring管理的类
        bean中的class类换成org.springframework.beans.factory.config.PropertiesFactoryBean
        id="Xxx"其它相同
        java类的属性或set方法上添加注解：
        @Value("#{public.basePath}#{public.filePath}")
            # 其中public 是上面配置的bean的id(xml文件中注入属性的话用不到id,所以没有配置)
            ## '#{}'代表引用属性
            ## '.'可以用'[]'代替，如public[basePath]
            ## 字符串的拼接可以用+连接
            # 第一次配置@Value的时候不会成功，改一次值再试就可以了
# jee
    quartz:定时器
        执行：ApplicationContext类加载后自动执行
        导包：quartz-all.jar包 与  commons-collections.jar包 与 commons-logging.jar
        xml配置：
            <!-- 任务类 ,其中有个叫execute的方法-->
            <bean id="myTaskID" class="jee.quartz.MyTask"/>

            <!-- spring提供专用于定时任务类 -->
            <bean id="methodInvokingJobDetailFactoryBeanID" class="org.springframework.scheduling.quartz.MethodInvokingJobDetailFactoryBean">
                <!-- 要定时执行的实例的spring bean id -->
                <property name="targetObject">
                        <ref bean="myTaskID"/>
                </property>
                <!-- spring bean中定时执行的方法 -->
                <property name="targetMethod">
                        <value>execute</value>
                </property>
            </bean>
            <!-- spring提供专用于任务频率类，给上面的任务指定频率 -->
            <bean id="cronTriggerBeanID" class="org.springframework.scheduling.quartz.CronTriggerBean">
                <property name="jobDetail">
                        <ref bean="methodInvokingJobDetailFactoryBeanID"/>
                </property>
                <property name="cronExpression">
                        <value>0 0/1 * * * ?</value>
                </property>
            </bean>
            <!-- spring提供的专用于任务频率工厂类 -->
            <bean id="schedulerFactoryBeanID" class="org.springframework.scheduling.quartz.SchedulerFactoryBean">
                <property name="triggers">
                    <ref bean="cronTriggerBeanID"/>
                </property>
            </bean>
        任务频率cronTriggerBean的配置：
            cron解析器:
                反斜线（/）字符表示增量值。例如，在秒字段中“5/15”代表从第 5 秒开始，每 15 秒一次。
                问号（?）字符和字母 L 字符只有在月内日期和周内日期字段中可用。问号表示这个字段不包含
                具体值。
                所以，如果指定月内日期，可以在周内日期字段中插入“?”，表示周内日期值无关紧要。字母
                L 字符是 last 的缩写。放在月内日期字段中，表示安排在当月最后一天执行。在周内日期字
                段中，如果“L”单独存在，就等于“7”，否则代表当月内周内日期的最后一个实例。所以“0L”
                表示安排在当月的最后一个星期日执行。
                在月内日期字段中的字母（W）字符把执行安排在最靠近指定值的工作日。把“1W”放在月内
                日期字段中，表示把执行安排在当月的第一个工作日内。
                井号（#）字符为给定月份指定具体的工作日实例。把“MON#2”放在周内日期字段中，表示把任
                务安排在当月的第二个星期一。
                星号（*）字符是通配字符，表示该字段可以接受任何可能的值。
            顺序：秒 分 时 日 月 周 年（年可以忽略）
            例子
                0 0 10,14,16 * * ?                  每天上午10点，下午2点，4点
                0 0/30 9-17 * * ?            朝九晚五工作时间内每半小时
                0 0 12 ? * WED                          表示每个星期三中午12点
                0 0 12 * * ?                          每天中午12点触发
                0 15 10 ? * *                          每天上午10:15触发
                0 15 10 * * ?                          每天上午10:15触发
                0 15 10 * * ? *                  每天上午10:15触发
                0 15 10 * * ? 2013          2013年的每天上午10:15触发
                0 * 14 * * ?                          在每天下午2点到下午2:59期间的每1分钟触发
                0 0/5 14 * * ?                          在每天下午2点到下午2:55期间的每5分钟触发
                0 0/5 14,18 * * ?                  在每天下午2点到2:55期间和下午6点到6:55期间的每5分钟触发
                0 0-5 14 * * ?                          在每天下午2点到下午2:05期间的每1分钟触发
                0 10,44 14 ? 3 WED                  每年三月的星期三的下午2:10和2:44触发
                0 15 10 ? * MON-FRI                周一至周五的上午10:15触发
                0 15 10 15 * ?                          每月15日上午10:15触发
                0 15 10 L * ?                            每月最后一日的上午10:15触发
                0 15 10 ? * 6L                    每月的最后一个星期五上午10:15触发
                0 15 10 ? * 6L 2014-2018        2014年至2018年的每月的最后一个星期五上午10:15触发
                0 15 10 ? * 6#3                        每月的第三个星期五上午10:15触发
                0/1 * * * * ?                        每秒钟触发一次
                0 0/1 * * * ?                        每分钟解发一次
                0 0 0/1 * * ?                        每小时解发一次

    远程调用 (rmi:remote message invoke)                # 相当于webService
        服务端
            1.自定义接口IServer,自定义抽象方法int rax(int)
            2.写接口实现类ServerImpl
            3.配置spring.xml 文件
                <!-- 服务端实现类 -->
                <bean id="serverImplID" class="jee.server.ServerImpl"/>
                <!-- spring提供的专用于RMI服务端注册器 -->
                <bean id="rmiServiceExporterID" class="org.springframework.remoting.rmi.RmiServiceExporter">
                    <property name="serviceInterface">
                            <value>jee.server.IServer</value>
                    </property>
                    <property name="service">
                            <ref bean="serverImplID"/>
                    </property>
                    <property name="serviceName">
                            <value>XXXX</value>
                    </property>
                </bean>
        客户端
            配置spring.xml 文件
                <!-- spring提供专用于RMI远程服务代理工厂类 -->
                <bean id="rmiProxyFactoryBeanID" class="org.springframework.remoting.rmi.RmiProxyFactoryBean">
                    <!-- 协议名://远程提供服务的IP地址:提供服务的端口/提供服务的名称 -->
                    <property name="serviceUrl">
                            <value>rmi://127.0.0.1:1099/XXXX</value>
                    </property>
                    <property name="serviceInterface">
                            <value>jee.client.IServer</value>
                    </property>
                </bean>
        执行：
            服务端加载 ApplicationContext类
            客户端
                加载 ApplicationContext类 ac
                ac.getBean方法中得到RmiProxyFactoryBean实际类型（可变类型）的实例，强转成服务端自定义的接口IServer的实现类（实现类由服务器决定）
                执行IServer实现类中的方法int rax(int)，实现了远程调用
# spring security
    Subject: 主体数据结构, 如用户
    SecurityManager: 安全管理器, 管理所有subject
# spring struts2
    原理
        tomcat启动日志：没有整合时不能加载struts-plugin.xml（spring-struts-plugin.jar包中的配置文件 ）
        struts中struts-default中常量配置加载com.opensymphony.xword2.ObjectFactory类作为默认struts创建action的类
        加载后struts-plugin.xml 中 修改了常量为struts-spring-plugin中的类来创建struts的类，也就是整个struts2创建action类的类被更改了

    整合
        jar包 struts2/lib/struts2-spring-plugin-2.3.1.1.jar                        # 为了在struts的xml配置文件中的class找spring 的容器
        配置web.xml   # \samples\petclinic\war\WEB-INF\web.xml目录下有示例
                                                
            <listener>          # 监听器，web程序启动时加载spring bean
            <listener-class>org.springframework.web.context.ContextLoaderListener
            <context-param>     # （可选）配置spring 配置文件的路径，
                                ## 从示例文件中查到，默认文件目录是/WEB-INF/applicationContext.xml(我们示例文件也是从源码/simple项目下的这个开头的文件中找的)
                <param-name>contextConfigLocation
                <param-value>/WEB-INF/classes/struts2/xxx.xml
        UserAction 中    # 不用值栈是因为通用性
        spring.xml        # action类由spring 产生
            <bean id="userActionID" class="" scope="prototype"/>
        struts2的配置文件中，替换class属性为spring beanid，其它一样
    总结
        spring的web配置是由下向上，一个个依赖注入的过程
            comboPooledDataSourceID ->
            localSessionFactoryBeanID ->
            hibernateTemplateID ->
            SysStaffDaoID ->
            SysStaffServiceID ->
            SysStaffActionID ->
            struts.xml配置中的<action class="SysStaffActionID">
        最后给Dao中的方法加入事务
# spring boot
    介绍
        减少配置, 习惯大于配置
    基础文件
        XxxApplication                  # 程序入口
            @SpringBootApplication      # 类，组合@Configuration, @EnableAutoConfiguration, @ComponentScan
                @EnableAutoConfiguration根据jar包依赖自动配置
                扫描该注解同级下级包的Bean
        XxxApplicationTests             # 空junit测试
        application.properties          # 或application.yml, 放在src/main/resources或config目录下
            server.port=8080                        # 默认8080
            server.servlet.context-path=/hello      # uri前缀
            xxx: 1                                  # 自定义value
                配置文件中用"${xxx}"引用
                类中用@Value("${xxx}")注入到属性
            xx.yy: 1                                # 可用properties类管理属性
                @Component
                @ConfigurationProperties(prefix = "xx")
                public class XxProperties {
                    private String yy;
                    ...getter和setter...
                }


        pom.xml
            <parent>
                <artifactId>spring-boot-starter-parent</artifactId>             # 此父级依赖提供了spring boot的功能, 提供maven依赖, 常用包不用再设置version
            </parent>

    热部署
        pom.xml
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-devtools</artifactId>
                <optional>true</optional>                                       # 热部署
            </dependency>
        application.yml
            spring:
              devtools:
                restart:
                  enabled: true
                  additional-paths: src/main/java
    注解
        控制器
            @RestController             # 类, 组合@Controller与@responseBody
            @RequestMapping("/index")   # 方法, url
        组件
            @Component
            @ConfigurationProperties    # 注入properties对应名称的属性
        属性
            @Value("${xxx}")
            @Autowired                  # 装载bean
    jsp
        pom.xml
            <!-- servlet依赖. -->
            <dependency>
                <groupId>javax.servlet</groupId>
                <artifactId>javax.servlet-api</artifactId>
                <scope>provided</scope>
            </dependency>
            <dependency>
                <groupId>javax.servlet</groupId>
                <artifactId>jstl</artifactId>
            </dependency>

            <!-- tomcat的支持.-->
            <dependency>
                <groupId>org.apache.tomcat.embed</groupId>
                <artifactId>tomcat-embed-jasper</artifactId>
                <scope>provided</scope>
            </dependency>
        application.yml
            spring:
              mvc:
                view:
                  prefix: /WEB-INF/views/
                  suffix: .jsp
        controller类
            @Controller
            public class XxxController {
                @RequestMapping("/xxx")
                public String xxx(Model m) {
                    m.addAttribute("a", 1);
                    return "view1";
                }
            }
        src/main/webapp/WEB-INF/views/view1.jsp
            <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
            jsp ${a}
    mybatis
        pom.xml
            <!-- mybatis -->
            <dependency>
                <groupId>org.mybatis.spring.boot</groupId>
                <artifactId>mybatis-spring-boot-starter</artifactId>
                <version>1.1.1</version>
            </dependency>
            <!-- mysql -->
            <dependency>
                <groupId>mysql</groupId>
                <artifactId>mysql-connector-java</artifactId>
                <version>5.1.21</version>
            </dependency>
        application.yml
           spring:
              datasource:
                url: jdbc:mysql://127.0.0.1:3306/outrun?characterEncoding=UTF-8
                username: root
                password: asdf
                driver-class-name: com.mysql.jdbc.Driver
              jpa:
                hibernate:
                  ddl-auto: update  # 新建连接必要
        pojo/User
            public class User {
                private Integer id;
                private String telephone;
                ...getter, setter...
            }
        mapper/UserMapper
            @Mapper
            public interface UserMapper {
                @Select("select * from user")
                List<User> findAll();
            }
        controller/UserController
            @Controller
            public class UserController {
                @Autowired
                UserMapper userMapper;

                @RequestMapping("/listUser")
                public String listUser(Model model) {
                    List<User> users = userMapper.findAll();
                    model.addAttribute("users", users);
                    return "listUser";
                }
            }
        webapp/WEB-INF/views/listUser.jsp
            <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
            <table align='center' border='1' cellspacing='0'>
                <tr>
                    <td>id</td>
                    <td>name</td>
                </tr>
                <c:forEach items="${users}" var="s" varStatus="st">
                    <tr>
                        <td>${s.id}</td>
                        <td>${s.telephone}</td>
                    </tr>
                </c:forEach>
            </table>