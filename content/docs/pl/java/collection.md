# 基础
    物理容器
        数组
        链表
    Java容器
        Collection
            List
                ArrayList
                Vector                          # JDK1.0，所有方法加synchronized
                    Stack
                LinkedList
                CopyOnWriteList                 # 写时复制整个list, 写加锁读无锁, 无fail-fast
            Set
                HashSet
                    LinkedHashSet
                SortedSet
                    TreeSet
                EnumSet
                CopyOnWriteArraySet
                ConcurrentSkipListSet
            Queue                               # 相比List添加线程友好API
                Deque                           # 双端队列
                    ArrayDeque
                    BlockingDeque
                        LinkedBlockingDeque
                BlockingQueue                   # LockSupport实现, channel, 生产者消费者
                    SynchronousQueue            # 锁实现, 无缓冲区channel
                    TransferQueue               # CAS, 生产者带队列阻塞
                        LinkedTransferQueue
                    ArrayBlockingQueue          # 有缓冲区channel
                    DelayQueue                  # 内部维护按时间排序队列
                    PriorityBlockingQueue
                    LinkedBlockingQueue         # 最大数量Integer.MAX_VALUE
                PriorityQueue                   # 堆排序实现
                ConcurrentLinkedQueue           # CAS
        Map
            HashMap
                LinkedHashMap                   # 双向链表，按插入或访问顺序遍历
            Hashtable                           # JDK1.0，所有方法加synchronized
            ConcurrentHashMap                   # CAS, 写慢、读快
            ConcurrentSkipListMap               # 有序, 没有concurrentTreeMap因为CAS红黑树难实现
            TreeMap                             # 有序，红黑树, 查找效率高。
            WeakHashMap
            IdentityHashMap
    工具类
        Collections
            synchronizedMap(Map)                # 内部mutex加synchronized
# Queue
    方法
        add()                                   # 满了报异常
        boolean offer()                         # 返回是否成功
        boolean offer(long, TimeUnit)           # 返回是否成功
        poll()
        peek()
        element()                               # 同peek(), 但空时报错
        remove()
# BlockingQueue
    方法
        put()                                   # 阻塞
        take()                                  # 阻塞
    TransferQueue
        transfer()
        take()
        getWaitingConsumerCount()               # 阻塞的消费者长度