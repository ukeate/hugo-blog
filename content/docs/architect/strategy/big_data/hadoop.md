# 介绍
    发行版
        Apache Hadoop
        CDH(Cloudera's Distribution Including Apache Hadoop)
        HDP(Hortonworks Data Platform)
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
## HDFS
    问题及方案
        单点故障
            多NameNode，主备(2.x只能1主1备, 3.x可以1主5备)
        压力大，内存受限
            联帮: Federation(元数据分片)
    配置网络
        /etc/sysconfig/network-scripts/ifcfg-eth0
        /etc/sysconfig/network
            NETWORKING=YES
            HOSTNAME=node01    
        /etc/hosts
        /etc/selinux/config
            SELINUX=disabled
        /etc/ntp.conf
            server htp1.aliyun.com
        /etc/profile
            export JAVA_HOME=/usr/java/default
            export PATH=$PATH:$JAVA_HOME/bin
        service iptables stop & chkconfig iptables off
        service ntp start & chkconfig ntp on
        配ssh免密登录
    部署配置
        mkdir /opt/bigdata
        /etc/profile
            export HADOOP_HOME=/opt/bigdata/hadoop-2.6.5
            export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
        /etc/hadoop
            hadoop-env.sh
                export JAVA_HOME=/usr/java/default
            core-site.xml
                <name>fs.defaultFS</name>
                <value>hdfs://node01:9000</value>
            hdfs-site.xml
                <name>fs.replication</name>
                <value>1</value>
                <name>dfs.namenode.name.dir</name>
                <value>/var/bigdata/hadoop/local/dfs/name</value>
                    # namenode元数据
                <name>dfs.datanode.data.dir</name>
                <value>/var/bigdata/hadoop/local/dfs/data</value>
                <name>dfs.namenode.secondary.http-address</name>
                <value>node01:50090</value>
                <name>dfs.namenode.checkpoint.dir</name>
                <value>/var/bigdata/hadoop/local/dfs/secondary</value>
            slaves
                node1
    命令
        hdfs namenode -format
        start-dfs.sh
        访问页面 node01:50070 node01:50090
        hdfs dfs -mkdir -p /user/root
        hdfs dfs -D dfs.blocksize=1048576 -put a.txt /user/root
## 例子
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
        ssh免登录(0到1,2,3,4,5)
            ssh-keygen -t rsa
            ssh-copy-id -i 192.168.56.11            # 这样就可以免登录访问192.168.56.11了
                                                    ## ssh-copy-id -i localhost 免登录自己
        复制Hadoop2.2.0(从0到1,2,3,4,5)
        添加Hadoop_home到环境变量
            etc/profile
                export HADOOP_HOME=/usr/local/Hadoop-2.2.0
                export PATH=$PATH:$HADOOP_HOME/bin
    启动
        0 上启动
            ./sbin/Hadoop-daemons.sh start journalnode
        0 上格式化namenode
            Hadoop namenode -format


