# 阻塞
    阻塞(bio)指cpu等待io
    非阻塞(nio)指调用io后立即返回，但要轮询事件状态
        # 非阻塞指对cpu不阻塞，但业务线程阻塞
    轮询(单线程)
        read
            定时重复调用来检查
        select
            前后read, 中间select轮询检查文件描述符的事件状态
            采用1024长度数组存储状态，只能同时检查1024个文件描述符
        poll
            前后read, 中间poll
            用链表代替数组, 也避免了不必要的检查
        epoll   # linux
            前后read, 中间epoll
            epoll检查不到事件，休眠epoll线程直到事件将它唤醒
        kqueue  # freeBSD中，类似epoll
        aio     # async io, linux, 业务线程不阻塞
            通过回调(信号)传递数据，不必像epoll线程(业务线程)阻塞等待
            仅linux下有, 只O_DIRECT方式读取，不能利用系统缓存
        IOCP    # windows aio
    模拟aio(io线程池)
        业务线程的io操作, 起io线程, io线程完成通信到业务线程触发回调
        库
            glibc(有bug)
            libeio
            node.js的libuv封装
                linux下自实现
                windows下IOCP

# 事件
    实现
        回调
        队列存事件, 单进程检测事件是否回调
    库
        libevent
        libev       # bug比libevent少
    工具
        epoll(select, poll)
        libev(libevent)
# 并发并行
    并发
        多任务共享时间段, 类比: 任务队列
        为什么并发
            多任务能力
            非阻塞
    并行
        多任务同时处理, 类比: 多核处理器
        为什么并行
            提高执行效率
        分类
            任务并行化
            数据并行化
        cpu交替任务           # EDSAC串行任务
            协作式         # 可能独占，Windows3.1, Mac OS 9
            抢占式         # 任务管理器强制中断，Windows95, Mac OS 9以后版本, Unix, Linux
        竞态条件
            三条件
                两个处理共享变量
                一个修改中
                另一个介入
            没有共享
                Multics(1969年)进程共享内存        # Multics基于PL/I和汇编编写
                UNICS(1970年)进程不共享内存
                UNIX10年后，线程共享进程内存
                actor模型(1973年), 不共享内存，传递消息，异步       # Erlang, Scala
            共享内存但不修改                    # haskell所有变量，c++ const变量, scala val变量, java immutable(private属性没有setter)
            不介入修改
                线程协作式                     # ruby的Fibre, python/js的generator
                不便介入标志
                    锁(有线程不检查锁，还是可以进入)               # 1965年提出，1974年改良为monitor。加解锁时，要求对锁的检查和修改同时执行
                        死锁问题
                        无法组合锁，组合要加新锁
                    事务内存                   # 临时创建版本对其修改，更新失败重新执行
                        硬件事务内存(1986年硬件安装lisp的LM-2)     # 1986年cpu MIPS基于RISC简化指令成功，LM-2商业失败
                        软件事务内存(1995年论文), 2005年微软concurrent haskell论文
                            2004年IBM X10, 2006年Sun Fortress, 2007年Clojure, 2010年微软终止.NET软件事务内存
        并行代码
            编译代码顺序不确定，或执行顺序不确定
            看一句代码的内部实现, 在其中执行了行为
                go func () { x = make([]int, 10) }()
                x[9] = 1
        业务并行解耦条件(满足幺半群性质)
            封闭性     # 业务运算结果是业务
            结合律     # 业务a、b的结果后与c执行，等同b、c的结果与a执行
            单位元     # 恒等业务a与其它业务b执行，得b, 如reduce的初值
    系统应用
        并发能力
        吞吐量(并行)
            I/O多路复用(epoll)
            cpu"多路复用"(进程、线程)
            cpu机制(多发射、流水线、超标量、超线程)
        进程线程应用
            cpu对任务的M:N处理
            进程切换处理任务
            线程(通信，并行)
    实现(异步, 并发，并行)
        写法
            回调(监听器), 链式(promise)，同步(async)
        事件处理器
            调度方式: 单线程循环
        协程
            为什么用户实现协程
                POSIX线程模型累赘
                    进程/线程 切换开销大
                    空间资源占用大
                os调度对go模型不合理
                    go gc需要内存处理一致状态(所有线程停止), os调度时，因gc时间不确定，期间大量线程停止工作
                        # go调度器知道什么时候内存处于一致性状态(只需正在核上运行线程)
            本质
                用户态，寄存器+栈, 让出(协作而非抢占)
            调度方式(线程模型)
                N:1     # N个用户空间线程运行在1个内核空间线程
                    上下文切换快
                    无法利用多核
                1:1
                    # POSIX(pthread), java
                    利用多核
                    上下文切换慢，每次调度都在用户态和内核态间切换
                M:N
                    任意内核模型管理任意goroutine
                    调度复杂性大
            go
                M(machine)代表内核线程
                G(goroutine)有自己的栈，程序计数器，调度信息(如正阻塞的channel)
                P(processor)调度上下文, $GOMAXPROCS设置数量
                P中有G队列(runqueue, 队尾添加新G)
                    当前运行一个G, 到调度点时，队列弹出另一个G
                    P周期检查全局G队列防止其中G饿死
                    P运行完，全局G队列拉取G
                    P运行完，全局G队列空，从其它P拉取一半G
                P运行在M, M阻塞时P移到其它M, 阻塞M中保留阻塞的G
                调度器创建足够多M跑P
                    阻塞M中G的syscall返回, M尝试偷一个P
                    没得到P时, 它的G加入全局G队列, M进线池睡眠

    概念
        过度竞争
            过多线程尝试同时使用一个共享资源
        同步  # 直接相互制约
            实现
                同步原语(如通道、锁)作用时，会刷处理器缓存到内存并提交，保证可见性
        互斥  # 间接相互制约
            竞态条件(race condition)
            临界区 # 只能一线程访问的代码，如lock了的代码
            监控模式    # 互斥锁, 函数, 变量 组合出临界区的模式, 使用了代理人(broker)(指锁)
        异步
            # 与同步相对。多线程是实现异步的一种手段
        可见性
            线程总可见到最后修改的数据, 脏读是反例
        原子性
            查看和修改同时发生
        乱序执行
            # java 中标记volatile的变量可以不乱序执行, 现多用原子变量
            编译器或JVM的静态优化可以打乱代码执行顺序(java)
            硬件可以通过乱序执行来优化性
        死锁  # 多线程竞争资源而互相等待
            条件
                互斥      # 资源排他
                不剥夺    # 资源不被外力剥夺
                请求和保持条件     # 线程已保持一个资源，请求新资源。请求被阻塞而自己资源保持
                循环等待    # 阻塞线程形成环
            方案
                锁按顺序获得  # a,b,c锁，要得c手中要有a, b
                    # 使用锁的地方比较零散时，遵守此顺序变得不实际
                    # 可以用对象散列值作全局顺序减小死锁机率
                阻塞加时限
                # 外星方法中可能包含另一把锁，要避免在持锁时调用外星方法
        活锁  # 多线程尝试绕开死锁而过分同步反复冲突
## 多线程
    线程池
        作用
            重复利用, 降低资源消耗
            提高响应速度，不等线程创建
            可管理，线程是稀缺资源，统一分配，调优和监控，提高系统稳定性
## 锁
    锁
        公平锁                             # FIFO取锁
        非公平锁                           # 每次直接占有
        互斥锁(mutex)                      # 访问前加锁，访问后解锁
            悲观锁                         # 假设最坏，等所有线程释放成功
                读加锁
            乐观锁                         # 假设最好，有冲突时重试
                读不加锁，写时判断数据版本是否修改，再重试
        读写锁(rwlock)                     # 竞争不激烈比互斥锁慢
            读锁(共享锁)
            写锁(互斥锁)
            状态
                读加锁状态
                    可多个线程占用
                    处理器缓存提交，数据可见
                    阻塞写线程              # 导致写线程抢占不到资源，所以有写线程时，阻塞后进入的读线程
                写加锁状态
                    一次只有一个线程占用
                    阻塞所有线程
                不加锁状态
        自旋锁 spinlock
            互斥锁改，自己进入循环等待状态(忙等)             # 适合锁持有时间较短
        RCU锁 Read-Copy Update
            读写锁改，一个写线程，读线程无限制
                实现垃圾回收器
                写线程copy副本修改，向垃圾回收器注册callback以执行真正的修改
                垃圾回收器收到信号，所有读线程结束，执行callback
        可重入锁                            # 互斥锁改，允许同一线程多次获得写锁
        管程(monitor)
        临界区(critical section)
        内置锁、显示锁                       # 指java的synchronized与Reentrantlock
    信号量
        进程, 线程间通知状态
## CAS
    # compare and swap，无锁算法(lock free), 非阻塞(non-blocking), 构成基本的乐观锁
    # cpu实现的指令
    3个操作数
        # V的值为A时，原子更新成B，否则无操作。返回V的值
        需要读写的内存位置V
        进行比较的值A
        拟写入的新值B
## 函数式
    介绍
        消除可变状态
    概念
        命令式语言中，求值顺序与源码的语句顺序紧密相关(有可能乱序执行)
        函数式程序并不描述"如何求值以得到结果"，而是描述"结果应当是什么样的"。函数式编程中，如何安排求值顺序相对自由
        引用透明性
            # 任何调用函数的地方，都可以用函数运行结果来替换函数调用，而不会产生副作用
        数据流式编程(dataflow programming)
            # (+ (+ 1 2) (+ 3 4))就是一个数据流，所有函数都可以用时执行
            future模型
## 分离标识与状态
    介绍
        Clojure, 指令式编程和函数式编程混搭

    clojure四种并发模型
        vars (thread-local)
        atoms原子变量
        agent代理
        refs引用 与 ATM软件事务内存
## actor模型
    介绍
        作为actor自己修改自己的数据，对外提供消息，处理对外消息
        共享内存模型和分布式内存模型，适合解决地理分布型问题，强大的容错性
        基于消息传递，侧重通道两端实体
        每个actor有一个mailbox, mailbox中转消息
## csp
    介绍
        通信顺序进程(communicating sequential processes)
        基于消息传递，侧重信息通道
## 数据级并行
    # 不可变数据, 观测不可变、实现不可变
## lambda架构
    介绍
        综合MapReduce和流式处理的特点，处理大数据问题的架构
# 状态保持
    cookie
        分域名, 客户端保存服务器定义数据, 请求时发送
    session
        服务器id数据，id下发到客户端
        共享
            # 同时多方案，动态切换 zookeeper切换环境变量与重启
            # java中filter重写request getSession
            webSphere或JBoss可配置session复制或共享
                # 不好扩展和移植
            加密存cookie
            服务
                redis
                memorycache
                gemfire     # 12306
# 认证
    单点登录
        sessionID存cookie, cookie禁用存头域
    token
        类型
            access token
                # 标识唯一用户
                user_id
                issue_time
                    # token发放时间，单位秒
                ttl
                    # 有效时间，uint16,单位分钟
                mask
                    # int128, 按bit分组用户，用于批量封禁或其它功能
            refresh token
                # 用来换access token，与access token同时发放
                # 过期时间更长
        实现
            redis存储
            token不要太长

# 常见问题
## CSRF
    介绍
        跨域请求伪造(cross-site request forgery)
        client登录A, 本地生成cookie
        client登录B, B给执行js，带参数请求站点A
    解决
        token验证     # 加入自定义头域
        验证Referer头域
## XSS
    介绍
        跨站脚本攻击(cross-site scripting, 易和css混淆，所以写成XSS), 渲染页面时脚本未转义
## XSF
    介绍
        跨站flash攻击(cross-site flash), actionScript加载第三方flash
## sql注入
    介绍
        拼装sql，参数插入sql逻辑
    解决
        sql预编译
## 1+N查询
    介绍
        先查出外键id集合, 再逐条id查关联表。orm易出的问题
    解决
        用 id IN (1,2,3)
        commit前自动合并sql

# 业务场景
## 关注/信箱
    要求
        user人数10w, 活跃1w。
        大部分user关注1k人, 一部分大v被关注100w人。
        每人每天发100条博文
        user新博文数量提醒，消息标记已读
    表
        user
        user_followers
        user_followed
        user_posts(u_id, created_ts)
        user_messages(u_id, p_id, is_read)
            # 10w * 100条数据 / 天
    定时任务拉取
        user_followed拉u_id, user_posts表按时段拉id, 更新user_messages
        优点
            平均, 少次, 增量。
        缺点
            及时性中
            每次对所有用户操作
        数据
            10w*1k*100条数据 / 天
    发布时推送
        有p_id, user_followers, 更新user_messages
        优点
            及时性高
        缺点
            计算集中, 可能高峰
        数据
            最高 100w*100条数据 / 次
            10w*100次 / 天
    messages处理
        存部分messages
            不活跃user不存message
                在登录状态，定时拉取
                    优点
                        减少message
                    缺点
                        计算集中
                    数据
                        1k * N(N<100)条 / 次
                        1w * 1k * 100条数据 / 天
        messages结构变化
            u_id: [{p_id: uint, is_read: bool}]         #  条数稳定为10w
            用mongodb或redis
    消息队列?
        服务端存message状态，不能mq
        如果客户端存状态，这就是个简单的mq问题