---
title: 数据库
type: docs
---

# sql
## mysql
## oracle
## postgreSQL
# nosql
## 键值
### redis
## 列簇
### cassandra
### hbase
### riak
## 文档
### mongodb
### couchdb
## 图
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
# 分布式
## tidb
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
