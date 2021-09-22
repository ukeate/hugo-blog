
# 基础
    优点
        完全面向对象编程思想，无sql
        减少代码
        控制数据库访问，降低访问数据库的频率（第一次访问后，数据存储在内存的缓存中），提升效率
        hibernate具有独立性（访问层随时可以更换）
    特性
        不写hbm.xml映射文件，而是基于注解的验证
        对象、集合、属性的延迟加载
            dao层之外使用延迟对象时，由于连接已关闭, 会报Nosession异常
    目录
        .                                        # hibernate程序包
        documentation                # 文档
        lib                                        # 所有依赖包
        project                                # 源码文件
    加载顺序
        后面的覆盖前面的
        hibernate.properties中的配置被覆盖
            # 因为该文件中的配置在new Configuration() 的时候就加载，而之后的xml配置文件是调用configuration.addResource()的方法加载的，新加载的配置覆盖了原来的配置   hibernate3.6之后可以基于注解对javaBean的数据进行验证（jsr303标准）
    开发流程
        加载配置: jdbc参数，数据库方言，hbm映射
        创建SessionFactory    # 内有连接池
        创建session
        事务处理
        关闭session
        关闭连接池
    对象状态
        𣊬时态     # 没有OID(持久化标识), 没有关联session
        持久态     # 有OID, 与session关联, 事务未提交
        脱管态     # 有OID, 没有关联session
    缓存机制
        一级缓存(session)
            事务级，事务结束缓存失效    # 请求同一对象，取得同一实例
            总是打开
        二级缓存
            SessionFactory级别，session共享
            缓存散装持久化实例, 有不同缓存策略
            先设置策略，再设置过期时间与cache提供器
        优点
            提高速度、减小压力
            缓存失效时，不立即查找，而是合并sql查找
    查询方式
        HQL
        QBC(命名查询)
        SQL
    get与load
        get立即加载，load延时加载
        get先查一级缓存，再查二级缓存，再查数据库, load查一级缓存，没有时创建代理对象，需要时再查二级缓存和数据库
            # 代理对象只存id
        get没有时返回null, load抛异常
    检索策略            # 取关联对象
        立即检索        # 一次全加载, select多
        延迟检索        # 访问游离状态代理类，需要在持久化状态时已被初始化
        迫切左外连接检索 # 用外连接取代select，全加载
# 优化
    数据库设计调整
    HQL优化
    api正确使用
    配置参数          # 日志、查询缓存，fetch_size, batch_size等
    映射文件优化      # id生成策略，二级缓存，延迟加载，关联优化
    一级缓存管理, 二级缓存策略
    事务控制策略
# 基本概念
    o-> hibernate 相当于dao层，层次划分中是访问层，解决增、删、改、查、批处理五个问题
    o-> hibernate实现orm(对象关系映射标准，完全面向对象编程思想)
        DBUtils与i/mybatis 与hibernate 是同样的，同样实现的是orm标准
        它们的区别在于
            hibernate中不写sql语句
            ibatis中写少量sql语句
            DBUtils中写sql语句
        它们的另一个相同点是
             底层全都是jdbc
    o-> 结构对应 javabean中的 类，对象，属性
             数据库中的            表，记录，字段
    o-> hql        hibernate query language，hibernate自己的sql语言，需要使用antlr jar包中的方法内部转换成sql语言才能使用
    o-> 正向工程：JavaBean生成表，反向工程：表生成JavaBean


# 使用
    1.导入核心包(10 + 1个)
        hibernate3.jar                                # 核心包
        c3p0-0.9.1.jar
        antlr-2.7.6.jar                                # 转换hql到sql
        commons-collections-3.1.jar        # apache的集合增强包
        dom4j-1.6.1.jar
        javassist-3.9.0.GA.jar                # 动态代理
        jta-1.1.jar                                        # java transaction api        处理事务用
        slf4j-api-1.5.8.jar
        log4j.jar
        slf4j-log4j12.jar                        # 三个日志
        +
        mysql-connector-java-5.1.7.bin.jar
            
    2.建立目录
        hibernate.dao
                demo.java
        hibernate.db
                xx.sql
        hibernate.domain
                xx.java
        hibernate.util
                HibernateUtil.java
    3.创建映射文件
        xx.java文件的同目录下，创建
                xx.hbm.xml
    4.创建配置文件
        src/hibernate.cfg.xml        (可变)
        src/hibernate.properties
    5.写提供hibernate session的工具类
        HibernateUtil
    6.demo中用hibernate session创建事务进行数据库操作
        demo.java
# session
    查询不需要事务，其它都需要事务

    流程
        Session session = HibernateUtil.getSession();
        Transaction t = session.getTransaction();
        t.begin();
        session.update(hero);
        session.delete(hero);
        t.comment();
        
    批量
        t.begin();
        session.save(hero);
        t.commit();
        session.clear();
        
        查询
        Query query = session.createQuery(hql);
        List<Hero> heroList = query.list();
        
        查询2
        Query query = session.createQuery(hql);
        query.setString(0,name);                // hql中参数从0开始
        query.setString(1,des);
        Hero hero = (Hero) query.uniqueResult();        // 只有一个结果时使用
        
        修改
        Query query = session.createQuery(hql);
        int i = query.executeUpdate();

    结尾
        }catch(Exception e){
                e.printStackTrace();
                t.rollback();
        }finally{
                HibernateUtil.closeSession(); // session.close();
        }
            
    session
        元素的状态
            # oid: object id,hibernate 的id值唯一并且与表中的数据一一对应
            ## hibernate中分辨数据只看oid
            临时（new），无oid,不在session中.生成sql语句
                持久化（persistence object）：session.save(hero),有oid,在session中;(saveOrUpdate(hero))
                游离：session.evict(hero),有oid,不在session中,session.update(hero)重新持久化
                删除：sesssion.delete(hero),有oid,不在session中,不可恢复,提交后可修改数据库
                    # 隐含将po对象转成持久化状态，并生成delete语句。提交后成delete状态，执行语句
                    ## 临时、持久、游离都可以调用
                    ## 临时调用delete时会删除数据库中相应id的值 ，危险
        函数
            get 与 load
                session.get(hero.class,1),从数据库得到持久状态对象
                    与数据库交互
                    查到时返回po
                    查不到时返回null
                session.load(hero.class,1)
                    不与数据库交互,返回自己创建的po(只有id)
                访问非id值的时候，与数据库交互
            session.clear() # session中的引用变量清空
            session.close() # clear() + 关闭session对象，回收资源，但session非空
            session.isOpen()
            session.flush() # 对session中的更改部分生成相应的sql语句,只在session中，不访问数据库
            session.update()    # 只是将游离重新持久化,不产生sql语句。（执行更新语句时加上它增加可读性）
                                                    ## update()方法执行时会检验一级缓存（session）中是否有 oid相同的po
                                                    ## ,同时会连接数据库，查询一级缓存中po与数据库中记录的一一对应关系
            session.commit()    # flush() + 提交事务
# hibernate.cfg.xml
    必要性
            必须配置

    目录与文件名
            任意，建议 src/hibernate.cfg.xml

    源码中的案例文件：
            \project\tutorials\web\src\main\resources\hibernate.cfg.xml
            \project\etc\hibernate.cfg.xml
    约束文件位置
            hibernate3.jar/org/hibernate/hibernate-configuration-3.0.dtd
    数据库连接属性与方言属性的属性名和值可以查找
            \project\etc\hibernate.properties                # 由于xml文件中配置要覆盖的是hibernate.properties文件中的属性
                                                                                            ## 所以属性内容从hibernate.properties文件的属性中查找
            方言类的位置是：hibernate3.jar/org.hibernate/dialect/中查找到相应的类，
                    这是最终的路径，（oracle的通用方言类的类路径 可以用这种方法找到，hibernate.properties配置文件中没有写）
            
    加载
            该配置文件属于纯人为配置，需要在Configuration类的实例中调用addResource("")方法加载
            addResource()方法中的参数是本配置文件相对于src/目录的全限定名
            
    作用
            1.映射数据库
            2.配置 类-表映射 资源xml文件的路径
            
    内容
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE hibernate-configuration PUBLIC
            "-//Hibernate/Hibernate Configuration DTD 3.0//EN"
            "http://hibernate.sourceforge.net/hibernate-configuration-3.0.dtd">
    <hibernate-configuration>
            <session-factory>
                    <!-- 配置访问数据库需要的属性 -->
                    <property name="connection.driver_class">oracle.jdbc.driver.OracleDriver</property>
                    <property name="connection.url">jdbc:oracle:thin:@localhost:1521:orcl</property>
                    <property name="connection.username">scott</property>
                    <property name="connection.password">tiger</property>
                    <!-- 配置方言 通知hibernate访问哪种数据库的语法结构-->
                    <property name="dialect">org.hibernate.dialect.OracleDialect</property>
                    <!-- 类表映射文件 -->
                    <mapping resource="hibernate/domain/Hero.hbm.xml"/>
            </session-factory>
    </hibernate-configuration>
# hibernate.properties
    必要性
            不必须配置
    位置：
            该文件的位置在src/目录下是不可以改变的，是hibernate加载配置的入口 

    源码中的参考文件：
            /project/etc/hibernate.properties
                    # oracle的通用驱动可以从hibernate3.jar/org.hibernate/dialect包中查找
            
    作用
            1.配置连接的数据库，更换数据库只需要更改配置文件即可
            2.配置数据库方言
            3.其它控制开关

    方言的作用
            更换数据库访问形式，实现通用性

    内容
            hibernate.dialect org.hibernate.dialect.MySQLDialect
            hibernate.connection.driver_class com.mysql.jdbc.Driver
            hibernate.connection.url jdbc:mysql:///outrun
            hibernate.connection.username outrun
            hibernate.connection.password asdf
            hibernate.show_sql true                # 开关：显示实际操作数据库的sql语句
    自动创建表
        hibernate.hbm2ddl.auto=create      # 每次都创建
        hibernate.hbm2ddl.auto=update      # 没有时再创建(有但是结构不同时会按照酌情增加列字段)
                                                                                ## 当更新或插入记录不满足条件时会出错
    缓存
            hibernate.cache.provider_class                # 开启二级缓存中的普通区           
            hibernate.cache.use_query_cache                # 开启二级缓存中的查询区

# HibernateUtil
    目的
            对SessionFactory返回Session的方式进行了重构，通过调用该静态工具方法
            实现只有一个SessionFactory实例，由它产生和销毁很多Session的工厂机制。

    缓存
            SessionFactory 是二级缓存
            Session 是一级缓存
                    # 查询时，先在二级缓存中查找，没有数据时查找一级缓存，最后查询数据库
                    # 缓存中的数据会用镜像联系着数据库，如果数据库有更新，缓存中的数据会自动更新

    SessionFactory对象与Session对象
            SessionFactory:只创建一次，重量级对象，线程安全，可以共享，实例变量，开始时创建 
            Session:创建多次，轻量级对象，线程不安全，不可以共享，局部变量，临时创建 
            

    实现代码
    /**
    * 提供hibernate session 
    * 并且用threadLocal跟踪实现无参删除
    * 
    * @author Administrator
    *
    */
    public final class HibernateUtil {
            // 单例的SessionFactory工厂 
            private static SessionFactory sessionFactory;
            // 单例的ThreadLocal<Session>实例，但是每个调用者都有自己独有的方法？
            private static ThreadLocal<Session> threadLocal;
            /**
            * 解析配置文件（properties,xml）到hibernate 的配置JavaBean,常驻内存
            * 
            */
            static{
                    // 在这里加载了hibernate.properties配置文件（这里可以配置数据库），执行其它配置
                    // 相当于jdbc中的DriverManager类（如果配置了数据库，相当于也注册了连接数据库的类文件 【Class.forName("..Driver")语句 ..Driver 新建实例的时候自动向DriverManager注册自己】）
                    Configuration config = new Configuration();
                    // 这里写xml配置文件对于src/目录的相对路径,加载映射用xml文件
                    config.addResource("hibernate.hbm.xml");
                    // 加载src/目录下的hibernate.cfg.xml配置文件
                    config.configure();                # configure("classpath:hibernate.cfg.xml");
                                                                            1.configure方法中可以加路径
                                                                            2.classpath:代表src/目录
                    // 导入org.hibernate.SessionFactory类而非org.hibernate.classic.SessionFactory类
                    sessionFactory = config.buildSessionFactory();
            }
            /**
            * 从单例工厂中得到被跟踪定位(每个调用者)的Session对象,没有就创建
            * 
            * @return
            */
            public static Session getSession(){
                    /* 根据不同的调用者返回跟踪的不同的Session对象,如果是第一次调用，就创建新的session，绑定到单例的ThreadLocal对象中记录，返回给调用者
                    * 如果不是第一次调用 ，也能返回让其得到原来为它创建的Session对象 
                    */ 
                    Session session = threadLocal.get();
                    if(session == null){
                            session = sessionFactory.openSession();
                            threadLocal.set(session);
                    }
                    return session;
            }
            /**
            * 删除调用者在ThreadLocal实例中的跟踪记录，并且关闭该Session实例
            * 
            */
            public static void closeSession(){
                    
                    Session session = threadLocal.get();
                    if(session != null){
                            session.close();
                            threadLocal.remove();
                    }
            }
    }
# hql
    hql特性
        1.hql是hibernate专用，有专用的技术转换hql到sql,但降低效率
        2.hql完全面向对象,只出现类，属性，操作符和关键字,例如sum(),order by
                而sql是面向关系的语言
    使用语句
            Query query = session.createQuery(hql);
            Customer c = (Customer)query.uniqueResult();        # 只返回一条结果
            List<Customer> list = query.list();                        # 返回多条结果

    常用 api
            session.createQuery()
            session.getNamedQuery()                # 从映射文件中加载<query>标签配置的与<class>标签同级的hql语句
            query.setString("","")
            Object o = query.uniqueResult();
            List list = query.list();
            分页
                    query.setFirstResult(0);        # 开始标号
                    setMaxResults(3);              # 最多显示的条数
            
    query语句                习惯用别名替代类名
                    # from后面出现的是类名，where中比较的是对象属性（已经在映射文件中映射到了表名与字段名）
            占位符
                    冒号占位符
                            "from Customer c where c.name = :cname"
                            query.setString("cname","司马懿");
                    问号占位符
                            "from Customer c where c.name = ?"
                            query.setString(0,"司马懿");
            映射文件中分离hql语句
                            # <query>标签与<class>标签同级
                    <Query name="findCustomerByAge">
            <![CDATA[
                from Customer c where c.age < ? 
            ]]>
            Query query = session.getNamedQuery("findCustomerByAge");
            query.setInteger(0,60);
            查询
                    "from Customer where id = 1"
                "from Customer as c where c.name = '司马懿' "
                "from java.lang.Object"    # 映射中没有，写类的全称。查找 src/hibernate.cfg.xml中加载到内存中的映射的类对应的表中的所有记录
                "from Order o order by o.price desc"
                    投影查询
                            1."select c.name,c.age from Customer c "
                            List<Object[]> list = query.list();        # Object[]中存储的是查询的select 语句中的数值
                            for(Object [] o : list){
                    System.out.println(o[0]);
                    System.out.println(o[1]);
                }
                2."select count(o), sum(o.price),min(o.price) from Order o"                # count()中的是表类名，统计实例数，查询Order表记录对象的个数 
                3."select o.customer.id from Order o"
    用到过的hql
            级联抓取
                    FROM Role r LEFT JOIN FETCH r.privilegeSet WHERE r.id = :id
            级联抓取顶级权限表（去重复）
                    SELECT DISTINCT p FROM Privilege p LEFT JOIN FETCH p.childrenSet WHERE p.parent IS NULL
            级联抓取角色        
                    FROM Account a LEFT JOIN FETCH a.roleSet WHERE a.id = :id
            三级级联抓取                # 对抓取的集合也可以直接抓取下一层
                    FROM Account a LEFT JOIN FETCH a.roleSet r LEFT JOIN FETCH r.privilegeSet WHERE a.login = :login AND a.pass = :pass
# 案例
    编码
        hibernate用用户操作系统的编码作为自己的编码

        mysql5.5中设置编码：根目录下my文件 default-character-set=gbk
# 查询
    hibernate的查询方式
        1.session.get(字节码,1)
        2.session.load(字节码,1)
        3.HQL查询session.createQuery()        session.getNamedQuery()        # 后面是从配置文件中载入hql语句
        4.对象导航，如多表映射中
                # 以对象的形式操作数据库中的表，如
                    ## p是person表的一个对象，c是card（身份证表）表的一个对象，p通过配置外键时定义的属性card得到自己的身份证表对象
                    ## 1.从表对象中：Card c = p.getCard();
                    ## 2.从hql语句中：select o.customer.id,o.customer.name,sum(o.price) from Order o group by o.customer.id
            5.createSQLQuery原生sql语句查询：        # 不要用，用了以后 hibernate跨平台的特性就没有了
                    String sql = "select {a.*} from sysgroup {a} where department regexp ?";
                    Query query = session.createSQLQuery(sql).addEntity("a",SysGroup.class);
                            # addEntity将表的别名与类字节码关联起来（否则返回的表字段数据是Object类型,jsp页面读取时会出错）
    连接查询的hql语法
                    # 只能连接有外键关系的表类，用表类中的关系类来表示第二张表，不能用笛卡尔积查询
                    ## 也就是说只能查一个表类
                    注意
                            hql连接查询的语法中用where替代了sql语法中的on
                            外连接与 sql不同，只能查询与一个表类有关系的外连接表（from语句后面不能写两个表类）
            内连接
                from Customer c join c.orderSet o where c.id = o.customer.id
            外连接                # 这里与 sql不同，只能查询与一个表类有关系的外连接表
                select c.name,count(o.orderno) from Customer c left join c.orderSet o group by c.name;
            自连接
                select a.name, b.name from emp a, emp b where a.mgr=b.id;
# 多表映射
    主控方                # 就是只有主控方的操作成立，非主控方的改变忽略
            inverse="true"
                    # false:主表管理，主表插入成功后，再发送n条更新语句来更新外键
            ## true:从表管理，自己插入时加上：自己javabean中存放的外键关联
                # 所以购物项中要关联购物车，由于购物车中已经一对多购物项，所以形成了双向关联
            有该属性的标签
                    <set>
            缺少主控方出现的问题
                    双向一对多中
                            1.hibernate生成的sql语句产生重复
                            2.主键冲突                # 插入操作时，由于“一”表级联插入“多”表，“多”表也要插入自己，它们的主键是相同的，会引起主键冲突

    级联                # 数据库只有级联删除
            cascade="save-update"  # 插入和更新
                            # 一般使用save-update，因为表一般软删除，（更新也没有，因为主键不更新，但是hibernate没有单save）
        cascade="delete";  # 删除订单，级联删上层客户
        cascade="none"  # 什么都不做（默认）
        cascade="all"  # save-update + delete
            有级联属性的标签
                    class标签下的
                            <set>
                            <one-to-one>
                            <many-to-one>
            注意
                    级联插入的子表的id内容要为空，否则会变成级联更新                # 这里和单个数据插入时设置对象的id属性不起作用【只有hibernate的主键增长策略起作用】是不同的
                    
    单向一对多                        # 集合映射的一种
            “一”的类中
                    private Set<Order> orderSet = new LinkedHashSet<Order>();
            映射xml文件中
                    <!-- set标签用于映射单向一对多 
                        name表示单方的关联属性
                        table表示多方对应表的名字
                        key-column表示多方对应表的外健
                        one-to-many-class表示单方关联属性中的每个元素的类型
                    -->
                    <set name="orderSet" table="ORDERS" cascade="all">
                            <key column="CUSTOMERS_ID"/>
                            <one-to-many class="Order"/>
                    </set>
    单向多对一                        # 常用
            映射xml文件中
                    <!--
                    many-to-one映射多方的关联属性
                    name表示多方的关联属性名
                    column表示多方对应表的外健(存储关联类对应表的主键)
                    cascade 级联
                    lazy表示“一”的类数据是否在一开始的时候就查询                # 如果lazy="proxy"【相当于懒加载】，action类中加载“一”方数据时会出错，因为调用service类结束后线程中的session销毁,延迟加载找不到session会失败
                    fetch表示抓取策略
                                    # 这里产生了hibernate的n+1问题：一条查询语句查出"一"的集合，n条查询语句查出集合中每个元素的一
                            join代表用join语句查询(一条语句),但是hibernate在多对一的时候不支持fetch="join"
                            默认是select，每次查询用一条select语句（多条语句）
                                    解决：自己写新的查询方法查询,执行hql如：FROM Category c LEFT JOIN FETCH c.account
                    -->
                    <many-to-one 
                            name="customer" 
                            column="CUSTOMERS_ID" 
                            cascade="all"
                    />
            
    双向一对多  # 双向映射就存在主控方的问题  
                    ##　主表从表（外键【可以为空】）        
                    ## 集合映射的应用
            1.同时配置单向一对多与单向多对一
            2.在"一"表中配置inverse="true",反转权力，“多”表为主控方
    双向一对一      # 主表从表（从表id既是主键又是外键）
                    ## 双方都是主控方 
        1.两表都配置<one-to-one/>
        2.主表配置cascade
            3.从表中constrained=true属性（主键是否同时为外键约束）
            
    多对多（单向左到右，单向右到左，双向）                # 集合映射的应用
                                                                    ## 多对多关系中一定要有主控方，否则主键冲突问题
            1.创建中间表  
                            # 中间表可以没有自己的JavaBean类文件对应，这时默认有联合主键（联合主键分别是保存的两个外键）
                    students_id
                    teachers_id 
                            # student_id 与 teachers_id为联合主键
                ## sql语句是primary key(student_id,teacher_id);
                    创建中间表原因：
                            之所以中间表是因为两边的表中主键唯一，所以不能在一个记录中对对应另一个表的多个记录
                            中间表相当于把多对多分成两个一对多。
            2.表对象类中都有对方表的set集合 
            3.映射xml中      # 可以用inverse,cascade
                                    ##  cascade="none"时,middle表中的记录也会被删除
                    ## 不配置主控方的话一边更新另一边，另一边也更新自己，会出错
            <set table="MIDDLES" name="teacherSet">
                <key columnet="STUDENTS_ID"/> 
                <many-to-many class="Teacher" column="TEACHERS_ID"/>
            4.dao中
                    在cascade="all"的配置下实现只删除老师与middle表中的教学关系          # 手工解除关系
                            # 不手工解除关系的话， 表记录对象：Teacher t1
                                    ，t1删除时,级联删除middle表中数据，middle表中对应了学生的外键
                                    ，由于多对一级联，会删除学生，由于该学生的主键可能会被middle表中的其它记录作为外键引用，所以不能删除，删除时会出错。 
                    
                    查询1号老师对应的学生,并解除关系 
                            Teacher t1
                            for(Student s: t1.getStudentSet()){
                                s.getTeacherSet().remove(t1);
                            }
                            1号老师解除关系
                            t1.setStudentSet(null);
                            session.delete(t1);
# 缓存
    缓存        
            1.一级缓存(session)中的数据是独享的，二级缓存(sessionFactory)中的数据是共享的
            2.一级缓存中的数据改变时会更新二级缓存(如果二级缓存设置为read-only时，会更新出错)
            3.二级缓存默认不能存po(持久化对象) ，只存放连接数据库的信息和映射文件 
                    # 这时查询数据时的顺序是 一级缓存 -> 数据库
                    
    启用二级缓存                # 开启的二级缓存中可以保存po
                                    ## 二级缓存的两个空间：普通缓存区(get、load)、查询缓存区(query对象查询)
            普通缓存区
            hibernate.properties文件中配置
                hibernate.cache.provider_class 
                        org.hibernate.cache.HashtableCacheProvider                # 只能内存缓存
                        org.hibernate.cache.EhCacheProvider                                # 也能磁盘缓存ehcache的jar包中ehcache-failsafe.xml配置文件中可以查到默认缓存配置
                                                                                # 可以在hibernate的中文官方教程中查到缓存策略提供商的类
                                                                                ## hibernate3.2之前缓存类jar包是集成的，默认是EhCache
                                                                                ## hibernate3.2之后缓存类jar包要自己导入
                                                                                ## ...Provider类并不是实现类，而是桥接类
                cache.use_second_level_cache
                        true                                                # 开启二级缓存（默认是true,但是没有配置缓存提供商之前不开启）
            hibernate.cfg.xml文件中配置使用二级缓存的类              # 可以设置<cache>的标签<class><set>
                                                                                            ## 设置<set>时，set对应表类的也要设置<cache>标签
                    <class-cache usage="read-write" class="pojo.Goods" />
                    usage属性
                            read-only：二级缓存只读(只是不能进行修改，但是从表中读取数据时一级缓存可以向二级缓存中放入数据)
                            read-write:可读写
            查询缓存区（hql语句）：默认不开启
                            # 因为hql命中率低(要求hql语句相同才行，模糊查询每次基本不同),每次查找会到缓存，找不到再到数据库，查询完数据再存入缓存，效率低
                ## 不配置的话查询还会存到缓存，但只提供get使用，hql自己不用
                    1.首先开启普通缓存区（设置了表类可以缓存）
                    2.在query对象中开启查询缓存区
                            query.setCacheable(true);
            查询顺序：一级缓存 -> 二级缓存 -> 数据库

    缓存提供商配置
            ehcache缓存提供商
                    创建src/ehcache.xml配置文件，使用ehcache缓存时会自动加载其中的配置
                            <diskStore path="java.io.tmpdir"/>        # 设置缓存目录，java.io.tmpdir指操作系统的临时目录
                            diskPersistent
                            diskExpiryThreadIntervalSeconds                # 这两个集群中使用，上面是是否集群持久化，下面是设置持久化时间
                            maxElementsInMemory                                        # 内存支持最大对象数目(溢出的对象会存到硬盘中)
                            overflowToDisk                                                # 内在到最大数目时是否缓存到硬盘
                            eternal                                                                # 缓存是否永久有效，如果为true，则timeToIdleSeconds与timeToLiveSeconds不起作用
                            timeToLiveSeconds                                        # 内存中缓存最大存活时间，服务器启动的时间加入其中
                            timeToIdleSeconds                                        # 缓存不被访问时最大存活时间
                            memoryStoreEvictionPolicy                        # 内存中对象的替换算法FIFO(先进先出first in first out) 
                                                                                                    ## LRU(最近最未使用算法,最久没有被访问的对象踢出) 
                                                                                                    ## LFU(最少未被使用算法,考虑了对象的访问频率,踢出最近最少被访问的对象)      
                                                                                                    ## 是windows自己的替换算法
    清空缓存
            一级缓存：session.clear();
            二级缓存：sessionFactory.close();
            
# 集合映射
    作用
            集合包含于表类中，对应其一个属性，相当于该类对应表的一个子表
            每种集合对应一张表，内容对应记录。
            把java类中经常使用的数据结构对应到表中

    使用
            javaBean（User）中
                    private Set<String> telSet = new LinkedHashSet<String>();
                    private List<String> cityList = new ArrayList<String>();
                    private Map<String,String> telCityMap = new LinkedHashMap<String,String>();
            xml文件中
                    <set name="telSet" table="TELS">
                <key column="USERS_ID"/>        # 外键列：集合所创建的表的外键列名
                <element column="TEL" type="string"/>      # 内容列：这里必需要有type 
                        # set中也可以把<element>标签换成<one-to-many class="Order"/>标签来对应JaveBean作为值，这就是一对多的映射
            <list name table>
                <key column/>
                <list-index column="IDX"/>      # 索引列：表中的索引号列(对应在list中的索引)
                <element column type/>
            <map name table>
                <key>
                <map-key type column>                        # map对应key的列
                <element column type>
            dao中使用
                    user.getTelSet().add("131");
# 检索策略
    hibernate检索的两种类型
            立刻检索:session.get,query.list        <class lazy="true">标签中类的检索策略，get方法与list都不遵循
            延迟检索:session.load      # 初始时是代理对象,使用时查询  只有load方法遵循<class lazy="true">标签中类的检索策略
                检索方法是load时
                    lazy属性出现在<class>与<set>标签中,两个标签中lazy属性的含义是不同的，两个lazy属性都是对load方法执行时是否查询数据库进行设置。
                            # <class>标签中lazy的含义是执行load方法时是否懒于查询数据库中除了set集合之外的所有属性
                            ## <set>标签中lazy的含义是执行load方法时是否懒于查询数据库中set集合的数据
                            ## <class>中默认lazy属性的值为true
                            ## <set>中默认lazy属性的值为true
                    true true 时    查类时没有查集合
                    false true 时    查类时没有查集合
                    false false 时    查类时查集合
                    true false 时    查类时没有查集合
# 经验
    删除的两种方法 
            session.delete(session.get(Category.class,id));    # 先查询再删除，效率低
        session.createQuery("delete Categroy c where c.id=:id").setInteger("id",id).executeUpdate();
                        # 执行hql语句，效率高
                        
    hibernate注解
            hibernate3.6支持注解
                    javaee5不支持，默认关闭
                    javaee6支持，默认开启，此时不加载注解配置文件会报错，所以要关掉
                            hibernate.cfg.xml中
                            <property name="javax.persistence.validation.mode">none</property>
                            
    DB Browser反射编译表的生成映射文件和类的时候，会生成项目目录下hibernate.reveng.xml的临时配置文件，可以删掉

    映射文件class属性
            dynamic-update="true"                # 动态更新，只有对相同的session有效，而且性能不好
                                                                    ## 用字段设置中的update="false"（对象中有字段值时更新，没有时不更新）属性来设置动态更新
    映射文件set标签属性
            Order-by="id"                                # set中级联对象按照"id"属性进行排序
# c3p0
    c3p0并不是hibernate默认的连接池（默认的是hibernate自带的连接池算法）
            配置c3p0以后自动关闭Hibernate自带的连接池，而使用c3p0连接池


    hibernate.cfg.xml文件中
            <!-- 最大连接数 --> 
            <property name="hibernate.c3p0.max_size">20</property> 
            <!-- 最小连接数 --> 
            <property name="hibernate.c3p0.min_size">5</property> 
            <!-- 获得连接的超时时间,如果超过这个时间,会抛出异常，单位毫秒 --> 
            <property name="hibernate.c3p0.timeout">120</property> 
            <!-- 最大的PreparedStatement的数量 --> 
            <property name="hibernate.c3p0.max_statements">100</property> 
            <!-- 每隔120秒检查连接池里的空闲连接 ，单位是秒--> 
            <property name="hibernate.c3p0.idle_test_period">120</property> 
            <!-- 当连接池里面的连接用完的时候，C3P0一下获取的新的连接数 --> 
            <property name="hibernate.c3p0.acquire_increment">2</property> 
            <!-- 每次都验证连接是否可用 --> 
            <property name="hibernate.c3p0.validate">true</property> 
    hibernate.properties文件中
            hibernate.c3p0.min_size=5 
            hibernate.c3p0.max_size=20 
            hibernate.c3p0.timeout=1800 
            hibernate.c3p0.max_statements=50 
# 映射
    hbm.xml
        位置与名称：
                domain.xx.java 文件同级目录 xx.hbm.xml

        约束文件位置
                hibernate3.jar/org/hibernate/hibernate-mapping-3.0.dtd
                从其中复制约束头
                
        源码中的案例文件
                \project\tutorials\中搜索 hbm.xml

        类-表映射的特点
                1.映射JavaBean到表字段（动态占位符），可以使用面向对象的hql语名生成sql语句
                2.session中保存类对象，缓存查询过的表的内容
                3.在映射关系的xml文件中可以设置主键的改变方式（这样以后dao类中设置的主键内容被配置文件中的设置覆盖）
                
        主键
                表中的主键
                        自然主键：有业务逻辑含义的字段（如name）（多个自然主键：联合主键）
                        代理主键
                hibernate中id的增加类型
                        increment  整型,不依赖数据库自增,多线程不安全
                    uuid        缺点：占空间
                    identity    整型，依赖数据库自增,线程安全
                    sequence    专用于oracle数据库,要用特定名字的序列，create sequence hibernate_sequence;线程安全
                    native(重点)    根据情况判断是identity或sequence
                    assigned    自然主键：<id name="name" column="name">,线程不安全
                    composite-id    多个自然主键,表的javaBean必须实现序列化(1.对象序列化到硬盘、数据库【其它JavaBean有id属性，hibernate自动实现序列化】2.线程间传递数据)
                        <composite-id><key-property name="firstname" column="firstname"/><key-property name="firstname" column="lastname"/>

        持久化对象的两种类型
                实体型：具有id属性的类，映射成一条含有id主键的完整记录
                值类型或组件：与上面相反(被实体型包含)，如
                                # 包含以后会把组件的属性添加到实体类属性的后面，一起当作一张表，仅此而已
                # Address   
                    province
                    city
                    area
                映射组件型属性
                1.类中引用组件：private Address address
                2.映射 <component name="address" class="Address"><property name column/>
                3.dao中    star.setAdrress(address);
        内容
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE hibernate-mapping PUBLIC 
            "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
            "http://hibernate.sourceforge.net/hibernate-mapping-3.0.dtd">        
        <hibernate-mapping package="hibernate.domain">
                <class name="Hero" table="heros" dynamic-insert="true">
                                        # 设置动态插入为true:如果是null的值，不再插入
                                        ## 如果不设定动态插入，会插入数据库null值，数据库中设定的默认值不会起作用
                        <!-- hibernate通过自己内部的类型type="",来转换java类型与sql类型之间的转换，一般不必写，自动反射 -->
                        <!-- id 是指主键，property是属性 -->
                        <id name="id" column="id">
                                <!-- hibernate内部的主键生成器 -->
                                <generator class="increment"/>
                        </id>
                        <property name="name" column="name"></property>
                        <property name="gender" column="gender"></property>
                        <property name="age" column="age"></property>
                        <property name="birthday" column="birthday"></property>
                        <property name="des" column="des"></property>
                </class>
        </hibernate-mapping>
    javaBean
        实现序列化接口
                在有名为id属性的JavaBean中，hibernate会自动实现序列化接口
                没有名为id属性的JavaBean中，需要我们自己实现序列化接口

        public class Hero implements java.io.Serializable{
                    private Integer id;
                    private String name;
                    private String gender;
                    private Integer age;
                    private Date birthday;
                    private String des;
        }

