---
Categories: ["语言"]
title: 程序语言
type: docs
---
# 原理
    gc
        分类
            mark-and-sweep
            reference-counting
            arc
                # automatic reference counting
# 编译
    # 流程
        词法分析，语法分析，语义分析，中间代码生成，中间代码优化，目标代码生成，表格管理，错误处理
        语义分析 -> 类型检查/推导 -> 代码优化 -> 机器码生成
                # 中间数据结构, 比如AST
        预处理，连接程序，装入程序，调试程序

    # 文法
        G = (Vn, Vt, S, P)
                # 终极符号, 非终级符号, 一个特殊非终级符号，产生式
        类型
                短语(0), 对应图灵机(TM)
                上下文相关(1), 对应线性有界自动机(LBA)
                上下文无关(2), 对应下推自动机(PDA)
                线性文法、正则文法、正规文法，对应有限自动机(FA)
                        # 无法控制自返数
    # 状态机(FA)
        确定状态机(DFA)
        非确定状态机(NFA)
                # 同状态可多种转移
        DFA与NFA互相转换
    # 词法分析
        状态转换矩阵法
    # 语法分析
        自顶向下
                # 最左推导建立语法树
                # first集，follow集，predict集
                不回溯方法
                递归下降
                LL(1)
                        # 从左输入符号、产生左推导、每次读一个字符。LL(k)特例
        自底向上
                # 从左读, 从右向前归约
                简单优先关系
                        # 运算符优先关系矩阵
                LR(k)
                        # 从左输入，最右推导
                        LR(0)
                                # 只看栈顶状态，有分析动作冲突
                        SLR(1)
                                # LR(0)加向前看展望符，不能分析所有文法
                        LR(1)
                                # LR(0)的每个推导加一个向前搜索符，状态太多
                        LALR(1)
                                # LR(1)中同向前搜索符的状态合并
    # 语义分析
        抽象语法树
        符号表
                # 动态规划记录变量的综合信息
        局部化处理
                # 压栈变量作用域
    # 中间代码生成
        后缀式(逆波兰式)
        三地址
                # 操作符两变量地址，结果地址
        四元式操作符
                # 地址加，赋值，过程调用，类型转换，算术、逻辑、关系运算的存储
        语法制导
                # 中间代码产生式后拼上语义程序，在语法分析中遇到动作马上处理
        类型检查
        下标变量
                # 如数组下标，同上全用四元式表示
    # 中间代码优化
        常量表达式
                a = 1, b = 2, c = a + b, 则只记c = 3
        公共表达式
                a = b * c, d = b * c, 则只记a
        循环不变式外提
                while k < 0 do b * c, 则b * c外提只计算一次
        基本块
                # 一块语句要么全执行，要么全不执行
        消减运算强度
                如加法代替乘法
        复写传播
                a = b, 后a, b不再变值，用a替代b
        无用代码消除
        数学优化（恒等变换）
                如a + 0 = a, a * 1 = a, a ^ 2 = a * a, a / 1 = a, 0 / a = 0
        窥孔优化
                对目标代码中短指令序列局部改进，如删除重复，控制流优化，代数化简，使用特殊指令等
        全局优化
                对整个程序控制流和数据分析再优化，如常量表达式全局优化
    # 运行时时空管理
        内存划分
                存储
                        引用的库的代码
                        目标代码
                        静态变量
                        栈区
                                # 函数调用，中断现场
                        堆区
                存储策略
                        静态分配
                                #编译时分配固定存储单元
                        动态分配
                                栈
                                堆
                活动记录
                        保存局部变量，中间结果，临时变量，过程调用，控制信息等
                        专用寄存器
                        调用链
                                # 保存下一个调用的起始地址
                        动态链
                                # 保存前一个调用的起始地址
                访问环境
                        # 记录闭包起始地址
                        display表
                                # 过程需要的所有非局部数据所在的过程活动记录的起始地址
                        全局display表
                        静态链
                                # 指向外层过程的活动记录的地址地址
    # 目标代码生成
        生成的语言
                机器语言
                可重定位的机器语言
                        # 由连接器装配后生成机器语言
                        # 多数用这种，如c语言
                汇编语言
        指令选择
        虚拟机
        寄存器分配
        四元式翻译

# c
    库
        libvirt
# c++
    问题
        野指针、迷途指针 Double Free问题
        智能指针
        RAII资源获取就是初始化
        二级指针
    库
        opencv
                iplimage
                        # 图像处理
# php

    安装
            php, php-cgi
        编译安装
            yum install libxml2-devel  openssl-devel  bzip2-devel libmcrypt-devel  -y
            ./configure --prefix=/opt/zly/php --with-mysql=mysqlnd --with-openssl --with-mysqli=mysqlnd --enable-mbstring --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml  --enable-sockets --enable-fpm --with-mcrypt  --with-config-file-path=/etc --with-config-file-scan-dir=/etc/php.d --with-bz2
            make
            make install
            cp php.ini-production /etc/php.ini
            cp sapi/fpm/init.d.php-fpm /etc/rc.d/init.d/php-fpm
            chmod +x /etc/rc.d/init.d/php-fpm
            cp /opt/zly/php/etc/php-fpm.conf.default /opt/zly/php/etc/php-fpm.conf
            chkconfig --add php-fpm
            chkconfig php-fpm on
            /etc/init.d/php-fpm start
    命令
            php -S localhost:8000 -t dir/
    配置
            /etc/php/php.ini
            date.timezone = Europe/Berlin
                    # 时区设置
            display_errors = On


    框架
        zend opcache
            # php5.5集成，把php执行后的数据缓冲到内存中从而避免重复编译
    工具
        fpm
            介绍
                php fastCGI 进程管理器
# scheme
    # 特点
        词法定界(Lexical Scoping)
        动态类型(Dynamic Typing)
        良好的可扩展性
        尾递归(Tail Recursive)
        函数作为值返回
        计算连续
        传值调用(passing-by-value)
        算术运算相对独立
    # 标准
        R5RS (Revised5 Report on the Algorithmic Language Scheme)
        Guile (GNU's extension language)
    # guile脚本中(.scm)
        #! /usr/local/bin/guile -s
        !#

    # 语法
        注释
            ;
                    # 注释到行尾
            #! ... !#
                    # 标准中没有，实现中有的多行注释
        类型
            1
            'symbol
            "str"
            true, false
            struct
            empty
                # 表示一个空表
        块(form)
            (define x 123)
            (set! x "abc")
            (+ 1 2)
            (* (+ 2 (* 3 4)) (+ 5 6 7))
            (display "hello world")
            (not #f)
                # #t
            (not #t)
                # #f
                # not 后不是逻辑型，都返回#f

        非精确数
            (- #i1.0 #i0.9)
        函数
            or
            and
            not
            (sqrt A)
            (expt A B)
                # A^B
            (remainder A B)
                # A%B
            (log A)
                # A的自然对数
            (sin A)
            (cond
                [(< n 10) 5.0]
                [else .06])
            (if (< x 0)
                (- x)
                x)
            (symbol=? 'Hello x)
                # 符号，比较。符号还有字符串和图像
            (string=? "the dog" x)
                # 字符串，系统看作符号
            (make-posn 3 4)
                # 创建posn结构体
                (poson-x (make-posn 7 0))
                    # 7
            (define-struct posn (x y))
                # 定义结构体
            (number?)
            (boolean?)
            (struct?)
            (zero?)
            (posn?)
                # 可以是自定义结构体名
            (null?)
                # 检查是否空list
            (eq? i list)
                # 元素i是否在list中， 否返回false, 是返回所在的子表
                # 可以比较符号
            (memq)
                # eq?的内部调用
            (error ''checked-number "number expected")
                # 马上出错
            (cons 'Mercury empty)
                # push
                (cons? alon)
                    # 是否有元素
                (define x (cons 1 2))
                    # 序对, 可嵌套
                    (car x)
                        # 1
                    (cdr x)
                        # 2
            (define (dispatch m)
                # 传0返回x, 传1返回y
                (cond ((= m 0) x)
                    ((= m 1) y)
                    (else (error "" m))))
            (first)
            (rest)
            (list (list 'bob 0 'a) (list 'car1 1 'a))
            (local)
                # 局部定义使用
            (lambda)
                # 匿名函数
            (append)
            (set! x 5)
    # 例子
        复合数据
            (define-struct student (last first teacher))
            (define (subst-teacher a-student a-teacher)
                (cond
                    [(symbol=? (student-teacher a-student) 'Fritz)
                        # 如果教师的名字是'Fritz
                        (make-student (student-last a-student)
                            # 创建student结构体，设置新教师名
                            (student-first a-student)
                            a-teacher)]
                    [else a-student]))
        递归列表
            (define (contains-doll? a-list-of-symbols)
                (cond
                    [(empty? a-list-of-symbols) false]
                    [else (cond
                        [(symbol=? (first a-list-of-symbols) 'doll) true]
                        [else (contains-doll? (rest a-list-of-symbols))])]))
        排序
            (define (sort alon)
                (cond
                    [(empty? alon) empty]
                    [(cons? alon) (insert (first alon) (sort (rest alon)))]))
            (define (insert n alon)
                (cond
                    [(empty? alon) (cons n empty)]
                    [else (cond
                        [(>= n (first alon)) (cons n alon)]
                        [(< n (first alon)) (cons (first alon) (insert n (rest alon)))])]))
        or函数
            (define (blue-eyed-ancestor? a-ftree)
                (cond
                    [(empty? a-ftree) false]
                    [else (or (symbol=? (child-eyes a-ftree) 'blue)
                        (or (blue-eyed-ancestor? (child-father a-ftree))
                            (blue-eyed-ancestor? (child-mother a-ftree))))]))
        列表替换
            (define (replace-eol-with alon1 alon2)
                (cond
                    ((empty? alon1) alon2)
                    (else (cons (first alon1) (replace-eol-with (rest alon1) alon2)))))
        列表相等
            (define (list=? a-list another-list)
                (cond
                    [(empty? a-list) (empty? another-list)]
                    [(cons? a-list)
                        (and (cons? another-list)
                            (and (= (first a-list) (first another-list))
                                (list=? (rest a-list) (rest another-list))))]))
        匿名函数
            (define (find aloir t)
                (filter1 (local ((define (eq-ir? ir p)
                    (symbol=? (ir-name ir) p)))
                        eq-ir?)
                    aloir t))
            (lambda (ir p) (symbol=? (ir-name ir) p))
        快速排序
            (define (quick-sort alon)
                (cond
                    [(empty? alon) empty]
                    [else (append
                        (quick-sort (smaller-items alon (first alon)))
                        (list (first alon))
                        (quick-sort (larger-items alon (first alon))))]))
            (define (larger-items alon threshold)
                (cond
                    [(empty? alon) empty]
                    [else (if (> (first alon) threshold)
                        (cons (first alon) (larger-items (rest alon) threshold))
                        (larger-items (rest alon) threshold))]))
            (define (smaller-items alon threshold)
                (cond
                    [(empty? alon) empty]
                    [else (if (< (first alon) threshold)
                        (cons (first alon) (smaller-items (rest alon) threshold))
                        (smaller-items (rest alon) threshold))]))
# erlang
    特点
        由爱立信所辖CS-Lab开发，目的是创造一种可以应对大规模并发活动的编程语言。易于编写分布式应用。
        面向并发(concurrent-oriented)
                在语言中定义了erlang进程的概念和行为，使它特别经量级(309字节)，创建和结束一个进程时间为1-3ms
                该进程(绿进程)在rlang虚拟机内管理和高度，是用户态进程
                进程堆栈占用233字节
                erlang虚拟机支持几十万甚至更多进程
        结构化，动态，函数式
# lisp
    介绍
        为人工智能开发的函数语言
        目前最主要两大方言为scheme和commonLisp。Emacs扩展语言为Lisp，有一种Emacs Lisp语言
        拥有理论上最高的运算能力

    编译器
        sbcl
                # steel bank common lisp
# lua
    介绍
        lua语言，来实现逻辑。 c/c++来实现功能
        eclipse ldt 来开发（cdt 再安装 ldt 使用更方便）
    使用
        lua Hello.lua                # 执行脚本
        luac Hello.lua                # 编译字节码
        #-> lua luac.out
    语法
        --                # 注释
        num = 10                # 定义

# perl
    标准
        pcre: Perl Compatible Regular Expressions

# prolog
    介绍
        programming in logic缩写， 是一种逻辑编程语言。广泛应用于人工智能
        不是真正意义上的程序，运行步骤由计算机决定。没有if, when, case, for这样的控制流程语句
        很难分清哪些是程序，哪些是数据，程序就是数据，是一个智能数据库
        有强大的递归功能。
# R
    介绍
        本身是GNU的一个开源软件
        用于统计分析、绘图
        是S语言的一个分支(实现)
    特点
        数据存储和处理
        数组运算(向量、矩阵运算强大)
# ruby
    工具
        gems
            gem update --system
# rust
    介绍
        mozilla开发的,注重安全, 性能, 并发的系统编程语言
        js之父Brendan Eich设计
# scala
    介绍
        haskell衍生语言
        集成了面向对象和函数语言的特性
        可以很简单地与已有的java代码交互，只需要反java相关类导入就可以了
        面向对象语言同时结合命令式和函数式编程风格
    工具
        sbt
            simple build tool

# .net
# objective-c
# swift
# groovy
        # 基于jvm，结合python, ruby, smalltalk的特性
# dart
        # 谷歌发布的基于javascript的编程语言
# hack
        # facebook开发的基于HHVM，可与PHP无缝对接
        特点
                结合了PHP开发高效性同时，有了静态语言的报错特性
                支持lambda表达式和强制返回等流行特性
# roy
        # 可编译到js
# elm
        # 可编译到js
# jujia
        # 动态语言，用于科学和数值计算
# Fortran
        # 最早出现的高级语言，用于工程计算领域
# ML
        # meta language, 非纯函数式编程,允许副作用和指令式编程
# OCaml
        # 在caml上加上oo, 源于ML
# simula
        # 专注于仿真的语言，由类创建的对象会在协调的多线程模式下，像erlang的进程一样并行处理