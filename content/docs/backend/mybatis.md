---
Categories : ["后端"]
title: "Mybatis"
date: 2018-10-11T15:09:36+08:00
---

# 使用
    1.导入ibatis jar包
    2.配置文件
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
                            <sqlMap resource="Student.xml"/>
            Student.xml                                # 映射xml文件
                    <sqlMap>
                            <typeAlias alias="Student" type="com.Student"/>
                                    <select id="selectAllStudent" resultClass="Student">
                                            select * from Student
            辅助类Student.java                 # 要求有无参构造方法
                    private sid = 0;
                    private String name = null;
                    private String major = null;
                    private Date birth = null;
                    private float score = 0;
    3.Xxx.java
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
# 配置
## sqlMapConfig.xml
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
## mapper.xml
    内容
            #{}接收简单类型, pojo的ognl属性注入
            ${}是字符串的拼接

    SELECT * FROM USER WHERE id=#{id}
    SELECT * FROM USER WHERE username LIKE '%${value}%'
                                    # sql 注入
## 输入输出映射
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
## 动态sql
    <where>
    <if>

    sql片段<sql>

    <foreach>
## 高级映射
## 缓存
## 逆向
    要求
            1. mapper.xml中namespace 写mapper接口
                    <mapper namespace="com.otr.tea.mapper.UserMapper">
            2. mapper.java中方法名与mapper.xml的statementid一致
            3. mapper.java中方法的输入类型与mapper.xml中的parameterType一致
                    # 由于传入的参数只有一个，所以用包装类型的pojo来传多个参数，不利于业务层的可扩展性
            4. mapper.java中方法的返回类型与mapper.xml中的resultType一致
    机制
            如果Mapper中返回类型为pojo, 则调用selectOne, 如果是List, 则调用selectList
# api
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