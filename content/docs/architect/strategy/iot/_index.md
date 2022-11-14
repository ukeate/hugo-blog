---
Categories : ["架构"]
title: "IoT"
date: 2018-10-10T16:49:27+08:00
---

# 框架
    # Internet of Things
    Kaa
    SiteWhere
        # tomcat, mongodb, hbase, influxdb, grafana
    ThingSpeak
        # matlab可视化
    DeviceHive
        # 开源, docker, k8s, es, spark, cassandra, kafka
    Zetta
    Thinger.io
    wso2
# 业务
    目的
        解决可读性可操作性
    模块
        展示
            dashboard
                在线设备
                消息量
                规则引擎消息流转次数
            运维大盘
                产品品类
                地区排名
                指标趋势
                设备在线率
                设备排行
                    事件数
                    事件类型
                    停用时长
                    延迟
        开发服务
            studio
                开发
                    web
                    移动
                    自动化服务
                设备
                    产品                        # 软硬分离的桥梁
                        设备开发 -> 设备模拟(在线写c, js) -> 软件开发
                配置(使用移动端)
                运营运维
                    后台
                    监控
                插件开发
                服务编排
            行业服务
                智能生活
            os                                  # 高性能、极简开发、云端一体、丰富组件、安全防护
                项目生成
                    领域模板
                    插件选择
        网络
            网关
            凭证
            无线
                车联网、智能家居、穿戴、媒体内容分发、环境监测、智慧农业
        设备
            节点
                接入
                    多协议: MQTT、CoAP、HTTP
                    多平台(设备端代码): c、node.js、java
                    多网络: 2/3/4G、NB-IoT、LoRa
                    多地域
                通信
                    双向通信
                        稳定
                        安全
                    影子缓存                            # 设备与应用解耦, 网络不稳定时增加可靠性
                安全
                    认证(一机一密)
                    传输: TLS
                    权限: 设备权限
                规则引擎
                    数据流转
                        M2M(machine to machine)            # 设备间通信
                        数据结构化存储
                        数据计算: 函数计算、流式计算、大规模计算
                        数据mq转发
                    联动触发
                管理
                    生命周期: 注册、分组、拓扑、标签、状态、数据采集、禁用删除
                    模型
                        数据标准化: 属性、事件、服务
                        存储结构化
                    远程
                        设备调试
                            实物
                            模拟
                        维护
                            指令
                            固件升级
                            下发配置
                        监控
                            日志
                            实时数据
                        通知
            分组
        数据分析
            流计算实时分析
            可视化
                三维设备关联
                二维(地图)分布, 实况， 搜索
            数据源适配
        边缘计算                                        # 就近计算, 实时, 离线运行, 快速编程, 降低成本
            功能
                视频设备sdk
                    边缘算法容器(接入方案)
                视频智能
                    视频算法容器
            驱动
                websocket、modbus、lightSensor、light、opcua,
        合作