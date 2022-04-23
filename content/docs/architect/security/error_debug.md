# 基础
	线上故障等级
		P0 致命问题
		P1 严重问题
		P2 一般问题
		P3 轻微问题
	线上故障分类
		外部依赖类
		运营质量类
		需求质量类
		系统质量类
# 混沌工程
	混沌工程画像
		ApplicationData
			进程Hang、Kill，启动异常，心跳异常，环境错误，包错误或损坏，配置错误、误删、获取超时
		Data
			系统单点，异步阻塞同步，依赖超时，依赖异常，业务线程池满，监控错误，OOM
		Runtime
			负载均衡失效，缓存热点，缓存限流
		Middleware
			数据库热点，数据库宕机，数据同步延迟，数据库主备延迟，数据库连接满，数据库热点
		OS
			CPU抢占，内存抢占，内存错乱，上下文切换
		Virtualization
			服务器宕机、假死，断电，超卖，混部
		Storage
			磁盘满、慢、坏，不可写，不可读
		Networking
			网络抖动、丢包、超时，网卡满，断网
	工具
		ChaosBlade
# Java
	Idea Debugger
# Redis
# MySQL
	Using intersect
		多余查询条件虽然命中索引，但会产生多余的索引查询使SQL变慢，应该使用唯一的单值索引
	force index指定期望的索引
	用count(*)不要count(1)
	use filesort可能会文件排序
# Trace
	Pinpoint记录