# 基础
    端口
        3306
    命令
        mysql
            --max-relay-logs-size=300                        # 中继日志大小(sql语句数)
            --relay-log-purge={0|1}                        # 中继日志自动清空
            --relay-log-space-limit=0                        # 限制中继日志大小,0表示无限制
        services.msc
        mysql -h 127.0.0.1 -u root -p
        mysqldump -uroot -p day02>d:/backup.sql                // 备份
        mysql -uroot -p day02<d:/backup.sql                        // 导入
        mysqladmin -uroot -proot status                                # 查看当前连接数
    组件
        mysql enterprise monitor documentation
        mysql enterprise monitor connector
        mysql enterprise monitor service manager
        mysql enterprise monitor agent
        mysql enterprise backup
        mysql connector
        工具
            mysql database
            mysql cluster          # 创建集群，配置复杂
            mysql cluster manager  # cluster帮助软件，配置简单
            mysql workbench        # 据库建模工具
            mysql utilities        # 提供一组命令行工具用于维护和管理 MySQL 服务器
    连接参数
        root:123456@tcp(abcdefg:3306)/meiqia?
            charset=utf8mb4,utf8&
            characterEncoding=UTF-8&
            loc=UTC&
            interpolateParams=true&
            time_zone=%27%2B00%3A00%27&
            sql_mode=%27NO_ENGINE_SUBSTITUTION%2CSTRICT_TRANS_TABLES%27
    数据类型
        int         # int(5) zerofill
        varchar(20)     # null不占空间
        decimal(10,2)  # 小数
        char(10)        # 空间已固定, 不论null与否
        date
        bool或boolean
        double
        float
        longtext
        longblob
        timestamp       # 自动在插入、修改记录时添加，用于记录更新
        enum('male','female') default male  # 枚举，只有一个
        set(('football','sleep','film')     # 集合，可以多个
    架构
        服务器
            连接管理与安全验证
            解析器     # 解析到缓存
                查询缓存(修改时清出缓存)，分析查询语句，生成解析树
            优化器
                查询语句优化
                    选索引
                    读取方式
                    获取查询开销信息
                    统计信息
            执行器
                执行查询语句，返回结果
                生成执行计划
        缓存
            执行计划缓存
            数据缓存
        存储引擎
            缓存管理    # 管理缓存
            锁管理      # 管理执行器
            事务管理
            文件管理
                innodb
    事务
        由存储引擎决定     # 与其它数据库产品不同
        默认自动提交
            # variables autocommit, 0 off 1 on
        一些命令强制自动提交
            DLL命令
            lock tables

# 引擎
    XtraDB
    Memory(Heap)
        # 之前叫Heap, 存到内存
    NDB
        特点
            集群设计
            share nothing, 高可用，可扩展
            存到内存, 主键查找快
            join操作在数据库层完成，不是引擎完成。需要网络开销大，查询慢
    Archive
        # 适合归档数据，只支持insert和select,提供高速插入和压缩功能
    Federated
        # 不存数据, 指向远程表，类似oracle的透明网关
    Maria
        # 开源，用于取代M主ISAM
    MyISAM
        特点
            不支持事务
            表锁
            适用联机分析(OLAP)
            不缓存数据文件，只缓存索引文件
            占较少空间保存数据与索引
        表文件
            .frm    # 存储定义
            .MYD    # MYData 存储数据
            .MYI    # MYIndex 存储索引
    InnoDB
        特点
            支持事务
            行锁
            支持外键
            支持非锁定读  # 类似oracle, 默认读不产生锁
            面向联机事务(OLTP)
            数据放在一个逻辑表空间中    # 类oracle
            实现4种隔离级别
                默认可重复读repeatable, 使用next-key locking的策略避免幻读
            索引组织表(Clustered)的方式进行存储     # 类oracle
            内存池维护并发线程
# 函数
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
# 系统库/数据字典
    系统库
        information_schema
            # 默认内置元信息数据库
            INNODE_TRX
                # 当前开启的事务
        mysql
            # 内置安全设置数据库
        performance_schema
            # 资源消耗，资源等待等情况
        sys
            # 5.7后，数据来源performance_schema, 降低复杂度
        test
            # 5.7移除，内置测试数据库
# 触发器(trigger)
    new与old
        # 指代新数据
        insert只有new是合法的；
        delete只有old才合法；
        update可同时使用。
    语句
        show triggers [from schema_name];
        drop trigger [if exists] [schema_name.]trigger_name
    例1
        create trigger tr1
        after                   # before, after
        insert on tb1           # insert, update, delete
        for each row
        update tb2 set field1 = field1+char_length(new.name);
            # 当更新表tb1的name字段时，更新表tb2 field1加上name的长度
    例2      # UPDATE同时使用NEW和OLD
        create trigger tr1
        before update on t22
        for each row
        begin
        set @old = old.s1;
        set @new = new.s1;
        end;
# 存储过程(stored procedure)
    # 5.0加入
    结束符号(delimiter) //
    语法
        create procedure 存储过程名(参数类型 参数名 参数数据类型)
        begin
                业务逻辑
        end//

        call pro1()//
            # 执行

        drop function pro1;

        语句
            # 所有sql语句都是合法的

            declare a int default 2;

            set @name = 'admin';
                # @name 为局部变量        @@name 为全局变量

            if
            then
            else
            end if;

            case variable1
            when 0 then
            when 1 then
            else
            end case

            while true do
            end while

            loop_label:LOOP
            LEAVE[ITERATE] loop_label;
            end loop [end loop_label]        # iterate是迭代

            LABEL label_name
            GOTO label_name

            repeat until
            end repeat # 执行后检查结果

    存储过程名
        大小写不敏感
        可以包含空格，最长为64位
        最好数据库名.过程名
        不要使用内建函数名
    参数类型
        IN参数    # 不修改传递进来的参数
        OUT参数   # 参数无法传进来，只修改参数
        INOUT参数 # 可读可写

    特征子句(characteristics clauses)
    查看
        show procedure status;
        show create procedure proc_name;
        show create function func_name;
        

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

    函数
        # 与存储过程唯一不同必须有RETURN语句
        # 不能在函数中访问表
                    
        function example1:
        create function myadd(num1 int, num2 int)
        returns int
        begin
        return num1 + num2;
        end//

                    
    例1
        create procedure pro(in name varchar(20))
        begin
        select name;
        set name='hello world';
        select name;
        end//

        set @name='jnb'//
        call pro(@name)//

    例2      # if语句，根据输入0/1 判断 男/女
        create procedure findGender(in op int)
        begin
        declare gendar varchar(20);                                # 在函数中定义变量gendar和其类型
        if op=0 then                                                        # =表示判断
        set gendar='male';
        else set gendar='female';
        end if;
        select gendar;
        end//

    例3      # switch语句，判断星期
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
            
    例4      # while循环
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
            
    例5      # 验证登录
        create procedure prologin(in user_name varchar(20), in user_psw varchar(100), out flag int)
        begin
        if exists(select name from users where name=user_name and psw=password(user_psw)) then
                set flag = 1;
        else
                set flag = 0;
        end if;
        end//

# 配置
    o-> my.cnf文件
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
# 安全性
    跨域访问，使用ssh隧道加密通信
    set password设置密码
    用grant和revoke对用户授权
        少开权限
        只有启动mysql的用户有写权限
        只授权process和super权限给管理用户
            mysqladmin processlist 可列举当前执行的查询
            super 可切断连接，改变服务器运行参数，控制从库
        不信任dns时，权限表只设置ip
    常见攻击
        防偷听
        篡改
        回放
        拒绝服务
    acl控制接口权限
    设置只有root可访问mysql数据库和user表
    不用明文密码，密码强度高
    数据库放在防火墙后，或在DMZ(demilitarized zone, 隔离区)
    防火墙设置3306端口不可访问
    sql预编译，避免sql注入
    存数据时检查大小
    以普通用户启动mysql
    tcpdump检查传输数据的安全性
        tcpdump -l -i eth0 -w -src or dst port 3306 strings
    max_user_connections变量限制指定帐户连接数
    打开mysqld安全开关
        --local-infile=0     # 0时客户端无法使用local load data
        --skip-grant-tables     # 对用户不做访问控制
            mysqladmin flush-privileges # 运行中开启访问控制
            mysqladmin reload           # 运行中开启访问控制
        --skip-show-databases   # 禁止show databases

# 方案
    初始化
        mysql_secure_installation
        mysqladmin -uroot -p 原密码 新密码
        mysql_safe --user=mysql --skip-grant-tables --skip-networking
                # 用于再登录重置密码
    授权远程登录
        GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'asdf' WITH GRANT OPTION;

    mysql重置密码
        UPDATE user SET password=PASSWORD('asdf') WHERE user='root';
        FLUSH PRIVILEGES;

    创建用户
        CREATE USER 'username'@'host' IDENTIFIED BY 'password';
    删除用户
        DROP USER 'username'@'host';

    修改密码
        问题
            error 1045(28000) access denied for user 'root'@'localhost' (using password:no)
        update方式
            update mysql.user set password=password('root') where user='root';
        set方式
            SET PASSWORD FOR 'username'@'host' = PASSWORD('newpassword');
            flush privileges;
        mysqladmin方式
            mysqladmin -uroot -p password 新密码
        mysqld_safe方式
            mysqld_safe --user=mysql --skip-grant-tables --skip-networking &
            mysql -u root mysql
            UPDATE user SET Password=PASSWORD('newpassword') where USER='root';
                    # 新版中password改为authentication_string
            flush privileges;
        文件方式
            使用/etc/mysql/my.cnf中[client]下的user与password
        mysqld方式
            mysqld --skip-grant-tables
            mysql -u root mysql
            update user set password=password('asdf') where user='root'
            flush privileges
            重启mysql
        mysqld方式2
            创建a.sql
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
    编码问题
        查询
            show variables like "%colla%"       # 字符串排序规则
            show variables like "%char%"
        修改
            set character_set_client='utf8'
        创建db时指定
            create database `db1` character set 'utf8' collate 'utf8_general_ci'
        创建表时指定
            create table (...) engine=innodb default charset=utf8
        查看db和表编码
            show database `db1`
            show create table `tb1`
        修改db和表编码
            alter database `db1` default character set utf8 collate utf8_general_ci
            alter table `tb1` default character set utf8 collate utf8_general_ci