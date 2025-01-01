---
weight: 4
Categories: ["语言"]
title: 程序语言
type: docs
---

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
            php, php-cgi, php-fpm
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
            # php fastCGI 进程管理器
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
# D
    # 并发
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
    语法
        表达式
            actor1 ! case1          # 异步消息
            actor1 !? case1         # 同步消息, 需要对方一定返回
            actor1 !! case1         # 异步消息, 需要对方一定返回
        Actor
            o->
            import scala.actors.Actor

            class HelloActor extends Actor {
            def act() {
                while (true) {
                receive {
                    case name: String => println("Hello, " + name)
                }
                }
            }
            }

            val helloActor = new HelloActor
            helloActor.start()
            helloActor ! "leo"
        case                        # 模式匹配
            case class Login(username: String, password: String)
            class UserManageActor extends Actor {
            def act() {
                while (true) {
                receive {
                    case Login(username, password) => println(username + password)
                }
                }
            }
            }
            val userManageActor = new UserManageActor
            userManageActor.start()
            userManageActor ! Login("leo", "1234")
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