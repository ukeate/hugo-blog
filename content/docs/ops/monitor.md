---
Categories: ["运维"]
title: "Monitor"
date: 2018-10-11T18:47:57+08:00
---
# 基础
    监控的方式
        主动、被动、旁路（舆情）
    监控类型
        服务端监控、客户端监控
    目标
        全、块、准
    指标
        请求量、成功率、耗时    
# 统计
    指标
        访问、访客
        停留时长
        跳出率
        退出率
        转化率
        参与度
    显示方式
        选时间段
            时序数据表
            max、min、avg
    埋点
        通过可视化工具配置，非硬编码
    第三方
        友盟
        百度移动
        魔方
        App Annie
        talking data
        神策数据
# 物理机
## Load Average
    介绍
        数字n表示n倍
## cpu
    Usage: 100%
        system
        user
        IO wait
    Saturation: 1.0core
    Max Core Usage: 1.0core
    Interrupts and Context Switches: 10k
    Processes: 10ops
        create(Forks)
        Runnable
        Blocked
## mem
    Physical Memory: RAM(Random-Access Memory)存储器
        used
        free
        buffers
    Virtual Memory
        介绍
            映射到RAM或Disk
        used
        available
    Swap Space
        used
        free
    Swap Activity
        swap in(read)
        swap out(write)
## disk
    space
        增长趋势
    I/O Activity
        read(page in)
        write(page out)
    File Descriptors: 1Milion
        limit
        allocated
    I/O Latency: 5ms
        write
        read
    I/O Load: 3
        write
        read
## network
    traffic: MB/s
        inbound
        outbound
    Utillization Hourly: GB
        sent
        received
    Local Network Errors: 0ops
        transmit drop
        receive drop
        transmit errors
    TCP Retransmission
        segments retransmitted: 0ops
        retransmit ratio: 0%
# 应用监控
    Prometheus
        # 监控, go实现
    Grafana
        # 监控
    Zabbix
        # 分布式监控
    Nagios
        # 监控
    Ganglia
    Zenoss
    Open-falcon
    emq
        # mqtt broker, erlang开发, 管理控制台
# APM
    # Application Performance Management
    SkyWalking
    CAT
    Jaeger
    Pinpoint
    Zipkin
    Dapper
        # C#
# Mysql
    总览
        Services: 38
        Min MySQL Uptime: 20 hours
        Max MySQL Uptime: 2.4 years
        Total Current QPS: 3.4k ops
        Total InnoDB Buffer Pool Size: 431GiB
        Top Service Used Connections: 800
        Top Service Used Connections: 80%
        Top Service Client Threads Connected: 60%
        Top Service Active Client Threads: 99%
        Top Service Threads Cached: 100%
## 单节点
    总计 
        Uptime: 29 weeks
        Version: 5.7.26
        Current QPS: 32
        InnoDB Buffer Pool Size: 3GiB
        Buffer Pool Size of Total RAM: 10%
    Connections
        Connections
            Max Connections
            Max Used Connections
            Connections
        Aborted Connections
            Aborted Connects(attempts): 0 ops
            Aborted Clients(timeout): 0 ops
    Client Threads
        Clients Threads Activity
            Peak Threads Connected: 22
            Peak Threads Running: 2
        Thread Cache
            Thread Cache Size
            Threads Cached
            Threads Created
    Temporary Objects & Slow Queries
        Temporary Objects
            Created Tmp Tables: 5
            Created Tmp Disk Tables: 0.3
            Created Tmp Files: 0
        Slow Queries: 0 ops
    Select Types & Sorts
        Select Types
            Select Scan: 14 ops
            Select Range: 4 ops
        Sorts
            Sort Rows: 1 ops
            Sort Scan: 0 ops
            Sort Range: 0 ops
    Table Locks & Questions
        Table Locks Immediate: 0.6 ops
        Table Locks Waited: 0 ops
    Questions: 32
    Network
        Network Traffic
            Outbound: 70 KBs
            Inbound: 15 KBs
        Newtwork Usage Hourly
            Sent: 240 MiB
            Received: 52 MiB
    Memory
        System Memory: 31 GiB
        InnoDB Buffer Pool Data: 2 GiB
        InnoDB Log Buffer Size: 32 MiB
        Key Buffer Size: 8 MiB
        Query Cache Size: 1 MiB
    Command, Handlers, Processes
        Top Command Counters
            select: 25
            set option: 4
            rollback: 0.6
            commit: 28
            stmt_prepare: 28
            stmt_execute: 28
            stmt_close: 28
            begin: 28
            show variables: 0.2
            alter_table: 0
            delete: 0.2
            insert: 3
            replace: 0
            update: 40
        Top Command Counters Hourly: 100k
        Handlers
            read_md_next: 800ops
            write: 150ops
            read_key: 100ops
            read_next: 100ops
            external_lock: 60ops
            read_first: 13ops
            update: 2ops
            delete: 1ops
            read_prev: 0ops
            read_md: 0ops
        Transaction Handlers
            commit: 25ops
            rollback: 0.6
        Process States
            idle: 20
            other: 1
            executing: 1
            sending data: 1
            statistics: 0
            preparing: 0
            init: 0
    Query Cache
        Query Cache Memory
            query cache size: 1 MiB
            free memory: 1 MiB
        Query Cache Activity
            not cached: 25
            queries in cache: 0
            prunes: 0
    Files and Tables
        File Openings: 0.2
        Open Files: 65k
    Table Openings
        Open Cache Status
            Hits: 40ops
            Misses due to Overflows: 17
            Misses: 16
        Open Tables
            Table Open Cache: 2k
            Open Tables: 2k
    Table Definition Cache
        Table Definition Cache Size: 1k
        Open Table Definitions: 700
        Opened Table Definitions: 0
### Node Summary
    总计
        Node Name
        Uptime: 1.4 years
        Load Average: 0.6
        RAM: 32GiB
        Memory Available: 63%
        Virtual Memory: 48GiB
        Disk Space: 2.3TiB
        Min Space Available: 26%
    CPU Usage
        iowait: 28%
        user: 10%
        system: 2%
    CPU Saturation and Max Core Usage
        Normalized CPU Load: 0.8
        Max Cpu Core Utilization: 30%
    Disk I/O and Swap Activity
        Disk Writes(page out): 30 MBs
        Disk Reads(page in): 30 MBs
        Swap Out(writes): 0
    Network Traffic
        Outbound: 3MBs
        Inbound: 330 kBs
### InnoDB
    总计
        Buffer Pool Size: 16GiB
        Buffer Pool Size of Total RAM: 52%
        Total Redo Log Space: 900 MiB
        Max Log Space Used
        Max Transaction History Length: 300k
        Data Bandwidth: 23MBs
        Fsync Rate: 40ops
        Row Lock Blocking: 0.02%
    Activity
        Row Reads: 20k
        Row Writes: 100
        Read-Only Transactions: 0
        Read-Write Transactions: 0
        Transactions Information(RW): 0
        Misc Transactions Information: 0
    Storage Summary
        Tables: 1014
        Data Buffer Pool Fit: 2%
        Avg Row Size: 900B
        Index Size Per Row: 700B
        Space Allocated: 900GiB
        Space Used: 900 GiB
        Data Length: 500 GiB
        Index Length: 400 GiB
        Estimated Rows: 600 Mil
        Indexing Overhead: 80%
        Free Space Percent: 0.4%
        Free: 4GiB
    Disk IO
        总计
            InnoDB Page Size: 16 KiB
            Avg Data Read Rq Size: 16 KiB
            Avg Data Write Rq Size: 20KiB
            Avg Log Write Rq Size: 4 KiB
            Data Written Per Fsync: 70 KiB
            Log Written Per Fsync: 20 KiB
            Data Read Per Row Read: 27B
            Data Written Per Row Written: 66 KiB
            Auto Extend Increment: 64MiB
            Double Write: ON
            Fast Shutdown: OFF
            Open Files: 2k
            File Use: 100%
        InnoDB Data I/O
            Data Reads: 37 ops
            Data Writes: 25 ops
        InnoDB Data Bandwidth
            Data Read: 10 MBs
            Data Written: 10 MBs
        InnoDB Log IO
            Log Written: 40 kBs
            Log Writes: 4 ops
        InnoDB FSyncs
            Data Fsyncs: 7 ops
            Log Fsyncs: 2 ops
        InnoDB Pending IO
            Pending Data Reads: 0
            Pending Data Writes: 0
            Pending Log Writes: 0
        InnoDB Pending Fsyncs: 0
    IO Objects
        Targets Bandwidth
        Targets Load
        Targets Read
        Targets Read Load
        Targets Write
        Targets Write Load
        Targets Read Latency
        IO Targtes Write Latency
        Reads by Page Type
        Writes by Page Type
    Buffer Pool
        总计
            Buffer Pool Size: 2GiB
            Buffer Pool Size of Total RAM
            NUMA Interleave
            Buffer Pool Activity: 215 ops
            BP Data
            BP Data Dirty
            BP Miss Ratio: 0.32%
            BP Write Buffering: 4
            Pool Chunk Size: 128 MiB
            Buffer Pool Instances: 8
        Buffer Pool Pages
            data: 120k
            free: 8k
            misc: 2k
        Buffer Pool Data
            data total: 2GiB
            Estimated Dirty Data Limit: 1GiB
            Data Dirty: 5MiB
        Buffer Pool Page Activity: 
            Pages Read: 40 ops
            Pages Written: 20 ops
            Pages Created: 3 ops
        Buffer Pool Requests
            read requests: 10k ops
            wite requests: 200 ops
        Read-Ahead
            Pages Fetched by Linear Read Ahead: 3ops
            Paged Fetched by Read Ahead but Never Accessed: 0.01 ops
            Paged Fetched by Random Read Ahead: 0ops
        Buffer Pool LRU Sub-Chain Churn
    Buffer Pool - Replacement Management
    Checkpointing and Flushing
    Logging
    Locking
    Undo Space and Purging
    Page Operations
    Adaptive Hash Index
    Change Buffer
    Contention
    Misc
    Online Operations(MariaDB)
        Defragmentation
        Online DDL
## Overview
    I/O Thread Running
    SQL Thread Running
    Read Only
    Connections
        Service Used Connections: 750
        Service Aborted Connections: 15
    Threads
        Service Client Threads Connected: 500
        Service Active Client Threads: 25
        Service Thread Cached: 55
    Queries & Questions
        总计
            Top Service Queries: 9.3k ops
            Top Service Questions: 3k ops
            Top InnoDB I/O Data Reads: 99.9%
            Top InnoDB I/O Data Writes: 100%
            Top Data Fsyncs: 50%
        Top Service Queries: 2.5k
        Top Service Questions: 0.5k
    InnoDB I/O
        Top Service Data Reads: 2k rps
        Top Service Data Writes: 1.5k wps
        Top Service Data Fsyncs: 100 ops
    Temporary Objects
        Service Temporary Objects: 150
        Top Service Selects
    Sorts
        Top Service Sorts: 50k
    Locks
        Top Service Table Locks: 3 ops
    Network
        总计
            Top Service Incoming Network Traffic: 10 MBs
            Top Service Outgoing Network Traffic: 30 MBs
        Service Incoming Network Traffic: 2 MBs
        Service Outgoing Network Traffic: 5 MBs
    Query Cache
        总计 
            Top Service Used Query Cache: 99%
        Service Query Cache Size: 100 MiB
    Files
        总计
            Top Percentage of File Openings to Opened Files: 100%
            Top Percentage of Opened Files to the Limit: 0.25%
        Service File Openings: 250
        Service Opened Files: 160
    Table Openings
        总计
            Top Open Cache Miss Ratio: 85%
        Lowest Service Open Cache Hit Ratio: 60%
    Open and Cached Table Definitions
        总计 
            Min Service Opened Table Definitions: 0
            Top Service Opened Table Definitions: 230 ops
            Top Service Open Table Definitions 1.5k ops
            Top Open Table Definitions to Definition Cache: 100%
        Service Table Definition Cache: 1.5 KiB
        Service Opened Table Definitions: 210 ops
        Service Open Table Definitions: 1.4k
## 主从复制
    Replication Delay:  10
    Binlogs Size:  10GiB
    Binlog Data Written Hourly
    Binlogs Count: 30
    Binlog Cache Use Hourly: 300k
    Relay Log Space: 300MiB
    Relay Log Written Hourly

# Oracle
    状态: alive
    活动会话(user)
    进程计数
    执行计数、提交计数、回滚计数
    等待时间
        并发等待: 200ms
        提交等待: 50ms
        应用等待: 50ms
        网络等待: 10ms
        系统I/O等待: 100ms
        用户I/O等待: 1s
        组态等待: 2ms
        scheduler等待: 500ms
    表空间
        表空间类型：持久、临时、重做
        使用率
        剩余空间: 100GB
    资源利用率
        branches
        cmtcallbk
        dml_locks
        enqueue_locks
# PostgreSQL
    总览
        services个数
        Active Connections
        Total Disk-Page Buffers: 32MiB
        Total Memory Size for Each Sort: 16MiB
        Total Shared Buffers: 128GiB
        Services Autovacuum: 100%
    Connections
        Top5 Service Connections: 600
        Top5 Service Active Connections: 5
        Service Idle Connections
        Service Active Connections
    Autovacuum
        Service Value: Yes
    Tuples
        总计
            Total: 170M ops
            Max Fetched: 6M ops
            Max Returned: 6M ops
            Max Inserted: 485 ops
            Max Updated: 560 ops
            Max Deleted: 371 ops
        Service Fetched Tuples Rate: 2M ops
        Service Returned Tuples Rate: 2M ops
        Service Inserted Tuples Rate: 100 ops
        Service Updated Tuples Rate: 100 ops
        Service Deleted Tuples Rate: 50 ops
    Transactions
        总计
            Total: 7.5k ops
            Max Commits: 270 ops
            Max Rollback: 0.2 ops
            Max Duration: 55 s
        Service Commits: 100 ops
        Service Rollbacks: 0.05 ops
        Service Duration of Active Transactions: 850 ms
        Service Duration of Other Transactions: 760 ms
    Temp Files
        总计
            Max Number of Temp Files: 17k
            Max Size of Temp Files: 178GiB
        Service Numbers: 17k
        Service Size: 178GiB
    Conflicts & Locks
        总计
            Total Locks: 6.5k
            Total Deadlocks: 0
            Total Conflicts: 0
        Service Locks: 100
        Service Deadlocks: 0
        Service Conflicts: 0
    Cache Hit
        总计
            Min Cache Hit Ratio: 97%
            Max Cache Hit Ratio: 100%
        Service Lowest Cache Hit Ratio: 100%
    Canceled Queries
        Service Canceled Queries: 0
    Blocks Operations
        总计
            Total Blocks Operations: 0 ops
            Max Blocks Writes: 0 ops
            Max Blocks Reads: 0 ops
        Servcie Blocks Reads: 0 ops
        Service Blocks Writes: 0 ops 
    Buffers Operations
        总计
            Max Allocaetd Bufferes: 38
        Service Allocated Buffers: 10 ops
        Service Fsync Calls by a Backend: 0 ops
        Service Written Directly by a Backend: 5 wps
        Service Written by the Background Writer: 0 wps
        Service Written During Checkpoints: 50 wps
    Checkpoint Stats
        总计
            Total Written Files to Disk: 140k
            Total Files Synchronization to Disk: 27
        Service Files Synchronization to Disk: 0.1 ops
        Service Written Files to Disk: 400 wps