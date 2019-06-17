---
Categories : ["前端"]
title: "前端"
date: 2018-10-10T14:51:24+08:00
---


# 套餐
## web
    bootstrap
    extjs
    jquery ui
    dojo
            # 语法较难用
    easy ui
    dwz
            # 国产较难用，卖文档
    wijmo
            # 收费
    vaadin
            # apache webkit
    foundation
            # 响应式，移动优先
    boilerplate
            # h5模板
    meteor
            # 融合前后端, 后端node
    knockout
            # mvvm, 利于单页应用
## mobile
    jingle
    vux
            # vue手机组件
    ionic
            # angular手机框架
    framework7
            # ios(兼容android)组件
    mui
    zui
            # 类bootstrap 移动端
    frozenui
# 组件
## 写法
    介绍
            框架的作用就是统一编程风格

    react
    jquery
    angular
    prototype
    mootools
            # 浏览器原生对象扩展
    underscore
            # 函数式
    underscore-contrib
            # 扩展underscore
    ramda
            # 函数式，较正确
    lodash
            # 函数式
    functional javascript
    bilby
            # 函数式库，包含dispatch, 蹦床, monadic, validator等
    allong.es
            # 提供函数组合子
    sweet
            # 支持宏
    zepto
            # 小型jquery
    kissy
            # 小型jquery
    rxjs
            # 微软开发，将异步流捕获成值的库
    tangram
            # 百度前端工具集
    qwrap
            # 360前端工具集
    polymer
            # 构建在底层的html扩展，构建跨desktop, mobile等平台的web应用
    riot
            # 小mvc
    ember
            # 小mvc
    vue
            # 小mvc
    backbone
            # 小mvc
## 操作
    touch.js
    move.js
## 加载
    bigpipe
    mod.js
            # 百度模块化开发工具
    curl.js
            # amd load
    sea.js
    when
            # amd 加载
## 页面
### 效果
    swiper
            # 滑动效果

    cordova
            # 访问原生设备，如摄像头、麦克风等
    create.js
    egret.js
            # 使用TypeScript的HTML5开发引擎, 一套完整的HTML5游戏开发解决方案
    tweenMax
            # 扩展TweenLite, 用于制作html5动画
    juliusjs
            # 语音识别
    babylon
            # microsoft webgl框架
    cubicVR
            # 高性能webgl框架, paladin游戏引擎的一部分
    scenejs
            # webgl模型
    glge
            # webgl框架
    three.js
### 图表
    highcharts
    nvd3.js
            # svg报表
    d3
    echarts
## 模板
    介绍
            引擎的一个优点就是可以直接把数据渲染到js中使用
    优点
            可以把动态页面的模板缓存起来，第一次请求之后，只需要更新数据
                    # 应该可以后端nginx缓存静态模板来提高性能

    velocity
            # java模板
    ejs
    hogan.js
    handlebars
            # 写法类似anglarjs模板
    jstl
            # java模板
    less
            # css模板
    stylus
            # css模板
    swig
        {% autoescape true %} {{ myvar }} {% endautoescape %}

        {% block body %} ... {% endblock %}

        {% if false %}
        {% elseif true%}
        {% else %}
        {% endif %}

        {% extends "./layout.html" %}

        {% filter uppercase %} oh hi, {{ name }} {% endfilter %}                # => OH HI, PAUL
        {% filter replace(".", "!", 'g") %} Hi. My name is Paul. {% endfilter %}        # => Hi! My name is Paul!

        {% for x in obj %}
                {% if loop.first %}<ul>{% endif %}
                <li>{{ loop.index }} - {{ loop.key }}: {{ x }}</li>
                {% if loop.last %}</ul>{% endif %}
        {% endfor %}
        {% for key, val in arr|reverse %}
        {{ key }} -- {{ val }}
        {% endfor %}

        {% import './formmacros.html' as forms %}
        {{ form.input("text", "name") }}                        # => <input type="text" name="name">
        {% import "../shared/tags.html" as tags%}
        {{ tags.stylesheet('global')}}                        // => <link rel="stylesheet" href="/global.css">

        {% include "./partial.html" %}
        {% include "./partial.html" with my_obj only%}
        {% include "/this/file/does/not/exist" ignore missing%}

        {% macro input(type, name, id, label, value, error)%}
                <label for="{{ name }}">{{ label }}</label>
                <input type="{{ type }}" name="{{ name }}" id="{{ id }}" value="{{ value }}" {% if error%} class="error" {% endif %}>
        {% endmacro %}
        {{ input("text", "fname",  "fname", "First Name", fname.value, fname.errors) }}

        {% extends "./foo.html" %}
        {% block content %}
                My content
                {% parent %}
        {% endblock %}

        {% raw %}{{ foobar }}{% endraw %}

        {% set foo = "anything!"%}
        {{ foo }}

        {% spaceless %}
                {% for num in foo %}
                <li>{{ loop.index }}</li>
                {% endfor %}
        {% endspaceless %}                                # 除去空白
## 格式
    uglifyjs2
            # 序列化
# 打包
    fis
    bower
    browserify
    yeoman
            # google和外部贡献团队合作开发，通过grunt和bower包装一个易用的工作流。由yo(脚手架), grunt(构建), bower(包管理)三部分组成
    gulp
    grunt
    webpack
    require.js
# 终端
    cocos2dx
            # 跨平台游戏
## android
    结构
        applications:                                                        如browser
        application framework(相当于api):                        如window manager
        libraries(库):                                                        如openGL,SQLite
                runtime(运行环境):                                                core libraries + Dalvik VM
        linux kernel(系统api):                                        如wifi Driver
    android sdk
        命令
            platform-tools/adb
                adb install *.apk                                      # 当前模拟器中安
        装软件

                adb remount
                adb shell
                su                                                      # 当前模拟器中执
        行linux命令
            
            tools/emulator-arm @test                                    # 启动一个模拟器
    框架
        atlas
                # 阿里开源的android native容器化组件框架
        webview
 
 # 跨平台
    atom electron
    node-webkit
    atom-shell
    nw.js