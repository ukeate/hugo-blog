
# 基础
    安装
        运行services.msc
        找到OracleServiceORCL 服务 （最后是数据库名）改为手动
        sqlplus / as sysdba 运行oracle测试是否安装成功
        解锁scott用户
            sqlplus / as sysdba
            alter user scott account unlock;
            alter user scott identified by tiger;
    启动
        OracleServiceORCL
        OracleOraDb11g_home1TNSListener
    端口
        1521    # 停了以后再开会变
    权限
        系统权限：创建数据库，创建用户
        对象权限：表操作
        sys create database权限
        system  没有create database权限
        scott
        hr
        角色  # 超管以角色进入，普通用户输入用户名密码
            dba
            dbaoperator
    服务器的组成
        oracle数据库
            存储位置 oracle安装位置/oradata/
                每个数据库文件夹中有多个二进制文件（*.dbf）
        oracle实例(内存概念)
            一个数据库进程可以有多个实例
            一个实例可以有多个数据库进程和一个内存池(缓存)    # 不同于windows进程，每个进程对应一个用户访问
            服务名为OracleService数据库名
        集群(多实例)
            连接失败转移
            负载均衡
    连接类型
        normal sysdba sysoper
    分布式
    认证
        开发技术认证
        Java认证
                    数据库开发语言SQL和PL/SQL认证
        数据库技术认证
            OCM【大师】
            OCP【专家】
            OCA【初级】
        中间件技术认证
            OracleServer认证，WEB服务器认证
        专业领域技术认证
            ERP
            CRM
            HR
            OA
    支持的事务隔离
        只支持读提交与序列化两种
    版本
        8i 9i 10i   # i是internet
        11g         # 基于jdk6, g是grid网格(一个请求多个服务器运行)
        12c         # c是cloud
    SQL99标准     # 不区分大小写
        PLSQL是Oracle对SQl99标准的扩展
        结构代查询语言
            DML select,insert,update,delete
            DDL create table,alter table, drop table
            DCL grant, revoke
            TCL(杜撰) commit, rollback,rollback to savepoint
    加载过程
         启动oracle服务
            oradim -startup -sid 数据库名                 # 相当于windows服务中启动该服务，会从windows注册表中加载配置
            oradim -shutdown -sid orcl -shuttype srvc    # 停止oracle 服务
            普通登录
                sqlplus system/asdf                 # 从注册表中查找默认的数据库名称进行登录
                sqlplus system/asdf@orcl            # 指定数据库名登录，必须有监听的时候该命令可以执行，监听的进程是独立于oracle之外的进程
            管理员登录
                sqlplus / as sysdba                 # windows管理员的身份进行登录，不需要用户名密码，可以在配置文件中禁用它
            无连接登录
                sqlplus /nolog                      #用来设置sql/plus
        启动实例
            cmd> sqlplus / as sysdba                    # 连接到数据库的空闲实例
            sql> select status from v$instance          # 查看实例状态
            sql> shutdown abort                         # 立即终止当前的实例,实例结束后用户仍然登录状态，但没有连接实例
            sql> startup nomount                        # 启动默认实例（不加载数据库）
            sql> startup open                           # 启动、装载、打开默认的数据库
            cmd> set oracle_sid=orcl                    # 在windows下设置oracle的默认登录数据库

            启动过程
                加载参数文件database/init数据库名
                分配sga (system global area)到内存空间，用于缓存数据库信息
                创建后台进程
        挂载数据库
            sql> startup mount

            挂载过程
                装载数据库文件夹中的文件    # sga中有已经初始化了ctl文件的路径，通过ctl文件装载数据库
                ctl(从中得到数据库文件名) -> dbf
                        # 3种数据库文件: .ctl(控制文件) .dbf(数据库文件) .log(日志文件)
                这时，数据库还是不能访问,但是管理员可以访问（debug数据库）
        打开数据库       # 使外界可以访问
            sql> alter database 数据库名 open                # 数据库文件夹中记录日志
# 类型
    varchar2(7)        # 可变字符串
    char                # 字符
    number(precision [, scale])    # presision是有效位（从左边第一个不为0的数算起，小数点和负号不计入有效位数），scale是精确位（正数为小数的精确位，负数为整数的精确位）
    constant number                # 常量

# 数据字典
    dual                # dual表只有一行，用于执行一些特殊操作
    dba_sequences
            select SEQUENCE_OWNER,SEQUENCE_NAME from dba_sequences
                    # 查询序列
    dba_users
            select username,password from dba_users;
                    # 查询用户和密码
    tab
            select * from tab
                    # 查看自己的可用表，视图，等
    v$session
            select count(*) from v$session
                    # 查看当前数据库的连接
# 存储过程
    过程与函数
        返回值
            函数有且只一个返回值
            过程没有或多个返回值用(out参数)
            过程可返回函数,函数只能返回值或表对象
        过程和函数不能重名
        函数可嵌入sql执行，过程不行
    语法
        IF .. THEN
                null;
        ELSIF .. THEN
                null;
        ELSE
                null;
        END IF;

        select into给变量赋值

        raise 异常名   # 抛异常
    函数
        create or replace function calculate_score
        ( cat in varchar2
        , score in number
        , weight in number
        ) return number as
        begin
        return null;
        end calculate_score;


        例子1     # in参数 和返回值的函数
            create or replace function findEmpIncome(pempno in number) return number
            as
                income number(10);
            begin
                select sal*12+NVL(comm,0) into income from emp where empno = pempno;
                return income;
            end;
            /
        例子2     # in、out 参数和返回值的函数
            create or replace function findEmpNameAndSal (pempno in number, psal out number)return varchar2
            as
            pename emp.ename%type;
            begin
            select ename , sal into pename,psal from emp where empno = pempno;
            return pename;
            end;
            /
            执行
            declare
            psal emp.sal%type;
            pename emp.ename%type;
                begin
                    pename := findEmpNameAndSal(7788,psal);
                    dbms_output.put_line(pename||'的工资是'||psal);
                end;
                /
    过程
        # 参数默认in
        create or replace procedure add_evaluation
        ( evaluation_id in number
        , employee_id in number
        , evaluation_date in date
        , job_id in varchar2
        , manager_id in number
        , department_id in number
        ) as            # as 变量 类型 (值范围);
        begin
        null;
        exception
            when others then
                rollback;
        end add_evaluation;

        exec  add_evaluation

        drop procedure add_evaluation;

        例子1                # in 参数的使用
            create or replace procedure raiseSalary(pempno in emp.empno%type)
            as
            begin
                update emp set sal = sal * 1.1 where empno = pempno;
            end;
            /
            exec raiseSalary(7369);
        例子2                # out参数的使用                select into
            create or replace procedure findEmpNameAndSalAndJob (pempno in emp.empno%type,
            pename out emp.ename%type,
            pjob out emp.job%type,
            psal out emp.sal%type)
            as
            begin
                select ename,job,sal into pename,pjob,psal from emp where empno = pempno;
            end;
            /
            declare
                pename emp.ename%type;
                pjob  emp.job%type;
                psal  emp.sal%type;
            begin
                findEmpNameAndSalAndJob(7788,pename,pjob,psal);
                dbms_output.put_line('7788号员工的姓名是'||pename||',职位是'||pjob||',薪水是'||psal);
            end;
            /
    包
        声明
            create or replace PACKAGE emp_eval AS
            PROCEDURE eval_department(department_id IN NUMBER);
            FUNCTION calculate_score(evaluation_id IN NUMBER , performance_id IN NUMBER)
                RETURN NUMBER;
            END emp_eval;
        定义
            CREATE OR REPLACE PACKAGE BODY emp_eval AS

            PROCEDURE eval_department(department_id IN NUMBER) AS
            BEGIN
                /* TODO implementation required */
                NULL;
            END eval_department;

            FUNCTION calculate_score(evaluation_id IN NUMBER , performance_id IN NUMBER)
                RETURN NUMBER AS
            BEGIN
                /* TODO implementation required */
                RETURN NULL;
            END calculate_score;

            END emp_eval;

# 触发器
    分类
        # select 没有触发器
        语句级insert / delete           # 只在语句执行时触发
        行级(for each row)update        # 每一行都执行，出错后不会继续执行并且回滚
    语法
        create [or replace] trigger 触发器名
        {before|after}
        {insert|delete|update of 列名}
        on 表名
        for each row
        plsql块

        行级触发器中
            :new 代表更新后那一行整行的值
            :old 则是旧的整行的值
            update of 列名 for each row是连起来用的。语句级触发器没有for each row

        drop trigger 触发器名

    例子(语句级)
        # 当在休息日与非9点到17点之间的时候，禁止对emp表进行插入操作
        create or replace trigger securityTrigger
        before insert on emp
        declare
        pday varchar2(10);
        phour number(20);
        begin
        select to_char(sysdate,'day') into pday from dual;
        select to_char(sysdate,'hh24') into phour from dual;
        if(pday in ('星期六','星期日') or (phour not between 9 and 17)) then
        raise_application_error('-20666','禁止操作');
        end if;
        end;
        /
    例子(行级)：当对每一行的工资进行修改的时候，新的工资不能小于原来的工资
        create or replace trigger checkSalayTrigger
        before update of sal on emp for each row
        begin
        if :new.sal < :old.sal then
        raise_application_error('-20555','工资不能减少');
        end if;
        end;
        /
# 函数及常量
    常量
        sysdate 当前日期

    单行函数
        nvl(comm,0)                        # 替换comm列中的空值为0
        nvl2(comm,comm,0)                # 替换comm列中的空值为0，非空时为comm
        select lower('AAA') from dual;                        # 取小写
        upper('')                # 取大写
        initcap('www.itcast.cn')        # 每一段字符串的首字符大写
        concat('','')                        # 拼接字符串
        substr('itcast',1,3)        # 取第一个和第三个字符，脚标从1开始
        length('')                # 字符的长度
        lengthb('')                # 字节的长度
        instr('itcast','t')      # 查找第一个匹配字符串的位置,区分大小写
        lpad('a',10,'*')                # 左填充，一直到10位,也可以截取左边的10位字节（并非字符）
        rpad('a',10,'*')                # 右填充，一直到10位,也可以截取右边的10位字节（并非字符）
        trim('x' from 'xxhelloxsx')                # 增强版trim(),去掉字符串中的所有'x'
        replace('hello','l','o')                # 替换字符串中的'l' 为 'o'
        round(3.45,2)                # 四舍五入，2代表小数点后的位数  -1代表个位，-2代表十位
                round(sysdate,'month')      # 四舍五入到月(15号前后判断)
        round(sysdate,'year')      # 四舍五入到年(6月30号前后判断)
        trunc(3.142,1)                # 截取小数点后1位
        mod(10,3)                        # 10mod3取余
        nullif(10,20)                # 比较两个数值，相同时返回空，不同时返回第一个数值
        (job,'analyst',sal + 1000,"manager",sal + 800, sal + 400) "新工资" from emp;
        decode(...)函数：例子
            select ename "姓名" , sal "原工资" , decode(job, 'analyst',sal + 1000, 'manager',sal + 800, sal + 400) "新工资" from emp;
            select ename "姓名" , sal "原工资" , case job when 'analyst' then sal + 1000 when 'manager' then sal + 800 else sal + 400 end "新工资" from emp
                #sql99语法
        日期函数
            sysdate +/- 1                # 增加或减少1天
            sysdate - hiredate                # 日期减日期，得到天数
            to_char(sysdate,'yyyy-mm-dd hh24:mi:ss')                # 格式化显示时间
            months_between('12-2月-13',sysdate)        # 日期之间的月数
            add_months(sysdate,1)                # 给当前日期增加1个月
            next_day(sysdate,'星期一')        # 下一个星期一的日期
            last_day(sysdate)                        # 反回这个月的最后一天
        类型转换：
            隐式转换                # 要求 1，格式正确。2，内容合理
                字符串与Date,number相互转换
            显式转换
                到字符串：
                    日期到字符串：to_char(sysdate,'yyyy "年" mm "月" dd "日" day hh12:mi:ss:am')
                        # day是星期、hh12是12进制计时(hh24代表24进制计时)、am是个变量,上午时是am，下午是pm
                        ##　双引号中的内容直接显示
                    货币值到字符串：to_char(1234,'L9,999')
                        # L可以小写，代表当地货币，','可以省略
                字符串到Date： to_date('1980-12-17','yyyy-mm-dd')
                字符串转换到数字：        to_number('123')
    多行函数    # 多行函数分为接收多个输入，返回一个输出。
               ##　多行函数本身不会统计值为null的记录
               ## 多表的多行函数的统计多会用到group by ，因为where 只是筛选出了不符合条件的部分
               ## ,剩下的部分分列在不同的表中，只有按照列名分组以后才能按列名执行多行函数
        having
        count([distinct] deptno)                # 统计deptno【不重复的】记录数
        sum(sal)                # 统计数值的和
        avg(sal)                # 统计平均值
        max(sal)                # 统计最大值，可以用在日期上
        min(sal)                # 统计最小值 ，可以用在日期上
# 游标
    分类
        显示
            cursor is
        隐式
            执行insert, delete, update，返回单条记录的select时，pl/sql自动定义
# 闪回技术
    可以闪回的操作
            dml 
            ddl操作（回收站中存在）

    闪回记录
            1.获取当前时间与改变号
                select to_char(sysdate,'yyyy-mm-dd:mi:ss') "系统时间", timestamp_to_scn(sysdate) "系统改变号" from dual;
                        # scn 是 系统改变号，每秒钟都会变，oracle根据它来进行闪回,如1216687
        2.给普通用户授于闪回的权限
            grant flashback any table to scott;
        3.alter table emp enable row movement;      # 更改rowid号可以更改
        4.flashback table emp to SCN 1216687;      # 闪回表到时间改变号
            # 如果没有做第三步，这里会出错 ，原因是 还原表记录时，递增的rowid后面不能插入数据。在rowid之间插入数据必须改变rowid的状态为可以'移动'，即还原记录后面的表记录可以'移动'。 

    闪回表（回收站中才可以）
            1.确定回收站中有该表，可以用show recyclebin命令查看
            2.flashback table emp to before drop;
                    # flachback table "BIN$Pu9C2euHQ96xySmn08e5aQ==$0" to before drop;        也是可以的
            3.如果回收站中有两个相同的表需要闪回时，设置一个表名
                    flashback table emp to before drop rename to newemp;
                            # 两张同名的表首先恢复最近删除的表
# 审计
    审计（Audit)
            用于监视用户所执行的数据库操作，并且Oracle会将审计跟踪结果存放到OS文件（默认位置为$ORACLE_BASE/admin/$ORACLE_SID/adump/）
            或数据库（存储在system表空间中的SYS.AUD$表中，可通过视图dba_audit_trail查看）中。
            默认情况下审计是没有开启的。
            不管你是否打开数据库的审计功能，以下这些操作系统会强制记录：用管理员权限连接Instance；启动数据库；关闭数据库。
            
    两个参数                # cmd> set xxx=xx
                            ## 这两个参数是static参数，需要重新启动数据库才能生效。
            Audit_sys_operations
                    默认为false，当设置为true时，所有sys用户（包括以sysdba,sysoper身份登录的用户）的操作都会被记录，
                    audit trail不会写在aud$表中，因为数据库还没有启动，conn / as sysdba 这样的命令是没法记录的
                    windows平台记录在windows的事件管理中,unix平台记录在audit_file_dest参数指定的文件中
            Audit_trail
                    None：是默认值，不做审计；
                    DB：将audit trail 记录在数据库的审计相关表中，如aud$，审计的结果只有连接信息；
                    DB,Extended：这样审计结果里面除了连接信息还包含了当时执行的具体语句；
                    OS：将audit trail 记录在操作系统文件中，文件名由audit_file_dest参数指定；
                    XML：10g里新增的。
                    
    审计级别
            Statement(语句)、Privilege（权限）、object（对象）。
            
            Statement        按语句来审计，比如audit table 会审计数据库中所有的create table,drop table,truncate table语句。
            Privilege        按权限来审计，当用户使用了该权限则被审计，如执行grant select any table to a，
            object                按对象审计，只审计on关键字指定对象的相关操作，如aduit alter,delete,drop,insert on cmy.t by scott; 
# 工具
    sqldeveloper
    isqlplus
    dbconsole
    toad
## sqlplus
    命令
        # ;或/结束

        /               # 执行最近一次的sql命令（不执行工具命令）
        host cls        # 清屏
        edit            # 用本地编辑器编辑
        设置显示
            column deptno format 9999       # deptno是列名,9999 代表4个数字宽度
            column ename format a8          # a8代表8个字符宽度(date也用a)
                col ename for a8            # 简写
            set pagesize 40                 # 设置一页显示40条记录
            spool d:/a.sql                  # 假脱机,开始记录控制台信息
                spool off                   # 正式保存记录信息到文件
                @ d:/a.sql                  # 从脱机文件中导入命令并执行
        监查时间
            set timing on / set timing off  # 每执行一段语句显示语句的执行时间
            set time on / set time off      # 在输入标记前面显示当前时间
## pl/sql
    procedure language
    oracle对sql99的扩展
        增加了类型定义
        判断
        循环
        指针/游标/光标
        输出语句
        异常
    语法
        符号
            /   # 结束标记
            :=                # 赋值号
            &   # 进行定义运行时赋值
        语句
            declare    分号结束
            ;
            begin  dml语句/tcl语句,以分号结束 # 必写
            ;
            [exception]
            ;
            end;        # 必写
            /

            set serveroutput on;        # 设置plsql的输出打开，默认是off 的

            dbms_output.put_line('');  # 只能在 plsql 的执行语句中使用，dbms_output的输出方法,会自动换行

            emp.ename%type;        # 同emp表中的ename的类型一样的类型
            emp_record emp%rowtype      # 匹配一行类型
                emp_record.ename输出一个字段的数据


            if 条件1.1 and 条件1.2 then 语句1;
            elsif 条件2 then 语句2;
            else 语句3;
            end if;

            loop
            exit [when];
            end loop;

            while 条件
            loop
            ;
            end loop;

            for i in 1..3                # 不可以在循环中更改i的值
            loop
            ;
            end loop;

        cursor      # 多行数据 ，相当于resultset
            cursor c1 查询语句
            open c1;
            loop
            fetch                        # 先判断再下移，最后一条记录打印两次
                                            ## 先下移再判断 ，正常显示
            exit when 条件;
            end loop;
            close c1;

    异常
            内置异常
            no_data_found  # 没有查到数据,游标中使用的时候异常不抛出
                select ename into pename from emp where deptno = 100;      # select into 插入的数据找不到的时候
            too_many_rows  #
            zero_divide    # 除零异常
            value_error
            timeout_on_resource
                    例子
                            declare
                        i number(2) := 10;
                        s number(2);
                    begin
                        s:= i/0;
                    exception
                        when zero_divide then dbms_output.put_line('除0异常');
                    end;
                            /
            自定义异常
                    declare
                    no_emp_found exception;
                begin
                    if()then
                    raise no_emp_found;
                    end if;
                exception
                    when no_emp_found then dbms_output.put_line('查无数据');
                end;
                /
            抛出异常的函数
                    raise_application_error('-20666','禁止操作');
                            # begin语句中的相关地方调用此函数即可
                            # 20000-20999错误编号范围，是负数

    例1                # dbms_output.put_line('');
        declare
            mysum number(3);
        begin
            mysum := 10 + 100;      # :=就是赋值
            dbms_output.put_line('结果为' || mysum);
        end;
        /
    例2      # emp.ename%type
            ## select .. into ..
        declare
            x emp.ename%type;
            y emp.sal%type;
        begin
            --select ename,sal from emp where empno = 7369        # sql语句可以单独执行
            select ename,sal into x,y from emp where empno = 7369      # plsql语句只能整体执行
            dbms_output.put_line(x || '是' || y);
        end;
        /
    例3                # emp%rowtype
        declare
            emp_record emp%rowtype;
        begin
            select * into emp_record from emp where empno = 7788;
            dbms_output.put_line(emp_record.ename || emp_record.sal);
        end;
        /
    例4                        # 运行时赋值符号与if判断语句
        declare
        num number(2);
        begin
        num := &num;
        if num<5 then dbms_output.put_line(num || '<5');
        elsif num=5 then ..
        else ..
        end if;
        end;
        /
    例5                        # loop 循环
        declare
            i number(2) := 1;      # 声明的时候可以赋值
        begin
            loop
                exit when i > 10;
                dbms_output.put_line(i);
                i := i + 1;
            end loop;
        end;
        /
    例6                        # while循环
        declare
            i number(2) := 10;
        begin
            while i <= 20
            loop
                dbms_output.put_line(i);
                i := i + 1;
            end loop;
        end;
        /
    例7                        # for循环
        declare
            i number(2)
        begin
                loop
            for i in 20..30    # 一个一个增加,循环中不能再对i进行操作
                dbms_output.put_line(i);
            end loop;
        end;
        /
    例8                        # cursor
        declare
            cursor cemp is select ename,sal from emp;
            pename emp.ename%type;
            psal emp.sal%type;
        begin
            open cemp;
            loop
                exit when cemp%notfound;
                fetch cemp into pename,psal;
                dbms_output.put_line(pename || '的薪水是' || psal);
            end loop;
            close cemp;
        end;
        /
    例9 # 有参游标
        declare
            cursor cemp(pdeptno emp.deptno%type) is select ename,sal from emp where deptno=pdeptno;
            pename emp.ename%type;
            psal emp.sal%type;
        begin
            open cemp(&deptno);
            loop
                fetch cemp into pename,psal;
                exit when cemp%notfound;
                dbms_output.put_line(pename ||'的薪水是' || psal);
        end loop;
                close cemp;
                end;
                /
    例10 # 输入&emptno没有的时候，输出"查无员工"                # 综合if loop 与cursor
        declare
            cursor cemp(pdeptno emp.deptno%type) is select ename,sal from emp where deptno=pdeptno;
            pename emp.ename%type;
            psal emp.sal%type;
                        pdeptno emp.deptno%type := &deptno;
        begin
                if pdeptno in (10,20,30) then dbms_output.put_line('输入的值正确');
            open cemp(pdeptno);
            loop
                fetch cemp into pename,psal;
                exit when cemp%notfound;
                dbms_output.put_line(pename ||'的薪水是' || psal);
        end loop;
                close cemp;
                else dbms_output.put_line('输入的值不正确');
                end if;
                end;
                /

    例11 # 给所有ANALYST加工资        # 综合cursor if loop ,循环之后执行了tcl 事务控制语言
        declare
            cursor cemp is select empno,ename,job,sal from emp;
            pempno emp.empno%type;
            pename emp.ename%type;
            pjob emp.job%type;
            psal emp.sal%type;
        begin
            open cemp;
            loop
                fetch cemp into pempno,pename,pjob,psal;
                exit when cemp%notfound;
                if pjob='ANALYST' then
                    update emp set sal = sal+1000 where empno = pempno;
                end if;
            end loop;
            commit;
            close cemp;
        end;
        /

