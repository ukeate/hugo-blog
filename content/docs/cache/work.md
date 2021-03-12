# 项目结构
	api: controller
	biz: 特异业务
		manager
		converter
	core: 公用业务
		model
			entity
			bo
		service
			repository
	common
		dal
			dataobject
				do
			dao
			mapper
		service
			facade
				dto: facade和controller用
				service: 服务间api
				validate
			integration
				service
		shared
			dto: 项目内部公用

# 业务流程
积分管理(向门店加积分)
	
配送流程
	物品档案
	配送物品关系
	配送售价单
	物品关系设置
	其他入库
	门店请购单

	订单中心
		生成订单
	配送订单
		生成备货分拣单/审核
	备货单
		备货完成
	分拣单
		编辑
			提交+校验
			审核（关闭开关[配送出库单是否自动审核]）+校验, 批量审核+校验
		[反审核]：不反结算
	配送出库
		出库（关闭开关[备货单和分拣单]）
		生成发货单
		反审核
	发货单
	验收单

# 配送金额
unit_price 3.925
purc_unit_num 2
tax_ratio 0.1

cost_price(成本单价) 3
price_type 1
price_param 5.55

purc_unit_price(订货单价)23.55 = cost_price 3 * 转换率6  + 固定值加价 5.55
purc_unit_price_notax 28.251



goods_amt 47.10 = purc_unit_num 2 * purc_unit_price 23.55 = 47.1
goods_amt_notax 42.82
goods_tax_amt 4.28 =  goods_amt - goods_amt_notax
goods_tax_amt_nodiscount
goods_amt_notax_nodiscount
goods_amt_nodiscount


# 表关系
## 退货入库单, 查出库单
dispatch_in(up_bill_id) -> return_goods(id) in_id   -> 
dispatch_in(id) up_bill_id -> out_check_relation(check_id) -> out_id


# 数据库

jdbc:mysql://172.17.31.65:3306/test_cloud_scm?useSSL=false&allowMultiQueries=true&rewriteBatchedStatements=true&serverTimezone=GMT%2B8&autoReconnectForPools=true&autoReconnect=true&failOverReadOnly=false&zeroDateTimeBehavior=convertToNull
test_new_scm test_scm_2018

 jdbc:mysql://172.17.31.65:3306/test_cloud_scm?useSSL=false&allowMultiQueries=true&rewriteBatchedStatements=true
dev_scm_user 5TRBomhB59OmtCsSJzTcBCsSs9qF6Umj

jdbc:mysql://172.16.5.6:5726/online_cloud_scm?useSSL=false&serverTimezone=GMT%2B8&allowMultiQueries=true&rewriteBatchedStatements=true&autoReconnectForPools=true&autoReconnect=true&failOverReadOnly=false&zeroDateTimeBehavior=convertToNull
scm_zbq_w_user qazwsx123

jdbc:mysql://172.17.31.67:3306/test_db_scm_07?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimeZone=GMT
dev_scm_user u5#AMiZnybvU4fN9YyNlstCXc6u8sHSZ

jdbc:mysql://172.17.31.67:3306/test_db_scm_report_config?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimeZone=GMT
dev_scm_user u5#AMiZnybvU4fN9YyNlstCXc6u8sHSZ

jdbc:mysql://172.17.31.65:3306/dev_prod_cloud_credit?useSSL=false&allowMultiQueries=true&rewriteBatchedStatements=true
dev_prod_cloud_cred_w_user 8adcese8acfe7c9Lba94abed88754eSS

jdbc:mysql://172.17.31.65:3306/test_prod_cloud_credit?useSSL=false&allowMultiQueries=true&rewriteBatchedStatements=true
test_cred_w_user 9Lba94abed8878adcese8acfe7c54eSS

# 测试
X-Service-Group：test04

# 配置加载
本地环境变量中的配置 > apollo配置中心的配置 > 本地文件的配置

1 命令行参数
    -Dspring.profiles.active=dev
2 通过 System.getProperties() 获取的 Java 系统参数
3 操作系统环境变量
    export SPRING_PROFILES_ACTIVE=dev
4 从 java:comp/env 得到的 JNDI 属性
5 通过 RandomValuePropertySource 生成的“random.*”属性
6 应用 Jar 文件之外的属性文件(通过spring.config.location参数)
7 应用 Jar 文件内部的属性文件
8 在应用配置 Java 类（包含“@Configuration”注解的 Java 类）中通过“@PropertySource”注解声明的属性文件
9 通过“SpringApplication.setDefaultProperties”声明的默认属性

