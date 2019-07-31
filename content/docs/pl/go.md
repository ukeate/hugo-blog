---
Categories: ["语言"]
title: "Go"
date: 2018-10-09T16:10:44+08:00
---

# 基础
    特点
        易工程化
            简单性而不方便性，避免工程复杂性乘法增长            # 某部分变复杂，增加其他部分的复杂性(功能、选项、配置)
                没有动态库, 没有泛型, 没有继承, 没有异常, 没有宏，没有注解，没有线程局部存储
            类型系统，无类型风格
            自然方式工作
                不显式初始化和隐式构造函数
                集合直接持有元素
            标准库避免配置和解释     # 自带电池
            项目结构简单
            编译检查代码格式
        csp(communicating sequential process)并发，变长栈运行轻量线程
        编译为本地机器码        # 像c一样，所以又叫类c语言
            编译快
        强静态类型
        有gc
        大厂支持
    历史
        2007年设计，受影响于Alef(CSP系列), Oberon-2(ALGOL60, Modula-2系列), C
            # 目的解决google许多复杂性激增的软件系统
        2009年发布, 作者是Robert Griesemer, Rob Pike, Ken Thompson
        2012年1.0
    并发编程特点
        语言层面关键字
        例程
            流程控制: csp       # channel为一等公民
            通信方式: promise-future, channel, event
        高效调度模型(调度器，资源占用小)
            O(1)的调度
            一进程可支撑上百万例程,5kib/goroutine的开销,
                变长栈存goroutine
    编译
        CGO_ENABLED=0
            # 静态链接，不跨平台
        初始化
            包级别初始化在main前
            局部变量在函数执行时
    配置
        GOROOT
            # go安装目录
        GOPATH
            # 包目录
            # 默认要有go的bin目录
        GOBIN
            # 当前bin目录
        GO15VENDOREXPERIMENT
            # 依赖目录
# 命令
    go
        version
        env                     # 打印go环境信息
        run                     # 编译并运行
        build                   # 编译成二进制执行文件
        install                 # 编译安装
        get                     # 下载依赖, 默认目录是GOPATH下的pkg
            -u                  # update
            -v                  # 查看进度
        clean                   # 清理build产生的文件
            -c                  # 清理.test文件
            -i                  # 清理生成的可执行文件
            -r                  # 包括依赖包的结果文件
        list                    # 列出指定代码包的信息
        fix                     # 升级旧代码成新版本代码
        vet                     # 检查静态错误
        test
            # go test -cover -args -config config_it.toml -test.run "TestA"
            # 执行当前目录下所有_test.go结尾的文件
            -file               # 可省略，测试单个文件, 如go test test_a.go a.go a.pb.go
                                ## 测试单个文件需要引入原文件
            -args               # 运行时参数
            -run TestFoo        # 测单个方法，名字正则匹配，如^TestFoo
            -test.run "TestCreate"                      # 同上
            -v                  # 也显示非错误信息
            -bench=".*"         # 指定运行的用例
            --cpuprofile=cpu.prof                       # 生成cpu分析文件
            --memprofile=mem.prof                       # 生成内存分析文件
            -c                  # 生成可执行的二进制文件，名为x.test，它用来生成状态图
            -cover              # 显示覆盖率
        tool
            pprof               # 交互式访问概要文件
                module1.test cpu.prof
                    # 用性能测试生成cpu状态图
            fix                 # 同go fix
            vet                 # 同go vet
            cgo                 # 生成能够调用c语言代码的go源码文件
        doc
            doc http.ListenAndServe
        fmt                     # 代码格式化
    godoc
        -http=:6060             # 运行本地帮助网站
    gofmt
# 语法
    包                      # 路径引用，命名空间
        main包              # 入口包
            main()          # 入口函数
        包名最好匹配目录名     # 导入路径的最后一段
        import
            逐行import或import(多行)
            import 别名 包路径
        var和const
            逐行或var(多行), const(多行)
        包文件函数
            init            # 文件在编译前排序，按依赖顺序和文件名，也是init的调用顺序。init不能调用和引用
        包依赖排序依次初始化
    注释
        //或/**/
        package前写文档注释，一个包约定一个
        doc.go约定为包的扩展文档注释
    命名
        字母或下划线开头，区分大小写, 不能用关键字
        关键字: break, default, func, interface, select, case, defer, go, map, struct, chan, else
            goto, package, switch, const, fallthrough, if, range, type, continue, for, import, return, var
        首字母大小写决定可见性，大写表示其是导出的
        go倾向短名称, 驼峰式命名, 缩写全大写或小写
    声明定义
        不能有无用的声明变量
        var s string            # 未初始化值默认零值，类型和表达式可省一个
        var s string = ""       # 不推荐
        var s = ""              # 不推荐
        s := ""                 # 短变量声明

        var i,j int             # 自动引申变量类型
        i, j := 0, 1
        i, j := true, "a"       # 类型可不一致
        i, err := 0, e          # err声明过(只检测本词法块，外层不算)，声明i, 赋值err。:=要求至少一个声明

        const

        type                    # 类型声明
            type A int          # 底层共类型, 可赋值性，可比较性。可重写String方法让fmt打印时个性化
            a = A(i)            # 可赋值就可类型转换
        func
        变量生命周期
            包级别是整个程序执行时间
            局部变量声明时创建，直到不可访问
        堆栈
            逃逸变量(函数外保存地址)在堆，局部变量在栈                   # 与变量创建方式无关(new与否), 逃逸需要一次额外内存分配。
    赋值
        x = 1
        *p = 1
        p.name = ""
        m[key] = 1

        +=
        i++和i--                # 只能自成一行, 且不能++i, --i
        _                       # 忽略变量
        a, b = b, a             # 多重赋值

        v, err = f()
        v, ok = m[key]          # map查询
        v, ok = x.(T)           # 类型断言
        v, ok = <-ch            # 通道接收
        可赋值性：类型精准匹配，nil赋值任何接口变量或引用变量, 常量更易隐式转换赋值
            ==和!= 比较，两边要求是可赋值的
    复合字面量                   # 初始化复合类型
        []string                # slice
        S{A:1}                  # 结构体
    指针                         # 不能运算
        &获取地址
        *获取指针
    语句
        for
            for i, j := 0, 1; i < n; i++ {}
            for i < n {}
            for {}
            for index, value := range slice1{}
        if
            if i < n {} else if i < m {} else {}
            if err := f(); err != nil {}
        switch
            switch {                # 无标签(tagless), 相当于switch true,
            case x > 0:             # fallthrough可贯穿, 可用控制流标签
            }
            switch i := 0 {}        # switch true
            switch i++ { }          # switch true
            switch f() {}           # switch true

            switch i {
            case 0:
            case 1:
            default:                # default可在任何地方
            }
        控制流标签
            break, continue, goto   # 可标签化, 如break Label1
    作用域
        词法块：语法块(block)(大括号), 隐式块(未在大括号中的声明, 如if中)
            全局块                   # 内置
            包级别                   # 函数外的声明
            文件级别                  # 导入的包
            局部
        控制流标签作用域是外层函数
        覆盖
            x := 1
            for {
                x := x+1
                if .. {
                    x := x+1        # 这里值的x是最外层x
                }
            }
        if声明的变量(隐式词法块)，else中可见
            if v, err := f(); err != nil {      # else中处理非err逻辑
                return err
            } else {
                v.close()
            }
        包中声明作用域无顺序，可递归    # 常量、变量不可以引用自己
    关键字
        defer fn
        go fn
    方法和接口
        func F(i int) int {
        }
    异常
        func Try(fn func(), handler func(interface{})) {
            defer func() {
                if err := recover(); err != nil {
                    handler(err)
                }
            }()
            fn()
        }

        func main() {
            Try(func() {
                panic("a")
            }, func(e interface{}) {
                print(e)
            })
        }
## 内置
    零值                              # 保障变量良好定义，没有未初始化变量
        数字0, 布尔false, 字符串""
        接口和引用类型(slice, 指针, map, channel, 函数)nil
        复合类型其所有元素或成员零值
    常量
        true
        false
        iota
        nil
    类型
        int
        int8
        int16
        int32
        int64
        uint
        uint8
        uint16
        uint32
        uint64
        uintptr
        float32
        float64
        complex128
        complex64
        bool
        byte
        rune
            # int32别名
        string
        error

        Type
        IntegerType
        FloatType
        ComplexType
    引用类型
        slice
        map                         # key可nil, 取不存在key时, 得到value类型的零值。随机无序遍历
        chan
            ch := make(chan string)

            var cin chan<- string
            var cout <-chan string

            ch <- ""
            <-ch
    命名类型
        type
        结构体
            type Point struct {
                X, Y int
            }
    函数
        make
        len
        cap
        new                         # 创建指定类型变量，初始化为零值，返回地址。不带任何信息且是零值(struct{}和[0]int)的类型, new出的地址不同(从前相同)

        append
        copy                        # slice或string元素复制
        close                       # channel中用
        delete
        complex                     # 创建复数对象
        real                        # 获取复数的实部
        imag                        # 获取复数的虚部
        panic
        recover

# 内部包
    # golang.org/pkg 找到索引
    fmt                         # string类型会调对象的String()方法
        Printf()                # 可以用转义序列(\t等)表示不可见字符
            %d                  # 十进制整数
            %x, %o, %b          # 十六进制、八进制、二进制整数
            %f, %g, %e          # 浮点数6位小数、15位小数、6位小数e表示
            %t                  # 布尔
            %c                  # unicode字符
            %s                  # 字符串
            %q                  # 带引号字符串("abc")，或字符('c')
            %v                  # 内置格式的任何值
            %T                  # 任何值
            %%                  # %本身
        Fprintf()
    os
        Stdin                   # 输入流
        Args                    # 运行参数
        Open()                  # 打开文件
            File
                Read()
                Write()
                Close()
        Exit(1)                 # 1异常退出
    io
        Copy()
    io/ioutil
        Discard                 # 丢弃

        ReadFile()              # 读整个文件到内存
        WriteFile()
    bytes
    strings
        Join()
        Split()
    net
        http
        poolServer(epoll/kqueue/iocp)
            # 支持多核大量并发连接fd
    net/http
        Get()
            Body
                Close()
        HandleFunc()
            ResponseWriter
            Request
                RemoteAddr      # 客户ip:端口
                Host
                Method
                Proto           # 网络协议
                Header
                Form            # 先ParseForm()
                URL
                    Path

                ParseForm()
        ListenAndServe()
    time
        Now()
        Since()
            Seconds()
    bufio                       # 带缓冲io
        NewScanner()
            Scanner             # 以行或单词断开
                Scan()          # 有内容返回true
                Text()
    flag
        Args                    # 非标识参数
        Parse()                 # 出错调os.Exit(2)

        o-> 输入'-s / a bc', 输出'a/bc'
        sep := flag.Strings("s", " ", "desc s")
        flag.Parse()
        println(strings.Join(flag.Args(), *sep))
    template
    regexp
    gob
    strconv
        ParseFloat
    json
    errors
        New
    testing
    log
        Fatal
    reflect
    encoding/gob
    unicode
        ToUpper()
    math
        Sin()
    math/rand
        Seed(time.Now().UTC().UnixNano())
        Float64()
    image
        Rect()
        NewPaletted()
            SetColorIndex()
    image/color
        Color
        White
        Black
    image/gif
        GIF
    sync
        Mutex
            Lock()
            Unlock()
# 外部包
    # godoc.org 搜索
    goimports           # 格式化imports顺序
# 测试
    规则
        文件名以_test.go结尾
        函数以Test开头
        benchmark测试函数以Benchmark开头
# 并发编程
    同步
        func
        channel
            缓冲区
                c := make(chan struct{})
                c1 := make(chan struct{}, 1)
                c ← struct{}{}  # 阻塞
                ← c             # 阻塞

                c1 ← struct{}{}     # 不阻塞
                c1 ← struct{}{}     # 阻塞
                ← c1                # 不阻塞
                ← c1                # 阻塞
            方向
                var c chan struct{}         # in和out
                var cin chan<- struct{}     # in
                var cout <-chan struct{}    # out

                cin = c
                cout = c
                c = cin                     # 编译错误
                c = cout                    # 编译错误
            nil
                var c chan struct{}
                c <- struct{}{}         # 阻塞
            关闭
                c := make(chan struct{})
                close(c)
                c ← struct{}{}          # panic
                o, ok := ← c            # o得到零值, ok是false
        for range
            c := make(chan struct{})
            ...
            for x := range c {}         # close(c)时break
        select
            # channel用select, 值用switch
            # select中不能用fallthrough
            c := make(chan struct{},2)
            label1:
            for {
                select {
                case c<- struct{}{}:
                    fmt.Println(1)
                case <-c:
                    fmt.Println(2)
                    break         # 无标签break跳出当前select块
                        # break label
                        # goto label2
                        # return
                default:
                    fmt.Println(3)
                }
            }
            label2:
            ...
        sync包
            Mutex
            RWMutex
            Once
            WaitGroup
            Cond
                Wait()      # 计数加1, 进入阻塞
                Signal()    # 解除一个阻塞，计数减1
                Broadcast() # 解除所有阻塞
            Map
            Pool
        sync/atomic包


        o-> 并发三个业务, 一起结束
        cond := sync.NewCond(new(sync.Mutex))
        wg := sync.WaitGroup{}
        wg.Add(3)
        wg1 := sync.WaitGroup{}
        wg1.Add(3)
        for i := 0; i < 3; i++ {
            go func(i int) {
                defer wg1.Done()
                cond.L.Lock()
                fmt.Println("wait", i)      # 业务预处理
                wg.Done()
                cond.Wait()                 # 阻塞
                fmt.Println("done", i)      # 业务后续处理(要求所有业务预处理过)
                cond.L.Unlock()
            }(i)
        }
        wg.Wait()           # 业务预处理完成

        cond.L.Lock()
        cond.Broadcast()    # 处理业务后续
        cond.L.Unlock()
        wg1.Wait()          # goroutine完成
    异步
        deadlock    # 指没有可调度的goroutine
            所有goroutine阻塞
            没有goroutine
        goroutine
            无id
            不能中断
            无返回值
        runtime
            Gosched         # 让出执行权
            Goexit          # 终止当前goroutine, 会执行defer
            LockOSThread    # 绑定协程到当前线程
            UnlockOSThread
            GOMAXPROCS      # 并发线程数
            NumGoroutine    # 限制goroutine数
        context
            # 线程安全, 树形结构
            context
                Cancel
                Deadline(Timeout)
                Value
                TODO

                o-> ctx.Done()
                func f(ctx context.Context) (error) {
                    errc := make(chan error, 1)

                    go func() {
                        defer close(errc)
                        time.Sleep(2 * time.Second)
                        errc <- nil
                    }()

                    select {
                    case <-ctx.Done():
                        <-errc
                        return ctx.Err()
                    case err := <-errc:
                        return err
                    }
                }

                o-> WithTimeout
                ctx, cancel := context.WithTimeout(context.Background(), 1*time.Second)     # 调cancel提前结束
                defer cancel()
                return f(ctx)
        time
            After()
            AfterFunc()
            NewTicker()
    并发模式
        # 避免goroutine泄漏，保证通信顺序
        done/quit
            o-> done控制goroutine退出
            func f(done <-chan struct{}) {
                select {
                case <-done:
                    return
                }
            }

            done := make(chan struct{})
            defer close(done)
            f(done)
        channels of channels
            o-> 循环处理请求
            func handle(reqs chan chan interface{}) {
                for req := range reqs {
                    req <- 0
                }
            }
            func server(req chan interface{}) {
                reqs := make(chan chan interface{})
                defer close(reqs)
                go handle(reqs)
                reqs <- req
            }
            func client() interface{} {
                req := make(chan interface{})
                defer close(req)
                go server(req)
                return <-req
            }
            fmt.Println(client())

            o-> 循环异常退出
            type S struct {
                closing chan chan error
            }
            func (s *S) close() error {
                errc := make(chan error)
                s.closing <- errc
                return <-errc
            }
            func (s *S) loop() {
                for {
                    select {
                    case errc := <-s.closing:
                        errc <- nil
                        return
                    }
                }
            }
        pipeline(fan-in, fan-out)   # 传入传出channel来处理
            o->
            func gen(done <-chan struct{}, nums ...int) <-chan int {
                out := make(chan int)
                go func() {
                    defer close(out)
                    for _, n := range nums {
                        select {
                        case out <- n:
                        case <-done:
                            return
                        }
                    }
                }()
                return out
            }
            func sq(done <-chan struct{}, in <-chan int) <-chan int {
                out := make(chan int)
                go func() {
                    defer close(out)
                    for n := range in {
                        select {
                        case out <- n * n:
                        case <-done:
                            return
                        }
                    }
                }()
                return out
            }
            func merge(done <-chan struct{}, cs ...<-chan int) <-chan int {
                # wg等cs数目个协程合并数据到out后，关闭out
                var wg sync.WaitGroup
                out := make(chan int)

                output := func(c <-chan int) {
                    for n := range c {
                        select {
                        case out <- n:
                        case <-done:
                        }
                    }
                    wg.Done()
                }

                wg.Add(len(cs))
                for _, c := range cs {
                    go output(c)
                }

                go func() {
                    wg.Wait()
                    close(out)
                }()
                return out
            }

            func main() {
                done := make(chan struct{})
                defer close(done)

                for n := range sq(done, sq(done, gen(done, 2, 3))) {
                    # gen产生维护数字chan, sq产生维护平方chan。三个chan
                    # 三个goroutine done()时return, chan return时close()
                    fmt.Println(n)
                }

                // 扇出
                in := gen(done, 2, 3)
                c1 := sq(done, in)
                c2 := sq(done, in)
                // 扇进
                for n := range merge(done, c1, c2) {
                    fmt.Println(n)
                }
            }
        timeout
            select {
            case <-ch:
                ...
            case <-time.After(time.Second)
                return
            }
    常用
        中断
            # os.Exit()程序返回错误码

            done := make(chan struct{})
            go func() {
                defer close(done)
                c := make(chan os.Signal, 1)
                defer close(c)
                signal.Notify(c, os.Interrupt, os.Kill)
                defer signal.Stop(c)
                <-c
            }()
        并发压测
            func concurrent(done chan struct{}, fn func(), num int, ccu int, qps int) {     # num总数，ccu并行数，qps并发数
                interval := time.Duration(1e9/qps) * time.Nanosecond
                don := make(chan struct{}, 2)
                go func() {
                    <-done
                    for i := 0; i < ccu; i++ {
                        don <- struct{}{}
                    }
                }()

                //
                tasks := make(chan struct{})
                go func() {
                    var wg sync.WaitGroup
                    wg.Add(num)
                    for i := 0; i < num; i++ {
                        tasks <- struct{}{}
                        wg.Done()
                        time.Sleep(interval)
                    }
                    wg.Wait()
                    close(tasks)
                }()

                //
                var wg sync.WaitGroup
                wg.Add(ccu)
                for i := 0; i < ccu; i++ {
                    go func() {
                        defer wg.Done()
                        for range tasks {
                            select {
                            case <-don:
                                return
                            default:
                                fn()
                            }
                        }
                    }()
                }
                wg.Wait()
            }
            m := sync.Mutex{}
            count := 0
            do := func(){
                m.Lock()
                count++
                m.Unlock()
            }
            concurrent(done, do, 999, 100, 1e3)

# 工具
## glide
    介绍
        包管理
    目录
        glide.yaml
        glide.lock
        main.go
        subpackages
        vendor
    命令
        glide
            init
                # 扫描代码目录，创建glide.yaml文件，记录所有依赖
                删除glide.yaml中自己项目本身
            get
                # 安装并更新glide.yaml
                --all-dependencies -s -v github.com/go-redis/redis#5.0.0
                    # --all-dependencies会更新subpackages
            update
                # 下载和更新glide.yaml中的所有依赖，放到vendor下
                # 递归更新
            install
                # 依据glide.lock与glide.yaml文件安装特定版本
                # glide.lock与glide.yaml不同步时，发出警告
            up
                # 更新依赖树，重建glide.lock文件
            name
                # 查看glide.yaml中依赖名称
            list
                # 依赖列表
            help
            --version
    glide.yaml
        package: .
        import:
        - package: github.com/go-redis/redis
        version: 5.0.0
        repo:git@github.com:go-redis/redis
    常见问题
        vcs
            glide mirror set a a --vcs git
                # 改~/.glide/mirrors.yaml文件
## govendor
    介绍
        包管理
    使用
        go get -u -v github.com/kardianos/govendor
## godev
    # 依赖管理
## gv
    # 依赖管理
## gvt
    # 依赖管理
## gvm
    # 版本管理
    命令
        gvm
            install go1.5
            use go1.5
            list
            listall
            implode
                # 删除所有go版本和gvm本身
## gore
    # repl
## go-torch
    # 性能火焰图
    go-torch -b cpu.prof
