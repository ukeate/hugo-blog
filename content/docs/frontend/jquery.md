---
Categories : ["前端"]
title: "Jquery"
date: 2018-10-11T07:34:03+08:00
---


# 对象命名方式
    var $a = $("#inputID");        

# 选择器（选择多个时形成数组）
    基本选择器
        $("#inputID");                # id选择
        $("input"); // 标签名,默认获取第一个                # 标签名选择
            $(".className"); // 按样式名定位                # 样式名选择
            $("#div1ID,.myClass,p");                # 选择多个
            $("*");                        # 所有元素
    层级选择器
        $("form input")                        # form所有后代元素中input元素的个数
        $("form>input")                        # form子元素中input元素个数，不包括下层元素
        $("form+input")                        # form同级并且下面的第一个input元素
        $("form~input")                        # form同级并且下面的所有input元素
    子元素选择器                # 只选择一个
        $("ul li:first")                # ul中第一个子元素li
        $("ul li:last")                        # ul中最后一个子元素li
        $("input:not(:checked)")                        # input标签中所有未选中的元素
        $("table tr:even")                # 表格的奇数行（索引号为偶数）
        $("table tr:odd")                # 表格的偶数行（索引号为奇数）
        $("table tr:eq(1)")                # table中索引号等于1的行
        $("table tr:gt(0)")                # table中索引号大于0的行（不包括0）
        $("table tr:lt(2)")                # table中索引号小于2的行（不包括2）
        $(":header")                        # 匹配如 h1, h2, h3之类的标题元素
    内容选择器
        $("div:contains('Join')")                # div 标签的html()中包含'Join'字符串的元素
        $("p:empty")                        # p 标签的html()的内容为空的元素
        $("div:has(p)")                        # div标签中包含p标签的该div标签
        $("p:parent");                        # 非空的p标签元素，即p为父元素
    可见性选择器
        $("tr:hidden")                        # 查找隐藏的tr元素，如<tr style="display:none">
                                                                                                        <td>Value 1</td>
                                                                                                </tr>
        $("tr:visible")                        # 查找可见的tr元素
    属性选择器
        $("div[id]")                        # 含有id属性的div元素
        $("input[name='newsletter']")                        # 所有name属性是newsletter的input元素
        $("input[name!='newsletter']")                        # 所有name属性不是newsletter的input元素
        $("input[name^='news']")                                # name以'news'开始的input元素
        $("input[name$='leter']")                                # name 以'letter'结尾的input元素
        $("input[name*='news']")                                # name包含'news'的input元素
        $("input[id][name$='leter']")                        # 含有id属性，并且它的name属性是以"letter"结尾的input 元素
    子元素选择器
        $("ul li:first-child");                        # 匹配多个ul中的第一个子li元素的li元素集合
        $("ul li:last-child");                                # 匹配多个ul中的最后一个子li元素的li元素集合
        $("ul li:nth-child(1)");                        # 匹配多个ul中的第一个子li元素的li元素集合,注意：标记从1开始(eq 从0开始)
        $("ul li:only-child");                                # 匹配多个ul中的只有一个li元素的li元素集合
    表单选择器
        $(":input");        # 所有input元素，包括select textarea button等
        $(":text");        # 所有文本框
        $(":password");    # 密码框
        $(":radio");        # 单选框
        $(":checkbox");    # 复选框
        $(":submit");      # 提交按钮
        $(":image");        # 有提交功能的图片
        $(":reset");        # 重置按钮
        $(":button");      # 按钮，包括<button></button>
        $(":file");        # 文件域
        $(":input:hidden");    # 隐藏域
    表单对象属性
        $(":input:enabled");        # 所有可用的input元素
        $(":input:disabled")        # 所有不可用的input元素
        $(":checkbox:checked");    # 所有已选中的checkbox(有checked属性的)元素    $(":checkbox:not(:checked)");  未选中的checkbox
        $(":select option:selected");      # 所有已选中的option元素
    
# 基础函数
    对象访问
        size()          # 同length,返回元素个数
        length          # 同size(),返回元素个数
        get(index)      # 取得一个匹配的元素,从0开始
        each(function(){});                        # 遍历调用该方法的元素数组中的元素，其中的this代表循环中的每一个元素
        
    属性
        val()                              # value属性的值，或option元素之间的值
        val("")                        # 设置value的值
        var(["Multiple2", "Multiple3"]);        # 设置select 下option的值
        html()                                # 相当于innerHTML ,同样不支持xml
        attr("")                        # 查找属性
        attr("checked","checked")                # 设置checked属性的值为"checked"
        removeAttr("align");                # 删除属性
        样式类（css）
            addClass("myClass");          # 添加 css 样式
            removeClass("myClass");        # 删除样式
            toggleClass("myClass");        # 切换样式，有变无，无变有
            hasClass("myClass")            # 返回是否有样式
# 筛选
    过滤
            eq(index)                                                # 从0开始的第index元素
            is(expr)                                                # 判断元素中是否有符合expr的元素（如"form"），有则返回true,无则返回false
            first()                                                        # 第一个元素
            last()                                                        # 最后一个元素
            filter(expr)                                        # 筛选出符合表达式的集合
            has(expr)                                                # 保留符合expr的元素，去掉不符合的
            not(expr)                                                # 删除符合expr的元素，与has相反
    查找
        find("");                      # 搜索所有与指定表达式匹配的后代元素
        children()                      # 取得所有直接子元素，不包含后代
        next()                          # 下一个同级兄弟
        prev();                        # 上一个同级兄弟
        parent("")                      # 含着所有匹配元素的唯一父元素 ,可以用选择器筛选
        parents("p")                    # $("span").parents("p") 每个span的所有是p元素的祖先元素
        nextAll()                      # 之后所有同级兄弟
        prevAll()                      # 之前所有同级兄弟
        siblings()                      # 上下的所有同级兄弟
    对象处理
        replaceWith()                  # $("p").replaceWith("<b>Paragraph. </b>"); 替换p节点为自制的粗体节点
        remove()                        # 自己删除自己
        clone()                        # 复制自己  clone(true) 会复制行为
        内部插入
            append(content)            # 元素内部之后添加元素，相当于appendChild()
            prepend(content)            # 元素内部之前添加元素
        外部插入
            after(content)              # 元素同级之后插入
            before(content)            # 元素同级之前插入
            
# 事件函数
    change(fn)              # $("select").change(function(){})  dom 中的onchange事件，元素内容变化时触发
    submit(fn)              # $("form").submit(function(){})  选中表单提交时触发，多用于简单检测输入
                    # 该事件函数中写return false;代表不提交表单
    focus(fn)              # $(":text").focus();      将光标定位到input text表单中
    select(fn)              # 选中  如 $(function(){  $(":text").select(); $(":text").focus(); })  页面加载时定位光标到input text文本域，并选中其中的文字        
    mouseover(fn)           
    mouseout(fn)
    mousemove(function(e){})          # 鼠标移动时执行 ie 中已经定义参数，不用传递，直接用event，event.clientX,event.clientY分别得到鼠标的x,y坐标
    keyup(fn)                  # ie 中 event.keyCode得到按键编码(firefox 中传递参数e,e.which得到按键编码)
    ready(fn)              # $(document).ready(fn) 相当于window.load()事件，但可以写多个

# css函数 
        css("background-color","red");                # 设置style属性
        addClass("myClass")                                # 添加css样式
    removeClass("myClass")              # 删除样式
    toggleClass("myClass")              # 切换样式，有则删除，无则添加
    hasClass("myClass")                # 是否有样式，返回true或false
    

# 效果函数
    slideUp(speed,fn)      # 向上滑动,如$("div").slideUp(200);
    slideToggle(speed,fn)  # 滑上滑下切换,如$("div").slideToggle(200);
    
    show(speed,fn)          # 元素从无到有动画显示出来
    hide(speed,fn)          # 元素从有到无隐藏起来
    toggle(speed,fn)        # 有则无，无则有隐藏、显示元素
    fadeIn(speed,fn)        # 淡入显示图片
    fadeOut(speed,fn)      # 淡出隐藏图片
    animate(styles,speed,easing,callback)                # 自定义动画。只有数字值可创建动画（比如 "margin:30px"）

# 工具函数
    $.trim(str)            # 去除str字符串开头和结尾的空白

# 其它函数
    serialize()            # 序列表单内容为字符串  ajax提交表单时可以        var sendData = $("form").serialize();  给sendData赋值传递表单信息
                                                

# 特殊使用
    $(document)    # 得到document区  ，可以定义事件，如$(document).mousemove(fn);
                    $(document).ready(fn); 相当于$(fn)
    $(fn)          # 相当于window.load ,在页面加载时执行，可以写多个，（而window.load只能一个生效，后面的会覆盖前面的）
    $("<div id='2013'>ss</idv>");      # 创建一个元素

# 与dom之间的转换
        var $input = $(inputElemenet); // 注意，没有双引号
        var inputElement = $input.get(0); // jquery相当于存储了dom对象的数组 
          var inputElement = $input[0];

# ajax    
    load(url)                      # $("span").css("color","red").load(url)        无参以get方式提交，返回的值直接作为<span>标签内的文本节点值
    load(url,sendData);            # 有参以post的方式提交
                                    ## var sendData = {"username":"user","password":"psw"};  sendData的内容用json的语法写
    load(url,sendData,function(backData,textStatus,ajax){});          # 加上处理返回值的函数,服务器返回数据时调用此函数
                                                                      ##  其中backData是返回的字符串,textStatus是响应头状态码的值对应的信息（success代表200）,ajax是ajax引擎对象
                                                                      ##  <span>标签的文本节点的值仍会被改变
                                                                      ##  可以只写一个参数：backData，参数的名字可以任意更改
    $.get(url,sendData,function(backData,textStatus,ajax){});          # 用get方式提交ajax模拟的表单
    $.post(url,sendData,function(backData,textStatus,ajax){});          # 用post方式提交ajax模拟的表单 响应头 content-type = "application/x-www-form-urlencoded" 会自动设置好
                                                                        
# 插件
    jquery提供
        fixedtableheader
        tablesort
        tools
        ui
        hashchange
            控制浏览器的前进后退到一个页面中(不必刷新)
        easing
            jquery的动画扩展, 比如动画执行的速度曲线
    代码
        icanhaz
        mustache
    功能
        fileupload
        treeview
            文件
                    jquery.treeview.js                        # treeview插件简化板
                    jquery.treeview.edit.js                # 可编辑的菜单
                    jquery.treeview.css                        # treeview可选使用的样式
                    
            使用
                    $("#root").treeview({                        # $("#root")是顶层ul元素
                            /* 展开还是收起, 默认为false 展开*/
                            collapsed: true,
                            /* 唯一的, 当前菜单打开的时候其他菜单收缩*/
                            unique: true,
                            /*动态加载菜单（接收json数据）*/
                            url: "source.do"
                    });
                            # 动态加载菜单时接收的数据格式为
                                    [
                                    {
                                    "text": "1. Pre Lunch (120 min)",
                                    "expanded": true,
                                    "classes": "important",
                                    "children":
                                    [
                                    {
                                            "text": "1.1 The State of the Powerdome (30 min)"
                                    },
                                            {
                                            "text": "1.2 The Future of jQuery (30 min)"
                                    },
                                            {
                                            "text": "1.2 jQuery UI - A step to richnessy (60 min)"
                                    }
                                    ]
                                    },
                                    {
                                    "text": "2. Lunch  (60 min)"
                                    },
                                    {
                                    "text": "3. After Lunch  (120+ min)",
                                    "children":
                                    [
                                    {
                                            "text": "3.1 jQuery Calendar Success Story (20 min)"
                                    },
                                            {
                                            "text": "3.2 jQuery and Ruby Web Frameworks (20 min)"
                                    },
                                            {
                                            "text": "3.3 Hey, I Can Do That! (20 min)"
                                    },
                                            {
                                            "text": "3.4 Taconite and Form (20 min)"
                                    },
                                            {
                                            "text": "3.5 Server-side JavaScript with jQuery and AOLserver (20 min)"
                                    },
                                            {
                                            "text": "3.6 The Onion: How to add features without adding features (20 min)",
                                            "id": "36",
                                            "hasChildren": true
                                    },
                                            {
                                            "text": "3.7 Visualizations with JavaScript and Canvas (20 min)"
                                    },
                                            {
                                            "text": "3.8 ActiveDOM (20 min)"
                                    },
                                            {
                                            "text": "3.8 Growing jQuery (20 min)"
                                    }
                                    ]
                                    }
                                    ]
                                            # "expanded": true 代表这个结点下的child是展开的。
                                            # 返回的json字符串中的双引号必须是双引号。
                                            ## 初次请求时传递数据 root=source,点击节点申请数据时传递id值，如3.6中有id为36，且hasChildren:true,点击后传递36，我们再据此返回相应json数据。
                            
                    
                    引入css文件，根据其中的样式对页面进行设置
        validate
            使用
                    验证写在<head>中时，要写在页面加载中（$(function{})）                # 否则读取<head>时，页面还没有加载，没有表单
                    验证完成触发事件
                            失败事件：errorPlacement:function(error,element){}                        # error是错误消息，element是求救消息的js对象 
                            成功事件：success:function(label){}                        # label是显示消息的js对象
                    远程验证：发送ajax请求到指定url                # 自动传递验证名与验证值，ie中get请求调用浏览器缓存，所以用户回退字符时不提交。所以用post方式发送请求
                                                                            ## 返回"true"表示成功，"false"表示失败
                            remote:{
                                    url:"/outrun/servlet/JqueryValidateServlet",
                                    type:"post"
                            }
                    简单例子：
                            $("form").validate({
                                    debug:true,
                                    rules:{
                                            name:{
                                                    required:true,
                                                    rangelength:[6,12]
                                            },
                                    },
                                    messages:{
                                            name:{
                                                    required:"用户名必填",
                                                    rangelength:$.format("用户名长度必须在{0}-{1}之间")
                                            },
                                    }
                            });

            兼容：
                    不同validate验证框架要求不同的jquery版本
                    validate1.5.2配jquery1.3
                    
            经验
                    默认情况是丢失焦点验证,如果验证失败则 在失败的文本框每次输入数据都会触发onkeyup
                            设置        onkeyup:false
                            
            样式
                    默认是class="error"的样式，可以在页面中自定义.error{}样式取代，但是这样除了出错信息的样式修改外，用户输入信息的样式也会修改
                    错误信息是以添加<label>标签的形式显示的，所以可以添加<label>标签的样式，如form label{}
        acccordion  下拉菜单
        autocomplete    自动补全(用索引库)
        password Vlidation 密码强度
        prettdate 日期插件
        message 消息框
    报表
        highcharts
        jscharts
        am charts
            对象与属性
                对象                # 静态创建
                    AmCharts.AmSerialChart()                 序列图
                            属性
                                    dataProvider        数据
                                            # 接收json数据
                                    categoryAxis        横坐标
                                            属性
                                                    labelRotation          横坐标显示名角度
                                                    gridPosition                网格的起始位置,"start"表示开始处
                                                    dashLength                值为数字，网格中垂直线虚线程度 ，0代表实线
                                    categoryField        横坐标显示名(dataProvider数据中的字段名)
                                    depth3D        3D图形深度
                                    angle                3D图形角度(左上俯角)
                                    creditsPosition        未购买之前的商标位置，如"top-right"表示右上。
                            方法
                                    write("chartdiv")                # 要绘图div的id属性值
                    AmCharts.AmPieChart()                饼图
                    AmCharts.AmSerialChart()         雷达图
                    AmCharts.AmXYChart()                离散图
                    AmCharts.AmLegend()                图例
                    AmCharts.ValueAxis()                纵坐标
                            # 通过 AmCharts对象中图对象的addValueAxis()方法给图添加本属性
                            属性
                                    title                        纵坐标标题
                                    dashLength                值为数字，网格中水平线虚线程度 ，0代表实线
                    AmCharts.AmGraph()                图形
                            # 通过 AmCharts对象中图对象的addGraph()方法给图添加本属性
                            属性
                                    colorField                值为dataProvider提供数据中的字段名，表示数据在报表中的颜色
                                    valueField                值为dataProvider提供数据中的字段名，表示占有数值的多少
                                    balloonText                鼠标悬停时气球中的内容，用[[value]], [[description]], [[percents]], [[open]], [[category]] 等标记来引用数据
                                                            也可以用html标签，如： "<span style='font-size:14px'>[[category]]: <b>[[value]]</b></span>"
                                    lineAlpha                0或1，代表数据图形是否有边界
                                    fillAlpha                代表数据图形是否透明，0为透明
                                    
                            AmSerialChart中AGraph的属性
                                    type                        数据图形的形状，如"column"代表方块柱状图
                    AmCharts.ChartCursor()                光标
                            # 通过 AmCharts对象中图对象的addChartCursor()方法给图添加本属性
                            属性
                                    cursorAlpha                0或1，是否显示鼠标跟随线
                                    zoomable                true或false 是否可以用鼠标选中来放大
                                    categoryBalloonEnabled                        true或false 是否跟随鼠标显示横坐标种类名
                方法2                # 动态创建
                    AmCharts.makeChart("" , json);
                            参数1 : 要产生图形的div的id
                            参数2 : json格式的产生条件
                                    type : 图形类型，如"pie"
                                    dataProvider : 图形数据
                                    titleField : 需要显示的种类名对应在dataProvider中的字段名
                                    valueField : 需要显示的权重对应在dataProvider中的字段名
                                    legend : json数据，图例的产生条件
                                            align : 对齐条件，如"center"
                                            markerType : 图例的形状，如"circle"
            使用1
                    var chart;
                    var chartData = [ {
                            "country" : "USA",
                            "visits" : 4025,
                            "color" : "#FF0F00"
                    }, {
                            "country" : "China",
                            "visits" : 1882,
                            "color" : "#FF6600"
                    } ];

                    AmCharts.ready(function() {
                                            // SERIAL CHART
                                            chart = new AmCharts.AmSerialChart();
                                            chart.dataProvider = chartData;
                                            chart.categoryField = "country";
                                            // the following two lines makes chart 3D
                                            chart.depth3D = 20;
                                            chart.angle = 30;

                                            // AXES
                                            // category
                                            var categoryAxis = chart.categoryAxis;
                                            categoryAxis.labelRotation = 0;
                                            categoryAxis.gridPosition = "start";

                                            // value
                                            var valueAxis = new AmCharts.ValueAxis();
                                            valueAxis.title = "Visitors";
                                            chart.addValueAxis(valueAxis);

                                            // GRAPH
                                            var graph = new AmCharts.AmGraph();
                                            graph.valueField = "visits";
                                            graph.colorField = "color";
                                            graph.balloonText = "<span style='font-size:14px'>[[category]]: <b>[[value]]</b></span>";
                                            graph.type = "column";
                                            graph.lineAlpha = 0;
                                            graph.fillAlphas = 1;
                                            chart.addGraph(graph);

                                            // CURSOR
                                            var chartCursor = new AmCharts.ChartCursor();
                                            chartCursor.cursorAlpha = 0;
                                            chartCursor.zoomable = false;
                                            chartCursor.categoryBalloonEnabled = false;
                                            chart.addChartCursor(chartCursor);

                                            chart.creditsPosition = "top-right";

                                            // WRITE
                                            chart.write("chartdiv");
                                    });
            使用2
                    AmCharts.makeChart("chartdiv", {
                            type: "pie",
                            dataProvider: [{
                                "country": "Czech Republic",
                                    "litres": 156.9
                            }, {
                                "country": "Ireland",
                                    "litres": 131.1
                            }, {
                                "country": "Germany",
                                    "litres": 115.8
                            }, {
                                "country": "Australia",
                                    "litres": 109.9
                            }, {
                                "country": "Austria",
                                    "litres": 108.3
                            }, {
                                "country": "UK",
                                    "litres": 65
                            }, {
                                "country": "Belgium",
                                    "litres": 50
                            }],
                            titleField: "country",
                            valueField: "litres",
                            balloonText: "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>",
                            legend: {
                                align: "center",
                                markerType: "circle"
                            }

                        });

## 习惯
    命名方式规律
            jquery.插件名.功能名.js
            
    存储
            网站js/下        分子文件夹存放不同插件的文件


## 自定义
    函数
            jQuery.extend(object);          # 直接调用
            jQuery.fn.extend(object);      # 对象调用 $.extend($.fn,{})或$fn.extend({})
    例子
            $.extend({
                    max : function(a, b) {
                            return a > b ? a : b;
                    },
                    min : function(a, b) {
                            return a < b ? a : b;
                    }
            });
            $.fn.extend({
                    max1 : function(a, b) {
                            return a > b ? a : b;
                    }
            });
            $.extend($.fn, {
                    min1 : function(a, b) {
                            return a < b ? a : b;
                    }
            })
            alert($.max(1, 2));
            alert($("html").max1(2, 1));
            alert($("html").min1(1, 2));
# 问题
    页面中引用jquery
            只能用<script></script>的形式，而不能用<script/>的形式
            引用的src必须写相对路径
            引用的<script></script>代码必须写在使用之前
            webroot/web-inf/不能用相对路径访问webRoot/下的文件，所以不能包含jquery文件。所以要用${pageContext.request.contextPath}/来访问
# jquery mobile