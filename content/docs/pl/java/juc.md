---
Categories: ["语言"]
title: "Java并发"
date: 2018-10-09T08:48:07+08:00
---

# 基础
    并发编程三大特性
        可见性(visibility)
            synchronized会刷新线程栈
        有序性(ordering)
        原子性(atomicity)
## CPU
    PC寄存器(Program Counter Register, 存下一指令)
    优化
        乱序读
        合并写
        乱序执行(流水线)
    ALU
        访问速度
            Registers: < 1ns
            L1 cache(核内): 1ns
            WC(Writer Comblining) Buffer    # 合并写, 一般4个字节
            L2 cache(核内): 3ns
            L3 cache(CPU内): 15ns
            memory: 80ns
    局部性原理
        空间
            按块读取(cache line)
                一次读64Bytes               # disruptor RingBuffer实现前后7个long，两个元素不同行，避免缓存一致性协议的通知
                Java1.8注解@Contended       # 保证不在同一行，需要JVM参数-XX:-RestrictContended
        时间
            批量读指令
    内存屏障                        # 不同CPU不一样
        Intel
            sfence                      # save, 之前写操作必须完成
            lfence                      # load, 之前读操作必须完成
            mfence                      # mix(save + load)
    lock指令                            # 指令执行完之前，锁内存
        lock_add
### CPU缓存一致性协议
    # 是缓存锁。无法被缓存、跨越多个缓存的数据，依然总线锁
    状态
        MESI Cache一致性协议                    # Intel CPU，实现方式为主动监听
            Modified                            # 一行数据在CPU Modified, 其它CPU为Invalid
            Exclusive                           # 独享，其它CPU没有
            Shared                              # 别人也在读
            Invalid                             # 别人改过了
        MSI
        MOSI
    缓存行                                      # 多数64字节
        伪共享                                  # 缓存行内无关数据也要同步
## OS
    进程
        # 资源分配
    线程
        # 调度执行
        切换(Context Switch)
            CPU导出原线程指令和data到cache, 再导入新线程数据
        线程数
            N(threads) = N(CPU) * U(CPU) * (1 + W/C)
                # N(CPU): CPU数
                # U(CPU): 期望CPU利用率, 0到1
                # W/C: wait时间/compute时间, (1+W/C)即运行时间/计算时间。用profiler、arthas分析
            压测决定
    CPU性能压榨
        单进程
        批处理
        多进程切换
        多线程进程内切换
            I/O复用
        协程(纤程、绿色线程)用户空间切换
## JVM
### 内存屏障
    LoadLoad
    StoreStore
    LoadStore
    StoreLoad
### 乱序执行(指令重排序)
    为什么
        CPU快, 指令1阻塞时，指令2先执行
    判断
        代码不影响单线程最终一致性
    例子，多线程
```java
        static int x = 0, y = 0;
        static int a = 0, b = 0;
        void main(){
            for (long i = 0; i < Long.MAX_VALUE; i++>) {
                x=0;
                y=0;
                a=0;
                b=0;
                CountDownLatch latch = new CountDownLatch(2);

                Thread one = new Thread(() -> {
                    public void run() {
                        a = 1;
                        x = b;
                        latch.countDown();
                    }
                });
                
                Thread other = new Thread(() -> {
                    public void run() {
                        b = 1;
                        y = a;
                        latch.countDown();
                    }
                });
                one.start();
                other.start();
                latch.await();
                if (x == 0 && y == 0) {
                    break;
                }

            }
        }
```
    例子，类初始化指令换顺序
```java
        class T {
            int m = 8;
        }
        T t = new T();
        汇编码
            0 new #2 <T>
                # 变量半初始化状态为0
            3 dup
            4 invokespecial #3 <T.<init>>
            7 astore_1
                # 4,7乱序执行, 先建立了关联再初始化, 变量中间状态值为0。线程访问时中间状态逸出
            8 return
        class C {
            private int num = 0;
            public C() {
                new Thread(() -> System.out.println(this.num)).start();
            }
            void main() {
                new C();
                System.in.read();
            }
        }
```
## Unsafe类
    # 相当于指针。1.8只能根部类用, 11可以直接用
    操作内存
        allocateMemory
        putXX
        freeMemory
        pageSize
    生成类实例
        allocateInstance
    操作类或实例
        objectFieldOffset
        getInt
        getObject
    CAS
        compareAndSwapObject()          # JDK1.8
        compareAndSetObject()
        weakCompareAndSetObject()       # JDK11
# 修饰符与锁
## 概念
    锁细化                              # 少代码加轻量锁
    锁粗化                              # 锁太多时，如行锁变表锁
## synchronized
    实现方式
        JVM没要求实现方式
        早期都是OS调度
        HotSpot
            在对象头(64位)上用2位实现，组合成锁的类型
            锁升级                      # 不比原子类慢，升完不降
                偏向锁, 第一个线程第一次访问只记线程id
                自旋锁，线程争抢时，JDK6旋10次，现在为CPU内核数一半。非公平
                重量级锁，OS调度，线程WAIT。符合执行时间长，线程多的场景
    原子性、可见性
    可重入                              # 同一个对象同线程可重入
    加锁对象
        方法锁和对象锁锁this
        static方法锁和类锁锁class类
        继承时锁的子对象(因为是this), 调super synchronized方法也锁子对象
    使用注意
        抛异常立即释放锁，但被锁数据已更新
        不能用的对象
            String常量，可能未知地方锁同一个
            Integer、Long等基本类型, 值变化会生成新对象
        synchronized的属性加final防止赋值
## volatile
    # 用synchronized性能差不多，volatile一般不用
    作用
        # 没有原子性，可能写同一值
        变量在线程见可见性
            依靠CPU缓存一致性协议
        禁止指令重排序                  # 用JVM的读写屏障
            
    修饰引用类型，内部属性不监控

    DCL(Double Check Lock)单例volatile问题
```java
        private static volatile C c;    // 禁止了创建c指令重排序
        private C(){}
        public static C getInstance() {
            if (c == null) {
                synchronized (C.class) {
                    if (c == null) {
                        // 申请内存(半初始化状态默认0)，成员变量初始化，赋值
                        // 先赋值未初始化时，线程2判断非空，返回了半初始化状态的对象
                        c = new C();    
                    }
                }
            }
            return c;
        }
```
## CAS
    # Compare And Set/Swap, 无锁优化, 乐观锁, 自旋
    # Unsafe类支持
    CPU原语
        cas(V, Expected, NewValue)
            if V == E                   # 无并发值判断问题，原语上加了屏障
            V = New
            else try again or fail
    Java
        AtomicInteger
            incrementAndGet()
    ABA问题
        # 线程1读取标记, 线程2改过又改回来，线程1判断标记锁住了提交了业务数据
        版本号                          # Java版本号类AtomicStampedReference
    LongAdder
        LongAdder每次加数字, LongAccumulator用lambda
        分段锁(CAS)。值分开放数组里, 多线程对应一个item
    性能测试
        LongAdder(713) > Atomic(2166) > Synchronized(3129)
## 锁
### AQS
    # AbstractQueueSynchronizer, CLH(Craig, Landin, and Hagersten)队列锁的变种
    # 实现方式: CAS，volatile, 模板方法
    类图
        AbstractQueueSynchronizer
            Sync
                NonfairSync
    方法
        AbstractQueueSynchronizer
            # 一个state和一个双向链表，双向链表看前一结点状态(如持有时等待)
            Node
                volatile Node prev
                volatile Node next
                volatile Thread thread
            VarHandle
                # JDK1.9，保存引用，普通属性原子操作。
                # 相比反射，直接操作二进制码
                get()
                set()
                compareAndSet()         # 原子性
                getAndAdd()             # 原子性
                class C {
                    int x = 0;
                    private static VarHandle handle;
                    static {
                        handle = MethodHandles.lookup().findVarHandle(C.class, "x", int.class)
                        handle.compareAndSet(c, 0, 1);

                    }
                }
            volatile state              # 多态实现
            acquire()
            tryAcquire()                # 模板方法
            acquireQueued()             # 获得
            addWaiter(Node.EXCLUSIVE)   # 放入队列，排他锁或共享锁, CAS设置tail(从前锁整表)
            cancelAcquire()             # status CANCELLED, tail时设置null, 非tail时unpark下一节点
        NonfairSync
            nonfairTryAcquire()
### ReentrantLock
        # 可重入锁，CAS实现, state记重入多少次
        new ReentrantLock(true)         # 公平锁
        tryLock(long, TimeUnit)
        lockInterruptibly()             # 响应interrupt()标记
        newCondition()                  # 多一个等待队列

        源码
            调NonfairSync
### CountDownLatch
        # 比join()灵活
        new CountDownLatch(4)
        countDown()
        await()
### CyclicBarrier
        # 满了一起放行, 场景如I/O批量消费
        new CyclicBarrier(4, ()->{})
        await()
### Phaser
        # 阶段批量执行过滤
        class MyPhaser extends Phaser {
            @Override
            protected boolean onAdvance(int phase, int registeredParties) {
                switch(phase) {
                    case 0:
                        print("arrived" + registeredParties);
                        return false;
                    case 1:
                        print("eated" + registeredParties);
                        return false;
                    case 2:
                        print("hugged" + registeredParties);
                        return true;
                    default:
                        return true;
                }
            }
        }
        Person implements Runnable {
            private int i;
            public Person(int i) {
                this.i = i;
            }
            public void arrive() {
                phaser.arriveAndAwaitAdvance();
            }
            public void eat() {
                phaser.arriveAndAwaitAdvance();
            }
            public void hug() {
                if (i == 0 || i == 1) {
                    phaser.arriveAndAwaitAdvance();
                } else {
                    phaser.arriveAndDeregister();
                }
            }

            @Override
            public void run() {
                arrive();
                eat();
                hug();
            }
        }
        phaser = new MyPhaser();
        phaser.bulkRegister(5);
        for (int i = 0; i < 5; i++) {
            new Thread(new Person(i)).start()
        }
### ReadWriteLock
        # 读锁是共享锁，不能写，悲观锁
        # 写锁是排他锁，不能读写
        ReadWriteLock readWriteLock = new ReentrantReadWriteLock();
        Lock readLock = readWriteLock.readLock();
        Lock writeLock = readWriteLock.writeLock();
        void read(Lock lock) {
            lock.lock()
            lock.unlock()
        }
        void write(Lock lock) {
            lock.lock()
            lock.unlock()
        }
        for (int i =0; i<10;i++) {
            new Thread(()->read(readLock)).start();
        }
        for (int i =0; i<2; i++) {
            new Thread(()->write(writeLock)).start();
        }
### StampedLock
        # 读时允许写，读完判断不一致再读一遍，乐观锁
### Semaphore
        # 信号量, 限流同时运行, 用于线程间同步。可设置公平
        Semaphore s = new Semaphore(1, true)
        new Thread(() -> {
            s.acquire();
            s.release()
        })
### Exchanger
        # 线程间通信, 阻塞交换
        exchange()
### LockSupport
        # 线程间通信，非锁阻塞，指定线程唤醒
        # 线程启动后，unpark()可以在park()前调用生效, make(chan struct{}, 1)
        Thread t = new Thread(() -> {
            for (int i = 0; i < 10; i++) {
                if (i == 5) {
                    LockSupport.park();
                }
            }
        })
        t.start();
        TimeUnit.SECONDS.sleep(1);
        LockSupport.unpark(t);
# 线程及线程池
## 使用注意
    为什么不用Executors线程池
        用LinkedBlockingQueue超数量OOM
        拒绝策略
        线程命名
## 类
```java
    Object
        wait()                              # 释放synchronized锁并加入等待队列，唤醒后执行需要得到synchronized锁
        notify()                            # 只唤醒，不释放当前synchronized锁
    Thread
        static currentThread()
        static sleep()
        static yield()                      # 让出CPU, 进Ready队列
        start()
        getState()
        join()                              # 等待结束
        setDaemon()                         # 是否后台
        setPriority(Thread.NORM_PRIORITY)   # 优先级，没有用


    interface Runnable
        void run()
    interface Callable
        V call() throws Exception
    interface Future
        get()
        get(long, TimeUnit)
        cancel(boolean)
        isCanceled()
        isDone()
        interface RunnableFuture
            class FutureTask
        interface CompletableFuture         # parallel
            static CompletableFuture<U> supplyAsync()
            static CompletableFuture<Void> allOf(CompletableFuture<U>...)
            static CompletableFuture<Void> anyOf(CompletableFuture<U>...)
            T join()
            CompletableFuture<U> thenApply()
            CompletableFuture<Void> thenAccept(Consumer<T>)

    interface ThreadFactory
        Thread newThread(Runnable)
        class DefaultThreadFactory
    interface Executor
        void execute()
        interface ExecutorService
            shutdown()
            shutdownNow()
            isShutdown()
            isTerminated()
            awaitTermination(long, TimeUnit)
            Future submit(Callable<T>)
            Future submit(Runnable, T)                     # 手动设个result
            submit(Runnable)
            invokeAll(Collection<Callable<T>>)
            invokeAll(Collection<Callable<T>>, long, TimeUnit)
            invokeAny(Collection<Callable<T>>)
            invokeAny(Collection<Callable<T>>, long, TimeUnit)
            abstract AbstractExecutorService
                RunnableFuture<T> newTaskFor(Runnable, T)
                RunnableFuture<T> newTaskFor(Callable<T>)
                T doInvokeAny(Collection<Callable<T>>, boolean timed, long)
                submit()
                invokeAll(Collection<Callable<T>>)
                    # 忽略CancellationException, ExecutionException，其它异常抛出并取消未完成任务
                invokeAll(Collection<Callable<T>>, long, TimeUnit)
                    # 忽略CancellationException, ExecutionException, TimeoutException，其它异常抛出并取消未完成任务
                invokeAny(Collection<Callable<T>>)
                invokeAny(Collection<Callable<T>>, long, TimeUnit)
                class ThreadPoolExecutor                    # 线程池+任务队列
                    # 任务顺序: 核心线程, 任务队列，起新线程，拒绝策略
                    class ScheduledThreadPoolExecutor       # 用DelayedWorkQueue
                        scheduleAtFixedRate(()->{}, int initial, int period, TimeUnit)
                class ForkJoinPool
                    execute(ForkJoinTask)
            interface ScheduledExecutorService
                    [class ScheduledThreadPoolExecutor]
    interface CompletionService                             # 不阻塞全部任务，已有结果入队列
        poll()
        class ExecutorCompletionService


    static class Executors
        newSingleThreadExecutor()                           # 为了用任务队列和生命周期管理
        newCachedThreadPool()                               # 超时60s, max为MAX_VALUE, 任务不堆积场景
        newFixedThreadPool()
        newScheduledThreadPool()                            # AbstractQueuedSynchronizer
        newWorkStealingPool()                               # ForkJoinPool, go的M,G,P
            # 每个线程单独队列, 尾部偷加尾部

```
## 创建线程
    # 继承
    class MyThread extendws Thread {
        @Override
        public void run(){}
    }
    new MyThread().start();

    # 组合
    class MyRun implements Runnable {
        @Override
        public void run(){}
    }
    new Thread(new MyRun()).start();

    # 返回值
    class myCall implements Callable<String> {
        @Override
        public String call(){}
    }
    FutureTask = ft = new FutureTask<String>(new MyCall())
    new Thread(ft).start();
    ft.get();

    # 线程池
    // execute无返回值
    ExecutorService service = Executors.newCachedThreadPool()
    service.execute(()->{});
    // submit有返回值 
    Future<String> f = service.submit(new MyCall());
    service.shutdown();
## 线程状态
    NEW
    RUNNABLE            # 可调度
        READY
        RUNNING
    WAITING             # 等待唤醒，忙等待(一直占CPU)
        o.wait()
        t.join()
        LockSupport.park()
        Lock.lock()

        o.notify()
        o.notifyAll()
        LockSupport.unpark()
        Lock.unlock()
    TIMED WAITING
        Thread.sleep(time)
        o.wait(time)
        t.join(time)
        LockSupport.parkNanos()
        LockSupport.parkUntil()
    BLOCKING            # 阻塞等待（不占CPU但经过OS调度)
        synchronized
    TERMINATED
## 线程打断
    方法 
        interrupt()                 # 设置打断标记位
        isInterrupted()             # 检查标记位
        static interrupted()        # 检查当前线程标记位，并重置
    检测当前线程打断标记的方法      # 抛异常并重置
        Thread.sleep()
        o.wait();
        o.join();
        ReentrantLock
            lockInterruptibly()
    不检测当前线程打断标记的方法
        synchronized                # 不是代码实现检测不了
        ReentrantLock
            lock()
    强制打断
        Thread
            stop()                  # 已废弃, 立即释放所有锁
            suspend()               # 已废弃，强制暂停，所有锁不释放容易死锁
            resume()                # 已废弃，强制恢复
    volatile
        判断数字不准，有同步的时间延迟, interrupt()也有延迟
        也需要代码中判断, 但interrupt()有wait()等系统方法支持
## 线程间通信
### 通知
    # synchronized wait() notify(), CountDownLatch, LockSupport
    volatile List c = new ArrayList();
    final Object lock = new Object();
    new Thread(() -> {
        synchronized(lock) {
            if (c.size() != 5) {
                lock.wait();
            }
            lock.notify();              // 唤醒t1
        }
    }, "t2").start();

    TimeUnit.SECONDS.sleep(1);

    new Thread(() -> {
        synchronized(lock) {
            for (int i = 0; i < 10; i++) {
                c.add(new Object());
                if (c.size() == 5) {
                    lock.notify();
                    lock.wait();        // 让出sychronized锁
                }
            }
        }
    }, "t1").start();
### 生产消费
    # 优化count可以用CAS加(有ABA问题)
    class MyContainer<T> {
        final private List<T> list = new LinkedList<>();
        final private int MAX = 10;
        private int count = 0;

        public synchronized void put(T t) {
            while(list.size() == MAX) {
                this.wait();            // 期间可能有add() 
            }
            list.add(t);
            count++;
            this.notifyAll();           // 应该只唤醒消费者
        }

        public synchronized T get() {
            T t = null;
            while(list.size() == 0) {
                this.wait();
            }
            t = list.removeFirst();
            count--;
            this.notifyAll();           // 应该只唤醒生产者
            return t;
        }
    }

    # 同步容器, ReentrantLock Condition
    private Lock lock = new ReentrantLock();
    private Condition producer = lock.newCondition();
    private Condition consumer = lock.newCondition();

    public void put(T t) {
        try {
            lock.lock();
            while(list.size() == MAX) {
                producer.await();
            }
            list.add(t);
            count++;
            consumer.signalAll();
        } finally {
            lock.unlock();
        }
    }

    public T get() {
        T t = null;
        try {
            lock.lock();
            while(list.size() == 0) {
                consumer.await();
            }
            t = list.removeFirst();
            count--;
            producer.signalAll();
        } finally {
            lock.unlock();
        }
        return t;
    }
# 协程
    quasar库                            # 需要设javaagent, 每个fiber生成栈
        fiber =  new Fiber<Void>()
        fiber.start()
# 并发API
## Stream
    parallelStream()                    # ForkJoinPool
## ThreadLocal
    内部类
        ThreadLocalMap<ThreadLocal, Object>
            # 存在每个线程里。场景如声明式事务拿conn
            # key是弱引用指向ThreadLocal, value是强引用。
        Entry extends WeakReference<ThreadLocal<?>> {
            Object value;
            Entry(ThreadLocal<?> k, Object v) {
                super(k);
                value = v;
            }
        }
    方法
        set(T)
    内存泄露问题
        ThreadLocal<M> tl = new ThreadLocal();
        tl.set(new M());
        tl = null;
            # threadLocalMap中key弱引用回收, value不回收
        tl.remove();
            # 必需remove()否则内存泄露, threadLocalMap中value强引用，tl回收了也一直存在
## PipedStream
    # 效率不高
    PipedInputStream
        connect(PipedOutputStream)
        read(byte[])
    PipedOutputStream
        write(byte[])
## JMH
    # Java Microbenchmark Harness
    概念
        Warmup                              # 预热
        Mesurement                          # 总执行次数
        Timeout                             # 每次执行超时时间
        Threads                             # fork线程数
        Benchmark mode                      # 模式
        Benchmark                           # 方法名
    环境变量
        TEMP或TMP                           # JHM临时文件存放
    使用
        @Benchmark
        @Warmup(iterations = 2, time = 3)           # 执行2次, 每次隔3秒
        @Fork(5)                                    # 多少线程
        @BenchmarkMode(Mode.Throughput)             # 显示每秒多少次
        @Measurement(iterations = 10, time = 3)     # 共测10次, 每次隔3秒
        public void testA() {

        }
## Disruptor
    介绍
        CAS, 环形数组Buffer
            数组用sequence定位修改快,也避免了头尾加锁
            直接覆盖降低GC
                覆盖前有等待策略
        单机MQ
            发布订阅模式
            观察者模式
        EventFactory
            会调工厂提前分配内存, 使用时不new而是修改值，提高效率, 降低GC
    使用
        class MyEvent {}
        class MyEventFactory implements EventFactory<MyEvent> {
            @Override
            public MyEvent newInstance() {}
        }
        class MyEventHandler implements EventHandler<MyEvent> {
            @Override
            void onEvent(MyEvent, long sequence, boolean endOfBatch) {}
        }
        class MyExceptionHandler implements ExceptionHandler<MyEvent> {
            @Override
            void handleEventException()
            @Override
            void handleOnStartException()
            @Override
            void handleOnShutdownException()
        }
        disruptor = new Disruptor<>(factory, 1024, Executors,defaultThreadFactory())
        disruptor = new Disruptor<>(MyEvent::new, 1024, Executors,defaultThreadFactory())
        disruptor = new Disruptor<>(factory, 1024, Executors,defaultThreadFactory(), 
            ProducerType.SINGLE, new BlockingWaitStrategy())
            # 默认ProducerType.MULTI, SINGLE可提高性能不用加锁
        // 消费
        disruptor.handleEventsWith(handler1, handler2)
        disruptor.handleEventsWith((event,seq,end)->{})
        disruptor.handleExceptionsFor(handler1).with(excptionHandler1)

        disruptor.start()

        // 生产
        ringBuffer = disruptor.getRingBuffer()
        sequence = ringBuffer.next()
        event = ringBuffer.get(sequence)
        event.set("")
        ringBuffer.publish(sequence)
        translator = new EventTranslator<>() {
            @Override
            void translateTo(event, sequence) {
                event.set("")
            }
        }
        ringBuffer.publishEvent(translator)
        ringBuffer.publishEvent((event,seq, "") -> event.set(l), "")
    等待策略
        BlockingWaitStrategy                # 阻塞直到再次唤醒
        BusySpinWaitStrategy                # 自旋等待
        SleepingWaitStrategy                # sleep等待
        LiteBlockingWaitStrategy            # 同BlockingWaitStrategy减少加锁次数                
        LiteTimeoutBlockingWaitStrategy     # 同LiteBlockingWaitStrategy加超时            
        PhasedBackoffWaitStrategy
        TimeoutBlockingWaitStrategy         # 同BlockingWaitStrategy加超时                
        YieldingWaitStrategy                # 尝试100然后Thread.yield()

# 源码分析
## ThreadPoolExecutor
    new ThreadPoolExecutor()                    
        int corePoolSize                    # 核心线程数, 永远存活。可设置参与回收
        int maximumPoolSize                 # 最大线程数
        long keepAliveTime                  # 生存时间
        TimeUnit
        BlockingQueue<Runnable>             # 任务队列
        ThreadFactory                       # 线程工厂, 设线程名
        RejectedExecutionHandler            # 拒绝策略
            Abort                           # 抛异常
            Discard                         # 忽略掉
            DiscardOldest                   # 忽略掉排除最久的
            CallerRuns                      # 调用者线程执行, 再多就阻塞
    AtomicInteger ctl
        # 高3位线程池状态，低29位线程数量
    void execute()
        判断添加核心线程
        放入队列成功
            拒绝或添加非核心线程
        添加非核心线程失败
            拒绝
    boolean addWorker(Runable, boolean)
        线程数量加1
        添加Worker
            加锁
            加线程
            启动
    class Worker extends AbstractQueuedSynchronizer implements Runnable
        # 本身是AQS锁, 被多任务(线程)访问
        Tread thread
## ForkJoinPool
    abstract class ForkJoinTask
        ForkJoinTask<V> fork()
        V join()
        abstract class RecursiveAction          # 无返回值
            void compute()
        abstract class RecursiveTask            # 有返回值
    例子
        class MyTask extends RecursiveTask<Long> {
            int start;
            int end;
            @Override
            Long compute() {
                if (end - start <= MAX_NUM) {
                    return sum
                }
                subTask1 = new MyTask(start, mid)
                subTask2 = new MyTask(mid, end)
                subTask1.fork()
                subTask2.fork()
                return subTask1.join() + subTask2.join();
            }
        }
        fjp = new ForkJoinPool()
        task = new MyTask(0, nums.length)
        fjp .execute(task)
        result = task.join()