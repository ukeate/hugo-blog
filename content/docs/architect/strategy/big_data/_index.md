# 基础
	思路 
		分治
		计算向数据移动
		本地取数据	
	流程
		采集 -> kafka -> ETL -> kafka -> 存储 -> OLAP
# 运维
## Ambari
	安装、部署、配置和管理
## Flume
	cloudera开源, 日志收集
## Ganglia
	分布式监控系统，php页面
## HUE
	web管理Hadoop
# 存储
## HDFS
	# Hadoop Distributed File System, 一开始为Nutch搜索引擎开发
	存储模型
		按字节切割,block存储,block多副本
		不支持修改(因为修改文件而非block, 且会引发规模修改)，可以追加
	主从架构
		NameNode
			树形目录
			内存存储元数据，可持久化(EditLog事务日志, FsImage)
				NameNode启动时安全模式
					SecondaryNameNode合并EditLog到新FsImage
					DataNode上报block列表
			存副本策略
		DataNode
			本地文件形式存block, 存校验
			与NameNode心跳，汇报block列表
		Client
			交互元数据和block
	API结构
		推荐节点数不过5000
		角色：一个进程
	Block副本放置策略
		Pipeline
	HA
		JournalNode
			NameNode同步EditLog
		FailoverController
			利用ZooKeeper
			同主机下监控NameNode
			验证对方主机主NN是否真的挂掉，调用对方降级为Standby
## HBase
	介绍
		Hadoop Database, 实时分布式, bigtable列簇数据库, 非结构化，自动切分, 并发读写
		只能row key查询, master有单点问题
	版本
		0.98
		1.x
		2.x
	原理
		修改只追加记录，合并时删除
	架构
		Client
			提供接口，维护客户端缓存
		Zookeeper
			只有一个活跃master
			存Region寻址入口
			实时监控region server在线信息，通知master
			存schema、table元数据
		Master
			为region server分配region	
			region server负载均衡
			失效region server重新分配region
			管理table CRUD
		RegionServer
			维护region
			切分大region
		Region
			表水平分region分配在多个region server, region增大时裂变
		HLog
			写Store之前先写HLog, flush到HDFS, store写完后HDFS存储移到old，2天后删除	
		Store
			region由多个store组成, 一个store对应一个CF
			store先写入memstore, 到阈值后启动flashcache写入storefile
			storefile增长到阈值，进行合并
				minor compaction
				major compaction，默认最多256M
			region所有storefile达到阈值，region分割
## Hive
	数据仓库
	封装的HDFS和MapReduce
## ClickHouse
# 采集
	业务数据
		ODS原始数据快照
		日志
		动态数据：用户推荐数据，用户行为
		第三方数据：用户征信、广告投放数据、企业信息
	技术
		RPC同步
		ETL拉取
		日志采集
		爬虫
	实时
		trigger、日志
			canel
	准实时
		日志
	非实时
		任务调度
			quartz, xxl-job, 大数据
## Flume
	日志采集
## Sqoop
	数据库ETL
    etl, sql-to-Hadoop, MapReduce程序, 支持Hive, HDFS
## OoZie
	任务调度
## Azkaban
	任务调度
# 处理
## 离线计算(批处理)
### MapReduce
		每个task启动一个jvm
## Pig
	数据流处理语言，类SQL, 脚本转换为MapReduce任务
## Mahout
	数据挖掘, 机器学
### Tez
	用DAG(有向无环图)组织多个MR任务
## 流式计算
### Impala
	# cloudrea开源,实时视图计算框架, 分布式查询引擎。直接从HDFS或Hbase中用select, join, 支持事务, 需要kafka
### S4
	# 分布式流计算，允许请求丢失
### Storm
	只能流式计算
### Spark
	介绍
		in memory, 准实时的批处理，生态好于Storm
		无事务
	集群
		Master
		Worker
		Driver
		Executor	
	组件
		Spark RDD(Resiliennt Distributed Datasets)
		Spark Core 批计算，取代MR
			粗粒度资源申请，task自行分配启动快，executor不kill
			内存计算
			chain
		Spark Streamming 流计算，取代Storm
			批计算无限缩小，实时性差
			默认无状态
				用updateStateByKey保存上次计算结果，变成有状态
				借助Redis或ES存
		Spark SQL 数据处理
		Spark MlLib 机器学习
		Spark R 数据分析
	使用
		val session = SparkSessionBase.createSparkSession()
		var sc = session.sparkContext
		var rdd = sc.makeRDD(List(1,2,3,4,5,6))
		val mapRDD = rdd.map(x -> {
			x
		})
		val filterRDD = mapRDD.filter(x => {
			true
		})
		filterRDD.count
### Flink	
	特点
		高吞吐、低延迟、高性能
		支持事件时间(Event Time)
		擅长有状态的计算	
			内存
			磁盘
			RocksDB
		灵活的窗口（Window）操作： time, count, session
		基于轻量级分布式快照（CheckPoint）实现容错，保证exactly-once
		基于JVM实现独立内存管理
		Save Points方便代码升级
	批计算是流计算的特例
		unbound streams		# 定义开始不定义结束，流计算
		bounded streams		# 定义开始也定义结束，批计算
	迟到数据问题
		温度窗口
		水位线(Watermark)
	集群
		JobManager(JVM进程)
		TaskManager(JVM进程)
			Task Slot	
				一组固定的资源，隔离内存，不隔离核
				一般与核数对应，核支持超线程时一个算两个
	配置
		/etc
			/flink-conf.yaml
			/slaves
			/masters
	组件
		部署
			Single JVM		# 多线程模拟
			Standalone
			YARN	
		库
			CEP				# 复杂事件库
			Table
			FlinkML
			Gelly
	使用
		import org.apache.flink.streaming.api.scala._

		val env = StreamExecutionEnvironment.getExecutionEnvironment
		val initStream:DataStream[String] = env.socketTextStream("node01", 8888)
		val wordStream = initStream.flatMap(_.split(" "))
		val pairStream = wordStream.map((_, 1))
		val keyByStream = pairStream.keyBy(0)
		val restStream = keyByStream.sum(1)
		restStream.print()
		env.execute("job1")
### Kafka Stream
# 数据管理
	元数据管理
	任务管理：管理、编排、调度、监测
	数据质量、数据治理
## Yarn
	介绍
		Yet Another Resource Negotiator, 任务管理, 调度算力资源, 在HDFS上运行计算框架(如MapReduce, Storm, Spark)
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
## Mesos
## Tachyon
	分布式缓存
# 上层(分析、展示)
## Mllib
	machine learning library, Spark机器学习库
## Giraph
	大规模图分布式计算
## GraphX
	Spark分布式图处理框架
## Superset
## Metabase
## Redash
## BIRT
## Kylin
## Davinci
## DBus-allinone
## HAWQ
	# Hadoop原生sql查询引擎
## phoenix
	# OLTP, 支持Hbase和HDFS, jdbc, 更快sql查询
## Shark
	# sql on Spark, 并行job处理比MapReduce快100倍
## Presto
	# 分布式sql查询, facebook开源, 称比Hive快10倍
## Drill
	# Apache, Dremel的开源版本, 对多数据库生成query plan
## Dremel
	介绍
		google的交互式数据分析系统，构建于gfs上
	特点
		嵌套型数据的列存储, 多层查询
		减少查询的处理数据量
## Kylin
	# OLAP, Apache, 支持Cube类查询
## GridGain
	网格计算框架，提供平行计算能力