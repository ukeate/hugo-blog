---
Categories : ["后端"]
title: "Hadoop"
date: 2018-10-11T10:05:41+08:00
---

# 发展
    google
            gfs
            mapReduce
                    # 并行计算框架
            big-table
    hadoop1.0 
    hdfs
            mapReduce
    hadoop2.0
            hdfs
                    # Hadoop Distributed File System　
            yarn
                    # Yet Another Resource Negotiator资源管理调度系统
                    # 在hdfs上运行计算框架(如mapReduce, storm, spark)
# 原理
    hdfs
        模块
                client
                nameNode                                                # 用于注册文件
                                                                        ## 2.0后可以有多个nameNode
                        metadata                                        # 数据的描述信息
                dataNode                                                # 数据在dataNode间水平传递
        关系
                client rpc nameNode
        结构
                metadata
                        /test/a.log, 3, {blk_1,blk_2}, [{blk_1:[h0,h1,h3]},{blk_2:[h0,h2,h4]}]
    mapReduce
        Map: 切分，并行计算
        Reduce: 从map中取多个计算结果，进行合并

# 组件
    ambari
            # 安装、部署、配置和管理
    hdfs
            # 分布式文件系统
    hive
            # 数据仓库
    pig
            # 数据流处理
    mahout
            # 数据挖掘
    mapreduce
    flume
            # 日志收集
    hbase
            # 实时分布式, bigtable数据库
    sqoop
            # etl
    zookeeper
# 框架
    CDH
        cloudera
    HDP
        hortonworks data platform
    应用框架
        sqoop
            在hdfs(hive)与关系型数据库之间数据相互转移
        phoenix
            介绍
                    打造更快的sql查询，面向hbase与hdfs之上的其它nosql数据库
            特征
                    通过jdbc进行交互
        shark
            介绍
                    hive on spark
            特点
                    并行job处理比mapReduce快100倍
        ganglia
            分布式监控系统，用于监视和显示集群中节点的各种状态信息，如cpu, mem, 硬盘利用率, i/o负载, 网络流量等，历史数据生成曲线图，通过php页面显现。
    存储框架
        hive
            功能
                    将结构化的数据文件映射为一张数据库表，并提供简单的sql查询功能，可以将sql语句转换为mapReduce运行。
            缺点
                    底层使用mapReduce引擎，是一个批处理过程，难以满足查询的交互性
        hbase
            特征
                    分布式的，面向列的开源nosql数据库，列可以动态增加
                    基于hadoop的bigTable
                    不同于一般关系数据库，是一个适合于非结构化数据存储的数据库
                    自动切分数据
                    并发读写
            缺点
                    只能按照row key来查询
                    master宕机，整个系统挂掉
    计算框架
        mr  
            离线计算框架
        spark
            介绍
                    内存计算框架
                    apache托管UC Berkeley AMP lab开源的类hadoop 通用并行框架
                    mapreduce中间输出结果可以保存在内存中，不再需要读写hdfs
                    是scala语言实现的
            特点
                    准实时，收集成rdd后处理
                    不支持事务 
            技术 
                    spark rdd
                    spark streaming
                    spark sql
        drill
            google dremel 的开源版本
        storm
            介绍        
                    实时视图计算框架
                    纯实时
                    支持事务
            特点
                    结合kafka 
        impala
            介绍        
                    实时视图计算框架
                    纯实时
                    支持事务
            特点
                    结合kafka 
# 部署
    本地模式
    伪分布模式(学习用)
    集群模式
    例子
        软件结构
                0        jdk, hadoop                        NameNode, DFSZKFailoverController
                1        jdk, hadoop                        NameNode, DFSZKFailoverController
                2        jdk, hadoop                        ResourceManager
                3        jdk, hadoop, zookeeper        DataNode, NodeManager, JournalNode, QuorumPeerMain
                4        jdk, hadoop, zookeeper        DataNode, NodeManager, JournalNode, QuorumPeerMain
                5        jdk, hadoop, zookeeper        DataNode, NodeManager, JournalNode, QuorumPeerMain
        zookeeper
            配置conf/zoo.cfg
                    tickTime=2000                        # 心跳间隔(ms)
                    initLimit=10                        # 初始化时最多容忍心跳次数
                    syncLimit=5                        # 同步失败最多容忍心跳次数
                    dataDir=/usr/local/zookeeper/data        # 运行时文件目录
                    clientPort=2181                # 运行端口号
                    server.1=主机名或ip:2888:3888        # 服务运行端口与选举端口
                    server.2=主机名或ip:2888:3888
                    server.3=主机名或ip:2888:3888
            命令
                    ./bin/zkServer.sh start
                    ./bin/zkServer.sh status
                    jps                                        # 显示名为QuorumPeerMain
        hadoop
            hadoop-env.sh
                export JAVA_HOME=
            core-site.xml
                <configuration>
                    <property>
                            <name>fs.defaultFS</name>
                            <value>hdfs://ns1</value>
                    </property>
                    <property>
                            <name>hadoop.tmp.dir</name>
                            <value>/usr/local/hadoop-2.2.0/tmp</value>
                    </property>
                    <property>
                            <name>ha.zookeeper.quorum</name>
                            <value>192.168.56.13:2181, 192.168.56.14:2181, 192.168.56.15:2181</value>
                    </property>
                </configuration>
            hdfs-site.xml
                <property>
                    <name>dfs.nameservices</name>
                    <value>ns1</value>
                </property>
                <property>
                    <name>dfs.ha.namenodes.ns1</name>
                    <value>nn1,nn2</value>
                </property>
                <property>
                    <name>dfs.namenode.rpc-address.ns1.nn1</name>
                    <value>192.168.56.10:9000</value>
                </property>
                <property>
                    <name>dfs.namenode.http-address.ns1.nn1</name>
                    <value>192.168.56.10:50070</value>
                </property>
                <property>
                    <name>dfs.namenode.rpc-address.ns1.nn2</name>
                    <value>192.168.56.11:9000</value>
                </property>
                <property>
                    <name>dfs.namenode.http-address.ns1.nn2</name>
                    <value>192.168.56.11:50070</value>
                </property>
                <property>
                    <name>dfs.namenode.shared.edits.dir</name>
                    <value>qjournal://192.168.56.13:8485;192.168.56.14:8485;192.168.56.15:8485</value>
                </property>
                <property>
                    <name>dfs.journalnode.edits.dir</name>
                    <value>/usr/local/hadoop-2.2.0/journal</value>
                </property>
                <property>
                    <name>dfs.ha.automatic-failover.enabled</name>
                    <value>true</value>
                </property>
                <property>
                    <name>dfs.client.failover.proxy.provider.ns1</name>
                    <value>org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider</value>
                </property>
                <property>
                    <name>dfs.ha.fencing.methods</name>
                    <value>sshfence</value>
                </property>
                <property>
                    <name>dfs.ha.fencing.ssh.private-key-files</name>
                    <value>/root/.ssh/id_rsa</value>
                </property>
            mapred-site.xml
                <property>
                    <name>mapreduce.framework.name</name>
                    <value>yarn</value>
                </property>
            yarn-site.xml
                <property>
                    <name>yarn.resourcemanager.hostname</name>
                    <value>192.168.56.12</value>
                </property>
                <property>
                    <name>yarn.nodemanager.aux-services</name>
                    <value>mapreduce_shuffle</value>
                </property>
            etc/hadoop/slaves
                192.168.56.13
                192.168.56.14
                192.168.56.15
        收尾
            o-> ssh免登录(0到1,2,3,4,5)
                    ssh-keygen -t rsa
                    ssh-copy-id -i 192.168.56.11                # 这样就可以免登录访问192.168.56.11了
                                                            ## ssh-copy-id -i localhost 免登录自己
                                                                    
            o-> 复制hadoop2.2.0(从0到1,2,3,4,5)

            o-> 添加hadoop_home到环境变量
                    etc/profile
                            export HADOOP_HOME=/usr/local/hadoop-2.2.0
                            export PATH=$PATH:$HADOOP_HOME/bin
        启动
            0 上启动
                    ./sbin/hadoop-daemons.sh start journalnode
            0 上格式化namenode
                    hadoop namenode -format
# 相关
    bigTable
    gfs
    dremel
        介绍
                google的交互式数据分析系统，构建于gfs上
        特点
                嵌套型数据的列存储
                多层查询
                减少查询的处理数据量，提升查询效率
