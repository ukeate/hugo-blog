---
Categories: ["语言"]
title: "Css"
date: 2018-10-09T16:27:24+08:00
---

# 介绍
    cascading style sheet
# 层叠
    # 浏览器对每个元素定义了默认的样式表
    不同级
        1. style属性
        2. style标签
        3. link标签
        4. 浏览器中用户自定义样式表
        5. 浏览器默认样式
    !important
        color: black !important
    同级
        # 评估得出最特殊的样式
        ## a-b-c值依次排序，a如id个数, b如其他属性个数, c如元素名个数
        # 评分相同时，使用最后的
        id值的数目
        其它属性和伪类的数目
        元素名和伪元素的数目
# 继承
    部分元素继承父元素样式
        元素外观继承
        布局不继承
    inherit
        # 指明使用父元素样式
        border: inherit    
# css样式一共三种用法:
    内联式
        <div style="color:#000;"></div>
    嵌入式
        <style type="text/css">
            div {color:#000;}
        </style>
    引用式
         <link href="css.css" rel="stylesheet" type="text/css" />
    @
        @charset "UTF-8"
            # 默认UTF-8, 在import前
        @import "styles.css"
            # 静态引用, 效率比<link>标签慢
# 颜色表示
    名称, 如silver, gray
    0xffffff
    rgb(112, 128, 144)
    rgb(112, 128, 114, 0.4)
    hsl(120, 100%, 22%)
        # 色相(hue), 饱和度(saturation), 明度(lightness)
    hsl(120, 100%, 22%, 0.4)
# 长度表示
    绝对单位
        # 只有在打印和设计文档时才用绝对单位
        cm
        pt
            # 磅
        in
            # 英寸
        mm
        pc
            # pica 等于12磅
    相对长度
        em
            # 元素字号
        ex
            # 元素字体的'x高度'，字体基线到中线的距离，一般与x的高度相当，大致等于0.5em
        rem
            # 根元素(html元素)字号
        px
            # css像素，假定了设备的分辨率为96dpi, 是1英寸的1/96(windows系统标准像素密度, 其它平台浏览器自己转换)
            ## css在定义中px是相对单位，但浏览器实现中全是绝对单位
        %
            # 不是所有元素都可以用
            # 不同属性中%定义不同，如font-size挂钩继承的font-size值, width挂钩元素包含块的宽度
    算式
        # css3 未得到广泛支持
        width: calc(80% - 20px);
# 角度
    deg
        # 度, 0 - 360
    grad
        # 百分度 0 - 400
    rad
        # 弧度 0 - 6.28
    turn
        # 圆周 1 turn = 360 deg
# 时间
    s
    ms

# 属性
## 布局
    position       
        # static, absolute, fixed, relative
        # 默认static, top等属性不起作用
        # fixed滚动固定
    left
    right
    top
    bottom

    z-index
    columns
        # 列数和列宽的简写属性
    column-count
        # 多列布局的列数
        column-fill
            # 列间内容分布方式
        column-gap
            # 列间隔
        column-rule
            # 列间规则的简写属性
        column-rule-color
        column-rule-style
        column-rule-width
        column-span
            # 元素跨列数
        column-width
    flex-align
        # 弹性盒子布局, 未实现
        flex-direction
        flex-order
        flex-pack
        -webkit-box-align
            # 内容高度小于容器高度时
            # start(顶边放置), end(底边放置), center(中间放置), baseline, stretch(拉伸元素)
            -webkit-box-flex 
                # 元素可伸缩性
            -webkit-box-pack
                # 元素伸缩到最大尺寸(max-width)时怎么做
                # start(左边放置), end(右边放置), center(中间放置), justify(平均分配到各个元素间)
            -webkit-box-direction
                # 内部盒子排列顺序
    例子
        o-> 多列布局
        column-count: 3;
        column-fill: balance;
        column-rule: medium solid black;
        column-gap: 1.5em;
        column-width: 10em;

        o-> 弹性盒
        #container {
            display: -webkit-box;
            -webkit-box-direction: reverse;
            -webkit-box-align: end;
            -webkit-box-pack: justify;
        }
        #first {-webkit-box-flex: 3;}
        #second {-webkit-box-flex: 1;}

        o-> css表格
        #table {display: table;}
        div.row {display: table-row;}
        p {display: table-cell;}
## 盒模型
    box-sizing
        # 尺寸样式(如width, height)应用到哪部分
        # content-box, padding-box, border-box, margin-box
    display
        inline    显示为文本行中的字
            # inline时，忽略width, height, margin属性
        block    显示为段落
            # 在垂直方向有所区别
        inline-block    显示为文本行
            # 整体作为inline, 但内部作为block, 这样认width, height, margin属性
        list-item    显示为列表项
        run-in    类型取决于周围元素
            # 包含display:block元素，就是block
            # 兄弟都是block时，为inline
            # 其它都为block
        compact    为块或标记盒(类list-item), 一般不支持
        flexbox    弹性盒布局用
            # -webkit-box
        table    表格布局用
            inline-table
            table-caption
                # 类似caption
            table-row-group
                # 类似tbody
            table-header-group
                # 类似thead
            table-footer-group
                # 类似tfoot
            table-row
                # 类似tr
            table-column-group
                # 类似colgroup
            table-column
                # 类似col
            table-cell
                # 类似td
        ruby    ruby注释的文本布局用
            ruby-base
            ruby-text
            ruby-base-group
            ruby-text-group
        none    元素不可见，不占空间
    float
        # 元素左边界或右边界移动到包含块或另一个浮动盒的边界。其余inline部分流式环绕
        # left, right, none
    clear
        # 左右边界不能挨着另外浮动元素
        # left, right, both, none
    padding
        padding-bottom
        padding-left
        padding-right
        padding-top
    margin
        margin-bottom
        margin-left
        margin-right
        margin-top
    height
        # 长度或百分比
    width
        max-height
        max-width
        min-height
        min-width
    overflow
        # auto(同scroll, 但自动加滚动条), hidden(剪掉), on-content(移除内容, 已废弃), on-display(隐藏内容, 已废弃), scroll, visible(溢出)
        overflow-x
        overflow-y

    visibility
        # 元素可见性
        # collapse(不可见，不占据空间), hidden(不可见，占据空间), visible
        ## collapse只能用在表相关内容，如tr, td
## 边框
    border
        # border: 30px dashed #000
    border-width
        # 可以是长度值, 百分比, thin, medium, thick 
        # border-width: 15px 5px 15px 5px
    border-style
        # 默认值是none。dashed 破折线, dotted 圆点, double 双线, groove 槽线, inset 内嵌效果, outset 外凸效果, ridge 脊线, solid 实线
        # border-style: solid dotted dashed double 定义了上、右、下、左的样式
        # border-style: none的时候，边框其它属性无意义
    border-color
        # blue rgb(25%, 35%, 45%) #909090 red;
    border-image
        # 不广泛支持
        # -webkit-border-image, -moz-border-image, -o-border-image
        # border-image: url(a.png) 30 / 50px round repeat; 九宫格切分长度都为30, 宽度为50, 横round, 竖repeat
        border-image-outset
        border-image-repeat
            # stretch 拉伸, repeat 平铺, round 不截断下拉伸, space不截断下图片间保留间距平铺
        border-image-slice
        border-image-source
        border-image-width
    border-left
        border-left-style
        border-left-color
        border-left-width
    border-right
        border-right-color
        border-right-style
        border-right-width
    border-top
        border-top-style
        border-top-color
    border-top-width
    border-top-left-radius
        # border-top-left-radius: 20px 15px; x半径20, y半径15
    border-top-right-radius
    border-bottom
        border-bottom-style
        border-bottom-width
        border-bottom-color
        border-bottom-left-radius
        border-bottom-right-radius
    border-radius
        # border-radius: 20px / 15px;
        # border-radius: 50% 20px 25% 5em / 25% 15px 40px 55%

    box-shadow
        # box-shadow: hoffset voffset blur spread color inset
        # 水平偏移量, 正向右，负向左。垂直偏移量，正向下，负向上。模糊值。阴影延伸半径，正向各方向延伸，负缩小。颜色。内嵌阴影
        # 可设置多组阴影，用, 隔开
    outline
        # 轮廓不属于页面，不影响布局
        # <颜色> <样式> <宽度>
        outline-color
        outline-offset
            # 距元素边框边缘的偏移量
        outline-style
            # 同border-style
        outline-width
            # 同border-width
## 背景
    # 不继承
    background
        # background: <background-color> <background-position> <background-size> <background-repeat> <background-origin> <background--clip> <background-attachment> <background-image>
    background-attachment
        # 背景附着方式
        # fixed 固定到视窗上, 不随文字滚动, local 随文字滚动, scroll 固定到元素上(使用浏览器的滚动条), 不随文字滚动
    background-color
        # 原点在border外边缘
        # 函数
            linear-gradient(transparent, rgba(0, 0, 0, 0.1) 20%, rgba(0, 0, 0, 0.5) 65%, rgba(0, 0, 0, 0.66))
                # 线性渐变 
    background-image
        # 原点在padding外边缘，也就是border内边缘
        background-image: url("bg.jpg")
    background-position
        # 起始位置, 可以是长度, top, left, right ,bottom, center
        # 第一个值控制垂直位置, 第二个值控制水平位置
        0px 0px
            # 左上偏移0, 0    
        right ？
            # 位置在右边显示
        left ？
            # 位置在左连显示(默认)
        ？ bottom
        center center
            # 位置在中间显示、内容从中间开始显示(默认)
        ? top
            # 内容从上开始显示
    background-repeat
        no-repeat
        repeat 水平和垂直同时平铺
        repeat-x 水平平铺
        repeat-y 
        space 水平或垂直平铺, 统一间距,不截断, round 水平或垂直拉伸, 不截断
        
    background-size
        # 可以长度值或百分比, contain(等比缩放, 宽高适应匹配, 不超出容器), cover(等比缩放, 宽高最大适应匹配, 可超出容器), auto本身尺寸显示
        # 500px 500px
    background-origin
        # 定位显示原点
        # 可取 border-box(边框盒子内), padding-box(内边距盒子内), content-box(内容盒子内)
    background-clip
        # 裁剪, 属性同上
## 色彩
    opacity
    color
        # 前景颜色    list-style
        # rgba(255, 255, 255, 0.7)
    user-select
        # 用户不可选择
    filter
        # 滤镜效果, ie8 或之前使用
        # filter:alpha(opacity=50)，同opacity: .5
## 文本
    text-decoration
        # node时 a标签没有下划线
    text-indent
        # 首行缩进
    text-align
        # start(语言的起始边界，可能是右), end, left, right, center, justify
    text-justify
        # text-align: justify时来指定规则
        # auto, none(禁用文本对齐), inter-word(空白在单词之间), inter-ideograph(中日韩), inter-cluster(泰), distribute, kashida(草体)
    text-transform
        # 转换大小写
        # none, capitalize, uppercase, lowercase
    text-decoration
        # 文本装饰
        # none, underlinenone, overline, line-through, blink
    text-shadow
        # 文本阴影
        # <h-shadow> <v-shadow> <blur> <color>, 水平偏移, 垂直偏移, 模糊程度, 颜色
    direction
        # 文本对齐
        # ltr, rtl
    word-spacing
        # 词间距
    letter-spacing
        # 字母间距
    white-space
        # normal(空白被压缩，文本行自动换行), nowrap(空白压缩，文本行不换行), pre(空白不压缩, 换行符换行), pre-line(空白压缩，自动换行或换行符换行), pre-wrap(空白不压缩, 自动换行或换行符换行)
    line-height
        # 行高
        # 百分比，长度
    word-wrap
        # 行超距单词截断
        # normal(溢出), break-word
    @font-face
        # 指定web字体, woff得到最广泛支持
        # 在@font-face中定义，font-family中使用
        @font-face {
            font-family: 'MyFont';
            font-style: normal;
            font-weight: normal;
            src: url('http://a/MyFont.woff')
        }
    font
        # <font-style> <font-variant> <font-weight> <font-size> <font-family>
        # 简写属性
        font-family
            # serif, sans-serif, monospace, cursive, fantasy
            font-family: MyFont, cursive
        font-style
            # normal, italic, oblique
    font-variant
        # normal, small-caps
        font-weight
            # bold, bolder, lighter
        font-size
            # xx-small(浏览器决定的大小), x-small, small, medium, large, x-large, xx-large, smaller(相对父元素字体的大小), larger, <length>, <%>
## 列表样式
    list-style
        # <list-style-type> <list-style-position> <list-style-image>
        list-style-type
            # 列表项前标记
            # none, box, check, circle, diamond, disc, dash, square, decimal, binary, lower-alpha, upper-alpha
        list-style-image
            # 图片作为列表标记
        list-style-position
            # 相对于内容框的位置
            # inside(内容框内部), outside(外部)
    vertical-align                    # 垂直对齐（文字不行）

    cursor
        auto ：标准光标
        default ：标准箭头
        hand ：手形光标
        wait ：等待光标
        text ：I形光标
        vertical-text ：水平I形光标
        no-drop ：不可拖动光标
        not-allowed ：无效光标
        help ：?帮助光标
        all-scroll ：三角方向标
        move ：移动标
        crosshair ：十字标 
        pointer
        e-resize n-resize nw-resize w-resize s-resize se-resize sw-resize ne-resize
## 表格样式
    border-collapse
        # 相邻单元格边框样式
        # separate(默认，重复画框), collapse(合并边框)
    border-spacing
        # 相邻单元格边框距离
    table-layout
        # 单元格行列的算法规则
        # auto, fixed(由表格自身样式和每列width属性决定布局[无则设等间距]，由第一行决定列宽，以下行内容自动换行)
    caption-side
        # 表格标题的位置
        # top, bottom
    empty-cells
        # 是否显示表格中空单元格
        # hide
## 计数器
    counter-reset
    counter-increment
## 动画
    介绍
        本质是增强过渡

    @keyframes
        # 指定一个以上关键帧
        # 只在过程中有效，动画结束后即使仍hover, 也返回初始状态
    animation
        # 动画，动画完后回到初始状态。想停留在结束状态用过渡。
        # 可以用在初始布局中
        # 通过keyframe显式控制， 可重用
        # <animation-name> <animation-duration> <animation-timing-function> <animation-delay> <animation-iteration-count>
        ## 只是模拟属性值改变来实现动画，动画结束后属性无变化
        ## 可以应用到页面的初始布局中去，而transform只能应用在动作上
        animation-delay
            # 延迟，可以指定多个值，对应transition-property中的多个属性
        animation-direction
            # 重复播放时播放方向
            # normal 每次向前播放, alternate 先向前，再反向，相当于animation-iteration-count: 2
        animation-duration
            # 持续时间, 可多值
        animation-iteration-count
            # 循环次数
            infinite
                # 无休止交替播放
        animation-name
            # 关键帧集合名称，可多个
        animation-play-state
            # 动画状态
            # js中ele.style.webkitAnimationPlayState = 'paused'
            paused
                # 停止
            playing
                # 开始播放
        animation-timing-function
            # 关键帧时间插值函数
            normal
                # 每次重复向前播放
            alternate
                # 先向前播放，再反向播放，相当于animation-iteration-count: 2
    transform
        # 变换，动画结束后属性有变化
        # -moz-transform: rotate(-45deg) scaleX(1.2)
        ## 逆时针旋转45度, 延x轴缩放到1.2倍
        函数
            translate
                # 水平、垂直或两个方向 平衡
                # 长度，百分比
            translateX
            translateY
            scale
                # 数
            scaleX
            scaleY
            rotate
                # 角度
            skew
                # 倾斜
                # 角度
            skewX
            skewY
            matrix
                # 6个参数。自定义变换, 由于z缩放未被实现，后两个参数省略
                # 数
        
        transform-origin
            # 变换的起点，默认是元素中心点
            # transform-origin right top;
            # 长度，百分比，left center right, top center, bottom

    transition
        # <transition-property> <transition-duration> <transition-timing-function> <transition-delay>
        # 可以作为初始状态，也可以过渡
        # -webkit-
        # transition: .2s background-cololr
        # transition: .2s all
        transition-delay
            # 开始之间延迟时间, ms
        transition-duration
            # 持续时间, ms
        transition-property
            # 应用过渡的多个属性
        transition-timing-function
            # 时间函数
            # 5种预设曲线 ease(默认), linear, ease-in, ease-out, ease-in-out
            # cubic-bezier指定自定义曲线
    示例
        o-> 过渡
        #banana {
            font-size: large;
            border: medium solid black;
            -webkit-transition-delay: 10ms;
            -webkit-transition-duration: 250ms;
                # 反向过渡
        }
        #banana:hover {
            font-size: x-large;
            border: medium solid white
            background-color: green;
            color: white;
            padding: 4px;
            -webkit-transition-delay: 100ms;
            -webkit-transition-property: background-color, color, 
                padding, font-size, border;
            -webkit-transition-duration: 500ms;
            -webkit-transition-timing-function: linear;
        }

        o-> 动画
        #banana:hover {
            -webkit-animation-delay: 100ms;
            -webkit-animation-duration: 500ms;
            -webkit-animation-iteration-count: infinite;
            -webkit-animation-timing-function: linear;
            -webkit-animation-name: 'GrowShrink';
            -webkit-animation-direction: alternate;
        }
        @-webkit-keyframes GrowShrink {
            from {
                # 可以用0%替代
                font-size: xx-small;
                background-color: red;
            }
            50% {
                # 定义了变化的速率，可以用0%, 100%代替from和to子句
                background-color: yellow;
                padding: 1px;
            }
            to {
                # 可以用100%替代
                font-size: x-large;
                border: medium solid white;
                background-color: green;
                color: white;
                padding: 4px;
            }
        }

        o-> 变换
        #banana {
            -moz-transform: rotate(-45deg) scale(1.2);
            -moz-transform-origin: right top;
        }
# 选择器
    *
        # 选取所有元素
    <type>                   # 标签选择
    .<class>                # 样式选择
    #<id>                # id选择
    [attr]
        # 属性, 如[title] {}
    [attr="val"]
    [attr^="val"]
        # 以val开头
    [attr$="val"]
    [attr*="val"]
        # 包含val
    [attr~="val"]
        # 属性多值有val, 空格隔开
        # [class~="class2"] {}
    [attr|="val"]
        # 属性多值有val, - 隔开
        # [lang |="en"] 
    <selector>, <selector>
        # 同时匹配
    <selector> <selector>
        # 后代
    <selector> > <selector>
        # 直接后代
    <selector> + <selector>
        # p 之后的第一个兄弟a
    <selector> ~ <selector>
        # p 之后所有兄弟a

    o-> 伪元素
        # 直接使用匹配所有
    ::first-line
        # 块级元素文本首行
    ::first-letter
        # 块级元素文本首字母
    :before
        # 之前插入内容
        {content: 'a'}
    :after
        # 之后插入内容

    o-> 伪类
        # 直接使用匹配所有
    :root
        # 文档根元素, 总是返回html元素
    :first-child
        # 第一子元素
        # p > span: first-child , p 下面第一个span元素
    :last-child
    :only-child
        # 只有一个子元素的该元素
    :only-of-type
        # 同上但指定类型，直接使用时会匹配更多，因为很多某类型的唯一元素
    :nth-child(n)
        # body > :nth-child(2)
    :nth-last-child(n)
    :nth-of-type(n)
    :nth-last-of-type(n)

    o-> UI  伪类
    :enabled
        # 已启用的元素
    :disabled
        # 禁用的元素
    :checked
        # 选中的单选或复选按钮
    :default
        # 默认的元素, 如 <button type="submit">
        # 常和outline属性一起使用
    :valid
        # 输入验证有效的元素
    :invalid
    :in-range
        # 范围内的input元素
        # 未广泛支持
    :out-of-range
    :required
        # 允许使用required属性的input元素
    :optional
        # 非required

    o-> 动态伪类
    :link
        # 未访问的a元素
    :visited
        # 已访问过的a元素
    :hover
    :active
        # 当前激活的元素(鼠标按下)
    :focus
        # 获得焦点的元素
    :not(<selector>)
        # a:not([href*="apress"])
    :empty
        # 无子元素的元素
    :lang(<language>)
        # lang属性为指定值
        # :lang(en) 匹配 <a lang="en-us">
    :target
        # url hash(片段标识符) 定向id所在的元素

    例子
        o->
        span.class2 {}

        o->
        body > * > span, tr > th {}

        o-> 计数器
        body {counter-reset: paracount;}
        p:before {
            content: counter(paracount) " ";
            counter-increment: paracount;
                # counter-increment: paracount 2; 可以增加2
        }

        o->
        :checked + span

# 典型问题
## 垂直居中
    line-height
        .content {
            height: 100px;
            line-height: 100px;
        }
    vertical-align
        .wrapper {display: table;}
        .cell {
            display: table-cell;
            vertical-align: middle;
        }
    position
        .wrapper {position: relative}
        .content {
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%)
        }
    position
        .content {
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            margin: auto;
        }
    float填充一半
        .floater {
            float: left;
            height: 50%;
            margin-bottom: -120px;
        }
        .content {
            clear: both;
            height: 240px;
            position: relative;
        }
## 图标切分
    background-image: url(/base/icons.png);
    background-repeat: no-repeat;
    background-position: -910px -74px;
# 兼容性
    工具
        caniuse.com
            # 在线浏览器兼容性测试
        modernizr.com
            # 测试特性支持是否到位
# 工具
    stylus
        # css扩展语言, 创建富有表现力的css, 比less更强大, 类似jquery的css引擎, 支持node.js
    compass
        # 编译到css，是sass的toolkit, 是用ruby开发的
    blueprint
        # css框架
    sass
        # css扩展语言
## less
    介绍
        less于css如jquery于js
    安装使用
        npm install -g less
    命令
        lessc styles.less > styles.css                # 编译
                                    # -x 压缩  --clean-css 更复杂的压缩
    语法
    模板
        {% %}
    变量
        @color: #4D926F;
        #header{
            color: @color
        }
        h2{
            color: @color
        }

