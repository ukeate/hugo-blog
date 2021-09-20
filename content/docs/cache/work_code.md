# 框架编写
优雅关闭相关的，使用到的是enable**
choice-driver-shutdown
jwt相关
choice-driver-jwt
通用
choice-driver-common
choice-driver-all
gray-spring-boot

0
FAT

1
eureka.instance.prefer-ip-address=true
eureka.instance.instance-id=fat:jncloud-account
eureka.instance.ip-address=192.168.0.9

2 TEST04 dev -> fat

3 0.9

4 fat:

5
36.137.165.51:31019

6 redis

7 删除

# 命令
git update-index --assume-unchanged a
mvn clean deploy -P keruyun -pl alsc-item-solution-kryun-dish-client -DskipTests

# 搜索词
分库 DynamicDataSource determineCurrentLookupKey

# snip
org.apache.ibatis.mapping.MappedStatement#getBoundSql

PageHelper.startPage(Optional.ofNullable(scmDirectSendCheckQueryDTO.getPageNum()).orElse(1),
                Optional.ofNullable(scmDirectSendCheckQueryDTO.getPageSize()).orElse(10));

com.choice.scm.utils.enums.EnumSalesOrderType 订单类型
com.choice.scm.utils.enums.EnumSalesOrderStatus 订单状态
com.choice.scm.utils.common.ScmConstants.SCM_ORDER_TYPE 汇总类型
com.choice.scm.utils.common.BillTypeEnum 出库类型
com.choice.scm.entity.dispatch.enums.ScmDispatchOutStatusEnum: 配送出库状态

// 设置属性
System.getProperties().set()
// 查属性
ServletContext sc = ContextLoader.getCurrentWebApplicationContext().getServletContext();
WebApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(sc);
Environment env = (Environment) ac.getBean("environment");
env.getProperty("name");


# sql
	update scm_out_posorderredu_detail_summary
	set 
	goods_qty = case uniq_key
	<foreach collection="list" item="item" index="index">
		WHEN #{item.uniqKey} THEN goods_qty + #{item.goodsQty}
	</foreach>
	END,

	goods_amt = case uniq_key
	<foreach collection="list" item="item" index="index">
		WHEN #{item.uniqKey} THEN goods_amt + #{item.goodsAmt}
	</foreach>
	END,

	unit_price = case uniq_key
	<foreach collection="list" item="item" index="index">
		WHEN #{item.uniqKey} THEN
		if(0=goods_qty, 0, convert((goods_amt) / (goods_qty) , decimal(65,#{item.precision})))
	</foreach>
	END

	where
	tenant_id = #{tenantId} and delete_flag=0
	and uniq_key in
	<foreach collection="list" item="item" index="index" open="(" separator="," close=")">
		#{item.uniqKey}
	</foreach>


        if (req.getIsOnlyFav() != null && req.getIsOnlyFav()) {
            Fav favReq = Fav.builder().
                    type(BizEnum.fav_type_article.getCode()).
                    userId(req.getLoginUserId()).
                    build();
            PageInfo<Fav> favResp = favService.list(favReq);
            if (favResp == null || CollectionUtils.isEmpty(favResp.getList())) {
                return new PageInfo<>(new ArrayList<>());
            }
            req.idListIntersect(favResp.getList().stream().map(Fav::getTargetId).collect(Collectors.toSet()));
            if (CollectionUtils.isEmpty(req.getIdList())){
                return resp;
            }
        }