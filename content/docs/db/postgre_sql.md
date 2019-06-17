---
Categories : ["数据库"]
title: "Postgre SQL"
date: 2018-10-11T15:34:29+08:00
---

# 命令
    initdb --locale en_US.UTF-8 -D 'data'
    postgres -D data
            # -p 6543
    pg_ctl -D data -l a.log start


    postmaster
            # -D /data
    psql -d postgres
            # 默认创建的数据库，用户名为当前用户名
        ＃ -h localhost -p 5432 -d dbname 用户名 密码
            # -f 导入sql命令文件, 或者在末尾加 < a.sql 来导入
            # -L 导出日志文件
    pg_dump -f a.sql -i -C -E UTF8 -n public -h localhost
            # 导出数据库
            # -a 导出某表
    createdb
            # -hlocalhost -Upostgres -O 用户名 数据库名                        
            # 创建数据库并指定 owner
    dropdb
            # -U user dbname
    元命令
            \?
                    # postgre命令
            \h
                    # sql命令
            \l
                    # 列出数据库
            \q
                    # 退出
            \c 数据库名
                    # 切换数据库
            \du
                    # 查看角色
            \dt
                    # 查看所有表
            \d tablename
                    # 查看表结构
            \i a.sql
                    # 执行sql文件
            \o a.log        
                    # 日志文件
# 特色sql
    数据类型
            serial
                    # 4字节，自增序列
                    bigserial
                            # 8字节
            text default ''::text
            bigint default 0
                    # 8字节
                    smallint
                            # 2字节
                    int, integer
                            # 4字节
                    decimal
                            # 变长, 声明精度，精确
                    numeric
                            # 同上
                    float
                    real
                            # 4字节，变精度，不精确
                    double precision
                            # 8字节，变精度，不精确

            boolean default false
            text[]
                    # text数组
            date
            time
            timestamp with time zone
            interval
            
            bytea
                    # 二进制

            money
            uuid
    约束
            constraint user_id primary key (id)
            constraint user_m_id unique(m_id)
            constraint fk_b_id foreign key (b_id) references tbb(id)
                    MATCH SIMPLE
                    ON UPDATE NO ACTION
                    ON DELETE NO ACTION
    dcl
            create database db1
                    owner outrun
            create role 用户名 with password '密码' login
                    # 创建用户。role关键词可以省略
                    # 其他权限 : CREATEDB CREATEROLE

            drop database db1
            drop table tablename;

            alter database abc RENAME TO cba;
            alter database 数据库名 owner to 用户名
                    # 更改数据库 owner
            alter table tb 
                    add primary key (id)
                    add foreign key(b_id) references tb(id) on update cascade on delete cascade
                    add column c1 text
                    alter column id type int using id::integer
                    rename c1 to c2
                        drop constraint fk_b_id foreign key (b_id) references tbb(id)
                    drop [column] name
                    owner to outrun
                            # 更改表 owner
            
            alter role 用户名 with login
                    # 添加权限。其他如 : password 'asdf' 、 VALID UNTIL 'JUL 7 14:00:00 2012 +8' (设置角色有效期)
            alter user postgres with password 'asdf'
                    # 修改密码

            grant all privileges on database 数据库名 to 用户名
                    # 授权数据库权限
    ddl 
            insert into tb("desc") values ('a'); 
    模糊查询
            ~
                    # 匹配正则，大小写相关
                    # 除'a$' '^a'的正则都只适合pg_trgm的gin索引
            ~*
                    # 匹配正则，大小写无关
            !~
                    # 不匹配该正则
            !~*
            ~ '^a'
                    like 'a%'
            ~ 'a$'
            ~ 'ab.c'
                    like '%ab_c%'
    o-> 视图 
    CREATE VIEW myview 
    AS 
    SELECT city, temp_lo, temp_hi, prcp, date, location 
    FROM weather, cities 
    WHERE city = name;

    o-> 建表
    create table dwh_timestamp_meta
    (
    "id" serial NOT NULL,
    "id" serial primary key,
    "c_id" serial references cities(id),
    "mongo_document_name" text default ''::text,
    "last_update_time" bigint default 0,
    "execute_time" timestamp with time zone,
    constraint pk_id primary key(id)
    )
    with (
    oids=false
    );

    o-> 序列
    create table a(
            id integer primary key
    );
    create sequence a_id_seq
            start with 1
            increment by 1
            no minvalue
            no maxvalue
            cache 1;
    alter table a alter column id set default nextval('a_id_seq')
# 数据字典
    pg_roles
            # 角色信息
    pg_database
            # 数据库信息
    information_schema
            select column_name from information_schema.columns where table_schema='public' and table_name='ad';
                    # 表的所有列名
    pg_stat_user_tables
            select relname from pg_stat_user_tables;
                    # 所有表名
# 配置
    数据库目录
            /usr/lib/systemd/system/postgresql.service
    jdbc
            driver : org.postgresql.Driver
        url : jdbc:postgresql://localhost:5432/postgres
        初始用户名 : postgres
        初始数据库 : postgres
# 存储过程
    drop function change_type1();
    create or replace function change_type1()
    returns int as
    $body$
    DECLARE
        r mongo_keys_type%rowtype;
        begin
        for r in select * from mongo_keys_type where type='number'
        loop
            EXECUTE 'alter table "' || r."mongo_collection_name" || '" alter "' || r."key" || '" type decimal';
        END LOOP;
        return 0;
        end
    $body$
    language 'plpgsql';

    select change_type1()