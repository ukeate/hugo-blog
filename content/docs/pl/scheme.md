---
Categories: ["语言"]
title: "Scheme"
date: 2018-10-09T16:03:20+08:00
---

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