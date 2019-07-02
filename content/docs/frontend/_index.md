---
title: 前端
Categories : ["前端"]
date: 2018-10-10T14:51:24+08:00
type: docs
---

# 套件
## 浏览器显示
    bootstrap
    extjs
        介绍
            2.0之前是免费的，但有内在泄漏总是
            GPLv3版本后收费

        Sencha
            1.是ExtJS、jQTouch(一个用于手机浏览器的jquery插件) 以及 Raphael（一个网页上绘制矢量图形的js库） 三个项目合并而成的一个开源项目。
            2.Sencha Touch 是全球领先的应用程序开发框架，其设计旨在充分
                利用HTML5、CSS3 和Javascript 来实现最高级别的功能、灵活性和优化。
                Sencha Touch 是针对下一代具有触摸屏设备的跨平台框架。
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
## 手机显示
    jingle
    ionic
            # angular手机框架
    framework7
            # ios(兼容android)组件
    mui
    zui
            # 类bootstrap 移动端
    frozenui
## 富应用
    react
    angular
    riot
    ember
    vue
    backbone
## 交互
    trhee.js
### createjs
    # easeljs
        介绍
                处理canvas
        使用
                var stage = new createjs.Stage("canvasName");
                stage.x = 100;
                stage.y = 100;
                var text = new createjs.Text("Hello", "36px Arial", "#777");
                stage.addChild(text);
                stage.update();
    # tweenjs
        介绍
                处理动画调整和js属性
        使用
                var circle = new createjs.Shape();
                circle.graphics.beginFill("#FF0000").drawCircle(0, 0, 50);
                stage.addChild(circle);
                createjs.Tween.get(circle, {loop: true})
                        .wait(1000)
                        .to({scaleX: 0.2, scaleY: 0.2})
                        .wait(1000)
                        .to({scaleX:1, scaleY:1}, 1000, createjs.Ease.bounceInOut)
                createjs.Ticker.setFPS(20);
                createjs.Ticker.addEventListener("tick", stage);
    # soundjs
        介绍
            简化处理音频
        使用
            var displayStatus;
            displayStatus = document.getElementById("status");
            var src = "1.mp3";
            createjs.Sound.alternateExtensions = ["mp3"];
            createjs.Sound.addEventListener("fileload", playSound());
            createjs.Sound.registerSound(src);
            displayStatus.innerHTML = "Waiting for load to complete";

            function playSound(event){
                    soundIntance = createjs.Sound.play(event.src);
                    displayStatus.innerHTML = "Playing source: " + event.src;
            }

    # preloadjs
        介绍
                协调程序加载项的类库
        使用
                var preload = new createjs.LoadQueue(false, "assets/");
                var plugin= {
                        getPreloadHandlers: function(){
                                return{
                                        types: ["image"],
                                        callback: function(src){
                                                var id = src.toLowerCase().split("/").pop().split(".")[0];
                                                var img = document.getElementById(id);
                                                return {tag: img};
                                        }
                                }
                        }
                }
                preload.installPlugin(plugin);
                preload.loadManifest([
                        "Autumn.png",
                        "BlueBird.png",
                        "Nepal.jpg",
                        "Texas.jpg"
                ]);
# 组件
## 操作
    touch.js
    move.js
## 加载
    mod.js
            # 百度模块化开发工具
    curl.js
            # amd load
    sea.js
    when
            # amd 加载
### bigpipe
    介绍
        facebook的页面异步加载框架
        不同于ajax的http调用，需要更多的网线连接。bigpipe与当前页面共用http连接

    使用
        前端
            <script src="jquery.js"></script>
            <script src="underscore.js"></script>
            <script src="bigpipe.js"></script>
            <div id="body"></div>
            <script type="text/template" id="tpl_body">
                    <div><%=articles%></div>
            </script>
            <script>
            var bigpipe = new Bigpipe()
            bigpipe.ready('articles', function(data) {
                    $('#body').html(_.render($('#tpl_body').html(), {articles: data}))
            })
            </script>

        服务器端
            app.get('/profile', function (req, res) {
                    if (!cache[layout]) {
                            cache[layout] = fs.readFileSync(path.join(VIEW_FOLDER, layout), 'utf8')
                    }
                    res.writeHead(200, {'Content-Type': 'text/html'})
                    res.write(render(complie(cache[layout])))
                    ep.all('users', 'articles', function () {
                            res.end()
                    })
                    ep.fail(function(err) {
                            res.end()
                    })
                    db.getData('sql1', function (err, data) {
                            data = err ? {} : data
                            res.write('<script>bigpipe.set("articles", ' + JSON.stringify(data) + ');</script>')
                    })
            })

        nodejs使用
            'use strict'
            var BigPipe = require('bigpipe');
            var bigpipe = BigPipe.createServer(8080, {
                    pagelets: __dirname + '/pagelets',
                            # 页面路径
                    dist: __dirname + '/dist'
                            # 静态资源路径
            });
            o-> 开启https
            var bigpipe = BigPipe.createServer(443, {
                    key: fs.readFileSync(__dirname + '/ssl.key', 'utf-8'),
                    cert: fs.readFileSync(__dirname + '/ssl.cert', 'utf-8')
            });
            o-> 嫁接
            var server = require('http').createServer(),
                    BigPipe = require('bigpipe');
            var bigpipe = new BIgPipe(server, {options});
            bigpipe.listen(8080, function listening(){
                    console.log('listening on port 8080.');
            });

            bigpipe.define('../pagelets', function done(err){
            });        # 合并pagelets, 结束后调用done
            o-> AMD 方式define，与链式编程
            bigpipe.define([Pagelet1, Pagelet2, Pagelet3], function done(err){
            }).define('../more/pagelets', function done(err){});
            # bigpipe.before来添加中间件, remove来删除中间件, disable、enable来跳过和重新启用中间件
            # bigpipe.use来引用插件
    api
        BigPipe所有组件继承EventEmitter interface
    功能
        pagelets
            var Pagelet = require('bigpipe').Pagelet;
                    # var Pagelet = require('pagelet');
            Pagelet.extend({
                    js: 'client.js',
                    css: 'sidebar.styl',
                    view: 'templ.jade',
                    name: 'sidebar‘,            // 唯一路由路径
                    get: function get(){
                            // 接收get请求时的业务逻辑
                    }
            }).on(module);
                    # 自动写 module.export部分来导出
            # traverse方法自动调用来递归找additional child pagelets, 要手动指定名称时手动调用

## 效果
    swiper
            # 滑动效果

    cordova
            # 访问原生设备，如摄像头、麦克风等
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
## 图表
    highcharts
    nvd3.js
            # svg报表
    echarts
### d3
    介绍
            数据可视化, 使用svg, css3
    使用
        node
                npm install d3
                //
                var d3 = require('d3'), jsdom = require('jsdom');
                var document = jsdom.jsdom(),
                    svg = d3.select(document.body).append('svg');
        web
                <script src="//d3js.org/d3.v3.min.js"></script>
                <script>d3.version</script>

    d3对象
            // 选择器
            event
            mouse
            select
            selectAll
            selection
            touch
            touches
            // 过渡
            ease
                    # ease对象
            timer
                    flush
            interpolate
                    # interpolate对象
            interpolateArray
            interpolateHcl
            interpolateHsl
            interpolateLab
            interpolateNumber
            interpolateObject
            interpolateRgb
            interpolateRound
            interpolateString
            interpolateTransform
            interpolateZoom
            interpolators
            transition
            // 数组
            ascending
            bisectLeft
            bisector
            bisectRight
            bisect
            descending
            deviation
            entries
            extent
            keys
            map
            max
            mean
            median
            merge
            min
            nest
            pairs
            permute
            quantile
            range
            set
            shuffle
            sum
            transpose
            values
            variance
            zip
            // 数学
            random
            transform
            // 请求
            csv
            html
            json
            text
            tsv
            xhr
            xml
            // 格式化
            format
            formatPrefix
            requote
            round
            // 本地化
            locale
            // 颜色
            hcl
            hsl
            lab
            rgb
            // 命名空间
            ns
            // 内部
            dispatch
            functor
            rebind
            // 比例尺
            scale
            // 时间
            time
            // 布局
            layout
            // 地理
            geo
            // 几何
            geom
            // 行为
            behavior
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
### swig
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
# 写法
    jquery
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

# 工具
    bower
    browserify
    yeoman
            # google和外部贡献团队合作开发，通过grunt和bower包装一个易用的工作流。由yo(脚手架), grunt(构建), bower(包管理)三部分组成
    require.js

## webpack
    # 介绍
            模块打包

    # 命令
            npm i -g webpack
            npm i css-loader style-loader
            webpack ./entry.js bundle.js
                    # --progress
                    # --colors
                    # --watch
                    # --module-bind
                    ## jade, 'css=style!css'
                    webpack ./entry.js bundle.js --module-bind 'css=style!css'
                    webpack
                            # use webpack.config.js
            npm i webpack-dev-server -g
            webpack-dev-server
                    # --progress --colors
                    # --hot 热部署
                    # 启动一个express在8080端口
    # 配置
        # webpack.config.js

        var webpack = require('webpack')
        var merge = require('webpack-merge')
        var path = require('path')
        var HtmlwebpackPlugin = require('html-webpack-plugin')

        var ROOT_PATH = path.resolve(__dirname)
        var APP_PATH = path.resolve(ROOT_PATH, 'app')
        var BUILD_PATH = path.resolve(ROOT_PATH, 'build')

        var baseWebpackConfig = {
                entry: {
                        app: path.resolve(APP_PATH, 'app.jsx')
                },
                output: {
                        path: BUILD_PATH,
                        filename: '[name].js',
                            chunkFilename: '[id].chunk.js',
                        publicPath: '/',
                                # 浏览器路径
                },
                devtool: 'eval-source-map',
                devServer: {
                    contentBase: path.resolve(ROOT_PATH, 'build') ,
                    historyApiFallback: true,
                    inline: true,
                    port: 3031
            }
                resolve: {
                        extensions: ['', '.js', '.vue', 'jsx'],
                            # 这样可以在js import 中加载扩展名
                        fallback: [path.join(__dirname, '../node_modules')],
                        alias: {
                                'src': path.resolve(__dirname, '../src'),
                                'assets': path.resolve(_dirname, '../src/assets'),
                                'components': path.resolve(__dirname, '../src/components')
                        }
                },
                resolveLoader: {
                        fallback: [path.join(__dirname, '../node_modules')]
                },
                module: {
                    preLoaders: [
                            {
                                    test: /\.jsx?$/,
                                    loaders: ['eslint'],
                                    include: APP_PATH
                            }
                    ]
                        loaders: [
                        {
                                test: /\.vue$/,
                                loader: 'vue'
                        },
                        {
                                test: /\.js$/,
                                loader: 'babel',
                                include: projectRoot,
                                exclude: /node_modules/
                        },
                        {
                                test: /\.json$/,
                                loader: 'json'
                        },
                        {
                                test: /\.html$/,
                                loader: 'vue-html'
                        },
                        {
                                test: /\.(png|jpe?g|gif|svg)(\?.*)?$/,
                                loader: 'url',
                                query: {
                                        limit: 10000,
                                        name: path.posix.join('static', 'img/[name].[hash:7].[ext]')
                                }
                        },
                        {
                                test: /\.(woff2?|eot|ttf|otf)(\?.*)?$/,
                                loader: 'url',
                                query: {
                                        limit: 10000,
                                        name: path.posix.join('static', 'fonts/[name].[hash:7].[ext]')
                                }
                        }
                        ]
                },
            plugins: [
                        new HtmlwebpackPlugin({title: 'a'})
                ]
        }
        module.exports = merge(baseWebpackConfig, {
        })
    # 插件
        内置
                # 通过webpack.BannerPlugin获得
                bannerPlugin
        htmlWebpackPlugin
        hotModuleReplacement
## grunt
    介绍
            压缩js代码
            合并js文件
            单元测试
            js代码检查
            监控文件修改重启任务
    命令
            grunt dist
                    # 重新生成dist目录，将编译后的css,js放入
            grunt watch
                    # 监测less源码文件改动，自动重新编译为css
            grunt test
                    # 运行测试用例
            grunt docs
                    # 编译并测试
            grunt 重新构建所有内容并运行测试用例
    安装
            # grunt模块以grunt-contrib-开头
            npm i -g grunt grunt-init grunt-cli

    例子
        o->
        // Gruntfile.js
        module.exports = function (grunt) {
                grunt.loadNpmTasks('grunt-contrib-clean')
                grunt.loadNpmTasks('grunt-contrib-concat')
                grunt.loadNpmTasks('grunt-contrib-jshint')
                grunt.loadNpmTasks('grunt-contrib-uglify')
                grunt.loadNpmTasks('grunt-replace')

                grunt.initConfig({
                        pkg: grunt.file.readJSON('package.json'),
                        jshint: {
                                all: {
                                        src: ['Gruntfile.js', 'src/**/*.js', 'test/**/*.js'],
                                        options: {
                                                jshintrc: 'jshint.json'
                                        }
                                }
                        },
                        clean: ['lib'],
                        concat: {
                                htmlhint: {
                                        src: ['src/core.js', 'src/reporter.js', 'src/htmlparser.js', 'src/rules/*.js'],
                                        dest: 'lib/htmlhint.js'
                                }
                        },
                        uglify: {
                                htmlhint: {
                                        options: {
                                                banner: 'a',
                                                beautify: {
                                                        ascii_only: true
                                                }
                                        },
                                        files: {
                                                'lib/<%= pkg.name %>.js': ['<%= concat.htmlhint.dest %>']
                                        }
                                }
                        },
                        relace: {
                                htmlhint: {
                                        files: {'lib/htmlhint.js': 'lib/htmlhint.js'},
                                        options: {
                                                prefix: '@',
                                                variables: {
                                                        'VERSION': '<%= pkg.version %>'
                                                }
                                        }
                                }
                        }
                })
                grunt.registerTask('dev', ['jshint', 'concat'])
                grunt.registerTask('default', ['jshint', 'clean', 'concat', 'uglify', 'replace'])
        }
## gulp
    介绍
            自动化构建项目工具
    使用
        安装
                npm install --global gulp
                        # npm install --save-dev gulp
                // gulpfile.js 在项目根目录
                var gulp = require('gulp');
                gulp.task('default', function () {
                        // 默认任务代码
                })
        命令
                shell> gulp
                        # gulp <task> <othertask>
    插件
        gulp-dom-src
                合并src, 改写html
        gulp-if
        gulp-useref
        gulp-usemin
        gulp-htmlreplace
        google-closure-compiler
        gulp-add-src
        gulp-autoprefixer
        gulp-changed
        gulp-clean
        gulp-clean-css
        gulp-concat
        gulp-concat-css
        gulp-consolidate
        gulp-html-replace
                # 替换html内容
        gulp-htmlmin
        gulp-imagemin
        gulp-less
        gulp-make-css-url-version
        gulp-minify-css
        gulp-rev-append
        gulp-uglify
## fis
    介绍
            npm的形式发布
            百度前端工具框架，为前端开发提供底层架构
            所有js文件都用模块书写，一个文件一个模块
                    F.module(name, function(require, exports){}, deps);

    安装
            npm install -g fis
    命令
        fis install                        # 安装模块
        fis release                        # 编译和发布, -h 查看帮助
                                ## 默认会调整资源引用的相对路径到绝对路径
                                ### 不想对路径做调整，可以使用spt工具https://github.com/fouber/spt
                                ## --optimize 或 -o 压缩。--md5对不同静态资源生成版本，也可以配置时间戳
                                ## --dest 或 -d。指定项目发布配置，在执行编译后发布。可以远程发布、发布多个
                                ## --pack 开启打包处理
                                ## -omp 简化 --optimize --md5 --pack
                                ## --watch 或 -w 自动监听文件修改，自动编译
                                ### 该监视考虑了各种嵌入关系, a.css中嵌入了b.css, b修改时会重构这两个文件
                                ### --live 或 -L 。在-w基础上实现，监视到修改后自动刷新浏览器页面
        fis server start                # 启动本地调试服务器
                                ## -p [port] 指定新端口
                                ## --type node 如果没有java, php环境，指定用node环境启动
        fis server stop
        fis server open                # 查看默认产出目录
    配置
        o->
        fis.config.set('pack', {
                'pkg/lib.js': [
                        '/lib/mod.js',
                        '/modules/underscore/**.js',
                        'modules/backbone/**.js'
                ]
        });                # 文件合并成lib.js，但是不替换页面中的静态资源引用
                        ## 为了替换引用，使用fis的后端静态资源管理来加载引用，或者用fis-postpackager-simple插件
        o->
        fis.config.set('roadmap.path', [{
                reg: '**.css',
                useSprite: true
        }]);                # 为所有样式资源开启csssprites, 该插件在fis中内置
        fis.config.set('settings.spriter.csssprites.margin', 20);                # 设置图片合并间距
                                                        ## 要在要合并的图片引用路径后面加?__sprite来标识
                                                        ## 被合并图片中的小图, background-position来分图的情况也支持
    组件
        yogurt
            基于express 的nodejs框架
        fis-plus
            fis + php + smarty
        gois
            fis + go + margini
        jello
            fis + java + velocity
        pure
            纯前端框架

    插件
        fis-postpackager-simple
            介绍
                    fis-plus和yogurt不需要
            安装
                    npm install -g fis-postpackager-simple
            配置
                    // fis-conf.js
                    fis.config.set('modules.postpackager', 'simple');                        # 打包时自动更改静态资源引用
                    fis.config.set('settings.postpackager.simple.autoCombine', true)        # 开启按页面自动合并css, js文件
        fis-parser-less
            介绍
                    less模板
                    npm install -g fis-parser-less
            配置
                    fis.config.set('modules.parser.less', 'less');
                            # 'modules.parser.less'表示后缀名less的文件，'less'表示用fis-parser-less编译
                    fis.config.set('roadmap.ext.less', css)
                            # 将less文件编译为css

# 终端
## 跨终端
    cocos2dx
        # 跨平台游戏
    atom electron
    node-webkit
    atom-shell
    nw.js
    polymer
            # 构建在底层的html扩展，构建跨desktop, mobile等平台的web应用
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

