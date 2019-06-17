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