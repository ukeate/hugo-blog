---
Categories : ["数据库"]
title: "Mysql"
date: 2018-10-11T15:37:48+08:00
---

# 工具软件
    mysql database
    mysql cluster                                                创建集群，配置复杂
    mysql cluster manager                                cluster帮助软件，配置简单
    mysql workbench                                        数据库建模工具
    mysql utilities                                                提供一组命令行工具用于维护和管理 MySQL 服务器
# 端口
    3306
# 包括
    管理工具 (克隆、复制、比较、差异、导出、导入)
        复制工具 (安装、配置)
        一般工具 (磁盘使用情况、冗余索引、搜索元数据)
    mysql enterprise monitor documentation
    mysql enterprise monitor connector
    mysql enterprise monitor service manager
    mysql enterprise monitor agent
    mysql enterprise backup
    mysql connector
# 引擎
    XtraDB
    MyISAM
    InnoDB
# 命令
    mysql
        --max-relay-logs-size=300                        # 中继日志大小(sql语句数)
        --relay-log-purge={0|1}                        # 中继日志自动清空
        --relay-log-space-limit=0                        # 限制中继日志大小,0表示无限制
    services.msc 
    mysql -h 127.0.0.1 -u root -p
    mysqldump -uroot -p day02>d:/backup.sql                // 备份
    mysql -uroot -p day02<d:/backup.sql                        // 导入
    mysqladmin -uroot -proot status                                # 查看当前连接数
# 连接参数
    root:123456@tcp(abcdefg:3306)/meiqia?
    charset=utf8mb4,utf8&
    loc=UTC&
    interpolateParams=true&
    time_zone=%27%2B00%3A00%27&
    sql_mode=%27NO_ENGINE_SUBSTITUTION%2CSTRICT_TRANS_TABLES%27
# 数据类型
    int                        int(5) zerofill
    varchar(20)
    decimal(10,2)        //小数
    char()
    date
    bool或boolean        
    double
    float
    longtext
    longblob
    timestamp                                                                // 自动在插入、修改记录时添加，用于记录更新
    enum('male','female') default male                // 枚举，只有一个
    set(('football','sleep','film')                        // 集合，可以多个
# 特色sql
    alter
            alter database day02 character set gbk collate gbk_chinese_ci
                    # 数据库编码
            alter table tb1 CONVERT TO CHARACTER SET utf8 collate utf8_general_ci
                    # 表编码
    command
            source a.sql
                    # 执行sql文件
            select @@sql_mode
            set sql_mode = ''
                    # sql model
            set global general_log = 'ON'
    事务
            start transaction;
            savepoint a;
            rollback to a;
            rollback;
    show
            show processlist
                    # 查看当前连接
            show VARIABLES LIKE "general_log%"
                    # 查看变量　
## trigger
    new与old
            对于INSERT语句,只有NEW是合法的；
            对于DELETE语句，只有OLD才合法；
            而UPDATE语句可以在和NEW以及        OLD同时使用。下面是一个UPDATE中同时使用NEW和OLD的例子。
            
    example1        # 当更新表data的name字段时，更新表chars所有字段count的值加上新加入name字段的长度

            create trigger tr1
            after insert on data 
            for each row
            update chars set count=count+char_length(new.name);

    example2
            create trigger tr1
            before update on t22
            for each row
            begin
            set @old = old.s1;
            set @new = new.s1;
            end;
## stored procedure
    存储过程： 不可移植，高效
            1 修改指令的结束符号，以delimiter// 用//表示结束符号
            2 语法
                    create procedure 存储过程名(参数类型 参数名 参数数据类型)
                    begin
                            业务逻辑
                    end//
                    call pro1()//
                    @name 为局部变量        @@name 为全局变量
                    drop function pro1;
            3 存储过程名
                    1.大小写不敏感
                    2.可以包含空格，最长为64位
                    3.最好        数据库名.过程名
                    4.不要使用内建函数名
                    
            4 参数类型：IN参数(不修改传递进来的参数)        OUT参数(参数无法传进来，只修改参数)                INOUT参数(可读可写)
            
            5 什么sql语句在存储过程中是合法的：都是合法的。但使用 MySQL附加功能语句不可扩充
            
            6 characteristics clauses 特征子句

        7 显示存储过程
            show procedure status;
            show create procedure proc_name;
            show create function func_name;
        
    可用语句
    declare a int default 2;
    set @name = 'admin';
    insert into 
    update
    select
    begin end 作用域
    if then else end if;
    case variable1 when 0 then when 1 then else end case
    while do end while
    loop_label:LOOP LEAVE[ITERATE] loop_label; end loop [end loop_label]        # iterate是迭代
    repeat until end repeat # 执行后检查结果
    LABEL label_name GOTO label_name

    异常
    DECLARE 
    { EXIT | CONTINUE } 
    HANDLER FOR 
    { error-number | { SQLSTATE error-string } | condition } 
    SQL statement 

    DECLARE EXIT HANDLER FOR 1216 
    DECLARE CONTINUE HANDLER FOR not found        # 写在存储过程的begin后，当前程序出错后会自动触发代码 MySQL允许两种处理器，
                                                                                    ## 一种是EXIT处理，上面所用的就是这种。另一种就是我们将要演示的，CONTINUE处理，
                                                                                    ## 它跟EXIT处理类似，不同在于它执行后，原主程序仍然继续运行
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET @x2 = 1; # 如果下面将@x2的值赋为1就会出错
    DECLARE EXIT HANDLER FOR `Constraint Violation` ROLLBACK;        # 回滚

    DECLARE `Constraint Violation` CONDITION FOR SQLSTATE '23000'; 
    DECLARE EXIT HANDLER FOR `Constraint Violation` ROLLBACK;                        # 先声明条件


    游标
    declare cur_1 cursor for select s1 from t;
    open cur_1
    fetch cur_1 into a
    close cur_1

    函数                # 函数跟过程很相似，唯一需要指出的语法上的不同就是创建函数后必须有RETURN语句返回函数指定的类型值。
                    ## 不能在函数中访问表
                    
    function example1:
    create function myadd(num1 int, num2 int)
    returns int
    begin
    return num1 + num2;
    end//

                    
    procedure example1: 

            create procedure pro(in name varchar(20))
            begin
            select name;
            set name='hello world';
            select name;
            end//

            set @name='jnb'//
            call pro(@name)//

    procedure example2:        # if语句，根据输入0/1 判断 男/女

            create procedure findGender(in op int)
            begin
            declare gendar varchar(20);                                # 在函数中定义变量gendar和其类型
            if op=0 then                                                        # =表示判断
            set gendar='male';
            else set gendar='female';
            end if;
            select gendar;
            end//

    procedure example3:        # switch语句，判断星期

            create procedure findday(in day int)
            begin
            declare findday varchar(20);
            case day
            when 1 then set findday='星期一';
            when 2 then set findday='星期二';
            when 3 then set findday='星期三';
            when 4 then set findday='星期四';
            when 5 then set findday='星期五';
            when 6 then set findday='星期六';
            when 7 then set findday='星期七';
            else set findday='无效';
            end case;
            select findday;
            end//
            
    procedure example4:        # while循环

            create procedure findsum(in n int)
            begin
            declare sum int default 0;
            declare i int default 0;
            while i<=n do
            set sum=sum+i;
            set i=i+1;
            end while;
            select sum;
            end//
            
    procedure example5:        # 验证登录
            create procedure prologin(in user_name varchar(20), in user_psw varchar(100), out flag int)
            begin
            if exists(select name from users where name=user_name and psw=password(user_psw)) then
                    set flag = 1;
            else
                    set flag = 0;
            end if;
            end//
## 函数
    count(*)
    count(name)                        # 不统计null，所以不推荐，会漏数据
    sum(english)/count(*) as 英语平均分
    avg(chinese)
    max(english)
    min(english)
    password('jiaoningbo')
    concat('jiao','ning','bo')                concat(38.8) # 连接                转换数字到字符串
    cast(38.8 as char)                        # 转换数字到字符串  同 concat(38.8) 但这个更正式
    strcmp('text','text2')                # 比较字符串，相同则返回0，不同则返回-1
    abs('-1')                                        # 绝对值
    crc32('mysql')                                # 计算循环冗余码校验值并返回一个 32比特无符号值
    pi()                                                # pi
    floor(1.2)                                        # 取整 返回一个bigint
    mod(29,9)                                        # 取摩
    is                                                        # select 1 is true,0 is false,null is unknown,null is not unknown  结果 ：1,1,1,0
    coalesce(null,1)                        # 返回第一个非空值，全空则返回null
    greatest(0,2,66,34)                        # 返回不定参数个数的 参数的最大值，个数为0时返回null
    least(2,0)                                        # 返回不定参数个数的 参数的最小值，个数为0时返回null
    1 xor 0 xor 1                                # 异或，两个1消为0
    ascii('ab')                                        # 返回最左字符的ascii码
    bin(13)                                                # 返二进制
    bit_length('text')                        # 返回二进制长度
    char_length('str')                        # 返回字符长度
    left('foobar',5)                        # 截取左数前5个
    right('foobar',4)                        # 截取右数前4个
    locate('bar','foobar')                # 返回位置4
    locate('bar','foobarbar',5)        # 返回从5开始数的子串的位置，这里是7
    ltrim(str)                                        # 去左空格
    rtrim(str)                                        # 去右空格
    trim(str)                                        # 去空格
    make_set(1|4,'hello','nice','world')                # 第一位是bit,1|4 表示1+4=5 即二进制101，所以显示结果为"hello,world", 0 输出空字符串
    repeat('m',3)                                # 重复
    replace('wb','w')                        # replaceAll
    reverse(str)                                # 倒序
    space(6)                                        # 输出6个空格
    adddate('1998-01-02',31)        # 加日期  同 adddate('1998-01-02',interval 31 day)同 date_add('1998-01-02',interval 31 day)
    addtime('1997-12-31 23:59:59.999999','1 1:1:1.000002')        #加时间 同 '1997-12-31 23:59:59.999999','1 1:1:1.000002');
    curdate()+ 3                                # 当前日期 + 3 天
    date(str)                                        # 提取日期时间表达字符串中的日期部分
    date('1997-11-12','1997-11-11')                # 前面减后面 得到天数
## 控制语句
    use day01                                                // 转换数据库
    show character set                                // 显示所有字符集
    SELECT VERSION();                                // 显示版本                # 或  SHOW VARIABLES LIKE 'version';
    set character_set_client=gbk;                set character_set_results=gbk;                //处理console 与 数据库内部读写数据程序转码
    SET names 'gbk';                        # 替代上面两个，设置console编码
    特有的分页语句
            select * from t_table where sal > 0 order by sal limit 0,1                # 从第0条开始，查找1条记录
        
    约束
            Check约束mysql 不支持
            特有约束auto_increment

    授权语句
            授权
                    GRANT privileges ON databasename.tablename TO 'username'@'host' IDENTIFIED BY 'password'
                            如
                                    grant insert,delete,update,select,create on day04.teachers to '用户名'@'localhost或者%'         identified by '密码'                
                                            # localhost代表只能本地连接,%代表可以ssh连接
                                    grant all
                    
            撤销权限
                    REVOKE privilege ON databasename.tablename FROM 'username'@'host';
            
            权限更改生效：
                    flush privileges;        # 提交授权修改
                                                            ## oracle中只要dcl语句执行应付提交
            远程登录
                    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'asdf' WITH GRANT OPTION; 
            重置密码
                    UPDATE user SET password=PASSWORD('asdf') WHERE user='root';
                    FLUSH PRIVILEGES;

    经验
            创建用户
                    mysql -- user表
                    或
                    CREATE USER 'username'@'host' IDENTIFIED BY 'password';
            修改root 密码
                    update mysql.user set password=password('root') where user='root';
                    或
                    SET PASSWORD FOR 'username'@'host' = PASSWORD('newpassword');
                    flush privileges;
            用mysqladmin 修改
                    cmd> mysqladmin -uroot -p password 新密码        
                            提示输入旧密码:旧密码
            删除用户
                    DROP USER 'username'@'host';
            匹配正则表达式
                    select * from sysgroup where department regexp '^.*d.*$';
            查看事务隔离级别
                    select @@tx_isolation
            查看数据库状态（编码）
                    status
            更改主键自动增长初始值
            ALTER TABLE forder AUTO_INCREMENT = 2013101801;

## 视图
    工作机制:
            1.当调用视图的时候，才会执行视图中的sql，进行取数据操作。视图的内容没有存储，而是在视图被引用的时候才派生出数据。
            2.grant语句可以针对视图进行授予权限。
            3.即时引用，视图的内容总是与真实表的内容是一致的。
            4.更新视图,其实就是以引用的方式操作了真实表
            5.视图不能与表名重名
            6.视图的记录都保存在information_schema数据库中views的表
            7.with check option：对视图进行更新操作的时，需要检查更新后的值是否还是满足视图公式定义的条件。
                    # 通俗点，就是所更新的结果是否还会在视图中存在。如果更新后的值不在视图范围内，就不允许更新
            8.CREATE ALGORITHM=merge VIEW 
                    # ALGORITHM有三个参数分别是：merge、TEMPTABLE、UNDEFINED
                    ## 因为临时表中的数据不可更新。所以，如果使用参数是TEMPTABLE，无法进行更新。
                    ## 当你的参数定义是UNDEFINED(没有定义ALGORITHM参数)。mysql更倾向于选择合并(merge|)方式。是因为它更加有效。﻿
                    例如
                    merge方式
                            CREATE ALGORITHM = MERGE VIEW v_merge (vc1, vc2) AS SELECT c1, c2 FROM t WHERE c3 > 100;
                            SELECT * FROM v_merge WHERE vc1 < 100;语句相当于
                            SELECT c1, c2 FROM t WHERE (c3 > 100) AND (c1 < 100);        加入了视图中的限定
                    
    命令
            ALTER VIEW 
                    ALTER [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
                VIEW view_name [(column_list)]
                AS select_statement
                [WITH [CASCADED | LOCAL] CHECK OPTION]
            
            CREATE VIEW
                    CREATE [OR REPLACE] [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
                VIEW view_name [(column_list)]
                AS select_statement
                [WITH [CASCADED | LOCAL] CHECK OPTION]
                
                    如：
                    CREATE VIEW test.v AS SELECT * FROM t;
                    CREATE VIEW v AS SELECT qty, price, qty*price AS value FROM t;                # 可以计算
                    CREATE VIEW v AS SELECT CHARSET(CHAR(65)), COLLATION(CHAR(65));                # 可以联合
            DROP VIEW
                    DROP VIEW [IF EXISTS]
                view_name [, view_name] ...
                [RESTRICT | CASCADE]
                        # 如果给定了RESTRICT和CASCADE，将解析并忽略它们。

            SHOW CREATE VIEW view_name
## 索引
    类型
            index
            unique                        # 不重复（单列、多列组合）
            primary key                # 带有名称的unique，所以一个表只能有一个

    创建
            create index
                    CREATE INDEX index_name ON table_name (column_list)
                    CREATE UNIQUE INDEX index_name ON table_name (column_list)
                            # 不可以创建primary key 索引
            
            通过alter
                    ALTER TABLE table_name ADD INDEX index_name (column_list)
                    ALTER TABLE table_name ADD UNIQUE (column_list)
                    ALTER TABLE table_name ADD PRIMARY KEY (column_list)
                            # 多列时各列之间用逗号分隔。索引名index_name可选，缺省时，MySQL将根据第一个索引列赋一个名称。

    删除
            DROP INDEX index_name ON talbe_name
            ALTER TABLE table_name DROP INDEX index_name        # 等价于前一个
            ALTER TABLE table_name DROP PRIMARY KEY
            
    查看
            show index from tblname
            show keys from tblname;        
                    # · Table
                    　　表的名称。
                    　　· Non_unique
                    　　如果索引不能包括重复词，则为0。如果可以，则为1。
                    　　· Key_name
                    　　索引的名称。
                    　　· Seq_in_index
                    　　索引中的列序列号，从1开始。
                    　　· Column_name
                    　　列名称。
                    　　· Collation
                    　　列以什么方式存储在索引中。在MySQL中，有值‘A’（升序）或NULL（无分类）。
                    　　· Cardinality
                    　　索引中唯一值的数目的估计值。通过运行ANALYZE TABLE或myisamchk -a可以更新。基数根据被存储为整数的统计数据来计数，所以即使对于小型表，该值也没有必要是精确的。基数越大，当进行联合时，MySQL使用该索引的机会就越大。
                    　　· Sub_part
                    　　如果列只是被部分地编入索引，则为被编入索引的字符的数目。如果整列被编入索引，则为NULL。
                    　　· Packed
                    　　指示关键字如何被压缩。如果没有被压缩，则为NULL。
                    　　· Null
                    　　如果列含有NULL，则含有YES。如果没有，则该列含有NO。
                    　　· Index_type
                    　　用过的索引方法（BTREE, FULLTEXT, HASH, RTREE）。
                    　　· Comment
                    　　更多评注。
# 数据字典
    information_schema
            # 默认内置元信息数据库
            INNODE_TRX
                    # 当前开启的事务
    mysql
            # 内置安全设置数据库
    selectperson
            # 点名系统
    test
            # 内置测试数据库
# 配置
    // my.cnf

    [client]

    port=3306
    socket=/tmp/mysql.sock

    [mysql]
    default-character-set=gbk

    [mysqld]
    character-set-server=utf8

    port=3306
    socket=/tmp/mysql.sock
    log-bin=mysql-bin
    server-id=1
    skip-name-resolve
            # 远程访问时非常慢解决
    innodb-flush-log-at-trx-commit=2
    innodb_log_file_size=268435456
    sync-binlog=1
            # 这两个配置为了使用事务的InnoDB在复制中最大的持久性和一致性
    master-connect-retry=60
            # 从服务器断开重连时间
    binlog-do-db=test
            # 主从都可以设置，复制的数据库
    binlog-ignore-db=mysql
            # 主从都可以设置，不复制的数据库
    lower_case_table_names=1
            # 设置大少写不敏感
    interactive_timeout=3600
    sql_mode=IGNORE_SPACE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
# 案例
    初始化
            mysql_secure_installation
            mysqladmin -uroot -p 原密码 新密码
            mysql_safe --user=mysql --skip-grant-tables --skip-networking
                    # 用于再登录重置密码

    远程登录
            # 远程登录必须要密码
            GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'asdf' WITH GRANT OPTION;
                    # flush privileges
            GRANT ALL PRIVILEGES ON *.* TO 'jack'@’10.10.50.127’ IDENTIFIED BY 'asdf' WITH GRANT OPTION;
                    # flush privileges
    修改密码
            方案1
                    set password for root@localhost = password('123');
            方案2
                    mysqladmin -uroot password 123
            方案3
                    mysqld_safe --user=mysql --skip-grant-tables --skip-networking &
                    mysql -u root mysql
                    UPDATE user SET Password=PASSWORD('newpassword') where USER='root';
                            # 新版中password改为authentication_string
                    flush privileges;
            方案4
                    使用/etc/mysql/my.cnf中[client]下的user与password
            方案5
                    a.sql
                            update mysql.user set password=password('mysql') where user='修改用户';
                            flush privileges
                    mysqld --defaults-file="a.sql"
    主从复制
        mysql配置文件my.cnf
        [mysqld]
            log-bin=mysql-bin  
            server-id=222 
            log-slave-updates =1
                        # m-m-s结构中第二个m配置
        主服务器授权从服务器
                GRANT REPLICATION SLAVE ON *.* to 'slave'@'%' identified by 'asdf';
        从服务器设置主服务器
                change master to master_host='192.168.56.14', master_user='slave', master_password='asdf', master_log_file='mysql-bin.000001', master_log_pos=319;
        命令
                主服务器
                        flush tables with read lock;
                        grant replication slave on *.* to 'slave'@'%' identified by 'asdf'
                        show master status\G
                        unlock tables;
                从服务器
                        stop slave
                        change master to master_host='192.168.0.42', master_user='slave', master_passowrd='asdf', master_log_file='mysql-bin.000001', master_log_pos=120;
                        start slave
                        show slave status\G
        问题
                The slave I/O thread stops because master and slave have equal MySQL server UUIDs; these UUIDs must be different for replication to work.
                        # 随意修改data/auto.cnf中的uuid的值
                主A复制到主B后，主B不会把数据复制到主B的从
