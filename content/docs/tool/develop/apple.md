---
title: Apple
type: docs
---

# ipad
    操作
        下边向上(短)：桌面
        下边向上(停): dock
            dock拖app: 小窗、分屏
                小窗向边(短): 隐藏
                小窗向边(停): 分屏
                小窗向上：分离
        下角向内(短): 切app
        下角向内(停): app表
        右上角向下: 控制中心
        左上角向下：通知
        桌面向下: 搜索
        3指左右: app内切换
        4指左右：切app
        4指向内(短): 桌面
        4指向内(停): app表 

        home一下：桌面
        home两下：app表
        截图、导出pdf: 主按键 + 电源键

        键盘：两指缩小浮动
        分屏: 一指拉出dock, 一指拖出程序
    siri
        问答: 笑话, 常识, 抛硬币
        safari: 搜索
        设置: 蓝牙,飞行模式
        时钟
            6点起床
            德国时间
            倒计时
        日历: 9点开会
        提醒：提醒和给妈妈打电话
        备忘录：记下我花了10块钱
        地图：回家路线
        打车
        打电话, 发信息
        照片
        体育：比赛消息
        音乐
        邮件
        天气
        计算器
        股票: xx涨了吗
        朋友：xx在哪里
        发微博
        指定xx: 打开trello发送a
        附近店
        相机：自拍模式
## alfred
    搜索
        指定网站搜索
        文件
    剪贴板
    计算器
    自定义脚本
        打字
        命令
        工作流
## fantastical
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
## mathStudio
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
## Working Copy
# mac
    操作
        四指
            向内：启动台
            向外：桌面
        三指
            左右：切桌面
            向上：app列表
            向下：expose(单程序多窗口)
        二指
            上下：滚动
            左右：前进后退
            右边：通知中心
            缩放,旋转
            点一下：菜单
            点二下：小缩放
        一指
            点一下：选中
            点二下：打开
            点一段：拖
            点二段：查询
    快捷键
        系统：
            锁屏：control + command + q
            关屏：shift + control + 关机
            注销：shift + command + q 
            睡眠：option + command + 关机
            强退：control + command + 关机
        程序坞： option + command + d
        调度中心：
            app列表: control + 上
            expose: control + 下
            左右桌面：control + 左右
            桌面：f11
        窗口：
            切换：command + tab
            程序内切换：command + `
            关闭：command + w
            退出：command + q
            强制退出：option + command + esc
            隐藏：command + h
            最大化: control + command + f
            最小化：command + m
            放大、缩小：command + +和-
            新标签：command + t
            新建: command + n
            打开：command + o
            保存：command + s
            另存为：shift + command + s
            刷新：command + r
            打印：command + p
            搜索：command + f
        文件： 
            全选、复制、剪切、粘贴、撤销: command + a c x v z 
            粘贴移到: option + command + v
            删除: command + return
        访达：
            预览：空格
            简介：command + i
        回收站：
            清空：shift + command + return
        截屏：
            整屏存文件：shift + command + 3
            区域存文件：shift + command + 4
            窗口区域：shift + command + 4 + 空格
            录屏：shift + command + 5
        输入法：control + 空格
## 命令
    brew
        update              # 更新brew
        search
        install
        remove
        upgrade
        tap                 # 安装扩展
        options             # 查看安装选项
        info
        home                # 访问包官网
        services
            list            # 查看已安装
            cleanup         # 清除无用配置
            restart         # 重启
