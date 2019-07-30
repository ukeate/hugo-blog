---
title: "程序语言原理"
date: 2018-10-10T15:13:01+08:00
---

# 语言
    注意
        比较语言，共通处(抽象的元知识)是要点
        在历史上判断设计者意图     # 利于了解知道的根基
        不同规则，只在特点语言中合理      # 如0在ruby为真
    历史
        EDSAC           # 1949，纸带
        FORTRAN         # 1954, 中缀表达式, 运算符优先级、结合性
        FORTH           # 1958, 没有语法，后缀表达式，语法树
        LISP            # 1958, 括号，前缀表达式，语法树
    语法
        引入优先级和左右结合
        规则不冲突是困难的
            vector<vector<int> >    # c++的语法缺陷, >>是位运算，必须加空格
    结构化     # 60年代
        if          # 汇编是判断再向后跳代码, if使可读性好
        while       # 可读了反复执行的if
        for         # 可读了数值渐增的while
        foreach     # 可读了集合遍历
    函数
        作用
            便于理解    # 组织划分部门
            便于再利用   # 再利用无代码成本
        用了跳转命令和返回命令      # 从记录函数前后地址到函数记录返回地址
        栈记录多级调用             # 解决多级调用返回地址被覆盖问题
        递归                     # 处理嵌套数据结构时，代码的嵌套结构
    错误处理
        历史
            UNIVACI         # 1950, 溢出时中断(interrupt)跳转到000
            COBOL           # 1959, 两种类型错误，用两关键字处理
            PL/I            # 1964
                先定义出错处理代码。编程时引入on语句goto到处理代码, 不检查返回值
                可定义新错误类型, 可用signal condition主动出错
            john goodenough # 1975，论文
                程序员可能忘处理异常、在不正确位置处理、处理不正确类型异常
                应该声明可能抛出的异常、将可能出错结构括起来的语句结构
            CLU             # 1975, begin ... end 后 except 错误类型, 再写错误处理语句
            C++             # 1983, 1984-1989多次讨论，try{}catch{}, throw抛异常(没用raise和signal, 因为它们已经使用了)
            Windows NT 3.1  # 1993, 使用finally
            Java            # 1995, 引入finally
            D               # 2001, 作用域守护取代finally, 写在初始化语句后面scope(exit) unlock(m)
        方式
            返回值           # 遗漏错误，可读性下降
            异常处理         # 函数多出口
                必执行代码        # 成对操作无遗漏，不使用goto执行同段代码
                    finally      # java, ruby, python
                    析构函数      # c++, RAII(资源获取即初始化, resource acquisition is initialization)
        何时使用异常          # 有不同的规则。缺少参数，js不抛异常。数据越界，js返回undefined, ruby返回nil
            出错立刻抛异常     # 错误优先(fail first), 早发现问题
        异常传递              # 一层层函数向上传递，都无处理时程序异常退出
            上层函数不了解下层异常细节
            不了解下层调用不能捕获全部异常     # java用检查型异常解决, 但很麻烦
    取名
        编号到取名       # 对照表实现, 变量名或函数名
        实现
            整个程序共用一个对照表     # perl无声明变量, 全局作用域、全局变量
                                    # 1994 javascript
                解决冲突
                    更长变量名
                    作用域
            动态作用域               # 1991 perl4 local变量
                                    # 1958 lisp
                之前存变量原值，之后用原值覆盖变量
                中间函数调用时，变量不是原值, 要看调用前所有代码   # 全局污染
            静态作用域               # 1975 scheme，调用时建专用对照表(属于调用而非函数)，查找变量更优先。
                # 又叫字面作用域(lexical scope), 因为和字面范围一致
                                    # 1991 perl5 my变量
                                    # 1991 python
                                    # 1994 javascript val变量
                                    # 1995 ruby
            python
                内置作用域           # 语言提供，如js的全局对象作用域
                全局作用域           # 当前文件字面
                局部作用域           # 函数
            赋值即定义
                嵌套函数直接找全局作用域，不字面上找外部函数作用域        # 2.0问题, 2001年2.1修复
                不能改变外部变量                                    # 2006年3.0 nonlocal声明为外部变量
    类型
        比特列标记类型，解释成不同数据
        整数
            excess-3(加三码)       # UNIVACI, 4位表示0到9
            二进制                 # 1983, 任天堂计算机8位表示整数。目前32位和64位表示整数
                八进制(3位切分), 十六进制(4位切分)
        实数
            单独记小数点左移位数        # 定点数，不好实现和计算。
                银行用加三码和定点数
            前位段表示数，后位段表示小数点位置       # 浮点数，也可表示大整数
                IEEE 754        # 有误差
                    第一位符号
                    中8位是指数(-127-128), 负向左移正向右移，-127代表0, 128代表无限大
                    后23位是尾数，从左到右代表1/2, 1/4, 1/8...
            二-十进制码          # 用二进制表示十进制，加三码是一种，无误差
        发展
            变量名表示类型         # FORTRAN, I-N开头表示整数，其它表示浮点数
            声明类型
            隐式类型转换           # 整数+浮点数，FORTRAN出错，c都转换为浮点数, 整数除法舍弃小数
                ML(1973年)中, 整数除法用x div y, 小数除法用 x / y
                python3.0(2008年)中, 不带舍去除法用 x / y, 带舍去除法用 x // y
        用户定义类型           # c中的结构体, c++中函数成为类型，用户实现的类型称为类
            类型即功能             # 访问控制(公开、非公开)
            接口                  # 不包含实现细节的类型
            异常成为类型           # CLU和Java
            类型实现所有功能        # 未实现。类型一致，功能就成立，没有bug
                类型不能表达的：数据处理时间，处理用内存，是否可以在线程中操作等
        总称型(部分可变类型)    # 类型为参数创建类型，c++的模板，java的泛型，haskell的类型构造器
        动态类型               # 类型信息和数值看作整体, 静态类型把变量名、内存地址、内存里的内容类型作为整体
            内存中同等类型对待，其中再细分类型
            灵活，运行时确定类型，但不能执行前编译检查bug
        类型推导               # 最早OCaml和Haskell这类ML语言擅长，现Scala等语言也越来越多
            目标是证明程序没有bug
    容器
        语言中用语不共通           # haskell列表是链表，不可变，元组是放不同类型的列表
        数组、链表
        字典(散列、关联数组)       # 字典散列或树实现
        树
    字符串
        字符集和字符编码           # 有的认为就按效率特异化编码，有的认为应标准化
            摩斯码                # 长短组合
            博多码                # 5位一字符，先通知字符种类
            EDSAC                # 5位一字符，shift切换，内容和博多码不同。用5孔纸带
            ASCII                # 7位
                EBCDIC           # IBM，8位
            ISO-xxx              # 区域化
                魔术注释符        # 告诉语言处理器编码，特殊记号事先写明
            unicode              # 统一
        字符串
            c语言一字符8位，定义字符为ASCII或EBCDIC。字符串不知长度，nul字符终止，没nul时可能内存中越界读取
            pascal一字符8位，带长度
            java一字符16位, 定义字符为unicode
            python2 ASCII码环境下，字符当作ASCII码，可以自动转换成unicode
            python3中""是unicode码, b""是字节列串，要显示转换类型，否则报错
            ruby一字符8位，追加编码信息
    面向对象                      # 不同语言中面向对象意义不同
                                 # goto因强大让人困惑，退出历史。面向对象、Trait也有这因素
        两种立场
            c++, 类是用户自定义类型，Simula语言的继承机制是关键
            smalltalk, 类让人痛苦，不要继承，不同状态对象传消息来通信
        历史              # ALGOL产生model思想(1958年), Simula , Smalltalk, C++, Java
            类在大部分语言中不是不可或缺的
            Java: 类是部件，将其组装就是程序设计
        归集方法和建模的发展              # 围绕实现多实例问题
            强关联元素分组存放，便于理解
            module                      # 关联函数集中, 1978年Modula-2引入, python, ruby叫模块，java, perl叫包
                初始化散列, 再作为参数传入包中函数，函数修改散列
                包提供初始化函数, 返回散列, 该函数成为构造函数(java叫工厂方法)。但使用包函数都要传入散列
                bless函数(perl)绑定包和散列产生blessed hash对象，它的方法对应包方法, curry了散列做参数
                包的初始化函数自己绑定, 返回blessed hash对象
            变量和函数放入散列            # js对象
                函数放入散列                                # 函数成为一等公民(first class citizen)，可赋值给变量。FORTRAN66中字符串还不是一等公民
                函数中通过this隐式获取自身做散列              # perl中显示获得散列
                创建构造函数，返回以上散列。但返回的散列上都定义了新的函数
                把函数单独放置在包或对象, 使用时很麻烦
                引入原型概念,对象变量查找作用域在原型链中扩展    # 这里是委托方式的原型，也可以在实例化时通过负责来实现。原型变更的处理，不同语言有差异
                定义new f()运算, 函数f的原型是以上散列，多个new的新对象共享了散列的函数
                    新对象原型指向函数f的原型
                    以新对象为this,执行f
            闭包(closure)                # 维持内部作用域状态的函数, 作用域呈封闭状态
            类
                分类/分组                 # 1965年ALGOL提出
                用户定义类型              # 1979年c++, 参考Simula
                    最初c语言结构体
                    声明和定义类方法       # Smalltalk方法调用是传送消息，调未定义方法是否出错由该类决定
                    作用                  # 成为一种模具
                        生成器            # module和散列只有该作用
                        可行操作的功能说明(类型、泛型)
                        代码再利用的单位(继承)
            继承
                实现策略
                    父类实现一般化, 子类是父类的专门化
                    共享部分提取           # 子类不是父类的一种, 函数思想考虑问题
                    差异实现               # 覆盖变更部分，为了再利用使实现更轻松，不倾向使用
                问题
                    多层级问题
                        向上不好找方法定义
                        修改方法时，向下影响子类    # 如动态作用域问题
                    里氏替换原则               # 1987年提出，对父类成立的条件，一定对子类成立。为了维护父子关系间的一致性，继承是is-a关系
                        实际编程中，子类功能增加常打破里氏替换原则，无论是在开始设计上避免还是在开发中放弃继承都很麻烦
                多重继承                      # 东西常常不属于一个分类,java禁止多重继承
                    问题
                        多父类成员名冲突
                            委托(delegation)  # 聚合(aggregation)，咨询(consultation), 不用多重继承，把原父类对象作为子类成员,后发展出依赖注入
                            接口多重继承       # Java引入，php5(2004年)引入
                            按顺序搜索
                                深度优先               # python2.1, 菱形继承中，第一层父类的值会覆盖第二层右边父类的值
                                C3线性化               # 1996年提出，python2.3, perl6默认, 对类编号，子类先于父类检查, 优先检查先书写的类
                                混入式处理(mix-in)     # 扁平成新类, 该类不能创建实例，python XxxMixIn类， ruby类单一继承，模块混入
                                Trait                 # 2002年Trait论文，Squeak最早引入, scala, perl6的Roll, php5.4, ruby2.0的mix method
                                    类作用：创建实例(要求全面, 大的类),再利用单元(小的类)冲突
                                    把再利用单元特别化
                                        ruby模块混入名称冲突时, 使用最后的模块, Trait会报错    # Smalltalk的Squeak处理器可取方法别名，可指定不参与冲突
                                        scala声明创建实例需要的方法, 另一Trait声明提供的方法，组合匹配后可创建实例
                                        对Trait改写定义新的Trait(继承), Trait组合成新Trait


# 原理
    gc
        为什么gc
            减少编程工作量
            减少内存泄露
            安全性
        分类
            mark-and-sweep
            reference-counting
            arc
                # automatic reference counting
# 异步编程
    事件  # 高阶函数的优势
        解耦业务逻辑
    问题
        异常处理    # 不能同步catch
        回调嵌套过深
        单线程模型中，业务处理阻塞全局
        异步转同步
    实现
        事件发布订阅
            回调函数事件化(钩子机制)
        promise/deferred        # promise/A, promise/B, promise/D模型
            # promise在外部暴露接口(可变部分), deferred在内部维护状态(不可变部分)
            状态
                未完成，完成，失败
                方向只能未完成->完成, 未完成->失败
                状态转化不能更改
            api
                then()
                done()
                all()     # 所有成功成功，一失败失败
                any()
        流程控制库
            尾触发     # 传next()函数
            async库(node.js)
                series()        # 串行
                parallel()      # 并行
                waterfall()     # 串行传结果
                auto()          # 计算依赖顺序执行
            bagpipe库(node.js)   # 限制并发, 任务可排队或拒绝, 超时控制

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
        # 源代码读入、解析成语法树
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