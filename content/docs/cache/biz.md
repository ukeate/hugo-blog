# 名词
    SCM
        供应链管理(Supply Chain Management)
# 业务
    订单
    采购
        单据
            领域模型
            领域服务
    库存
        生产入库
        调拨
        盘点
        单据
            领域模型
        领域服务
# 目标
    领域设计
    业务库瘦身
        模型
            单据拆分：核减单据、非核减单据
            流水拆分
                核减流水: 物品、档口、批次、日期
                非核减流水
        周期
            14个月滚动
            历史单据按年拆分   
    实时计算框架
    商户分库
    冷热数据分离

# 分层

# 代码 
    choice-scm
        entity
            ScmParams
                paramScope: 1:门店 2:总部  3:系统 默认为1
                    tenantId
        service
            ScmParamService
                findScmParamsData: 获取系统配置参数
            dataclean
                cleancenter
                    executor
                        Basic
                        Business
                        Cache
                        MicService
                        Retry
                        StatusRef
                        TenantInit
                    event
                table
                    Range
                    TableConfig
                task
                    ExecLogService
                    NoteService
                    Servicesdf

                ui
        web
            advice
                SetMoney
        schedule


    scm-core-domain                 # 领域核心, 单据
    scm-core-stock                  # 领域核心, 库存
    scm-product-base
    scm-product-stock