---
Categories: ["语言"]
title: "JS"
date: 2018-10-09T10:31:30+08:00
---
# 基础
    特性
        面向对象
        动态语言(已超出脚本语言的范畴)

        first-class function的思想来自Scheme语言
        prototype-based的思想来自Self语言
    机制
        弱类型，变量都是var
        解释器有自己的内存管理机制(garbage collection)
        自由数据类型转换    # 产生了==, ===的判断相等的不同定义
    commonJs规范下的javascript
        node.js
        mongoDB
        ringojs
    v8引擎
        直接生成机器码
        分代式GC
        java jvm工程师参数了优化

# 词法
    js是unicode字符集编写的
        # unicode转义如, 'café'表示为 'caf\u00e9'
        ## 'é' 也可以表示为'e\u0301', e后面跟一个语调符
    区分大小写
        # html中不区分大小写, 其要调用的函数在js中一律小写
    注释如//, /**/
    标识符和保留字
        要求
            开头以字母、下划线、dollar符。
            后续可以加数字
            可以出现unicode字符集中的Mn类、Mc类、Pc类，如
                # Mn表示非间距字符，Mc表示影响基字符标志位的间距字符, Pc是连接两个字符的连接符或标点符号。
                é, π,
        保留字
            break, delete, function, return, typeof, case, do, if, switch, var, catch, else, in, this, void, continue, false, instanceof, throw, while, debugger, finally, new, true, with, default, for, null, try
        未被使用的名保留字
            class, const, enum, export, extends, import, super
        严格模式下的保留字
            implements, let, private, public, yield, interface, package, protected, static
        严格模式下不能用做变量名
            arguments, eval
        es6新增保留字
            await
        ECMAScript3将所有java关键字列为保留字
        全局属性和对象和函数
    自定义全局对象和函数列表
## 直接量
    直接量(numeric literal)
        1
        1.2
        "hi"
        'hi'
        true
        false
        /javascript/gi
            # 用于模式匹配
            ## 实际是一个RegExp对象
            ## gi是用来修饰匹配模式的含义
        null
        {x:1, y:2}
            # {foo}    // 等同{foo: foo}
            # {method () {}}    // 等同{method: function () {}}
            # {*m () {}}    // generator
            ## 简化写法常用于函数返回值, 如return (foo, method)
            # {['a' + 'b']: 1}
            ## {['hello'](){reutrn 0;}}
            ## 对象属性是Symbol值, name属性返回这个Symbol值的描述
            # {get a () {}, set a (val) {}}    // 属性getter, setter
            ## get, set函数的函数名name是 'get xxx', 'set xxx'
        [1,2,3,4]
    整型直接量
        0
        10
        0xff/0Xff
            # 16进制
        0o377
            # 8进制
            0377
                # ECMAScript标准不支持八进制直接量，某些实现可以采用八进制表示
                ## ECMAScript6严格模式下, 八进制直接量是明令禁止的
        0b11/0B11
            # 2进制
    浮点型直接量
        3.14
        .333
        6.02e23
            # 6.02 x 10^23
        1.4E-32
    字符串直接量
        ECMAScript3规定必须写在一行, ECMAScript 5可多行，如
            "one\
            long line"
        模板字符串
            # 保留换行，空格，缩进
            # ${}中任意表达式，包括函数
            var name = 'Bob';
            `hello ${name}
            how are you`
# 语法
    可省略的分号
        通用规则: 独占一行，并与下一行不能整体解析时
            # var a = f
            ## (a+b).toString(); 就不可以
            # 以 (, [, /, +, - 开始的语句极可能和前一条语句一起解析，可写成 ;(a+b)
        例外规则
            return, break, continue占一行时，总加分号
            ++, -- 永远解析为前缀, 所以作后缀时要加分号
                # 如　x [换行] ++ [换行] y, 解析为 x; ++y
        '}'之前

## 类型与变量
    声明
        # 存值之前是undefined
        # 写在后面的声明可以前面用, 重复声明无影响
        # 给非声明变量赋值默认创建全局变量，这不是好习惯，只是侥幸
        ## ECMAScript 5 严格模式下未声明赋值会报错
        ## 非声明的全局变量与声明全局变量的区别
        ### 非声明的全局变量是可配置的(可delete)，而var声明的全局变量不可配置
        var x;
        x = 1;
        let a = 10
            # 支持了直接用{}的块级作用域
            # 只在块级作用域有效
            ## for(let i = 0; ...; ...)
            # 无变量提升
            # 暂时性死区
            ## 死区中使用该变量会直接报错
            # 重复声明报错
            # 声明的全局变量不再是全局对象的属性, 同样机制的还有const, class
        const PI = 3.1415
            # 只能在声明时赋值一次
            # 其他同let
            # export const A = 1;
            ## import * as constants from './constants'
            ## constants.A
    分类1
        原始类型(primitive type)
        对象类型(object type)或引用类型，如
            对象(object)是属性(property)的集合
                property由key/value组成
            全局对象(global object)
            数组类: Array
                内存连续保住的带编号的值的有序集合
            函数类: Function
                具有相关联的可执行代码的特殊对象
        原始类型
            # 可以拥有自己的方法
            # 原始类型都包含内置构造函数
            数字        
            字符串
            布尔值
            Symbol
        原始值
            # 不可以拥有自己的方法
            null
            undefined
    分类2
        可以拥有方法的类型
        不能拥有方法的类型
    分类3
        可变(mutable)类型    
            # 值可以改变
            ## 比较(==, ===)是地址的比较
            对象
        不可变(immutable)类型
            # 比较(==, ===)是值的比较
            数字、布尔值、null、undefined、字符串
                # 字符串不像c语言可以看作字符数组，js的字符串不可变
                ## 只可以访问其任意位置, 不可以修改文体内容
    类型转换
        # Symbol不可转换
        转换为数字
            # 字符串允许在开始和结尾处带有空格
            false为 0
            true为 1
            ""为 0
            失败为 NaN
        转换为字符串
            -0 为"0"
            -Infinity 为"-Infinity"
            [9]为 "9"
            ['a']其他数组，调用join()方法
        对象转换字符串
            # 运算符+ == != 的处理运用这里的原理
            # 日期对象有自己的重定义,valueOf与toString返回的原始值将直接使用
            toString()
            valueOf()
                # 没有toString()方法时调用
                ## 如果返回原始值，自动将它转换为字符串
                数组、函数、正则表达式返回对象本身
                日期类返回毫秒数
            无法得到原始值则抛出异常
        对象转换数字
            # 运算符 - < 用了这里的原理
            首先尝试valueOf()
                # 如果返回原始值，自动转换为数字
            再尝试toString()
                # 自动转换为数字
            无法得到原始值则抛出异常
        例子
            数字
                []为0        # valueOf -> toString -> "" -> 0
                [9]为9        # valueOf -> toString -> "9" -> 9
    相等性
        null == undefined
        "0" == 0
        0 == false
        "0" == false

### 类型
    数字
        基础
            所有数字用二进制浮点数表示(64位, 如java中的double)
                # IEEE-754标准
                ## 整数范围 -2^53 ~ 2^53(大约900亿亿)
            实际的操作(数组索引, 位操作符)基于32位整数
            负号是一元运算符，并不是数字直接量语法的组成部分
            0与-0唯一差别
                1/zero !== 1/-0    # 正无穷大和负无穷大不等
        实数近似表示(几乎所有现代编程语言都存在, 因为都是IEEE-754标准)
            浮点数表示褛的个数为18 437 736 874 454 810 627个
            IEEE-754标准精确表示1/2, 1/8, 1/1024，但不精确表示1/10, 1/00。
                # 建议用大整数进行重要计算(如元, 角, 分各用整数表示)
                所以js只能近似表示0.1
                var x = .3 - .2
                var y = .2 - .1
                x == y        // => false
                x == .1    // => false
                y == .1    // => true
    字符串
        基础
            从0开始
            没有如c语言中的字符型
            采用UTF-16编码的Unicode字符集。
                是一组无符号16位值组成的序列。
                    # 用16位内码表示, 表示一个单个字符
                    ## 不能16位Unicode表示的遵循UTF-16编码规则，两个16位值来表示一个(代理项对)
                    ### 长度为2的字符串可能表示一个Unicode字符,如var e ="\ud835\udc52"; e.length // => 2
                字符串的操作不对代理项对单独处理
                不对字符串做标准代加工
                    所以不能保证字符串是剑的UTF-16格式
        运算
            +            # 字符串连接
        unicode
            允许采用\uxxxx表示\u0000 到 \uFFFF之间的字符
            超出范围时用4字节表示, 如 \uD842\uDFB7
            '\u20BB7' 会被解释成 '\u20BB' + '7'
            '\u{20BB7}' 会正确解释
            多种表示法
                '\z'
                '\172'
                '\x7A'
                '\u007A'
                '\u{7A}'
        转义
            十六进制数表示Latin-1或Unicode中的任意字码, 由两位十六进制数指定
                '\xA9'        // => ©
            \u表示4个十六进制数指定的Unicode字符
                '\u03c0'    // =>
            \n
            \'
            \0            # 同\u0000, 表示空字符串
            \b            # 同\u0008, 表示退格符
            \t            # 同\u0009, 表示tab
            \v            # \u000B, 垂直制表符
            \f            # \u000C, 换页符
            \r            # \u000D, 回车
    布尔
        转换
            # 所有值都可以转换为布尔值
            false
                undefined
                null
                0
                -0
                NaN
                ""
            true
                除以上，全部为true
        api
            toString()        # 转换成"true"或"false"
    null undefined
        介绍
            都是js的全局属性
        类型
            null为object
                # 但可以表示数字类型、字符串类型
            undefined为"undefined", 是一个单独类型
        比较
            null == undefined        // => true
            null === undefined        // => false
        api
            无
                # .和[]取成员会产生类型错误
        bug
            undefined在ECMAScript可读/写，可赋任意值
        结论
            undefined表示系统级类似错误的空缺
            null表示程序级的，正常出现的空缺

    Symbol
        介绍
            原始数据类型，因为不是对象，所以不能new, 不能添加属性
            不参与类型转换, 但可以toString
                # 可以String(s)得到 'Symbol(a)', Boolean(s)得到true, !s 得到false
                ## Number(s)会报错
            可以做属性名a[sym1] = 1, 不能用点运算符赋值或取值
            常用于设置常量结构体来switch，以消除魔术字符串
### 作用域
    全局变量
    就是定义顶级对象的属性
        # 这点在ECMAScript规范中强制规定
    在js代码任何地方都有定义
    局部变量
        # 未规定是该函数的属性
        ## var声明的局部变量是我们不可见的内部实现
        在函数内有定义，优先于全局变量
    与c语言区别(嵌套作用域)
        c中{}内产生块级作用域(block scope), 其中变量其外不可见
        js中没有块级作用域，是函数作用域(function scope), 变量在内部嵌套函数有定义。
    声明提前
        内部嵌套函数而言, 变量声明之前就可用, 称为声明提前(hoisting)
        # hoisting js函数里声明的所有变量(不赋值), 被"提前"到函数体顶部，在js引擎预编译时进行。
        例子
        var scope = "global"
        function f(){
            console.log(scope)
                # 这里是undefined, 因为局部scope声明提前，覆盖了全局scope, 而声明提前不定义, 定义在执行代码时进行
                ## 等价于开头var scope;
            var scope = "local"
            console.log(scope)
        }
    o-> js本身设计中没有构造函数，普通函数，对象方法，闭包。这些都是莫须有的叫法
    o-> 内部函数可以访问函数上下文
    o-> 非严格格式直接声明变量，挂到global上
    o-> 作用域在函数中定义, 非块定义, 所以
        for(var i = 0; i < 10; i++) var value = 'hello';
            # 中定义的i与value，在for之外可以被访问
            ## 声明提前
    o-> 闭包一坑
        for(var i = 0; i < 5; i++){
            setTimeout(function(){
                console.log(i);
            }, 5);
        }        # 会打印5个5, setTimeout是global调用的外层的i引用
        改进
        for(var i = 0; i < 5; i++){
            (function(idx){
                setTimeout(function(){
                    console.log(idx);
                }, 5);
            })(i);
        }            # 匿名函数中定义了新的作用域，保留了i在循环中的值的引用
    o-> this
        有调用对象就指向调用对象
        没调用对象指向全局对象
            O.a = function(){
                var b = function(){
                    console.log(this);
                        # b中的this永远是全局对象
                };
                b();
            };
            O.a()
        new 构造时指向新对象
            var O = function(){this.val = 100;}
            var o = new O();
            console.log(o.val);        # 这里输出o.val而不是O.val
        用apply或call或bind方法改变this指向
            function tt(){
                console.log(arguments.callee);            # 永远是tt本身
                console.log(this);                        # 都是下面定义的a
            }
            var a = '1';
            tt.call(a, 1, 2);
            tt.apply(a, [1, 2]);
            var att = tt.bind(a);
            att();
    o-> 参数调用时，会扩展作用域，如
        f(a.b)()
        var f = function(c){ // c得到a.b的值，并且a挂到f的作用域}
#### 作用域链
    scope chain
    介绍
        每一段js代码有关联的作用域链
            一个对象链表，定义这段代码的作用域
            变量解析(variable resolution)时，从链第一个开始查找到最后一个
                # 查找不存在时抛出引用错误(ReferenceError)
    原理
        定义一个函数时，实际上保存一个作用域链
        调用该函数时，创建新对象放局部变量，添加到保存的作用域链
            同时，创建一个新的、更长的 「函数调用作用域"链"」
                该函数每次调用外部函数时，嵌套函数重定义
    代码作用域链分类
        顶层代码
            顶级对象属性
        无嵌套函数体
            var定义的局部变量
            顶级对象属性
        嵌套函数体
            var定义的局部变量
            顶级对象属性
            函数调用作用域"链"      
    注意
        1.在函数add创建时，它的作用域链中会填入全局对象
        2.执行此函数时会创建一个称为“运行期上下文(execution context)”的内部对象
            # 运行期上下文定义了函数执行时的环境。
            ## 每个运行期上下文都有自己的作用域链，其作用域链初始化为当前运行函数的[[Scope]]所包含的对象。
        3.函数中的值按照它们出现在函数中的顺序被复制到运行期上下文的作用域链中。
            它们共同组成了一个新的对象，叫“活动对象(activation object)”
            # 该对象包含了函数的所有局部变量、命名参数、参数集合以及this
            ## 此对象会被推入作用域链的前端
            ## 运行期上下文被销毁，活动对象也随之销毁
        4.在函数执行过程中，每遇到一个变量，都会经历一次标识符解析过程以决定从哪里获取和存储数据。
            # 该过程从作用域链头部，也就是从活动对象开始搜索
            ## 如果没找到继续搜索作用域链中的下一个对象，如果搜索完所有对象都未找到，则认为该标识符未定义
        5.其作用域链只会被 with 语句和 catch 语句影响。
        优化代码：
            1.因为全局变量总是存在于运行期上下文作用域链的最末端，因此在标识符解析的时候，查找全局变量是最慢的。
                所以，在编写代码的时候应尽量少使用全局变量，尽可能使用局部变量
            2.一个好的经验法则是：如果一个跨作用域的对象被引用了一次以上，则先把它存储到局部变量里再使用。
            3.优化with() try-catch
                with(document){ }   # 使用width语句来避免多次书写document，看上去更高效，实际上产生了性能问题。
                                    # 代码运行到with语句时，运行期上下文的作用域链临时被改变了。一个新的可变对象被创建，它包含了参数指定的对象的所有属性。这个对象将被推入作用域链的头部
                                    ## ，这意味着函数的所有局部变量现在处于第二个作用域链对象中，因此访问代价更高了。
                try{
                    doSomething();
                }catch(ex){
                    alert(ex.message); //作用域链在此处改变
                }            # 同理，catch语句使效率下降。你可以通过优化代码来减少catch语句对性能的影响。
                try{
                    doSomething();
                }catch(ex){
                    handleError(ex); //委托给处理器方法
                }           # 优化后的代码，handleError方法是catch子句中唯一执行的代码。该函数接收异常对象作为参数，这样你可以更加灵活和统一的处理错误。
                            ## 由于只执行一条语句，且没有局部变量的访问，作用域链的临时改变就不会影响代码性能了。

## 表达式
    介绍
        表达式(expression), 由解释器计算(evaluate)
    原始表达式(primary expression)
        常量
        直接量
        关键字
            true, false, null, this
        变量名
    对象和数组初始化表达式
        # 对象直接量、数组直接量
        {}
        []
    函数定义表达式
        # 函数直接量
        var square = function(x){reutrn x*x}
    属性访问表达式
        # 其前面的表达式首先计算
        ## null, undefined会抛出类型错误异常，因为它们不能包含属性
        .
        [1]
        ["a"]
            # 计算[]中的值
    调用表达式(invocation expression)
        # 顺序
        ## 首先计算函数表达式，再计算参数表达式
        ## 传入实参的值赋值给形参
        ## 执行函数体
        ### return返回值给变量名，无return 函数名赋为undefined
        # 左边是属性访问表达式，本调用称作方法调用(method invocation)
        ## 函数体的this是宿主对象(执行者)
        ## 非方法调用时，this是顶级对象
        ### ECMAScript 5中非方法调用时, this = undefined
        f(0)            # 非方法调用
        Math.max(x, y, z)    # 静态方法调用, this为Math类
        a.sort()            # 动态方法调用, this为a实例
    对象创建表达式(object creation expression)
        # 创建一个对象并调用构造函数
        # 与调用表达式相似
        # 过程
        ## 创建空对象，该对象作为构造函数的this，可用来初始化动态属性
        ## 传入指定参数，执行构造函数。
        ## 返回值以构造函数返回值优先(本次对象废弃)，没有时则返回本次创建的对象
        
        new Point(2, 3)
        new Object()
        new Object        # 不传参时, ()可以省略
    关系表达式
        相等, 大小, 是...的属性, 如==, <, in, instanceof
    逻辑表达式            # 带有! && || 的表达式
    赋值表达式
        (a=b) == 0        # 赋值成功时返回1
        i = j = k = 0;
### 运算符
    介绍
        operator
        将简单表达式组合成复杂表达式
        由标点符号或关键字表示
            # 如+ = delete instanceof
    概念
        一元、二元、三元运算符
            # - +(正负号)是一元，*是二元, ?!是三元
        期望与转型(优先级图中有详细)
            "3" * "5"        # 期望数字, 自动转型
            运算符对类型依赖
                +        # 数字则运算，字符串则拼接
                <        # 数字则比较, 字符则比较字符表次序
        左值(lvalue)
            表达式只能出现在赋值运算(=)的左侧
                或者指&, ++等操作符的操作数
                或者内存栈中的变量名
            如: 变量、对象属性、数组元素
            内置函数可返回左值，自定义函数不可以
        优先级
        左右结合性
        运算顺序
            总是严格从左到右计算表达式
            表达式会影响变量值(如++, --, delete)时，先执行
                # b = (a++)+a
                ## 计算b, 计算a++(返回的结果是1), 计算右边的a(结果是2)
                ### 计算等号右边(值为1 + 2), 进行赋值
    关键字运算符
        delete, typeof, instanceof, in, void
        in运算符
            # 判断是否存在属性
            # 希望左是字符串, 希望右是对象
            'toString' in obj
            for( var i in ojb)
        instanceof运算符
            # 判断是否实例, 会判断父类
            ## 遍历原型链(prototype chain), 所以一个实例可能instanceof多个继承的函数
            ### 是js的继承机制, 对象存在一个隐藏成员一层层指向父类原型。
            原理
                o instanceof f
                    计算f.prototype, 然后在o原型链中查找f, 找到则返回true
        typeof 运算符
            # 返回一个对象的类型描述字符串
            typeof value == "string" ? "'" + value + "'" : value
            typeof(value)        # 可以写作函数的形式
            返回值
                "undefined", "object", "boolean", "number", "string", "function"
                null, 对象和数组 返回"object"
                    # 进一步判断类型
                    ## instanceof, class特性, constructor属性
                函数是对象的一种，但typeof特殊对待
        delete运算符
            删除属性, 成功则返回true
            内置核心客户端属性不能删除
            var语句声明的变量不能删除，function定义的函数和其参数不能删除
                # 严格模式下删除失败会报错
        void运算符
            写在操作数前，操作数照常计算, 但返回undefined
                <a href="javascript:void window.open();">
                    # 使浏览器不必显示计算结果
    普通一元(目)运算符
        +, -, ++, --
            # 这里+, -表示正负号
            ## +, -会把变量自动转型为数字
            ## ++, -- 作为前增量时, 返回计算后的值，后增量时，返回计算前的值
            ### 与c语言不一样，c语言的前后增量作用于整个表达式s
    普通二元(目)运算符
        - * / % **
            # **是指数运算符
            必要时转换数字
            js中数字都是浮点数, 所以5/2 = 2.5
        +
            左结合
            根据变量类型进行 数字相加或字符串连接
            对象先尝试转换数字(Date除外，先转换字符串)
                如果存在字符串，则拼接(不论字符串值是否数字)
                都为非字符串，则转换数字计算，失败返回NaN
    三元(目)运算符
        ?:
            # 条件运算符, 唯一三元运算符
    位运算符(对操作数每位布尔运算)
        #要求操作数是整数(32位整形而非64位浮点型)
        ## 会自动强制转换
        ### NaN, Infinity, -Infinity转换为0
        &        # 按位与
            0x1234 & 0x00FF = 0x0034
        |        # 按位或
            0x1234 | 0x00FF = 0x12FF
        ^        # 按位异或
            0xFF00 ^ oxF0F0 = 0x0FF0
        ~        # 按位非
            ~0x0f = 0xFFFFFFF0或 -16
        <<        # 左移
            7<<2 = 28
                # 移动倍数是0~31的整数，用0补
        >>
            7>>1 = 3
            -7>>1 = -4
                # 左边高位 正数填0, 负数填1
        >>>        # 无符号右移，左边高位总填0
    相等不等运算符
        ==(equality operator), ===(严格相等(strict equality)或恒等(identity operator))
            # 数字和字符串原始类型也是地址的相等(恒等)
            ==
                null == undefined
                数字==字符串, 字符串转换为数字比较, true转换成1比较
                "1"==true    # 同时转换为数字比较
                对象根据另一个值的类型转换
            === 与 ==
                不同类型间比较，==之比较“转化成同一类型后的值”看“值”是否相等，===如果类型不同，其结果就是不等
        !=, !==是==, ===的求反
    比较运算符
        <, >, <=, >=
            # 存在NaN则返回false
            # <=只是简单的不大于，>=相反。不进行==比较
            0 == -0
            Infinity最大(除了本身)
            -Infinity最小(除了本身)
        转换
            对象转换为数字
            同为字符串，字母表顺序比较(16位unicode字符索引顺序)
            存在不为字符串，转换数字
    逻辑运算符
        ! && ||
            # !会隐式转换为布尔类型
            # &&比||优先级要高, !优先级最高
        隔断性
            (a == b) && stop()        # 同if(a == b) stop();
            var max = a || b || 0;        # 常用。层层按优先级判断，给max赋值
                            ## 常用来给可能未传入的参数赋默认值
    赋值运算符
        =
        带操作的赋值运算符
            +=, -=, *=, /=, %/, <<=, >>=, >>>=, &=, |=, ^=, **=
        注意
            data[i++] *=2
            data[i++] = data[i++] * 2
                # 以上不相同
    逗号运算符
        # 计算左边表达式并忽略结果
        ## 连接多上表达式成为一个表达式
        i=0, j=1, k=2        # 计算结果是2
        for(var i=0, j=10; i < j;j--)
    扩展(spread)运算符   
        # 展开具有[Symbol.iterator]接口的可遍历对象，所以可以展开字符串, Map, Set, Generator
        # 内部使用for of
        # 支持4字节字符
        [1, 2, ...arguments]
            # 展开成新数组, 等于[1, 2].concat(arguments)
        [a, ...rest] = [1, 2, 3]
            # 模式匹配给rest赋值, 只能放在最后
        array.push(1, ...items, 2)
            # 函数调用
    函数绑定运算符
        # 返回原对象, 可以链式调用a::b::c, 把b, c都绑定到a
        foo::bar
            # bar.bind(foo)
        ::obj.foo
            # obj.foo.bind(obj)
    优先级
        优先级(js权威指南六版66页)
    算术运算
        不报错
            溢出(overflow), 下溢(underflow), 被零整除
            overflow
                超过表示的数字上限, 得到Infinity或-Infinity
            underflow
                比最小值还小, 返回0或负0, 负0几乎和0一样, 很少用到
            除零
                返回无穷大或负无穷大
        返回NaN
            零除以零
            无穷除以无穷
            负数开方
            无法转换为数字
### eval  
    介绍
        计算由源代码组成的字符串, 用eval("")来运行
        eval()是一个函数，但设计上更像运算符。
            限制eval()函数使它更像运算符
    问题
        eval()中的代码，解释器不能分析和优化
            eval()可以改变局部变量，对优化是很大的问题
        eval()的函数名可以被赋予其他名字(与运算符的区别)
            var f = eval;
            var g = f;
            这样解释器无法优化任何调用g()的函数
            # 所以ECMAScript规定不可以对eval()赋予别名，会抛出EvalError异常
            ## 实际上，大多数实现并不这么做。别名调用时, 会当作顶层全局代码来执行
            ### 这样不会修改局部变量的值，不影响优化
        ECMAScript 5规定
            直接eval(direct eval), 总是在调用它的上下文作用域执行
            间接调用(指别名调用)则作为顶层代码执行，不能读、写、定义局部变量
                # 间接eval是有用的特性，允许在局部作用域执行上下文无依赖的脚本
        ie9之前的不同
            别名调用eval()是局部调用
            用execScript()来全局eval调用        # 与eval不同在于总是返回null
        ECMAScript 5 严格模式
            eval作为保留字, 不能用别名覆盖(更像运算符)
            eval中的字符串以"use strict"指令开始
            可以使用和更改局部变量，不可以定义新的变量
    eval()
        # 一个参数，如果不传入字符串，则直接返回传入的参数。
        ## 传入字符串, 则编译该字符串
        ### 失败则抛出语法错误异常(SyntaxError)，成功则开始执行这段代码
        #### 执行成功，返回字符串中最后一个语句的值。最后语句没有值，返回undefined
        ##### 执行中抛出异常, 该异常将调用传递给eval()[?]
        # eval的作用域是当前作用域, 如eval("var y = 3;")
        # 用eval向函数中粘贴代码片段是无意义的，如
            var foo = function(a){eval(a)};
            foo("return;");
                # 执行eval(a)的上下文是全局的, 会抛出return not in function错误
        ## eval作为单独脚本，如eval(" y = 1;")是有意义的
## 语句
    介绍
        语句以分号结束
        表达式计算出值，语句来执行。
            # 有副作用的表达式也会执行，叫作表达式语句(expression statement)
            ## 声明语句(declaration statement), 来声明新变量或定义新函数
        js解释器依照语句编写顺序执行
            一些语句， 控制结构(control structure)改变顺序
                条件conditional
                    switch
                循环loop
                    while, for
                跳转jump
                    break, return, throw
    表达式语句
        赋值语句，如 greeting = "Hello" + name;
        ++, --
        delete
        函数调用，如 alert(greeting);
            # Math.cos(x)不是表达式语句，它没有对浏览器造成影响
    复合语句和空语句
        # {}括起来当作单独语句
        ## 内部语句必须分号
        ## 内部声明的变量作用域在外部(es6之前)
        {
            x = Math.PI;
            cx = Math.cos(x);
        }
        空语句
            ;
        如
            if(){....}
            if();
    块作用域(es6之后)
        # 内部使用严格模式
        {
        }
    声明语句
        # 声明语句创建的变量无法删除，但不是只读的，可以重写
        # 函数声明常出现在代码最顶层
        ## 函数声明并没有归类为真正的语句
        ## 函数声明不能出现在if, while等语句中
        var, function
        如
            var f = function(){}        # 变量名指向函数对象，声明提前。初始化要在执行到时进行
                            ## 不可以在代码之前调用
            function f(){}            # 函数声明和定义均提前，可以在代码之前调用
    条件语句
        # 称为代码中的决策点或分支
        if(expression1) statement1
            else if(expression2) statement2
            else statement3
        switch(expression){ statements}
            # 不重复计算表达式
            # 无break向下执行，如c语言
            # ECMAScript规定case可跟随任意表达式
            ## case是恒等比较, 所以不会作类型转换
            ## 避免使用函数表达式和赋值表达式，建议常量表达式
            # case是运行时(run-time)计算的, 灵活但效率低。c, c++, java中case是编译时(compile-time)常量
            ## 编译时常量形成跳转表(jump table), 执行非常高效
            # default标签可以在switch语句内的任何地方
            switch(typeof x){
                case 'number': break;
                default: break;
            }
        while(expression) statement
        do statement while(expression);        # 代码至少执行一次
        for(initialize; test; increment) statement
            # for(;;)比while(true)高效
        for(variable in object)
            # 遍历对象属性成员
            # 遍历出的数组key(如0, 1, 2)是字符串
            for(a[i++] in o)
            for(i in [1,2,3])
            原理
                计算object表达式
                    为null或undefined 则跳过
                        # ECMAScript3的实现可能会抛出一个类型错误异常
                    为原始值, 则包装对象
                    否则就一定是对象，枚举对象属性(或数组索引)
                        # 只有可枚举(enumerable)属性才会遍历到
                        ## 代码中所有属性和方法可枚举
                        ### ECMAScript 5可以特殊手段变为不可枚举
                        ## js语言核心定义的内置方法不可枚举(nonenumerable)，如toString()
                        ## 很多内置属性不可枚举
                        # 继承的自定义属性也可以枚举出来
                        # prototype上有多个原型(原型链上多个对象), 每个都遍历
                        # for/in中提前删除的未枚举属性不会枚举到
                        ## 定义的新属性不会枚举到(有些实现是可以枚举到的)
                        每次循环计算variable表达式的值，以它为左值赋值
            顺序
                通常实现按照定义先后顺序
                原型链多继承对象有特定顺序
                数组依照数字顺序            # 不是全部实现
                                    # 索引非数字或不连续时，按照特定顺序
        for(let c of s)
            # 会正确识别4字节字符
    跳转语句(jump statement)
        break, continue, return, throw
            # throw是复杂的跳转语句，跳转到最近闭合异常处理程序
            ## 处理程序可以在同函数中或高层调用栈中
    标签语句
        identifier: statement
            # identifier不能是保留字。与变量或函数命名空间不同，可以使用同一个标识符作标签和函数名
            ## 外层语句标签不能和它内部的重名。不嵌套下是可重名的
            # break, continue是唯一可以使用语句标签的语句
        mainloop: while(token != null){
            continue mainloop;
                # break mainloop;
        }
    break语句
        # break后面无内容自动补分号
        # 不可以跳出函数边界，只在一个函数中起作用
        # for中不会计算自增表达式, 直接退出
        break;
        break labelname;
    continue语句
        # continue后面无内容自动补分号
        # while中跳到开头检测expression, do/while跳到结尾
        # for中先计算自增表达式，再检测expression, for/in中遍历下一个属性名，赋给变量
        continue;
        continue labelname;
    return语句
        # return后面无内容自动补分号
        # 函数调用是表达式，return返回函数表达式的值并跳过后续结果。无return时, 函数表达式结果为undefined
        ## 只在函数中出现
    throw语句
        # js解释器立即停止当前执行的逻辑，并跳转到就近异常处理程序
        ## try/catch/finally语句的catch编写异常处理程序
        ## 没有异常处理程序, js把异常当作程序错误处理，报告给用户
        throw expression;
        throw new Error('x不能是负数');
            # Error对象
            ## name属性表示错误类型, message属性存放传递给构造函数的错误信息
    try/catch/finally语句
        # catch可选, finally可选
        # try finally一起, finally用于清理代码
        finally中常写的逻辑
            # finally中return, continue, break, throw跳转，忽略已有返回值或异常，以finally中的为准
            o-> 正常终止, 收尾语句
            o-> break, continue或return终止
            o-> 抛出异常，被catch捕获。抛出异常未被捕获, 继续向上传播
        模拟for(initialize; test; increment)body;
        initialize;
        while(test){
            try{body;}
                # body中有break时, 这里相比for循环有一次额外的自增运算
                ## 所以while不能完全模拟for
            finally{increment;}
        }
    with语句
        # with语句用于临时扩展作用域链, 将对象添加到作用域链的头部
        # with下创建未声明变量不会添加到with对应对象作属性，而是和平时一样
        ## with执行完后把作用域链恢复到原始状态
        ## 作用域链(scope chain)
        ### 按序检索的对象列表, 通过它进行变量名解析
        ## 严格模式下禁止使用with语句。非严格模式不擒获with, 因为运行慢且非常难于优化
        ### 对象嵌套层很深时使用with来简化代码编写
        with(object) statement
    debugger语句
        debugger;
            # 产生一个断点(breakpoint)，在解释器调试模式运行时使用
            ## ECMAScript 5中加入的debugger语句。但从前主流浏览器已经实现了
    "use strict"指令
        # 只出现在代码或函数体的开始或eval()中。其前可以有其字符串直接量表达式语句
        ## 解释器可能将"use strict"之前的字符串和它都解释成解释器自有的指令
        ## 直到第一条常规语句出现之后, 字符串直接量就只当作普通表达式语句对待
        # 表示其后的代码将会解析为严格代码
        ## 函数和eval()只作用到自身
        # ECMAScript 5引入的指令。可以使用单引号。对于没有实现ECMAScript 5的解释器来说，它什么也不做(没有副作用)
        ## 将来ECMAScript希望用use做关键字
    tag函数
        # 用于过滤html字符串, 嵌入其他语言执行或filter出特定的值
        tag`hello ${1} world ${2}`
        function tag(strArr, ...values){}
            # ['hello ', ' world ', ''] , 1, 2
    数组推导
        # 支持iterator接口, 即也支持字符串。惰性求值
        # 可以替代filter方法
        var a1 = [1, 2, 3]
        var a2 = [for (i of a1) i * 2]
        var a3 = [for (i of a1) if(i < 3) i]
        var b1 = [1, 2]
        var b2 = ['a', 'b']
        [for (s of b1) for (w of b2) s+w]    // ['1a', '1b', '2a', '2b']
        let c = (for (n of generator()) n * n)

### 模式匹配
    注意
        模式匹配只对自身属性起作用

    o-> 数组
    let [foo, [[bar], baz]] = [1, [[2], 3]]
        # var, const同样适用
    let [,, third] = [1, 2, 3]
    let [head, ...tail] = [1, 2, 3]
    let [x, y, z] = new Set(['a', 'b', 'c'])
        # 只要有Iterator接口，都可以匹配

    var [foo = true] = []
        # 设置默认值，在值严格等于undefined时生效
        # var [x = 1] = [undefined]
        ## x = 1
        # var [x = 1] = [null]
        ## x = null
        # let [x = f()] = [1]
        ## 惰性求值
        # let [x = y, y = 1] 报错, y 未声明

    o-> 对象
    var {bar, foo} = {foo: 'a', bar: 'b'};
    var {foo: baz} = {foo: 'a'};
        # baz = 'a'
    var {p: [x, {y}]} = {p: ['a', {'b'}]}
        # 这里p是模式，不是变量，所以不声明或赋值
    let obj = {}, arr = [];
    ({foo: obj.prop, bar: arr[0]} = {foo: 1, bar: 0});
        # 嵌套值, 不加()时{}会被解释成代码块
    var {x = 3} = {};
    let {log, sin, cos} = Math
        # 将对象的方法赋值到变量
    let n = {...{a: 3, b: 4}}    // {a: 3, b: 4}
        # 扩展null, undefined会被忽略
        # 被扩展对象中的getter会执行
        let n = {x: 1, ...a}
            # a中的x属性会被覆盖掉, 原理同Object.assign
        let {x, y, ...z} = {x: 1, y: 2, a: 3, b: 4}
            # x // 1, y // 2, z // {a: 3, b: 4}
            ## z 是引用

    o-> 基本类型
    const [a, b] = 'hello'
    let {toString: s} = 123
        # let {toString: s} = true
        ## 如果右边不是对象，先包装
        ### null 和 undefined不能匹配

    o-> 函数
    function add([x, y]){}
    add([1, 2])
    function move({x = 0, y = 0} = {})
        # function move({x, y} = {x: 0, y: 0}) 是错误的

    o-> 圆括号
    [(b)] = [3]
    ({p: (d)} = {})
    [(parseInt.prop)] = [3]
        # 只有非声明语句的非模式部分可以用圆括号

    o-> 用途
    [x, y] = [y, x]
        # 交换值
    function f(){return [1, 2]}
    var [a, b] = f();
    function f(){return {foo: 1, bar: 2}}
    var {foo, bar} = f();
        # 函数返回多个值
    function f([x, y]){}
    f([1, 2])
    function f({x, y, z = 3}){}
    f({y: 2, x: 1})
        # 参数定义
    let {id} = {id: 42, status: 'ok'}
        # json匹配
    var map = new Map(); map.set('a', 1)
    for(let [, val] of map){}
        # 遍历map
    const {SourceMapConsumer, SourceNode} = require('source-map')
        # 输入模块方法
    
## 函数
    基础
        定义一次，执行任意次。js的函数是参数化的
        形参 标识符列表(函数中定义的变量)，调用时为其提供实参值。
        初始化对象的函数是构造函数
        在js中，函数即对象，可以随意传递，可以设置属性和调用该函数的函数
        在js中，函数可以嵌套定义, 嵌套的函数可以访问被定义所处作域中的变量，这个作用域就是闭包(closure)
            # 嵌套函数的闭包给js带来非常强劲的编程能力
        return停止函数执行并返回它的表达式。没有表达式时返回undefined。没有return语句时返回undefined
        this是关键字，不是变量或属性名，所以不允许赋值。
            this没有作用域限制
        函数是对象，但typeof经过处理，所以返回"function", 可以拥有静态属性和方法，可以用内部构造函数Function()创建
        将函数绑定到Function.prototype上，以便所有函数对象都继承它
    关键字
        this
            # 除实参外，每次调用拥有一个调用上下文 this, 对象调用函数时, 此次调用上下文是该对象。
        super
            super()调用父类的构造方法, super相当与父类的实例，super同时部署了父类的静态属性
            对象总是继承其他对象，所以在任意对象中，都可以使用super, 如
                var obj = {toString() {return 'a ' + super.toString() }}
        new.target
            # 构造函数中使用, 返回调用该构造函数时new 命令作用的对象, 如果直接调用等, 则值为undefined 
            function Person() {new.target === Person}
            class {constructor() {new.target}}
                # 子类继承父类调用super()时, 父类构造方法中new.target指向子类
                ## 可以利用写出不能继承的类
    定义
        # 精心挑选的函数名可以极大地改善代码的可读性
        ## 函数名通常是动词或以动词为前缀的词组，常用的写短
        function a(){}            # 声明和定义均提前
                        # ecma只允许它作为顶级语句，不能出现在循环、条件判断或者try/cache/finally及with语句中
                        ## 一些js实现并未严格遵守规则，比如firefox就可以在if中出现函数声明
        var a = function(){}        # 只声明提前。可作匿名函数
                        # 此为函数定义表达式, 可以出现在js代码的任何地方
        o.m = f            # 给已有对象的属性引用方法
    创建函数
    function fun(){}
    var fun = function {}
    var fun = new Function("输入变量1","输入变量2","执行内容");            # 动态创建函数
    var f = (a, b) => a + b
        # 箭头函数特性: 
        ## 没有自己的this, this是外部的this, 所以不能用call, apply, bind改变this
        ## 不能当作构造函数, 没有super, new.target
        ## 没有arguments, arguments是外部的
        ## 不能成为Generator
        # var f = n => n
        # var f = () => {return 1}
        # var f = () => ({a: 1})
        ## 大括号解释为代码块, 要返回对象时用圆括号括起来
        # const pipeline = (...funcs) => val => funcs.reduce((a, b) => b(a), val)
        ## 返回闭包
        ## const plus1 = a => a + 1, mult2 = a => a * 2, addThenMult = pipeline(plus1, mult2);
        ## addThenMult(5)    // 12
        # let insert = val => ({into: (arr) => ({after: (afterVal) => {
        ##     arr.splice(arr.indexOf(afterVal) + 1, 0, val); return arr;
        ##}})})
        ## insert(2).into([1, 3]).after(1)    // [1, 2, 3]
    参数
    function f(x, y = 5)
        # f({x: 1, y: 2})可以模式匹配
        # 默认值可以是变量，作用域是函数内作用域。函数a默认值是函数b时, 函数b的作用域链不包含函数a
        # 默认值一般在最后, 可以一眼看出哪些参数可以省略，调用时也好看
    function f(url, {method = 'GET'} = {})
    function f({a, b}) {a, b}
        # f({a: 1, b: 2}) 对象匹配
    function f(a = throwErr())
        # 设置不可省略的参数, 默认值是延迟计算的
    function f(...rest)
        # 一定在末尾
    嵌套函数
        特性    
            内部嵌套函数可以读写外部参数
            this不会在嵌套函数中继承，函数调用和方法调用中this的规则不变。
                # 如果要在内部访问外部this, 需要将外部this保存到变量中(通常用self, [that 是传递this时使用的变量名])
    调用
        方式
            作为函数
            作为方法
            作为构造函数
            通过它们的call()和apply()方法间接调用
        原理
            调用由函数对象，左圆括号，参数列表(逗号分隔)，右圆括号组成
            每个参数表达式都会计算出一个值作为实参传递给声明时定义的形参
                # 在函数体中存在一个形参的引用指向当前传入的实参列表
            函数表达式的值成为调用表达式的值
            ECMAScritp 3和非严格ECMAScript 5中，函数调用上下文(this)是全局对象。严格模式下是undefined
                # 常用this判断是否严格模式
        调用表达式
            f()                # 作为普通函数调用
            o.m(x, y)            # 函数表达式本身就是属性访问表达式 
                            ## 此时函数作为一个方法调用
                            ### 方法调用的上下文是该调用对象o
            o["m"](x, y)
            a[0](z)                # 可以用方括号来方法调用
            a.b.c()
            f().m()                # 方法链, 链式调用。比如jquery库。    
                            ## 与构造函数的链式调用不同
                            ## 方法并不需要返回值时，最好直接返回this
    构造函数调用
        # 方法名前带有new, 就是构造函数的调用
        # 与普通的函数调用及方法调用在实参处理、调用上下文、返回值方面都不同
        # 定义一类(class)对象，创建对象继承构造函数的prototype属性
        ## class看作是对象类型的子类型
        # 使用新对象作为调用上下文, 如new o.m()中，this不是o
        # 如果return一个对象，则构造的就是这个对象，如果返回原始值或没有值，则忽略返回值
        原理
            计算实参表达式，传入函数内。没有形参，允许省略实参列表和圆括号，如
                var o = new Object()        # 无参时圆括号可以省略
            创建空对象，继承构造函数的prototype, 试图初始化该对象，并将该对象作为调用上下文
                # 尽管构造函数看起来像方法调用，但它用新对象作为调用上下文
                ## 所以 new o.m()看起来是方法调用，但它的调用上下文并不是o
            通常不使用return关键字，显式返回构造的新对象
                显式使用return时，如果没有值或是原始值，就忽略return。如果是对象，就返回return的对象
    间接调用
        call和apply
            可以显式指定调用上下文，这样任何函数都可以作为任何对象的方法来调用
            call使用自有的实参列表作为函数实参，apply以数组形式传入参数
    实参和形参
        不检查传入的参数类型和参数个数，所以要手动做参数检查
            # 传入参数少时，剩下的形参都设置为undefined
            ## 所以在参数检查时，要给省略的参数赋默认值。如 a = a || []
            ### a = a || [] 是习惯用法，用来代替if语句，前提是a必须预先声明
            # 前面的参数可选且不传时，传入占位符null(也可以传undefined)
            # 函数定义中使用/*optional*/来强调形参可选, 如
            ## function f(o, /*optional*/ a)
        可变长实参列表(实参对象)
            arguments
            # 是类数组对象，可以通过数字下标访问传入的实参值
            ## 有length属性
            # 这种可以接收任意个数实参的函数    称为 不定实参函数(varargs function)
            # 非严格模式下, 实参对象的数组元素是函数形参对应实参的别名，改变实参值时，实参对象中的值也改变
            ## ECMAScript 5中移除了别名这个特性(实测没有移除)
            # 非严格模式中, arguments是一个标识符，严格模式中，它是一个保留字
            arguments的callee和caller属性
                # ECMAScript 5 严格模式中，对这两个属性的读写操作都会产生类型错误
                非严格模式中, callee指代当前正在执行的函数，caller是非标准的，但大多数浏览器都实现了这个属性，指代调用callee的函数。
                    # 通过caller属性可以访问调用栈
                可通过callee递归调用自身
                    var factorial = function(x){
                        if( x <= 1) return 1;
                        return x * arguments.callee(x-1)
                    }
        对象属性作实参，如
            easycopy({from: a, to: b, length: 4})
            function easycopy(args){
                args.from;
                args.from_start || 0;
            }
        类型注释
            function max(/*number*/a, /*optional*/b, /*array*/c, /*integer*/d, /*index*/e){
                if(isArrayLike(c)){
                    if(isFinite(a));
                }
            }
    函数作为值
        function a(){}
            # 定义创建函数对象，赋值给a。函数对象的名字是看不见
        o.f = f
            # 将函数赋值给对象的属性，就称为方法
        var a = [function() {}, 20]
            # 没有名字的函数，放在数组直接量中
    函数的自定义属性
        # 如当函数需要专属常量时，可在上面定义静态属性
        ## 如要求函数返回唯一整数，可以定义静态属性做个计数器，
        ## 如果要做缓存，也可以定义多个静态属性来缓存返回过的结果，属性名就是传入过的值
    作命名空间
        # 无法声明只在一个代码块中可见的变量。所以定义一个函数做临时命名空间
        ## 有些js扩展中(如mozilla的java script 1.7)可以使用let声明语句块内的变量, 如
        ### let(x = 1){ print(x)}
        (function(){
        }());
            # 匿名函数不会定义全局函数变量并运行
            ## 定义了内部的局部变量
            # 最外层圆括号是习惯写法，尽管有些时候没必要也不应当省略
    闭包
        # js采用词法作用域(lexical scoping), 函数的执行依赖变量作用域。作用域在函数定义时决定，而非调用时
        ## 当前函数的变量保存在函数作用域内(闭包)
        ### 闭包指函数变量可以被隐藏于作用域链之内，象是函数将变量"包裹"了起来
        # 每函数中引入当前作用域链
        定义时与运行时
            大多定义函数时的作用域链在调用函数时依然有效
            调用函数时与定义函数时作用域链不是同一个时
                如返回内部嵌套的函数a时，外部运行a，其作用域链仍然是a的作用域链而非外部作用域链
        作用
            捕捉局部变量并一直保存
        原理
            如果一个函数的局部变量定义在cpu栈中, 函数返回时它们的确不存在了
            js中作用域链是一个对象列表，不是绑定的栈。
                运行js函数a时, 都创建新的对象保存局部变量。该新对象添加到作用域链中
                    函数a返回时，从作用域链中删除该局部变量对象，等待垃圾回收
                    如果a有嵌套函数，每个嵌套函数各自对应一个作用域链
                        # 该嵌套函数的作用域链，保留a的局部变量对象
                        嵌套函数在a中局部变量对象中保存时，会随其一起从作用域链删除
                        嵌套函数被返回或被外部引用时, 该嵌套函数不被回收，且其自身作用域链中的自身局部变量对象、a的局部变量对象也不删除。
            闭包的this值会随外部调用者而变动，所以要先将this转存。var self = this;
                闭包中使用的arguments也会变动，也要转存。var outerArguments = arguments;
    可调用对象
        # 如"类数组对象"不是真正的数组，"可调用对象"不是函数，但所有函数都是可调用的
        # 可调用对象使用越来越少
        例如
            ie8及之前的版本window.alert()和document.getElementById()使用了可调用的宿主对象
            RegExp对象可以直接调用(如RegExp()), 是非标准特性, Netscape提出后被后续浏览器兼容
                # typeof RegExp可能是"function"也可以是"object"
                # 最好不要对可调用RegExp对象有太多依赖，其可调用特性将来可能被删除
### generator
    基本
        generator生成的遍历器g, g[Symbol.iterator]()得到自己。继承它prototype上的方法
            # generator中this添加的属性, 生成的遍历器实例中没有, generator new相当于执行得到遍历器
            # g.bind(obj) 可以改变generator中的this
        作为对象属性时写做 {* g() {}}, {g: function* () {}}
    应用
        状态机
        协程(coroutine)
            generator是半协程(semi-coroutine), 只有generator函数的调用者，才能改变程序运行状态
            将多个协作的任务写成generator, 用yield语句交换控制权
        异步程序同步写法
        部署iterator接口
        可看作数组结构
    yield
        # 惰性求值
        # 在表达式中时加圆括号, 如'hello' + (yield 1)，字符串模板中`${yield}`
        # var n = yield i; g.next(1) 来返回值给n, g.next()返回undefined
        ## 第一次调用g.next()不能传值，因为执行第一个yield之前的代码, 还没有yield来接收
        var a = yield* g()
            # 展开g()得到的generator(可展开所有iterator), 是for ... of的一种简写形式
            # g()中有return 时, a 得到return 的值
        yield [a(), b()]
            # 非展开，而是并列执行, 全部执行返回时返回
    throw
        # 外部的throw语句只被外部捕获
        # generator中throw的错误先内部捕获，再抛出, g.throw(1)相当于从内部yield处抛出一个错误
        ## generator抛出错误后不再能继续执行，再执行返回done=true
        var g = function* () {try {yield;} catch (e) {}}
            # 可以多个yield一个try catch ,  而回调函数只能一个回调一个try catch
        var i = g(); i.next()
        try{i.throw('a'); i.throw('b') } catch(e){}
            # 内部捕获a, 外部捕获b
    return
        # 相当于强制内部return
        # generator中有finally时, g.return()延迟到所有finally执行后执行，再结束
        g.return(0)    // {value: 0, done: true}
    使用
        function* f () {
            yield 1; yield 2; return 3;
        }
        var ff = f(), ff.next()
            # {value: 1, done: false}, {value: 2, done: false}, {value: 3, done: true}, {value: undefined, done: true}
            ## 没有return语句时, 去掉第三个结果，其它不变
    自动执行
        # 写执行器处理thunk和promise
        非promise
            thunk函数, 把回调函数抽离出来
            
### promise
    介绍
        promise有三种状态: 进行中(pending)、完成(fulfilled)和失败(rejected)
            # 状态可以由pending转换成fulfilled，或pending转换成rejected
            # promise的状态转换只发生一次，之后代码会执行，但抛出的错误不捕获
        ## p2中return p1, 则p1的状态决定了p2的状态, 如果p1是resolved或reject, p2的回调立即执行
        ### 所以返回promise对象时, then的回调相当于返回promise的then的回调
        新建即执行，不能取消。内部错误不抛出。无法得到具体pending状态
    使用

### async 
    基本
        generator的语法糖, 自动执行generator, 处理promise
        内置执行器，返回promise对象
    使用
        var asyncReadFile = async function () {
            try {
                var f1 = await readFile('/etc/fstab');
            } catch (e) {}
            await p2.catch(function (e) {})
        }
### class
    基本
        所有方法在prototype上(constructor, static外)，不可枚举
        无变量提升
        类内部即严格模式
        class A的A.name = 'A', 意义同函数名

    o-> 语法
    class Point {
        constructor(x, y) {
            # 不定义时，生成空constructor方法
            # this代表新生的实例
            this.x = x, this.y = y;
        }
        toString() {return 'a'}
        [methodName]() {}
        get prop() {...}
        set prop(val) {}
        * [Symbol.iterator]() {}
        static sMethod() {}
            # 相当于直接在Point上定义
            # es6 内只有方法，没有属性
        prop: 1
            # es6中忽略, es7提案
        static prop2: 2
            # es6中忽略 es7提案
    }
    Point.a = 1;
        # es6 静态属性只能在class外部定义
    var point = new Point(2, 3);

    o->
    var A = class B{};
        # 这时类的名字是A, 而B只能在类内中指代自己
    var A = class {};
    var a = new class {}();

    o-> 继承
        # 两条原型链
        # Object.setPrototypeOf(B.prototype, A.prototype)
        ## B.prototype.__proto__ = A.prototype
        ### 作为构造函数, 子类B的prototype是A的实例
        # Object.setPrototypeOf(B, A)
        ## B.__proto__ = A
        ### 作为一个对象, 子类B的原型是A(强行成为继承关系来得到A的静态属性)
        ### B.__proto__.__proto__ = A.__proto__, 子类原型的原型是父类的原型
        # 继承的特殊种类
        ## class A {}, A.__proto__ = Function.prototype, A.prototype.__proto__ = Object.prototype
        ## class A extends null {}, A.__proto__ = Function.prototype, A.prototype.__proto__ = undefined
    class A extends B {
        constructor(x, y, color) {
            super(x, y);
                # 调用B的constructor
                # 必须调用super来创建父类对象作用自己的prototype, 否则整个继承失败，报错
            this.color = color
                # this必须在super调用之后才能使用, 否则没有prototype生成this, 报错
        }
            # 默认construcotr为constructor(...args) {super(...args)};
    }
    let cp = new A(1, 2, 'a')
    cp instanceof A    // true
    cp instanceof B    // true

    o-> 继承原生构造函数(es5不可以)
    function MyArray() {Array.apply(this, arguments)}
    MyArray.prototype = Object.create(Array.prototype, {constructor: {
        value: MyArray,
        writable: true,
        configurable: true,
        enumerable: true,
    }})
        # es5机制决定先新建子类实例this, 再将父类属性添加到子类上。父类的内部属性无法获取(如Array的[[DefineOwnProperty]])。
    class MyArray extends Array {
        constructor(... args) {
        super(... args);
        }
    }
    # es6允许继承原生父类构造函数定义子类, 即先新建父类this, 再用子类修饰, 父类的所有行为都可继承

    o-> 用mixin来混合继承
    class A extends mix(B, C)
#### decorator
    介绍
        编译时执行
        相当于 class A {}, A = decorator(A) || A;
        不能用于函数，因为函数提升?

    o-> 修饰类
    function testable(target) {
        # target是被修饰的类, 参数2为属性名, 参数3为属性描述对象
        target.isTestable = true;
    }
    function testable(val) {
        return function(target) {
            target.isTestable = val;
        }
    }
    @testable
    class A {}
    A.isTestable    // true

    o-> 修饰类属性
    function readonly(target, name, descriptor) {
        descriptor.writable = false;
        return descriptor;
    }
    class Person {
        @readonly
        name() {return 0}
    }
### 函数式编程
    介绍
        js不是函数式编程语言，但可以像操控对象一样操控函数。
    数组的函数式编程
        # ECMAScript 5
        [1, 1, 3, 5, 5].reduce(function(x, y){ return x + y;})        # 返回总和 15
        [1, 4, 9].map(function(num){return num * 2;})            # 返回数组 [2, 8, 18]
    高阶函数(higher-order function)
        # 就是操作函数的函数
        ## 接收函数作为参数，并返回新函数
    不完全函数(partial function)
        # 把一次调用拆成多次调用，每次调用返回一个函数，如f(1,2)(3,4)(5,6)
        # 每次调用叫做不完全调用(partial application)
        函数f()的bind()方法返回新函数，给新函数传入特定上下文和参数，再调用函数f()
            # 新实参在左侧
#### 自定义函数
    基本
        generator生成的遍历器g, g[Symbol.iterator]()得到自己。继承它prototype上的方法
            # generator中this添加的属性, 生成的遍历器实例中没有, generator new相当于执行得到遍历器
            # g.bind(obj) 可以改变generator中的this
        作为对象属性时写做 {* g() {}}, {g: function* () {}}
    应用
        状态机
        协程(coroutine)
            generator是半协程(semi-coroutine), 只有generator函数的调用者，才能改变程序运行状态
            将多个协作的任务写成generator, 用yield语句交换控制权
        异步程序同步写法
        部署iterator接口
        可看作数组结构
    yield
        # 惰性求值
        # 在表达式中时加圆括号, 如'hello' + (yield 1)，字符串模板中`${yield}`
        # var n = yield i; g.next(1) 来返回值给n, g.next()返回undefined
        ## 第一次调用g.next()不能传值，因为执行第一个yield之前的代码, 还没有yield来接收
        var a = yield* g()
            # 展开g()得到的generator(可展开所有iterator), 是for ... of的一种简写形式
            # g()中有return 时, a 得到return 的值
        yield [a(), b()]
            # 非展开，而是并列执行, 全部执行返回时返回
    throw
        # 外部的throw语句只被外部捕获
        # generator中throw的错误先内部捕获，再抛出, g.throw(1)相当于从内部yield处抛出一个错误
        ## generator抛出错误后不再能继续执行，再执行返回done=true
        var g = function* () {try {yield;} catch (e) {}}
            # 可以多个yield一个try catch ,  而回调函数只能一个回调一个try catch
        var i = g(); i.next()
        try{i.throw('a'); i.throw('b') } catch(e){}
            # 内部捕获a, 外部捕获b
    return
        # 相当于强制内部return
        # generator中有finally时, g.return()延迟到所有finally执行后执行，再结束
        g.return(0)    // {value: 0, done: true}
    使用
        function* f () {
            yield 1; yield 2; return 3;
        }
        var ff = f(), ff.next()
            # {value: 1, done: false}, {value: 2, done: false}, {value: 3, done: true}, {value: undefined, done: true}
            ## 没有return语句时, 去掉第三个结果，其它不变
    自动执行
        # 写执行器处理thunk和promise
        非promise
            thunk函数, 把回调函数抽离出来
            
## 对象 
    基础
        一种复合值。属性的无序集合，属性由名/值对组成，看作字符串到值的映射。
            # 这种数据结构叫做散列(hash), 散列表(hashtable), 字典(dictionary), 关联数组(associative array)
            # 常用来模拟静态对象或静态语言的结构体。也可以模拟json字符串
        可以基于原型(prototype)继承属性，称作原型式继承(prototypal inheritance)
        除了字符串、数字、true、false、null、undefined外，js中的值都是对象
            # 字符串、数字、布尔值可以自动包装为对象(构造函数的实例)
        对象操作通过引用(而非值)。
        常见属性操作
            创建(create)
            设置(set)
            查找(query)
            删除(delete)
            检测(test)
            枚举(enumerate)
    组成
        属性的名/值对 + 属性特性(property attribute) + 对象特性(object attribute)
                属性名可以是空字符串，不能重名
            属性特性包括: 可写(writable attribute), 可枚举(enumerable attribute), 可配置(configurable attribute)
                # 可配置表明是否可以删除或修改该属性
                # 通过代码给对象创建的所有属性都是可写、可枚举、可配置的
                ## ECMAScript 5 中可以改变
            对象特性包括
                对象原型(prototype)            # 指向另外一个对象, 本对象继承它的原型
                对象的类(class)                # 一个标识对象类型的字符串
                对象的扩展标记(extensible flag)        # ECMAScript 5中指明是否可以向该对象添加新属性
    分类
        内置对象(native object)            # 由ECMAScript定义的对象或类。如数组、函数、日期、正则表达式
        宿主对象(host object)            # js解释器( 如web浏览器)嵌入的宿主环境,如 HTMLElement对象
                            ## 宿主环境定义的方法可当作普通js函数对象, 宿主对象可当作内置对象
        自定义对象(user-defined object)        # 运行中的js代码创建的对象
        自有属性(own property)            # 直接在对象中定义的属性
        继承属性(inherited property)        # 对象的原型对象中定义的属性
    原型
        每一个js对象(null除外)都与另一个对象(原型)关联，从原型继承属性。
        内容
            对象直接量创建的对象有同一个原型对象Object.prototype
            new的对象原型是构造函数prototype的属性的值
                # 于是new Object()创建的对象继承自Object.prototype
            Object.prototype这个对象没有原型
            具体
                除Object.prototype的对象是普通对象，都有原型。
                所有内置构造函数都继承Object.prototype
                    # 如new Date()创建的对象同时继承Date.prototype和Object.prototype
                    ## 这一系列的链接的原型对象就是"原型链"(prototype chain)
    创建对象
        {}            # 对象直接量创建
            # ECMAScript 5中(ECMAScript3的部分实现), 保留字用作属性名可以不带引号
            ## ECMAScript 3中保留字作属性名必须用引号
            # ECMAScript 3的IE中, 最后一个逗号不可以忽略
            # 每次计算对象直接量，都会计算它的每个属性的值
        new            # 关键字创建
            # new后的函数是构造函数(constructor)。
        Object.create()        # ECMAScript 5中出现的静态函数
                    ## 参数1是原型对象, 参数2可选，对对象属性进一步描述
            Object.create({x:2})
            Object.create(null)
                    # 传入参数null来创建没有原型的新对象。
                    ## 没有原型的对象没有toString等方法, 所有不能+运算
            Object.create(Object.prototype)
                    # 创建普通对象
    
    对象序列化(serialization)
        # json(JavaScript Object Notation)
        ECMAScript 5 api
            # stringify, parse的第二个参数可选，传入属性列表来定制序列化或还原操作
            JSON.stringify()
                # 支持对象, 数组, 字符串, 无穷大数字, true, false, null。NaN, Infinity, -Infinity序列化结果是null
                ## 日期stringify为日期字符串，parse不能还原成对象    
                ## 只序列化对象的可枚举自有属性。不能序列化的属性自动省略掉
                # 函数, RegExp, Error对象和undefined不能序列化和还原
            JSON.parse()
    创建对象                # 函数即对象，本身为构造方法
        var obj = {};        # var obj = []是数组, 数组中Obj['aa']添加的是属性而非成员
                    ## 静态对象
        function Obj(a, b){};
            new Obj(a, b);
        function Obj(a, b){
            thisf = new Array();
            return new Object(a, b)
        };            
            Obj(a, b);                        # 只能返回Obj里定义的新对象的实例(不能返回本身的实例)
                                        ## 内的变量函数静态。指向外部函数可动态
                                        ## 内对象为动态
            new Obj(a, b);                        # 内变量函数动态(内存浪费)
            Obj.prototype.c = 'c'
            Obj.prototype.d = function(){};
            Obj.prototype.e = new Array();            # prototype函数为静态函数
                                        ## prototype对象为静态
        function Obj(a, b){
            if(typeof Obj._initialized == 'undefined'){
                Obj.prototype.c = function(){};
                Obj._initialized = true;
            }
        }                                # 内部prototype, 与外部完全相同
        最好方式:
            内部定义变量和对象, prototype定义函数(防止new对象的函数动态)。
            prototype定义函数可以在内部，也可以在外部。
        扩展对象
            Obj.prototype.extend                # 添加或重写当前对象的属性
            Object.prototype.extend            # 所有对象上添加属性
### 属性
    查询和设置
        . []
            # ECMAScript 3中, 点运算符后的标识符不能是保留字。ECMAScript5(包括ECMAScript3的某些实现)中可以
            # []中必须返回可以转换为字符串的值
            ## []的写法用了字符串索引，叫做关系数组(associative array), 散列或字典
        属性不存在时自动创建
    描述对象
        value
        writable
            # 可修改
        enumerable
            # 可枚举性
            ## for...in, Object.keys(), JSON.stringify(), Object.assign(), Reflect.enumerate()会忽略不可枚举属性
            # for...in等价Reflect.enumerate(), 会返回继承的属性
        configurable
            # 可配置
    遍历属性
        # 先遍历属性名是数值的属性，再遍历字符串，再遍历Symbol
        for ... in
            # 自身和继承的可枚举属性
        Object.keys
            # 自身的可枚举属性(不含Symbol)
        Object.getOwnPropertyNames
            # 自身所有属性(不含Symbol)
        Object.getOwnPropertySymbols
            # 自身所有Symbol属性
        Reflect.ownKeys
            # 自身所有属性
        Reflect.enumerate
            # 同for ... in
    访问错误
        查询不存在的属性不报错, 返回undefined
        对象不存在，会查询null和undefined的属性，会报错
            建议写法如下
                var len = book && book.subtitle && book.subtitle.length
        只读的设置不报错，如
            # ECMAScript 5的严格模式中会报错
            Object.prototype = 0;        
    设置属性失败的情况
        o中属性p是只读的        # defineProperty()可以
        o中属性p是继承属性，且它是只读的
        o没有属性p, o没有使用p的setter方法, o可扩展性为false
    删除属性
        delete
            # 删除成功，属性不存在，不是属性访问表达式时，返回true
            # 属性可配置性为false，非严格模式下返回false, 严格模式下抛出异常
            # 全局对象可以不用属性访问表达式, 如 delete x;
            ## 严格模式下, delete x; 会报语法错误, 必须delete this.x
            只是断开联系
            只删除自有属性，不能删除继承属性
                # 继承属性可以从原型对象上删除它
                # a = {p:{x:1}}; b= a.p; delete a.p; 执行后p.x还是1。因为属性的引用依然存在
                ## 会内存泄漏，所以在销毁对象时，要遍历属性中的属性，依次删除
    检测属性
        in                    # 检测自有属性和继承属性
            "x" in o;
        o.x !== undefined            # 同in，但没法区分属性的值为undefined时的属性，in可以
                            ## !==可以区分null和undefined, 所以用!==
        hasOwnProperty()            # 只检测自有属性
            o.hasOwnProperty("x");
        propertyIsEnumerable()            # 自有属性且可枚举
            o.propertyIsEnumerable("x")
    枚举属性
        # ECMAScript 3 的不可枚举属性不能得到
        for/in
            # ECMAScript 5之前, 工具库给Object.prototype添加的属性必须可枚举
            ## 所以for/in会枚举出来，要用hasOwnProperty(p)来过滤    
        Object.keys()                    # ECMAScript 5中定义，返回可枚举的自有属性名数组
        Object.getOwnPropertyNames()            # ECMAScript 5中定义，返回自有属性名数组
    getter和setter
        # 通常用来表示同一组数据的两种方法(如笛卡尔坐标系表示法和极坐标系表示法)
        ## 也用于检测属性的写入和读取值
        # ECMAScript 5中属性值可以用方法替代，就是getter和setter, 叫做存取器属性(accessor property)
        ## 是访问描述符，相对数据描述符(如writable)
        ## 普通的属性叫做数据属性(data property), 只有一个简单的值
        ## 存取器属性不具有可写性(writable attribute)
        ### 作为替代, 只有getter, 则只读。只有setter, 则只写。同时拥有, 则可读写
        #### 读取只写属性总是返回undefined
        # 存取器属性是可以继承的
        定义
            var o = {
                data_prop: 1,
                get accessor_prop(){},
                set accessor_prop(value){}
                    # 函数中的this表示当前对象o
            };
            var descriptor = Object.getOwnPropertyDescriptor(o, 'accessor_prop');
            'get' in descriptor    // true
            'set' in descriptor    // true
        例子
            var p = {
                $x: 1.0, 
                $y: 1.0,
                get r () {return Math.sqrt(this.x * this.x + this.y * this.y);},
                set r (newvalue) {
                    var oldvalue = Math.sqrt(this.x * this.x + this.y * this.y);
                    var ratio = newvalue/oldvalue;
                    this.x *= ratio;
                    this.y *= ratio;
                },
                get theta () {return Math.atan2(this.y, this.x); }
            }
        例子
            var serialnum = {
                # 序列
                $n: 0,
                    # $暗示私有属性
                get next(){return this.$n++;},
                set next(n){
                    if(n >= this.$n) this.$n = n;
                    else throw "序列号的值不能比当前值小";
                }
            }
        例子2
            var random = {
                # 返回不同数量范围的随机数
                get octet(){ return Math.floor(Math.random() * 256)},
                get uint16(){ return Math.floor(Math.random() * 65536)},
                get int16(){ return Math.floor(Math.random() * 65536) - 32768}
            };
    属性的特性
        # ECMAScrit 3这些特性不可以配置, ECMAScript 5中提供查询和设置的api
        作用
            给原型对象添加方法，设置该方法为不可枚举，看起来像内置方法
            给普通对象定义不能修改或删除的属性，实现"锁定"
        组成
            值(value), 可写性(writable)、可枚举性(enumerable)、可配置性(configurable)
                # 存取器特性是读取(get)、写入(set)、可枚举性、可配置性
        原理
            ECMAScript 5定义了 属性描述符(property descriptor)对象, 代表4个特性
                该对象的属性有value, writable, enumerable, configurable, 代表4个特性
                存取器属性描述符用get和set代替value和writable
                    # writable, enumerable, configurable是布尔值
                    ## get和set是函数值, value什么都可以
        调用
            # 新建属性的默认特性对象为false或undefined
            Object.getOwnPropertyDescriptor(o, p)
                # 获得对象o的p自有属性的 属性描述符对象
                ## 要得到继承属性的特性, 要遍历原型链
            Object.defineProperty(o, "x", {
                value: 1,
                writable: true,
                enumerable: false,
                configurable: true
            });
                # 新建或修改自有属性的特性
                # 传入对象和属性名与属性描述符对象
            Object.defineProperty(o, "x", {get: function(){ return 0; }});
                # 修改x为存取器属性
                ## 返回修改后的对象
                # 不允许创建或修改的属性，抛出类型错误异常
                ## 规则(违反则抛异常)
                ### 对象不可扩展，可以编辑已有属性, 不能添加
                ### 属性不可配置, 不能修改可配置性和可枚举性
                ### 存取器属性不可配置, 不能修改getter, setter方法, 不能转换为数据属性
                ### 数据属性不可配置，不能转换在存取器属性
                ### 数据属性不可配置，不能可写性从false修改为true
                ### 数据属性不可配置且不可写, 不能修改值。可配置但不可写时可以修改值
                #### 实际上自动标记为可写，再改值，再转换为可写
            Object.defineProperties({}, {
                x: {value: 1, writable: true, enumerable: true, configurable: true},
                y: {value: 1, writable: true, enumerable:true, configurable:true},
                r: {
                    get: function(){return Math.sqrt(this.x * this.x + this.y * this.y)},
                    enumerable: true,
                    configurable: true
                }
            })
                # 新建或修改多个属性及特性。第一个参数是修改对象，第二个参数是映射表
                ## 返回修改后的对象
                # 不允许创建或修改的属性，抛出类型错误异常
        老式api(ECMAScript 5之前，非IE浏览器)
            __lookupGetter__()
            __lookupSetter__()
                # 返回一个属性的getter和setter
            __defineGetter__()
            __defineSetter__()
                # 定义getter和setter, 第一个参数是属性名, 第二个参数是getter或setter方法
#### 对象三个属性
    包括
        原型(prototype)
        类(class)
        可扩展性(extensible attribute)
    原型
        api
            Object.getPrototypeOf()
                # ECMAScript 5出现, 传入对象返回原型
            o.constructor.prototype
                # 得到对的原型，对于Object.create()创建的对象常不是这样
            p.isPrototypeof(o)
                # 检测p是否是o的原型(或牌原型链中)，与instanceof运算符类似
            __proto__
                # Mozilla实现的js有的属性, safari和chrome也支持
    类属性
        # 表示对象类型信息的字符串, 用toString()方法可以得到
        # ECMAScript 3和5 都不能设置这个属性，只能间接查询
        # js内置构造函数创建的对象类属性与函数名称相匹配
        ## 对象直接量、Object.create、自定义构造函数 创建的对象类属性是"Object"
        ### 对于自定义类来说，没办法通过类属性来区分对象的类
        api
            toString()        # 返回如 [object class], 提取class
                # 很多对象的toString方法重写了, 要间接调用Function.call()方法
            function classof(o){
                if(o === null) return "Null";
                if(o === undefined) return "Undefined";
                    # ECMAScript 5中不需要对null和undefined作处理
                return Object.prototype.toString.call(o).slice(8, -1);
            }
    可扩展性
        # 表示是否可以给对象添加新属性。ECMAScript 5中 内置对象和自定义对象都显式可扩展
        ## 宿主对象可扩展性由js引擎定义
        api
            # preventExtensions, seal, freeze 都返回传入的对象
            Object.esExtensible()            # 判断对象是否可扩展
            Object.preventExtensions()        # 转换对象为不可扩展, 参数为待转换对象
                                ## 对象转换不可扩展后，无法再转换回来
                                ## 给不可扩展对象原型添加属性, 对象同样会继承新属性
            Object.seal()                # 对象设置不可扩展, 同时对象自有属性不可配置
                                # 已有属性标记为可写的依然可配置
                                # seal后的对象不能解封
            Object.isSealed()            # 检测对象是否封闭
            Object.freeze()            # 除了seal外，将自有数据属性设置为只读
                                ## setter方法不受影响
            Object.isFrozen()            # 检测是否冻结
#### 继承
    介绍
        js对象有自有属性(own property)，有从原型继承来的属性
    原型链(prototype chain)
        # 原型，原型的原型 ...
        属性的查询先找自有属性，再找原型链
        属性修改时, 先检查属性是否允许赋值。
            # 总在自有属性修改或创建，不修改原型链上的对象。这就是属性的覆盖(override)
            ## 继承的对象有setter方法且是accessor属性时，修改属性时会由当前对象(非原型对象)调用setter方法。
            ### 由当前对象调用，所以还是不会修改原型链
            ### setter方法如setTitle()
    inherit(p)函数
        function inherit(p){
            if(p == null) throw TypeError();
            if(Object.create) return Object.create(p);
            var t = typeof p;
            if(t !== "object" && t !== "function") throw TypeError();
            function f(){};
            f.prototype = p;
            return new f();
        }
        var o = {x: "don't change this value"};
        library_function(inherit(o));
            # 可以防止对o的意外修改

### 数组
    介绍
        数字索引        # 最大索引 2^32 - 2
                    ## 实现经过优化, 数字索引访问比访问常规属性快很多
        元素无类型
        数组是动态, 根据需要它们会增长或缩减
        数组可能是稀疏的, 索引不一定连续, length对于稀疏数组取最大索引+1
    原理
        数组对象使用小于0 ~ 2^32 - 2 非负整数属性名时, 自动维护其length属性值
        [] 索引内的数字作为索引创建和访问, 其它作为属性
        a['1'] 同 a[1] 同 a[1.000]
        数组可以原型继承, 可以定义getter, setter方法
        数组元素可以delete, in, for/in
            # delete a[0]
            # 0 in a
    稀疏数组
        # 稀疏数组比稠密数组更慢, 内存利用率更高, 查找元素与常规对象属性查找时间一样长
        # for/in时会跳过未有元素
        a = new Array(5)
        a = [, , ,]
        a = [1, , 3]
            # 旧版本实现中, [1,,3]与[1,undefined, 3]是一样的，不是稀疏数组
        a[1000] = 0
    创建与调用
        var misc = [1.1, , true]        # 第二个是undefined
        new Array()
        new Array(10)                # 预分配数组空间
        new Array(5, 4, "testing")
        a[0]        
        a.length    
            # length大于每一个索引            
            # 对lenght赋值, 小于length索引的元素将删除, 如length=0清空数组
            ## Object.defineProperty()让数组的length变成只读
            ### Object.defineProperty(a, "length", {writable: false})来避免删除元素
            ## 让数组无线不能配置也可以，如Object.seal, Object.freeze方法
    添加删除
        a[1] = "a";
        a.push("zero", "one")
        delete a[1]
        a.pop()            # 反push
        a.shift()        # 头部删除, 重改所有元素索引
        a.unshift()        # 反shift, 头部插入元素
        splice()            # 通用方法插入, 删除, 替换数组元素, 根据需要修改length属性
    遍历
        for(var i = 0; i < a.length; i++)    # 判断undefined
        for(var index in a){            # 会遍历出Array.prototype中的方法, 要进行过滤
                            ## ECMAScript 允许for/in遍历顺序不同, 一般是升序的
                            ### 如果同时有属性和元素，很可能是创建顺序
            if(!a.hasOwnProperty(i)) continue;
            // if(String(Math.floor(Math.abs(Nuber(i)))) !== i) continue;        # 跳过不是正整数的i
        }
        a.forEach(function(x){})        # ECMAScript 5定义的新方法
    多维数组
        # js不支持真正的多维数组，可以用数组模拟
        var a = new Array(10)
        a[0] = new Array(10)
        a[0][0]
    空位问题
        Array(3)    // [, , , ]
            # 没有0位置, 但length = 3, 不同于有0位置但值为undefined
            # es5中对空位处理很不一致, 一般是跳过, es6会将空位值转为undefined
    类数组对象
        # 与数组相似的对象
        # 字符串虽然与数组类似，但length没有限制, 最好不看作类数组对象
        特性
            自动更新length属性, length设置后自动截断数组
            从Array.prototype中继承了一些有用的方法
            类属性(class)为"Array"(Date等类也是"Date")
        创建
            # 数组的方法对于自定义的类数组对象是通用的
            ## 虽然不能继承Array.prototype, 但可以间接调用Function.call
            要求
                自动维护length属性
                下标是数字字符串并在数组下标范围内
            var a = {"0": "a", "1": "b"}
    作为数组的字符串
        介绍
            ECMAScript 5中，字符串类似只读数组。访问如下
                s.charAt(0)
                s[0]
            Array.isArray(s)是false
            通用字符串方法可以乃至字符串中，如
                # 但字符串是不可变值的，所以中push, sort, reverse, splice在字符串上是无效的, 出错时没有提示
                Array.prototype.join.call('abc', " ")        // => "a b c"
#### 二进制数组
    介绍
        ArrayBuffer, TypedArray, DataView
        TypedArray按小端字节序来处理ArrayBuffer, 大端字节序可以自定义DataView
    TypedArray
        溢出
            正向溢出(overflow)
                uint8[0] = 256    // 0
                    # 值为 数据类型最小值 + 余值 - 1, 这里为 0 + 1 - 1
                int8[0] = 128    // -128
                    # -128 + 1 - 1
            负向溢出(underflow)
                uint8[0] = -1    // 255
                    # 值为 数据类型最大值 - 余值 + 1, 这里为 255 - 1 + 1
                int8[0] = -129    // 127
                    # 127 - 1 + 1
            Uint8ClampedArray负向溢出都为0, 正向溢出都为255
    场景
        o->ajax中
        xhr.responseType设置为 'arraybuffer'来接收二进制数据(也可以设blob)

        o-> canvas中
        ctx.getImageData(0, 0, canvas.width, canvas.height)
        uint8ClampedArray = imageData.data;

        o->　websocket中
        socket.binaryType = 'arraybuffer'
        var arrayBuffer = event.data;
        socket.send(new Uint8Array(4).buffer);

        o-> fetch api中
        返回request.arrayBuffer()得到arrayBuffer数据

        o-> file api中
        reader.readAsArrayBuffer(file);
        reader.onload = function() { var arrayBuffer = reader.result; }
### 集合
    Set
        数据唯一
        Nan等于自身
    WeakSet
        成员只能是对象
        成员弱引用，垃圾回收不考虑其引用，所以不能引用其成员，所以WeakSet不可遍历，因为刚遍历出的成员可能已删除
        可用于储存dom节点，实时判断是否存在，且防止内存泄漏
    Map
        各种类型都可作为键, 键唯一覆盖, NaN等于自身, +0 等于 -0
    WeakMap
        只接受对象作key
        元素被回收后, 自动移除对应的键值对
        适用于dom节点作键名，部署关联外部的私有属性(外部对象删除后，私有属性同步删除)，不会内存泄漏
#### 遍历器
    介绍
        默认三种结构支持, Array, Set, Map。Object不支持，因为不确定遍历顺序
        字符串是类数组，有原生的iterator接口
    内部调用方式
        解构
            let [x, y] = new Set().add(1).add(2);
        扩展运算符
            [...iterable]
        yield* iterable
        参数
            for ... of
            Array.from()
            Map(), Set(), WeakMap(), WeakSet()
            Promise.all()
            Promise.race()
    实现
        iterable[Symbol.iterator] = function* () {
            yield 1;
            yield 2;
        }
        iterable[Symbol.iterator] = function () {
            return {
                next(){},
                return () { return {done: true}}
                    # return 在for ... of 提前退出(出错, break, continue), 可以用于释放资源
                    # return 方法必须返回一个对象，这是Generator规格规定的
                throw() {}
                    # 配合Generator使用
            };
            
        }
    使用    
        var result = iterator.next()
        while(!result.done) {
            var x = result.value;
            result = iterator.next();
        }
### proxy
    介绍
        元编程(meta programming), 在对象外层进行代理
        在obj.proxy上设置Proxy对象，该对象的操作会变成对Proxy对象的操作

    var obj = new Proxy({}, {
        get: function (target, key, receiver) {
            return Reflect.get(target, key, receiver);
        },
        set: function (target, key, value, receiver) {
            return Reflect.set(target, key, value, receiver);
        }
    });
### reflect
    介绍
        将Object上一些明显属于语言内部的方法(如Object.defineProperty)放到Reflect上
        修改Object上原有方法，变得更合理, 如Object.defineProperty在无法定义属性时抛出异常, 而Reflect.definePropert则返回false
        让Object操作变成函数作为, 如name in obj, delete obj[name]变成Reflect.has, Reflect.deleteProperty
        让Proxy上方法与Reflect方法对应，让Proxy的对象操作默认行为在Reflect上执行
## 模块化
    介绍
        es6中模块化思想是尽量静态化，编译时确定模块依赖关系与输入输出
            # CommonJS(CMD)与AMD都只能在运行时确定
            ## UMD模式只是加了CMD和AMD的切换
    CommonJS
        # 输出的是值的拷贝
        # require后的模块运行后缓存, 再require只在缓存中取而不再运行。可以手动清除缓存
        let {stat, exists, readFile} = require('fs')
            # 加载fs所有方法生成_fs, 再取其中3个方法。没法做静态优化
    es6
        # import, export可以出现在顶层的任何位置
        # 模块自动采用严格模式
        # 输出/引入的是值的只读引用, 值在运行时计算
        import
            # 会变量提升, 会执行import的模块
            # 引入的变量是只读的，修改会报错。但可以修改引入变量的内部属性
            # 只加载3个方法，编译时加载，可能静态分析。但不能引用fs模块本身
            # 使引入宏(macro)和类型检查(type system)成为可能
            import {stat, exists, readFile} from 'fs'
                # './profile'
            import {a as b} from './profile'
                # b 作为 a 的别名
            import 'lodash'
                # 只运行模块
            import * as circle from './circle'
            circle.area
                # 引入模块到对象
            import a from './export-default'
                # 引入模块中默认的导出, a 可以起任意名，不用大括号
                ## import {default as xxx} from './' , 本质是输出名字为default变量
            import def, {a} from './module'
                # 同时引入default和其它变量
        export
            export var a = 1;
            export function f () {}

            var b = 1, c = 1;
            export {b, c}
                # 用于统一输出
            export {v1 as sv1}
            export {a as b} from './someModule'
                # 导入同时导出
            export v from 'mod'
                # 导入同时导出, es7提案可省略大括号
            export default function() {}
                # export default命令来配置默认导出, 本质是输出名字为default的变量，系统允许它取任意名
                # export default foo 导出的foo名在模块外部是无效
        继承
            export * from 'circle'
            export var e = 2.7
            export default function() {}
                # 输出了circle模块的所有方法(忽略default), 又输出了自定义属性
    循环引用
        CommonJS会输出已执行的部分
        // a.js
        exports.done = false;
        var b = require('./b.js');
        console.log('a.js => b.done : ', b.done)
        exports.done = true;
        console.log('a.js done')
        // b.js
        exports.doen = false;
        var a = require('./a.js')
        console.log('b.js => a.doen : ', a.doen);
        exports.done = true;
        console.log('a.js done')
        // main.js
        var a = require('./a.js'), b = require('./b.js')
        console.log('main.js => a.done: ', a.done, ' b.done: ', b.done)
            # b.js => a.done: false, b.js done, a.js => b.done: true, a.js done, main.js => a.done: true b.done: true
            ## a.js中require('./b.js'), 阻塞, 执行b.js, b.js中require('./a.js'), 加载已执行的a.js, 执行完b.js回到a.js, 执行完a.js, main.js加载已执行的a.js b.js
            # var foo = require('a').foo的写法有问题，在a在别处循环引用时, 得到的foo可能是执行到一半的值。而var a = require('a'), a.foo就会得到执行完后的值
        es6 import时不执行代码，而是引用
        // a.js
        import {bar} from './b.js';
        export function foo() {
            bar(); 
            console.log('a.js done')
        }
        // b.js
        import {foo} from './a.js';
        export function bar() {
            if(Math.random() > 0.5) {foo()}
        }
        babel-node a.js
            # CommonJS中不能执行, a加载b, b加载a, a没有输出, foo不存在, es6中可以执行
        // even.js
        import {odd} from './odd'
        export var counter = 0;
        export function even(n) {
            counter++;
            return n == 0 || odd(n - 1);
        }
        // odd.js
        import {even} from './even';
        export function odd(n) {
            return n != 0 && even(n - 1);
        }
        // main.js
        import * as m from './even.js'
        m.even(10)    // true
        m.counter    // 6
            # 10 变到 0 even执行了6次
        m.even(20)    // true
            # 20 变到 0 even执行了11次
        m.counter    // 17
            ＃es6中引用加载机制保证even, odd函数能加载，所以可执行。而CommonJS中循环引用，even和odd函数都不会加载

## 标准
    Netscape(现Mozilla)创建JavaScript, 但JavaScript是Sun(现Oracle)的注册商标
    作为标准提交给ECMA(欧洲计算机制造协会), 改名为ECMAScript
        ECMAScript 3(ES3) 作为标准广泛使用
        ECMAScript 5(ES5) 定义了新的语言标准
        JavaScript1.5是Mozilla的版本号, 相当于ES3,包含一些非标准语言扩展
            JavaScript1.8 在实现es7
        JavaScript解释器或引擎(engine)也有版本号
            Google的叫做V8(现在是4.0)
    微软改动并取名Jscript
### ECMAScript 6
    介绍
        目标使JavaScript可以写复杂的应用程序、函数库、代码自动自成器(code generator)
        mozilla基于ECMAScript6 发布 JavaScript2.0
        V8已经部署ECMAScript6的部分特性, node.js 0.11中使用了该版本的引擎
#### 新特性
    let        # 块级作用域中声明变量
    const        # 声明常量
    Set对象    # 同java Set, 是一个数组
        属性
            size
        方法
            add(value)
            delete(value)
            has(value)
            clear()
    Map对象    # 键值对，键可以是对象
        使用
            var m = new Map();
            o = {p: "Helllo"};
            m.set(o, "content");
            m.get(o);
        属性
            size
        方法
            set(key, value)
            get(key)
            has(key)
            delete(key)
            clear()
    ... (rest运算符)
    yield关键字
    class关键字
### commonJS
    介绍
        模块化标准
        代码会在require同步加载之后执行，会阻塞。这对服务器不是问题，但对浏览器是大问题
        
    应用
        var math = require('math');
        math.add(2, 3);
### AMD
    介绍
        模块化标准
        模块异步加载
    应用
        require(['math'], functioni (math){
            math.add(2, 3);
        });
            # 加载成功后进行回调
### CMD
    sea.js提出的规范
        define(function(require, exports, module){ ... })
## 问题精练
### 命名空间
    o-> function a(){
            # 其中的this 仍然是window
        }
    o-> var A = function (){}
        var oA = new A()        # A中的this为A
    o-> dom中的事件
        o-> html写的各种事件调用的是window的全局方法，
            其命名空间必定是全局。
                # 可以通过js筛选dom对象添加方法，该方法为局部。
        o-> 对于大页面, 子页面模块可以写一个静态对象，页面中的方法绑定到该对象，防止命名空间泄漏。
### 语法糖
    介绍
        添加某种语法，对语言功能没有影响，更方便使用，增加可读性，减少代码出错机会
    思路
        闭包模拟似有属性
### 闭包
    闭包的概念
        函数中的函数，就是闭包（能够读取其他函数局部变量的函数。）在本质上，闭包就是将函数内部和函数外部连接起来的一座桥梁。
    闭包概念(函数式)
        相对于传递对象参数，闭包传递对行为的建模
        闭包函数反回一个代码块
        闭包相对于匿名内部类，类，泛型等，不自己管理状态，而权责让渡给语言管理。并行友善
        闭包可延迟执行
    闭包的作用：
        1.可以读取其它函数的局部变量
        2.让局部变量的值保持在内存中
            function f1(){
        　　　　var n=999;
        　　　　nAdd=function(){n+=1}
        　　　　function f2(){
        　　　　　　alert(n);
        　　　　}
        　　　　        return f2;
            }
            var result=f1();
            result(); // 999
            nAdd();
            result(); // 1000
                # result()即f2()执行两次都输出了结果，证明了，局部变量n一直保存在内存中
                ## 另一点值得注意的是nAdd函数前面没有var 所以它是一个全局变量（函数）
                ## nAdd 指向的匿名函数本身也是一个闭包，所以nAdd相当于是一个setter，可以在函数外部对函数内部的局部变量进行操作。
    闭包注意
        1.由于闭包会使得函数中的变量都被保存在内存中，内存消耗很大，所以不能滥用闭包
            解决方法是，在退出函数之前，将不使用的局部变量全部删除。
        2.闭包会在父函数外部，改变父函数内部变量的值。所以，如果你把父函数当作对象（object）使用
            把闭包当作它的公用方法（Public Method），把内部变量当作它的私有属性（private value）
        注意的例子（新知识点：作用域的赋值特点）
            function outerFun()
                {
                //没有var 
                a =0;
                alert(a);  
            }
            var a=4;
            outerFun();
            alert(a);
                # 结果为 0,0 真是奇怪,为什么呢?
                ## 作用域链是描述一种路径的术语,沿着该路径可以确定变量的值 .
                ## 当执行a=0时,因为没有使用var关键字,因此赋值操作会沿着作用域链到var a=4;  并改变其值.
## 严格模式
    区别
        o-> 禁止使用with语句
        o-> 所有变量都要先声明
        o-> 调用的函数(非属性调用，如eval()，非a.test()), this值是undefined
            # this禁止指向全局变量
            # call(), apply()调用函数时, this是传入的第一个参数
        o-> 增加了保留字(如await, protected, static, interface)
        o-> 给只读属性赋值，给不可扩展对象创建新成员抛出类型错误异常
        o-> eval()代码不能创建局部变量或函数，而是定义在eval创建的新作用域(在eval返回时弃用)中, eval不包含外层作用域
        o-> arguments对象拥有参数的静态副本。
            # 非严格模式中，都是引用，可以改变原值
        o-> 限制调用栈检测能力, arguments.caller, arguments.callee都会抛出类型错误异常
            # 具有caller和arguments属性，但访问时会抛出异常
        o-> fn.caller, fn.arguments禁止使用
        o-> delete后非法标识符抛出异常(如delete prop, 只能delete global[prop])，delete不可配置属性抛出异常
        o-> 对象定义同名属性产生语法错误, 函数声明同名参数产生语法错误
        o-> 不允许八进制整数直接量(0前缀)
        o-> eval, arguments当作关键字
        o-> es5, es6中尾调用优化只在严格模式下开启，因为arguments.caller会跟踪函数调用栈
## 正则
    基本字符
        会精确匹配一段字符，如hi。这段字符可以出现多次
    字面量
        /^[a-z]+$/.text(str);        # ^代表开头, $是结尾
    转义
        \
    元字符
        # metacharacter
        .
            # 匹配除换行符以外任意字符
        \b
            # 表示单词的开头或结尾，也就是单词的分界。只匹配一个位置\s\S  
            \bhi\b                        
                # hi单词
        \d
            # 表示数字
        \s
            # 匹配任意空白符，包括空格、tab、换行、中文全角空格等
            \s\S
                # 匹配包括\n在内的所有字符
        \w
            # 匹配非特殊字符，包括字母、数字、下划线或汉字
        ^
            # 匹配开头    
        $
            # 匹配结尾
        反义
            \W
                # 非字符
            \S
                # 非空白
            \D
                # 非数字c
            \B
                # 非单词位置
    非
        [^x]
            # 非x
            # [^aeiou] 除了aeiou以外的任意字符 
    限定字符
        {2}
            # 表示前面的内容出现2次
            ## {5, 12}内容出现5到12次
            ## {5, }内容出现5或更多次
        ?
            # 零次或一次
        *
            # 零个或多个
        +
            # 表示一个或多个
    字符类
        [aeiou]
            # 匹配其中的一个
            ## [.?!] 匹配.或?或!
        [0-9]
            # 同\d
            ## [a-z0-9A-Z] 同\w
    分枝条件
        |
            # jpg|png
            # 每个分支都从第一个分支开始匹配
            ## 如\d{5}|\d{5}-d{4}只能匹配11111或11111-2222中的11111
    分组
        # 零宽断言只占用不消费
        ()
        语法
            (exp)
            (?<name1>exp)
                # 组命名
            (?:exp)
                # 消费exp, 不捕获匹配的文本，也不分配组号
            (?=exp)
                # 零宽断言，正向前瞻，后面能匹配表达式exp
                \b\w+(?=ing\b)
                    # 匹配以ing结尾单词的前面部分，如dancing中的danc
                /(\w)\1{2}(?=(\w)\2{2})/g
                    # 匹配所有在3个连续相同字符前的相邻3个连续相同字符
                    ## aaalllsss0tAAAnnn999结果是aaa, lll, AAA, nnn
            (?<=exp)
                # 零宽断言，正向后瞻，前面能匹配表达式exp
                (?<=\bre)\w+\b
                    # 匹配以re开头单词的后半部分，如reading中的ading
            (?!exp)
                # 零宽断言，负向前瞻，后面不匹配exp的位置
                # js不支持
                \b\w*q(?!u)\w*\b
                    # 匹配一个单词，该单词包含后面不是字母u的字母q
                    
                \d{3}(?!\d)
                    # 匹配三位数字，且它们后面不能有数字
                \b((?!abc)\w)+\b
                    # 匹配不包含连续字符串abc的单词
            (?<!exp)
                # 零宽断言，负向后瞻，前面不匹配exp的位置
                # js不支持
                (?<![a-z])\d{7}
                    # 匹配前面不是小写字母的七位数字
            (?#comment)
                # 注释
    后向引用
        # 分组捕获后会自动编号，从左到右，1234。
        ## 后向引用用于引用前面匹配到的文本，如 \1 代表分组1匹配的文本
        \b(\w+)\b\s+\1\b
            # 匹配重复的单词, 如go go
        (?<Word>\w+) 或 (?'Word'\w+)
            # 把\w+的组名指定为Word
            ## 用\k<Word>引用
    贪婪与懒惰
        o-> 包含能接受重复限定符时，会匹配尽可能多的字符。如a.*b
        o-> a.*?b会懒惰匹配
            懒惰限定符
                *? 重复懒惰匹配任意次
                +? 重复懒惰匹配1次或多次
                ?? 重复懒惰匹配0次或1次
                {n, m}? 重复懒惰匹配n到m次
                {n,}? 重复懒惰匹配n次以上
    平衡组/递归匹配
        (?'group') 把捕获的内容命名为group，并压入栈(Stack)
        (?'-group') 从栈中弹出最后压入的名为group的捕获内容。如果栈为空，则匹配失效
        (?(group)yes|no) 如果栈中存在名为group的捕获内容，继续匹配yes部分的表达式，否则则继续匹配no部分的表达式
        示例
            # 平衡组最常见的应用是匹配HTML
            匹配xx<aa<bbb><bbb>aa>yy
                # 思路: 每碰到左括号，就压入一个Open, 每碰到右括号，弹出一个
                ## 最后看栈是否空，如果否则表示不配对，应该失败
                ## 正则表达式引擎会进行回溯(放弃最前面或最后面一些字符), 尽量使整个表达式得到匹配
            <                # 最外层的左括号
            [^<>]*        # 后面非括号的内容
            (
            (
            (?'Open'<)    # 又碰到了左括号, 压入一个Open
            [^<>]*        # 后面非括号内容
            )+
            (
            (?'-Open'>)    # 碰到了右括号, 擦掉一个Open
            [^<>]*        # 后面非括号内容
            )+
            )*
            (?(Open)(?!))        # 负向前瞻，判断栈中还有没有Open, 有则匹配失败
            >                # 最外层右括号
            )
### 特点
    o-> js中不支持 回顾后发断言
    o-> 可以跟三个flag，比如/something/igm
        # i表示不区分大小写
        # g表示匹配多个
        ## g会影响String.prototype.match()和RegExp.prototype.exec()的行为
        ## match中加g会返回数组，不加g返回比较详细的信息
        ## exec中加g，且正则存在变量中时,该正则变量执行exec后会存储信息, 如
        ### var re = /h(.*?)\b/g;
        ### re.exec('hello helloo') 执行三次，匹配内容有变化
        # m表示，^$可以匹配每一个的开头和结尾
    o-> api
        RegExp
            exec
                # 执行第一个, exp本身保留执行状态
                exp = /#/
                exp.exec('##')
            test
        String
            replace
                # 替换第一个
                'John Smith'.replace(/(\w+)\s(\w+)/, '$2, $1')
                'abc123#$*'.replace(/([^\d]*)(\d*)([^\w]*)/, function replacer(match, p1, p2, p3, offset, string) {
                return [p1, p2, p3].join(' - ');
                });
                    # 'abc - 123 - #$*'
            replaceAll
            match
                # 不能有g选项，只得到第一个匹配

    .net中处理选项
        IgnoreCase
        # 忽略大小写
        Multiline
        # 多行模式, 更改^$的含义为一行首和行尾, $表示\n之前的位置以及字符串结束前的位置
        Singleline
        # 单行模式(可以与Multiline通用)，更改.的含义，便它与每一个字符匹配(包括\n)
        IgnorePatternWhitespace
        # 忽略空白，会忽略表达式中非转义空白并启用#作为标记注释
        ExplicitCapture
        # 显式捕获，仅捕获已被显式命名的组
### 常用
    <a[^>]+>                
        # 用尖括号括起来的以a开头的字符串

    ^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,10}$
        # 密码的强度必须包含大小写字母和数字的组合，不能使用特殊字符，长度在8-10之间

    ^[\\u4e00-\\u9fa5]{0,}$
        # 字符串只能是中文

    ^\\w+$
        # 由数字，26个英文字母或下划线组成的字符串

    [\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?
        # 校验E-Mail 地址

    ^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$
        # 校验身份证号码 15位

    ^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$
        # 校验身份证号码 18位

    ^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$
        # “yyyy-mm-dd“ 格式的日期校验，已考虑平闰年

    ^[0-9]+(.[0-9]{2})?$
        # 金额校验，精确到2位小数

    ^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$
        # 国内 13、15、18开头的手机号正则表达式

    ^.*MSIE [5-8](?:\\.[0-9]+)?(?!.*Trident\\/[5-9]\\.0).*$
        # 判断IE的版本

    \\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\b
        # 校验IP-v4地址

    (([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))
        # 校验IP-v6地址

    /^[a-zA-Z]+:\\/\\//
        # 检查URL的前缀

    ^(f|ht){1}(tp|tps):\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- ./?%&=]*)?
        # 提取URL链接

    ^([a-zA-Z]\\:|\\\\)\\\\([^\\\\]+\\\\)*[^\\/:*?"<>|]+\\.txt(l)?$
        # 文件路径及扩展名校验

    ^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$
        # 提取Color Hex Codes

    \\< *[img][^\\\\>]*[src] *= *[\\"\\']{0,1}([^\\"\\'\\ >]*)
        # 提取网页图片

    (<a\\s*(?!.*\\brel=)[^>]*)(href="https?:\\/\\/)((?!(?:(?:www\\.)?'.implode('|(?:www\\.)?', $follow_list).'))[^"]+)"((?!.*\\brel=)[^>]*)(?:[^>]*)>
        # 提取页面超链接

    ^\\s*[a-zA-Z\\-]+\\s*[:]{1}\\s[a-zA-Z0-9\\s.#]+[;]{1}
        # 查找CSS属性

    <!--(.*?)-->
        # 抽取注释

    <\\/?\\w+((\\s+\\w+(\\s*=\\s*(?:".*?"|'.*?'|[\\^'">\\s]+))?)+\\s*|\\s*)\\/?>
        # 匹配HTML标签

    '12345678901'.replace(/(\d{3})\d{4}(\d{4})/, '$1****$2')
        # 替换中四位到*
    '1111111'.replace(/([\d]{3})(?=[\d]+)/g, '$1-')
        # 替换为 '111-111-1'
### 元字符扩展
    \a            # 报警字符
    \t            # 制表符
    \v            # 竖向制表符
    \r            # 回车
    \f            # 换页符
    \n            # 换行符
    \e            # Escape
    \0nn        # ASCII码中八进制代码为nn的字符
    \xnn        # ASCII码中十六进制代码为nn的字符
    \unnnn        # Unicode码中十六进制代码为nnnn的字符
    \cN            # ASCII控制字符，如\cC 代表ctrl + c
    \A            # 字符串开头，同^但不受多行选项影响
    \Z            # 字符串结尾或行尾，不受多行选项影响
    \z            # 字符串结尾，同$但不受多行选项影响
    \G            # 当前搜索的开头
    \p{name}    # Unicode中命名为name的字符类，如\p{IsGreek}
    (?>exp)        # 贪婪子表达式
    (?<x>-<y>exp)                # 平衡组
    (?im-nsx:exp)                    # 在子表达式exp中改变处理选项
    (?im-nsx)                        # 为表达式后面的部分改变处理选项
    (?(exp)yes|no)                    # 把exp当作零宽正向先行断言，如果能匹配，使用yes作为此组表达式，否则使用no
                                    ## (?(exp)yes) 只使用空表达式为no
                                    ## (?(name)yes|no) 命名为name的组捕获到内容，使用yes
# 浏览器
    js执行顺序
        当页面载入时，会执行位于 body 部分的 JavaScript。
        当被调用时，位于 head 部分的 JavaScript 才会被执行。
# api
## 全局
    属性
        Infinity
            # 表示正无穷大
        NaN
            # 指示是不是数字
            ## Infinity与NaNECMAScript中可读写， ECMAScript修正为只读
            ## Infinity与NaN与任何值不相等(包括自身), 建议用非来判断
        undefined
        console
            log('abc %s', 'd')    // 'abc d'
                # 格式化输出

    方法
        parseFloat
            # 可以解析整数和浮点数
            # 跳过前导空格, 忽略后面非数字内容。
            ## 第一个非空格字符是非法数字直接量时，返回NaN
        parseInt
            # 只解析整数
            # 可接收第二个可选参数，指定数字转换基数
            "0x", "0X"前缀, 解析为16进制数
        isNaN
        isFinite
            # NaN, Infinity 不通过, 非数字报错 
        escape
            # deprecated since ECMAScript v3
        decodeURI
            # 不处理 =, & 等
        decodeURIComponent
            # 会处理 =, & 等
        encodeURI
        encodeURIComponent
        eval
            # 可以访问调用时的整个作用域，所以编译器不能裁剪作用域
            # 要间接调用, 如 (0, eval)(src)
        requestAnimationFrame
        fetch
            fetch(url).then(function (request) { return request.arrayBuffer })

## 构造函数
### 包装对象函数
    介绍
            基本类型(数字，布尔，字符串)在构建时，会通过new String(s)的方式转换成对象，有了对象的方法，这个过程就是包装对象
    undefined没有包装对象，所以访问属性会造成类型错误。
#### String
    介绍
            是Object类型, 是基本类型string的包装类型
                    # 引用字符串类型的属性时,js会调用new String(s)来转换成对象
                    ## 属性引用结束, 该新对象销毁
                    ### 实际上有优化
    包装测试
            自动包装测试
                    1.toString                # 异常
                    (1).toString                # => "1"
            原始类型属性只读
                    var s = "test";
                    s.len = 4;
                            # 相当于new String("test").len = 4
                    s.len                // => undefined
                            # 相当于new String("test").len
            运算
                    ==                # 原始类型与包装类型相等
                    ===                # 原始类型与包装类型不相等
    语法
            ECMAScript 5中，可以用数组方式访问16位值, 如
                    s[0]
    属性
            length
                    # 4字节的字符会误判为2

    静态方法
            localCompare()                                # 参照本地语言字母表字符次序
            fromCodePoint()
                    # 支持4字节字符值转换, 多参数时合并成字符串
            raw
                    # 一个tag函数, 转义模板字符串到字符串
                    String.raw`\n${2 + 3}`
                            # '\\n5'
                    String.raw({raw: 'test'}, 0, 1, 2)
                            # 正常调用时, 第一个参数对象中必要有raw属性，其值为tag函数的第一个字符串数组的参数。其余参数与tag函数其余参数对应
                    
    方法
            substring(1, 4)                // => 返回第2~4个字符
                    # 与java不同，java是第1~3个
            slice(1, 4)
            indexOf("")
            lastIndexOf("")
            toUpperCase()
            charAt(0)
                    # 取2个字节的字符
            charCodeAt()
                    # 取2个字节字符的十进制值
            codePointAt()
                    # index位的4字节字符当作一个字符，正确处理，得到十进制值
                    ## index+1位会取该4字节字符的后2字节, 为了匹配length属性
            at()
                    # 支持4字节字符, 匹配正确长度的方法
            fromCharCode()
                    # 2字节字符值转换到字符
            normalize()
                    # '\u01D1'.normalize() === '\u004F\u030C'.normalize()
                    ## 原重音符号与 (字符 + 重音)合成符等价
                    # 不支持3个及以上字符合成
            includes
                    # s.includes('o', 6) 从6位置开始搜索o是否出现
            startsWith
            endsWith
                    # s.endsWith('o', 6) 前6个字符是否以o结尾
            repeat(3)
                    # 字符串重复3次返回
            padStart
                    # 'x'.padStart(5, 'ab') 返回 'ababx'
                    ## padStart(5)会填充空格
            padEnd
            正则
                    # es6中内部调用RegExp.prototype[Symbol.match]等方法
                    search(pattern)                                # 返回首次匹配成功的位置
                    match(pattern)                                # 所有匹配位置的数组
                    replace(pattern, "")                        # 所有匹配替换
                    split(pattern)                                # 匹配分割
#### Number
    属性
            NaN
            POSITIVE_INFINITY
            NEGATIVE_INFINITY
            MAX_VALUE
            MIN_VALUE
            EPSILON
                    # 极小的常量 2.22....e-16, 用来设置浮点计算的一个合理误差范围
            MAX_SAFE_INTEGER
                    # 越界最大值
            MIN_SAFE_INTEGER
                    # 越界最小值
    静态方法
            isFinite
            isNaN
            isInteger
            isSafeInteger
                    # 判断是否越界
            parseInt
            parseFloat
            
    方法
            字符串解析
                    构造方法
                            # 只基于十进制转换
                    调用全局函数parseInt(), parseFloat()
            转换为字符串
                    toString()
                            # Number类的toString()可接收转换基数, 来转换进制
                            ## 如 n.toString(2); n.toStrng(8); n.toString(16)
                    toFixed(0)                        # 保留几位小数
                                                    ## 从不使用指数计数法
                    toExponential(1)                # 转换为指数, 参数为指数前保留几位小数
                    toPrecision(4)                        # 保留有效数字，多出位数转换成指数
                            # 以上三个方法自动补0
#### Boolean

### Object
    属性
            __proto__
                    # 用来读取或设置当前对象的prototype对象，只有浏览器必须部署这个属性
                    # 语义上是内部属性，被支持仅因为被广泛使用
    动态方法
            hasOwnProperty
                    # 是否有某属性，可判断属性值为undefined的情况
                    # 没prototype的对象, 该方法直接调用失败，需要Object.prototype.hasOwnProperty.call来调用
            propertyIsEnumerable
            isPrototypeOf
                    b.isPrototypeOf(c)
                            # b是否出现在c的prototype链中
            toString
            toLocaleString
                    # 返回对象的本地化字符，默认时仅调用toString方法
                    # Date和Number对toLocaleString做了定制
                    # Array的toLocalString对每个数组元素调用toLocaleString方法
                    ## toString会对每个数组元素调用toString方法
            *toJSON
                    # Object.prototype没有定义这个方法, JSON.stringigy会调用要序列化对象的toJSON方法,如Date.toJSON()
            valueOf
                    # 要将对象转换为原始值时调用
                    # 如果需要使用原始值的上下文中使用了对象，会自动调用这个方法
    静态方法
            create
                    # new会执行构造方法，有副作用
                    Object.create(null)
                            # 创建的对象没有prototype，不同于{}
            getPrototypeOf
                    # 用于判断继承
                    Object.getPrototypeOf(B) === A
            getOwnPropertyNames
                    # 所有自身属性
            getOwnPropertyDescriptor(obj, 'foo')
                    # 获得属性的描述对象
            getEnumPropertyNames
                    # 可枚举自身属性和继承属性
            setPrototypeOf
                    # 标准可靠的方法修改对象prototype的关联
                    Object.setPrototypeOf(Bar.prototype, Foo.prototype)
                            # 同Bar.prototype = Object.create(Foo.prototype)
            keys
                    # 可枚举自身属性
            defineProperty
                    # 数据描述符，getter、setter是访问描述符
                    # 修改属性，在原型链上层属性为writable: false或有对应属性的setter时，不会发生屏蔽。使用defineProperty可发生屏蔽
                    Object.defineProperty(Object, 'is', {
                            value: function (x, y) {...},
                            configurable: true,
                                    # false时，delete该属性会静默失败
                            enumerable: false,
                            writable: true,
                            get: function(){return 1}
                    })
            toLocaleString
            toString
                    # toString(16) 转换为16进制
            is('foo', 'foo')
                    # 比较两个值是否相等, 基本是===，不同在于
                    ## +0 等于 -0, NaN 等于 NaN
            assign(target, source1, source2)
                    # 复制源对象自身可枚举属性到目标对象, source2覆盖source2覆盖target
                    # Symbol值的属性也会被拷贝
                    # _.defaultsDeep方法可以深拷贝
                    # 常用于给对象添加静态方法或方法，合并对象，为属性指定默认值
                    ## Object.assign({}, DEFAULTS, options);
            preventExtensions
                    # 使对象不可设置属性
            isExtensible
            seal
                    # 创建“密封”对象, 在现有对象上调用preventExtensions并把现在属性标记为configurable: false
            freeze
                    # 调用seal并标记现有属性为writable: false
### Array
    静态方法
            isArray(a)                # ECMAScript 5 判断是否数组
                    [] instanceof Array的问题
                            多frame中有多个js环境, 都有自己的全局对象与构造函数。一个窗体中的对象是当前窗体构造函数创建，而另外窗体构造函数判断该对象则不成立。
                                    # 但窗体间的混淆不常发生
                    ECMAScript 3 可以检查对象类属性来判断。
                                    # 实际上就是ECMAScript 5中Array.isArray的代码
                            var isArray = Array.isArray || function(o){
                                    return typeof o === "ojbect" && Object.prototype.toString.call(o) == "[object Array]"
                            };
            from
                    # 类数组对象或可遍历对象(如Set, Map)转为数组，转换后的数组具有了iterator接口
                    # 类数组对象同[].slice.call(arraylike), 可遍历对象同[...traversable]
                    Array.from(arraylike)
                    Array.from([1, , 2, , 3], (n) => n || 0)
                    Array.from('abc')
                            # 字符串转数组
                    Array.from(new Set(array))
                            # 去除重复元素
            of
                    # 一组值转换为数组, 用于替代Array(), new Array()
                    # 弥补Array()的返回不一致问题, 如Array(3) // [, , ,]
                    Array.of(1, 2, 3)        // [1, 2, 3]
    动态方法
            join, ...
                    # firefox1.5 后 动态方法也写入到了静态方法中。但不是标准
                    # 是String.split()的逆向操作
                    a.join()                                // => "1,2,3"
                    a.join("")                        // => "123"
                    new Array(2).join('-')                // => "--"
            reverse
                    # 倒序
                    a.reverse()
            sort
                    # 排序
                    a.sort()
                            # 默认以字母表排序, 自动转字符串 undefined排到最后
                    a.sort(function(a, b){
                            return a-b;
                            # a在前, 返回负数。b在前返回正数。0表示相等，顺序无关紧要
                            ## 此处是升序排列
                    })
            concat
                    # 连接数组, 创建返回一个新数组
                    ## 传入数组, 连接数组元素而非本身, 但不扁平化数组的数组
                    a.concat(4, [5, [6, 7]])
            slice
                    # 截取新数组
                    var a = [1,2,3,4,5]
                    a.slice(0,3)                        // 返回 [1,2,3]
                    a.slice(3)                        // 返回 [4,5]
                    a.slice(1, -1)                        // 返回 [2,3,4]
                    a.slice(-3, -2)                        // 返回 [3]
            splice
                    # 修改数组
                    ## 第一个参数起始位置(包含), 第二个参数删除个数(省略则从起始到结束都删除)
                    ## 后面任意个参数指定插入到数组中的元素
                    ## 返回由删除元素组成的数组
            push 和 pop
                    # 数组作为栈(先进后出)来用, push在结尾添加, pop在结尾删除
                    ## 插入元素时不解封数组
            unshift 和 shift
                    # unshift在头部添加元素, shift在头部删除。都改变索引
                    ## 插入元素时不解封数组
            toString
                    # 调用每个元素的toString()方法, 输出有逗号分隔的字符串列表(没有方括号)
                    ## 与不使用任何参数的join()是一样的
            toLocaleString
                    # 调用元素的toLocaleString
            copyWithin
                    # 当前数组中复制一段到另一位置
                    [1, 2, 3, 4, 5].copyWithin(0, 3)        // [4, 5, 3, 4, 5]
                            # 第三个参数是结束位置(不包含), 默认是结尾。把4, 5 复制替换到1, 2
                    [1, 2, 3, 4, 5].copyWithin(0, -2, -1)        // [4, 2, 3, 4, 5]
                            # 4到5(不包含)复制到1
            find
                    # 返回第一个符合条件的元素, 没有时返回undefined, 可处理NaN
                    # 第二个参数绑定回调函数的this对象
                    [1, 4, -5, 10].find((n) => n < 0)
            findIndex
                    # 返回第一个符合条件的index, 没有时返回-1
            fill
                    # 用某元素填充数组, 可标识起始位置
                    [1, 2, 3].fill(0)        // [0, 0, 0]
                    [1, 2, 3].fill(0, 1, 2)        // [1, 0, 3]
            includes
                    # 是否包含元素，可识别NaN, 返回布尔值, 第二个参数表示起始位置
                    # indexOf 使用===判断, 会对NaN误判
                    [1, 2, 3].includes(2, 0)
            
            遍历类方法
                    # 对稀疏数组，不存在的元素不调用传递的回调函数
                    # 方法第一个参数是回调函数, 第二个参数是回调函数的this
                    # 多数情况下, 传入的回调函数传递三个参数: 数组元素, 元素的索引, 数组本身
                    forEach
                            # 没有break语句，用抛出异常替代
                            a.forEach(function(value){})
                                    function foreach(a, f, t){
                                    try{a.forEach(f, t);}
                                    catch(e){
                                            if(e === foreach.break) return;
                                            else throw e;
                                    }
                            }
                            foreach.break = new Error("StopIteration");
                    map
                            # 映射数组元素
                            # 稀疏数组也返回相同的缺失元素
                            [1,2,3].map(function(x){return x * x})                # 返回 [1, 4, 9]
                    filter
                            #  回调返回true的元素保留，返回新数组
                            ## 返回的数组总是稠密的，可用于压缩空缺并删除undefined 和 null元素
                            [5, 4, 3, 2, 1].filter(function(x){ return x < 3})        # 返回 [2, 1]
                    every和some
                            # every表示所有, 在都返回true时返回true
                            # some表示存在, 都返回false时返回false
                            ## 在确定返回值时停止遍历
                            a.some(func)
                    reduce和reduceRight
                            # 使用指定函数将数组元素进行组合，称为"注入"和"折叠"
                            a.reduce(function(x, y){ return x + y}, 0)
                                    # 第一个是回调函数。第二个可选，是初始值，无初始值时一开始直接传入第一第二个元素
                                    ## 回调函数中第一个是累积的结果, 第二个是当前元素
                                    # 空数组无初始值调用会导致类型错误异常。
                                    # 只有一个值并没有初始值时, reduce只简单抬这个值
                            reduceRight同reduce，但索引从高到低处理数组
                    indexOf和lastIndexOf
                            # 搜索数组元素, 返回第一个匹配元素的索引, 失败则返回 -1
                            ## indexOf从前往后, lastIndexOf从后往前
                            # 第二个参数可选，指定起始索引。负索引代表相对末尾的偏移量
                            # 字符串也有indexOf和lastIndexOf, 针对每个字符
            返回遍历器
                    entries
                            for(let [ind, ele] of ['a', 'b'].entries()) {}
                                    # 得到 0 'a', 1 'b'
                                    # 不用for of , entriesIterator.next().value        // [0, 'a']
                    keys
                    values
### Function
    使用
            # 在实际编程中很少用到
            var f = new Function("x", "y", "return x*y;");
                    # 任意数量实参。最后一个实参是函数体，语句间用分号隔开
                    # 创建一个匿名函数
    特点
            允许js在运行时动态创建并编译函数
            每次调用，都解析函数体并创建新函数对象，效率低
                    # 循环中嵌套函数和函数定义表达式不会每次都重新编译
            总在全局作用域创建，可以认为其构造函数是全局作用域中执行eval()

    函数体代码内
            arguments
                    callee
                    caller
                            # 调用栈的上层函数
                            # 出于安全考虑，大部分编译器已不支持caller, 用非标准的 fn.caller来取代, fn为当前函数名
    属性
            length                                
                    # 只读属性，代表函数形参数量。不包含设置了默认值的形参，也不包含...rest参数
                    # arguments.length是实际实参个数, arguments.callee.length是期望实参个数, 同本length
            name
                    # 函数名, es5中只支持具名函数如function a(){}, es6支持var a = function(){}
                    # (new Function).name        // 'anonymous'
                    # foo.bind({}).name        // 'bound foo'
            prototype                        # 指向原型对象(prototype object)，从该函数创建对象时，从原型对象上继承属性

    方法
            call(o, 1, 2)                        # 传入可变调用时参数
            apply(o, [1, 2])                # 传入调用时参数数组或类数组对象
                                            ## 这样可以将arguments数组直接传入另一个函数来调用
                    # ECMAScript 严格模式中，o传入什么,this就是什么。其它情况下，o为null或undefined时替换为顶级对象，原始值会被包装。
            bind(o, ...)                        # ECMAScript 5新增方法。在函数a上调用bind, 传入对象o，反回以o调用a的新函数b
                                            ## bind返回的是一个闭包, 返回的函数不包含prototype属性
                                            ### 普通函数固有的prototype属性是不能删除的
                                            ## 除第一个实参外，其它实参按顺序绑定到调用bind函数f的实参上，称为柯里化(currying), 如
                                            ## f = function(x, y); ff = f.bind(o, 1); ff(2);        // 此时x绑定为1, y传入为2
                                            ## ECMAScript 5中的bind, 返回的函数对象的length属性，值是返回函数的形参个数减其实参个数
                                            ### 返回的函数可以用作构造函数，此时以原始函数的形式调用作为构造函数(实参也会原封不动地传入)
                                            #### 用作构造函数时, 使用原始函数的prototype
            toString()                        # ECMAScript规定返回和函数声明语法相关的字符串
                                            ## 大多数toString()方法返回函数的完整源码，内置函数往往返回类似"[native code]"的字符串作函数体

### Date
    var now = new Date()
    var then = new Date(2011, 0, 1)
    var later = new Date(2011, 0, 1, 17, 10, 30)
    var elapsed = now - then;

    now.setMonth(now.getMonth - 1);
    方法
            getFullYear()
            getMonth()
            getDate()
            getDay()
            getHours()
            getUTCHours()
### Error
### RegExp
    构造
            new RegExp('xyz', 'i');
                    # /xyz/i
            new RegExp(/abc/ig, 'i')
                    # /abc/i
    修饰符
            i
            g
                    # 全局多次匹配, 下次匹配从剩余中重新开始
            u
                    # 正确处理4字节字符
                    # 存在u修饰符时, /\u{61}/可以表示unicode字符
                    ## 否则会匹配61个连续的u
            y
                    # 粘连，基本同g，不同在于剩余第一个字符开始必须匹配上
                    # 确保匹配之间不会有漏掉的字符
                    var s = 'aaa_aa_a', r1 = /a+/g, r2 = /a+/y;
                    r1.exec(s), r2.exec(s)
                            # ['aaa'] ['aaa']
                    r1.exec(s), r2.exec(s)
                            # ['aa'] null
    属性
            flags
                    # 修饰符
            lastIndex
                    # 从这个index开始匹配
            sticky
                    # 是否设置了y字符
    静态方法
            
    方法
            test
                    /\d+/g.test("testing: 1, 2, 3")
            exec
                    # 返回带有特殊属性的Array match
                    match
                            属性
                                    index
                                            # 在index上匹配成功
### Set
    构造
            new Set()
            new Set([1, 2, 3])
    属性
            size
                    # Set实例成员数
    方法
            add(x)
            delete(x)
            has(x)
                    # 是否有x
            clear()
                    # 清除所有成员
            keys()
            values()
                    # values同keys完全一致, 返回遍历器
            entries()
                    # 返回[key, key]的遍历器
            forEach(function (value, key, obj) {}, boundThis)
### WeakSet
    构造
            new WeakSet()
            new WeakSet([1, 2, 3])
                    # 任何可遍历对象
    属性
            # 没有size
    方法
            add(x)
            delete(x)
            has(x)
### Map
    构造
            new Map()
            new Map([['a', 1], ['b', 2]])
    属性
            size
    方法
            set(key, value)
            get(key)
            delete(key)
            has(key)
                    # 是否包含key
            clear()
            keys()
            values()
            entries()
                    # map[Symbol.iterator] === map.entries
            forEach(function(value, key, map) {}, boundThis)
### WeakMap
    方法
            get
            set
            delete
            has
### Proxy
    new Proxy(target, handlers)
            # target表示要拦截的对象, handler是回调方法
    拦截器
            get(target, propKey, receiver)
                    # 属性读取。propKey是属性名, receiver是继承该proxy的对象
            set(target, propKey, value, receiver)
                    # 属性设置
            has(target, propKey)
                    # in操作，返回布尔值
            deleteProperty(target, propKey)
                    # delete操作，返回布尔值
            enumerate(target)
                    # for in , 返回遍历器
            ownKeys(target)
                    # Object.getOwnPropertyNames, Object.getOwnPropertySymbols, Object.keys, 返回数组
            getOwnPropertyDescriptor(target, propKey)
                    # Object.getOwnPropertyDescriptor, 返回描述对象
            defineProperty(target, propKey, propDesc)
                    # Object.defineProperty, Object.defineProperties, 返回布尔值
            preventExtensions(target)
                    # Object.preventExtensions, 返回布尔值
            getPrototypeOf(target)
                    # Object.getPrototypeOf, 返回对象
            isExtensible(target)
                    # Object.isExtensible, 返回布尔值
            setPrototypeOf(target, proto)
                    # Object.setPrototypeOf, 返回布尔值
            apply(target, object, args)
                    # 拦截proxy作为函数调用的操作, 如proxy(), proxy.call, proxy.apply
            construct(target, args, proxy)
                    # 拦截proxy作用构造函数的操作, 如new proxy
    静态方法
            revocable(target, handler)
                    # 返回有proxy, revoke属性的对象实例, proxy是Proxy实例, 调用revoke()函数可以取消Proxy
                    et {proxy, revoke} = Proxy.revocable({}, {})
### ArrayBuffer
    构造
            var buf = new ArrayBuffer(32)
                    # 生成32字节的内存区域，每个字节默认值为0
            if(buf.byteLength === 32)
                    # 由于内存可能不够大，要检查是否分配成功
    属性
            byteLength
                    # 内存区字节长度
    方法
            slice(0, 3)
                    # 拷贝前3个字节，生成新的ArrayBuffer
            isView(v)
                    # 检查某视图是否为该buf的视图
### (TypedArray)
    9种类型数组
            Int8Array
            Uint8Array
            Uint8ClampedArray
                    # 自动过滤溢出。用于处理图像颜色, 只取值0 - 255, 过滤掉高位
                    # ie10不支持该类型
            Int16Array
            Uint16Array
            int32Array
            Uint32Array
            Float32Array
            Float64Array
    构造
            var x1 = new Int32Array(buf)
                    # 带符号整形方式读buf
                    # new Int32Array(buf, 2, 2) 开始于字节2, 长度为2(2 * 32bit)。第3个参数不填则到末尾
                    ## 开始字节数要符合视图类型, 如16位类型视图单位是2个字节, 不能从1字节开始, 否则将报错
                    ## 用于构建复合视图
            x1[0] = 1;
                    # 第0位4个字节赋值
            var x2 = new Uint8Array([0, 1, 2])
                    # 数组会直接分配内存生成ArrayBuffer
            new Float64Array(8)
                    # 直接分配8字节生成ArrayBuffer来创建视图
            new Int8Array(new Uint8Array(4))
                    # 会开辟新的ArrayBuffer，复制原有数据来建立视图
                    # new Int8Array(new Uint8Array(4).buffer)可以用同一个buffer
    属性
            length
            BYTES_PRE_ELEMENT
                    # 表示当前数据类型占用的字节数
            buffer
                    # 该视图的ArrayBuffer对象
            byteLength
                    # 该视图中buffer占内存的长度，是只读属性
            byteOffset
                    # 该视图从哪个字节开始, 只读属性
    静态方法
            of
                    # 将参数转为TypedArray实例
            from
                    # 可遍历数据转TypedArray, 可将TypedArray转为另一种TypedArray。可以接map函数
                    Int16Array.from(Int8Array.of(1, 2, 3), x => 2 * x)
    方法
            # 没有concat方法
            set
                    # 复制数组，整段内存覆盖
                    b.set(a, 2)
                            # 从b的index2开始复制a
            subarray
                    # 建立新视图
                    a.subarray(2, 3)
                            # 从index2复制到index3(不包含), 参数2不填默认复制到结尾
            slice
### DataView
    构造
            new DataView(buf)
                    # DataView(ArrayBuffer buffer [, startIndex [, length]])
    属性
            buffer
            byteLength
            byteOffset
    方法
            getInt8(0, true)
                    # 以带符号整形格式读第0个字节, 第二个参数默认false, 使用大端字节序解读(两个或以上字节的数据需要), 设置true则为小端字节序
            getUint8
            getInt16
            getUint16
            getInt32
            getUint32
            getFloat32
            getFloat64
            setUint8(0, 1, true)
                    # 开始序号, 数据, 小端字节序
            setInt16
            setUint16
            setInt32
            setUint32
            setFloat32
            setFloat64
### WebSocket
    构造
            new WebSocket('ws://127.0.0.1:8081')
    属性
            binaryType
                    # 设置成'arraybuffer'来接收和发送arraybuffer
### FileReader
    构造
            var fileInput = document.getElementById('fileInput');
            var file = fileInput.files[0];
            var reader = new FileReader();
            reader.readAsArrayBuffer(file);
            reader.onload = function () { var arrayBuffer = reader.result; }
            或
            reader.addEventListener('load', processimage, false);
            function processimage(e) { var buffer = e.target.result; }
### Promise
    构造
            var promise = new Promise(function (resolve, reject) {resolve(0); /* reject(err)*/})
    方法
            then(func1, func2, func3)
                    # func1对就fulfilled回调, func2对应rejected回调, func3用于处理进度信息
            catch
                # 是then(null, rejection)的别名，尽量使用catch而非then(null, rejection), 这样看起来更接近同步写法
    静态方法
            all([p1, p2, p3])
                    # 成员不是promise对象时，先promise.resolve(data)
                    # 全部完成, fullfilled。一个rejected, rejected, 返回第一个reject的错误
            race([p1, p2, p3])
                    # 一个完成, fullfiled, 返回该promise
                    Promise.race([p1, new Promise((resolve, reject) => {
                            setTimeout(() => reject(new Error('time out.')), 5000)
                    })])
                            # 定时任务
            resolve
            reject
            done
                    # 不在规范内
                    # 总是在回调链尾端, 保证抛出任何可能出现的错误
            finally
                    # 不在规范内
                    # 接受一个回调函数，永远执行
## 全局对象
### 顶级全局对象
    介绍
            js代码最外层的this
            初始化时, 定义所有预定义全局值
            代码中定义的全局变量，实际是该对象的属性
    Global

    Window
            介绍
                    初始化时定义了一部分其他全局属性
### Math
    属性
            PI
            E                        # 自然对数底数
            LN10
                    # 同Math.log(10), 表示以e为低10的对数
                    # Math.log(100)/Math.LN10 消底后表示以10为底100的对数
            LN2
    静态方法
            trunc
                    # 去除小数部分
            sign
                    # 判断正负或零
            exp
                    # e的x次方
            log
                    # x的自然对数
            cbrt
                    # 立方根, 同Math.pow(Math.abs(x), 1/3)
            clz32
                    # 二进制下32位无符号整数有多少个前导0。小数会取floor
                    ## count leading zero bits in 32-bit binary representations of a number
                    Math.clz32(1000)        // 22
                    Math.clz32(1000 << 1)        // 21
            imul
                    # 32位带符号整数的乘积, 在乘积越界时会返回正确的低位数值
            fround
                    # 返回一个数的单精度浮点数表示, 4位无法精确表示的小数，会返回最接近的数
                    # 同new Float32Array([x])[0]
                    Math.fround(1.337);        // 1.337000012...
            hypot
                    # 所有参数平方和的平方根
            expm1
                    # 返回Math.exp(x) - 1
            log1p
                    # 返回Math.log(1 + x)
            log10
                    # 返回以10为低x的对数, 同 Math.log(x) / Math.LN10
            log2
            sinh
                    # 双曲正弦 hyperbolic sine
            cosh
                    # 双曲余弦 hyperbolic cosine
            tanh
                    # 双曲正切 hyperbolic tangent
            asinh
                    # inverse hyperbolic sine
            acosh
            atanh
    方法
            pow(x, y)                # x的y次方
                                    # pow(x, 1/3) 表示立方根
            round(.6)                # 四舍五入
            ceil(.6)                        # 向上求整
            floor(.6)                # 向下求整
            abs(-5)                        # 绝对值
            max(x, y)                # 最大值
            min(x, y)                # 最小值
            random()                # >=0, < 1.0的伪随机数
            sqrt(3)                        # 平方根
            sin(0)
            log(10)                        # 自然对数
            exp(3)                        # e的3次幂
### JSON
    方法
            parse(str)
            stringify(obj)
### Reflect
    静态方法
            ownKeys(target)
                    # 返回对象自身所有属性
            enumerate(target)
                    # 返回Iterator，遍历对象自身和继承的所有可枚举属性, 同for ... in
            apply(target, thisArg, args)
            construct(target, args)
            get(target, name, receiver)
            set(target, name, value, receiver)
            defineProperty(target, name, desc)
            deleteProperty(target, name)
            has(target, name)
            isExtensible(target)
            preventExtensions(target)
            getOwnPropertyDescriptor(target, name)
            getPrototypeOf(target)
            setPrototypeOf(target, prototype)

### Symbol
    属性
            hasInstance
                    # Obj[Symbol.hasInstance]方法在instanceof运算时调用，如Foo[Symbol.hasInstance](foo)
            isConcatSpreadable
                    # arr.concat时是否要展开
                    # let arr = [1, 2], arr[Symbol.isConcatSpreadable] = false, 
                    ## ['a', 'b'].concat(arr, 'c')        // ['a', 'b', [1, 2], 'c']
            species
                    # 如果this.constructor[Symbol.species]存在, 用它来做构造函数
            match
                    # str.match(obj)时, 调用obj[Symbol.match](str)
            replace
                    # str.replace(s, r)时, 调用s[Symbol.replace](s, r)
            search
                    # str.search(obj)时，调用obj[Symbol.search](str)
            split
                    # str.split(separator, limit)时, 调用separator[Symbol.split](str, limit)
            iterator
                    # for ... of指向调用的默认遍历器
                    # function A {*[Symbol.iterator] () {
                    # let i = 0; while(this[i] != undefined) {yield this[i]; i++;}
                    ## }}
            toPrimitive
                    # 对象转原始类型值时调用
                    # {[Symbol.toPrimitive] (hint) {}}        // hint值有 'number', 'string', 'default'
            toStringTag
                    # toString时拼在后面, 如 '[object xxx]'
            unscopables
                    # 排除with时的属性, Array.prototype[Symbol.unscopables]        // {copyWithin: true, ...}
            
    方法
            s.toString()        // 'Symbol(foo)'
                    # 可以String(s) 得到字符串'Symbol(foo)'
    静态方法
            for('foo')
                    # 搜索以'foo'作参数登记的Symbol值, 没有时会新建、登记并返回
                    ## 这种登记是全局的
            keyFor(s)
                    # 返回s登录的字符串，没有时返回undefined
            
# 扩展api
    # 参数类型检测与递归计算
    function flexisum(a){
            var total = 0;
            for(var i = 0; i < arguments.length; i++){
                    var element = arguments[i], n;
                    if(element == null) continue;
                    if(isArray(element))
                            n = flexisum.apply(this, element);
                    else if(typeof element === "function")
                            n = Number(element());
                    else
                            n = Number(element);
                    if(isNaN(n))
                            throw Error("flexisum(): can't convert " + element + " to number");
                    total +=n;
            }
            return total;
    }
## 闭包函数
    o-> 作用域命名不污染
            var uniqueInteger = (function(){
                    // 私有变量不被修改
                    var counter = 0;
                    // 返回嵌套函数，引用闭包
                    return function(){return counter++;}
            }());
    o-> 一个计数器对象
            function counter(){
                    var n = 0;
                    return {
                            count: function(){return n++;},
                            reset: function(){n = 0;}
                    };
            }
            var c = counter(), d = counter();
            c.count()
            c.reset()
    o-> 属性存取器改写闭包。属性存取器就是闭包
            function counter(n){
                    // n是私有变量(局部变量)
                    return{
                            get count() {return n++;},
                            set count(m){
                            if(m >= n) n = m; 
                            else throw Error("count can only be et to a larger value");
                            }
                    }
            }
            var c = counter(1000);
            c.count;
    o-> 闭包技术共享私有状态。作用是给一个对象加私有属性
            function addPrivateProperty(o, name, predicate){
                    // predicate为set属性值时验证有效的规则
                    var value;
                    // 方法名称为getXxx, setXxx时，自动成为存取器方法。
                    // 两个闭包(getter作用域链和setter作用域链)共享一个变量value
                    o["get" + name] = function(){return value;}
                    o["set" + name] = function(v){
                            // v是局部变量，无法在外部绕过存取器方法来设置或修改这个值
                            if(predicate && ! predicate(v)) throw Error("set" + name + ": invalid value " + v)
                            else value = v;
                    };
            }
            var o = {}
            addPrivateProperty(o, "Name", function(x){ return typeof x == "string";});
            o.setName("A");
            o.setName(o);
    o-> 不希望闭包间共享变量
            function constfunc(v){return function(){return v;};}
            var funcs = []
            // 循环创建闭包，变量不共享
            for(var i = 0; i < 10; i++) funcs[i] = constfunc(i);
            funcs[5]();
            //// 下面错误写法
            function constfuncs(){
                    var funcs = [];
                    // 循环创建闭包，共享了上层变量i
                    // 闭包关联的上层"作用域链"是同一个, 不会复制一份
                    for(var i = 0; i < 10; i++) funcs[i] = function(){return i;};
                    return funcs;
            }
            var funcs =  constfuncs();
            funcs[5]();        // => 10
## api自定义函数
    # 用apply实现代理
    # 动态修改方法(monkey-patching), 包裹原始函数的函数称作泛函数
    ## 泛函数也叫泛函, 指一种变换，这种变换输入函数，输出值或另一个函数
    function trace(o, m){
            var original = o[m];
            o[m] = function(){
                    return original.apply(this, arguments);
            }
    }
    # 兼容 ECMAScript 3实现bind
    function bind(f, o){
            if(f.bind) return f.bind(o);
            else return function(){
                    return f.apply(o, arguments);
            }
    }
    # 柯里化的bind
    if(!Function.prototype.bind){
            Function.prototype.bind = function(o /*, args */){
                    var self = this, boundArgs = arguments;
                    return function(){
                            var args = [], i;
                            for(i = 1; i < boundArgs.length; i++) args.push(boundArgs[i]);
                            for(i = 0; i < arguments.length; i++) args.push(arguments[i]);
                            return self.apply(o, args);
                    }
            }
    }
## object
    function getAllPropertyNames = function(obj){
            var props = [];
            do {
                    props = props.concat(Object.getOwnPropertyNames(obj));
            } while (obj = Object.getPrototypeOf(obj));
            return props;
    }
## extend()
    function extend(o, p){
            for(prop in p){
                    o[prop] = p[prop];
            }
            return o;
    }
            # p中属性复制到o中，同名覆盖
    function merge(o, p){
            for(prop in p){
                    if(o.hasOwnProperty[prop]) continue;
                    o[prop] = p[prop];s
            }
            return o;
    }
            # 同extend, 同名属性以o为准
    function restrict(o, p){
            for(prop in o){
                    if(!(prop in p)) delete o[prop];
            }
            return o;
    }
            # 保留o中与p中属性同名的属性
    function subtract(o, p){
            for(prop in p){
                    delete o[prop];
            }
            return o;
    }
            # 删除o中与p中属性同名的属性
    function union(o, p) { return extend(extend({}, o), p);}
            # 返回新对象如extend(o, p)
    function intersection(o, p){ return restrict(extend({}, o), p);}
            # 返回新对象如restrict(o, p)
    function keys(o){
            if(typeof o !== "object") throw TypeError();
            var result = [];
            for(var prop in o){
                    if(o.hasOwnProperty(prop))
                    result.push(prop);
            }
            return result;
    }

    # 动态函数中调用，复制对象o中的属性(不覆盖本对象中的属性)及特性
    ## 复制特性。
    # extend函数作为不可枚举属性添加到Object.prototype中
    Object.defineProperty(Object.prototype, "extend", {
            writable: true,
            enumerable: false,
            configurable: true,
            value: function(o){
                    var names = Object.getOwnPropertyNames(o);
                    for(var i = 0; i < names.length; i++){
                            if(names[i] in this) continue;
                            var desc = Object.getOwnPropertyDescriptor(o, names[i]);
                            Object.defineProperty(this, names[i], desc);
                    }
            }
    });

    # 定义函数extend, 将第二个与之后的对象属性复制到第一个参数
    ## 一一定会复制不可枚举属性, 如toString
    // 这里用了命名空间函数，返回其执行后的结果，命名空间函数中的变量不会污染外部变量
    var extend = (function() {
            // 判断 for/in 是否会枚举不可枚举属性toString。是则返回简单版本的extend()函数
            for(var p in {toString: null}){
                    return function extend(o){
                            // 遍历第二个参数之后的对象，将它们的属性覆盖到第一个对象上
                            for(var i = 1; i < arguments.length; i++){
                                    var source = arguments[i];
                                    for(var prop in source) o[prop] = source[prop];
                            }
                            return o;
                    };
            }
            // 执行到此时，for/in不会枚举toString属性，则返回显式测试Object.prototype的不可枚举属性的extend
            return function patched_extend(o){
                    for(var i = 1; i < arguments.length; i++){
                            var source = arguments[i];
                            for(var prop in source) o[prop] = source[prop];
                            // 复制已知不可枚举属性列表中的属性
                            for(var j = 0; j < protoprops.length; j++){
                                    prop  = protoprops[j];
                                    if(source.hasOwnProperty(prop)) o[prop] = source[prop];
                            }
                    }
                    return o;
            };
            // prototype properties
            var protoprops = ["toString", "valueOf", "constructor", "hasOwnProperty", "isPrototypeOf", "propertyIsEnumerable", "toLocaleString"];
    }());
## generator
    状态机
    o-> 优点, 不保存外部状态(本身就包含一个状态)，无副作用，符合函数式编程思想
    var clock = function* (_) {
            while(true) {
                    yield _;
                    console.log('Tick');
                    yield _;
                    console.log('Tock');
            }
    }
    o-> 非generator
    var ticking = true;
    var clock = function() {
            if (ticking) console.log('Tick');
            else console.log('Tock');
            ticking = !ticking
    }

    promise执行器
    var readFile = function(fileName) {
            return new Promise(function (resolve, reject) {
                    fs.readFile(fileName, function(err, data) {
                            if(err) reject(err);
                            resolve(data);
                    })
            })
    }
    var gen = function* () {
            var f1 = yield readFile('/etc/fstab');
    }
    function run(gen) {
            var g = gen();
            function next(data) {
                    var result = g.next(data);
                    if (result.done) return result.value;
                    result.value.then(function(data) {
                            next(data);
                    })
            }
            next()
    }
    run(gen);
### thunk
    o-> 基本使用
    var Thunk = function (fileName) {
            return function (callback) {
                    return fs.readFile(fileName, callback)
            }
    }

    o-> 串行gen, 重用readFile的回调
    var readFile = thunkify(fs.readFile);
    var gen = function* () {
            var r1 = yield readFile('/etc/fstab');
            var r2 = yiled readFile('/etc/shells')
    }
    var g = gen()
    var r1 = g.next()
    r1.value(function (err, data) {
            var r2 = g.next(data);
            r2.value(function (err, data) {g.next(data)})
    })
            
    o-> 自动generator
    function run(fn) {
            var gen = fn();
            function next (err, data) {
                    var result = gen.next(data);
                    if (result.done) return;
                    result.value(next);
            }
            next();
    }
    run(gen);
## class
    o-> mixin
    function mix (...mixins) {
            class Mix {}
            for (let mixin of mixins) {
                    copyProperties(Mix, mixin);
                    copyProperties(Mix.prototype, mixin.prototype);
            }
            return Mix;
    }
    function copyProperties(target, source) {
            for(let key of Reflect.ownKeys(source)) {
                    if(key !== 'constructor'
                            && key !== 'prototype'
                            && key !== 'name'
                    ) {
                            let desc = Object.getOwnPropertyDescriptor(source, key);
                            Object.defineProperty(target, key, desc);
                    }
            }
    }
    class A extends mix(B, C) {}
            # 混合继承
### decorator
    o-> mixins
    function mixins (...list) {
            return function (target) {
                    Object.assign(target.prototype, ...list)
            }
    }
    const Foo = {
            foo() {}
    }
    @mixins(Foo)
    class MyClass()

    o-> mixins 方法不被覆盖
    let Mixin1 = (superclass) => class extends superclass {
            foo () {if(super.foo) super.foo()}
    }
    let Mixin2 = (superclass) => class extends superclass {
            foo () {if(super.foo) super.foo()}
    }
    class S {
            foo() {}
    }
    class C extends Mixin1(Mixin2(s)) {
            foo() {super.foo()}
    }
    new c().foo()        // C, Mixin1, Mixin2, S

    o-> trait 同mixins 额外功能: 防止同名方法冲突, 排除混入某些方法，为混入方法起别名等

# dom
## window对象
### document
    属性
            id
            innerHTML                # 非标准但通用
            body
                    方法
                            appendChild(domElement)
    方法
            getElementById("")
### element
    属性
            innerHTML
            style
                    display = "none"
                    visibility = "hidden"
            className
    方法
            createElement("div")
            createTextNode(msg)
            appendChild(ele)
### XMLHttpRequest
    var req = new XMLHttpRequest()
    方法
            open("GET", url)
            send(null)
                    # null表示不带正文地发送这个请求
            onreadystatechange = function(){
                    # 重写回调函数
                    if(req.readyState == 4 && req.status == 200){
                            var text = req.responseText;
                                    # 响应的字符串
                    }
            }
### localStorage
### Worker
    介绍
            it is a javascript running in the background, without affecting the performance of the page.
            dom中的js线程在执行时会阻塞
    使用
            var w;
            // start worker
            function startWorker(){
                    if(typeof(Worker) !== 'undefined'){
                            if(typeof(w) == 'undefined'){
                                    w = new Worker('demo_workers.js');
                            }
                            w.onmessage = function(event){
                                                                                                ＃ worker 's api, will call postMessage()
                                    document.getElementById('result').innerHTML = event.data;
                            };
                    }else {
                            document.getElementById('result').innerHTML = 'sorry, your browser does not support Web Workers...';
                    }
            }
            // stop worker
            w.terminate();                                                        ＃ worker 's api, will trigger w.onmessage();
            w = undefined;

            /* demo_workers.js */                                            # 外部的js文件不能访问window, document, parent对象
            var i = 0;
            function timeCount(){
                    i = i + 1;
                    postMessage(i);                                            # worker 's api, when onmessage() was triggered.
                    setTimeout('timeCount()', 500);
            }
            timedCount();
### EventSource
    介绍
            浏览器推送
    事件
            onopen
            onmessage
            onerror
    使用
            var source = new EventSource("demo_sse.php");
            source.onmessage = function(event){
                    document.getElementById('result').innerHTML += event.data + '<br/>';
            };
            // demo_sse.php
            <?php
            header('Content-Type: text/event-stream');
            header('Cache-Control: no-cache');
            
            $time = date('r');
            echo "data: The server time is: {$time}\n\n";
                    # data在上面event.data中引用
            flush();
            ?>
## 控件
### ActiveXObject
    new ActiveXObject("Excel.Application");
                            # Microsoft.XMLHTTP
                            ## ie中适用
    Server.CreateObject("Microsoft.XMLHTTP")
                            # 在chrome中不起作用
                            ## 可以用 new XMLHttpRequest()创建
## canvas
    概念
            o-> 原点: canvas左上角
            o-> 默认Style为black
            o-> 颜色设定
                    "red" "blue"
                    "#EEEEFF"
                    "rgb(1-255, 1-255, 1-255)"
                    "rgba(1-255, 1-255, 1-255, 0-1)"
            o-> 路径
                    可以被填充多个轮廓或图形的操作。
    基本使用
            var context =canvas.getContext("2d");

            context.fill()//填充
            context.stroke()//绘制边框
            context.lineWidth//图形边框宽度

            context.fillStyle//填充的样式
            context.strokeStyle//边框样式
    绘制
            矩形
                    content.fillRect(x, y, width, height)
                    strokeRect(x, y, width, height)
                                    # x, y是起点坐标, width, height为宽和高
            清除矩形区域
                    context.clearRect(x,y,width,height)
            圆弧
                    context.arc(x, y, radius, startAngle,endAngle, anticlockwise)
                                    # x, y是圆心坐标, radius是半径, startAngle, endAngle是开始、结束弧度, anticlockwise=false时顺时针画圆
                                    # 一刻钟是零度, 弧度可以用Math.PI来表示
    例子
            矩形
                    context.fillRect(0, 120, 100, 100);
                    context.strokeRect(120, 120, 100, 100);
                    context.clearRect(50, 50, 240, 120);
            圆弧
                    context.beginPath();
                    ctx.arc(100,75,50,0,1.3 * Math.PI, false);
                    context.closePath();
                    context.fill();                                                # 或ctx.stroke()画线, fill()填充开始点与结束点的连线
    image
        var image = ctx.getImageData(0, 0, 256, 256);
                # 取画布矩形区域的图像
        ctx.putImageData(image, 10, 70)
                # 把图像复制到画布的一个起点
        例子
            var c=document.getElementById("myCanvas");
            var ctx=c.getContext("2d");
            var imgData=ctx.createImageData(100,100);
            for (var i=0;i<imgData.data.length;i+=4)
                    # 一个像素有4个值RGB + alpha, alpha=255表示不透明
            {
    
                    imgData.data[i+0]=255;
                    imgData.data[i+1]=0;
    
                    imgData.data[i+2]=0;
                    imgData.data[i+3]=255;
            }
            ctx.putImageData(imgData,10,10);


### 优化
    canvas.width = canvas.width
            # 一种巧妙的方法清除并重置画布
### webgl
    介绍
            由Khronos Group维护
                    # 还维护了OpenGL和COLLADA
            使用OpenGL渲染语言GLSL ES
            WebGL是在浏览器中实现三维效果的一套规范
            webgl通过增加openGL es 2.0的一个js绑定, 把它们结合在一起
            webgl可以为html5 canvas提供硬件3d加速渲染
                    更流畅地展示3d场景和模型
                    创建复杂的导航和数据视觉化
    名词
        科纳斯组织        Khronos Group
        GLSL ES        OpenGL Shading Language Embedded System
        网格        Mesh
        模型        model
        纹理映射        texture map
        材质        material
        光源        light
        变换        transform
        相机        camera
        视口        viewport
        投影矩阵        projection matrix
        视锥体        view volume
        视平截头体        view frustum
        着色器        shader
        图元        primitive
        三角形带        triangle strip
        类型化数组        typed array
        模型视图矩阵        modelview matrix
        投影矩阵        projection matrix
        顶点着色器        vertex shader
        片元着色器        fragment shader
        像素着色器        pixel shader
                # 同fragment shader
        自发光        unlit
        预置光照        prelit
        镜面高光        specular highlights
        镜面反射        specular reflection
        alpha混合        alpha blending
        变换层级        transform hierarchy
        帧动画        frame-based animation
        补间动画        tweening
        关键帧        keyframe
        关键帧动画        keyframe animation
        插值        interpolation
        线性插值        linear interpolation
        关节动画        articulated animation
        蒙皮动画        skinned animation
        骨骼        skeleton
        目标变形动画        morph target animation
        程序贴图        procedural texture
        纹理变换        texture transform
        拾取        picking
        面法线        face normal
        程序贴图        procedural texture
        多级渐进纹理过滤        mipmapping / mipmapping filtering
        数码内容创作软件        DCC        digital content creation
        包围盒        bounding box
    框架
        three.js
            physi.js
        glMatrix
        GLGE
        philoGL
        sceneJS
        spiderGL
    着色器
    工具
        webgl inspector
                # chrome的扩展, webgl调试
    网站
        www.khronos.org/webgl/                                # Khronos提供的主页 
        learningwebgl.com/blog
        blog.tojicode.com
        https://developer.mozilla.org/en/WebGL                # mozilla的webgl教程
        www.chromeexperiments.com                        # chrome体验
        www.html5rocks.com                                # 提供html5资源
        www.lao3d.com                                        # 国内首个webgl网站

# 风格
    o-> 最好js和html用独立的引号风格，如
            html双引号, js单引号
    o-> 始终用var之类来声明变量，不用未声明变量

    o-> let和const取代var, 全局常量使用const

    o-> 特意将变量声明放在函数体顶部, 而不是使用变量之外, 来反映真实的作用域声明提前

    o-> 多用解构 
            const [first, second] = arr
                    # 数组取元素
            function f({a, b}) {}
                    # 对象解构给函数赋值
            function f() {return {a, b}}, const {a, b} = f()
                    # 函数返回值解构
            var arr2 = [...arr]
                    # 扩展运算符拷贝数组

    o-> 单行定义对象不逗号结尾(以后不扩展), 多行时逗号结尾(以后可能会扩展), 尽量用简洁的写法
            {a: 1, b}
            {
                    [getKey('a')],
            }

    o-> Array.from转换类数组到数组

    o-> 匿名函数 (() => {})(), 同时绑定了this为当前作用域

    o-> 不使用arguments, 使用rest运算符

    o-> 函数使用默认值 function f (opts = {})  {}

    o-> 用Map取代Object, 因为Map内建遍历机制, key可为对象。只能要数据转换时用Object

    o-> 总是用class取代需要的prototype操作, 因为class写法更简洁。extends也更简单, 不会有破坏instanceof运算的危险

    o-> 模块使用es6的机制, 模块只能一个输出时用export default, 多输出时用export, 不要export 和export default混合使用

    o-> 运算符
    var t = o && o.a || ''                        # 有o时取o.a, 无o时取'', 因为&&的优先级比||高
    var ifExist = !!o.a                                # 转换成布尔类型
                                                            ## 当然o.a = 0 什么的值时， 会判断失误，所以用来判断对象

    o-> 判断类型
    typeof a === "string"
            # 数组等其他Object类型通通是Object
    a instanceof Array
            # 判断Object类型的具体类型
    a.constructor == Array
            # 判断构造函数
    Object.prototype.toString.call(o) === '[object Array]'
            # 用toString判断

    o-> 柯里化
    function currying (fn, n) {
            return function (m) {
                    return fn.call(this, m, n);
            }
    }
    function tailFactorial(n, total) {
            # 尾递归调用优化
            if(n === 1) return total;
            return tailFactorial (n - 1, n * total);
    }
    const factorial = currying(tailFactorial, 1);
    factorial(5)

    o-> 尾递归
    function factorial (n, total = 1) {
            if(n === 1) return total;
            return factorial(n - 1, n * total);
    }
# 解释器
    typescript
            # 扩展语言
    coffeescript
            # 扩展语言
    system.js
        介绍
                一个垫片库, 浏览器端l加载es6模块、AMD模块、CommonJS模块 到es5。内部调用traceur

        <script src='system.js'></script>
        <script>
                System.import('./app').then(function(m) {
                        # app.js是一个es6模块
                        m.f()
                })
        </script>
    traceur
        介绍
                在线转换，将ES6代码编译为ES5
        使用
                npm install -g traceur
                traceur /path/es6                                # 运行ES6文件
                traceur --script /path/es6 --out /path/es5        # 转换
    babel
        使用
                npm install -g babel-cli
                npm install --save babel-core babel-preset-es2015
                // .babelrc
                {
                    "presets": ["es2015"],
                    "env": {
                                "dev": {
                                        # 在NODE_ENV=dev时使用特性
                                        "presets": ["react-hmre"]
                                }
                        }
                }
                babel-node
                babel es6.js
                        # babel es6.js -o es5.js
                        # babel -d build source -s
                        ## -s 是产生source-map
        插件
            babel-preset-react-hmre
                    # react热加载
                    .babelrc中配置 "react-hmre"
    transpiler
        介绍
                google的es6模块加载转为CommonJS或AMD模块加载的工具
        使用
                npm install -g es6-module-transpiler
                compile-modules convert es6.js es5.js
                        # compile-modules convert -o out.js file1.js