---
Categories : ["数据库"]
title: "Mongodb"
date: 2018-10-11T16:00:15+08:00
---

# 特点
        数据结构json(bson)
        易写入，易修改
        c++编写
        分布式
        介于关系数据库 和 非关系数据库之间
        查询语句强
        支持索引
        bson格式

# 注意
        document不能大于4Mb
        可以非安全模式异步马上成功
        每个连接用队列存储命令

# 数据结构定义
        collection                                        # 表
                document                                # 记录
                        field(key, value)                # 字段(field)与值(value)
        与关系型数据库的区别
                document中的field不要key俱全或一样
                find()命令查询

# bson的数据类型
        ＃bson 是json的扩展
         # 增加了数据类型
         # 把json数据转换成二进制码存到文件
        null
        boolean
        undefined
        数组                                # 如{gps: [20, 56]}
        32位和64位整数                # shell中不支持
                                        ## node.js python java等高级语言的驱动中支持
        64位浮点                        # shell使用的全是这种类型, 如{x:3.14}
        utf-8                                # 字符串类型
        ObjectID
        Date                                # 如{x:new Date()}
        正则                                # 如{x:/uspcat/i}
        javascript块代码                # 如{x:function(){}}
                                        ## 相当于存储过程
        内嵌文档                        # 如{x: {xx: "a"}}
        二进制                                # shell中不能使用

# ObjectId
        大小
                12字节
                显示为24个十六进制字符
                # 空间换时间的思想
        细节
                前4字节是unix时间戳
                后3字节集群machine hash
                后2字节pid
                后3字节inc自增计数器, 在前面都相等时全局自增
# 命名
        数据库与集合名
                不能是空字符串
                特殊字符
                        ' (空格) , $ / \ \0
                应该全小写
                小于64字节
                数据库名不与保留库名相同，如
                        admin, local, config
        集合名
                db-text合法，但不能db.db-text得到，要db.getCollection("db-text").text得到
                        # db-text 会认为是减法
                        ## 数据库名可以是db-text
                可以a.b来命名来划分子集合
                        不能以system.开头命名
# api
    collection
            增
                    save
                            # 不存在时插入，存在时更新
                            # {$ref: 'user', $id: 1} 来保存引用
                    insert
            删
                    remove('id': 'bar')        # 删除一条数据
                                                                            #remove()删除所有数据
                    drop()                                # 删除persons collection, 不释放文件空间
                    dropIndexes()                        # 删除所有索引
            改
                    update(finder, updater, options或upser, multi)
                            # $set
                            # {age: {$gt: 18}, $isolated : 1} $isolated事务隔离该字段到本语句执行结束, does not work with sharded clusters
                    findAndModify
            查
                    findOne()
                    find(finder, filter)
                            # limit(3).skip(10).sort({name: -1, age: 1})
                            ## sort({$natural: 1}) 固定集合排序
                            # explain() 返回带统计信息的文档
                            ## 是否用到索引，耗时，需要扫描多少文件
                            # hint({}) 强制使用某索引查询
                            # null可以匹配null, 也可以匹配{$exists: false}        
                            # 正则可以匹配自身，也可以模式字符串
                    count()                                # document的条数
                    aggregate

    db
            # 默认存在的数据库admin, config, local
            sources
                    # 从节点中设置的源collection
            help()
            persons.help()
                    # 显示某集合的帮助
            auth('username', 'pwd')
                    # 切换用户
            addUser()
                    # addUser('admin', 'asdf')
                    # addUser('readonly', 'asdf', true)
            listCommands()
            shutdownServer()
            eval()
                    # 执行
            stats()                                        
                    # 当前数据库的状态
                    ## 包括名称，collection数，索引数等
            createCollection()
                    # {'user', {capped: true, size: 100, max: 10}} 
                    ## 创建固定集合, 100字节, 文档数上限为10
                    ## 固定集合插入快，不能删除，无_id, 有尾部游标
            getCollection("persons").text
                    # 同db.persons        
            dropDatabase()
                    # 删除当前数据库        
            repairDatabase()
                    # 释放空间
            serverStatus()
                    # 返回数据库的metrics 数据
            serverStatus().metrics.cursor
                    # 返回指针信息
            ensureIndex({x: 1, y: -1}, {name: 'xy'})
                    # 建立x的升序, y的降序联合索引
                    # 只使用索引的前部, 即对x的查询可以用该索引
                    # {"gps": '2d'} {'gps': '2dsphere'}
                    ## 支持gps写成 [0, 0] {x: 0, y: 0} {latitude: 0, longitude: 0} 格式
                    # 可以索引内嵌文档
                    # {unique: true} 来建立唯一索引
                    # {dropDups: true} 将唯一索引中重复的文档都删掉
            dropIndexes
            system
                    indexes
                            # 保留集合，索引
                    namespaces
                            # 也包含索引信息
                    js
                            insert({_id: 'fn', value: function() {}})
                                    # 用db.eval('fn()') 执行
            runCommand()
                    # {'dropIndexes': 'col', 'index': 'ind'}
                    # 可以返回命名执行的状态信息
                    {buildInfo: 1}
                    {collStats: 'user'}
                    {distinct: 'user', key: a, query: {b: 0}}
                    {drop: 'user'}
                    {dropDatabase: 1}
                    {dropIndexes: 'user', index: 'ind'}
                    {getLastError: 1}
                            # 上次更新的作用信息
                            {getLastError: 1, w: 3}
                                    # 阻塞复制，有3个节点
                    {isMaster: 1}
                    {findAndModify: 'user', query: {a: 0}, sort: {a: 1}, update: {$set: {a: 1}}}
                    {listCommands: 1}
                    {listDatabases: 1}
                    {ping: 1}
                    {renameCollection: 'user', to: 'user1'}
                    {repairDatabase: 1}
                            # 修复并压缩当前数据库
                    {serverStatus: 1}
                            # globalLock: 全局写入锁占用了多少时间
                            # mem: 内存映射了多少数据
                            # indexCounters: B树磁盘检索(misses)和内存检索(hits)的次数
                            # backgroundFluhing: 后台做了多少次fsync及用的时间
                            # opcounters: 每种主要操作的次数
                            # asserts: 断言的次数
                    {convertToCapped: 'user', size: 100}
                            # 转为固定集合
                    {fsync: 1, lock: 1}
                            # 缓冲写入磁盘，并加写入锁。后可以直接复制磁盘数据来备份
                            # db.$cmd.sys.unlock.findOne() 解锁
                            # db.currentOp() 查看为空时已解锁
                    {resync: 1}
                            # 从节点重新同步
                    {collMod: 'users', usePowerOf2Sizes: true}
                            # 每次增大空间总是2的倍数，适用于常写的集合
    rs
            isMaster
            slaveOk
    dcl
            help                                        # 显示帮助
            show dbs                                # 显示所有数据库
            use mydb                                # 选择数据库(默认为test)
                                                    ## 如果没有该数据库，则创建(插入第一条数据时实际创建)
            db                                        # 显示当前数据库名
            show collections                        # 查看当前数据库的collections
            db.eval()                                # 执行shell语法字符串

            用户管理命令
                    use test                                # 选择需要添加用户的数据库
                    db.addUser('name','pwd')                # 第三个参数代表是否只读 true代表是 ,  false代表否
                                                            ## db 代表本数据库，也就是test
                    db.system.users.find()                        # 查看用户列表
                    db.auth('name','pwd')                # 用户认证，反回１代表认证成功
                    db.removeUser('name')
                    show users                                # 查看所有用户

                            # 注
                                    权限生效需要mongod　以　-auth参数启动
                                    admin数据库中的user是超级管理员 , 其他数据库中的user只限于本数据库

    ttl(time to live)
            # mongodb每1分钟检查一次数据删除
            db.log_events.ensureIndex({"createdAt": 1}, {expireAfterSeconds: 3600 })
            db.log_events.insert({
                    "createdAt": new Date(),
                    "logEvent": 2,
                    "logMessage": "Success!"
            })
                    # 插入的这条数据在1小时后删除
            db.log_events.ensureIndex({"expireAt": 1}, {expireAfterSeconds: 0})        
            db.log_events.insert({
                    "expireAt": new Date('July 22, 2013 14:00:00'),
                    "logEvent": 2,
                    "logMessage": "Success!"
            })
                    # 插入的这条数据在July 22, 2013 14:00:00删除

## aggregate
    mapReduce(
            function() {emit(this.cust_id, this.amount);},
                    # map
            function(key, values) {return Array.sum(values)},
                    # reduce
            {
                    query: {status: 'A'},
                            # query
                    out: 'order_totals'
                            # output
            } 
    )

    distinct()

    count()

    group({
            key: {a: 1},
                    # $keyf: function(x) {return x.category} 定义分组函数
            cond: {a: {$lt: 3}}.
            $reduce: function(cur, result) {result.count += cur.count},
            initial: {count: 0},
            finalize: function (prev) {}
    })
            # 返回的文档 {retval: [], count: 0, keys: 0, ok: 0}
    aggregate([
            {$redact: {$cond: {
                    if: {$eq: ['$level', 5]},
                    then: '$$PRUNE',
                    else: '$$DESCEND'
            }}}
            {$match: {status: 'A'}},
            {$geoNear: {...}},
            {$project: {name: {$toUpper: '$_id'}, _id: 0}},
            {$unwind: '$sizes'},
            {$group: {_id: '$state', totalPop: {$sum: '$pop'}}},
            {$skip: 10},
            {$limit: 5},
            {$sort: {age: -1}},
            {$out: 'authors'}
    ])

    例子
        o-> 得到tags数组的长度
        db.users.aggregate([{
                $group: {
                        _id: '$username',
                        tags_count: {$first: {$size: '$tags'}}
                }
        }])
        db.users.aggregate([{
                $project: {
                        tags_count: {$size: '$tags'}
                }
        }])
## expressions            
    $and
    $or
    $not
    $setEquals
    $setIntersection
    $setUnion
    $setDefference
    $setIsSubset
    $anyElementTrue
    $allElementsTrue
    $cmp
    $eq
    $gt
    $gte
    $lt
    $lte
    $ne
    $add
    $subtract
    $multiply
    $divide
    $mod
    $concat
    $substr
    $toLower
    $toUpper
    $strcasecmp
    $meta
    $size
    $map
    $let
    $literal
    $dayOfYear
    $dayOfMonth
    $dayOfWeek
    $year
    $month
    $week
    $hour
    $minute
    $second
    $millisecond
    $dateToString
    $cond
    $ifNull
    $sum
    $avg
    $first
    $last
    $max
    $min
    $push
    $addToSet
    $near
    $within
    $box
    $center
## 对象
    全局函数
            printjson
            connect('localhost:27017/mydb')
                    # 连接另一个服务器
            runProgram
    对象类型
            cursor
                    hasNext()
                            # 立即返回前100个数据与4Mb数据的较小者。取数据时直接读缓存
                    next()
                    forEach
## 复制
    复制
            mongod --master --oplogSize 100
            mongod --slave --source localhost:27017
                    # --source指定主节点
                    # --only 指定只复制特定的数据库
                    # --slavedelay 主从复制时的延时
                    # --fastsync 从节点是主节点快照时，加这个选项，同步速度快
                    # --autoresync 重新同步
                    # --oplogSize 主节点oplog的大小
            db.sources.insert({host: 'localhost:27017'})
                    # 从节点设置主节点

    副本集
            #  没有主节点，集群自己选举主节点
            # 数据太多从节点会自动停止同步
            mongod --dbpath '/var/local/mongo1' --port 27017 --replSet rs0
                    # 三个实例replSet 名必叫 rs0
            use admin
            rs.initiate({
                    _id: 'a',
                    members: [{
                            _id: 1,
                            host: 'localhost1:27017'
                    }, {
                            _id: 2,
                            host: 'localhost1:27018'
                    }]
            })
                    # 其中一台执行初始化
            rs.add('localhost:27019')
            rs.status()
            db.getMongo().setSlaveOk()
            rs.isMaster()
            rs.conf()
            db.getReplicationInfo()
            db.printReplicationInfo()
            db.printSlaveReplicationInfo()
            use local        
            db.addUser('name', 'pwd')
                    # 复制认证时用
## 分片 
    mongods --port 3000 --configdb localhost:27017
            # 多个地址用,隔开
            # 每个片都就是副本集
    mongo localhost:3000/admin
    db.runCommand({addshard: 'localhost:27017‘, allowLocal: true})
            # 在localhost上运行时, 要设allowLocal
            # 'a/localhost:27017' 让mongo知道这个片所在的副本集
    db.runCommand({enablesharding: 'db1'})
    db.runCommand({shardcollection: 'db1.user', key: {_id: 1}})
    db.printShardingStatus()
    db.runCommand({removeshard: 'localhost:27017'})
# shell
    mongo 127.0.0.1:27017/admin
            # 启动sell , 默认数据库为test
    mongod –port 10000 –fork –logpath= logpath=/data/mongodb/log/mongodb.log -- logappend -- dbpath=/data/mongodb/data/db –config ~/.mongodb.conf 
            # 启动服务 -auth开启身份验证
            # --rest 开启http管理，其端口号比mongo端口号大1000
            ## --nohttpinterface关闭http管理
            # --bindip localhost 设置只能有某ip访问
            # --noscripting 完全禁止服务端js执行
            # --repair 启动并修复
            # 不要发送SIGKILL信号关闭(kill -9), 应发送SIGINT或SIGTERM
            mongod --remove                                
                    # 结束服务
            // mongodb.conf
                    port = 5586
                    fork = true
                    logpath = mongodb.log
    mongodump --host 127.0.0.1 --port 27017 --out ./dir/name
            # 备份数据库
    mongodump -h IP --port 端口 -u 用户名 -p 密码 -d 数据库 -o 文件存在路径
    mongorestore --host 127.0.0.1 --port 27017 --directoryperdb ./dir/name
            # mongorestore -h IP --port 端口 -u 用户名 -p 密码 -d 数据库 --drop 文件存在路径
            # --drop 是先删除现有的数据
    mongoexport -d tank -c users -o /home/outrun/mongo
            # 导出整张表
            ## mongoexport -h IP --port 端口 -u 用户名 -p 密码 -d 数据库 -c 表名 -f 字段 -q 条件导出 --csv -o 文件名
            # mongoexport -d tank -c users --csv -f uid,name,sex -o tank/users.csv 
            ## 导出表的部分字段
            # mongoexport -d tank -c users -q '{uid:{$gt:1}}' -o tank/users.json
            ## 根据条件导出数据
    mongoimport -d tank -c users --upsert tank/users.dat
            # mongoimport -h IP --port 端口 -u 用户名 -p 密码 -d 数据库 -c 表名 --upsert --drop 文件名 
            ## 还原整表导出的非csv文件,  --upsert 表示插入或更新现有数据
            # mongoimport -h IP --port 端口 -u 用户名 -p 密码 -d 数据库 -c 表名 --upsertFields 字段 --drop 文件名
            ## 还原部分字段导出的文件, --upsertFields跟upsert一样
            ## 如 mongoimport -d tank -c users  --upsertFields uid,name,sex  tank/users.dat
            # mongoimport -h IP --port 端口 -u 用户名 -p 密码 -d 数据库 -c 表名 --type 类型 --headerline --upsert --drop 文件名  
            ## 还原导出的csv文件
            ## mongoimport -d tank -c users --type csv --headerline --file tank/users.csv
    mongofiles put foo.txt
            # 使用gridfs
            list
            get foo.txt
            search
                    # 按文件名查找
            delete foo.txt
    mongostat
            # 实时输出mongo状态
# java client
    1.导入mongo-java-drver-2.9.3.jar
    2.api
            Mongo m = new Mongo("localhost", 27017);
            DB db = m.getDB("mydb");
            boolean auth = db.authenticate("root", "root".toCharArray());
            System.out.println("身份认证" + auth);
            // 获得所有数据库名
            for (String s : m.getDatabaseNames()) {
                    System.out.println("db : " + s);
            }
            // 删除数据库
            m.dropDatabase("my_new_db");
            // 获得collection列表
            Set<String> colls = db.getCollectionNames();
            for (String s : colls) {
                    System.out.println("collection : " + s);
            }
            // 获得一个collection
            DBCollection coll = db.getCollection("testCollection");
            // 创建document(包括内嵌文档)
            DBObject doc = new BasicDBObject().append("appendField", "appendField");
            doc.put("name", "MongoDB");
            doc.put("type", "database");
            doc.put("count", 1);
            DBObject info = new BasicDBObject();
            info.put("x", 203);
            info.put("y", 102);
            doc.put("info", info);
            // 插入文档
            coll.insert(doc);
            // 查询文档
            DBObject doc2 = coll.findOne();
            System.out.println(doc2);
            // 统计文档数
            long count = coll.getCount();
            System.out.println(count);
            // 用游标遍历
            DBCursor cursor = coll.find();
            while (cursor.hasNext()) {
                    DBObject object = cursor.next();
                    System.out.println(object);
            }
            // 查询
            DBObject query = new BasicDBObject();
            query.put("i", 71);
            cursor = coll.find(query);
            // 条件查询
            query = new BasicDBObject();
            query.put("i", new BasicDBObject("$gt", 50)); // i>50
            cursor = coll.find(query);
            // 创建索引
            coll.createIndex(new BasicDBObject("i", 1)); // 1代表升序 , -1是降序
            // 查询索引
            List<DBObject> list = coll.getIndexInfo();
                    for (DBObject index : list) {
                    System.out.println("索引 : " + index);
            }
    类型
        // 自动生成的唯一ID
        ObjectId id = new ObjectId();
        System.out.println(id);
