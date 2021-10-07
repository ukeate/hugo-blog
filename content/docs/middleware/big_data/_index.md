# 历史

# Hadoop
	HDFS
	MapReduce
	Yarn
# 离线计算
	MapReduce
		每个task启动一个jvm
	Hive
		封装的HDFS和MapReduce
# 流式计算
## Storm
	只能流式计算
## Spark
	生态好于Storm
	集群
		Master
		Worker
		Driver
		Executor	
	组件
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
## Flink	
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
## Kafka Stream