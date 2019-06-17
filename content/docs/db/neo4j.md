---
Categories : ["数据库"]
title: "Neo4j"
date: 2018-10-11T15:59:29+08:00
---

# 介绍
        使用zookeeper
# 特点
        完全兼容ACID
        主从复制
        副本从节点
                从节点写数据，先同步到主节点, 再由主节点分发
# 配置
    dbms.connector.bolt.enabled=true
    dbms.connector.bolt.listen_address=0.0.0.0:7687
    dbms.connector.http.enabled=true
    dbms.connector.http.listen_address=0.0.0.0:7474
            # 远程访问