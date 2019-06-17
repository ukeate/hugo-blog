---
Categories: ["语言"]
title: "Python"
date: 2018-10-09T16:05:05+08:00
---

# 介绍
        虚拟机语言
        虽然是脚本语言，可以预编译成pyc文件来执行

# shell
        #! /usr/bin/python
        # -*- coding: utf8 -*- 
# 语法
    规范
            pep8

## 内置函数
    o->
            input("")
                    # x = int(input("Please enter an integer:"))
            print("%s", % s1)
                    ## %.3s % ("abcdef")取3字符
                    ## %.* s % (2, "abcd")取2字符)
            # %r repr()显示字符串
                    # %c 单个字符
                    # %b 二进制整数
                    # %x 十六进制整数
                    # %d 十进制整数
                    # %i 十进制整数
                    # %o 八进制整数
                    # %e %E 指数(基底分别为e E)
                    # %-10.3f %-10.3F 浮点数
                    ## 10位宽, 小数精确3位, 右对齐
                    # %g %G 指数(e E)或浮点数(根据显示长度决定)
                    # %% 字符%
                    print("c is %s, e is %i" % (c, e)
            str(1)
            int("1")
            range(1, 10)
                    # range(-2, -11, -3)
            exec('')
                    # 执行字符串中的代码
            execfile(r'a.py')
            eval('2 * 3', globals, locals)
                    # 执行字符串中的表达式
                    # ast.literal_eval
            compile(str, filename, kind)
                    # 编译字符串为模块
                    # kind取值: single单语句, exec多语句, eval一个表达式
            assert 1 != 1
            repr(list)
                    # 对象转换成代码字符串　
            map(str, range(100))
            filter()
            reduce()
            locals()
                    # 当前作用域的变量字典
            isinstance(value, list)
            hasattr(obj, '__call__')
                    # 判断是否函数
            type(l)
                    # 返回对象类型，或创建metaclass
            chr(48)
                    # 返回字符
            unichr
            ord('0')
                    # 返回ascii码
            bool()
            iter()
            next()
            zip('abc', '123')
                    list(zip())
    o-> 文件
            spath = "D:/a.txt"
            f = open(spath, "w")
                    # 没有时创建
            f.write("a\n")
            f.writelines("b")
            f.close()

            f = open(spath, "r")
            for line in f:
                    print("%s" % line)
            f.readline()
            f.close()
    o-> 文档
            dir(list)
            help(s.replace)
## 类型
    o-> 基本类型
            数字
                    1.2, 3+4j, Decimal, Fraction
            字符串


            列表
                    [1, 2]
            字典
                    {'a':1}
            元组
                    (1)
            文件
                    open('eggs', 'r')
            集合
                    {'a'}
            其他类型
                    类型, None, False, True
            编程单元
                    函数, 模块, 类
            实现相关类型
                    编译代码堆栈跟踪
                    
    o-> 扩展属性
            dict = type('dict', (dict,), {})
            d = dict()
            d.a = 1

    o-> 序列
            [1,
            2]
            [1, [2]]

            len(l)
            l[0]
            l[-1]
            l[1:3]
            l[1:]
            l[:3]
            l[:-1]
            l[:]
            
            l + l
            l * 2
            del l[1:3]
            o-> 字符串
                    # 不可变
                    r'a' R'a' u'a' U'a' b'a' B'a' 
                    'abc\
                    def'
                    'a' 'b'
                    'a' "a" '''a''' """a"""

                    s.startswith('a')
                    s.find('a')
                    s.replace('a', 'A')
                    s.split(',')
                    s.join(list)
                    s.upper()
                    s.isalpha()
                    s.isdigit()
                    s.rstrip()
                            # 去右侧空白
                    '%s, %s' % ('a', 'b')
                    '{0},{1}'.format('a', 'b')

                    if 'a' in name:
            o-> 列表
                    l.append('h')
                    l.pop(2)
                            # 弹出特定位置
                    l.sort()
                    l.reverse()
                            
                    print(l)

                    for x in word:

                    [2 * i for i in [2,3,4] if i > 2]
                            # 列表解析
                            [row[1] + 1 for row in M]
                            [M[i][i] for i in [0, 1, 2]]
                            {ord(x) for x in 'spaam'}
                                    # 创建集合
                            {x: ord(x) for x in 'spaam'}
                                    # 创建字典
            o-> 元组
                    # 不可变
                    ('a', 'b')
                    (1,) + (2,)
                            # (1, 2)
                    t.index('c')
                    t.count('c')
            o-> set
                    s = set('a')
                    set([1])
                    s.add(2)

                    s1, s2
                    s1 & s2
                    s1 | s2
                    s1 - s2
                    {x ** 2 for x in [1,2,3,4]}
                            # 返回set

    o-> 字典
            d = {'a': 'aaa', 'b': 'bbb', 'c': 12}
            d['d'] = 3
                    
            d.items()
                    # key value
            d.keys()
                    list(d.keys())
                    
            len(d)
            del d['a']
            d.get('a', 0)
            d['a']

            for key in d:
            if 'a' in d:
            d['a'] if 'a' in d else 0
    o-> 文件
            f = open('data.txt', 'w')
            f.write('a')
            f.close()

            text = f.read()
                    text.split()
## 语句
    o-> 语句
            在物理行中用分号划分逻辑行
            pass
    o-> 运算符
            + - * / % << >> < > <= >= == !=
            & | ^ ~
                    # 按位与 或 异或 翻转(x 变为 -(x + 1))
            not and or
            **
                    # 幂
            //
                    # 取整除
            code if None else 0
            True and 1 or 0
    o-> 条件
            if x < 0:
                    x = 0
            elif x == 0:
            else:

    o-> 循环
            for x in a:
            else:

            while running:
            else:
## 函数
    函数
            def sum(a, b=2, *args, **kwargs):
                    # *args得到元组, kwargs得到字典
                    ''' doc 
                string'''
        
                global x
                nonlocal y
                return a + b
            sum(a=1)
            sum.__doc__
                    
            def make_repeater(n):
                    return lambda s: s * n
                            # lambda只能跟表达式，返回一个函数
    生成器
            def gn2():
                    yield
            def gn(N):
                    for i in range(N):
                            yield i ** 2
                    yield from gn2()
                            # 相当于静态引入gn2
            g = gn()
            next(g)
            g.send(1)
    asyncio模块
            @asyncio.coroutine
            def f():
                    yield from asyncio.sleep(1)
            loop = asyncio.get_event_loop()
            tasks = [asyncio.async(f())]
            loop.run_until_complete(asyncio.wait(tasks))
            loop.close()
    协程
            @types.coroutine
            def f2():
                    yield

            async def f():
                    print(1)
                    await f2()
                            # 协程显式交替，线程不用写，会隐式交替

            try:
                    f().send(None)
            except StopIteration:
                    pass
    协程asyncio
            async f():
                    await asyncio.sleep(1)
            loop = asyncio.get_event_loop()
            tasks = [asyncio.ensure_future(f())]
            loop.run_until_complete(asyncio.wait(tasks))
            loop.close()
    协程属性
            gi_frame
                    f_code
                            co_filename
                    f_lineno
    属性
            __name__     
            __code__
            __annotations__
## oop
    class Base:
            __metaclass__ = models.SubfieldBase
                    # __metaclass__实例化结果是类，用于继承
            description = ''
            def __init__(self, name):
                    # self就是this
                    #  __del__(self)
                    # __str__(self)
                    # __lt__(self)
                    # __getitem__(self, key)
                    ## x[key]索引时调用
                    # __len__(self)
                    super(Base, self).__init__(*args, **kwargs)
                    self.data = []
            
            def add(self, x)
                    self.data.append(x)
            @classmethod
            def t1(cls):
            @staticmethod
            def t2():
    class Child(Base):
            # 继承
            def plus(self, a, b):
                    return a + b
    oChild = Child()
    oChild.add("str1")
    oChild.data
    oChild.plus(2, 3)
## 模块
    # .pyc是字节编译文件
    # __name__ 等于'__main__'时程序本身使用运行, 否则是引用

    # a.py
    def add_func(a, b):
            return a + b
    # b.py
    from a import add_func
            # import add_func as f
            # from a import *

    # __init__.py
            # 表示文件夹为包, 可空

    包路径
            # 环境变量PYTHONPATH中的值
            import sys
            import os

            sys.path
            sys.path.append(os.getcwd() + "\\parent\\child")
            
## 异常 
    if s == "":
            raise Exception("must not be empty.")
    try:
            i = int(s)
    except Exception as err:
            # except Exception, err
            print('Error %d: %s' % (e.args[0], e.args[1]))
    except:
    finally:
            print("Goodbye.")
    else:

# 模块
    os
    sys
            argv
                    # 参数列表, 多维列表
            exit()
                    # 退出线程 
    imp
            reload
                    # 重载模块 
    time
    timeit
    profile
    decimal
    fractions
    urllib
    http
    re
    functools
    itertools


    PyQt
            # gui
    PyGTK
            # gui
    wxPython
            # gui
    TkInter
            # gui
    matplotlib
            # 图形
    pillow
            # ocr, 文字识别
    pytesseract
            # ocr, 精确


    numpy
    math
    random
    scipy
            # 科学计算


    beautifulsoup
            # 网页结构化
    scrapy
            # 网页结构化
    requests
    phantomJS
            # 运行网页js
    selenium
            # 运行网页js


    pandas
            # 数据分析，产生数据结构、操作、统计、绘图 
    seaborn
            # 数据可视化
    scikit-learn
            # 机器学习
    nltk
            # 自然语言分析


    mysql-connector
    mysqlclient
    PyMySQL
    MySQLdb
    redis.py
    south
            # 表结构迁移, django自带

    pickle
            # 持久化
    qrcode
            # 二维码


    ast
            # 运算前检查的eval()
    datetime
    shutil
            # shell


    fabric
            # 运程自动部署
    celery
            # 定时调度
# 工具
    steuptools
            easy_install
    pip
            pip install -i http://pypi.douban.com/simple/ torndb
                    # 用豆辨的pypi索引
            pip install ipython==4.2.0
                    # 安装指定版本 
    ipython notebook
            # 在线运行python
    bpython
            # 更好的repl
    pdb
            # 调试
    cprofile
            # 性能测试
# 容器
    gunicorn
            # python实现
            sudo pip install gunicorn        
            gunicorn -w4 -b0.0.0.0:8001 app.wsgi 
    uwsgi
            # c语言实现
            sudo pip install uwsgi
            uwsgi --http :8001 --chdir /path/to/project --home=/path/to/env --module project.wsgi
                    # --home指定virtualenv的路径 
    nginx
    shell