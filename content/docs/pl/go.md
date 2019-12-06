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
                引用包名在头
                包依赖有向无环，可独立和并行编译
                目标文件包含依赖包信息
        强静态类型
        有gc
        变长栈，最小2kb, 最大1GB
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
        GOROOT                  # go安装目录
        GOPATH                  # 包目录, 默认要有go的bin目录
        GOBIN                   # 当前bin目录
        GO15VENDOREXPERIMENT    # 依赖目录
        GOOS                    # 指定操作系统, 如android, linux, darwin, windows
        GOARCH                  # 处理器架构，如amd64, 386, arm
# 命令
    go
        help
            importpath          # 说明 指定代码托管网站版本协议
            gopath              # vendor怎么使用
            list                # go list 说明
        version
        env                     # 打印go环境信息
        run                     # 编译并运行
            -race               # 检查运行中的竞态冲突并报告
        build                   # 库被舍弃，main包编译成二进制执行文件
            go build gopl.io
            go build x.go
            -race
            -i                  # 编译到指定位置
        install                 # 编译安装
        clean                   # 清理build产生的文件
            -c                  # 清理.test文件
            -i                  # 清理生成的可执行文件
            -r                  # 包括依赖包的结果文件
        doc
            命令
                go doc go/build
            包
                go doc html/template
            包成员
                go doc time.Since
            方法
                go doc http.ListenAndServe
        fmt                     # 代码格式化

        get                     # 下载依赖, 默认目录是GOPATH下的pkg。下载后自动install
            go get gopl.io/...  # ...通配
            -v                  # 查看进度
        list                    # 列出指定代码包的信息
            go list ...         # ...通配
            go list ...xml...
            -json hash          # 输出json格式完整信息
            -f                  # 使用go模板
        fix                     # 升级旧代码成新版本代码
        vet                     # 检查静态错误

        test
            # go test -cover -args -config config_it.toml -test.run "TestA"
            # 执行当前目录下所有_test.go结尾的文件
            -race

            -file               # 可省略，测试单个文件, 如go test test_a.go a.go a.pb.go
                                ## 测试单个文件需要引入原文件
            -args               # 运行时参数
            -run TestFoo        # 正则表达式匹配方法，NONE表示不匹配。如"^TestFoo", "F|F1"
            -test.run "TestCreate"                      # 同上
            -v                  # 每个测试用例的名称和时间
            -bench=".*"         # 正则匹配benchmark测试函数
            -benchmem           # 显示benchmark测试时内存分配
            --cpuprofile=cpu.prof                       # 生成cpu分析文件，使用多个标记时(如cpu, mem), 一个类别会覆盖另一个。性能剖析启用时, go test不丢弃其临时可执行文件
            --blockprofile=block.out                    # 生成阻塞分析文件
            --memprofile=mem.prof                       # 生成内存分析文件
            -c                  # 生成可执行的二进制文件，名为x.test，它用来生成状态图
            -cover              # 显示覆盖语句汇总信息
            -coverprofile=c.out # 生成日志文件c.out，记录语句覆盖信息
            -covermode=count    # 语句覆盖信息不用bool而用count累加

        tool
            cover               # 测试覆盖率工具使用方法
                go tool cover -html=c.out               # html分析c.out
            pprof               # 交互式访问概要文件
                go tool pprof module1.test cpu.prof                   # 性能测试状态图, 参数是可执行文件和剖析日志
                -test           # 文本格式
                -nodecount=10   # 限制输出10行
                -web            # 渲染有向图web显示
            fix                 # 同go fix
            vet                 # 同go vet
            cgo                 # 生成能够调用c语言代码的go源码文件
            compile
                -help           # 可传给编译器的参数

    godoc                       # 提供html页面
        -http=:6060             # 运行本地帮助网站
        -analysis=type          # 提供静态分析结果
            -analysis=pointer
    gofmt
    golint                          # 检查风格
# mod
    环境变量
        GO111MODULE
            off                     # 总关闭
            on                      # 总开启
            auto                    # 默认，有go.mod开启
    路径
        $GOPATH/pkg/mod             # 保存多版本依赖, 被多项目引用
        go.mod                      # 被go命令维护, 融入了go命令的各个模块
        go.sum                      # 记录lock
    依赖加载顺序
        最新release tag
        最新commit
    命令                            # 融入到各个子命令中
        go
            build                   # 检测mod
            install                 # 检测mod
            get gopl.io@2           # 指定mod版本号
                -u                  # 更新到mod最新版本
            mod
                init packageName1   # 生成go.mod
                download            # 下载mod
                tidy                # 下载缺少，删除多余
                edit                # 编辑go.mod
                graph               # 打印依赖图
                vendor              # 复制依赖到vendor
                verify              # 验证mod
                why                 # 打印依赖原因
# 语法
    包                              # 路径引用，命名空间
        不能循环依赖
        main包                      # 入口包, 产生可执行文件，也可当库导入
            main()                  # 入口函数
        包名最好匹配目录名          # 导入路径的最后一段
        import
            逐行import或import(多行)
            import 别名 包路径
            import "gopkg.in/yaml.v2" 忽略.v2, 包名为yaml
            import _ "image/png" 空导入
            可导入相对目录，以.或..开头
        var和const
            逐行或var(多行), const(多行)
        包文件函数
            init                    # 文件在编译前排序，按依赖顺序和文件名，也是init的调用顺序。init不能调用和引用
        包依赖排序依次初始化
        工作空间
            src
            bin                     # 编译后的执行文件
            pkg                     # 编译后的包, 重复使用加快编译
        vendor目录放本地依赖
        文档注释影响编译
            // +build linux darwin                  # linux和darwin才编译
            // +build ignore                        # 任何时候都不编译
        内部包                      # 路径有internal的包, 只能被父目录导入
            net/http/internal/chunked
    注释
        //或/**/
        package前写文档注释，可出现在任何文件中，但一个包约定一个
        doc.go约定为包的扩展文档注释
    命名
        字母或下划线开头，区分大小写, 不能用关键字
        关键字: break, default, func, interface, select, case, defer, go, map, struct, chan, else
            goto, package, switch, const, fallthrough, if, range, type, continue, for, import, return, var
        首字母大小写决定可见性，大写表示其是导出的
        go倾向短名称, 驼峰式命名, 缩写全大写或小写
    操作符
        优先级:
            * / % << >> & &^    # 可加=, 如*=
            + - | ^             # 可加=, 如*=
            == != < <= > >=     # 基本类型都可比较
            &&
            ||
            + -                 # 一元取正负
        %                       # 只能整数，符号与被除数一致
        /                       # 整数除，去小数部分。溢出高位丢弃
        & | ^ &^                # 按位独立
            &^                  # and not(位清空)右边1清左边为0
            &                   # and
            |                   # or
            ^                   # xor, 前缀表示取反或按位取补(逐位取反)
        << >>                   # 注意，有符号数右移按符号位填补空位
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

        const                   # 编译时计算
            枚举
                type Weekday int
                const (
                    Sunday Weekday = iota               # 值为0
                    Monday
                    ...
                )
                const (
                    i T1 = 1 << iota                    # 值为1, 下值为 1<<1
                    ...
                )
            无类型常量
                只有常量可以无类型
                无类型常量存大数精度高于基本类型, 算术精度高于机器精度, 至少256位
                可用于更多表达式，无需转换类型
                分类
                    布尔: true
                    整数: 0
                    文字符号: '\u0000'
                    浮点数: 0.0
                    复数: 0i
                    字符串: ""
                const (
                    _ = 1 << (10 * iota)             # 下值为 1<<(10*1)
                    ...
                )


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
    指针                         # 不能运算
        &获取地址
        *获取指针
    语句
        变长参数
            f(s...)
        for
            for i, j := 0, 1; i < n; i++ {}
            for i < n {}
            for {}
            for index, value := range slice1{}
            for key, value := range map1 {}
            for range s{}
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

            switch t.(type) {                   # 类型匹配, 无匹配类型会panic, 不能用fallthrough
            case nil:
            case int, uint;
            case bool:
            case string:
            default:
            }
            switch x := x.(type) {}
        select                                  # channel用select, 值用switch。一直等待直到匹配(default会直接匹配)。多情况匹配随机选择。不能用fallthrough
            select {
            case <-ch1:
            case x := <-ch2:
            case ch3 <- y:
            default:
            }

            o-> 超时
            select {
            case <-time.After(10*time.Second):
            case <-ch:
            }

            o-> 自发自接
            for i := 0; i < 10; i++{
                select {
                case x := <-ch:
                case ch <- i:
                }
            }

            o-> 标签
            c := make(chan struct{},2)
            label1:
            for {
                select {
                case c<- struct{}{}:
                    fmt.Println(1)
                case <-c:
                    fmt.Println(2)
                    break                       # 无标签break跳出当前select块
                        # break label
                        # goto label2
                        # return
                default:
                    fmt.Println(3)
                }
            }
            label2:
            ...
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
     函数
        字面量
            var func()                   # 声明
            func f(i int) int {}
            func f(i, j int) (int, error){}
            func f() (r int){}
            func f(vals ...int) {}       # 变长函数, 只放最后, vals是slice
                f(vals...)
        一等公民
        函数签名，即函数类型，包括形参列表和返回列表, 命名不影响
        未定义时为nil, 不可比较
        值传递, 不能指定默认值
        函数返回多值, 可return, 可做传入参数
        返回值有命名，可祼返回(不在return后写参数)
        错误
            v, ok := f()                  # 错误只一种情况
            v, err := f()                 # 错误信息会串联，避免首字母大写和换行
            if err != nil {
                return nil, err
            }
        匿名函数用字面量定义，包含外层词法环境(闭包)
            递归要先声明，再赋值定义
            重定义变量
            for _, dir := range dirs() {
                dir := dir                      # for块作用域变量共享位置，重定义dir每次一个位置
                dirs = append(dirs, func(){     # 匿名函数引用外层变量，却不一定同步执行
                    os.RemoveAll(dir)
                })
            }
    方法
        字面量
            func (t T) f(){}                    # t值传递, 方法名唯一, 方法名不能用字段名
            func (t *T) f(){}                   # t引用传递

            type Path []Point                   # 别名赋方法(不能是指针和接口), 可覆盖原类型方法
            func (p *Path)f(){}
        方法可在任何类型(除指针和接口), 如函数
        变量与变量指针都可直接调方法，编译器隐式取地址或取指针
            P{1}.f()                            # 编译器不报错但运行出错, f()声明成引用传递, 但P{1}.时, 内存地址还未分配, 即还没有*P, 就无法调f()
        有引用传递方法时，避免值传递方法，会产生多例
        值为nil时可调方法
        方法可赋值
            f := t.f
            f(t.f)
        组合
            结构体匿名成员方法可如属性般直接调用
            匿名成员是引用时，多结构体可组合同一成员对象
            多匿名成员方法冲突时，调用时编译报错
            可给未命名结构体加方法
                t = struct{
                    sync.Mutex
                    v int
                }
                t.Lock(); t.v++; t.Unlock()
    接口
        字面量
            type I interface {
                f()
            }
            type I2 interface {                  # 接口组合
                I
            }

            v := t.(T)                           # 断言，失败panic
            v, ok := t.(T)                       # 失败不panic, ok=false
        隐式实现，方法匹配即可(接口即约定)           # 鸭子
        指针方法匹配接口，对接口赋值时要传指针
        interface{}为空接口类型，可赋值任何类型
        实现
            除了接口的定义类型，还包含动态类型(Type) + 动态值(Value)               # 编译时不知道，生成代码在运行时动态分发
                零值，是动态类型和动态值都是nil
                    动态类型是nil, 指的是它为接口本身类型
                    i = nil会设置接口为零值
                ==和!=比较
                    动态值都为nil相等
                    动态类型和动态值都相等，才相等
                        i = new(T); i != nil
                    动态类型一致，动态值不可比较(如slice), 则panic                # 非平凡
                    格式化输出%T拿到动态类型
        断言
            变定义类型, 动态类型和动态值不变
            空接口断言总失败
            断言成接口，使用公共功能
                v := t.(I)
                v.Common()
        风格
            强调功能相似性                         # 子类型多态(subtype polymorphism)
            联合再断言区分                         # 可识别联合(discriminated union), 特设多态(ad hoc polymorhpism)
                switch t.(type) {}
    关键字
        defer fn                                 # 后进先出, return或panic后调用
            defer func(i){...}(1)
            return、出参赋值、defer顺序            # 先赋值，再defer，再return
                func f() (i int) {
                    defer func(){
                        i++
                    }
                    return 0          # 相当于 i=0; i++; return
                }
        go fn
        异常
            panic()
                日志包括值(interface{}), 调用栈
                    用interface{}自定义异常类型
                    runtime.Stack()查看栈，利用defer函数在栈清理前调用, 所以栈存在
                终止当前goroutine, 外层goroutine不捕获
                按函数调用栈依次中止函数并调defer, 最上层后程序异常退出
                panic之后定义的defer不执行(声明不提前)
            recover()
                中止panic
                在defer中(panic时只调defer)捕获panic对象，没有时为nil
                捕获panic对象后, 捕获函数正常返回。要上抛就再手动panic()
            o->
            func Try(fn func(), handler func(interface{})) {
                defer func() {
                    if err := recover(); err != nil {
                        handler(err)
                    }
                }()
                fn()
            }

            func main() {／
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
            比较
                var s []int         # 未初始化比较, ==nil
                s = []int(nil)      # 强转, ==nil
                s = []int{}         # 初始化比较, !=nil
    基本类型
        字面量
            06                      # 8进制
            0x0a                    # 16进制
            .1或1.                   # 小数点前后可省略
            2.2e10                  # 科学计数法
            1 + 2i                  # 复数
            字符串
                "\\"                # 转义
                "\r"                # 光标退到行首
                "\b"                # 光标退一字符
                "\x1a"              # 16进制表示位数据, 必2位，无法识别成unicode
                "\212"              # 8进制表示位数据, 必3位, 无法识别成unicode
                "\u1234"            # unicode, 16进制数字, 共4x4=16位
                "\u12345678"        # unicode, 16进制数字, 共4x8=32位
                ``                  # 原生字符串, 回车被删除(换行符保留)
        注意
            会自动截断，如int i=127; i+1=-128; i*i=1
        int                         # 平台原生整数大小，或该平台运算效率最高值, 多是int32
        int8                        # -128-127
        int16
        int32
        int64
        uint                        # 平台决定大小。无符号极少用于表示非负值，往往用于位运算或特定算术运算符，如位集，解析二进制，散列，加密
        uint8                       # 0-255
        uint16
        uint32
        uint64
        uintptr                     # 存放指针，大小不明确，底层编程
        float32                     # 运算会迅速累积误差, 正整数范围有限
        float64
        complex64                   # float32构成
        complex128                  # float64构成
            var x complex128 = complex(1,2)
            x := 1 + 2i
        bool
        byte                        # uint8别名, 强调是原始数据
        rune                        # int32别名, unicode码点(UTF-8), 下标取字符(非字节)
        string                      # 认为是UTF-8编码的unicode, 不合理字节替换成方块(\uFFFD)。不可变(安全截取、共用), 下标取字节，越界宕机异常
            和数组和slice一样操作
            []byte和string元素操作一致，只类型不同
            互换
                []byte, []rune, string                  # 转换产生副本
        error
    聚合类型
        数组
            字面量
                var q [3]int
                q := [3]int{1,2,3}
                q := [...]int{1,2,3}                        # 长度由元素个数决定
                q := [...]int{0: 1, 3:2}                    # 指定索引元素值
            数组是值传递
            数组元素不可包含自己
            默认元素为零值
            不同长度不同类型，不能赋值
            如果元素可比较，数组就可比较     # 深度比较
                q1 < q2                   # 字符串比较按字节字典排序
        slice
            字面量
                q := []int{1,2,3}                           # 这里创建了slice, 指向了隐式创建的数组
                q[0:1]                                      # 左闭右开
                q[:1]; q[1:]; q[:]
            轻量级数据结构，用来访问数组的部分
            零值是nil, 行为和slice一样，不用特殊判断
            slice后标访问越界时，会自动扩展，越界超过数组长度+1时，会panic
                append(arr[:i], arr[i+1:]...)删除元素, i为最后元素时, i+1不越界
            不可比较, 只有写函数实现。只能和nil比较
                因为slice的元素不是直接的
                    有可能包含它自身
                    同slice不同时间会拥有不同元素
                        如果slice可比较来做map键, map只对key做浅拷贝, slice需要深度比较, 所以要求slice元素不变
            三元素                         # 有自己的属性，不是纯引用类型，是聚合类型
                指针: 指向slice在数组上起始位置
                长度: slice长度
                容量: 指针到数组结尾元素个数
        map                                # key可nil, 取不存在key时, 得到value类型的零值。随机无序遍历
            字面量
                m := map[string]int{
                    "a":1,
                }
                a["b"]=2
            不能获得地址，如&m["a"]          # 因为map增长时，已有元素可能重新散列
            迭代顺序随机                     # key用维护排序, 散列算法健壮
            零值是nil, 向nil map设置元素会panic
            map[key1]没有时，获得零值
                v, ok := m["a"]             # 判断有无key
            不可比较，只能和nil比较
            key要求可比较，可以数组,不可以slice,可以自己映射成可比较类型
                q := [2]int{}
                m := map[[2]int]int{}
                m[q] = 1
        结构体
            字面量
                type T struct {                             # 结构体,
                    Name string `json:"name0,omitempty"`    # 成员标签定义, opmitempty在零值时忽略
                    I1, I2 int
                }

                t := &T{"a"}                                # 顺序易出错, 用于明显的小结构。未指定成员为零值
                t := &T{
                    Name: "a",
                }
                (*t).Name = "a"
                t.Name = "a"                                # .可以用于指针

                struct{}                                    # 空结构体，没有长度，无信息。

                type T1 struct{                             # 匿名成员
                    T
                    T2
                    *T3
                    Name1 string
                }
                t1 := T1{
                    T: {
                        Name: "a"
                    }
                }

            首字母大写可导出
            属性类型不可自己，但可自己指针
            结构体零值由成员零值组成            # 希望结构体方法中处理零值成一个自然的值，如sync.Mutex
            成员可比较，结构体实例可比较, 可作map key
            匿名成员(组合)
                点号访问可跨入(语法糖)，访问匿名成员属性和方法
                    t1.Name; t1.T.Name
                不能有相同类型的匿名成员
                不可导出类型的匿名成员，内部成员不影响，但匿名成员本身不可见
    引用类型
        Type
        IntegerType
        FloatType
        ComplexType

        chan
            ch := make(chan string)

            var cin chan<- string
            var cout <-chan string

            ch <- ""
            <-ch
    接口类型
        error
            Error()
    命名类型
        type
        结构体
            type Point struct {
                X, Y int
            }
    函数
        make()
            make([]int)
            make(map[string]int)
            make(chan int)
        delete()
            delete(m, "a")          # 删除map元素, 没key不报错返回零值
        len()
            len(ch)                 # 当前缓冲个数
        cap()
            cap(ch)                 # 缓冲区容量
        new()                       # 创建指定类型变量，初始化为零值，返回地址。不带任何信息且是零值(struct{}和[0]int)的类型, new出的地址不同(从前相同)
            t := new(T)
        append()                    # 操作slice
            先检查原容量，容量够修改原数组元素，不够创建新数组(容量扩一倍)复制元素, 返回新slice
            所以append()最好赋值给原slice
            s1 := append(s1, s2...)
        copy()                      # slice或string元素复制
        close()                     # channel中用
        complex()                   # 创建复数对象
        real()                      # 获取复数的实部
        imag()                      # 获取复数的虚部
        panic()
        recover()
    反射
        谨慎使用
            脆弱，能导致编译报错的写法，反射中都对应panic，执行时才知道
            降低自动重构和分析工具的安全性与准确度，反射对类型操作无法静态检查
            反射慢1-2个数量级(实测20位左右), 适合测试用，不适合关键路径上用
    unsafe
        值在内存中对齐，计算更高效。结构体用内存间隙来对齐，占空间比元素之和更大
        结构体成员内存中重新排列可省内存，但目前不是
    cgo
        o-> c文件
        #include <bzlib.h>
        int bz2compress(bz_stream *s, int action, char *in, unsigned *inlen, char *out, unsigned *outlen) {...}

        o-> go文件
        /*
        #cgo CFLAGS: -I/usr/include
        #cgo LDFLAGS: -L/usr/lib -lbz2
        #include <bzlib.h>
        int bz2compress(bz_stream *s, int action, char *in, unsigned *inlen, char *out, unsigned *outlen);
        */
        import "C"
        import (
            "io"
            "unsafe"
        )
        type writer struct {
            w io.Writer
            stream *C.bz_stream
            outbuf [64*1024]byte
        }
        func NewWriter(out io.Writer) io.WriteCloser{
            const (
                blockSize = 9
                verbosity = 0
                workFactor = 30
            )
            w := &writer{w: out, stream: C.bz2alloc()}
            C.BZ2_bzCompressInit(w.stream, blockSize, verbosity, workFactor)
            return w
        }
        func (w *writer) Write(data []byte) (int, erro) {
            if w.stream == nil {
                panic("closed")
            }
            var total int
            for len(data) > 0 {
                inlen, outlen := C.uint(len(data)), C.uint(cap(w.outbuf))
                C.bz2compress(w.stream, C.BZ_RUN, (*C.char)(unsafe.Pointer(&data[0])), &inlen, (*C.char)(unsafe.Pointer(&w.outbuf)), &outlen)
                total += int(inlen)
                data = data[inlen:]
                if _, err := w.w.Write(w.outbuf[:outlen]); err != nil {
                    return total, err
                }
            }
            return total, nil
        }

        注释
            #cgo 指令指定C工具链选项
        import "c"
            编译时促使go build用cgo预处理其上注释
            产生临时包包含c函数对应声明
                包含类型，函数，预处理宏对象
                这里用了C.bz_stream和C.BZ2_bzCompressInit
        go也可编译成静态库链接进C, 或编译成动态库通过C加载和共享
# 内部包
    # golang.org/pkg 找到索引
    errors
        New()
    testing
        T
            Error()
            Errorf()
            Fatal()
            Fatalf()
        B
    syscall                 # 执行其它语言
    syscall/js
    js/wasm                 # 1.11, webAssembly
    go/doc
    go/token
    runtime
        Stack()                             # 调用栈
        Gosched()                           # 让出执行权
        Goexit()                            # 终止当前goroutine, 会执行defer
        LockOSThread()                      # 绑定协程到当前线程
        UnlockOSThread()
        GOMAXPROCS()                        # 并发线程数
        NumGoroutine()                      # 限制goroutine数
    runtime/debug
    os
        Stdin                   # 输入流
        Args                    # 运行参数
        FileInfo

        Open()                  # 打开文件
            File
                Read()
                Write()
                Close()
        Exit(1)                 # 1异常退出
        RemoveAll()
        Stat()                  # 文件信息
    os/exec                     # 子进程
    io
        EOF                     # 文件结束标志, 是一个error

        Copy()
        WriteString()
    io/ioutil
        Discard                 # 丢弃

        ReadFile()              # 读整个文件到内存
        ReadAll()
        WriteFile()
        ReadDir()
    bufio                       # 带缓冲io
        NewScanner()
            Scanner             # 以行或单词断开
                Scan()          # 有内容返回true
                Text()
        NewReader()
            ReadRune()
    path                        # 文件路径
        Base()                  # 获得最后文件名
    path/filepath               # 根据平台处理文件路径
    net
        Conn
    net/http
        poolServer(epoll/kqueue/iocp)
            # 支持多核大量并发连接fd
        Get()
            Header
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
    net/http/httputil
    net/url
        QueryEscape()           # url转义
    context                     # 线程安全, 树形结构
        Cancel()
        Deadline(Timeout)
        Value()
        TODO()

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
    flag
        Args                    # 非标识参数
        Parse()                 # 出错调os.Exit(2)

        o-> 输入'-s / a bc', 输出'a/bc'
        sep := flag.Strings("s", " ", "desc s")
        flag.Parse()
        println(strings.Join(flag.Args(), *sep))
    log
        SetPrefix()
        SetFlags()              # 格式标记
        Fatal()                 # 加日期时间前缀
        Fatalf()
    time
        Time
            Format()

        Now()
        Since()
            Seconds()
        After()
        AfterFunc()
        NewTicker()
            ticker := time.NewTicker(1 * time.Second)
            <- ticker.C
            ticker.Stop()
        Tick()
            tick := time.Tick(1 * time.Second)          # 无法中止, 用于全局，否则内部goroutine泄漏
            for {
                <-tick
            }


    fmt                         # string类型会调对象的String()方法
        Stringer                # 接口，有String()方法可匹配

        Printf()                # 可以用转义序列(\t等)表示不可见字符
            %d                  # 十进制整数
            %x, %o, %b          # 十六进制、八进制、二进制整数
                %X
                % x             # 十六进制输出，两数一空格
            %f, %g, %e          # 浮点数6位小数、15位小数并自动精度与表示方式、6位小数e表示
                "%8.3f"         # 输出8字符宽度，保留3位小数
            %t                  # 布尔
            %c                  # unicode字符
            %s                  # 字符串
                %*s             # 缩进后面指定数字个空格
            %q                  # 带引号字符串("abc")，或字符('c')
            %v                  # 内置格式的任何值
                %#v             # 包含结构体成员名字
            %T                  # 类型
            %[1]c               # 重复利用第一个参数
                Printf("%d %[1]c %[1]q", 'a')
            %%                  # %本身
            特殊数字
                var z float64
                fmt.Println(z,-z,1/z,-1/z,z/z)              # "0 -0 +Inf -Inf NaN"
        Fprintf()
        Scanf()                 # 格式化输入
        Errorf()                # 产生一个error
    strconv                     # 类型转换
        ParseFloat()
        ParseInt()
        ParseUint()
        Itoa()                  # 整数转字符串
        FormatInt(int64(1a), 2)
        FormatUint()
    unicode                 # 单符号
        ToUpper()
        ToLower()
        IsDigit()
        IsLetter()
    unicode/utf8            # 逐个处理
        RuneCountInString()                 # 字符数
        DecodeRuneInString()                # 解码, string类型默认调用
    bytes                       # 操作byte数组
        Buffer
            WriteByte()
            WriteRune()
            WriteString()
            String()

        Index()
        Contains()
        Count()
        Fields()
        HasPrefix()
        Join()
        Equal()
    strings                     # 处理UTF-8或位序列
        Index()
        Split()
        HasPrefix()
        HasSuffix()
        Contains()
        Count()
        Fields()
        Join()
    regexp
        MustCompile()           # 检查
        Compile()               # 编译表达式
    text/template
        Must()                  # 检查，有错panic


        o->
        {{.Name}}               # .代表当前值
        {{range .Items}}
            {{.Title | printf "%.64s"}}
            {{.CreateAt | daysAgo}}
        {{end}}
        template.New("report").
            Funcs(template.FuncMap{"daysAgo": daysAgo}).
            Parse(templ)
    text/tabwriter              # 生成表格
        Flush()
    html/template               # 对html, js, css, url中原字符转义, 避免对输出页面注入控制
        Html                    # 字符串转成该类型，受信任，不用转义

        Parse()                 # 解析html
    encoding/json               # unicode
        Marshal()               # 转成json, 不可导出不可见
        MarshalIndent()         # 格式化转成json
        Unmarshal()
        NewDecoder()            # 流式解码
            Decode()
    encoding/xml
    encoding/gob
    encoding/asn1
    compress/gzip               # DEFLATE算法
        NewWriter()
        NewReader()
    compress/bzip2              # Burrows-Wheeler变换, 压缩高，慢


    sort
        IntSlice
            sort.Sort(sort.IntSlice(ints))

        Sort()
        Reverse()
            sort.Sort(sort.Reverse(values))
        IsSorted()
        Strings()
        Ints()
        IntsAreSorted()

        o->
        type StringSlice []string
        func (p StringSlice) Len()int {return len(p)}
        func (p StringSlice) Less(i, j int)bool {return p[i] < p[j]}
        func (p StringSlice) Swap(i, j int) {p[i], p[j] = p[j], p[i]}
        sort.Sort(StringSlice(names))
    math
        Sin()
        NaN()               # 返回NaN, NaN值比较总false(除!=), NaN用作信号量
    math/rand
        Seed(time.Now().UTC().UnixNano())
        Float64()
    math/cmplx              # 复数运算
        Sqrt(-1)            # 0 + 1i
    math/bits
    image
        Rect()
        NewPaletted()
            SetColorIndex()
        Decode()
        Encode()
    image/color
        Color
        White
        Black
    image/gif
        GIF
    image/jpeg              # 空导入注册解码器
    image/png               # 空导入注册解码器


    sync
        Mutex
            Lock()
            Unlock()
        RWMutex
            Lock()
            Unlock()
            RLock()
            RUnlock()
        Once                                # 单例资源初始化，解决了多线程下读检查，防重写的问题
            Do()
        WaitGroup
        Cond
            Wait()                          # 计数加1, 进入阻塞
            Signal()                        # 解除一个阻塞，计数减1
            Broadcast()                     # 解除所有阻塞
        Map
        Pool


    reflect                 # 非导出字段反射可见, 不可更新
        Type                # 类型
            String()        # 类型描述, fmt.Printf()中的"%T" 内部调用
            Field()         # 结构体成员, 返回StructField
                Name
            Method()
        Value               # 值
            String()        # 值描述，如"<int Value>"
            Type()
            Interface()     # 返回接口具体值
                x := v.Interface()
                i := x.(int)
            Kind()          # 得到类型，Bool, String, 各种数字, Array, Struct, Chan, Func, Ptr, Slice, Map, Interface, Invalid(零值), Func
            Index()         # 数组
            NumField()      # 结构体成员数
            FieldByName()
            MapKeys()       # map
            MapIndex()      # map
            IsValid()
            IsNil()         # 指针
            Elem()          # 指针指向元素
            CanAddr()       # 是否可寻址，如指针元素取Elem()的值，数组元素
            Addr()          # 取地址
                v.Addr().Interface().(*int)
            CanSet()        # 检查CanAddr()和是否非导出字段
            Set()           # 要求可寻址, 类型一致。可Set()interface{}类型
                SetInt(), SetUint(), SetString(), SetFloat()            # 相对Set()有容错性,不可SetXx()interface{}类型
                SetMapIndex()
            NumMethod()     # 方法数
            Method()        # 取方法
                Name
            Call()          # 执行Func类型Value
        StructField
            Tag
        StructTag
            Get()           # 字段标签中key的值
        Method

        TypeOf()
        ValueOf()
        Zero()              # 零值
        Append()
        MakeMap()
        New()               # 类型新对象地址
        DeepEqual()         # 深度比较，基本类型用==, 组合类型逐层比较。
            判断武断，不认为值为nil的map和值不为nil的空map相等。slice同理
                var c, d map[string]int = nil, make(map[string]int)
                var a, b []string = nil, []string{}

    unsafe                  # 由编译器实现，暴露了内存布局。
        Pointer             # 任何地址，可比较，可比较nil。无类型向内存写任意值。
            可转成uintptr对地址计算
                问题
                    移动垃圾回收器(目前未用)在移变量时地址改变使地址出错。
                    goroutine增长栈时旧栈地址重新分配
                解决
                    Pointer转uintptr再转回来在一条语句中实现
                应用
                    深度比较时，防止循环引用，每次比较存两个抽象的指针(即Pointer)和类型(y和y[0]地址一样)
            var f float64
            i := *(*uint64)unsafe.Pointer(&f)
        Sizeof()            # 表达式占字节长度, 不计算表达式，由编译器推断
        Alignof             # 报告类型对齐方式
        Offsetof()          # 成员相对起始偏移量, 计算空位
# 外部包
    # godoc.org 搜索
    goimports           # 格式化imports顺序
# 测试
    规则
        文件名以_test.go结尾
        汇报PASS或FAIL, 平均执行时间
        忽略main函数, 当作库测试
            main特权函数 log.Fatal()和os.Exit()会阻止跟踪过程
        包测试循环依赖时，建立外部测试包
            导出内部成员用于测试的后门成员声明，放在export_test.go内
    机制
        扫描*_test.go
        生成临时main包来调用，再编译、运行、汇报, 最后清空临时文件
    Test函数                          # t用于汇报结果和日志
        func TestF(t *testing.T) {}
    benchmark函数                     # 基准测试，性能
        b增加了成员N指定执行次数, 增加了性能检测方法
            开始指定小N, 再推断足够大的N检测稳定运行时间
        基准测试时初始化代码放循环外面，它的执行时间不加到每次迭代时间中。普通Test做不到
        用go test -bench=.运行
            报告中 f-8 1000000 1035 ns/op 分别代表GOMAXPROCS=8, 执行100000次，平均每次1035ns

        o-> 基本使用
        func BenchmarkF(b *testing.B) {
            for i := 0; i < b.N; i++{
                f()
            }
        }
        o-> 相对比较, 如数量级、找最佳缓冲区大小、选算法策略
        func benchmark(b *testing.B, size int){}
        func Benchmark10(b *testing.B) {benchmark(b, 10)}
        func Benchmark100(b *testing.B) {benchmark(b, 100)}
    Example函数                       # 示例，无参无结果。
        用处
            可举例子作为文档
            结尾注释 // output: 验证终端输出
            实验代码
        func ExampleF()  {
            fmt.Print("a")
            // output: aa
        }
# 并发编程
    同步
        func
        channel                                 # 和调度器深度关联，控制goroutine的阻塞和唤醒
            缓冲区
                作用
                    异步
                        发送接收解耦
                        让数据可并行处理(计数信号量)
                        消除goroutine间速率差异(速率大致相同, 某刻休息)
                            上下游速率差异大时无作用
                    阻塞时同步
                c := make(chan struct{})
                c1 := make(chan struct{}, 1)
                c ← struct{}{}                  # 阻塞
                ← c                             # 阻塞

                c1 ← struct{}{}                 # 不阻塞
                c1 ← struct{}{}                 # 阻塞
                ← c1                            # 不阻塞
                ← c1                            # 阻塞
            方向
                var c chan struct{}             # in和out
                var cin <-chan struct{}         # in, 关闭时panic
                    v := <-cin
                var cout chan<- struct{}        # out
                    cout <- v

                cin = c
                cout = c
                c = cin                         # 编译错误
                c = cout                        # 编译错误
            nil                                 # 永远阻塞, 用于开启禁用情况
                var c chan struct{}
                c <- struct{}{}                 # 阻塞
            关闭                                 # 关闭不是必须的，不影响回收。只是用来通知和广播
                c := make(chan struct{})
                close(c)                        # 再关闭panic
                c ← struct{}{}                  # panic
                o, ok := ← c                    # o得到零值, ok是false
        for range
            c := make(chan struct{})
            ...
            for x := range c {}                 # close(c)时break
        select

        sync包
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
                fmt.Println("wait", i)          # 业务预处理
                wg.Done()
                cond.Wait()                     # 阻塞
                fmt.Println("done", i)          # 业务后续处理(要求所有业务预处理过)
                cond.L.Unlock()
            }(i)
        }
        wg.Wait()                               # 业务预处理完成

        cond.L.Lock()
        cond.Broadcast()                        # 处理业务后续
        cond.L.Unlock()
        wg1.Wait()                              # goroutine完成
    异步
        语句
            语句是串行一致的(sequentially consistent)
            串行一致基础上，语句会重排, 重排中可能穿插执行其它goroutine语句
                t := map[string]int{
                    "a": 1
                    "b": 2
                }
                重排为
                t := make(map[string]int)
                t["a"]=1
                t["b"]=2
        goroutine
            语句
                go f()
            泄漏
                阻塞不能自动结束                  # 如操作channel时
                main中最后调panic(), 从崩溃转储信息判断资源释放情况
            死锁(deadlock)                      # 指没有可调度的goroutine
                所有goroutine阻塞或没有goroutine
            运行main的是主goroutine, main返回所有goroutine暴力终结
            无id(标识)
            不能中断
            无返回值
        runtime
        context
        time
    并发模式                                    # 避免goroutine泄漏，保证通信顺序
        done/quit
            o-> done控制goroutine退出。         # 更快的响应要写更多的逻辑入侵，找到响应慢点写done逻辑
            func f(done <-chan struct{}) {
                select {
                case <-done:
                    for range ch{              # 耗尽通道, 其它goroutine不会卡在ch<-上而退出
                    }
                    return
                }
            }
            func cancelled()bool{
                select {
                case <-done:
                    return true
                default:
                    return false
                }
            }
            func f2(){                          # 轮循函数中入口检查, 避免创建新goroutine
                if cancelled() {
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
        pipeline(fan-in, fan-out)           # 传入传出channel来处理
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
        控制并发数
            并发写缓冲区channel
            for循环产生并发数goroutine
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
        o-> cannot detect vcs
            glide.lock或vendor依赖旧版本
                清理glide.lock和vendor, 检查glide.yaml旧版本
            glide.yaml子目录处理不完善
                subpackages:
                - cloudsql
            glide mirror找不到包
                glide mirror set a a --vcs git
                    # 改~/.glide/mirrors.yaml文件
        o-> does not appear to be a git repository
            加速服务没有项目
        o-> glide up依赖不是最新
            ~/.glide/cache中缓存了旧版本
        o-> cannot find package "." in
            glide对非git协议自有域名处理歧义，子目录分析不准确
                清理缓存
                    ~/.glide/cache/src/包名
                    ~/.glide/cache/info/包名
                glide.yaml添加repo重定向及subpackages
                    package: github.com/grpc-ecosystem/grpc-gateway
                    repo: git@github.com:grpc-ecosystem/grpc-gateway.git
                    subpackages:
                    - internal
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
