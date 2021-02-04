# 跳转点
积分类 ScmSettlementPointServiceFacade

精度
Integer precision = paramClientService.getPricePrecision(dto.getTenantId());

标准单位转订货单位
scmDataProcessorService.transferUnitQty2OrdOrPrucQtyWayFloor(prepareDTO.getTenantId(), detail.getWareQty(), detail.getPurcUnitRates(), precision )

物品
goodsClientService.findGoodsList

计算类类似 DispatchOutPriceCalculator 
        detail.setPurcUnitPriceNotax(BigDecimalUtils.div(detail.getGoodsAmtNotax(), detail.getPurcUnitNum(), pricePrecision))

枚举
出库状态 ScmDispatchOutStatusEnum

tenantUtil

# 命令
git update-index --assume-unchanged a

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


// 查属性
ServletContext sc = ContextLoader.getCurrentWebApplicationContext().getServletContext();
WebApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(sc);
Environment env = (Environment) ac.getBean("environment");
env.getProperty("name");


# sql
	UPDATE scm_out_posorderredu_detail
	SET bill_no = CASE bill_id
	<foreach collection="list" item="item" index="index">
		WHEN #{item.billId} THEN #{item.billNo}
	</foreach>
	END
	WHERE
	tenant_id = #{tenantId} and delete_flag = 0
	and bill_id IN
	<foreach collection="list" item="item" index="index" open="(" separator="," close=")">
		#{item.billId}
	</foreach>


	update scm_dispatch_detail
	set purc_out_num = case
	<foreach collection="updateDetails" item="item" index="index">
		when id=#{item.id} and tenant_id=#{item.tenantId}
		then #{item.purcOutNum}
	</foreach>
	end
	WHERE id IN
	<foreach collection="updateDetails" item="item" index="index" open="(" separator="," close=")">
		#{item.id}
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