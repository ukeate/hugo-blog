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
        dao, orm, aop, jee, web, core
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
    循环依赖问题
        构造器, 正在创建在Bean池标记，创建完删除标记，标记冲突报错      # 所以用@Autowired决定注入时机，不写在构造方法里
        单例， 三级缓存, 提前暴露使双方都可初始化
        setter, 提前暴露bean
    版本
        2.5
            注解
        3.2
            基于注解的注入测试类@RunW..
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
    @Qualifier("dataSource)                     # 多类配置时，指定使用类
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
# 模块
## 监听器
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
## properties
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
## bean
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
                <value>2013</value>    # 传入构造方法参数注入值，,位置不能颠倒，不调用setter方法
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
## aop
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
## dao
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
## 事务
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
## spring mybatis
    基础
        #与$
            #相当于解析成引号, 防止sql注入
            $变量引用, 不能防止sql注入，用于传入表名之类
        特点
            sql易维护，传参方便
            orm
        Mapper接口
            方法名与配置id相同
            输入输出参数类型对应定义的parameterType类型和resultType类型
            类路径是配置的namespace
        缓存
            # 基于PerpetualCache的HashMap
            一级缓存
                存在本地
                作用域为session, session flush后清空
            二级缓存
                可定义存储服务
                作用域为namespace
                配置
                    <cache/>
                        readOnly="true" 时，缓存实例单例，false时返回缓存拷贝
            更新
                create, update, delete后，作用域下所有select缓存clear
    与hibernate区别
        都通过SessionFactoryBuilder从配置生成SessionFactory, 再生成Session
        都支持jdbc和jta
        mybatis可细致优化sql, hibernate移植性好
        mybatis学习成本低
        mybatis本身缓存不好，hibernate对象维护和缓存好
        hibernate dao层封开发简单(不用维护映射)，crud方便
    使用
        编程
            创建SqlSessionFactory
            创建SqlSession
            执行数据库操作
            session.commit()
            session.close()
        导入ibatis jar包
        配置文件
            SqlMap.properties        # 属性名可以修改
                driver=oracle.jdbc.driver.OracleDriver
                url=jdbc:oracle:thin:@127.0.0.1:1521:orcl
                username=root
                password=root
            SqlMapConfig.xml                # 总配置文件
                <sqlMapConfig>
                    <properties recource="SqlMap.properties"/>
                    <transactionManager type="JDBC">
                            <dataSource type="SIMPLE">
                                <property value="${driver}" name="JDBC.Driver"/>
                                <property value="${url}" name="JDBC.ConnectionURL"/>
                                <property value="${username}" name="JDBC.Username"/>
                                <property value="${password}" name="JDBC.Password"/>
                            </dataSource>
                        <sqlMap resource="Student.xml"/>
                    </transactionManager>
                </sqlMapConfig>
            Student.xml                                # 映射xml文件
                <sqlMap>
                    <typeAlias alias="Student" type="com.Student"/>
                        <select id="selectAllStudent" resultClass="Student">
                            select * from Student
                        </select>
                    </typeAlias>
                </sqlMap>
            辅助类Student.java                 # 要求有无参构造方法
                private sid = 0;
                private String name = null;
                private String major = null;
                private Date birth = null;
                private float score = 0;
        Xxx.java
            private static SqlMapClient sqlMapClient = null;
            static{
                Reader reader = Resources.getResourceAsReader(总配置文件);
                sqlMapClient = SqlMapClientBuilder.buildSqlMapClient(reader);
                reader.close();
            }
            public List<Student> queryAllStudent(){
                List<Student> studentList = sqlMapClient.queryForList("selectAllStudent");
                return studentList;
            }
            @Test
            public void testHere(){
                for(Student student: this.queryAllStudent()){
                    System.out.println(student.getName);
                }
            }
    配置
        sqlMapConfig.xml
            mybatis加载属性顺序
                properties中property中的属性
                properties中resource或url中的属性
                parameterType中传递一属性
                    # properties中配的属性会影响到mapper.xml中${}的sql拼接，因为都是ognl
            配置标签
                properties
                settings
                    # ibatis有性能优化的参数，mybatis会自动调优，不用设置了
                typeAliases
                    # 针对parameterType和resultType指定的类型定义别名
                    # java.lang.Integer在mybatis中默认别名为int
                typeHandlers
                    # 类型处理器，jdbc类型和java类型的转换
                    ## 一般mybatis提供的类型处理器够用了
                objectFactory
                plugins
                environments
                mappers
        mapper.xml
            内容
                #{}接收简单类型, pojo的ognl属性注入
                ${}是字符串的拼接

            SELECT * FROM USER WHERE id=#{id}
            SELECT * FROM USER WHERE username LIKE '%${value}%'
                # sql 注入
        输入输出映射
            parameterType
                java类型
                hashmap
                    # #{key}来取value
                pojo
                包装类型
            resultType
                    # 指定一条数据的类型，在java方法的返回类型中list或pojo来体现数据条数
                    # mybatis判断mapper代理中使用selectOne或者selectType
                pojo
                    # 返回字段可以是别名，但要与pojo中的属性名相同
                    ## 如果有记录返回但没有pojo中匹配的属性名对应，则直接不创建该对象
                java类型
                    # 在返回结果只有一行一列时，可以是简单类型
                hashmap
                    # key是字段的字，value是字段的值
                    ## 多条数据时，list里面存hashmap
            resultMap
                # 查询出来的字段名与pojo属性名不一致
                定义resultMap
                使用resultMap
        动态sql
            <where>
            <if>

            sql片段<sql>

            <foreach>
        高级映射
        缓存
        逆向
            要求
                1. mapper.xml中namespace 写mapper接口
                    <mapper namespace="com.otr.tea.mapper.UserMapper">
                2. mapper.java中方法名与mapper.xml的statementid一致
                3. mapper.java中方法的输入类型与mapper.xml中的parameterType一致
                    # 由于传入的参数只有一个，所以用包装类型的pojo来传多个参数，不利于业务层的可扩展性
                4. mapper.java中方法的返回类型与mapper.xml中的resultType一致
            机制
                如果Mapper中返回类型为pojo, 则调用selectOne, 如果是List, 则调用selectList
    api
        sqlSessionFactory
        sqlSession                        # 是线程不安全的，因为它的类中有数据和属性
                                        ＃ 是多例的，在方法中局部变量使用
            Executor                # 执行器操作数据库（基本执行器，缓存执行器）
        mapped statement                # 封装sql语句、输入参数、输出结果类型

        例子
            InputStream is = Resources.getResourceAsStream("SqlMapConfig.xml");
                # Resources是mybatis提供的资源加载类
            SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(is);
            SqlSession sqlSession = factory.openSession();
            User user = sqlSession.selectOne("test.findUserById", 1);
                ＃ selectList()
                # insert("test.insertUser", user)
                ## sqlSession.commit();
                ## user.getId() 会主键返回
                ### mysql中LAST_INSERT_ID()在insert语句后接着执行可以得到刚刚自成的id
            sqlSession.close();
    案例
        返回id
            mysql
                <insert id="insert" parameterType="com.test.User" keyProperty="userId" useGeneratedKeys="true" >
            oracle
                <insert id="insert" parameterType="com.test.User">
                    <selectKey resultType="INTEGER" order="BEFORE" keyProperty="userId">
                        SELECT SEQ_USER.NEXTVAL as userId from DUAL
                    </selectKey>

                    insert into user (user_id, user_name, modified, state)
                    values (#{userId,jdbcType=INTEGER}, #{userName,jdbcType=VARCHAR},
                    #{modified,jdbcType=TIMESTAMP}, #{state,jdbcType=INTEGER})
                </insert>
## spring struts2
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
## spring mvc
    原理
        DispatchServlet doService()捕获请求, doDispatch()用HandlerMapping映射url得到HandlerExcutionChain(执行链, 包括拦截器和handler)
        handler getHandlerAdapter得到适配器来处理handler, 返回ModelAndView
            # HandlerAdapter分三类: Servlet、Controller, HttpRequest
        DispatchServlet用ViewResolver(视图解析器)解析ModelAndView成View
            # ModelAndView是逻辑视图，DispatchServlet转化成视图View
        返回View
    与struts2区别
        spring mvc方法对应请求, struts2是类
        spring mvc请求是方法调用，struts2创建Action实例
        spring mvc用aop处理请求，struts2用独有的拦截器(interceptor)
        spring mvc入口是servlet, struts2入口是filter
        spring mvc集成ajax(@ResponseBody), struts2需要插件
        spring mvc验证支持JSR303, struts2不支持
        spring mvc与spring无缝
        spring mvc不需要配置
    注解
        @RequestMapping             # url映射
        @RequestBody                # 转换参数到对象
        @ResponseBody               # 返回对象转json

        开启注解处理器
            springmvc.xml
                <mvc:annotation-driven>
    乱码问题
        post
            web.xml中配置CharacterEncodingFilter
        get
            tomcat配置文件修改项目编码
            new String(Request.getParameter("a").getBytes("ISO8859-1"), "utf-8")
## quartz:定时器
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

## 远程调用
    # rmi:remote message invoke
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
## websocket
    handler
        extends TextWebSocketHandler
            @Override
            handleTextMessge()                      # 处理client.send()的数据

            @Override
            afterConnectionEstablished(WebSocketSession)                    # 连接事件

            @Override
            handleTransportError()                  # 出错事件

            @Override
            afterConnectionClosed()                 # 断开事件

            @Override
            supportsPartialMessages()               # 并行处理
    config
        @EnableWebSocket
        implements WebSocketConfigurer
            @Override
            registerWebSocketHandlers()
                registry.addHandler(handler, "/ws")                         # 路由handler
    client
        extends WebSocketClient
            constructor(uri)
                super(new URI(uri))

            @Override
            onOpen()

            @Override
            onClose()

            @Override
            onError()

            @Override
            onMessage()
    service
        init()
            client = new Client("ws://127.0.0.1:8001/ws")
            client.connectBlocking()
        send()
            while(!client.getReadyState().equals(ReadyState.OPEN)){
                log("connecting")
            }
            client.send("")
    runner
        implements ApplicationRunner
            run()
                service.init()
# spring boot
    介绍
        减少配置, 习惯大于配置
        支持groovy, gradle
    命令
        java -jar xxx.jar
            --server.port=8080                                      # --后内容，相当于application.yml设置
            --spring.profiles.active=two                            # 选择applicaton-two.yml配置
## 基础文件
    目录
        src
            main
                java
                    com.outrun
                        XxxApplication
                resources
                    static/
                    templates/
                    application.properties
                    application.yml
                webapp
                    WEB-INF
            test
                java
                    com.outrun
                        XxxApplicationTests
        pom.xml
    XxxApplication.java                                     # 程序入口
        @SpringBootApplication                              # 类，组合@Configuration, @EnableAutoConfiguration, @ComponentScan
            @EnableAutoConfiguration根据jar包依赖自动配置
            扫描该注解同级下级包的Bean
    application.yml                                         # application.yml或application.properties, 放在src/main/resources或config目录下
    pom.xml
## 配置
    区分环境
        application-{profile}.properties                                    # profile比如是dev, test, prod
        设置spring.profiles.active=dev来区分
    加载顺序                                                                 # 为了外部人员维护，可覆盖定义
        命令行
        SPRING_APPLICATION_JSON环境变量, json格式
        java:comp/env的JNDI属性
        java系统属性                                                         # System.getProperties()查看
        系统环境变量
        random.*配置的随机属性
        jar包外文件名, 如application-{profile}.properties
        jar包内文件名
        @Configuration注解类中，@PropertySource修改的属性
        SpringApplication.setDefaultProperties定义的内容
    application.yml
        ---                                                 # ---分隔多个配置，这里相当于建立了application-two.yml文件
        spring:
            profiles: two
        ---
        spring:
            profiles
                active: dev                                 # 配置环境, 加载applicaton-dev.yml
            application:
                name: app1
    pom.xml
        <packaging>jar</packaging>                          # 不用war包部署, 嵌入了tomcat, jar可服务
        <parent>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-parent</artifactId>             # 提供spring boot基础依赖和默认配置
            <relativePath/>                                 # 从仓库查找parent
        </parent>
        <properties>
            <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
            <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
            <java.version>1.8</java.version>
        </properties>
        <dependencies>
        </dependencies>
        <build>
            <plugins>
                <plugin>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-maven-plugin</artifactId>       # 方便启动停止应用, 如mvn spring-boot:run
                </plugin>
            </plugins>
        </build>
## 注解
    @SpringBootApplication                      # spring boot 启动类
        组合了@Configuration, @EnableAutoConfiguration, @ComponentScan
## 类  
    ApplicationRunner                           # 继承该类，注解@Component, 随容器启动运行
        run()
## 插件
### maven
    命令
        mvn spring-boot:run
    pom.xml
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>       # 方便启动停止应用, 如mvn spring-boot:run
        </plugin>
## 组件
    starter POMs            # spring-boot-starter开头的组件
### spring
    配置
        随机数用${random}
            ${random.value} 字符串
            ${random.int} int
            ${random.long} long
            ${random.int(10)} 10以内int
            ${random.int[10,20]} 10到20 int
        application.yml
            aa
                bb: 1                                           # 可用properties类管理属性
            xxx: 1                                              # 自定义value
                配置文件中用"${xxx}"引用
                类中用@Value("${xxx}")注入到属性
                SpEL中用"#{xxx}"引用
        AaProperties.java
            @Component
            @ConfigurationProperties(prefix = "aa")
            public class AaProperties {
                private String bb;
                ...getter和setter...
            }
        注解    
            @Configuration
            @PropertySource(value = "classpath:test.properties")                    # 加载文件, 配合@ConfigurationProperties注入属性
            @EnableConfigurationProperties({ConfigBean.class, User.class})          # 加载bean, 配合@Autowired注入
    基础
        注解
            @Value("${xxx}")
            @Autowired                                  # 装载bean
            @Bean                                       # 实例化Bean, 属性名为方法名
                @Bean
                public RestTemplate restTemplate() {
                    return new RestTemplate();
                }
                相当于
                RestTemplate restTemplate = new RestTemplate();
            @Scope(ConfigurableBeanFactory.SCOPE_SINGLETON)                         # 生命周期
                singleton                               # 单例
                prototype                               # 多例
                request                                 # web程序ContextApplication用, 随请求创建
                session                                 # web程序ContextApplication用, 随session创建
                global session                          # porlet的global用, 其它用降级为session
    实体
        注解
            @Entity                                     # 修饰bean类
            @Id                                         # id属性
            @GeneratedValue(strategy=GenerationType.AUTO)                           # 自增属性
            @Column(nullable = false, unique = true)
    组件
        注解
            @Component
            @ConfigurationProperties(prefix = "my")     # 注入properties对应名称的属性
    dao
        注解
            @Repository                                 # 修饰类
    service
        注解
            @Service                                    # 修饰类
    controller
        注解
            @Controller                                 # 修饰类
### 测试
    pom.xml
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    注解
        @Before
        @Test
        @RunWith(SpringRunner.class)                # 修饰类, 测试spring
        @SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)                 # 修饰类, 测试spring boot
        @LocalServerPort                            # 注入端口号
        @AutoConfigureMockMvc                       # 使用mockMvc, 用@Autowired注入MockMvc
        @WebAppConfiguration                                # 模拟ServletContext
    XxxApplicationTests.java                        # junit测试
        @RunWith(SpringJUnit4ClassRunner.class)
        @SpringApplicationConfiguration(classes = XxxApplication.class)
        @WebAppConfiguration
        public class XxxApplicationTests {
            private MockMvc mvc;
            @Before
            public void setUp() throws Exception {
                mvc = MockMvcBuilders.standaloneSetup(new XxxController()).build();
            }
            @Test
            public void hello() throws Exception {
                mvc.perform(MockMvcRequestBuilders.get("/hello").accept(MediaType.APPLICATION_JSON))
                    .addExpect(status().isOk())
                    .addExpect(content().string(equalTo("hello")));
            }
        }
### 数据库
    pom.xml
        spring-boot-starter-jdbc
        spring-boot-starter-data-jpa                            # spring data JPA
    application.yml
        jpa:
            generate-ddl: false
            show-sql: true
            hibernate:
                ddl-auto: none                          # create时, 第一次create之后update
        datasource:
            platform: h2
            schema: classpath:schema.sql                # 建表
            data: classpath:data.sql                    # 数据
    注解
        @Transactional                                  # 修饰方法，开启事务，或在事务中
#### mybatis
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
        mybatis:
            mapper-locations: classpath:mapper/*.xml        # 指定mapper.xml位置


    mapper.xml                      # 用mbg生成
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
        <mapper namespace="com.outrun.erp.mapper.UserMapper">

            <resultMap id="BaseResultMap" type="com.outrun.erp.entities.User">
                <id column="id" jdbcType="BIGINT" property="id" />
                <result column="name" jdbcType="VARCHAR" property="name" />
            </resultMap>

            <select id="selectUserById" parameterType="long" resultMap="UserMap">
                SELECT name FROM user WHERE id=#{userId}
            </select>

            <insert id="inserUser">
                <selectKey keyProperty="id" resultType="int" order="BEFORE">
                    select field1 from seq1
                </selectKey>
            </insert>

            <sql id="userColumns">
                ${alias}.id, ${alias}.username
            </sql>
            <select id="selectColumns" resultType="map">
                select
                    <include refid="userColumns"><property name="alias" value="tb1"/></include>
                from tb1
            </select>

            <select id="dynamicSql" resultType="User">
                select * from user
                where state = 0
                <if test="title != null">
                    and title like #{title}
                </if>

                <choose>
                    <when test="title != null">
                        and title like #{title}
                    </when>
                    <when test="author != null and author.name != null">
                        and author_name like ${author.name}
                    </when>
                    <otherwise>
                        and featured = 1
                    </otherwise>
                </choose>

                <foreach item="item" index="index" collection="list" open="(" separator="," close=")">
                    #{item}
                </foreach>

                <trim prefix="where" prefixOverrides="and | or">
                    ...
                </trim>

                <bind name="a" value="'%' + _data.getTitle() + '%'" />
                select * from blog
                where title like #{a}
            </select>

            <update>
                update User
                    <set>
                        <if test="username != null">username=#{username},</if>
                    </set>
            </update>

            <cache>                 # 该命名空间缓存
            <cache-ref>             # 引用其它命名空间缓存
            <delete>
            <resultMap>
                <constructor>       # 构造方法
                    <idArg>         # id参数, 标记id帮助提高性能
                    <arg>           # 普通参数
                </constructor>
                <id>                # 标记id帮助提高性能
                <result>            # 普通字段
                <association>       # 关联
                <collection>        # 结构体
                <discriminator>     # 自动映射
            </resultMap>
        </mapper>
    mapper/UserMapper
        @Mapper           # 如果扫描mapper.xml，不用加@Mapper
        public interface UserMapper {
            List<User> selectUserById(@Param("userId") long userId)

            @Select("select * from user")
            List<User> findAll();
        }
    entities/User
        public class User {
            private Integer id;
            private String name;
            ...getter, setter...
        }
    注解
        @Table(name = "user")                   # 修饰类，指定表
        @Id                                     # 修饰属性, 指定主键
        @Column(name = "name")                  # 修饰属性, 指定字段

        @Mapper                                 # 修饰类
        @Select("select * from user")           # 修饰方法
        @Param("userId")                        # 修饰参数
    api
        SqlSessionFactory
            build
            openSession                         # 重载事务方法
        SqlSesion
            selectOne()
            selectList()
            selectMap()
            insert()
            update()
            delete()
            commit()
            rollback()
            clearCache()
            close()
        Mapper
            o->
            @Insert("insert into tb1(id, name) values(#{id}, #{name})")
            @SelectKey(statement="next value", keyProperty="id", before=true, resultType=int.class)
            int insertTable1(String name)
        SQL
            INSERT_INTO()
            VALUES()

            o->
            new SQL(){{
                SELECT("a.name");
                SELECT("a.age");
                FROM("tb1 a");
                WHERE("a.name like ?");
            }}.toString()
        LogFactory
            useSlf4jLogging()
            useLog4jLogging()
            useStdOutLogging()
### web
    # 用的spring mvc
    pom.xml
        <dependency>
            <groupId>org.springframework.boot</groupId>                 # web模块, 有tomcat, spring mvc
            <artifactId>spring-boot-starter-web</artifactId>            # 测试模块, 有JUnit, Hamcrest, Mockito
        </dependency>
    application.yml
        server
            port: 8080                                      # 默认8080
            servlet
                context-path: /hello                        # uri前缀
    注解
        控制器
            @RestController                             # 修饰类, 组合@Controller与@responseBody
            @RequestMapping("/index")                   # 修改类或方法, url
                @GetMapping("/{id}")                    # 相当于@RequestMapping(method=RequestMethod.GET)
                @PostMapping
                @PutMapping
                @DeleteMapping
                @PatchMapping
            @CrossOrigin                                # 修饰方法, 允许跨域
            @RequestBody                                # 修饰方法, 解析body到参数
            @PathVariable Long id                       # 修饰参数, 接收url参数
    内置对象
        ServerProperties                                # 单例可@Autowired, 存端口之类属性
    自实现
        XxxController.java
            @RestController
            public class HelloController {
                @RequestMapping("/hello")
                public String index() {
                    return "hello";
                }
            }
### 日志
    application.yml
        logging:
            level:
                root: INFO
                org.hibernate: INFO
                org.hibernate.type.descriptor.sql.BasicBinder: TRACE
                org.hibernate.type.descriptor.sql.BasicExtractor: TRACE
    注解
        @Slf4j                                      # 修饰类，其中可直接用log变量
        @EnableSwagger2                             # 修饰类
        @Api(tags = "")                             # 修饰类, 文档
        @ApiModel("")                               # 修饰类
        @ApiModelProperty(")                        # 修饰属性
        @ApiOperation(value="", notes="")           # 修改方法, 文档
        @ApiIgnore                                  # 修饰方法, 文档忽略
### jackson
    注解
        @JsonInclude                                # 修饰类, 序列化时包含
            @JsonInclude(JsonInclude.Include.NON_EMPTY)                 # null或""时不序列化
        @JsonIgnore                                 # 修饰属性
### Scheduled
    scheduled
        注解
            @Scheduled                                  # 修饰方法, 定时调度
                @Scheduled(initialDelay = 1000, fixedRate = 1000)
        类
            @Configuration
            implements SchedulingConfigurer             # 配置类
                configureTasks(ScheduledTaskRegistrar)
                    registrar.setScheduler(Executors.newScheduledThreadPool(2));    # worker池
    async
        注解
            @Async                                      # 修饰方法, 异步调用 
        类
            implements AsyncUncaughtExceptionHandler    # 处理@Async异常
                @Override
                public void handleUncaughtException()

            @Configuration
            @EnableAsync
            implements AsyncConfigurer
                @Bean
                @Override
                public Executor getAsyncExecutor()

                @Override
                public AsyncUncaughtExceptionHandler getAsyncUncaughtExceptionHandler()             # 处理无返回值＠Async方法异常
                    return handler
        使用
        @Async
        Future<String> fetch(){
            return new AsyncResult<String>("")
        }
        future = fetch()
        try{
            future.get()
        }

### 热部署
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
### jsp
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
### lombok
    注解
        @Builder                            # 修饰类, 可build方式设置属性
        @Getter                             # 修饰类, 生成getter
        @Setter                             # 修饰类, 生成setter
        @ToString                           # 修饰类, 生成toString方法
        @Data                               # 修饰类, 注入getter, setter, toString
        @NoArgsConstructor                  # 修饰类, 生成无参构造方法
        @AllArgsContructor                  # 修饰类, 生成带所有参数的构造方法
        @RequiredArgsConstructor            # 修饰类, 生成带常量、@NotNull修饰变量参数的构造方法
            @RequiredArgsConstructor(onConstructor_ = @Autowired)               # 构造类时，自动对private final 属性@Autowire

### remote shell
    pom.xml
        spring-boot-starter-remote-shell
### actuator
    pom.xml
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
    原生端点
        应用配置类
            /autoconfig                                 # 自动化配置详情
                positiveMatches	                        # 成功
                negativeMatches
            /beans                                      # 所有bean
            /configprops                                # 属性
            /env                                        # 环境属性
            /mappings                                   # spring mvc映射关系
            /info                                       # 自定义信息，默认为空，用info前缀定义
        度量指标
            /metrics                                    # 程序信息，内存、线程、gc等
                nonheap.*                               # 非堆内存
                gauge.*                                 # http请求性能，如gauge.response表示上次延迟
                counter.*                               # 记录累计，如counter.status.200表示返回200的次数
            /metrics/{name}                             # 查看某项
                /metrics/mem.free
            /health                                     # 启动状态，磁盘空间
                DiskSpaceHealthIndicator                # 低磁盘空间
                DataSourceHealthIndicator               # DataSource连接是否可用
                MongoHealthIndicator
                RabbitHealthIndicator
                RedisHealthIndicator
                SolrHealthIndicator
            /dump                                       # 线程信息
            /trace                                      # 跟踪信息
        操作控制                                         # 用属性配置开启
            /shutdown                                   # 关闭端点
                通过endpoints.shutdown.enabled=true开启
    自定义counter统计
        @Autowired
        private CounterService counterService;
        counterService.increment("didispace.hello.count")
    自定义health检测器
        @Component
        public class RocketMQHealthIndicator implements HealthIndicator {
            private int check(){}
            @Override
            public Health health() {
                int errorCode = check();
                if (errorCode !=0) {
                    return Health.down().withDetail("Error Code", errorCode).build();
                    return Health.up().build();
                }
            }
        }
### spring boot admin 
    application.yml
        spring:
            application:
                name: erp-admin-server
            boot:
                admin:
                    routes:
                        endpoints: env,metrics,dump,jolokia,info,configprops,trace,logfile,refresh,flyway,liquibase,heapdump,loggers,auditevents,hystrix.stream
        endpoints:
            health:
                sensitive: false
                enabled: true
            actuator:
                enabled: true
                sensitive: false
            beans:
                sensitive: false
                enabled: true

### spring initializer
    介绍
        生成spring基础项目
### spring security
    配置
        application.yml
            security:   
                basic:
                    enabled: false                          # 禁用security
    注解
        @EnableWebSecurity                                  # 修饰WebSecurityConfigurerAdapter, 开启web验证
        @EnableGlobalMethodSecurity(prePostEnabled = true)  # 修饰WebSecurityConfigurerAdapter, 开启方法验证
        @PreAuthorize                                       # 修饰controller方法
    api
        Subject                                             # 主体数据结构, 如用户
        SecurityManager                                     # 安全管理器, 管理所有subject
        UserDetails
            getAuthorities()
            getUsername()
            getPassword()
            isAccountNonExpired()
            isAccountNonLocked()
            isCredentialsNonExpired()
            isEnabled()
        GrantedAuthority
            getAuthority()
        WebSecurityConfigurerAdapter
            configure(HttpSecurity)                         # 验证请求
            configure(AuthenticationManagerBuilder)         # 验证数据，需要授权服务配置AuthenticationManager
                userDetailService
                passwordEncoder
            authenticationManagerBean()                     # 指定管理bean
### spring security oauth2
    pom.xml
        spring-cloud-starter-oauth2
    结构    
        OAuth2 Provider
            Authorization Service                           # 授权服务
            Resource Service                                # 资源服务
            Spring Security过滤器
                /oauth/authorize                            # 授权
                /oauth/token                                # 获取token
    授权服务
        applicatoin.yml                                     # server
            security:   
                oauth2:
                    resource:
                        filter-order: 3
        注解
            @EnableAuthorizationServer                      # 修饰AuthorizationServerConfigurerAdapter, 开启授权服务
        api
            AuthorizationServerConfigurerAdapter            # 授权服务配置
                configure(ClientDetailsServiceConfigurer)                           # 客户端信息
                    clientId
                    secret
                    scope
                    authorizedGrantTypes                    # password, refresh_token, client_credentials
                    authorities                             # 具体权限
                configure(AuthorizationServerEndpointsConfigurer)                   # 使用token的服务
                    authenticationManager                   # 密码认证
                        authenticate(Authentication)
                    userDetailService                       # 获取用户数据
                        loadUserByUsername(String)
                    authorizationCodeServices               # 验证码
                    implicitGrantService
                    tokenGranter
                    tokenStore
                        InMemoryTokenStore
                        JdbcTokenStore
                        JwtTokenStore
                configure(AuthorizationServerSecurityConfigurer)                    # 使用token服务的安全策略, 授权服务与资源服务分离时配置
        接口
            Principal /users/current
        测试
            insert into user(username, password) values('outrun', '$2a$10$l7.7AJEHtXukwUZiKAyVSO6lHJOyHhPxHvi7MHawe8SjlOKkCVbAe')
            curl erp-auth-resource:asdf@localhost:9016/uaa/oauth/token -d grant_type=password -d username=outrun -d password=asdf
            浏览器
                url: localhost:9016/uaa/oauth/token
                header
                    'Authorization': 'Basic ' + base64('erp-auth-resource:asdf')
                data
                    username: 'outrun'
                    password: '123456'
                    grant_type: 'password'
    资源服务
        application.yml                                     # client
            security:
                oauth2:
                    resource:
                        user-info-uri: http://localhost:9016/uaa/users/current
                    client:
                        clientId: erp-auth-resource
                        clientSecret: asdf
                        accessTokenUri: http://localhost:9016/uaa/oauth/token
                        grant-type: client_credentials,password
                        scope: server
        注解
            @EnableResourceServer                           # 修饰ResourceServerConfigurerAdapter, 开启资源服务
                                                            # 修饰AuthorizationServerConfigurerAdapter, 因为授权服务提供token获取和验证接口
            @PreAuthorize("hasAuthority('ROLE_ADMIN'))      # 修饰controller方法，验证权限
        api
            ResourceServerConfigurerAdapter                 # 资源服务配置
                configure(HttpSecurity)
                    authorizeRequests                       # 请求放行
        测试
            curl -d "username=outrun&password=asdf" "localhost:9017/user/registry"
            insert into role values(1, 'ROLE_USER'), (2, 'ROLE_ADMIN')
            insert into 'user_role' values(user_id, 2)
            curl erp-auth-resource:asdf@localhost:9016/uaa/oauth/token -d grant_type=password -d username=outrun -d password=asdf
            curl -l -H "Authorization:Bearer 7df6669c-0c86-417b-827f-9a58297f57e5" -X GET "localhost:9017/hello"
    客户端
        注解
            @EnableOAuth2Client                             # 修饰[Oauth2ClientConfig], 客户端
        api
            [Oauth2ClientConfig]                            # 客户端配置, 自定义类，名称任意
                ClientCredentialsResourceDetails            # bean, 资源信息
                RequestInterceptor                          # bean, 保存请求上下文
                OAuth2RestTemplate                          # bean, 用于向授权服务发送请求
    表
        clientdetails
        oauth_access_token
        oauth_approvals
        oauth_client_details
        oauth_client_token
        oauth_code
        oauth_refresh_token
# spring integration
    # 服务编排