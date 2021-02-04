---
title: 程序调试
type: docs
---
# 分析方向
## cpu
    方法调用
        调用栈时长比例
        录制时间内调用栈时长
    火焰图(graph frames)
        宽度: 方法耗时
        高度: 调用栈深
        排序是按字母的，颜色是随机的
    subsecond offset heat map
        x轴: 秒
        y轴: 一秒内各阶段
        z轴: 颜色深度标记events采样数
## 内存
    对象
        对象个数、空间比例
        调用栈分配比例
## 线程/协程
    泄露
        I/O阻塞
        锁阻塞
        channel阻塞
## GC问题
    少建对象
# Linux
    time
    ftrace
    perf_events
    eBPF
    SystemTap
    LTTng
    ktap
    dtrace4linux
    OEL DTrace
    sysdig
# Java
### VisualVM
### JProfiler
    # 收费, java
### perfino
    # 监测jvm
### YourKit
    # 收费, java, 有调用链
### Spring Insight
    # java spring
# Golang
    go命令
        go tool pprof Xx.bin Xx.prof
            -inuse_space                # -inuse_space显示真正使用的内存
            -cpuprofile=cpu.prof
            -memprofile=mem.prof
            -blockprofile=block.prof
            -svg                        # 输出svg

        go build
            -toolexec="/usr/bin/time"   # -toolexec在每个命令加上前缀
            -toolexec="perf stat"
            -gcflags='-memprofile=m.p'
            -gcflags='-traceprofile=t.p'

        go test
            -blockprofile=b.p net/http
            -trace=t.p
        go tool trace Xx.bin t.p
        go-torch cpu.prof
   环境变量
        GODEBUG=gctrace=1
            # 打印gc信息 
   http 
        import _ "net/http/pprof"
        func main() {
            log.Println(http.ListenAndServe("localhost:3999", nil))
        }

        go tool pprof http://localhost:3999/debug/pprof/profile
        go tool pprof http://localhost:3999/debug/pprof/heap
        go tool pprof http://localhost:3999/debug/pprof/block
## pprof