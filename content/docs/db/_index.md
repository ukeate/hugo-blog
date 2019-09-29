---
title: 数据库
type: docs
---
# 基础
    数据库类型
        关系型数据库
        模糊型数据库
            # 存放模糊数据，提供函数
            如模糊数，包括模糊区间数，模糊中心数，模糊集合数
            隶属函数
        统计数据库
            # 管理统计数据
            这类数据库包含有大量的数据记录，但其目的是向用户提供各种统计汇总信息，而不是提供单个记录的信息。
        网状数据库(层次数据库)
            # 处理以记录类型为结点的网状数据模型
            处理方法是将网状结构分解成若干棵二级树结构，称为系。
        演绎数据库
            # 指具有演绎推理能力
            实现
                数据库管理系统
                规则管理系统
            外延数据库
                将推理用的事实数据存放在数据库中
            内涵数据库
                用逻辑规则定义要导出的事实
            主要研究内容: 如何有效地计算逻辑规则推理。
                递归查询的优化
                规则的一致性维护

    其它数据存储方式
        文件系统
            版本控制
        保存持久状态
            CQRS(command query responsibility segregation)
                查询(query)
                命令(command)
                领域模型(domain model)
                领域事件(domain event)
        对象数据库
    趋势
        分布式new sql  # tidb
        Polyglot persistence (混合持久化)
            # 将对不同数据库的操作封装成服务

    事务隔离级别
        读未提交（Read Uncommitted）  # 读其它事务未提交的数据
            现象
                不允许更新丢失
                允许脏读(dirty read)               # 事务中读到不存在数据, 是其它事务修改中的数据
            原理
                可同时读
                不同时写，多事务写
            实现
                排他写锁
        读提交（Read Committed）                    # 读其它事务提交的数据
            现象
                不允许脏读
                允许不可重复读(nonRepeatable read)   # 事务中前后查询不一致
            原理
                可同时读
                单事务写
            实现
                瞬间共享读锁
                排他写锁
        可重复读（Repeatable Read）                  # 读到的数据加锁，解决不可重复读问题
            现象
                不允许脏读
                不允许不可重复读
                允许幻读(phantom read)               # 事务中存在未生效行，是其它事务的插入或删除
            原理
                读到的数据(加锁)不写
                单事务写
            实现      # 读涉及范围加锁
                共享读锁
                排他写锁
        序列化（Serializable）       # 或叫串行化
            原理
                事务序列化执行
            实现
                读锁写锁互斥
    事务特点(ACID)
        原子性(atomicity)          # 什么都做或都不做
        一致性(correspondence)     # 事务前后数据库状态一致, 事务中断时也不会有暂时状态
        隔离性(isolation)          # 事务间不干扰
        持久性(durability)         # 提交结果是永久的
    索引存储
        B+ tree
        LSM(log-structured merge) tree
        fractal tree
    OLTP和OLAP
        CAP(一致性、可用性、分区容错性)中, OLTP要求ca或cp, OLAP要求ap
        OLTP要求写优化, OLAP要求查优化
        OLTP要求优化latency, OLAP要求优化throughput
        OLTP基于row, OLAP基于column
        OLTP看中IOPS, OLAP看中data-size传输
    分布式数据库
        面临问题
            ACID
            CAP
            scale out
            self-healing
            运维友好
            sql
            事务
            性能
            api用明文或二进制
            升级方案
            硬件，网络，网络模型，存储模型，语言
            分布式协议，压缩方案，ha，api，运维方案，存储计算分离，缓存方案
# rds(relational database service)
    缺点
        阻抗失谐    # 和内存中的模型存在差异
    安全
        sql注入   # 应该写符号编译sql
    范式
        # Normal Form 用于避免冗余数据
        第一范式(1NF)
            列不可再细分列(原子性)
        第二范式(2NF)
            必须有主键，允许联合主键
            其它列依赖完整主键(不能只依赖一部分)
        第三范式(3NF)
            其它列直接依赖主键(非传递依赖，如A依赖B, B依赖主键)
    实例
        postgres
        sqlserver
        mysql
        mariadb
        percona
            # mysql分支
        drizzle
            # mysql分支
        oracle
        db2
        oceandb
        h2database
            # java编写，可嵌入java使用
        tidb
## sqlite
    命令
        sqlite3 数据库文件
    语法
        .table              # 查看所有表
        .schema             # 查看建表语句
## sql
    语法
        注释
            --      # 单行注释
            /**/    # 多行注释
        单引号
            字符串大小写敏感
        双引号
            转日期时, 双引号直接显示。to_char(sysdate,'yyyy "年" mm "月" dd "日" day')
        表别名不加as关键字, 有别名后原名无效
        oracle
            ||      # 管道符号
                select ename || '的薪水是' || sal from emp;
    定义(DDL, data definition language)
        create database db1             # create or replace
            default character set utf8          # 默认编码
            collate utf8_general_ci;    # 校对规则(排序), ci(case insensitive)大小写不敏感, cs(case sensitive)大小写敏感
        create table `tb1`(           # create or replace
            `id` int unsigned unique not null auto_increment,
                # `id` int unsigned not null primary key,
            `id2` int unsigned,
            `name` varchar(20),
            `age` int unsigned,
            `birthday` date,
            primary key(`id`),          # 主键
            key idx_tb1_name (`name`),   # 索引
            foreign key(`id2`) references `tb2`(id) on delete cascade on update cascade     # 外键、级联删除、级联更新, 不要用
            )character set utf8 collate utf8_general_ci
            engine=innodb default charset=utf8;
        create table person like student;           # 复制表结构
        create table emp1 as select * from emp;     # 复制内容
        create view tb1_v (a,b) as select a, b from tb1 #  create or replace
        create synonym tb2 for tb1;     # 同义词

        drop database db1;
        drop table tb1
            purge;              # 加purge不放入回收站
        drop synonym tb1;

        truncate table tbq;


        alter database db1
            character set gbk
            collate gbk_chinese_ci;        # 更改数据库的编码
        alter table tb1
            add column sex char(1);
        alter table tb1
            add constraint pr_id primary key (id);   # 添加主键
        alter table tb1
            add constraint fk_id2 foreign key (st_id) references tb2(id);  # 添加外键
        alter table tb1
            rename to tb2;
        alter table tb1
            change sex gender char(1);      # 只能改名，但类型必须写
        alter table tb1
            modify birthday varchar(20);    # 只能改类型
        alter table tb1
            convert to character set utf8 collate utf8_general_ci;  # 转换表编码
        alter table tb1
            drop column name;
        alter table field1
            auto_increment = 5;             # 更改自增长初始值


        rename table tb1 to tb2;

        desc tb1;


        mysql
            use db1

            source a.sql            # 批执行

            show status [from schema_name];         # 服务器状态
            show databases;
            show create database db1;
            show tables;
            show create table tb1;
            show processlist                        # 查看当前连接
            show VARIABLES LIKE "general_log%"      # 查看变量　
                "version"                           # 显示版本
                "autocommit"                        # 事务开启状态 0 off 1 on, set autocommit=off 或 0
            show character set                      # 显示所有字符集



            select @@sql_mode                       # 查看变量
            select @@tx_isolation                   # 查看事务隔离级别
            select
            select VERSION()                        # 显示版本

            set sql_mode = ''                       # sql_mode定义支持的sql语法，数据校验。
            set names 'gbk';                        # 设置终端编码, 等价character_set_client=gbk 与 character_set_results=gbk
            set global general_log = 'ON'           # 设置记录所有sql

        oracle
            create table tb1 (
                sex char(1) check(sex in (0, 1))        # check约束
            show user                   # 显示用户名
            show recyclebin             # 回收站
            purge recyclebin            # 闪回文件
            oracle表创建时自动添加伪列
                rowid       # 唯一，指向当前记录
                rownum      # 唯一，字段列名, 从1开始，永远连续。
                    # 支持比较符号 <, <=(可以比较=1)。取别名后可以比较 >, =


    操作(DML, data manipulation language)
        # 和DQL, data query language, select、from、where
        insert into tb1
            values (3, 'a', null);
        insert into tb1
            select * from tb2;
        insert into tb1(name)
            values ('a'),('b');
        insert into tb1(a, b)
            select c, d from tb2

        update tb1
            set name='a'

        delete from tb1


        select * from outrun.employee;      # 限定数据库名
        select field1 as f1 from tb1 as t1
        select a, b into tb2 from tb1;
        select distinct (a+b) as c from tb1
            # select distinct sum(price) as s
        子查询
            # 要求数量和类型匹配
            # 不能利用索引(join可以), 不形成笛卡尔积

            where a < (select max(a) from tb2)
                # 单行符号 =、<、>
            where a in ()
                # 多行符号 in、any、all
                where a < any ()    # 小于一个就true
                where a < all ()    # 小于所有才true



        where a=1 and b=2                   # where后不能出现列的别名，可以出现表的别名
            a=1 or b=2
                # <>表示!=
                # =可设置日期
            a in (1,2)
                # a not in (1,2)
            a between 1 and 2
                # a not between 1 and 2
            a like 'a%'
                # 不能用*
                # % 匹配任意个字符
                # _ 匹配一个字符
                # \ 转义 _ 或 %
            a regexp '^.*d.*$'
                # 匹配正则
            a is null
        order by    # null看作最大值
            a asc   # 升序
            a desc  # 降序
        group by
            select a, count(b), avg(c) from tb1     # group by的select元素都是聚合函数
                where b > 0
                group by a
                having count(b) > 2                 # having使用聚合函数条件
            select a from tb1                       # 子查询
                where b in (select b from tb2 where c='c')
                group by a
                having count(distinct b) = (select count(*) from tb2 where c='c')


        select执行过程
            # 每步都产生虚拟表
            from 组装数据
                join
                on
            where 筛选
            group by 划分
            # with,  with是sql server的语法
            计算聚合函数
            having 筛选
            计算表达式
            select 字段
                distinct
            order by 排序
            top

        oracle
            insert into tb1 values(&id, '&s')                   # &是占位符，字符型数据加''
            alter table tb1 rename column field1 to field2

        常用
            分页
                select * from tb1 limit 0,1         # mysql, 从0开始，查找1条


                select * from                       # oracle
                    (select rownum r, a from tb1 where rownum<=20)
                where r > 10

                select * from                       # oracle,  效率低
                    (select  rownum rn, a from tb1)
                where rn between 21 and 40


                select rownum,emp.* from emp        # oracle, 效率低
                    where rownum <=4
                minus
                select rownum,emp.* from emp
                    where rownum <=2;

    控制(DCL data control language)

        grant all privileges on db1.tb1         # 授权
            # grant insert,delete,update,select,create on db1.tb1
            to 'user1'@'host1'          # localhost本地 , %代表远程
            identified by 'pwd1'
            with grant option;          # 有授权权限
        grant select any table      # oracle
            to user1
        revoke select any table     # oracle
            from user1

        revoke privilege ON db1.tb1 from 'user1'@'host1';       # 撤销权限
        flush privileges;        # 提交授权修改, oracle不用flush直接生效


        oracle
            alter user user1 account unlock             # 解锁用户
            alter user user1 identified by user1        # 改密码
            conn / as sysdba                            # 换角色

    事务
        start transaction;
        savepoint a;
        rollback to [savepoint] a;
        rollback;
        commit;

    聚合函数
        avg()
        count()
        max()
        min()
        sum()


    连接(join)
        内连接(inner)
            # 带条件的交叉连接
            # 只查出符合条件的记录
            select * from tb1 a         # 显示
                inner join tb2 b
                on a.c_id=b.c_id
            select * from tb1 a, tb2 b  # 隐示
                where a.c_id=b.c_id
            自连接     # 表中有层次关系。自连接无中间表, 效率快
                select a.c, b.d from course as a, course as b
                    where a.c=b.d
        外连接(outer)
            # 以一表为基准，查另一表
            # 可查出不符合条件的记录(另一表无对应值，标记成null)
            左外连接
                # 以左为基准
                select * from tb1 as a
                    left [outer] join tb2 as b
                    on a.c_id=b.c_id

                select a.c_id       # oracle
                from tb1 a, tb2 b
                where a.c_id = b.c_id(+)
            右外连接
                    right [outer] join
            全外连接
                # full [outer] join, 只oracle支持
                # 先左连接再右连接，取的是交集
                select * from a
                    full join b
                    on a.c_id=b.c_id
        交叉连接(cross)     # 笛卡尔积
            # 有where条件时，会先生成where查出的两个表
            select * from tb1 a
                [cross] join tb2 b
                where a.c_id = b.c_id;
        自然连接(natural)
            # 自动检查相同名称的列，类型会隐式转换，不能指定显示列(或用*)、不能用on语句
            # 每种连接名称前加natural都是自然连接
            select * from tb1 a
                natural innter join tb2 b
    集合
        # 数量,类型匹配
        # 前语句别名可用,后语句别名不可用
        select a, b from tb1
            union [all] select a, b from tb2    # 并集, all 允许重复
                # intersect 交集
                # minus 差集

    约束(constraint)
        not null
        unique
        primary key
            primary key unique, not null auto_increment
            primary key(col1, col2)     # 联合主键
        foreign key
            constraint fk_id2
                foreign key(id2) references tb2(id)
                    # 被引用的列要建索引
                    # 被引用的记录不可删除
                    # 被引用的值要级联修改
                on update cascade
                on delete cascade
                    # 级联约束
        检查约束    # oracle支持
## 存储过程
    优势
        高效, 首次运行进行预编译
        模块化
        更快执行，大量sql时，比sql快
        减少网络流量
        安全机制
            针对过程授权
            调用时看不到语句信息和数据
            避免sql注入     # 参数视为文字
            可对过程加密
    劣势
        不可移植
        需要专人维护
        逻辑变更时修改不灵活
## 触发器
    用途
        表级联更改
        实现比check约束复杂的逻辑
        强制执行业务规则
        评估修改后表状态，执行操作
    基础
        同一表不能建立2个相同类型触发器
## 视图
    特点
        优点
            简化查询
            提供独立访问
            限制访问
        查看时，生成sql查看, 有即时性
        更新视图表级联
            不能更新的视图包含元素
                组函数
                distinct
                group by
                rownum
        grant可授权
        不能与表名重名
        mysql保存在information_schema.views中
        删除不放回收站

        CREATE [OR REPLACE] [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]       # TEMPTABLE是临时表，不能更新
            VIEW view_name [(column_list)]
            AS select_statement
            [WITH [CASCADED | LOCAL] CHECK OPTION]                      # 通过该视图更改的数据，可再通过该视图查看到(满足视图的限制)
        o->
        CREATE VIEW test.v AS SELECT * FROM t;
        o->
        CREATE VIEW v AS SELECT qty, price, qty*price AS value FROM t;                # 可以计算
        o->
        CREATE VIEW v AS SELECT CHARSET(CHAR(65)), COLLATION(CHAR(65));                # 可以联合
        o->
        CREATE ALGORITHM = MERGE VIEW v_merge (vc1, vc2)
            AS SELECT c1, c2 FROM t1 WHERE c3 > 100

            查询解释
                SELECT * FROM v_merge WHERE vc1 < 100; 会执行
                SELECT c1, c2 FROM t WHERE (c3 > 100) AND (c1 < 100);


        ALTER [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
            VIEW view_name [(column_list)]
            AS select_statement
            [WITH [CASCADED | LOCAL] CHECK OPTION]              # CASCADED 忽略主外键关系

        DROP VIEW [IF EXISTS]
            view_name [, view_name] ...
            [RESTRICT | CASCADE]

        SHOW CREATE VIEW view_name
## 索引
    特点
        第一次查询时创建
        加快查询的速度，表删除时索引自动删除
        primary key 与 unique 自动建立
    命中
        where 中添加对应索引的条件， 只能从前向后命中
    是否使用
        使用
            分布广
            经常在where中出现
            表经常访问
        不使用
            表小
            不经常出现的列
            经常更新的字段
    类型
        index
        unique
        primary key

    CREATE INDEX index_name ON table_name (column_list)         # 创建索引，primary key已有索引
    CREATE UNIQUE INDEX index_name ON table_name (column_list)

    ALTER TABLE table_name ADD INDEX index_name (column_list) # 创建索引，列名逗号分隔。index_name缺省时，根据第一个索引列取名
    ALTER TABLE table_name ADD UNIQUE (column_list)
    ALTER TABLE table_name ADD PRIMARY KEY (column_list)

    DROP INDEX index_name ON talbe_name
    ALTER TABLE table_name DROP INDEX index_name        # 等价于前一个
    ALTER TABLE table_name DROP PRIMARY KEY

    show index from tb1;
    show keys from tb1;
        Table         # 表的名称。
        Non_unique    # 如果索引不能包括重复词，则为0。如果可以，则为1。
        Key_name      # 索引的名称。
        Seq_in_index  # 索引中的列序列号，从1开始。
        Column_name   # 列名称。
        Collation     # 列以什么方式存储在索引中。在MySQL中，有值‘A’（升序）或NULL（无分类）。
        Cardinality   # 索引中唯一值的数目的估计值。通过运行ANALYZE TABLE或myisamchk -a可以更新。基数根据被存储为整数的统计数据来计数，所以即使对于小型表，该值也没有必要是精确的。基数越大，当进行联合时，MySQL使用该索引的机会就越大。
        Sub_part      # 如果列只是被部分地编入索引，则为被编入索引的字符的数目。如果整列被编入索引，则为NULL。
        Packed        # 指示关键字如何被压缩。如果没有被压缩，则为NULL。
        Null          # 如果列含有NULL，则含有YES。如果没有，则该列含有NO。
        Index_type    # 用过的索引方法（BTREE, FULLTEXT, HASH, RTREE）。
        Comment       # 更多评注。
## 序列
    # 共享对象唯一的数值，不一定连续
    create sequence tb1_seq
        INCREMENT BY 10              # 步长是10
        START WITH 120               # 从120开始
        MAXVALUE 9999                # 最大到9999
        NOCACHE                      # 不缓存序列的值（缓存是先创建很多再取出，不缓存则是什么时候取，什么时候创建）
        NOCYCLE;                     # 到最大值的时候是否循环

    select seq.nextval from dual                # nextval下一个序列 currval当前序列  第一次使用必须是nextval
    insert into emp(id) vallues(seq.nextval);   # 使用
    alter sequence tb1_seq increment by 10;
        start with 100;                         # 错误 ，不能变更启动序列，只能在创建序列时指定
    drop sequence seq

# 性能优化
    设计
        库
            分库
                拆微服务
                主从      # master不拆，slave树形
                索引与数据分库
        表
            不要代价高的关系(外键、级联)
            字段可冗余，为了提高性能，但要考虑同步。不能是频繁修改的字段，不是varchar和text
            单表行数超过500万或意表容量超过2GB，才分库分表
            分表  # 垂直分字段，水平分记录
                表名加hash到多表
                partitioning key字段分表    # proxy网关分流
                    时间
                    地点
                建lookup table查找对应表
                冷热分离
            用表变量代替临时表
            表变量数据大时，只有主键索引
            大量重复引用大型表或常用表数据时，可创建临时表。一次性事件，最好导出表
            临时表时数据大时, 用select into代替create table, 避免log过多
            临时表最后要先truncate, 再drop, 避免表较长时间锁定
        类型
            尽量not null
            数字类型尽量用
            char存几乎定长字符串类型
            varchar变长字符串，不预先分配空间，长度不要超过5000
            text存大于5000,独立出表用主键对应，避免影响其它字段索引效率
            bool用unsigned tinyint
            小数类型用decimal，不用float double
                # float和double存储的时候，存在精度损失的问题
                # 长度超过decimal范围，拆成整数和小数分开存
            合适的字符长度，不但节约表空间，节约索引存储，更提升检索速度
                unsigned tinyint    0到255
                unsigned smallint    0到65535
                unsigned int    0到42.9亿
                unsigned bigint    0到10的19次方
        索引
            有唯一特性，都建唯一索引
                # insert速度损耗可以忽略，但明显提高查找速度
                # 不建唯一索引，总会有脏数据产生
            where与order by涉及的列建索引
            建组合索引时，区分度最高的在左边
                where a=? and b=? ，a列几乎接近唯一值，只需要建idx_a索引
                非等号和等号混合时，等号是最左边，如where a>? and b=?, 那么b在索引最前列
            字段值大量重复时，索引作用不大
            索引降低insert与update效率
            索引数据列少更新           # 数据列为表存储方式，更新会调整整表存储
            varchar建索引，要指定索引长度
                一般字符串数据，长度为20的索引，区分度高达90%以上
                count(distinct left(列名，索引长度)) / count(*)来计算
    语句
        where放弃索引，全盘扫描
            比较符
                in      # in元素尽量控制在1000内
                not in
                # exists代替in
                    select num from a where num in(selct num from b)    改为
                    select num from a where exists(select 1 from b where num=a.num)
                is null
                is not null
                <>
                or
                like '%a'模糊开头

            where对字段用表达式或运行函数
                where num/2=100 改为
                where num = 100*2

                where year(admin_time)>2014 改为
                where admin_time>'2014-01-01'
            where使用参数       # 因为运行时解析局部变量，访问计划在编译时进行
                select id from t where num=@num 改为
                select id from t with(index(索引名)) where num=@num    # 强制使用索引
        select
            不要写无意义查询
                select a into #t from t where 1=1 改为
                create table #t
            不要select *             # 增加查询分析器解析成本，增减字段容易与resultMap不一致
            不select for update      # 长期锁定行(游标默认都用)
                不要用游标
        函数
            使用count(*)统计行数
                用count(distinct col1, col2)来计算不重复
            sum(col)会返回null，如下解决
                SELECT IF(ISNULL(SUM(g)), 0, SUM(g)) FROM table1
            使用ISNULL()来判断NULL
                # NULL与任何值比较都为NULL
    业务
        sql优化至少到range级别
            # explain结果type=
            # all 全表扫描
            # index 扫描整个索引表，几乎相当于全表扫描
            # range 用索引选择范围
            # ref 非唯一索引扫描
            # eq_ref 唯一索引扫描
            # consts 索引一下就找到，单表中最多有一个匹配行(主键或唯一索引), 在优化阶段即可读取到数据
            # system 表只有一行
        库
            不在数据库写逻辑           # 不使用存储过程, 难调试和扩展，没有移植性
            正确锁类型                # 隐式锁、显式锁、行锁、页锁、范围锁、表锁、数据库锁
            全球化用utf-8，要使用表情，用utfmb4
                SELECT LENGTH("轻松工作") 返回 12
                SELECT CHARACTER_LENGTH("轻松工作") 返回4
        事务
            不要多阶段提交             # 更好的拆分表，而不多阶段提交延长单一数据库生命
            避免大事务
            连接释放
        crud
            TRUNCATE快，但无事务不触发trigger, 不要在开发代码中使用
            修改数据时，先select，避免误删除和修改
            分页时count为0直接返回
            用覆盖索引来变相加快查询，如explain的结果，命中时出现using index
            避免返回大量数据
            order by注意利用索引的有序性，order by最后的字段是组合索引的最后，避免file_sort
                如 where a=? and b=? order by c; 索引 a_b_c
                有范围查找时，有序性无法利用，如 where a>10 order by b
        联合
            多表联合查询拆分多个query     # 容易锁表和阻塞
            禁止三表join
                join的字段类型要一致
                被关联的字段需要有索引
                注意sql性能
            join时，小结果驱动大结果      # left join小表在左
                优化前
                    select * from admin
                    left join log on admin.admin_id = log.admin_id
                    where log.admin_id>10
                优化后
                    select * from
                        (select * from admin where admin_id>10) T1
                    left join log on T1.admin_id = log.admin_id
    mysql
        引擎选择
        limit 1
            只查一条时，加limit 1, 引擎会找到一条马上返回
        limit基数大用between, 分页时要找到id, 避免offset之前全查的问题
            优化前
                select * from admin order by id limit 10000,10
            优化后
                select * from admin where id between 10000 and 10010 order by id
            子查询id
                select a.* from 表1 a, (select id from 表1 where 条件 limit 100000,20) b where a.id=b.id
# nosql
    介绍
        aggregate-oriented (面向聚合)
            键值
            文档
            列族
        relationship-oriented (面向关系)
            图
    特点
        少约束(schemaless)
        应用程序数据库（作为微服务的数据库来解耦）
        聚合(aggregate)
            # 领域驱动设计中提出
            # 图除外
        图支持事务
        牺牲一部分一致性和持久性
    问题
        存在不一致窗口
        会话一致性问题
    兼容
        物化视图来处理更新
        实时BI, 来更新中间关系聚合
        一致性
            锁
            条件更新(更新前检查)
                版本戳
                    # http 中的etag
            写入仲裁与读取仲裁
                复制因子大于某值时认为写入完成
                读取多于某值个节点数据并相同时，认为读到最新数据
            用zookeeper等外部“事务”程序库同步读写操作
## 图
    介绍
        领域
        关系是一等公民
        大部分不支持分布式
        Gremlin，Cypher 查询语言
    适用
        互联数据
        运输等基于位置的服务
        推荐引擎
    不适用
        经常更新
    工具
        neo4j
        flockDB
                # 仅支持单深度关系及邻接表
        hyperGraphDB
        infiniteGraph
        allegroGraph
        orientdb
        pregel
            # google图数据库
### neo4j
    # 介绍
        使用zookeeper
    # 特点
        完全兼容ACID
        主从复制
        副本从节点
            从节点写数据，先同步到主节点, 再由主节点分发
    # 配置
        dbms.connector.bolt.enabled=true
        dbms.connector.bolt.listen_address=0.0.0.0:7687
        dbms.connector.http.enabled=true
        dbms.connector.http.listen_address=0.0.0.0:7474
            # 远程访问
## 列族
    特点
        键空间
    适用
        事件记录
            # 事件id为行
        内容管理
        计数器
        带过期的列
    不适用
        ACID事务
        多行数据聚合
    工具
        cassandra
        hbase
        amazon simpleDB
        hypertable
        bigtable
        clickhouse
            # 用于OLAP, 实时分析
### cassandra
    特点
        适用大规模数据
        良好的分布式扩展性
        功能比key-value丰富，不如mongo
        写快于读
        不稳定
        没有主节点，所有节点平等
        查询语言CQL
        列TTL(秒)
    命令
        cqlsh localhost 9042
    数据库命令
        use aaa
            # 用aaa键空间
### hbase
    特点
        hdfs存储，分布式，面向列
        可利用map reduce
    特点
        多版本
        列权限控制
        多个列划分为列族，可设置保留多少版本
        多行划分为region
        空列不占空间，可稀疏存储
        无类型，所有类型都是字符串
        行一致性，一行数据在一个server
        查询方式有限：rowkey, rowkey的range, 全表扫描
        协处理器coprocessors
            观察者observer（监听器）
            终端endpoint（rpc调用代码）
## 文档
    适用
        事件记录
        内容管理
        网站分析与实时分析数据
        电子商务中产品或订单
    不适用
        事务
        持续变化的数据
    工具
        couchDB
        orientDB
        ravenDB
        terrastore
        xml数据库
        mongoDB
        memDB
            # 带事务的mongo
        tokumx
### couchDB
    特点
        apache托管,  alang语言开发的，面向文档的分布式数据库
        json结构，易于存储cms, 电话本，地址本等半结构化数据。存储类似于lucene的index
        易添加，不易修改
        主主双向复制
## 键值
    适用
        session
        用户配置信息
        购物车
    不适用
        数据间关系
        多项操作的事务
        模糊键查询
        对集合关键字操作
    工具
        redis
        riak
            # 类cassandra
        berkeleyDB
        levelDB
            # google
        memcached
        project voldemort
        tokyo cabinet
        rocksDB
        groupCache  # go编写
## 时序
    influxDB    # go编写
# newsql
    工具
        分布式
            google spanner
            voltdb
            clustrix
            nuodb
            tidb    # go编写
        h-store
        foundationDB
        scalebase
        dbshards
        scalearc
        tokudb
        memsql
## tidb
# 流式数据库
    piplelineDB
        # 依赖zeromq, 记录时间段内的事件
# proxy
## mycat
    # 目录结构
            bin
                    mycat                        # 服务器启动等
            conf
                    wrapper.conf                # jvm配置参数(如分配系统资源)
                    server.xml                # 服务器参数，用户授权
                    schema.xml                # 逻辑库，表，分片的定义．修改后要重启
                    log4j.xml                # 配置输出到logs/mycat.log的日志
            logs
                    mycat.log                # 日志（每天一个日志文件）， 可调整输出级别

    # 默认值
            默认数据端口: 8066
            默认管理端口: 9066

    # 配置
        wrapper.conf                # jvm配置参数(如分配系统资源)
        server.xml                # 服务器参数，用户授权
        schema.xml                # 逻辑库，表，分片的定义．修改后要重启
        log4j.xml                        # 配置输出到logs/mycat.log的日志

        mysql
            linux版数据库设置大小写不敏感，否则会发生表找不到的问题
                    my.cnf
                            [mysqld]
                            lower_case_table_names = 1

    # 例子
        server.xml
                <mycat>
                <user name="test">
                        <property name="password">test</property>
                        <property name="schemas">TESTDB</property>
                </user>
                </mycat>

        schema.xml
                <mycat>
                <schema name="TESTDB" checkSQLschema="false" sqlMaxLimit="100">
                        <table name="travelrecord" dataNode="dn1,dn2,dn3" rule="auto-sharding-long" />
                        <table name="employee" primaryKey="ID" dataNode="dn1,dn2" rule="sharding-by-intfile" />
                        <table name="company" primaryKey="ID" type="global" dataNode="dn1,dn2,dn3" />
                        <table name="goods" primaryKey="ID" type="global" dataNode="dn1,dn2" />
                            <table name="hotnews" primaryKey="ID" dataNode="dn1,dn2,dn3" rule="mod-long" />
                                <table name="customer" primaryKey="ID" dataNode="dn1,dn2" rule="sharding-by-intfile">
                                                <childTable name="orders" primaryKey="ID" joinKey="customer_id" parentKey="id">
                                                        <childTable name="order_items" joinKey="order_id" parentKey="id" />
                                                </childTable>
                                                <childTable name="customer_addr" primaryKey="ID" joinKey="customer_id" parentKey="id" />
                                </table>
                </schema>
                <dataNode name="dn1" dataHost="localhost1" database="db1" />
                <dataNode name="dn2" dataHost="localhost1" database="db2" />
                <dataNode name="dn3" dataHost="localhost1" database="db3" />
                <dataHost name="localhost1" maxCon="1000" minCon="10" balance="0"
                        writeType="0" dbType="mysql" dbDriver="native">
                        <heartbeat>select user()</heartbeat>
                        <writeHost host="hostM1" url="centos6.5_1:3306" user="root" password="asdf">
                        </writeHost>
                </dataHost>
                </mycat>

        rules.xml
                <mycat>
                        <tableRule name="sharding-by-intfile">
                        <rule>
                                <columns>sharding_id</columns>
                                <algorithm>hash-int</algorithm>
                        </rule>
                        </tableRule>
                        <tableRule name="mod-long">
                        <rule>
                                <columns>id</columns>
                                <algorithm>mod-long</algorithm>
                        </rule>
                        </tableRule>
                        <function name="hash-int" class="org.opencloudb.route.function.PartitionByFileMap">
                                <property name="mapFile">partition-hash-int.txt</property>
                        </function>
                        <function name="mod-long" class="org.opencloudb.route.function.PartionByMod">
                                <property name="count">3</property>
                        </function>
                </mycat>

        partition-hash-int.txt
                10000=0
                10010=1

        sql
                create table employee (id int not null primary key,name varchar(100),sharding_id int not null);
                insert into employee(id,name,sharding_id) values(1,'leader us',10000);
                insert into employee(id,name,sharding_id) values(2,’me’,10010);
                insert into employee(id,name,sharding_id) values(3,’mycat’,10000);
                insert into employee(id,name,sharding_id) values(4,’mydog’,10010);

                create table company(id int not null primary key, name varchar(100));
                insert into company(id,name) values(1,'hp');
                insert into company(id,name) values(2,'ibm');
                insert into company(id,name) values(3,'oracle');

                create table customer(id int not null primary key, name varchar(100), company_id int not null, sharding_id int not null);
                insert into customer (id,name,company_id,sharding_id )values(1,'wang',1,10000);
                        insert into customer (id,name,company_id,sharding_id )values(2,'xue',2,10010);
                        insert into customer (id,name,company_id,sharding_id )values(3,'feng',3,10000);

                create table orders (id int not null primary key ,customer_id int not null,sataus int ,note varchar(100));
                insert into orders(id,customer_id)values(1,1);
                insert into orders(id,customer_id)values(2,2);

                create table travelrecord( id bigint not null primary key,username varchar(100), traveldate DATE, fee decimal, days int);
                insert into travelrecord(id,username,traveldate,fee,days)values(1,'wang','2014-01-05',510.5,3);
                insert into travelrecord(id,username,traveldate,fee,days)values(5000001,'wang','2014-01-05',510.5,3);

                create table hotnews(id int not null primary key, title varchar(400), created_time datetime);
                insert into hotnews(id,title,created_time)values(1,'first',now());
                insert into hotnews(id,title,created_time)values(5,'first',now());

                create table goods(id int not null primary key,name varchar(200),good_type tinyint,good_img_url varchar(200), good_created date, good_desc varchar(500), price double);

                create table order_items(id int not null primary key, order_id int not null);
                insert into order_items(id, order_id) values(1,1);
    # 经验
        o-> 数据库上的数据修改(权限修改)立即生效
        o-> 支持跨库事务，且等待主从复制完成后完成事务(如全局表的复制)
        o-> virtualbox4.3下配置的mycat节点不能子表插入
        o-> 可以配置jdbc数据库进行远程数据调用
        o-> childTable中的joinKey与parentKey是必须字段, childTable不能配置dataNode
        o-> 同一个childTable出现在多个主表时(相当于mysql的多个外键)，会出错，提示该childTable重复创建
        o-> childTable不能配置dataNode, 默认和主表存的dataNode相同
        o-> 虽然childTable只能配一个，但mysql里可以配置多个外键，但要求外键关联的表配置>在相同的dataNode上
        o->  配置在两个dataHost中的表, show tables 时表名会显示两遍
        o-> table不配置rule默认数据每个dataNode存一份，但是mycat查询时显示同id的两份数据，此方法不可用
        o-> table不配置，不可以创建
        o-> 全局序列号名称必需大写
        o-> 不同dataNode中的普通表不可以关联查询
        o-> 同样配置dn1, dn2 的两个普通外键关系表之间数据插入可能会出错(如: 表2数据在dn1中, 其外键关联表2在dn2中的数据时)
