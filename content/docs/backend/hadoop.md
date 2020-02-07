# 介绍
    大数据 
        PB级数据
        4V
            volume(大量)
            velocity(高速)
            variety(多样)
            value(低价值密度)
        场景
            物流仓储: 精细化运营，命中率
            推荐
            保险: 风险预测
            金融: 用户特征
            房产: 精准投策、营销
            AI
        组织部门
            平台: 集群
                Hadoop、Flume、Kafka、HBase、Spark等搭建
                性能监控、调优
            数据仓库: 写SQL
                ETL, 数据清洗
                Hive, 数据分析、建模
            数据挖掘
                数据支持
                算法、推荐、用户画像
            报表
                JavaEE
    hadoop
        Apache开源, 分布式系统基础架构
        面临问题
            硬盘
                1块: 10TB-14TB 
                1PB: 102块硬盘
            算
                MySQL5.5: 300w-500w
                MySQL8: 1亿、1GB
        Doug Cutting
            GFS -> HDFS
                存储
            Map-Reduce -> MapReduce
                计算
            BigTable -> HBase
                表式存储
        发展
            2003-2004: Google公开部分GFS和MapReduce
            2005: Hadoop成为Apache Lucene子项目Nutch了一部分
            2006.3: MapReduce和NDFS(Nutch Distributed File System)纳入Hadoop
        发行版本
            Apache: 开源
            Cloudera: Doug Cutting, 一键部署, 资源占用大
            Hortonworks: 雅虎工程师，贡献Hadoop 80%代码, 一键部署
            阿里云
        特点
            高可靠性：多副本
            高扩展性
            高效性: 并行运行
            高容错性
        组成
            Hadoop1.x
                HDFS(存), MapReduce(算、资源调度), Common
            Hadoop2.x
                HDFS(存), MapReduce(算), Yarn(资源调度), Common
            Hadoop3.x
# 流程
    数据

|来源       |结构化数据: 数据库         |半结构化数据: 文件日志         |非结构化数据: 视频, PPT    |
|:----------|:--------------------------|:------------------------------|:--------------------------|
|传输       |Sqoop                      |Flume                          |Kafka                      |
|存储       |HDFS, HBase                |HDFS, HBase                    |Kafka                      |
|管理       |YARN                       |YARN                           |                           |
|计算       |MapReduce                  |MapReduce                      |                           |
|包装       |Hive, Mahout               |                               |                           |
|任务调度   |Oozie, Azkaban             |                               |                           |
|业务模型   |                           |                               |                           |

    计算
        MapReduce(离线)
            Hive(查询)
            Mahout(数据挖掘)
        SparkCore(内存)
            Mahout(数据挖掘)
            Spark Mlib(数据挖掘): 用户画像, 产品聚类
            Spark R(数据分析)
            Spark SQL(数据查询)
            Spark Streaming(实时/在线/流式)
                有缓存
        Storm(实时)
            # 口径小, 被淘汰
            纯流式计算(无缓存)
        Flink(实时)
            纯流式计算(无缓存)
    调度
        介绍：处理任务依赖
    支撑/发现
        Zookeeper    
# 组件
    论文
        BigTable
    转换
        Pig
            # 数据流处理, 脚本转换为MapReduce任务
        Sqoop
            # etl, sql-to-Hadoop, MapReduce程序, 支持Hive, HDFS
        kafka
    数据
        HDFS
            介绍
                Hadoop Distributed File System, 分布式文件系统, 一开始为Nutch搜索引擎开发
            优点
                高容错, 高吞吐量
                部署在廉价机器上
            模块
                NameNode(nn)
                    存metadata: 文件名, 目录结构(生成时间、副本数、文件权限), 文件块列表，文件块所在DataNode
                DataNode(dn)
                    本地FS, 存文件块，文件块校验和
                    数据在dataNode间水平传递
                Secondary NameNode(2nn)
                    监控HDFS，周期获取HDFS元数据快照
                    可恢复部分NameNode
            结构
                metadata
                    /test/a.log, 3, {blk_1,blk_2}, [{blk_1:[h0,h1,h3]},{blk_2:[h0,h2,h4]}]
            命令
                hdfs
        Hbase
            介绍
                Hadoop Database, 实时分布式, bigtable列簇数据库, 非结构化，自动切分, 并发读写
            缺点
                只能row key查询, master单点
        Hive
            # 数据仓库, 映射成表, sql MapReduce, 批处理
        Impala
            # cloudrea开源,实时视图计算框架, 分布式查询引擎。直接从HDFS或Hbase中用select, join, 支持事务, 需要kafka
        GFS
            # google FS
        TiDB
    计算
        在线
            Storm
                介绍
                    实时视图计算框架, 支持事务, 需要kafka
            S4
                # 分布式流计算，允许请求丢失
        离线
            MapReduce
                阶段
                    Map: 切分，并行计算
                    Reduce: 从map中取多个计算结果，进行合并
                命令
                    hadoop jar a.jar grep input output 'dfs[a-z.]+'
            Mahout
                # 数据挖掘, 机器学习
            Spark
                介绍 
                    分布式计算, scala实现, 建立在HDFS上,也可Hadoop 基于内存的分布式数据集(rdd), 准实时
                缺点
                    无事务
                组件
                    Spark RDD(Resiliennt Distributed Datasets)
                    Spark Streaming
                    Spark SQL
        查询
            HAWQ
                # Hadoop原生sql查询引擎
            phoenix
                # OLTP, 支持Hbase和HDFS, jdbc, 更快sql查询
            Shark
                # sql on Spark, 并行job处理比MapReduce快100倍
            Presto
                # 分布式sql查询, facebook开源, 称比Hive快10倍
            Drill
                # Apache, Dremel的开源版本, 对多数据库生成query plan
            Dremel
                介绍
                    google的交互式数据分析系统，构建于gfs上
                特点
                    嵌套型数据的列存储, 多层查询
                    减少查询的处理数据量
            Kylin
                # OLAP, Apache, 支持Cube类查询
    调度
        K8S
        Yarn
            介绍
                Yet Another Resource Negotiator, 调度算力资源, 在HDFS上运行计算框架(如MapReduce, Storm, Spark)
            组成
                ResourceManager(RM)
                    处理请求
                    监控NodeManager
                    启动、监控ApplicationMaster
                    资源分配调度
                    常驻
                NodeManager(NM)
                    常驻
                ApplicationMaster(AM)
                    数据切分
                    为应用程序申请资源再分配给内部任务
                    任务监控、容错
                    非常驻，job拉起
                Container
                    运行APP
                    某节点上多维度的资源
                    由NodeManager调度
                    非常驻
        Mesos
    治理
        Zookeeper
        Flume
            # cloudera开源, 日志收集
        Ganglia
            分布式监控系统，php页面
    集成
        Ambari
            # 安装、部署、配置和管理
            组件
                Log Search
    发行版
        Apache Hadoop
        CDH(Cloudera's Distribution Including Apache Hadoop)
        HDP(Hortonworks Data Platform)
    ui
        HUE
            # web管理Hadoop
    搜索
        ElasticSearch
        Solr
    方案
        宜信
            D.Bus
                # 数据收集与计算
            UAVStack
                # AIOps, 智能运维
                UAV.Monitor
                    # 监控
                UAV.APM
                    # 性能管理
                UAV.ServiceGovern
                    # 服务治理
                UAV.MSCP
                    # 微服务计算
            Wormhole
                # SPaaS(Stream Processing as a Service)
            Gartner
                # ITOA，算法即运维
# 部署
    本地模式
    伪分布模式(学习用)
    集群模式
    例子
        软件结构
            0        jdk, Hadoop                        NameNode, DFSZKFailoverController
            1        jdk, Hadoop                        NameNode, DFSZKFailoverController
            2        jdk, Hadoop                        ResourceManager
            3        jdk, Hadoop, Zookeeper        DataNode, NodeManager, JournalNode, QuorumPeerMain
            4        jdk, Hadoop, Zookeeper        DataNode, NodeManager, JournalNode, QuorumPeerMain
            5        jdk, Hadoop, Zookeeper        DataNode, NodeManager, JournalNode, QuorumPeerMain
        Zookeeper
            配置conf/zoo.cfg
                tickTime=2000                        # 心跳间隔(ms)
                initLimit=10                        # 初始化时最多容忍心跳次数
                syncLimit=5                        # 同步失败最多容忍心跳次数
                dataDir=/usr/local/Zookeeper/data        # 运行时文件目录
                clientPort=2181                # 运行端口号
                server.1=主机名或ip:2888:3888        # 服务运行端口与选举端口
                server.2=主机名或ip:2888:3888
                server.3=主机名或ip:2888:3888
            命令
                ./bin/zkServer.sh start
                ./bin/zkServer.sh status
                jps                                        # 显示名为QuorumPeerMain
        Hadoop
            Hadoop-env.sh
                export JAVA_HOME=
            core-site.xml
                <configuration>
                    <property>
                        <name>fs.defaultFS</name>
                        <value>HDFS://ns1</value>
                    </property>
                    <property>
                        <name>Hadoop.tmp.dir</name>
                        <value>/usr/local/Hadoop-2.2.0/tmp</value>
                    </property>
                    <property>
                        <name>ha.Zookeeper.quorum</name>
                        <value>192.168.56.13:2181, 192.168.56.14:2181, 192.168.56.15:2181</value>
                    </property>
                </configuration>
            HDFS-site.xml
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
                    <value>/usr/local/Hadoop-2.2.0/journal</value>
                </property>
                <property>
                    <name>dfs.ha.automatic-failover.enabled</name>
                    <value>true</value>
                </property>
                <property>
                    <name>dfs.client.failover.proxy.provider.ns1</name>
                    <value>org.Apache.Hadoop.HDFS.server.namenode.ha.ConfiguredFailoverProxyProvider</value>
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
                    <value>Yarn</value>
                </property>
            Yarn-site.xml
                <property>
                    <name>Yarn.resourcemanager.hostname</name>
                    <value>192.168.56.12</value>
                </property>
                <property>
                    <name>Yarn.nodemanager.aux-services</name>
                    <value>mapreduce_shuffle</value>
                </property>
            etc/Hadoop/slaves
                192.168.56.13
                192.168.56.14
                192.168.56.15
        收尾
            o-> ssh免登录(0到1,2,3,4,5)
                ssh-keygen -t rsa
                ssh-copy-id -i 192.168.56.11            # 这样就可以免登录访问192.168.56.11了
                                                        ## ssh-copy-id -i localhost 免登录自己

            o-> 复制Hadoop2.2.0(从0到1,2,3,4,5)

            o-> 添加Hadoop_home到环境变量
                etc/profile
                    export HADOOP_HOME=/usr/local/Hadoop-2.2.0
                    export PATH=$PATH:$HADOOP_HOME/bin
        启动
            0 上启动
                ./sbin/Hadoop-daemons.sh start journalnode
            0 上格式化namenode
                Hadoop namenode -format


