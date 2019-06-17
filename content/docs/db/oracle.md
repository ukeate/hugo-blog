---
Categories : ["数据库"]
title: "Oracle"
date: 2018-10-11T15:46:29+08:00
---

# 启动：两个服务
    OracleServiceORCL
    OracleOraDb11g_home1TNSListener

# 服务器的组成
    oracle数据库
        存储位置 oracle安装位置/oradata/ 
            每个数据库文件夹中有多个二进制文件（*.dbf）
    oracle实例(内存概念)
        服务名      OracleService数据库名
            # 实例操作数据库
            # 实例包括多个进程与一个内存池(缓存)
# 工具        # 工具操作实例
    sqlplus
    sqldeveloper

# 分布式
    失败转移与负载平衡
    多个服务器集成：集群
        逐个连接服务器失败转移
        根据每个服务器的特点分配连接进程数
    
# Oracle认证
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
# 版本
    Oracle11g      用jdk6
    8i 9i 10i      # i 是internet 
    11g    # g 是grid网格(一个请求多个服务器运行)
    12c                # cloud

# 端口
    1521(lisener服务的端口号（停了以后再开会变）)
    netstat -a
# 权限
    系统权限：创建数据库，创建用户
    对象权限：表操作
    sys create database权限
    system  没有create database权限
    scott  
    hr
    角色  # 超管以角色进入，普通用户输入用户名密码
        dba
        dbaoperator
# SQL99标准（不区分大小写）
    PLSQL是Oracle对SQl99标准的扩展
    结构代查询语言
            DML select,insert,update,delete
        DDL create table,alter table, drop table
        DCL grant select any table to scott, revoke select any select from scott
        TCL(老师编的) commit, rollback,rollback to savepoint
# 原理
    oracle总体结构
            1. 一个数据库进程可以有多个实例：集群
            2. 一个实例可以有多个数据库进程（不同于windows进程，每个进程对应一个用户访问）用来访问多个数据库，和一个内存池
            3. 工具与实例间通过网络连接
                    sqlplus
                    isqlplus
                    dbconsole
                    pl/sql
                    toad
                    
    oracle 的连接类型
            normal sysdba sysoper
            
    加载过程
            0. 启动oracle服务
                    cmd> oradim -startup -sid 数据库名                # 相当于windows服务中启动该服务，会从windows注册表中加载配置
                    cmd> oradim -shutdown -sid orcl -shuttype srvc    # 停止oracle 服务
                    普通登录
                            sqlplus system/asdf                # 会从注册表中查找默认的数据库名称进行登录
                            sqlplus system/asdf@orcl        # 指定数据库名登录，必须有监听的时候该命令可以执行，监听的进程是独立于oracle之外的进程
                    管理员登录
                            sqlplus / as sysdba                # windows管理员的身份进行登录，不需要用户名密码，可以在配置文件中禁用它
                    无连接登录
                            sqlplus /nolog      用来设置sql/plus
            1.启动实例 
                    当数据库实例没有启动的时候，执行sqlplus / as sysdba 连接到数据库的空闲实例
                    sql> select status from v$instance        # 查看实例状态
                    sql> shutdown abort    # 立即终止当前的实例,实例结束后用户仍然登录状态，但没有连接实例
                    sql> startup nomount 启动默认实例（不加载数据库）
                    sql> startup open        启动，装载并打开默认的数据库
                            cmd> set oracle_sid=orcl                # 在windows下设置oracle的默认登录数据库
                    
                    过程分析
                            1.加载参数文件  database/init数据库名..
                            2.分配sga (system global area)到内存空间 ，用于缓存数据库信息
                            3.创建后台进程        
            2.mount database
                    sql> startup mount 
                    
                    过程分析
                            装载数据库文件夹中的文件  (sga中有已经初始化了ctl文件的路径，通过ctl文件装载数据库)
                            ctl (得到了数据库文件名)-> dbf
                                    #　数据库文件夹中有3种文件        .ctl(控制文件)  .dbf(数据库文件)  .log(日志文件)
                            
                            这时，数据库还是不能访问,但是管理员可以访问（debug数据库 ）
            3.open database                        # 外界可以访问
                    sql> alter database 数据库名 open                # 打开数据库,数据库文件夹中记录日志 
# 类型
    varchar2(7)        # 可变字符串
    char                # 字符
    number(precision [, scale])    # presision是有效位（从左边第一个不为0的数算起，小数点和负号不计入有效位数），scale是精确位（正数为小数的精确位，负数为整数的精确位）
    constant number                # 常量

# 特色sql
    注意
            o-> sql语句中不区分大小写
            
    语法与常识
            o-> ||                        # 管道符号，用于拼接字符串，相当于java中的'+',例如
                    select ename || '的薪水是' || sal from emp; 
            o-> dual表                # dual表只有一行，用于执行一些特殊操作
            o-> 双引号出现的地方：
                            列名取别名时， 如select sal [as] "薪水" 
                            日期转换字符串时,双引号中的内容直接显示，如to_char(sysdate,'yyyy "年" mm "月" dd "日" day')
            o-> 表名取别名 不加 as 关键字，定义好别名后，原名称无效
            o-> 单引号出现的地方：包围字符串
            o-> 单引号中的字符串大小写敏感
            o-> 注释--                单行注释
                    /**/        多行注释
            o-> = 可以配置日期
            o-> != 与 <>都可以用作不等于
            o-> = 后面的是精确的数值,null不是 ，所以判断null都是用is ，或 is not
            o-> * 通配所有列名,可以直接使用，也可以 表名.* 表示一张表中的所有列
                    * 不能直接与字段连用,与字段连用的话要使用  表名.* 的格式来表示表中的所有数据
                    
    查询语法注意
            o-> where 语句后面不能出现列的别名，但是可以出现表的别名
            
## 存储过程
    创建语法
            过程
                    CREATE OR REPLACE PROCEDURE ADD_EVALUATION
                    ( evaluation_id IN NUMBER
                    , employee_id IN NUMBER
                    , evaluation_date IN DATE
                    , job_id IN VARCHAR2
                    , manager_id IN NUMBER
                    , department_id IN NUMBER
                    ) AS
                    BEGIN
                    NULL;
                    END ADD_EVALUATION;
            函数
                    CREATE OR REPLACE FUNCTION calculate_score
                    ( cat IN VARCHAR2
                    , score IN NUMBER
                    , weight IN NUMBER
                    ) RETURN NUMBER AS
                    BEGIN
                    RETURN NULL;
                    END calculate_score;
            包
                    声明
                            create or replace PACKAGE emp_eval AS
                            PROCEDURE eval_department(department_id IN NUMBER);
                            FUNCTION calculate_score(evaluation_id IN NUMBER
                                                                            , performance_id IN NUMBER) 
                                                                            RETURN NUMBER;
                            END emp_eval;
                    定义
                            CREATE OR REPLACE PACKAGE BODY emp_eval AS
                            
                            PROCEDURE eval_department(department_id IN NUMBER) AS
                            BEGIN
                                    /* TODO implementation required */
                                    NULL;
                            END eval_department;
                            
                            FUNCTION calculate_score(evaluation_id IN NUMBER
                                                                            , performance_id IN NUMBER)
                                                                            RETURN NUMBER AS
                            BEGIN
                                    /* TODO implementation required */
                                    RETURN NULL;
                            END calculate_score;

                            END emp_eval;
                            
            
    plSQL语法、语句
            SELECT .. INTO 变量 FROM .. WHERE ...;                                        # 存储结果到变量
            Dbms.output.put_line('打印信息');
            RETURN score * weight;                                                                        # 可以返回表达式
        n_score NUMBER(1,0) : = 9;                                            # 变量赋值
            scores.evaluation_id%TYPE                                                                # scores表evaluation_id的类型
            

    逻辑语法
            IF .. THEN
                    null;
            ELSIF .. THEN                # 这里就是ELSIF
                    null;
            ELSE
                    null;
            END IF;
## 触发器
    两种触发器
            语句级        insert / delete                        # 只在语句执行时触发
            行级(for each row)                update        # 每一行都执行，出错后不会继续执行并且回滚

    语法                        # select 没有触发器
            create [or replace] trigger 触发器名
            {before|after}
            {insert|delete|update of 列名}
            on 表名
            for each row
            plsql块
            
            行级触发器中
                    :new 代表更新后那一行整行的值        :old 则是旧的整行的值
                    update of 列名 for each row是连起来用的。语句级触发器没有for each row

    删除
            drop trigger 触发器名
            
    例子
            语句级： 当在休息日与非9点到17点之间的时候，禁止对emp表进行插入操作
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
            行级：当对每一行的工资进行修改的时候，新的工资不能小于原来的工资
                    create or replace trigger checkSalayTrigger
                    before update of sal on emp for each row
                    begin
                    if :new.sal < :old.sal then
                    raise_application_error('-20555','工资不能减少');
                    end if;
                    end;
                    /
## 多表查询
    笛卡尔集表：列数之和，行数之积

    关于效率：
            只有两张真实的表之间才会建立连接，自连接不会建立连接，是自己查询自己，所以速度更快

    连接查询
            内连接        #　只能查询出符合条件的记录
                            ## ，比如员工表单中外键部门编号，部门表中有新部门无与之对应的员工
                            ## ，无论怎么内连接查询，也查询不出新成立的那个部门
                    等值查询        # 用'='比较两表之间的字段值 
                            select e.* from emp e, dept where emp.deptno = dept.deptno
                                    # 用外键为约束查询两张表
                    不等值查询        # 用 '<=' '>=' '<>' between and in来比较两表之间的字段值 
            外连接        # 可以查询出不符合条件的记录，它是以一张表中的每一条记录为基础，去查询另一张表
                            ## ，就算无一张表中无值与另一张表中的记录对应，也会把查询记录插入到结果集中
                    左(右)外连接
                            select d.deptno, d.dname, count(e.empno)
                            from dept d, emp e
                            where d.deptno = e.deptno(+)
                            group by d.deptno, d.dname;
                            注意点：
                            1.左外连接是以左边的表为基础，去查右边的表（查全所有左边表的记录），右边不全，适应性地增加。右外连接相反
                            2.(+) 不是sql99的标准，是oracle专用的语法，放在表名称后 。sql99中规定的语法是left join、right join
                            3.两张表的查询用一个 where 条件限定
                            4.select 语句中的真实字段的名称都是group by 语句中必要的
            自连接
                    缺点：可能会出现表庞大的情况 
                    优点：效率高，不用多表连接。
                    用到自连接的地方：有层次关系的，有包含关系的一张表
                    select users.ename || '的老板是' || boss.ename
                    from emp users,emp boss
                    where users.mgr = boss.empno(+);
                            # user是oracle的关键字，所以不能起'user'为别名
                            
                            
    子查询
            # 可以不同表之间查询，用小括号包含子查询的语句
            ## 只要类型和数量匹配就可以匹配查询
            与连接查询的比较        ： 连接查询较好
                    # 连接查询两表连接有内部索引优化，只查询一张表
                    ## 子查询两张表，没有形成笛卡尔积，比较慢
            分类 
                    单行子查询: 符号: = < >
                    多行子查询: 符号: in any all
                            where sal in (查询语句)
                            where sal < any (查询语句)                # 只要小于一个就成立
                            where sal < all (查询语句)        #　小于所有

    集合查询                # 个数相同，类型对应相同就可以 (前面的别名起作用,后面的别名不起作用)
            并集        union / union all(交集部分重复添加)                  # 并集 
            交集        intersect                # 相交的部分
            差集        minus                  # 去掉前面集合中与后面集合的交集
## plsql
    plsql: procedure language (structured query language 结构化查询语言)
            用于处理比较复杂，过程化的数据库操作
    oracle对sql99的扩展
            增加了类型定义
            判断
            循环
            指针/游标/光标
            输出语句
            异常
        oracle PLSQL继承了oracle对sql99的扩展      # sqlserver 有 T-sql(transaction sql)
    语法
            o-> 所有的作为结束标记的/ 必须要换行写
            o-> plsql也可以回滚
            o-> declare    分号结束
            ;
            begin  dml语句/tcl语句,以分号结束 # 必写
            ;
            [exception]
            ;
            end;        # 必写
            /
        
            o-> set serveroutput on;        # 设置plsql的输出打开，默认是off 的
            o-> dbms_output.put_line('');  # 只能在 plsql 的执行语句中使用，dbms_output的输出方法,会自动换行
            o-> :=                # 赋值号
            o-> emp.ename%type;        # 同emp表中的ename的类型一样的类型
            o-> emp_record emp%rowtype      # 匹配一行类型
                    # emp_record.ename输出一个字段的数据
            o-> if 条件1.1 and 条件1.2 then 语句1;
            elsif 条件2 then 语句2;
            else 语句3;
            end if;
            o-> 可以用&进行定义运行时赋值
            o-> loop
            exit [when];
            end loop;
            o-> while 条件
            loop
            ;
            end loop;
            o-> for i in 1..3                # 不可以在循环中更改i的值
            loop
            ;
            end loop;
        o-> cursor      # 多行数据 ，相当于resultset 
            cursor c1 查询语句
            open c1;
            loop
            fetch                        # 先判断再下移，最后一条记录打印两次
                                            ## 先下移再判断 ，正常显示
            exit when 条件;
            end loop;
            close c1;
            例子
            例子1                # dbms_output.put_line('');
            declare 
                mysum number(3);
            begin
                mysum := 10 + 100;      # :=就是赋值
                dbms_output.put_line('结果为' || mysum);
            end;
            /
            例子2                # emp.ename%type
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
            例子3                # emp%rowtype
            declare
                emp_record emp%rowtype;
            begin
                select * into emp_record from emp where empno = 7788;
                dbms_output.put_line(emp_record.ename || emp_record.sal);
            end;
            /
            例子4                        # 运行时赋值符号与if判断语句
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
            例子5                        # loop 循环
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
            例子6                        # while循环
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
            例子7                        # for循环 
            declare
                i number(2)
            begin
                    loop
                for i in 20..30    # 一个一个增加,循环中不能再对i进行操作
                    dbms_output.put_line(i);
                end loop;
            end;
            /
            例子8                        # cursor
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
            例子8 # 有参游标
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
            例子9 :输入&emptno没有的时候，输出"查无员工"                # 综合if loop 与cursor
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
            
            例子10 :给所有ANALYST加工资        # 综合cursor if loop ,循环之后执行了tcl 事务控制语言
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

    例外（异常）
            内置例外
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
            自定义例外
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
            抛出例外的函数
                    raise_application_error('-20666','禁止操作');        
                            # begin语句中的相关地方调用此函数即可
                            # 20000-20999错误编号范围，是负数        
    过程与函数
        1.有一个返回值的时候，适合使用函数
        2.没有返回值的时候用过程
        3.多个返回值的时候，适合使用过程
        
    存储过程                # 过程和函数不能重名
            用于
                    一个业务中的逻辑固定不变或较少变化时
                    业务经常变化时用sql
            创建
                    create or replace procedure hello                # 可以无参，参数有两种，一种是in,一种是out ，默认是in，如 empno in emp.empno%type
                    as         
                    begin
                    end;/
            删除
                    drop procedure hello;
            使用
                    1.命令exec
                    2.存储过程中调用 
                            begin
                            hello;
                            end;
                            /
                    3.java中使用Callablestatement 类的实例
            例子1                # in 参数的使用
                    create or replace procedure raiseSalary(pempno in emp.empno%type)
                    as
                    begin
                        update emp set sal = sal * 1.1 where empno = pempno;
                    end;
                    /
                    exec raiseSalary(7369);
            例子2                # out参数的使用                select into
                    create or replace procedure findEmpNameAndSalAndJob
                            (pempno in emp.empno%type,
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
    函数                # 过程和函数不能重名
            返回值
                    只有一个，其它返回值通过out类型的参数返回，所以需要返回多个值时用存储过程比较合适
            创建
                    无参函数
                            create or replace function getName return varchar2
                            as
                            begin
                            return '赵君';
                            end;
                            /
            调用
                    不可以 exec
                    1.存储过程调用
                            begin
                                    dbms_output.put_line(getName);
                            end;
                            /
                    2.java类CallableStatement
            例子1                        # in参数 和返回值的函数 
                    create or replace function findEmpIncome(pempno in number) return number
                    as
                        income number(10);
                    begin
                        select sal*12+NVL(comm,0) into income from emp where empno = pempno;    
                        return income; 
                    end;
                    /
            例子2                        # in、out 参数和返回值的函数 
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
## 函数及常量
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
                    select ename "姓名" , sal "原工资" , decode(job,
                                                                                            'analyst',sal + 1000,
                                                                                            'manager',sal + 800, 
                                                                                            sal + 400)
                                                                                            "新工资" 
                    from emp;
                            #相当于sql99语法中的:
                    select ename "姓名" , sal "原工资" , case job
                                                                                            when 'analyst' then sal + 1000
                                                                                            when 'manager' then sal + 800
                                                                                            else sal + 400
                                                                                            end "新工资"
                    from emp
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
    多行函数        # 多行函数分为接收多个输入，返回一个输出。
                    ##　多行函数本身不会统计值为null的记录
                    ## 多表的多行函数的统计多会用到group by ，因为where 只是筛选出了不符合条件的部分
                    ## ,剩下的部分分列在不同的表中，只有按照列名分组以后才能按列名执行多行函数
                            having 
            count([distinct] deptno)                # 统计deptno【不重复的】记录数        
            sum(sal)                # 统计数值的和
            avg(sal)                # 统计平均值 
            max(sal)                # 统计最大值，可以用在日期上
            min(sal)                # 统计最小值 ，可以用在日期上
            
## 控制语句
    sqlplus工具命令        # sqlplus命令是sqlplus 命令特有的,可以以;结束,可以以/结束，语句可以简写
                                    ## sql 命令必须以分号结束

            /      # 执行最近一次的sql命令（不执行工具命令）
            host cls        # 清屏
            edit        # 用本地编辑器编辑
            设置显示
                    column deptno format 9999        # deptno是列名,9999 代表4个数字宽度
                    column ename format a8      # a8代表8个字符宽度(date也用a)
                            col ename for a8        # 简写
                    set pagesize 40                                # 设置一页显示40条记录
            spool d:/a.sql                # 假脱机,开始记录控制台信息
                    spool off                        # 正式保存记录信息到文件
                    @ d:/a.sql                # 从脱机文件中导入命令并执行
            监查时间
                    set timing on / set timing off                # 每执行一段语句显示语句的执行时间
                    set time on / set time off                        # 在输入标记前面显示当前时间
    用户语句
            exit                # 退出        
            show user        # 显示用户名
            password        # 改密码

    表操作
            dml操作(data manipulation language)数据操作语言
                    占位符&        # 执行语句时会提示输入
                            insert into emp values(&deptno,'&ename')        字符型的数据加'',其它都不加
                            select deptno,&column from &tablename where sal > &sal group by &column having round(avg(sal),0) > &money;
                    增
                    删
                    改
                    查
                            select deptno as "编号"...                        # 给列取别名 ，其中的as和双引号可以省略
                                                                                            ## 双引号省略后，引号的内容中不能有空格
                            select sal * 12 + nvl(comm,0)        # 由于comm可以为null，有null的表达式结果全都为null
                                                                                    ## nvl()函数用0来代替comm列中出现的null
            ddl操作(data definition language) 数据定义语言
                    增
                            create table users(
                                    id number(2)        # 2代表最大数字的位数
                                    sal number(4,2)    # 4代表所有数字的位数（包括小数），2代表小数位数（小数位数可以变多，自己截取？）
                                    varchar2(4)        # 其中的4代表4个字节
                                    birthday date default sysdate
                                    long        # 2g的字符串
                            clob        # 字符数据,最大4g
                            blob        # 二进制数据，最大4g
                            )
                                    rowid      # 表创建时自动添加 ，唯一字符串，是对文件中的表的记录的引用（指针）,连接显示内容与表记录
                                    rownum                # 表创建时自动添加,字段唯一的列名
                    删
                            drop table emp        # 这种删除放入回收站(有删除的表的时候自动建立的一个回收站，可以查看tab表发现，没有时自动删除)
                                    drop table emp purge  # 这种删除不放入回收站
                                    回收站
                                            show recyclebin
                                            闪回技术，还原回收站中的文件
                                            purge recyclebin
                            truncate table emp                # 表截断 ，将表中的数据删除，结构还在
                                    # 注意,truncate 是不可回滚的    , 回滚只针对dml操作，不能针对其它操作
                    改
                            alter table emp rename column ename to username;        # oracle特有的修改列名的语句
                    查
            dcl操作(data control language) 数据控制语言
                    alert user hr account unlock;        # 解锁 用户
                    alert user hr identified by hr                # 修改用户密码
                    conn / as sysdba        # 更换角色
                    show user        # 显示当前用户
                    grant select any table to scott;                # 授权
            revoke select any table from scott;                # 收回授权
            tcl操作（老师起名 transaction control language事务控制语言）
                    事务        # 只针对 dml操作
                            oracle中没有start transaction命令，从第一条dml操作语句执行时事务自动开始
                    commit
                    rollback
                    savepoint xxx
                    rollback to savepoint xxx
                            事务隔离级别
                                    未授权读取：read uncommitted        # 允许脏读取，但不允许更新丢失。如果一个事务已经开始写数据，则另外一个事务则不允许同时进行写操作，但允许其他事务读此行数据。该隔离级别可以通过“排他写锁”实现
                                    授权读取：read committed                # 允许不可重复读取，但不允许脏读取。这可以通过“瞬间共享读锁”和“排他写锁”实现。
                                    可重复读取：repeatable                        # 解决脏读和不可重复读，未解决幻读。读取数据的事务将会禁止写事务（但允许读事务），写事务则禁止任何其他事务。这可以通过“共享读锁”和“排他写锁”实现。
                                                                                    # 由于更新数据时需要先读取，所以‘只写’事务不能更新，解决了重复读的问题
                                                                                    ## 但是插入和删除记录不需要先读取，所以幻读仍然存在。
                                    序列化：serializable                # 解决脏读，不可重复读，解决幻读。进行严格的事务隔离，事务只能一个一个地执行（不并发），效率低下。仅仅通过“行级锁”是无法实现事务序列化的，必须通过其他机制保证新插入的数据不会被刚执行查询操作的事务访问到。
                                            # 脏读，一个事务开始读取了某行数据，但是另外一个事务已经更新了此数据但没有能够及时提交。第一个事务修改数据会造成忽略第二个事务修改的数据的情况
                                            ## 不可重复读（Non-repeatable Reads）一个事务对同一行数据重复读取两次，但是却得到了不同的结果。它包括以下情况：
                                                    事务T1读取某一数据后，事务T2对其做了修改（已提交，不是脏读），当事务T1再次读该数据时得到与前一次不同的值。
                                            ## 幻读（Phantom Reads），事务T1读取某一数据后，事务T2对其做了插入或删除，当事务T1再次读该数据时包含了第一次查询中未出现的数据或者缺少了第一次查询中出现的数据
                                                    该过程中没有进行任何读取，只是插入。
                                            ## 隔离级别越高，越能保证数据的完整性和一致性，但是对并发性能的影响也越大。
                                                    一般使用read committed级别，在可能出现这类问题的个别场合，可以由应用程序采用悲观锁或乐观锁来控制。
                                    oracle 只支持read committed 与 serializable,两种
                                    oracle 中默认事务是从第一次dml操作开始时开始的,用rollback回滚
                            事务提交以后，不可以回滚
                                隐式提交
                            ddl操作
                            dcl操作
                            commit命令
                            exit 命令
                                隐式回滚：关闭窗口,断电
                                
            o-> where语句
                            hiredate between '20-2月-81' and '23-1月-82' 
                            ename like '%\_%' escape '\'                # 去掉'\' 并转义通配符'_'为字符,但只能是一个字符
    约束                # mysql中没有check约束
            gender varchar2(2) check(gender in ('男','女'))
    视图                # 一般用户没有创建视图的权力，必须dba执行grant create view to 用户名 的授权语句进行授权
                    with read only语句创建只读视图
    授权
        grant create view to scott
            1.视图中存的是select语句，如果视图访问的表被删除了，视图还在，但是无法访问
        2.对视图进行操作，相应的表会被级连
                    以下元素存在的话不能对视图进行操作
                    组函数（count/sum/avg/max/min)
                GROUP BY 子句
                DISTINCT 关键字
                ROWNUM 伪列
        3.视图删除以后不放入回收站
        4.优点
            1.限制数据访问
            2.提供数据的相互独立访问
            3.简化复杂查询
    序列
            共享对象唯一的数值，不一定连续
            create sequence emp_emptno_seq
                    INCREMENT BY 10                # 步长是10
                START WITH 120                # 从120开始
                MAXVALUE 9999                # 最大到9999
                NOCACHE                                # 不缓存序列的值（缓存是先创建很多再取出，不缓存则是什么时候取，什么时候创建）
                NOCYCLE;                        # 到最大值的时候是否循环
                    
            select seq.nextval from dual        # nextval下一个序列 currval当前序列  第一次使用必须是nextval
            insert into emp(id) vallues(seq.nextval);      # 使用
            alter sequence emp_deptno_seq increment by 10;
                start with 100;    # 错误 ，不能变更启动序列，只能在创建序列时指定
            drop sequence seq
    索引
            第一次查询时创建
            加快查询的速度，表删除时索引自动删除
            primary key 与 unique 时已经建立

            建立 
                    create index emp_deptno_idx on emp(deptno,job)
            使用   
                    where 中添加对应索引的条件，条件的内容必须与索引一样（只包含一个索引也不会使用索引）

            什么时候使用
                1.分布广
                2.经常在where 中出现的列
                3.表经常会被访问
            不使用
                1.表小
                2.不经常出现的列
                3.经常更新的字段,比如剩余火车票数量的字段
            
    同义词
            授权                # 默认普通用户没有权限，要先授权
                    grant create synonym to scott;
            创建
                    create synonym emp_syn for emp;
            删除
                    drop synonym emp_syn;
## 闪回技术
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
## 审计
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
# 数据字典
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
# 案例
    安装
            运行services.msc,找到OracleServiceORCL 服务 （最后是数据库名）改为手动
            sqlplus / as sysdba 运行oracle测试是否安装成功
            解锁scott用户
                    sqlplus / as sysdba
                    alter user scott account unlock;
                    alter user scott identified by tiger;
    分页
        概念
                rownum
                        是伪列，数值型，从1开始，不断增加，永远连续
                        不能进行除了对1以外的'='比较，不能进行'>'或'>='比较（因为rownum默认到无限大）,只能进行'<'或'<='的比较
                                # 解决方法，为rownum 取别名再进行'>'与'='的比较

        o->
        SELECT * FROM  
        ( 
        SELECT A.*, ROWNUM RN  
        FROM (SELECT * FROM TABLE_NAME) A  
        WHERE ROWNUM <= 40 
        ) 
        WHERE RN >= 21

        o->
                # 效率低
        select rownum,emp.* from emp where rownum <=4
        minus
        select rownum,emp.* from emp where rownum <=2;

        o->
                # 效率低
        SELECT * FROM  
        ( 
        SELECT A.*, ROWNUM RN  
        FROM (SELECT * FROM TABLE_NAME) A  
        ) 
        WHERE RN BETWEEN 21 AND 40 