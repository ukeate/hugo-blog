---
Categories : ["架构"]
title: "构架-方案"
date: 2018-10-10T16:49:27+08:00
---

# 数据迁移
    去掉约束
    排序（中断继续）
# 数据存储
    缓存
        queue + map
            # queue存储、限量, map查询，指向queue中元素
# 直播
    《关于直播，所有的技术细节都在这里了》
# 并发
    异步事件
        tornado + celery + rabbitmq + 优先级
# 缓存
    queue + map
        # queue存储、限量, map查询，指向queue中元素
# 前端模板
    layout
        layout service
            # 缓存layout到redis
            crud layout功能
        layout对象
            index
                # 缩略信息
            plugins
                components
                    table
                layout
                    # 组合方式
                    水平，垂直，tab
# 游戏
    进程
        gateway进程组
            # 对外api
        function进程组
            # 注册玩家全局信息
        session进程组
            # 玩家状态
        dbserver进程组
            # 数据
        多word进程组
            # 不同地图的信息、逻辑

# go高并发实时消息推送
    问题
        长连接             # 支持多种协议(http、tcp)
            server push
            HTTP long polling(keep-alive)
            基于TCP自定义
            心跳侦测
        高并发             #>= 10,000,000
            C1000K
        多种发送方式
            单播: 点对点聊天
            多播: 定点推送
            广播: 全网推送
        持久/非持久
        准实时         # 200ms ~ 2s
            gc卡顿是大问题
        客户端多样性
        同帐号多端接入
        网络变化
            电信、联通切换
            wifi, 4g, 3g
            断线、重连、断线、重连
    系统架构
        组件
            room
                # 接入客户端
                分布式全对称
                一个client一个goroutine
                每个server一个channel存消息队列
                book记录user与server映射
                统一http server收消息并将消息路由到room和server
                manager掌控room的服务：内部单播、多播、广播
                admin负责room进程管理
            center
                # 运营人员从后台接入
                提供操纵接口给应用服务器调用
                restful
                长时操作，有任务概念来管理
                提供统计接口
            register
                # room和center注册
                key-value的map，value是struct
                记录用户连到哪个room
                记录在线时长等信息
                hash算法定位register进程
                不直接用redis是为了添加业务逻辑
            saver
                # room和center调用
                # 使用redis
                分布式全对称
                提供存储接口
                采用encoding/gob编码格式的rpc
            idgenerator
                # saver和center调用
                全局消息id生成器, int64
                分布式，每个进程负责一块id区域
                后台goroutine每隔一秒写一次磁盘，记录当前id
                启动时跳过一段id，防止一秒内未写入磁盘的id重复生成
        存储
            redis
                存核心数据
                db_users: zset, 存各产品用户集合
                db_slots: list, 存用户离线消息队列
                db_buckets: dict, 存消息id -> 消息体
    数据
        16机器，标配24硬件线程, 64g内存
        linux kernel 2.6.32 x86_64
        单机80万并发连接
            load 0.2 ~ 0.4 cpu
            总使用率7%~10%
            内存占用20g
        目前接入1280万在线用户
        2分钟一次gc, 停顿2秒，tip上提供了并行gc
        15亿个心跳包/天
        持续运行一个月无异常

