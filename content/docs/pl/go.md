---
Categories: ["语言"]
title: "Go"
date: 2018-10-09T16:10:44+08:00
---

# 特点
        原生支持并发，编译执行的类脚本语言
        不支持动态库，不支持重载，不支持泛型，有怪异的正则
# 命令
    godoc
            -http=:6060
                    # 运行本地帮助网站
    go
            build
                    # 编译代码包
            install
                    # 编译安装
            get
                    # 下载依赖
                    # 默认目录是GOPATH下的pkg
                    -u
                            # update
                    -v
            clean
                    # 清理build产生的文件
                    -c
                            # 清理.test文件
                    -i
                            # 清理生成的可执行文件
                    -r
                            # 包括依赖包的结果文件
            run
                    # 编译并运行
            list
                    # 列出指定代码包的信息
            fix
                    # 升级旧代码成新版本代码
            vet
                    # 检查静态错误
            test
                    # go test -cover -args -config config_it.toml -test.run "TestA"
                    # 执行当前目录下所有_test.go结尾的文件
                    -file
                            # 可省略，测试单个文件, 如go test test_a.go a.go a.pb.go
                            ## 测试单个文件需要引入原文件
                    -args
                            # 运行时参数
                    -run TestFoo
                            # 测单个方法，名字正则匹配，如^TestFoo
                    -v
                            # 也显示非错误信息
                    -bench=".*"
                            # 指定运行的用例
                    -cpuprofile=cpu.prof
                            # 生成cpu profile文件
                    -c
                            # 生成可执行的二进制文件，名为x.test，它用来生成状态图
                    
            tool
                    pprof
                            # 交互式访问概要文件
                            x.test cpu.prof
                                    # 用性能测试生成cpu状态图
                    fix
                            # 同go fix
                    vet
                            # 同go vet
                    cgo
                            # 生成能够调用c语言代码的go源码文件
            doc
            env
                    # 打印go环境信息
# 配置
    GOROOT
            # go安装目录
    GOPATH
            # 包目录
            # 默认要有go的bin目录
    GOBIN
            # 当前bin目录
    GO15VENDOREXPERIMENT
            # 依赖目录
# 语法
    min, max := 0, 100
            # 自动引申变量类型
    var s string
## 函数
    defer fn
    go fn
    New
## 包
    函数
        init
        main
## 内置
    内置常量
            true
            false
    内置函数
            append
            cap
            close
                    # channel中用
            complex
            copy
            delete
            imag
            len
            make
            new
            panic
            real
            recover
    内置类型
            ComplexType
            FloatType
            IntegerType
            Type
            Type1
            bool
            byte
            complex128
            complex64
            error
            float32
            float64
            int
            int16
            int32
            int64
            int8
            rune
                    # int32别名
            string
            uint
            uint16
            uint32
            uint64
            uint8
            uintptr
## 异常
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
# 包
    fmt
    bytes
    net
        http
    time
    template
    regexp
    gob
    json
    errors
        New
    flag
    testing
    log
    reflect
# 测试
    规则
            文件名以_test.go结尾
            函数以Test开头
            benchmark测试以Benchmark开头
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
    结构
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
    godev
    gv
    gvt
## gvm
    命令
            gvm
                    install go1.5
                    use go1.5
                    list
                    listall
                    implode
                            # 删除所有go版本和gvm本身
## gore
    介绍
            go repl
