---
title: iPad
type: docs
---

# alfred
    搜索
        指定网站搜索
        文件
    剪贴板
    计算器
    自定义脚本
        打字
        命令
        工作流
# fantastical
    个人总结
        名字 date 9th from 9.30p to 10.32p alert 30min
    对象
        Account - Calendar Sets - Cals(Subscription+Interesting) + Item(Events + Tasks)
    nlp
        语法
            事件 [with 人物] [at 地点] [at 日期时间] [on 日期] [from 日期时间] [to 日期时间] [of every 日期时间] 提醒 URL 日历
        日期
            特定
                日期
                    11月1日     11/1    11.1
                星期
                    周一        mon/tue/wed/tur/fri/sat/sun
            相对
                日期
                    15天后      after 15 days
                星期
                    下周一      next mon
            重复
                日期
                    每月2号     every 2
                星期
                    每周二      every tue
                    每隔两周的周三      on wed every 2 weeks
                复合
                    7月1日到8月1日之间的每个周一周二        on mons tues from 7/1 to 8/1
            区间
                12月17日到次年1月3日是寒假      寒假 12/17-1/3      12/17~1/3
        时间
            24小时制
                13
            12小时制
                下午一点        1p  1pm
            分钟
                下午一点半      13:30   1.30p
            默认
                早上8点         morning
                中午12点        noon
                下午5点         evening
                晚上8点         night
                半夜12点        midnight
            区间
                下午1点32到晚上7点47        1.32-7.47   1.32~7.47
        提醒
            提前2小时提醒       alert 2 hours
            提前5分钟提醒       alert 5 min
        URL
            在合适位置的url
        日历
            /Work       /w
            四个空格
        待办事项(reminder)
            开启
                todo、task、Remind、Remind me to开头
            独有语义
                11月27日晚上8点截止     due 11/27 8p        until 11/27 8p      by Thursday
                低 中 高        ! !! !!!
    快捷键
        新建                command + n
        切换日程/待办事项   command + k
        保存                command + s
        删除                command + d

        搜索                command + f
        详情                command + i
        显示事项            command + r
        定位到今天          command + t
        设置                command + ,
        切换全屏视图        command + shift + f

    操作
        新建页面滑动隐藏
        长按日期新建
        长按Item
            移动到Calendar
            颜色

            复制/重建/剪切/删除
            建模板
            隐藏

            邮件触发事件
        横划删除
# mathStudio
    Basic Expressions
        1+2
        4*5
        6!
    Algebra
        a*a+b
        Expand((a+b)^10)
        Apart( (x^2) / ( x^2 + 1)^2)
        Factor( x^4 + 5x^2 - 6 )
    Solving Quadratic Equations
        Solve( x^2 + 5x + 6 = 0 )
        Solve(1,5,6)
    Limits
        Limit()
    Derivatives
        D(sin(x))
    Integrals
        Integrate( x^2 + 3x - 6 )
    Graphing
        Plot(sin(x))
    Parametric Plots
        ParametricPlot(cos(u), sin(u))
    Polar Plots
        PolarPlot(sin(2@theta))
    Time Graphing
        Plot(sin(x + T))
    Vector Fields
        VectorPlot(-y, x)
    Multiple Plots
    Minimum, Maximum and Zero Values
        Plot(sin(x), min=1)
    List Plots
        ListPlot([1,2,3,4,5,4,3,8,6,8])
    Regression Analysis
        LinearFit([1,4,9,5,7,5,4,2,9], [3,4,5,7,8,10,4,7,6])
        LinearFitModel()
        LinearFitPlot()
        QuadraticFitPlot()
        SinFitPlot()
    3D Graphing
        Plot3D(2cos(x) * sin(y))
    3D Parametric Plots
    Sliders
        Slider(n, 1..50)
        Slider(a, 2, 10, 0.1)
    Scripting
        one = 1
        two = 2
        one + two
        cube(x) = x^3
        cube(5)
        for [row, column] in data
        end
    Lists
        1:100
        [1,2,3] * [4,5,6]
    Matrices
        [[1,2], [3,4]] * [[5,6], [7,8]]
        Inverse([a,b], [c,d])
        Identity(5)
    Units
        2@feet + 24@inches
# Working Copy