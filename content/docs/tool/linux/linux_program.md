---
Categories: ["系统编程"]
title: "LinuxProgram"
date: 2018-10-11T18:47:57+08:00
---

# 系统编程
## 进程通信
    对象
        ipc
    种类
        消息队列
        共享内存
        信号量
    消息队列
## 错误处理
    curedump机制, 产生core文件
    命令
        ulimit
    目录
        /proc/[pid]/
## fork
    介绍
        子线程
## epoll
    介绍
        多路复用io接口，提高大量并发连接中只有少量活跃情况下系统cpu利用率
## signals
    介绍
        unix系统中出错时显示的错误码（通常是拼在最后）
        http://people.cs.pitt.edu/~alanjawi/cs449/code/shell/UnixSignals.htm
    SIGHUP	1	Exit	Hangup
    SIGINT	2	Exit	Interrupt
    SIGQUIT	3	Core	Quit
    SIGILL	4	Core	Illegal Instruction
    SIGTRAP	5	Core	Trace/Breakpoint Trap
    SIGABRT	6	Core	Abort
    SIGEMT	7	Core	Emulation Trap
    SIGFPE	8	Core	Arithmetic Exception
    SIGKILL	9	Exit	Killed
    SIGBUS	10	Core	Bus Error
    SIGSEGV	11	Core	Segmentation Fault
    SIGSYS	12	Core	Bad System Call
    SIGPIPE	13	Exit	Broken Pipe
    SIGALRM	14	Exit	Alarm Clock
    SIGTERM	15	Exit	Terminated
    SIGUSR1	16	Exit	User Signal 1
    SIGUSR2	17	Exit	User Signal 2
    SIGCHLD	18	Ignore	Child Status
    SIGPWR	19	Ignore	Power Fail/Restart
    SIGWINCH	20	Ignore	Window Size Change
    SIGURG	21	Ignore	Urgent Socket Condition
    SIGPOLL	22	Ignore	Socket I/O Possible
    SIGSTOP	23	Stop	Stopped (signal)
    SIGTSTP	24	Stop	Stopped (user)
    SIGCONT	25	Ignore	Continued
    SIGTTIN	26	Stop	Stopped (tty input)
    SIGTTOU	27	Stop	Stopped (tty output)
    SIGVTALRM	28	Exit	Virtual Timer Expired
    SIGPROF	29	Exit	Profiling Timer Expired
    SIGXCPU	30	Core	CPU time limit exceeded
    SIGXFSZ	31	Core	File size limit exceeded
    SIGWAITING	32	Ignore	All LWPs blocked
    SIGLWP	33	Ignore	Virtual Interprocessor Interrupt for Threads Library
    SIGAIO	34	Ignore	Asynchronous I/O
## pf-kernel
    介绍
        是linux kernel 的fork, pf代表post-factum, 是作者的nickname
## libev
    libevent
        介绍
            是linux kernel 的fork, pf代表post-factum, 是作者的nickname