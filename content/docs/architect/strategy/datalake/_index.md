# 愿景
	统一
		批流一体
# 数据难点
	SQL脚本拼凑，没有可视化工具
	技术要求高，大量重复开发工作
	数据稽核难: 勾稽关系不可见，数据校核不可见
	数据运维困难：可读性差，难以调整，扩展困难
# 湖仓一体计划
	思路
		分治
		计算向数据移动
		本地取数据	

# 数据仓库计划
	采集 -> kafka -> ETL -> kafka -> 存储 -> OLAP
# 采集工具
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
	技术
		Flume
			日志采集
		Sqoop
			数据库ETL
			etl, sql-to-Hadoop, MapReduce程序, 支持Hive, HDFS
		OoZie
			任务调度
		Azkaban
			任务调度
# 存储工具
	HDFS
	HBase
	Hive
		数据仓库
		封装的HDFS和MapReduce
	ClickHouse

# 运维工具
	Ambari
		安装、部署、配置和管理
	Flume
		cloudera开源, 日志收集
	Ganglia
		分布式监控系统，php页面
	HUE
		web管理Hadoop
# 处理工具
## 离线计算(批处理)
	MapReduce
		每个task启动一个jvm
	Pig
		数据流处理语言，类SQL, 脚本转换为MapReduce任务
	Mahout
		数据挖掘, 机器学
	Tez
		用DAG(有向无环图)组织多个MR任务
## 流式计算
	Impala
		# cloudrea开源,实时视图计算框架, 分布式查询引擎。直接从HDFS或Hbase中用select, join, 支持事务, 需要kafka
	S4
		# 分布式流计算，允许请求丢失
	Storm
		只能流式计算
	Spark
	Flink
	Kafka Stream
# 数据管理工具
	分类
		资产大屏
		元数据管理
		任务管理：管理、编排、调度、监测
		数据质量、数据治理
	Yarn
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
	Mesos
	Tachyon
		分布式缓存
# 分析展示工具
	Mllib
		machine learning library, Spark机器学习库
	Giraph
		大规模图分布式计算
	GraphX
		Spark分布式图处理框架
	Superset
	Metabase
	Redash
	BIRT
	Kylin
	Davinci
	DBus-allinone
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
	Doris
	GridGain
		网格计算框架，提供平行计算能力
# 数仓建模
	分层
		ODS层(数据源): 多源接入
			业务库，集团数据，流量日志，三方数据
		IDL层(数据集成): 屏蔽底层影响，还原业务，统一标准
		CDL层(数据组件): 指标口径统一，重复计算
		MDL层(数据集市): 数据分析查询，数据应用支持
		ADL层(数据应用): 多维数据分析
	工具
		基础层工具: 元数据中心维护业务过程，表关联关系、实体对象、识别分析对象、数据组件
		自助查询工具: 逻辑宽表、生成查询语句、查询情况反馈建模
		应用层工具: 拼接小模型